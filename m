Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAAC5AC669
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiIDUmA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiIDUl7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:41:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CEA2CDD9
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:41:58 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gb36so13424007ejc.10
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2TKO21Rlla/qvZK34Fz8BjApzN6ApLKp7MGJiH5wI2Q=;
        b=Xns4HeOxM/SKLURejzl9mULKC21ET2tDlaQUxVUFGTOoLSWUfwdRiVMk2NeZ1/s7XC
         1VH51ndr/CaGDCQTEimO2Yw3AaiuLvplza3DLpoTIy0c9v8upeVjmBxJGtaLJwdkHfLi
         8aMvptF59yc4C5slBFqmALCAPK1wudIUe7T07F2O078dM6TCuniWk5h4L76bxNUI46DS
         hIrkw4LaVM8AO81Tzggy5tIjH5+3TjVbs0in2gBEGv4OisCXGTp8VHc3jydnclOA/+bg
         OIRfUv/Eh8EJtVuprbpag5wlWqisGJoqj3uudkA40H2hcuz757ukFlCBbptKfkZYWXBW
         g12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2TKO21Rlla/qvZK34Fz8BjApzN6ApLKp7MGJiH5wI2Q=;
        b=rGypW0suHrleYXBmN/3ilks8XuNcVCiQLWP+7Sx0nFFBASQTriQKeb/ymyQhRpo99A
         X5qaHpx/Ziq2ex1pKsOt7pfoa28OKoc3hw1uVC46+NkGpVmPBGv2kUGntOheZdQtOA4X
         TOZ/6FkkfuDE1UidzkXEIBHybEAp6JdAozCYgVET7ie5Ypt9Y3Hsge0NmLh+4g7VWj5p
         UIxtZ7b7gR91Jloiyza6TsQSB9P1uRTPpNnjZ8pk5KKFt7bosFMYtgbL60Y0XuL8V9mE
         Hj/wTUXIobhfz23fNMMlvPaDKashoeCaqLyeXmk+GTd2eT8RAL/clXCU0lXi2d71ADHL
         nUjQ==
X-Gm-Message-State: ACgBeo2waAz6XsakPh3rJaBqctPanlBxIHGY8yCjisvQOIlsJKpmro1n
        6OUFznN2UBC5ePNcXYEykq5LMgI+66kY7Q==
X-Google-Smtp-Source: AA6agR7FxpdBkSyEZQHYZTizq312dzEvifVUmvOcw2vGAmf5xgWaC8JkpB3LchBCtLkPU2GCS8cBBg==
X-Received: by 2002:a17:907:7f02:b0:73d:dffa:57b3 with SMTP id qf2-20020a1709077f0200b0073ddffa57b3mr31850366ejc.19.1662324116567;
        Sun, 04 Sep 2022 13:41:56 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id ca8-20020aa7cd68000000b0043d7b19abd0sm531988edb.39.2022.09.04.13.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:56 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 07/32] bpf: Allow specifying volatile type modifier for kptrs
Date:   Sun,  4 Sep 2022 22:41:20 +0200
Message-Id: <20220904204145.3089-8-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=memxor@gmail.com; h=from:subject; bh=EAJh0euJO1zfWYt0lcTRwXNayT97xfctSqXX1QFhvhY=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wurIaJQy2LdIrCOuZhZAMqhHjoCA2ijoanJDs Ql2Bp2+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8RytVSD/ 0R15CMzUxhdJVoDLrZf40nyyb5uDCQJVoI3NZqA2N7tG2qNKZyfTQHQBj9O+kssb47GNB2pzUR7xlX mT9CyXz7Tu/011s715tR4hH8fIfu8l5ymJ5kHdf0vvpRtI3LlA+ew/qScuT2BuD+jbyMDMSEATyAF6 yPLTZeVFw/wat4YOA3P8tWAzyDOFZy0hXAH+TLBFK7DDCNHlQJDVaTTqdya+c0KRPm28J/j37TrwDc jVZlD+gpM1knKkFS43/lp/Sy3awhcxoOje3pTzQcpjtWpUA/TU9lsYSX/leGpNI5kVfpR/2tE5B31K AqIbjvO2UNBe64j25Szz4/Yt/UIIFGjl3urW3OXu6+y5D1/kCQR8bjQgofuZqbAPDvNmgpABxl2mgT HqAn9pJmtNYLS1w9YRBYK4+DlNWAXaa5+N2pJirYtm/g7JCdnqD1ag0qEHtzf7WiyX8OId7Jzj1YCk OtcVnOx4yZuXSDNKwH1QYgmeeSWQWNiGw8qz3ySIvtAamCxSo8KjDEeFQwjZTo3vh2B94M7RjacFvi JA6RjzuvtVqb/MqVcT+VZqXS3FwoC3/tzbxu+lQmfKbuprvaqjpRGRLtoZ7XnDqIcnbiMvrV4O26vN lLTiK8kKl6PryqrT/ePBckjuJLRPrSmO+El1R3Spx9NtgFAF0TAavX6gABMw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index ad93c2d9cc1c..b3d47e9b9d5c 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -279,6 +279,11 @@ static inline bool btf_type_is_typedef(const struct btf_type *t)
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
index 903719b89238..5e860f76595c 100644
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

