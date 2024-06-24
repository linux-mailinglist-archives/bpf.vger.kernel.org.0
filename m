Return-Path: <bpf+bounces-32873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C491436B
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 09:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B901A1F241AA
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DC04964E;
	Mon, 24 Jun 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMpXGlOe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699B3FE46
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213354; cv=none; b=CYQaw6aiM2xP7ChIS77kwNrHSZ0V57N6k5idlVjDIGn7Px50AnjCwOnckfs+cADquFRN/UI6eEUE7UmffZ/X2E8wORKo3a6Sf3GnL+bQflEH1eMmndWBpn8Thtx5hUGhDsiVV3x6CTi+LgPKPBL/hamC8HDr3OPACUWVoNcTQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213354; c=relaxed/simple;
	bh=82wJZCCqun4NOECCHgaJY2tZeV3dAOO/UhnSbnhFick=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1sSOAj2pGoLJTW46o8XAIda7rCCsIIXctCy31lfLRHPGieWtdC4VS+lfioRQ2eh49w7Z4jUiefpg3PXSVw6j+nL2x+lFmYm47/dxa+cnMjqjuU0LhSktusNwEa+2NSCXbqRj9iP586lW2NVp+BPTLggMbS9BcqnNE5zf5GjGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMpXGlOe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6fe617966fso151690666b.1
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719213351; x=1719818151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MvQpjgF5V7L0Z8FK12wktdTvS6a/j/HLvzrnm+Uzm4=;
        b=MMpXGlOeoj7Qz1hjDnQ9wlV2Z06W+qJVtI56/nYsK17pXy5AKRmwSgV+PaQCAgt9k7
         a5oQf21ppq4CV9krfurTmfXjf72tqVfTqxmJ7vfCDjRg+zpVuKmaoMenKXKOXLDvLS4C
         AYWN86qj8Exw352pLD3z7ShOntdRy3SlVqfQYt9F8wgUZx+7TTxAH5aLzI354d/LXzaZ
         vZmmLnFUeznWkrfhEqIPcB5HDTeZ1FnoSL+KPVtI5my1w6iGM6HjHILyiRSRUUOnkP2r
         6g8rsL+c3QPDGsdogXGFu+IgJ60g8PYgN7qcmgpuy/UoX/tWIfQSdaJnvBb/lb3++UIo
         LRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719213351; x=1719818151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MvQpjgF5V7L0Z8FK12wktdTvS6a/j/HLvzrnm+Uzm4=;
        b=qJyl9a1W6UKhcZihErhF5B7U62mI8gxpGb8hb3Rv8tTFHRuQuYRcaYjjYSpXWBBX5E
         ZFKMzm8AZCWK05hXyqw2zmPpf0aI7xiGugqJF24P8d9f2taQtvmdnM5XS/Dfyk9PT60f
         zcFE4ukKztXnDFRHR/Zro/BGD9hcXJCwFn2nFY7QC3uuCW3oXcjmWAdU1in0liimefmR
         1O/NzLck3s0m8/AmWFqMau9d4HJ21j2Ep+JItJR3k4rS2bWghun14lEP5hFR/o8Ua3Br
         mrpBZ9VFhfXHD5NRZ/TJzX3lAoc/9i3DpLSbq4iaLIPCFvPGdNhCuvTZV2+uJGdDnOAQ
         zCYA==
X-Gm-Message-State: AOJu0YyDaafKr45DTTV+dcqWB3NFsi8T1o6DHtyXcRF5BzJvWF/WDSzj
	1KLnrjFRH16Vb5iKAh10eOKIEti5Zy5sgQSvVVLtzpkJRXEIsaP0
X-Google-Smtp-Source: AGHT+IGtvM6bklXF6TFZ2YL0/J3tCJXDC2ADfcXwpbZF8jpetmGuN/RK844ir9RobJSfEcTYQiXNuQ==
X-Received: by 2002:a17:906:fcb0:b0:a6e:ffa2:3cce with SMTP id a640c23a62f3a-a7245b851aemr204098866b.41.1719213350962;
        Mon, 24 Jun 2024 00:15:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b4ddsm377080466b.67.2024.06.24.00.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 00:15:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 24 Jun 2024 09:15:48 +0200
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/2] bpf: verifier: use check_sub_overflow() to
 check for subtraction overflows
Message-ID: <ZnkdJCyFlENgSDS2@krava>
References: <20240623070324.12634-1-shung-hsi.yu@suse.com>
 <20240623070324.12634-3-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623070324.12634-3-shung-hsi.yu@suse.com>

On Sun, Jun 23, 2024 at 03:03:20PM +0800, Shung-Hsi Yu wrote:

SNIP

> @@ -13428,15 +13409,16 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
>  	s64 smax_val = src_reg->smax_value;
>  	u64 umin_val = src_reg->umin_value;
>  	u64 umax_val = src_reg->umax_value;
> +	s64 smin_cur, smax_cur;
>  
> -	if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
> -	    signed_sub_overflows(dst_reg->smax_value, smin_val)) {
> +	if (check_sub_overflow(dst_reg->smin_value, smax_val, &smin_cur) ||
> +	    check_sub_overflow(dst_reg->smax_value, smin_val, &smax_cur)) {
>  		/* Overflow possible, we know nothing */
>  		dst_reg->smin_value = S64_MIN;
>  		dst_reg->smax_value = S64_MAX;
>  	} else {
> -		dst_reg->smin_value -= smax_val;
> -		dst_reg->smax_value -= smin_val;
> +		dst_reg->smin_value = smin_cur;
> +		dst_reg->smax_value = smax_cur;
>  	}
>  	if (dst_reg->umin_value < umax_val) {
>  		/* Overflow possible, we know nothing */
> -- 
> 2.45.2
> 
> 

could we use dst_reg->smin_* pointers directly as the sum pointer
arguments in check_add_overflow ? ditto for the check_sub_overflow
in the other change

jirka


---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3f6be4923655..dbb99818e938 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12720,26 +12720,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
-static bool signed_add_overflows(s64 a, s64 b)
-{
-	/* Do the add in u64, where overflow is well-defined */
-	s64 res = (s64)((u64)a + (u64)b);
-
-	if (b < 0)
-		return res > a;
-	return res < a;
-}
-
-static bool signed_add32_overflows(s32 a, s32 b)
-{
-	/* Do the add in u32, where overflow is well-defined */
-	s32 res = (s32)((u32)a + (u32)b);
-
-	if (b < 0)
-		return res > a;
-	return res < a;
-}
-
 static bool signed_sub_overflows(s64 a, s64 b)
 {
 	/* Do the sub in u64, where overflow is well-defined */
@@ -13241,21 +13221,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		 * added into the variable offset, and we copy the fixed offset
 		 * from ptr_reg.
 		 */
-		if (signed_add_overflows(smin_ptr, smin_val) ||
-		    signed_add_overflows(smax_ptr, smax_val)) {
+		if (check_add_overflow(smin_ptr, smin_val, &dst_reg->smin_value) ||
+		    check_add_overflow(smax_ptr, smax_val, &dst_reg->smax_value)) {
 			dst_reg->smin_value = S64_MIN;
 			dst_reg->smax_value = S64_MAX;
-		} else {
-			dst_reg->smin_value = smin_ptr + smin_val;
-			dst_reg->smax_value = smax_ptr + smax_val;
 		}
-		if (umin_ptr + umin_val < umin_ptr ||
-		    umax_ptr + umax_val < umax_ptr) {
+		if (check_add_overflow(umin_ptr, umin_val, &dst_reg->umin_value) ||
+		    check_add_overflow(umax_ptr, umax_val, &dst_reg->umax_value)) {
 			dst_reg->umin_value = 0;
 			dst_reg->umax_value = U64_MAX;
-		} else {
-			dst_reg->umin_value = umin_ptr + umin_val;
-			dst_reg->umax_value = umax_ptr + umax_val;
 		}
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->off = ptr_reg->off;
@@ -13363,21 +13337,15 @@ static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
 	u32 umin_val = src_reg->u32_min_value;
 	u32 umax_val = src_reg->u32_max_value;
 
-	if (signed_add32_overflows(dst_reg->s32_min_value, smin_val) ||
-	    signed_add32_overflows(dst_reg->s32_max_value, smax_val)) {
+	if (check_add_overflow(dst_reg->s32_min_value, smin_val, &dst_reg->s32_min_value) ||
+	    check_add_overflow(dst_reg->s32_max_value, smax_val, &dst_reg->s32_max_value)) {
 		dst_reg->s32_min_value = S32_MIN;
 		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		dst_reg->s32_min_value += smin_val;
-		dst_reg->s32_max_value += smax_val;
 	}
-	if (dst_reg->u32_min_value + umin_val < umin_val ||
-	    dst_reg->u32_max_value + umax_val < umax_val) {
+	if (check_add_overflow(dst_reg->u32_min_value, umin_val, &dst_reg->u32_min_value) ||
+	    check_add_overflow(dst_reg->u32_max_value, umax_val, &dst_reg->u32_max_value)) {
 		dst_reg->u32_min_value = 0;
 		dst_reg->u32_max_value = U32_MAX;
-	} else {
-		dst_reg->u32_min_value += umin_val;
-		dst_reg->u32_max_value += umax_val;
 	}
 }
 
@@ -13389,21 +13357,15 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
 	u64 umin_val = src_reg->umin_value;
 	u64 umax_val = src_reg->umax_value;
 
-	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
-	    signed_add_overflows(dst_reg->smax_value, smax_val)) {
+	if (check_add_overflow(dst_reg->smin_value, smin_val, &dst_reg->smin_value) ||
+	    check_add_overflow(dst_reg->smax_value, smax_val, &dst_reg->smax_value)) {
 		dst_reg->smin_value = S64_MIN;
 		dst_reg->smax_value = S64_MAX;
-	} else {
-		dst_reg->smin_value += smin_val;
-		dst_reg->smax_value += smax_val;
 	}
-	if (dst_reg->umin_value + umin_val < umin_val ||
-	    dst_reg->umax_value + umax_val < umax_val) {
+	if (check_add_overflow(dst_reg->umin_value, umin_val, &dst_reg->umin_value) ||
+	    check_add_overflow(dst_reg->umax_value, umax_val, &dst_reg->umax_value)) {
 		dst_reg->umin_value = 0;
 		dst_reg->umax_value = U64_MAX;
-	} else {
-		dst_reg->umin_value += umin_val;
-		dst_reg->umax_value += umax_val;
 	}
 }
 

