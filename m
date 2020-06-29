Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6130720E23B
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 00:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgF2VD1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 17:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbgF2TMs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8143EC008643
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so15908119wrn.3
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ls8hWmzQG+X5GaT67nD+iROEACoxQwnKFhpQ2RUlTb8=;
        b=gAwOtZCRIBa8C5dGzWFZv4z7W4S1TYj4CHrpP+KUcr4kVixqeJojxGiEKMQZHBj9Si
         0D5wnmfq+CXw/oxWIUfBgXXAphCCgHHX6ClxCMQIHFoY6EGDDg2j+SGjFmgw43Z86iaI
         JnjNRgKwXGwY5iq+tq9B6UjX6UbeL+TLr6hsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ls8hWmzQG+X5GaT67nD+iROEACoxQwnKFhpQ2RUlTb8=;
        b=G7n+KyUuIfroGi3gjYlOZNUmXMIPa8QSKUDXbCD2E5cf+6BBRIw1E0hmKg7Md6qZX0
         99yHQKewK7URWNMFv3pA5O/F2Y8Pf/47PLX3SlTAx2mYyxxbvEKX9IOpIO5CZWleeOKi
         XOfeVJarXzKUr2pMi2cZUj+BI05itC/qM19suaaaRhzbqMWjJH6fNcqD0KQNT2z2w0Kr
         D0x4QjPH8oP9v52jc5YVDUJzF3AfGBgFaNkpIA6a7xr7q5KbCdxNjsDHZXj2Ey1FDvV9
         BduCd/r5Y4SOHHuOlPtDuYu2Fa1MomFanBD2GuiFYCsO+fjgGDfRhnEr0OpahOWFhchW
         IOzg==
X-Gm-Message-State: AOAM5301+aEuRZFzECBBL/k3qGeLNiTF+1ARqxVyU2Ix8vXQ1mpNf2ev
        wXhxQrjT/S1RfjnVArzLBZxNXw==
X-Google-Smtp-Source: ABdhPJy1DPZkoGti0unLwAu4l34JPDW6ixePi46Ozsm6zqJQBZSEyWVOwouBqRZzste4ddEH1zr08A==
X-Received: by 2002:a05:6000:11cc:: with SMTP id i12mr16063103wrx.224.1593424787290;
        Mon, 29 Jun 2020 02:59:47 -0700 (PDT)
Received: from antares.lan (d.b.7.8.9.b.a.6.9.b.2.7.e.d.5.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:55de:72b9:6ab9:87bd])
        by smtp.gmail.com with ESMTPSA id y7sm42565369wrt.11.2020.06.29.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:59:46 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 3/6] bpf: sockmap: check value of unused args to BPF_PROG_ATTACH
Date:   Mon, 29 Jun 2020 10:56:27 +0100
Message-Id: <20200629095630.7933-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629095630.7933-1-lmb@cloudflare.com>
References: <20200629095630.7933-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using BPF_PROG_ATTACH on a sockmap program currently understands no
flags or replace_bpf_fd, but accepts any value. Return EINVAL instead.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
---
 net/core/sock_map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 4c1123c749bb..db45c1453d39 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -70,6 +70,9 @@ int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct fd f;
 	int ret;
 
+	if (attr->attach_flags || attr->replace_bpf_fd)
+		return -EINVAL;
+
 	f = fdget(ufd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
-- 
2.25.1

