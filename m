Return-Path: <bpf+bounces-30703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242058D1337
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 06:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552F51C20F10
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 04:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E117C6A;
	Tue, 28 May 2024 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7s6NEW7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6B17BD6
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869447; cv=none; b=T9aMFmQH0+iGoQbGPS11h4G+Ks+peBxW1ilvNv3OnkFNTt86X2tr6SDADGGyrHJsz4JHBw7yUsx9optzd9nun44sZ9IilBIvc89G+bGEjWHHMVlUr1iJBH+COpCn9U66fOuVZB7NZR9yEFgvcfh6UPTNb8XhUPVHUs3/mQneeY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869447; c=relaxed/simple;
	bh=QIJ1fBoBjuXIRHSDSPzfUWRQlC5niyfwgy+ObH6Xs1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJ0C5pGev3Y7LOMZAxcpzuOiJwaHfeTCpnJ8RBv5BTwOP0YrqADSByFHaA8fP4i7vbnhVTjQoTpQZDWR5Vy54qyndaRleY9zXjZ4zDojGZJe/VeJnvr0AKJhI8I5VKfGU1y94Kd0oYYvYfYyDPmspb4p5qdQCGl068U0DC+F3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7s6NEW7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f480624d0dso3257535ad.1
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 21:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716869446; x=1717474246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TQ752EyCh9fFYBo8OGzWkVIrzN5As7ijtVXtP8RxL90=;
        b=d7s6NEW7kiM5+Cg+m+JeIzJC/QsIE5UK5mp6/E+nu8+K/n6LJpAim+wpnFUZEFTnxg
         vgINnpHmh+IERbBw52cbWj6dflW5gjy24iIsPjgYrd+i4dCiE/fEKEUhsFfKGYMIKUe4
         ttR16RS+HS8X/oybPHhOS2kSdIg3QiHoBH4xUNIyD6XLwBr5hvt65WurIg/Lmr+7LM6+
         K2WJsNQh2FBY7eDOFMbPCSp9wQ7ydswsuviV4v+8ZXKjeDMAfMhgnKLBbCte+vqruKQr
         LaZSk0VkcLhr3aq+6LjBp5NQ9zsNXp1NBvncklP4C/FkRgpA62YA12mIVUWNQx3yGmmQ
         CEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716869446; x=1717474246;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQ752EyCh9fFYBo8OGzWkVIrzN5As7ijtVXtP8RxL90=;
        b=WCPDBbx9JzUmfcFDDYHHdKAboW8MG7P6v6ffOaREsYZZFTmzsQiE/v2MTCLCBIpyhy
         H15wLl/n0aRk7aOyeNjOimmTkNl2mhiJe/LDzD3TRiRsxvEfz4S/1SNA2DCa5rF2UYga
         +7cDfl9ihsD1peTI2cZhrEH/l9UJNHMpcwmEqyXz6JEiwsRlaZ1l8N14DI0PgRE1//Ag
         9J3JnQtPXWYq6sFDi7PENJcQoLDvg4c2YvYdqk2ghmYnvj1R0aW5AbqHBHG84TqnLFl8
         GoLsPg+WxztnXbsRbKFDVTOP/JmVoJOY9eUNN29lUwBPhHIjBaBO3ho+DDCTJIzxDi0N
         iq5g==
X-Forwarded-Encrypted: i=1; AJvYcCX8YzZChHKZuwHlERadVKEp4JkGt591IbXMW8aqRkKWXLVFiWF7zyJD+qWPQCxaO+TozwMdSuE6XzqyBAO4esnOokjs
X-Gm-Message-State: AOJu0YyIvbLMNAJ0v+AXoMKOEl+75Lw773N425+PflAUbAOr/wF714T5
	Jlah05OWogprJISlerb+F3Rl6qXVOyEDT+kAUHRn1ICA07xtwcsa
X-Google-Smtp-Source: AGHT+IE1YiOuY2h0YKl8PeItC3IcSELCmYLCK/Eqve/FE3lX4+CxSVUPX49LEnXM9usGuYX5UbmrJg==
X-Received: by 2002:a17:902:c405:b0:1f4:5278:5bed with SMTP id d9443c01a7336-1f45278630emr158257285ad.42.1716869445739;
        Mon, 27 May 2024 21:10:45 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9683b3sm69492675ad.163.2024.05.27.21.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:10:45 -0700 (PDT)
Message-ID: <90874d4e32e7fe937c6774ad34d1617592b8abc8.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Mon, 27 May 2024 21:10:44 -0700
In-Reply-To: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 20:11 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>

[...]

> With that the get_loop_entry() can be used to gate is_branch_taken() logi=
c.
> When the verifier sees 'r1 > 1000' inside the loop and it can predict it
> instead of marking r1 as precise it widens both branches, so r1 becomes
> [0, 1000] in fallthrough and [1001, UMAX] in other_branch.
>=20
> Consider the loop:
>     bpf_for_each(...) {
>        if (r1 > 1000)
>           break;
>=20
>        arr[r1] =3D ..;
>     }
> At arr[r1] access the r1 is bounded and the loop can quickly converge.
>=20
> Unfortunately compilers (both GCC and LLVM) often optimize loop exit
> condition to equality, so
>  for (i =3D 0; i < 100; i++) arr[i] =3D 1
> becomes
>  for (i =3D 0; i !=3D 100; i++) arr[1] =3D 1
>=20
> Hence treat !=3D and =3D=3D conditions specially in the verifier.
> Widen only not-predicted branch and keep predict branch as is. Example:
>   r1 =3D 0
>   goto L1
> L2:
>   arr[r1] =3D 1
>   r1++
> L1:
>   if r1 !=3D 100 goto L2
>   fallthrough: r1=3D100 after widening
>   other_branch: r1 stays as-is (0, 1, 2, ..)

[...]

I'm not sure how much of a deal-breaker this is, but proposed
heuristics precludes verification for the following program:

  char arr[10];
 =20
  SEC("socket")
  __success __flag(BPF_F_TEST_STATE_FREQ)
  int simple_loop(const void *ctx)
  {
  	struct bpf_iter_num it;
  	int *v, sum =3D 0, i =3D 0;
 =20
  	bpf_iter_num_new(&it, 0, 10);
  	while ((v =3D bpf_iter_num_next(&it))) {
  		if (i < 5)
  			sum +=3D arr[i++];
  	}
  	bpf_iter_num_destroy(&it);
  	return sum;
  }

The presence of the loop with bpf_iter_num creates a set of states
with non-null loop_header, which in turn switches-off predictions for
comparison operations inside the loop.
This looks like a bad a compose-ability of verifier features to me.

--

Instead of heuristics, maybe rely on hints from the programmer?
E.g. add a kfunc `u64 bpf_widen(u64)` which will be compiled as an
identity function, but would instruct verifier to drop precision for a
specific value. When work on no_caller_saved_registers finishes this
even could be available w/o runtime cost.
(And at the moment could be emulated by something like `rX /=3D 1`).

