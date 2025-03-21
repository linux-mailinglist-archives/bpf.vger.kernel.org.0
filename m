Return-Path: <bpf+bounces-54554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B367A6C3CB
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 21:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9924A48313D
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE81EE033;
	Fri, 21 Mar 2025 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7W8Wz/W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AB70805
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587341; cv=none; b=A6XXaUFQyoyGXLGkMXV++QywvIPB96/9hzjgGjRq6cK3cw9mAacRmlftWCTvJdgG8/J0O3fx/Hz7G4XWoA027y6yIkD9GxMD79BjWrMlfR/IfcrZB9IX4A3am/RzfaHuUhwJuKsd6a/ZYeUfEO2p/nu9zfe+Qs9Z9Qkz4DotYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587341; c=relaxed/simple;
	bh=zUNMDLJL+kfpeudh1F1IWdlQZKzVw4Pq07dBB/qW/rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SI6iKpEshOQoTwZQ44ZEup5g2Bu8DPOhBNcxYmleV6wyvA5k33uaiiuMjj/fmqvil5zORVDvcfcfV4rK34vWU1N5apAdwvFLSPKxNj8Za/1XGMJoxH8SeX5zGrpYK45XUXwzYmu4W+FXKcdsneu0vOX1hyCl93++tpOFO3xVvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7W8Wz/W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2254e0b4b79so24501795ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742587339; x=1743192139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2MZ02gV+wBg1eZGqVxfpCAubLbLQaMxdAhDHO82l0v4=;
        b=S7W8Wz/WjpuErNDAFw8GL73BlA6xaWMM5bMtju5DxszNj8oSMC7X7hVErZD/PCizR1
         Ew/C0qNK+9p3XYVRXo7Et1eX1KSMv2vRQIW4fQffvnr681BRVoGBAea39PVOApFtIfnQ
         nhuBXje/Ce34SiZp3nDpdc7wgqvcEe2JzwyERN1GI80XYt8QJiSL8bDq9MF6+UaOrJBF
         6xFWgzdeCJLPSNb6IuwkRaylHKom3tZSTimZjXR7hi1F1U9cfIvr2yZ9k3jKlgARpP42
         XqR8hXw7fVKKQwLACRr1NtkJwV0h9VOjbcmhdkPwq/2cNpEnhf6s1u3+uI061ZdsN2zy
         9t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742587339; x=1743192139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MZ02gV+wBg1eZGqVxfpCAubLbLQaMxdAhDHO82l0v4=;
        b=M17ndbFs2HOljStyHfqfuD3gmIFBoIsX/Ysx3wfdmK2fsFgws564pyjLbq+q/zkBPO
         yrNYaWAJN+7PsLVDDnQZor5R6EbsnwCqsRuKAFWI8Ob13/NzrfeKZuVn3upgXyFT+zNp
         9dBtKdlHIp6McQuhjcganydg7jkPPYVxOW9Fk50IzTKNazZry9sO4Bi2E1drv8JUT+KM
         GAaUSl56rkrifpJfEWbHY/9jYkffdRJanQaDGuaFptPmY4RQM9bcci8Jz7D24Rb3tOcJ
         Vjpl8ne47N3Ak60HHb7HR4w8DhbXLvVDB9BVycKc+PajAOJa1zzIL9ONreeqYD9p8NR8
         +9Sg==
X-Gm-Message-State: AOJu0Yw7K7SELoQdYbRiYasjNAi5EoyRpcSyunkWjbteiB0yb23mjswC
	0sLnMWeUPeQyPmBqzLG60Z9DUfa7mwjR1pQMID23wAWDXf9LywQJ
X-Gm-Gg: ASbGncs/oxoX7s7cvPzVnaT49EXPam9aOPb2lI/ekXNfwIW5xtz44EnIUY8BD/SJnHF
	E78x90eokhran0h9qcAYbepGn7ign7Ulf86allcmm33O3Tvt48zkoaEI3F7HzpQO/EOmnnexfKk
	yj6CXh1Xog5ib9tS28zp5IJnBaAi3CpWHl3yjtphjACUJ4x8qpuWKGFvk7+bs6fJiRIm2ZDriI7
	3aRO4l+j48OUKuMHkIiLYrN98jJlEHQFHa0beGo5qpvABLjO10fHqAzza6z7k1yWEgIE1rDffLc
	k4g8MqlmH69uYuOZTDzaKC+JODMJRHitva+qs+UQ
X-Google-Smtp-Source: AGHT+IF+AysJdlcjJaAkTIRDH8TekjpnJOT4GTU5srcsDQy8Kun5IqIbJIIdENXtbuN4+iG3pRgY5Q==
X-Received: by 2002:a17:902:d549:b0:224:a96:e39 with SMTP id d9443c01a7336-22780c55343mr76288265ad.9.1742587339250;
        Fri, 21 Mar 2025 13:02:19 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf636029sm6603162a91.42.2025.03.21.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:02:18 -0700 (PDT)
Message-ID: <a4f1e259a083698bf511b9194be9bff5ba46eb05.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: states with loop entry have
 incomplete read/precision marks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 21 Mar 2025 13:02:13 -0700
In-Reply-To: <CAADnVQJabnCzo6=3uATv3nN2hz7Av=BAORVS=hgnyNHt+5dBCw@mail.gmail.com>
References: <20250312031344.3735498-1-eddyz87@gmail.com>
	 <3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com>
	 <9190c8821684a6c75c524c58c6d54f7d9b2366e3.camel@gmail.com>
	 <CAADnVQKBdJsDWVCNk2LaEc7ZTPFOEeQrRgoEiio4YWFYsijkcw@mail.gmail.com>
	 <1b1913448e28d0d6beef5c2f47a033aa44e2f336.camel@gmail.com>
	 <CAADnVQJabnCzo6=3uATv3nN2hz7Av=BAORVS=hgnyNHt+5dBCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-17 at 14:46 -0700, Alexei Starovoitov wrote:

[...]

> > Looks like there are only two options left:
> > a. propagate read/precision marks in state graph until fixed point is
> >    reached;
> > b. switch to CFG based DFA analysis (will need slot/register type
> >    propagation to identify which scalars can be precise).
> >
> > (a) is more in line with what we do currently and probably less code.
> > But I expect that it would be harder to think about in case if
> > something goes wrong (e.g. we don't print/draw states graph at the
> > moment, I have a debug patch for this that I just cherry-pick).
>
> if (a) is not a ton of code it's worth giving it a shot,
> but while(!converged) propagate_precision()
> will look scary.
> We definitely need to do (b) at the end.

I tried a simpler approach we talked about on Wednesday.
Here is an implementation using strongly connected components:
https://github.com/eddyz87/bpf/tree/scc-instead-of-loop-entry

The idea is as follows:
- Compute strongly connected components on control flow graph;
- The number of such components is not big for selftests and
  sched_ext;
- For each component track the following:
  - A flag indicating if states loop had ever been formed by states
    originating in this component
    (states loop is states_equal(...RANGE_WITHIN)).
    When such flag is set the states within the component need to be
    compared using RANGE_WITHIN logic.
  - A counter for "yet to be explored / currently explored" states
    originating from the component + an epoch counter. The epoch
    counter is incremented each time the "yet to be explored" counter
    reaches zero. Verifier states are extended to keep an epoch
    counter if states insn_idx is within the component. The epoch
    counter is needed to know if two verifier states are within the
    same states sub-tree.
- in clean_live_states() mark all state registers/stack slots as read
  and precise if:
  - state->insn_idx is within a strongly connected component;
  - state loops had been formed for states within this component;
  - state's component's epoch differs from current component's epoch,
    meaning that sub-tree of child states had already been explored
    and there would be no need to apply widening within this component.

This almost works.
It comes short for a single selftest:

    int cond_break1(const void *ctx)
    {
    	unsigned long i;
    	unsigned int sum =3D 0;

    	for (i =3D zero; i < ARR_SZ && can_loop; i++) // Loop A
    		sum +=3D i;
    	for (i =3D zero; i < ARR_SZ; i++) {           // Loop B
    		barrier_var(i);
    		sum +=3D i + arr[i];
    		cond_break;
    	}

    	return sum;
    }

The test is still verified, but the number of explored states goes
from 10 to 8K. The problem here is that the loop B converges first and
`clean_live_states()` marks `sum` as precise at entry to loop B.
Then, when a branch originating from Loop A reaches entry to loop B it
hits a checkpoint and propagates `sum` to the `may_goto` checkpoint at
the beginning of the Loop A.
Hence, widening logic for `sum` does not kick in.

There is also a problem with one sched_ext program (lavd_dispatch),
where eager precision marks applied to cached state confuse
mark_chain_precision, at it hits a bug assert when trying to mark r1
precise when backtracking a function call. This is something to debug
further.

---

I also tried a more complex approach, where:
- state loop backedges are accumulated for each strongly connected
  component;
- when component is done exploring (using same branch/epoch logic as
  above) do propagate_{liveness,precision} along the backedges while
  precision marks change.

It is here:
https://github.com/eddyz87/bpf/tree/read-marks-stead-state-per-scc
The test cases at hand pass (absent_mark_in_the_middle_state{,2}),
but it hits memory protection errors on complete test_progs run and
requires further debugging.

Overall, I don't like the level of complexity this approach involves.
It appears that it would be better to invest this complexity into a
compiler style pass computing a conservative approximation of precise
registers / stack slots.


