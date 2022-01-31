Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF34A5207
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 23:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiAaWFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 17:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiAaWFs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 17:05:48 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E20C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso563707pjv.1
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhqyUCno5avnlYlJWrXkwopIrnAwzhUTkOu2zMw9Wps=;
        b=dbPYFFRAtdsa0QgYfdgieYyQOPPNFTbGZrZIS4ueXltlgss0nNczhC3EXGo08Pt0EX
         Gr2SOhYMxkWwSVCnDW3aKma73vxr/TREADmMKoBoBCqRsfBJmEhwbGoPhUxde+8TPjSg
         ErnZTq94GpR/siZORySzqTqb/Lvmd12q6rOejcqKZpMDLidkkGJa6/zvH4SUgxsJHWwA
         gyjh3y63UFk7lqSgZIo7Iftx86V2kg005g/8vAK+eOh4NPZrBEJHo34VnrbWlHLfYmFg
         FT6rRh5+x9w/vZSxhNse2LsIbOOlX+Dbeb/J/BftrnWfxPu7EKXtgjxyTvvJqpkOVEpf
         qM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhqyUCno5avnlYlJWrXkwopIrnAwzhUTkOu2zMw9Wps=;
        b=jGQ1BxmoFniTgZpkLMtTbNfuvHw3xYK7p968Mlo11qgrgjISMwd5B6DlbwRuADmHI6
         MJZ8vMilQ2JedJazS5mfGVTVoNUsTzMYcgSOCRbwhMXvBHmpj+BLqbrlTQxqZyftlQWS
         AtTq66nq2CmMwDGSOm2oXGrvCNnfB7TexRLyROct5yLQCGEkRIFr4R0rice2VTsb5FbS
         TcaSETRqc9EUFDfTxRqPsn5pgdWS55Vlh4BTTTzQN2v8vk0kL0rHGUsbaAKdehlxhsYQ
         ev51PCHEpo9UGaj7laT3+Bg0Jqd8MFHs6N7N6WKzDi7r5QBqcsSuFznNZEBp0zioWL4C
         MgBQ==
X-Gm-Message-State: AOAM533Fgk+PQ3gXhYh3ay+D80chpaBZDoBmqRRMTdb39lEqouK5PhWx
        n1iyfbk1en2tEeSmm3CjQ/s=
X-Google-Smtp-Source: ABdhPJwpiFWoVB/fXDxXUec5xwPdU0jRFh+GQvCVNNN/SIF5nO2c5SbXTVAL8VOAAGatMkxuaBDFLA==
X-Received: by 2002:a17:90a:5204:: with SMTP id v4mr27001572pjh.47.1643666748283;
        Mon, 31 Jan 2022 14:05:48 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:78b6])
        by smtp.gmail.com with ESMTPSA id mm24sm290495pjb.20.2022.01.31.14.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:05:47 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 6/7] bpf: Open code obj_get_info_by_fd in bpf preload.
Date:   Mon, 31 Jan 2022 14:05:27 -0800
Message-Id: <20220131220528.98088-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Open code obj_get_info_by_fd in bpf preload.
It's the last part of libbpf that preload/iterators were using.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/preload/iterators/iterators.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/preload/iterators/iterators.c b/kernel/bpf/preload/iterators/iterators.c
index 23b74916fb84..4dafe0f4f2b2 100644
--- a/kernel/bpf/preload/iterators/iterators.c
+++ b/kernel/bpf/preload/iterators/iterators.c
@@ -16,6 +16,22 @@
 int to_kernel = -1;
 int from_kernel = 0;
 
+static int __bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
+{
+	union bpf_attr attr;
+	int err;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.info.bpf_fd = bpf_fd;
+	attr.info.info_len = *info_len;
+	attr.info.info = (long) info;
+
+	err = skel_sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr));
+	if (!err)
+		*info_len = attr.info.info_len;
+	return err;
+}
+
 static int send_link_to_kernel(int link_fd, const char *link_name)
 {
 	struct bpf_preload_info obj = {};
@@ -23,7 +39,7 @@ static int send_link_to_kernel(int link_fd, const char *link_name)
 	__u32 info_len = sizeof(info);
 	int err;
 
-	err = bpf_obj_get_info_by_fd(link_fd, &info, &info_len);
+	err = __bpf_obj_get_info_by_fd(link_fd, &info, &info_len);
 	if (err)
 		return err;
 	obj.link_id = info.id;
-- 
2.30.2

