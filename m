Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DD634E85
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 04:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiKWDy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 22:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiKWDyZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 22:54:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF8D725CE
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 19:54:25 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m2-20020a17090a730200b0021020cce6adso493673pjk.3
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 19:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tXoYmzVLVRhwn82EZ8bonHMIHSg0ea3diawdbsWoyf0=;
        b=YpCFKKKos0zR12SPfSYgjzfbs0aGorlQ5jlOQfda9EmlLYacc0sF6YnNRcFl6z8PR5
         pJKnG3r/zfBSMZx+8rhKflfz00PjJ5bBr365Spq4XtuA9CJBbTKkfUrt03U9W4J3vqCe
         uOG9HAbIoCS/Ggyx8NkKk8clpVTag/puKpnJz+Q4J0Wu7ZqJRmqwiGfNALPkanGsFBtH
         Xu1qdYtsADKlt6/rulyfV2NVupJKENAkSHzN3hQnV01S4HfPihDgq/iwfjtlivxeYNAz
         Z17upa4fmfeBM67pQXIFSiQ/l5DTeLu+jfg+r85PFXxb9jQLt7Rq6Ys/ej302WlA8fQw
         lrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXoYmzVLVRhwn82EZ8bonHMIHSg0ea3diawdbsWoyf0=;
        b=z2+Almyh+b1PhoPwYCM6V0kFakhp5aq/EJTz3KyI5OtZxZmgKJcLQ1ng6fUdZM7XPr
         Sz6o7M0UaW8VkCULVeKXz80YzKkpBpMt1j7k86ERnzquoejVEL9MKtlflx+0ZfJyVJoD
         jtolhY7Sk1zMb1FOOD8RT8N+5jg1rgQTCyaz2d+K372TReqIm/yDfmAJ4TqIxkuwdgE3
         IsEHEQ71zMMdEq/km1du4Bke+v+mCIYK/dxM9WLceMS5qPCJSKKK+vuv5PjBo5wCTxM+
         8UOygkhM2nsvLHjBeIubFRFZg/ShnpDfr1prf3DjqOxEJleMvaWUevM9DpRJtCMr2X13
         iYnQ==
X-Gm-Message-State: ANoB5pmQGpdWUPLEIN6oYlW/ilOPyq/HrxUarC4xbnRJrw89UAeCyqvW
        R/u4n5uJrvJ5o+GqvS/yyHR29KZgnJN94ZjG1b5dBL20KsWpxVawfQBBH7O2MZ7QWD0thx3nOhW
        0qCRgxPu1mA0VTUq5DKRSHCjWgWBBakumIpOxpPNFbggrDWaMYA==
X-Google-Smtp-Source: AA0mqf7YPbfNtNV5GSSlW/ldiFoDbKs0heqU0PSYptArNmU3C22s0UlkWAoZJ5XSjKahYnZw+uZX06c=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:f7c1:b0:188:6baf:1ffe with SMTP id
 h1-20020a170902f7c100b001886baf1ffemr7523986plw.113.1669175664537; Tue, 22
 Nov 2022 19:54:24 -0800 (PST)
Date:   Tue, 22 Nov 2022 19:54:21 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123035422.872531-1-sdf@google.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Add reproducer for decl_tag in
 func_proto argument
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It should trigger a WARN_ON_ONCE in btf_type_id_size.

    RIP: 0010:btf_type_id_size+0x8bd/0x940 kernel/bpf/btf.c:1952
    btf_func_proto_check kernel/bpf/btf.c:4506 [inline]
    btf_check_all_types kernel/bpf/btf.c:4734 [inline]
    btf_parse_type_sec+0x1175/0x1980 kernel/bpf/btf.c:4763
    btf_parse kernel/bpf/btf.c:5042 [inline]
    btf_new_fd+0x65a/0xb00 kernel/bpf/btf.c:6709
    bpf_btf_load+0x6f/0x90 kernel/bpf/syscall.c:4342
    __sys_bpf+0x50a/0x6c0 kernel/bpf/syscall.c:5034
    __do_sys_bpf kernel/bpf/syscall.c:5093 [inline]
    __se_sys_bpf kernel/bpf/syscall.c:5091 [inline]
    __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5091
    do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 95a2b80f0d17..de1b5b9eb93a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3948,6 +3948,20 @@ static struct btf_raw_test raw_tests[] = {
 	.btf_load_err = true,
 	.err_str = "Invalid return type",
 },
+{
+	.descr = "decl_tag test #17, func proto, argument",
+	.raw_types = {
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 0), 4), (-1),	/* [1] */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 0), /* [2] */
+		BTF_FUNC_PROTO_ENC(0, 1),			/* [3] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+		BTF_VAR_ENC(NAME_TBD, 2, 0),			/* [4] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0local\0tag1\0var"),
+	.btf_load_err = true,
+	.err_str = "Invalid arg#1",
+},
 {
 	.descr = "type_tag test #1",
 	.raw_types = {
-- 
2.38.1.584.g0f3c55d4c2-goog

