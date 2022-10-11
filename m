Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F715FA9F6
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJKBXp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiJKBXR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:23:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383782D04
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c20so2251142plc.5
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hv2RM/Gc/5fxkeVrZbmO9zQwxyDDXIFkyfCJKBgP+jQ=;
        b=BSlOcwJrFWR4lL1tNDXIcQuTNV0FPuZBfUUiFzA8P8mJrhseLVXRKXUw3N591DWmcL
         496p3SNm3tfZmXAPi6qA8hoNCjsL/4S/QvGAGZ0Ho0f/7PkO34vjO7N4Hxv4j+iTLHNN
         6sNI9gS2HmpWQqTad2GWRe/hO9v0iLQZPlSJh7id7wcGn/1UVnTZizZsNjQSCMIIRuVM
         jESCcVlxp2ASaR+v56GQz8j8N3GCPqnKQUj0za5BG6eW2TBXD1HN05gEuZD1zS1lm2zc
         +ScQ9urUkYtXnKhHp9owRtU6aKU2KJzSi7jj1XngIVxd2GjPQNyYBwFUPQKj8tK3gnbb
         PCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hv2RM/Gc/5fxkeVrZbmO9zQwxyDDXIFkyfCJKBgP+jQ=;
        b=wItKIzGdyXvLw/B+bihIpn4dHhgz0/zb7AxOwuTqP2S5btNe8Cc690JlFIxzVbE5yi
         u99QsnFOoipYRdq+T+L9OhVB2xO8s2lwjZatrmkpJROe2Kz3MPpxskl38WAG/d/Smpcl
         fdX+7hoFkk2AxI9th6CFXQeYaoKQFx95hmeuo6UtKnCh1eiy7cT75aRbTfP1Dv8uNxB8
         TwMd4EP+ytntppq+uIESmc1JlePDYxcFG6p948DzT7eHfSTNkk3wXjcixeJywGz+gr94
         ByAMo4B9E6/umEvUh7fzDT9w9e448hyhl4U0/pF0M8dXi7+0Hq1hUs2+P6pZlj1BKWV0
         iFhA==
X-Gm-Message-State: ACrzQf37pR5CvWJEGPWgsj/ourDeTcHQwFKNO0XszExaXAExSGrzBqLK
        DxrZJs9kYwmnBxwmpw+oUCZzF7cmh1eUyw==
X-Google-Smtp-Source: AMsMyM6TQFkA7I8pLLuk+0ImY3y5NYdRxgrSy4vVSGYyIo/1W7z6k1hAVyl6INnTZtJXRC+8LipFtQ==
X-Received: by 2002:a17:902:d4ce:b0:178:1e39:3218 with SMTP id o14-20020a170902d4ce00b001781e393218mr21707318plg.144.1665451370890;
        Mon, 10 Oct 2022 18:22:50 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id q9-20020aa78429000000b0053e4baecc14sm7544886pfn.108.2022.10.10.18.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:22:50 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 02/25] bpf: Allow specifying volatile type modifier for kptrs
Date:   Tue, 11 Oct 2022 06:52:17 +0530
Message-Id: <20221011012240.3149-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=memxor@gmail.com; h=from:subject; bh=yyO+aCTALZegtvRf3fQf0a5NZMFkaIgWLpfML2P9IPU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUa1ODWu0lBULS8TM+tAzzVDTt9Dv0f7q7r2jiJ O3cbKsKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8Rynn3D/ 4nzwdFcbeUfc79CejV7WuAOPCLZjXU26+ckOGpGIR1sUxgioz8deIHjMsaw7aeg5b6wwNlvjKTOtdO suDvvvUOj1VnAe67dUQAtnDo3pEI4GV8VKP9NwdhPA9XpuxlogRraC1wCmxO5ydAP6xFCe/BDqTTOh NJhv9y8Xe1V30dMS8a2n3l8UG6Qc1JNCWTEJpTrcV27lvms0n7ksq8UMBAq+gbRZ44TKb4f5Q/MOlS 1ONq9Bao/LadeWvBy/YQhDldtE0Je4DrAMs/i2706y8ugHaKBHGcd3aZVP6Er0sZEJ0aao6TmsVCf9 y0reTrtWeclI59VNL31GGHLngQojEzKdPU2SlQZsGFKE+r9aNY0p9Sq/XOqyPDUxzVRxc3GEMlOqiq Pslb8gKhL9BYfV4dtBHMbn3W0SrKFMKTosTdD2enE6BeB4QyurAE4xIRpIA66iO3GRvxsAEYzfebcd GRorDOWT6Ws8hDfKQDvs6O8smfyWL0pnP5w1HWNxL/TgrRTnhl/Aw4n0n41aVH5whNi79DUYc/qP5q aT82nWW6nS4JwD4vFCTifg7YJDfJq28e8b2aSx81d2hI0455bNOszKEYfphFKnIumaD6mA/vLPx2Mu hnmHr2/ZjAXRmsPpJoWeBVVIvpJ/AqsDnQ5GFtnDYWMaSe5EP3rnR8zGyHPw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is useful in particular to mark the pointer as volatile, so that
compiler treats each load and store to the field as a volatile access.
The alternative is having to define and use READ_ONCE and WRITE_ONCE in
the BPF program.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h | 5 +++++
 kernel/bpf/btf.c    | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9aababc5d78..86aad9b2ce02 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -288,6 +288,11 @@ static inline bool btf_type_is_typedef(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF;
 }
 
+static inline bool btf_type_is_volatile(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_VOLATILE;
+}
+
 static inline bool btf_type_is_func(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_FUNC;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..ad301e78f7ee 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3225,6 +3225,9 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	enum bpf_kptr_type type;
 	u32 res_id;
 
+	/* Permit modifiers on the pointer itself */
+	if (btf_type_is_volatile(t))
+		t = btf_type_by_id(btf, t->type);
 	/* For PTR, sz is always == 8 */
 	if (!btf_type_is_ptr(t))
 		return BTF_FIELD_IGNORE;
-- 
2.34.1

