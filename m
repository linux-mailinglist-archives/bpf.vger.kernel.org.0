Return-Path: <bpf+bounces-37080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A7950CA0
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841951C22124
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0D1A3BC4;
	Tue, 13 Aug 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR1vT3HA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736941A4F13
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575464; cv=none; b=Yy/4t2B2Q/o8WZBSCPuy6WqZUbrHJPRMvY4mG4pz44LFrwYDFj4j5sM0T+x0/lQ7DZmUnsmkY8a1F4VNd/pBhj8dvBFxVNFjJjorpt2P349xmqHNpPMjGvSRgBT7FGilNbd04+8qVanzlRHIExMZXq2TpJLVjEKSsUKx62jtaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575464; c=relaxed/simple;
	bh=lEQwG+/jmec8jtwZy86eY5q0lAA8CNAmjnqILFheLPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g0O6uxJuL7neyGpjH+PjYfE5cvbHnMCzeBwYWP3/8fL8/8D1afHuceDHgsYAliHilYG2NvrvtqO2tlBfs1TywpU2sm0dFQL9xLjWYR+uMBD5UIV1ehykjAT1YuTazJE8WC9wXv4RUF1wVRy0Aofs+A9fTWft70OD2eqsu0eGueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR1vT3HA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so3392779a12.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723575463; x=1724180263; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vDKhwwMKdYab5vc/vut0Vz3DK55CMMHC9c7bBC/o9wg=;
        b=SR1vT3HA4Mrkevi7aZ2SQ4RY7Crgx7Q5Y6KdM3jggxfmuMosaG09bvfletLfO9nnyL
         NXJM2/+3uc9Q0hjEG/u7Lg+cTyrzu0OjqYrloB2sWtixrARBx6EsuImmUkHnfRHDNHbI
         SgY/oaA/KRpk6gw290n3QHEJSRmhmk3XNJW/PipOsdkj8YcYX/pOt00IX6ns8dCf0LIf
         C8Be0FgNN8AqmL+ylScNOzUN6N2OVh9TTYzL5RULJzUxFw8LaUaelMTxmxMa9L81avaZ
         pqOsHXRMiaxnmFhY1+PjXyZQrKOo3I0aLd/4YVDiqH+AuJ8A+9jsQECftxVVo/fBbmBh
         uJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575463; x=1724180263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDKhwwMKdYab5vc/vut0Vz3DK55CMMHC9c7bBC/o9wg=;
        b=BrqA436W6YqncXOKt+/XV284DEKyUx8S6tfD4aEk96FIQqCNDbnD4+3g88Mk3La1vS
         6/sGr33SB+OGioTzXElh7+chsYKpo4IxTaTQqJfJixXwxoJ6jnoEyqThWjJQ6zBbhgBm
         qYu7S1aBcWcDkeDRka2k98xtAMEApy3p48PQmuzzNqbi7VPtkvqtKq4TEKdSAK17zLwW
         i7uRINyflzFzlAzWFwkDDqcnSYkE5usP6FFsc+whI8yQ+Djov6hn6lHdPaG9aCXBE1cK
         UDcrW4Tzsbbg0aXPAYXL2/SI39lzQlLAIhEalKfaVbWHnKE5LhSV1SVXPTevUBkZceGl
         hPzg==
X-Forwarded-Encrypted: i=1; AJvYcCVP45PNe198TzdsdyrsqTLkrErTx8QXQ6AsUjmH0vAeocz5DQPDIQBPOjIYhqd1a7usAByc1p5H8L92NNC8eUfsV5Tk
X-Gm-Message-State: AOJu0YxZ1qbtENzMO95bNoqQmhF5pTfqMm6D//fzM/fysE93ZoKpKEJX
	KLPwRNmWNGbrmNKEAqsPMABHBDQmrBGIWMsH3QlCz3H5Xv3sy1vqXJA6XBTPkeU=
X-Google-Smtp-Source: AGHT+IF4E0Qa4ZqRNN58QzfIoN1E39QRHjIKl+Pej8xeya+YRdypyrmAmEnCxIvO4x90PLcWLXVcyQ==
X-Received: by 2002:a17:90a:474c:b0:2c8:64a:5f77 with SMTP id 98e67ed59e1d1-2d3aab8d732mr514496a91.37.1723575462722;
        Tue, 13 Aug 2024 11:57:42 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d396a59287sm1241275a91.0.2024.08.13.11.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:57:42 -0700 (PDT)
Message-ID: <dfa21bf78dbbf006ed07275a67c408a6f77ad36b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to
 kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com
Date: Tue, 13 Aug 2024 11:57:37 -0700
In-Reply-To: <2970dc12-3dab-446d-9d75-a33c2f6bc008@linux.dev>
References: <20240812234356.2089263-1-eddyz87@gmail.com>
	 <20240812234356.2089263-2-eddyz87@gmail.com>
	 <2ca49adc-2c90-42ee-b1ff-bf339731ad5a@linux.dev>
	 <b7518fdfd0a01f1eef66556b62f5e72484501eae.camel@gmail.com>
	 <2970dc12-3dab-446d-9d75-a33c2f6bc008@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-13 at 08:18 -0700, Yonghong Song wrote:

[...]

> > > > @@ -16238,6 +16260,20 @@ static void mark_nocsr_pattern_for_call(st=
ruct bpf_verifier_env *env,
> > > >    				  bpf_jit_inlines_helper_call(call->imm));
> > > >    	}
> > > >   =20
> > > > +	if (bpf_pseudo_kfunc_call(call)) {
> > > > +		struct bpf_kfunc_call_arg_meta meta;
> > > > +		int err;
> > > > +
> > > > +		err =3D fetch_kfunc_meta(env, call, &meta, NULL);
> > > > +		if (err < 0)
> > > > +			/* error would be reported later */
> > > > +			return;
> > > > +
> > > > +		clobbered_regs_mask =3D kfunc_nocsr_clobber_mask(&meta);
> > > > +		can_be_inlined =3D (meta.kfunc_flags & KF_NOCSR) &&
> > > > +				 verifier_inlines_kfunc_call(&meta);
> > > I think we do not need both meta.kfunc_flags & KF_NOCSR and
> > > verifier_inlines_kfunc_call(&meta). Only one of them is enough
> > > since they test very similar thing. You do need to ensure
> > > kfuncs with KF_NOCSR in special_kfunc_list though.
> > > WDYT?
> > I can remove the flag in favour of verifier_inlines_kfunc_call().
>=20
> Sounds good to me.

Just one more point. The reason I added the KF_NOCSR was to keep the code
as close to helpers case as possible. For helpers there are two guards:
- verifier_inlines_helper_call() function shared between
  mark_nocsr_pattern_for_call() and do_misc_fixups();
- bpf_func_proto->allow_nocsr flag.

The idea is that verifier might inline some functions w/o allowing nocsr.
Hence I decided to use KF_NOCSR in place of bpf_func_proto->allow_nocsr.
On the other hand, verifier_inlines_kfunc_call() is not used by any
other function except mark_nocsr_pattern_for_call() at the moment,
so the KF_NOCSR flag might be redundant indeed.


