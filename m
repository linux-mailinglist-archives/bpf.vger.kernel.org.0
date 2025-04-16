Return-Path: <bpf+bounces-56025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F3A8AFDC
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 07:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381B4440B3F
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 05:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2EC22AE5D;
	Wed, 16 Apr 2025 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4it5G4F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAE224B05
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744782785; cv=none; b=cbsP+XH/MzkrjqUP3qeauz1fHYJzfVaLmqvxPCE5WWeHV1E9QAsX80J+s4b72Mgau1eshTlkuRIHxNVC4Qx1V/g+qrxonPZIBcl8eglOvKEvjwU9wXDbRDFJlZmi8SHoSNy8VfTqVuOd8MBtf3MgpZURFNewq6iq+dQEqMj6AzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744782785; c=relaxed/simple;
	bh=cYJUsqsgINWinwFf7iSqtrHzQ0ACKvleub567qWW2Hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ed5A8tyjmuSGhkPKkp/qCS0WflMJtnqfEWV/x5k7nB1LGP6MZ48DObdTF5mxDZ/YL/V/KXJyDu5GeJOAM4wahJnD8BS1rJsAnUC2dE/aohd2AzbXPxuGXx5u721UESvKI5kpsUUIZ0Eg+1tQ70A9/7hNqGGafFgiZ0O8GUze7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4it5G4F; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73bb647eb23so5714272b3a.0
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 22:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744782783; x=1745387583; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsXVti7zgiA+XVZuOBVnTzbK6+V7JyUsGyiAETDDEmc=;
        b=Z4it5G4F9cED9o5Sn+8nBofVm/LUHg7Eg5AQk4KRbYb13Iecz1nGEQZZRbz4OwQB5l
         cv2yZS2eZFDcD8Lx4skt3HBqFJr93TO+3uHp0svhvVITCCEFNSSrUWxNwZijUU+XYLvv
         Pb7qd+cbAVOs6oFRz3hdUe2Nfv0g0l/s3pM7/UztpBA8FL363hXMkeAcK+2s2cV9Si99
         TZ5mJnMPF6jDkLFqDCvMTAVScfa3jXYH4xxy8um/fwJrwR/dhSjVZ42AU0ePTvXv6F//
         Z5v3zKZporRYmPWtegXamsCxJZIL46BsQrAJ3L6IsPJGZc3TL1dM6OywpgzgGQuJjhPL
         vwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744782783; x=1745387583;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsXVti7zgiA+XVZuOBVnTzbK6+V7JyUsGyiAETDDEmc=;
        b=mxeXnQRpWq9xJH18uHptvbTRyR9AasMoEBg+lgZ/Pfqar+x8Y1FUyMSIvG36S58THO
         +7DbydlewUWOK9/xsCpmawuY0lBDPxITzujFKws8Rh1SicFu1w95+Vyg0Tsgk4RFVdYX
         RDK+CCZAFMyvoo6zvDHVoTtl7WrM3nqe2HRFThCyWaHkWZbUfvhnLckwANI8NU1dciHf
         JlCurejj3zPmXteCnW2ZN3HJy8d4qs7A4sQNUHoeaFQNcdxTJ/PCXuZ9gsr9lpW7ZPWc
         D1SIi4260Oe7G8y6agpxzN1FMQ/gj89khlbvf3Nww3rKHW/V/mhJepQ1rL3R81ZwdvSJ
         jWNg==
X-Gm-Message-State: AOJu0YxwJRlmil1qVNck11KU4pJWk9LtU92tswg4ps6v2D15Ee+yR53v
	q+eIfAYNuSCdfvN2V3OlGSGmq51lROUrkJcc6PXIxd6DiY/6uGWz
X-Gm-Gg: ASbGncvfNMrW/tjWIPZEdeq0Tcpcks3KzX/+fG685u7WYoknzPVJ9nkv+h6lY6SBoXG
	NZife1dJiBboZRvBvSPFO35zkmoNoxs1t+2tH42ZAXY7F6fS59wmDS0DVMngZybMSQpk0nzBAlR
	kFy4LIoxw++9iQrhqjMic5BRwxmXSQfan7ciIFeamUP1pP2rmJ1z+qeIDmqhUCqmfkkFitQCV2W
	WsOHTEFy13MAcYoEJzHinyaDFU1wvKFkO0/43jch680gO//78wMR98R0kl0O+gHZpf6bcfTE+6y
	TC7UO9liJ1Q21PBhOGLCupORRpXJ57Siij0NgvULBho2ndY=
X-Google-Smtp-Source: AGHT+IGkteEobQ4QfpZYKw9DnZXKixXt/J1fJBNt1jVA2msLjA5Ha9huSmZ+n8uBnHSGseTuQGT9rQ==
X-Received: by 2002:a05:6a00:10d0:b0:736:5c8e:bab8 with SMTP id d2e1a72fcca58-73c266b9b28mr833504b3a.3.1744782782856;
        Tue, 15 Apr 2025 22:53:02 -0700 (PDT)
Received: from ezingerman-mba ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2335208sm9488286b3a.166.2025.04.15.22.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 22:53:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Amery Hung <ameryhung@gmail.com>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Barret
 Rhoden <brho@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 01/13] bpf: Tie dynptrs to
 referenced source objects
In-Reply-To: <20250414161443.1146103-2-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Mon, 14 Apr 2025 09:14:31 -0700")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-2-memxor@gmail.com>
Date: Tue, 15 Apr 2025 22:52:57 -0700
Message-ID: <m234e8wt3a.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

> @@ -818,22 +819,19 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
>  	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
>  }
>  
> -static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +static int __unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_func_state *state,
> +				       int spi, bool slice)
>  {
> -	struct bpf_func_state *state = func(env, reg);
> -	int spi, ref_obj_id, i;
> +	u32 ref_obj_id;
> +	int i;
>  
> -	spi = dynptr_get_spi(env, reg);
> -	if (spi < 0)
> -		return spi;
> +	ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
>  
> -	if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
> +	if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type) && !ref_obj_id) {

If dynptr_type_refcounted is true, does this mean that ref_obj_id is set?
If it does, the check could be simplified to just `if (!ref_obj_id)`.

>  		invalidate_dynptr(env, state, spi);
>  		return 0;
>  	}
>  
> -	ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
> -
>  	/* If the dynptr has a ref_obj_id, then we need to invalidate
>  	 * two things:
>  	 *

[...]

