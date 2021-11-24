Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DBF45B41E
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbhKXGFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhKXGFi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:38 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C596C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so1640983pjb.1
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jm2kyBTEUmcq4PhVPwSiHCfzkpWfB+jxdd98MlHtrg=;
        b=ZtDB57yeDC9XzxPHyMJWval7ud18Yc/D8vjQeea8ajy2vUdZt6Mp4z8ftsAdLe8kmm
         1TJNhS1X+WDqVk947O9+OP0pZB+X6SYjPXfH+z/5OB9F1uZqcUMsCOtqWRVwduWaaPty
         59x+r5+wrXMyCBzx1ItgwfPviwS3lSj3nrOw969+mkONoFH554B1HT4wBWDC4mPkvZXR
         Z1gKZ4idHDw5DicYfn0wNkpc7E2FXExrAbE1MhE6lmoOKK0PlzsgiCBEnBM3sbarQYj3
         K5s3hAowxfo69pBn2meLc5MFogiaoJPBAzM/jPFHkC01JaxazLIpkXYZK0MoIO7GooXJ
         cpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jm2kyBTEUmcq4PhVPwSiHCfzkpWfB+jxdd98MlHtrg=;
        b=rQnWeQXJkrDo/aK9tdPwP4pVRLQ9nsHMKV09dln0U1xCnxEua5LNYZM8PZBVWX1Ex2
         8xzmR0EdsAEHfkFvQfFRqKigxX2rwgPLWx8IDl2rv73VBSLd1TJUN7ZSM50SVDMH92fN
         VfFI4LHBbKyvf9XYZX2UBYrmvXk/PME0LmxYOfVfB7/GyxagglHOBl0SVvP30nWUOwUa
         x8cKTP1fA6Zyu80DLSs0dKrr5uIcKMd8JoBVb/fSb/CXrAjSIrOl7VxTT6r378cqZF87
         uazLJuxN4E0zyLli7SQoyQJBVkP6izEx2cDzONGrC4MBMFdG0mXO+S5f5tVPAl/UWtRS
         TXXw==
X-Gm-Message-State: AOAM531iRC0tFH8LC0FjAqUeN2oMKVD62IEa1V63w6bnLipIoyFflm2z
        2NnvMMBYe/xnBuR0P4KFm1g=
X-Google-Smtp-Source: ABdhPJxud8TjWaCOXkw9tz5W34TuNFz5puMWwao9Za5DSoGfP2Thw6P21PeRbXN2g6VAn1pAPKoadw==
X-Received: by 2002:a17:902:7b8d:b0:143:95e3:7dc0 with SMTP id w13-20020a1709027b8d00b0014395e37dc0mr15310849pll.21.1637733748939;
        Tue, 23 Nov 2021 22:02:28 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id bf19sm3193814pjb.6.2021.11.23.22.02.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:28 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 06/16] bpf: Adjust BTF log size limit.
Date:   Tue, 23 Nov 2021 22:01:59 -0800
Message-Id: <20211124060209.493-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Make BTF log size limit to be the same as the verifier log size limit.
Otherwise tools that progressively increase log size and use the same log
for BTF loading and program loading will be hitting hard to debug EINVAL.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0d070461e2b8..dbf1f389b1d3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4472,7 +4472,7 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 		log->len_total = log_size;
 
 		/* log attributes have to be sane */
-		if (log->len_total < 128 || log->len_total > UINT_MAX >> 8 ||
+		if (log->len_total < 128 || log->len_total > UINT_MAX >> 2 ||
 		    !log->level || !log->ubuf) {
 			err = -EINVAL;
 			goto errout;
-- 
2.30.2

