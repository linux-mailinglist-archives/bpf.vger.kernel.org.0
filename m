Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600265FD4C1
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJMGYm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJMGYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E02BDF
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c20so960491plc.5
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRQPVIx6PuDuYOj8sgIpj99BmoQRHkLc10CGGLmMseo=;
        b=ZtLne4krRtBs7dPi3kWjy7Wn4iRLXdCTHfaeWHIUgGNt7sJj86aCcjJsz21sXjpNAZ
         cGv5EyPWjNx7R6F6jffXWJElfF6w/6VfNfx+m26S69hkKi5kbyRjn/S0Dabms+/xDHWO
         JIFcoP46XrtBArHX5UeRPkEQKgjHMBhqhGt3gIZzfBr3o6sZRpEIqNHasWiYRv6yjgfa
         iXaCg2UpOpJ6AFgP9xoa+35oQxqn40i+OB48HbpkVNPWwX7XeqitU4Z859SYqwKT0PNY
         ylxzSuNr9LwuMUYZqNd9ombhr0bYleTPvSjH0KoCtrm3T6mHR3joBy4SvRKyJXtxebXH
         +Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRQPVIx6PuDuYOj8sgIpj99BmoQRHkLc10CGGLmMseo=;
        b=PN6vK0c9bA664mzAMM++dEovAT3sWGUoarQcx/UkhwvONoiCPcCRZMyYa3Cg0rESYZ
         WDKFpW3zQVgLrw7iod9CPivRYZht0iiVn1HicYj4XuCeXLjknA7bj9w9ra0hFa4LNtY0
         4tU/1n2gQyoMrR9RStm7rZQsiy9sIDwJiXKKjaL7iqZIXpqRfbqJzVVhYvFE0i/AqdYq
         A9aZCAbf+AQO6d2B1L6dHS+F9XXIq6XXTbAgkQVJmnoSINsyd94PctVQnOeOGTXtVqS4
         mJowkzmhv5sKNlb1xXaUawFKnQp1MGCqSouPxZjR0Y9OoHnakrzMGwni2hq/IJe9RrI6
         UMfg==
X-Gm-Message-State: ACrzQf2W+oN9CKCvhcFWaEgYbp2VDlKgjVTMX9M0kZV5Gt9C6Gja+2LK
        WswvFRvbmqLqQZ+oDko3zpf/ICwLgew=
X-Google-Smtp-Source: AMsMyM5XAnaDwxur28QPzIy722/jSofz4/Aq+wkxrYp1K5ev8qOA0PF/NLCdyyalRkkJwIw7YN38rQ==
X-Received: by 2002:a17:902:e952:b0:17c:2eee:c0ce with SMTP id b18-20020a170902e95200b0017c2eeec0cemr33540262pll.145.1665642275654;
        Wed, 12 Oct 2022 23:24:35 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090a300a00b00205db4ff6dfsm2452274pjb.46.2022.10.12.23.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:35 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 21/25] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Thu, 13 Oct 2022 11:52:59 +0530
Message-Id: <20221013062303.896469-22-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; i=memxor@gmail.com; h=from:subject; bh=247d4B9qqF66djy67fqpsfgFwM2wi6jr+u26OstQgQ4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67E4MDc+dxx7e88DmOh0xx3H5WX9np9u8nAh0Wl 2SLYHzGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euxAAKCRBM4MiGSL8RymEMD/ 9aJgrddK8bro/Z/uNJlvLq6g63cykUvM46Sl05Q3XxWqN675n4BvaiTygxrNhguBpGg8zbovqJCukP M3TWQyK0bj2rcQ5qoWbTF4p7MeLeQKJsea4A9ez+riAJQUGiQXIjeQfoUrQYrcS1pFKBu31QP0+CT3 dq1aTCEv3fB/AQOng+6SGAmahXkLnfdnT/JlhjHgsomQvqeK6gfosD0+KSfp5n/dez1q+oHMaYabPB q/uQcsAZUlzgb6HYnNEaVtW/WnSRRXXtMbDhxRZcTDDt1p5zCZAj7NDw4IG5vKKd39k6ASnk/CpoE+ pdrT2UWRxJaYKYPksQZLNQFubEA+wCVts7ibcwXsyrdYIGOajrI6SzwbN4LUEgRRbdU03dg68jDAFO hRkwvnvo5g5Zbl+ZBdDO6J/AukiW8wOLc9UjX9UepH+DFcsrujIMI1Kgg54eGQrGP537j9vIgcMVTU GRtO5362OvEA0z49drq/ROekpbvRL4vUJpvuN1NOQPO4dx9+f0bXnW8MrCo698rGPDbS9BRi9/Im3q UsFH8BTN73OljGcyfbJwrznH1AtDvT2uqrfO0tS8v460ty4QiZx/wa9UgNsPr+IAZc3ZYMpCfcN1La xmJSqfhCCD7PZ7oEbispEi2foKDOraHzHmjiiGBKpR5XUXn/NXPO1aOK9tZQ==
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

bpf_list_del{,tail} helpers return a local kptr with incremented offset
pointing to bpf_list_node field. The user is supposed to then obtain the
pointer to the entry using container_of after NULL checking it. The
current restrictions trigger a warning when doing the NULL checking.
Revisiting the reason, it is meant as an assertion which seems to
actually work and catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a4a806cb68dc..a8cd04c18ac5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10612,15 +10612,20 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
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
+			if (WARN_ON_ONCE(reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL | PTR_MAYBE_NULL)))
+				return;
+			if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+				return;
 		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
-- 
2.38.0

