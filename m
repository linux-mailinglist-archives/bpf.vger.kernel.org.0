Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD695B0884
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIGPZJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiIGPYz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 11:24:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9911F2FA
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 08:24:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e20so20916511wri.13
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=KrME+K4nTDXLVQBzQgWW+HAUAsW/PctFtvKraH0dD+Q=;
        b=JjMkfmZe4PxbLFUF0McSn4iAOI0ncNwh1tJnbGPqRMk8HGEHF9h5iswUIntLhq0cyl
         0dd098Sp9hF4CXd06gRxBpSag4tzCcSdmv2uQ2LIAlDRHW4tRs0ArhyPKkW1N/PvSCmt
         QtacrpsRDm35DGO4mClZSvLhQ+tke3QbnzKvDiyZunasqzQLp8kcdhRYD/HTzEdlgTr+
         hyrKW0v5wouxmPBuDFnpe8v8glK7tt+SL5r8tyzUlR81Wo4lKZ8TCIpnPjVkdTdNfhL1
         CmIebjLjbqBOsVoL7GHel7iLldCLiwzBCTv2PDPWyl2vO40wtS5d+aGhen/zeXUePu5I
         IUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KrME+K4nTDXLVQBzQgWW+HAUAsW/PctFtvKraH0dD+Q=;
        b=u4L0i3xdk5Y+H+VnhbqmlSoITXTxjfYRdsGb3/zLoY9tcCGlu9BPsySokifhPYmta1
         O97IVGKUHyzpsLGczlbwokdEWGKKF1dJNl2/bWjQQLW86IWaY5TmsmohrgA8su0ikm1+
         xvm2rzUxI9B1jAjkdXz7TXgQPB1sZgd1dwc9PG9Zln91gBQWAcQzvDXGHmCAhfsyEqAE
         2pvvjz+mAU9r3QSsfqQo1gq6cXCu45SyKcum97S1Iu0qbep/FhisTnyW6spUktBKtZuF
         TOcims+LlhiUxRp1UxM7jMjrGEKyI+qnVl7fR61mLQOe1H+COLC0x02CB8s/YGrs1LwT
         mh1g==
X-Gm-Message-State: ACgBeo2UMP1nrQ069G1C9hBOaD5UYLMiIRtcIxcYmpkqg/oKGKbSMkFo
        qziYbbVrAB3ebPEVcH95VLIibK4Y5s28
X-Google-Smtp-Source: AA6agR6hivNN5nTAPmOcAvGClc4Xq9ClB1+1jzZ7aume3JagkF4JYeUpFB4atcnpmzRysd34ePibEA==
X-Received: by 2002:adf:eb8e:0:b0:223:a1f6:26b2 with SMTP id t14-20020adfeb8e000000b00223a1f626b2mr2497000wrn.216.1662564273562;
        Wed, 07 Sep 2022 08:24:33 -0700 (PDT)
Received: from playground (host-92-29-143-165.as13285.net. [92.29.143.165])
        by smtp.gmail.com with ESMTPSA id m18-20020adff392000000b00228b3ff1f5dsm12697493wro.117.2022.09.07.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:24:33 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:24:20 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, memxor@gmail.com,
        Elana.Copperman@mobileye.com
Subject: [PATCH bpf-next v2] bpf: Fix resetting logic for unreferenced kptrs
Message-ID: <Yxi3pJaK6UDjVJSy@playground>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sparse reported a warning at bpf_map_free_kptrs()

"warning: Using plain integer as NULL pointer"

During the process of fixing this warning,
it was discovered that the current code
erroneously writes to the pointer variable
instead of deferencing and writing to the actual kptr.
Hence, Sparse tool accidentally helped to uncover this problem.

Fix this by doing WRITE_ONCE(*p, 0) instead of WRITE_ONCE(p, 0).

Note that the effect of this bug is that
unreferenced kptrs will not be cleared during check_and_free_fields.
It is not a problem if the clearing is not done during map_free stage,
as there is nothing to free for them.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
Changes in v2:
 - Make commit message clearer
 - Change commit headline
   from Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
   to bpf: Fix resetting logic for unreferenced kptrs

 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 27760627370d..f798acd43a28 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -598,7 +598,7 @@ void bpf_map_free_kptrs(struct bpf_map *map, void *map_value)
 		if (off_desc->type == BPF_KPTR_UNREF) {
 			u64 *p = (u64 *)btf_id_ptr;
 
-			WRITE_ONCE(p, 0);
+			WRITE_ONCE(*p, 0);
 			continue;
 		}
 		old_ptr = xchg(btf_id_ptr, 0);
-- 
2.35.1

