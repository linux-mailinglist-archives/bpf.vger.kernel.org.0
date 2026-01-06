Return-Path: <bpf+bounces-78007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B21CFAC20
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 20:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19976301A4FB
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215CB2FD69A;
	Tue,  6 Jan 2026 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgLJapAX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A562FE078
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728591; cv=none; b=ASa4FDzYoh87sN9aUdXub9foToUMB/SAJo2hSLuW9ELkY/K9O99I/P44Ahw3A5484lFtaMciyWQ3LH/btSv3DTPEAvVVGCm+xIpFHBNFu1n6SdGZITnIM5QTZd3hUREnfk1Dj2qrsibwbKa6B3b3YY0cZXMA4KzQLqwRwGmC6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728591; c=relaxed/simple;
	bh=cQkCwpLfMHgFECHSgiTdiHx6C721NMxhQ4A1ljBuofk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXd8T8dDRr1Jl7r3wKEvlllDHsDZSTx8kZ5MhQo2zPUgpbpzk006D/aKZ1bqJUSBBR4dRQdP6adfOO/+hWfQ6XB0ind6wkAJk4mcS7cLGKExOge096rqfj0D6qDTj6lKMmNVECXeh4DCl3JhD/067nVQS/NQ6H90JNiLim0u87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgLJapAX; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6420c0cf4abso1240851d50.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767728587; x=1768333387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7/Azh4zwRmV8HgO8z+Rp5x3OtBJOTRULAPqMlyrXYk=;
        b=XgLJapAXBoPNglc9NVDTvu95shZPCAhHj1hmfgj0iyZXPK7uDzNetNrK+LZHzbGluR
         gcbVt0pEDYsKvY/Gszc+Qeee0PRVcArlsJ3sYCgGw4PfA7bXNYNRPXpaDmEolsSDmnyS
         ztIaHlPFC4g46Inop5IcIeKxSJB1clj3GxFfmxhISt4BFZGYWAO94akImL9Ta9FpRqr3
         a5ItzFCtDMvk7yhiVu68gycnrZHhh3tEdGdb7vWINn32kOumPSWMtkIOl7cA9sVZgnSL
         Ij+Cr00ubqnp5I5sayUD3BrDtgCJD6O6DLF2MlU6+iewP3KTwFNZHYVqDESVeZOFYNUa
         2f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728587; x=1768333387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p7/Azh4zwRmV8HgO8z+Rp5x3OtBJOTRULAPqMlyrXYk=;
        b=HdvdzQTWkjtP1PnXyr7hgZqr0nYJZ1w4hv4INlOxmZeKVMtroXdrSVS9pzPIPVvcNe
         4UClbo3hTH+0UVpB4u4qqgChWPjS9eO0tmXoG+u2LORUloy+katvwnQGKs/DZ9aI4htc
         tDD8oWfMe9A44d0pGOSZ2gg58x4gaTSSrNEb5c6es2UPERQbK+YHiUJIfZEDmYLm+xhD
         tqCOXZleah1nKdLFUURFB3T5n21dRrC+HAkaBZuHVKKnOtyS/5E+m48Tpmo46/0Faw+p
         U8h70OmmUtcMagd5mrbP4v2lL7qtG+epcFnPie8Zk1ofoyoZSj7lfReSeMgjoBcnMzWk
         wDAA==
X-Forwarded-Encrypted: i=1; AJvYcCUBXU6fkQ1lHqDCOK2GCr8S7ouV00F2iC37MPjvjkKDOJsZ6weUla0axXuWKTsWThSiIgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+AHHzDc6/sNFaUhBaBuqbS1zLQH4LcOpBEsgMSY3APIGa6j5H
	C9w0f7tpf9xshMawjmgnhl+o5miC9I/pF0snPiQzhhJQVTSYvPrPx2CzS20HeMLC8IrkKnw12rM
	ZxIZVdJru4Wqqr3tsyhKn/k1NMlZAsjk=
X-Gm-Gg: AY/fxX5Jk9aZtK5obD1/dsUl5lpASGLw8LeTTVnkGgb8e2dBMSOtAhqnW6j/FZejbMq
	9CkcWwEOX1a1m0b8EuRgF9pc7n9Gk/1BOHIFil3HBGiLJRAVKSsJAbmvGSS+HXCJwBPRhItRVQ8
	HWJFicttrwyEIsUp3W/JCoidHPAY/5IiPiUsI8mizXcZS0r2YUb9ugm++Lc3oIDVCEkB5c/YkDD
	ghC/Q7VD1fh1/8d2e6kdcGeO4UAgby1nmi6krHEr3lUDwyDZ90v8ku0tFYle96Cvcdzs8xKJW6o
	i4dZXusZuI8=
X-Google-Smtp-Source: AGHT+IFq1+DSiAXRqUWE1kc0JcF82BATUlLMIxXXAO0gDD9PD3IPczJG27PxqkLRnUeu4+f+nC+UN6DHny0PaZ8Pijg=
X-Received: by 2002:a05:690e:1898:b0:63f:55de:63cc with SMTP id
 956f58d0204a3-64716b8e33cmr149478d50.31.1767728587032; Tue, 06 Jan 2026
 11:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
 <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
 <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev> <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
 <d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev> <CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
 <CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com>
 <877btu8wz2.fsf@cloudflare.com> <CAMB2axNnCWp0-ow7Xbg2Go7G61N=Ls_e+DVNq5wBWFbqbFZn-A@mail.gmail.com>
 <87qzs2imh3.fsf@cloudflare.com>
In-Reply-To: <87qzs2imh3.fsf@cloudflare.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Jan 2026 11:42:55 -0800
X-Gm-Features: AQt7F2o23PNEu4IjMYve2RPbJIZtZVOwPPQtczTw_MCkphfX-k0Ojeorcl0AwDw
Message-ID: <CAMB2axO3E30y2862=uMH-S-_KvCzsWyEfBK7gntgF0gyyVZg2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:12=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Jan 06, 2026 at 09:46 AM -08, Amery Hung wrote:
> > On Tue, Jan 6, 2026 at 9:36=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -21806,6 +21806,14 @@ static int convert_ctx_accesses(struct bpf_ve=
rifier_env *env)
> >>                         env->prog =3D new_prog;
> >>                         delta +=3D cnt - 1;
> >>
> >> +                       /* gen_prologue emits function calls with targ=
et address
> >> +                        * relative to __bpf_call_base. Skip patch_cal=
l_imm fixup.
> >> +                        */
> >> +                       for (i =3D 0; i < cnt - 1; i++) {
> >> +                               if (bpf_helper_call(&env->prog->insnsi=
[i]))
> >> +                                       env->insn_aux_data[i].finalize=
d_call =3D true;
> >> +                       }
> >> +
> >>                         ret =3D add_kfunc_in_insns(env, insn_buf, cnt =
- 1);
> >
> > And then we can get rid of this function as there is no use case for
> > having a new kfunc in gen_{pro,epi}logue.
>
> Happy to convert bpf_{qdisc,testmod} gen_{pro,epi}logue to use
> BPF_EMIT_CALL instead of BPF_CALL_KFUNC.
>
> If it's alright with you, I'd like to kill kfunc support in
> {pro,epi}logue as a follow up.
>

Totally. Appreciate it!

Make sense to do in another patchset.

> Looks like there will be a bit of churn in selftests to remove the
> coverage. And this series is getting quite long.

