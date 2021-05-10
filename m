Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF2379561
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhEJRYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhEJRYJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:24:09 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13739C061761;
        Mon, 10 May 2021 10:23:04 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g13so12497808qts.4;
        Mon, 10 May 2021 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxuzpoKujYtr2aHiM/kDtdSl1lSD9oNhumKLKx3WNhI=;
        b=cim2XGAYUsRYtj3qYEecXybCMYw3siy/whG1UYmVo9bCb0DP9dGn0X6vqnCsTnw3Qb
         oKHVXOYbDs0C3ZUfdElVbiFfHpdg/oDCfRhaW96kzakVZ4PNS0PM+eTJP3muffFNgsZ6
         FD6/yxgNixLspgbzKtWqT1lPhMzCXIv+Lzg6rhVRL3rlx1xReAsmQjviAjs5Gh0GG9ot
         5VtNsFrMIrx9sc3OEHv4px0SOwKM/J7SzyfUOZxm/woWxUj0q1XV8M1ivNFDlKj+60Qq
         KucQcDJG+XE3H04y4W4AbHWeJJ3i9EkQkr8o47xME/HoLufj/YWKXVf8w6zw/ufl8hDJ
         8mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxuzpoKujYtr2aHiM/kDtdSl1lSD9oNhumKLKx3WNhI=;
        b=H14KBPZ4EMGhY9WI/Fw69ZuJlTlqKFxoSY+5ZQJWGPKb5xrALpTpxruzlzK/xec5pj
         Hz+zqZNtl4XYHIxAw7w2PP53RdCOlojScSXSHA66tEAwEhlBSxzeJumpSpgUOzn6isxi
         9viE7MfP0qkS+sjDww3WqJleBuwPHoB/GzITsUa5mopfm9VrWa8VzGmVUtfvSLmImdGj
         W2N1vGqDzFOic2q4BSo0jMhpe+WytgQFl1z3Boeb5soKl4+PaJFkZDCk6ssq+I7piAuX
         zyzW8DOxavXdAOTR+gcBTxrMn4+ZnGzLIx+Qy/ctSMc0iaAvGZhAG4pwvpbIRbD61jRf
         qVKg==
X-Gm-Message-State: AOAM531SVr8O62elgn3zQS1aKxHgbI4aSWOT3YZDoLuAMvZ1OzFj6+ej
        kxANZnvk6+NllgB0rn+P3+o=
X-Google-Smtp-Source: ABdhPJxFkSB5mUmfRJ/kv+m/vRYxB1+SBmVTgvWXRofx/Tgdpz9dCSNx6diUsdagHlUsBhavhfieDA==
X-Received: by 2002:a05:622a:13c6:: with SMTP id p6mr23882773qtk.288.1620667383346;
        Mon, 10 May 2021 10:23:03 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q7sm11924367qki.17.2021.05.10.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:23:03 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux.dev, bpf@vger.kernel.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: [RFC PATCH bpf-next seccomp 08/12] seccomp-ebpf: restrict filter to almost cBPF if LSM request such
Date:   Mon, 10 May 2021 12:22:45 -0500
Message-Id: <25cc2777f0c1e5603fc8751bff0f36249b018388.1620499942.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

If LSM hook security_seccomp_extended returns non-zero, seccomp-eBPF
filters are not permitted to use eBPF maps or helpers.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 kernel/seccomp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 8550ae885245..b9ed9951a05b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2441,6 +2441,9 @@ static bool seccomp_is_valid_access(int off, int size,
 static const struct bpf_func_proto *
 seccomp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	if (security_seccomp_extended())
+		return NULL;
+
 	switch (func_id) {
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
@@ -2459,9 +2462,15 @@ seccomp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 const struct bpf_prog_ops seccomp_prog_ops = {
 };
 
+static bool seccomp_map_access(enum bpf_access_type type)
+{
+	return !security_seccomp_extended();
+}
+
 const struct bpf_verifier_ops seccomp_verifier_ops = {
 	.get_func_proto		= seccomp_func_proto,
 	.is_valid_access	= seccomp_is_valid_access,
+	.map_access		= seccomp_map_access,
 };
 #endif /* CONFIG_SECCOMP_FILTER_EXTENDED */
 
-- 
2.31.1

