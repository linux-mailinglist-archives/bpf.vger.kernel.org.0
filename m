Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B42C62036D
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiKGXLR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiKGXLF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:11:05 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C329834
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:11:04 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id c2so12555466plz.11
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34JwRE/hItzOhlEzOozXW/4nElB65477jrFZyMohsaU=;
        b=Xxrm63FYus2cZLN9p/ZD7ikxYlwGg6u27LrjsfKXivlwhTUHuUcWd5QmR6ruAxLKtO
         qXUGQ7Yg6GEjP6WwUqPL3ekqk1wr1H9diyJ/gi+t/D1Ij5WyklVhLLvlPqLNGNuuPqTb
         1SBcRemsigzpcH8GZ4Kmp0GCuvb3yT9TFVc035Kb+Ew2SoytQDir7S7ylTRHmP0vuRvj
         vrgPAeVj203FesMu+lFFY9eT2hYOXGTWyeA+il1rEq3Q3dI24w/UZyDdb/tuTm/Pjipf
         4XTqxTyuYB77IqD9T56qFDgmGpfttMhi1j3PTFAXlwnuQ3A/MK/Z4YCsKsJwcBQoge0v
         oA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34JwRE/hItzOhlEzOozXW/4nElB65477jrFZyMohsaU=;
        b=Kv8rNYhL19IflC/xIDfOxfYs/8LJNnm2jBTJVcrUTiW30V75wRWznQrcD8CszPApTs
         HPTh+5hisWFVK7wfSsxzQXd3uEF6LW7Bytffhwg/gGUQKSREI2Bw2daNZqQHy+9+I5IR
         bLC8VJMlkoq7E6x2HLYfGKviSDohkJPSOj0uej4uQoCugtfaI57z7v/7gxxPntYHsiu2
         /ltYtdW+9V1ST17lL5GiSjDB/50Wyqt6zFhk/31+An/xXkVe6eC6UKEoNguf7lT2GZLM
         ZcmaGC44K4cu6gz5YBTyetqqgj+4Dd43GZAsiKAD+SnBC/zwa3GFi2VA8aA0ONiIjtIV
         GTxw==
X-Gm-Message-State: ACrzQf2vsGpNO/DLra+6gp5LyX5eO5ZANhu2jyJGB36ci/c+STeSwC2a
        rH+LnNQGTZvzhGSLr3OcBYUlPtsCRQh6mg==
X-Google-Smtp-Source: AMsMyM48wkVKEjFe+laY2xwOAMymTRTsED0lKsFbJYgvmFrFeKTGHEyOQH2fVe/c6pfVVdXMkrLiKw==
X-Received: by 2002:a17:90b:394:b0:212:19d7:9072 with SMTP id ga20-20020a17090b039400b0021219d79072mr70377425pjb.69.1667862664083;
        Mon, 07 Nov 2022 15:11:04 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b00180033438a0sm5493753plg.106.2022.11.07.15.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:11:03 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 18/25] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Tue,  8 Nov 2022 04:39:43 +0530
Message-Id: <20221107230950.7117-19-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205; i=memxor@gmail.com; h=from:subject; bh=KwYI5sn0hhQ9lV7wTPXq3b80fTzA1hv0z+Cf7VRfx4k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+36QVCRIN31DsW7OAwJfdhPmPIqX5SO97Vojcj ZTXzVpOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtwAKCRBM4MiGSL8Ryjb9D/ 9TKdoU97GUhHbCVaVsVJaaaXnHrHXz0MqeuvA0XpXIXasPLAhlqsPHBNX7sFx3d21FHxE2IiELL9Kp xbgqRp99OXI29D2Z5USCj4yZGcxKkaEQ9HVACgmue/aH1N7HDRUdvhUXRMxgQ18GnBneWbWlm9XC1y iBGtB4Mh0d+80vdoO5R4pkcWtJU2k1wg4gNmF0niXAVtMsajvHWRsRMgqjIYKcn8nQSqROxfCGgkhz P0WCerCMyEuA96bn3z1QJxhfVA1KmnMeg+mYFk8O2pi/hJxM15X8xgflJS1DGCPLGrqi2blQfHARzY AXCTAtpbJhswHGW8JVuLt3frvtjWJ1HlAjxfhq3OSTY/ntu4UxrWZ734QObbHX2ntmvy2cjU6QmWJB HW+Z9dQq17PqHOSk4CZPim7G4A10NnWZWTFBeLySH0Lg8ycg2OCNLiD+I83volQZtu31HJxGRDmDxn Tqs9n7Hmp7FnpZnPJumIOJtykxZzFtch7X4AnoetwQkQSy3EXaRIW0y5Oqd48rx2/dXJ4w+s/l+eIe 9uLnw1p4EOAF1H4hlj8X4M5IQr3EmY3eMoLcZ/bInxQ4vqfy6klq+89hdSrV2JP69MyLoZoowD8Zl/ f05+O4lob5ftYU8TKG6yfmwAc1i3nCtwdDZgiv5PMOi+8Tw2ORhGHxKyTvdQ==
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

Pointer increment on seeing PTR_MAYBE_NULL is already protected against,
hence make an exception for local kptrs while still keeping the warning
for other unintended cases that might creep in.

bpf_list_pop_{front,_back} helpers planned to be introduced in next
commit will return a local kptr with incremented offset pointing to
bpf_list_node field. The user is supposed to then obtain the pointer to
the entry using container_of after NULL checking it. The current
restrictions trigger a warning when doing the NULL checking. Revisiting
the reason, it is meant as an assertion which seems to actually work and
catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7c5d9e933d97..abcb23a4c6fc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10809,15 +10809,20 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 {
 	if (type_may_be_null(reg->type) && reg->id == id &&
 	    !WARN_ON_ONCE(!reg->id)) {
-		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
-				 !tnum_equals_const(reg->var_off, 0) ||
-				 reg->off)) {
+		if (reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0) || reg->off) {
 			/* Old offset (both fixed and variable parts) should
 			 * have been known-zero, because we don't allow pointer
 			 * arithmetic on pointers that might be NULL. If we
 			 * see this happening, don't convert the register.
+			 *
+			 * But in some cases, some helpers that return local
+			 * kptrs advance offset for the returned pointer.
+			 * In those cases, it is fine to expect to see reg->off.
 			 */
-			return;
+			if (WARN_ON_ONCE(reg->type != (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL)))
+				return;
+			if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+				return;
 		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
-- 
2.38.1

