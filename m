Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0A2633FC
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgIIRMy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbgIIRME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15066C061755
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so3790887wrs.5
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Qf5LrUrrFDb7ZG/DC+Ibysm2jzcOs3sVRYjuHbV+04=;
        b=GDFU2LGgdjMha1TD0vFTTtbkYnaQoIiJAPzf1ulLdpz6XzZoet4IolJBIFgXVuIMCO
         hjLzK3Wp0IfIFtakpB8hhzblwj4swDV4zEKQDpAFL7L3SJWxDIwcgPHPX8havDNcNtyr
         KQoO8RyUh3Bp2xQi8cqxul4OTWWU9uDgJ5+1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Qf5LrUrrFDb7ZG/DC+Ibysm2jzcOs3sVRYjuHbV+04=;
        b=YExSA4bEpcnZDtteRxui86eeUyjnRfLrzpYZS6reZAYX/VeDHuXHFl0tWogOlvFqwj
         qqS4f7PswaafnhDWvsbEEDMdKwyY1JHMpBMU6dMOPMPSUH+llEcxa+6PwaBkXbtu+hEo
         +gdrushMRabeBxJxy0HdQNMH9EahOvXDEBIlvgVjDExxC+F0rI6aAGZtao5pyzt2qUEN
         Re26c7+ioxzM9gxYVQLlr8k56UzLkKdfin7/OtUMnjb7Uz8eejQoArfJEzdubfINOIkt
         z5/uNeHn/D11NUe/kxVwiRkq6Ngjht6ybbWc3M6H8bApRnKmkxnBQuws8ZziepkIUWnQ
         iVXA==
X-Gm-Message-State: AOAM533vSB9erOoegb6EMzqMp8BJZ3MDeJZBH2I1a6+QNGyI8vNQJ97M
        EuGxYfp0Xp2TODIOixkOymMd3w==
X-Google-Smtp-Source: ABdhPJx5/7QTW+saqHfm1D/y4OoyoQUaqsLOKHVrJ2P6dEI9Dlnbr+zFTh8IkWPHDadHJ2xUJxNVBg==
X-Received: by 2002:adf:f50a:: with SMTP id q10mr4785818wro.319.1599671522710;
        Wed, 09 Sep 2020 10:12:02 -0700 (PDT)
Received: from antares.lan (1.3.0.0.8.d.4.4.b.b.8.a.1.4.5.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:e541:a8bb:44d8:31])
        by smtp.gmail.com with ESMTPSA id g131sm3746743wmf.25.2020.09.09.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:02 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 02/11] bpf: check scalar or invalid register in check_helper_mem_access
Date:   Wed,  9 Sep 2020 18:11:46 +0100
Message-Id: <20200909171155.256601-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909171155.256601-1-lmb@cloudflare.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move the check for a NULL or zero register to check_helper_mem_access. This
makes check_stack_boundary easier to understand.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 814bc6c1ad16..c997f81c500b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3594,18 +3594,6 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
 	struct bpf_func_state *state = func(env, reg);
 	int err, min_off, max_off, i, j, slot, spi;
 
-	if (reg->type != PTR_TO_STACK) {
-		/* Allow zero-byte read from NULL, regardless of pointer type */
-		if (zero_size_allowed && access_size == 0 &&
-		    register_is_null(reg))
-			return 0;
-
-		verbose(env, "R%d type=%s expected=%s\n", regno,
-			reg_type_str[reg->type],
-			reg_type_str[PTR_TO_STACK]);
-		return -EACCES;
-	}
-
 	if (tnum_is_const(reg->var_off)) {
 		min_off = max_off = reg->var_off.value + reg->off;
 		err = __check_stack_boundary(env, regno, min_off, access_size,
@@ -3750,9 +3738,19 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 					   access_size, zero_size_allowed,
 					   "rdwr",
 					   &env->prog->aux->max_rdwr_access);
-	default: /* scalar_value|ptr_to_stack or invalid ptr */
+	case PTR_TO_STACK:
 		return check_stack_boundary(env, regno, access_size,
 					    zero_size_allowed, meta);
+	default: /* scalar_value or invalid ptr */
+		/* Allow zero-byte read from NULL, regardless of pointer type */
+		if (zero_size_allowed && access_size == 0 &&
+		    register_is_null(reg))
+			return 0;
+
+		verbose(env, "R%d type=%s expected=%s\n", regno,
+			reg_type_str[reg->type],
+			reg_type_str[PTR_TO_STACK]);
+		return -EACCES;
 	}
 }
 
-- 
2.25.1

