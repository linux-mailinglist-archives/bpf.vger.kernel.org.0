Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7383F31C9
	for <lists+bpf@lfdr.de>; Fri, 20 Aug 2021 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhHTQzz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhHTQzx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 12:55:53 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA73C061575
        for <bpf@vger.kernel.org>; Fri, 20 Aug 2021 09:55:15 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id dt3so5844168qvb.6
        for <bpf@vger.kernel.org>; Fri, 20 Aug 2021 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fu4+PEWQ87vZiGjl7KyFUYdCMwiriMEkc4k2Dmlg/B4=;
        b=VzHxr9UNasgH57nLhpyqdoT7BsV8FtGUDcODwDSC8y+6G5eR/8iJAbxujLDlNt5bA9
         3Lkq5pyGU8/GJS9En20Gp7I5QzTYa/4HXoWEzy/6ptrDXpPwqXXlO0Aql+eoWmJ6CQe7
         8LThirTSIa56j22hbgxUBirUrdEJze8z2NeHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fu4+PEWQ87vZiGjl7KyFUYdCMwiriMEkc4k2Dmlg/B4=;
        b=lgzRnpOedc0zVH8iYmRmqxz4L+8YIDuuc9ZPnXfhoBY3q6oXQytdLvbLEmMIJTyW8c
         U+ZOAV1KV0kEkfdDtpET8cmrCv73+JG1Ef7al1JUJQHRxUhnjbCFtnkISi5ZvmdT7ePW
         jn1gkdVRD11rciZ/iATmT89WRKoWe/8bN4vwLDBhPksSh9akD35RJsTncVrDPG9b7vIg
         ykMKLO2uciL+C4WP0Lk0SV4ykM+/B+s5h8WzSh3ZWsmyXt5Tr1lb8S4YZf4DoYv+A9op
         AzN1SyOZz3INefMmpRFYBuDSknqZG7ZtqjpcIeqn9Q4qHJYd1x7SWNzrA8hVdI997+gU
         Uhxg==
X-Gm-Message-State: AOAM533iOiWj9iNVEOx/pjk4sj4CwhudFyqJWD+U2L4A6rOiwIcZE7im
        fiAYOyWrRMnsQBK4Su06NgT1kA==
X-Google-Smtp-Source: ABdhPJzZBTlctaNaVMbW+4RGXpIBuCVcZSyPu+S+4slyxlVE7q2VJPN5Yib5nDGfvSkJBChqoadLhg==
X-Received: by 2002:a0c:ef84:: with SMTP id w4mr20937176qvr.34.1629478514711;
        Fri, 20 Aug 2021 09:55:14 -0700 (PDT)
Received: from localhost.localdomain ([191.91.81.196])
        by smtp.gmail.com with ESMTPSA id p22sm3369044qkj.16.2021.08.20.09.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 09:55:14 -0700 (PDT)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauriciov@microsoft.com>
Subject: [PATCH bpf-next] libbpf: remove unused variable
Date:   Fri, 20 Aug 2021 11:55:11 -0500
Message-Id: <20210820165511.72890-1-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Mauricio Vásquez <mauriciov@microsoft.com>

Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algorithm")

Signed-off-by: Mauricio Vásquez <mauriciov@microsoft.com>
---
 tools/lib/bpf/relo_core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git tools/lib/bpf/relo_core.c tools/lib/bpf/relo_core.c
index 4016ed492d0c..52d8125b7cbe 100644
--- tools/lib/bpf/relo_core.c
+++ tools/lib/bpf/relo_core.c
@@ -417,13 +417,6 @@ static int bpf_core_match_member(const struct btf *local_btf,
 				return found;
 		} else if (strcmp(local_name, targ_name) == 0) {
 			/* matching named field */
-			struct bpf_core_accessor *targ_acc;
-
-			targ_acc = &spec->spec[spec->len++];
-			targ_acc->type_id = targ_id;
-			targ_acc->idx = i;
-			targ_acc->name = targ_name;
-
 			*next_targ_id = m->type;
 			found = bpf_core_fields_are_compat(local_btf,
 							   local_member->type,
-- 
2.25.1

