Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25FA62E8D4
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiKQW4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiKQW4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:56:16 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B3657D3
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:13 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b29so3172751pfp.13
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPomuiw38Tc36JRhHYvhQJpHAo45CMYZVjWlALJ2I00=;
        b=jCXmre/Cdccl+ibrThBtWFk4fv0CZ8yAN1rRMvOm9RSUvBTu0ofgAg3ahjkwA/jc4x
         4zSL1CsG97gfWqzxHe0LbQ4iczgGk9BmdKlruQE4qaGczzG5b+t+B3WHhbiFOWAVuQjS
         LwaxBh1YIQ9/JCMZEOMsVGiaDn4Rt58ohbqC7Ux23yVNhGjn2pZLVVCcvWau9v40PX6K
         RuuxsFSGTxMP+A0by1ES2xJlvcZftKKju+9STEAFjQWZMk/21VvZHBWFBw8JlGANtNeN
         ho2Cu/zohC8HsGxzOlFZbAJwTkXkYTDEvX4H5sJ7CK5Qt4FrW1iUXP9/YG1papw8q+Z9
         VYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPomuiw38Tc36JRhHYvhQJpHAo45CMYZVjWlALJ2I00=;
        b=Q0x2MNRBuFT5hrmBCFk9eCc8cOSp7g/ptSjQlJDm9En9yQQCTai7MfBVmpaiYWGu4g
         EA+VfaBEpfXiAc49ceXO6gXw6Xm6aS8X+Mo/wNaaBNH0btUxArewxwHL5ZX7ZMTlqiEP
         dABKkmy5FrkS9PIg84Vf0Jce+xxm53MhUrFwngTqHP+xyCqXg8XOFUoOmvcJN8YSP+Ms
         HFVD3kgniJdwI4UQKGFD38pR6IL+VZICmjOThwGQ0r7LktX8uM7Q1SNrWYtFhFK8rABQ
         /hJcEQr8AFQjfjUzMhvtXGtTcdMR0JnYu3qaxhOiWu/Sj6GsHYVOie5UhNsT4Nrg5VQU
         PbXg==
X-Gm-Message-State: ANoB5pmX6YRRNjP+mk330ATdG31MfqbQeHdOd5a0Kj5CaPy345i1CWvi
        rTjoTrbKrzq6xIG893BHA8sthvQxP5Y=
X-Google-Smtp-Source: AA0mqf4xkenl+pR46635D3VWiUO4FbSFo1C6RiNfmaJ0H3aBiKa73WvNFpfh7Euw+lNYrHuwqGH1rg==
X-Received: by 2002:a63:d741:0:b0:457:f843:ffcd with SMTP id w1-20020a63d741000000b00457f843ffcdmr4106613pgi.101.1668725772366;
        Thu, 17 Nov 2022 14:56:12 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id i6-20020a626d06000000b00572275e68f8sm1659190pfc.166.2022.11.17.14.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:56:12 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 15/23] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Fri, 18 Nov 2022 04:25:02 +0530
Message-Id: <20221117225510.1676785-16-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=memxor@gmail.com; h=from:subject; bh=24iLGg5VsnwmsvtaAeQ9jk4cZGNEIECN8xis7P+9mPQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkc+mohHswfHDzYNGMTg+MLWeTNlIOxWTD6wKYO D3uPfdGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5HAAKCRBM4MiGSL8RygUbD/ 9wOVyivjJwrY1UMdpWeJEmPAr6JLmujgPSVTNUSAJIDAyd0l74jYYsSe4a2zTn5tQf1BaHktsP9KYz U7maV2CuoxHT2IxHzl11HhR4O4HuNfGB0TId685o8qOBDgidih6wioXHFmkvTmxBIRDhTOorimgNV5 QNN+jgMWTdwm8XtEswAZ3MDxCUIgPk5867HrFixS2zgfxdbqxTMxM7tBn09zk+dKSxMJt7ralVOmH7 4vNxdDG2w/65fzIwljH5oe0OVE8vOoejVJRPxLawlw76/QczJLu5Sjs+USB0a8NJYqTK/LfkwyIqKd yIeYKUVfCLJLkApf9Nzy42OkLkceOmd+2+gsvCleVifTId2Lem9v347HbfE8GgZA/c+NLa2+8pwiae poeWAhEDExOkfYi9bQnvXDvWI0PH5JEwb8rIRbhq/BLLGYO4duVqkN1myMBvlOtstq9aEB0WZd9Sql JQ7l9FrQyoa+MCmKhMyzdQDhhrPIvwEquCYhdJ02wX0eCMYV/ev7A8L2iHbXGtDxLVdDxY2J3YOyGg uOdQ1ufsTxEP4+YyvOxEHEH01cQhQbyVxQYv0Q20Y6eEYW6CR6ni/DkX6izNV7HvWLuVzFUe4WnGJw sitk5BKvAN0Uaa3ForvwScc9pkICnXzmUPUQFtWPT4Pa/uqkCsuzaGO2pktQ==
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
hence make an exception for PTR_TO_BTF_ID | MEM_ALLOC while still
keeping the warning for other unintended cases that might creep in.

bpf_list_pop_{front,_back} helpers planned to be introduced in next
commit will return a MEM_ALLOC register with incremented offset pointing
to bpf_list_node field. The user is supposed to then obtain the pointer
to the entry using container_of after NULL checking it. The current
restrictions trigger a warning when doing the NULL checking. Revisiting
the reason, it is meant as an assertion which seems to actually work and
catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b96c525fa413..8951f50ae918 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10790,16 +10790,19 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 {
 	if (type_may_be_null(reg->type) && reg->id == id &&
 	    !WARN_ON_ONCE(!reg->id)) {
-		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
-				 !tnum_equals_const(reg->var_off, 0) ||
-				 reg->off)) {
-			/* Old offset (both fixed and variable parts) should
-			 * have been known-zero, because we don't allow pointer
-			 * arithmetic on pointers that might be NULL. If we
-			 * see this happening, don't convert the register.
-			 */
+		/* Old offset (both fixed and variable parts) should have been
+		 * known-zero, because we don't allow pointer arithmetic on
+		 * pointers that might be NULL. If we see this happening, don't
+		 * convert the register.
+		 *
+		 * But in some cases, some helpers that return local kptrs
+		 * advance offset for the returned pointer. In those cases, it
+		 * is fine to expect to see reg->off.
+		 */
+		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+			return;
+		if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL) && WARN_ON_ONCE(reg->off))
 			return;
-		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
 			/* We don't need id and ref_obj_id from this point
-- 
2.38.1

