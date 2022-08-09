Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA158DA0F
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiHIOGW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiHIOGW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 10:06:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52212AA0
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 07:06:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id o22so15232020edc.10
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=T9rhKHE44Kqx6/Cxz4pDtpbNcz3iUaMJMeFl+qlHrS0=;
        b=L0CwTrIG09dSLUMqKbg8Ud0t76nX1pxxqTAbuuSaFSedPR6P4xFWJ3mv1g/uqe+tcv
         tx/ERO1plcDJnMzTyyErUWRAEr2eGC/DKj0lyBDtDcfJhTmxr0J0fZ8y8weLqMGpgQbs
         aI/J7NOueufnhMJUN7TP1wCfxyLJN27fzBpDGbR/SDN2eaxqfpfPSZfm7xfxhLS9MdMm
         5WCKH3FKsgvipT4FN230ZzVy1ghspZJJgAz6ybiQi+yjcKRNtBA63zX2RPzts/yEULHu
         NAx7FfgtiN/Oa1/2kgX1fYyOkTE715idhvr/ccNJmkyRivo0fgngFk1RSLjupcn+gRu0
         EKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=T9rhKHE44Kqx6/Cxz4pDtpbNcz3iUaMJMeFl+qlHrS0=;
        b=wI7e5GxorIrTaM7nK8BoYPWrW6ZeIMZXQ6v0MC0AI61Ib98TH7L9zHP6HwmQliVtNK
         a5VuDpIH3Ui2ysgPksp88/apT9XP+D/Y17A71C9R/ZRkLEhVLezj22yEy4ga8nwRbsuo
         nu2MSK19jK2ahpyplKW9AEXfwgS21lqxgFQ4wcQyQNvd9Xr0nOHUORH62SlUNNa5BGR+
         OUJlNPzGtQC1MU5rKmpGhZKPjN1jHt3wq/ZlI+VkVWvnT2yqZC7mjAjzoiDHc4SxuN85
         hfOcU2Kofmrgzs1iduPKvrzRgACc7xS/oc3vtWA5s4pClARdeh2zDGMEhgKGtWmqdTUt
         vGGA==
X-Gm-Message-State: ACgBeo3Lkl/DUCRQa8F5T7deCGtjkjohzuHqYAqRXCU/KqKfyIMnjd5S
        fHFjM/fsfYUazd1Ml8e/uLUP0Gp9C+o=
X-Google-Smtp-Source: AA6agR5ygM98StyYs18mGkIGmyVjivMqsuWEjSnaDIbtheu29Xb0qKfHrOgAufeS4yp8O6FvpCVKvQ==
X-Received: by 2002:a50:d0da:0:b0:43d:5f5f:32c3 with SMTP id g26-20020a50d0da000000b0043d5f5f32c3mr22120333edf.192.1660053979605;
        Tue, 09 Aug 2022 07:06:19 -0700 (PDT)
Received: from localhost (icdhcp-1-189.epfl.ch. [128.178.116.189])
        by smtp.gmail.com with ESMTPSA id z19-20020aa7d413000000b0043ce97fe4f7sm6092647edq.44.2022.08.09.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:06:19 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 1/3] bpf: Allow calling bpf_prog_test kfuncs in tracing programs
Date:   Tue,  9 Aug 2022 16:06:13 +0200
Message-Id: <20220809140615.21231-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809140615.21231-1-memxor@gmail.com>
References: <20220809140615.21231-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=memxor@gmail.com; h=from:subject; bh=awNP/IgLW1N8fIbBHxKdlf2TW0p3qvwRBAwGmHV3Yak=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi8mm83qgE/DhN74Ua3h+V8AyFn0fCybOK94XLuCCn kQ1Xv3aJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvJpvAAKCRBM4MiGSL8Ryj7BD/ 0eLYMR3Qotz/zdIIxrJlgb4v7TRPj4mtHxa8QwTImL3hYk9qrpPAXlyIvg+Bp7p3A2PdlXhr3BU0f5 W0xz8h5BL5j3uq3zEc8SeJgkHkGpZKFUHmfrNlQuY3aWRpPTxZG9/lkzFHtjra3atv0dGOfmGuRlxB 4wJ+v8z10sWaGbiB7h9WMzz/HzzjJ586JDCFrdOKtBYA429lukIWhG497K1ESci0teh5Ov8OBp7oKQ vWkDo0tvsAjWEHRyVSJCTUz9qDyK12gefqZaVj+v4EASBPd0cEfA3Am1/AKdNLCByJYx3LB0MAIKgf p85lbHOCFnpt8hOuNUnMJqN+VeyXUGtXGbrrSdPGXo91hIgY83pgz+ZAC88F5Y5am0eepegW0hypTb hJ6dc4lAcyK+3SrHJYX15AAwi97JT7XWYHhJ/IeMd/idOTcmVbcIiMeggMoXq7A52bqf6a1OjuGd+S qg79qqzqzA3wXC+eE+9dtI9dSxvdnYQLkpTcwq8+z+cXdMgUCSWsD2Po6ktwGaGJkZiAsUxj3W/WPF lmweHCtHQJ/mM7H1f+r27wFAfHaJ5CfZ4uwp1bJ1N3jqr+APNqjWVR3Id/IVj132zN8Snr3YLD1+vQ j4AckOtptfPb1E2FruEHCsVJkVfPU9sZe77W0UyjuyxSgxYsW18mJHIhpdWQ==
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

In addition to TC hook, enable these in tracing programs so that they
can be used in selftests.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index cbc9cd5058cb..d11209367dd0 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1628,6 +1628,7 @@ static int __init bpf_prog_test_run_init(void)
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_prog_test_kfunc_set);
 	return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
 						  ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
 						  THIS_MODULE);
-- 
2.34.1

