Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910864598B5
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 00:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhKWAAr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWAAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:00:46 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2671C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:57:39 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t4so9332236pgn.9
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SyNmxjVrM1MiYtCpCqUDLH2S8AYiRFIZmRV4VCFzmM=;
        b=b9Fj4jNy1TgambKUu6d35RAOA/J9bYKpgs5+cZV86qRhfZmIXgSRHhoLWrCZM7uAN0
         UhYxylOqlNz2tBtulmB51f0gNYQAzZ5ZwHuzcxAqAArlXBhyBodzmSGttPDyxCUR1tqt
         Pflmx5a+9W8i0dtkTBirTJEdy5Fy6vi75EPqJMECgv4Jnj1ggmOeVF0bYTAfMI0v1563
         W4awPGoLEwmr+elyCm9X40iFlyvx58GW90GfkIblO/J70iWmIw0sVOuIjmwbNi9A+lVq
         UvWP9hr3didtpx8Lm9VwZwKdFQ917VZ2HiWL9zBgsoU12U33fQ6m6vDVsAoNvcqQNjuQ
         I07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SyNmxjVrM1MiYtCpCqUDLH2S8AYiRFIZmRV4VCFzmM=;
        b=pWKc8HRkBYI3MgsZ1oFXyjUt27kM3S1cUk2TUuyw85xXRgIVZUiL27m6PLWpyUT4ex
         Wv+S7butlFvUZ7JDIxeU08I4bWiIl/Q42uZrgWbsIx5YXRj9NLzZPW+x2EsVnVWaMUWY
         +ISrho6LTaUnfKqd4p3ARIVdc6R+BfMG+VYzKQoNia4HFCfAe2wRpBRXCFjdj1odzqDZ
         djJEtXsr6r13GkRDmjNbb9CmaEvLY8VwZUxkOIVvTAuVWE1vJAE5w9EpXTOXaFsfNY07
         oH6w4tdM/Sa9Yw/KJ5E/SLp9BSlWE0SKxflzRKskndcYQ7fi/r12617njegLE0gytebD
         qu7w==
X-Gm-Message-State: AOAM530Gs3bWaB/0P+K8NRlDTnVvEBj+Uug8ezxFQ+xy4jE1sPUJCgd7
        J7crJ4NwUtjqrfL6z/mWv7ZG8J4ke/g=
X-Google-Smtp-Source: ABdhPJwiaxb8lwylQEWFuHIBzSfcL7+hS3Xd8ylfqJ4o+6ThkOStqv15lxbr0KbJtx6nVaRdkTMqww==
X-Received: by 2002:a05:6a00:2313:b0:49f:d9ec:7492 with SMTP id h19-20020a056a00231300b0049fd9ec7492mr885762pfh.25.1637625459261;
        Mon, 22 Nov 2021 15:57:39 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id e15sm9371192pfc.134.2021.11.22.15.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:57:38 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 1/3] bpf: Change bpf_kallsyms_lookup_name size type to ARG_CONST_SIZE_OR_ZERO
Date:   Tue, 23 Nov 2021 05:27:31 +0530
Message-Id: <20211122235733.634914-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122235733.634914-1-memxor@gmail.com>
References: <20211122235733.634914-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; h=from:subject; bh=AtZbQtOOJ2Z4rJPkyXSn1Ll6XcEhA3xESndwsMgvAwc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhnC22bMCppp/GTM6BFAvf9b4QOwlM922fs0WXvGUh vrrTR/qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZwttgAKCRBM4MiGSL8RymQLEA CSRLst9ofsy1MJCUUtBrJh9uN+Yx3e/uC5Q3Y2Vw0eCHPLe1z4ZteB1aie3pbIOweTZVehddJ8EpKT 1FtNwN6sZGsVkKdu8z63tfPgHyXraDQxc6K42iIXCUwR8qS/m8/CWmcu+vejDkeej0grkeeTw6SAmO gjmnGd5KmIDDeDU2d03RxXwr+lVg8jiWM5o3RqfjjptVV68Qxei1bDFbLeX1y+nQPOCLfzmrbvel5V oGbWty8FhD4Z4qPSsq3GYS6iqAIqXBvm0RcDZDDqkqZiaMYl4hIwh2HyBHtgMPWxZMeDWaX2F6z3Sb wVPe4bRGt6Tv7wy+KrcyxP5yY1wfCl5VNU8QK/OuuAHr3OeVL87MGUccTXyHLWzS2Xa5Vy+YmNYaYg 01xpu4frmKWYs9r727W75EGCdblOk0UrMjpt1A0yG9URJCCmveUT6rQQ7C871t7cTpFWpE87t/xigG NrHfcEe/ho65BPGz73tYesaZHqZPjnP3lApnN26E51dcblLW+JzUme2kv0vMyMCqf1biA0p3VHncVQ RQ0h/i0p2D7vFEA30Ak6DW4TMbSzl3Qa3NYYo57VE9iKHKszuFtvschDRQPIxEvkIJO0ajNDdWWVii OiVstm8rzbPqqWRMVtQUnL3Mnhhordxu89OXhaR0TlPPHuaE2HT+A/b2usnQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii mentioned in [0] that switching to ARG_CONST_SIZE_OR_ZERO lets
user avoid having to prove that string size at runtime is not zero and
helps with not having to supress clang optimizations.

  [0]: https://lore.kernel.org/bpf/CAEf4BzZa_vhXB3c8atNcTS6=krQvC25H7K7c3WWZhM=27ro=Wg@mail.gmail.com

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 50f96ea4452a..47089d1d67a4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4804,7 +4804,7 @@ const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
 };
-- 
2.34.0

