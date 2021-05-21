Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1513938BCDB
	for <lists+bpf@lfdr.de>; Fri, 21 May 2021 05:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhEUDIS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 May 2021 23:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbhEUDIS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 May 2021 23:08:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10938C061574
        for <bpf@vger.kernel.org>; Thu, 20 May 2021 20:06:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v184-20020a257ac10000b02904f84a5c5297so25354027ybc.16
        for <bpf@vger.kernel.org>; Thu, 20 May 2021 20:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LCvhfrAF8R5mHZN7FS4R/Cp/wmIOcPcxTTJB/A0cLT4=;
        b=DS7WbltlGi/2GwuM3anNh91eEOX13R8pcP8rgJfvN9o3kUTbIq4p5s33b39uNsH0CT
         q76kT25ftwKth+AdhXBI6aGJOcmrGiYe/PIdePZ8Qyr2wfhlzU4OA7LXCVEsrsVKlTG3
         CYb0Q9j10AhNHIx1BKSjOXXQXli+Dm2Oerrq3TabT5EROaW7h5BkiNuYszMTaUFv9nND
         nftAyzZ+BA5T8hWM1vPIKb1esuMtfVwKAve8TKP7FBpe9QQDtqyk+rGDRxr7b0Qp9tkg
         vrddLljI0BtwHKtLC6Fyfe3Mtwd5J/eqtLcz7IRjQ7CQtTeJZtbuP5D0Ff6okTG677nX
         ugwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LCvhfrAF8R5mHZN7FS4R/Cp/wmIOcPcxTTJB/A0cLT4=;
        b=TGfaFv3f16VzVxefHHUdNZmh4IJ7Ux5vT4J5USuQK9aNklUwmWXSxA3IqEIlXrI+TB
         aroTnou19CPqOAo8TtMFiolD5Z2vQu58d/ZpJWoOb2djfRZnClhD0lqbTDi9eRFs6nS+
         ZKjKSYzrAeYBGEpuLHHRLagsMVrBpUUvTRsLVo9kIExCiMtJay9eV+LaPUcnMyEM9Oli
         buOB9RUGPziBXY+Ap7EXth5q6kuK6ehMd6iotGFNhti5deD98TQPqYeQCVYcIqnKaBhS
         4O5dSuHyJI+fgg7UqOMu1yjVSenVw+t22PsyRlCy7/sS27W1WYSQKR+Tua+ARx2HpdtI
         JbbQ==
X-Gm-Message-State: AOAM533XjASSf54Vz6BuTcWQ18n10IH509SYjoFD5jhqCKs5lhrUGMWR
        NM0oYuBzPuna4Xr8Afmgnbjn3zM=
X-Google-Smtp-Source: ABdhPJy3OyWHNakdyTykO6cwFh7DgXNHUnTio/6IB0a8KqgJtvcLm3ekljRvWXEXWWG5r3eNGHZ6hoQ=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:4909:ac09:6d2:d3a3])
 (user=sdf job=sendgmr) by 2002:a25:410e:: with SMTP id o14mr7921617yba.122.1621566415220;
 Thu, 20 May 2021 20:06:55 -0700 (PDT)
Date:   Thu, 20 May 2021 20:06:53 -0700
Message-Id: <20210521030653.2626513-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH bpf-next] libbpf: skip bpf_object__probe_loading for light skeleton
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm getting the following error when running 'gen skeleton -L' as
regular user:

libbpf: Error in bpf_object__probe_loading():Operation not permitted(1).
Couldn't load trivial BPF program. Make sure your kernel supports BPF
(CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough
value.

Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dc4d5fe6d9d2..b396e45b17ea 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3971,6 +3971,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
 	};
 	int ret;
 
+	if (obj->gen_loader)
+		return 0;
+
 	/* make sure basic loading works */
 
 	memset(&attr, 0, sizeof(attr));
-- 
2.31.1.818.g46aad6cb9e-goog

