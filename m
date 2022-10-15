Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8465FF7A3
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 02:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJOAZB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 20:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJOAYu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 20:24:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F8F167F5
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 17:24:46 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u5-20020a170902e80500b00178944c46aaso4127065plg.4
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3irTsDwhXxMlvvjoF3IsVuph9QBypbJM5ZOlEr/qfUY=;
        b=TpvWOngeHfJni14CPmcTU7U+t7qy40LTOvK7l6+HRA6HjCPZHkD+cGMMUBq/QLDOnZ
         dprr45ZzZRTPQ9V2M8fwGuMVytH2E2DsHsJg0+t+oPgCbaX+k0X8ONmNwNRD0INs92nz
         vpsZ8xlnaSbYiHmYZfEXTjTKRF4PCqeZ5rlmP1XamWLgYi11ftwmHw6r3l8sjZC0en0L
         uk8DLY51wfeOu0uSq6cZZ2AUzfXFTUUY6H455/6bGHomiIBo9EUWmcMse910t1n2G6yD
         g2QktocwGKJ6Xg7t7qCwaW+Mk6gPrVa05r94I1RurqZ2/3OGVgXK50c537S7lB2wumkT
         MRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3irTsDwhXxMlvvjoF3IsVuph9QBypbJM5ZOlEr/qfUY=;
        b=pDRGYyAzLwWS0OwcN73DDsmwXzwke5XmCJgGi/j8EdBLpuzNHIzq6ELJFMRTBu2X6J
         BYNCjYXglr3f+qdbAd9XfaWj5FptnwkfjI4f+Tvz/h7n1H9P4mlWVRFoa87VrJ6JHeFp
         ySBB9YXd57j9+BCD7lHOjCGwMUUZ7pz4DxN25rVEWob+vgDBxIo3AefQlrABTM5ZxkOf
         Dqc4TfGhtE1yORe59S39s2vB7N8brse6yo28PZtOYxi2E89kAHfnwMtQR+W62Dp8Tmh1
         oEY/5hcS0c4neka9X+mhMaBeaHWarqGL2ctTSylMSEQow4SLmuOBI147+MrS28h7OS21
         ZNLA==
X-Gm-Message-State: ACrzQf13ku4kzNerkbsbdyQrES6AM2M/bkHE2eVpfJiwZr/GmZvzAxFs
        TXcGwzGPs6CJDTmwkpx/B5OWpwnMgTCkJcl3Wx1CixCGog+xdI9LOP5etWmQ7SNINDl7dTqK15I
        ddMgmkH8Heow2lspQFoECSP+fSCnnsfObFdEYDZnZZfieOog8UA==
X-Google-Smtp-Source: AMsMyM490HgO66lsAtBqXeIfWe599wxeSMzCo5HwTwWdXcIIzOFJ7hd2Puabwj6J0ODR6molChm9UHU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:15ce:b0:562:cafb:2844 with SMTP id
 o14-20020a056a0015ce00b00562cafb2844mr308590pfu.75.1665793486166; Fri, 14 Oct
 2022 17:24:46 -0700 (PDT)
Date:   Fri, 14 Oct 2022 17:24:43 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221015002444.2680969-1-sdf@google.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Add reproducer for decl_tag in
 func_proto return type
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
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

     btf_func_proto_check kernel/bpf/btf.c:4447 [inline]
     btf_check_all_types kernel/bpf/btf.c:4723 [inline]
     btf_parse_type_sec kernel/bpf/btf.c:4752 [inline]
     btf_parse kernel/bpf/btf.c:5026 [inline]
     btf_new_fd+0x1926/0x1e70 kernel/bpf/btf.c:6892
     bpf_btf_load kernel/bpf/syscall.c:4324 [inline]
     __sys_bpf+0xb7d/0x4cf0 kernel/bpf/syscall.c:5010
     __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
     __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
     __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5067
     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
     do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
     entry_SYSCALL_64_after_hwframe+0x63/0xcd

Cc: Yonghong Song <yhs@fb.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 127b8caa3dc1..24dd6214394e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3935,6 +3935,19 @@ static struct btf_raw_test raw_tests[] = {
 	.btf_load_err = true,
 	.err_str = "Invalid type_id",
 },
+{
+	.descr = "decl_tag test #16, func proto, return type",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),				/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),						/* [2] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 0), 2), (-1),	/* [3] */
+		BTF_FUNC_PROTO_ENC(3, 0),						/* [4] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0local\0tag1"),
+	.btf_load_err = true,
+	.err_str = "Invalid return type",
+},
 {
 	.descr = "type_tag test #1",
 	.raw_types = {
-- 
2.38.0.413.g74048e4d9e-goog

