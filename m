Return-Path: <bpf+bounces-64912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A4B18599
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9DE5405B4
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7D28C874;
	Fri,  1 Aug 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kht167kb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F228C851;
	Fri,  1 Aug 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065200; cv=none; b=AMkX7NgYcbD2ErVcVvn5zSBkEL0fiwrCVbeP/kKoKi8R/7w72fSUJtEQop7VSJqoOnLAf+wFsBRqrQgOgKy63RYSWwNP5N36ikluDavkDGjNBa98dERs07RiIFbgygUvZon5GIYau9IjeDLtDDl+wkUfaTvdn7cJKj/vojuBBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065200; c=relaxed/simple;
	bh=xBhJ9NN0CtvtGb3z7gKGhMrTS1+ZWkKki87wQnqGoxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSQ5xV1rEUPDeYgEhaTVGrpxraOOZOcbJYduDocmjRF2fn1oPfXTVL+ertyBTh6W0eAM1wNXatTWX5u0/+PR/5/iWvH7FCs0Y8lYNEjFd5WyRghXbHWp2D8RN5MAbuwDamOnid4OzmW4VgDYo6ZlAzowSyQTnrcMpU3Y8cAiKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kht167kb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78a034f17so916357f8f.2;
        Fri, 01 Aug 2025 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754065197; x=1754669997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XP4YIMZTKRThkcs9yPXE8L2X3CGeAT6eABqlIZ1SvRU=;
        b=Kht167kb76fslEBdUhloaq+ElRK+PbfUYeIAqxXt+301ENG4Mo3HWNsxoAlvVfku2Y
         QxG7AARLcv7dk14TMUBeazaVKtqUb/a0FxXeNHYJFqP9oT7s+8G8fxgTCc0Q+g64qTBn
         xNR4udwUmLFdpIC13paaPmLRCddPffOcYhm9kB3lDeXQPZ8t381LB+61PfisYiMIieBL
         8tFPteDPEYqpTzjU0Eq2Sgzi6lJtEUt4afteRce18gOpqWk4p+GB2LOKMhDn7Mv2Bl2n
         HW6Wg69dbqXTD1nkAbpHVhroVlAbGV10eL6JeW7QL0IBJPLm4CcQpA+ZcHNoMekygUeu
         eLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065197; x=1754669997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP4YIMZTKRThkcs9yPXE8L2X3CGeAT6eABqlIZ1SvRU=;
        b=h2JJHENMmUY1rsOd/CznKu7PZFgHXNKgWQinCMjRlYMY2JUOori44l/vv4d1ykQeQA
         PplXpdpO2eVwjO8TVkgyepzwMZ7N1cNLMHBxyV/CvsL0Ag87aefP6YIKXUPfto4TnZEc
         soHuZXn7Z9fWnwrK7WgpKSqJ06ryeX5KtvtH8sd+ThrHZTyK55srFCkuiq0hJNFpEt4T
         hLW2IjbBt5m8dIyf0YsnRilChMHA7Js1E+f8/Ou5TRyJ+8QwhjBaUfgRtzzdJ07ng3sc
         yGV0C4HzLZte1octTG7lArOxY9+/ZeYhmG6es5TmfGHdmXPdJlh7U2eqrd3CCIzB7NHP
         ADqg==
X-Forwarded-Encrypted: i=1; AJvYcCWbL8cNAvfhLEME4AeVyIhS4lnfpqWeFfj4Crxz/futfug1f55VNPqdBcR2cV4iLhUlZ6q8dXnXYDennBmOMjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztv0UaHfc3n1hYXsajpcyw0WeU7BcKQGhxSj3r8/ol3gQ8lnV2
	wFJKH69IqdkbhQqdcUfbjOp/dCPj+7palLHhEoHHdG6m4Hv7ACCD3oef
X-Gm-Gg: ASbGncsMnL1OkaKcAFHEedXRQlqrERY1VQYA676DpsU0Npj8zI4niwzsg27u+MYMPFM
	gUcyupZKNAPWmm49zPaOPF2SKL0gf63CRnsVxbrikjev1n8TheZ0ohliKBTXxgdrXR+GSlxFnIV
	H9I+D2yBhjHuqy3Xbaam3lkp4H3bYGKKi8TgS1oeBb7eJMG3RGeEYz8XskBZtuFnHZzClmcfOdY
	x85e0jvRNUIzUdAW8tnZkxao/L9uqOrSZkarLYeGVL/42/4DyWfOpSmjjepIRMDUa46gP9+bUKM
	6Dox7DAo0dPNjmnqdsaCoyoKl8XwYtE7lfOG8inXMonUhd4qEoZUFL+GDXG1gviC6TMQoN67AxO
	ypdl3lkLf7C68Dif0xtwZ3bXsVDnklWsAyYLfIzFIl35NN5NGHdk4bNLhkbMZ3QWq4S8Mr1QjaG
	ao1JyWvw25UyoAT3eqduI=
X-Google-Smtp-Source: AGHT+IGdpLP2JUjJ/UN9tkL58eg/98V8ZH47Sg+EWQpXAeAsapV49G75Nw17zB/4BfWaL9RtrggW6g==
X-Received: by 2002:a05:6000:2382:b0:3b7:9dc1:74bf with SMTP id ffacd0b85a97d-3b8d94ba976mr346916f8f.35.1754065196809;
        Fri, 01 Aug 2025 09:19:56 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000cb332f63428a027.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:cb3:32f6:3428:a027])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abf0csm6234394f8f.14.2025.08.01.09.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:19:56 -0700 (PDT)
Date: Fri, 1 Aug 2025 18:19:54 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Petar Penkov <ppenkov@google.com>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH bpf 3/4] bpf: Improve ctx access verifier error message
Message-ID: <aIzpKu2PChlhVGsq@mail.gmail.com>
References: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
 <cc94316c30dd76fae4a75a664b61a2dbfe68e205.1754039605.git.paul.chaignon@gmail.com>
 <5e7b3c728c88b238224d3dffde4abbd7567b8d1c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7b3c728c88b238224d3dffde4abbd7567b8d1c.camel@gmail.com>

On Fri, Aug 01, 2025 at 09:09:33AM -0700, Eduard Zingerman wrote:
> On Fri, 2025-08-01 at 11:49 +0200, Paul Chaignon wrote:
> > We've already had two "error during ctx access conversion" warnings
> > triggered by syzkaller. Let's improve the error message by dumping the
> > cnt variable so that we can more easily differentiate between the
> > different error cases.
> > 
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks for the review!

> 
> >  kernel/bpf/verifier.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 399f03e62508..0806295945e4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21445,7 +21445,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> >  					 &target_size);
> >  		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
> >  		    (ctx_field_size && !target_size)) {
> > -			verifier_bug(env, "error during ctx access conversion");
> > +			verifier_bug(env, "error during ctx access conversion (%d)", cnt);
> 
> Nit: maybe print the rest of the fields as well?

I considered it but didn't want to unnecessarily bloat the message.
Knowing cnt is enough to know which of the three conditions is true. If
the last one is true, then knowing the values of ctx_field_size and
target_size doesn't really help us because the issue is just that one is
set (ctx_field_size in _is_valid_access) while the other wasn't
(target_size in _convert_ctx_accesses). That indicates a mismatch
between the two functions for that particular program type.

> 
> >  			return -EFAULT;
> >  		}
> >  

