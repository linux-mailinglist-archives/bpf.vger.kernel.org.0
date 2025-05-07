Return-Path: <bpf+bounces-57592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E8AAD232
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97FB7BBB4E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B28C1E;
	Wed,  7 May 2025 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEKzbNCm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162479EA
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577131; cv=none; b=jSEd7vQpQ2m0Ow3hng0ET9LScyR9MIDK31IZXESIVK6JiC9tdzV+e+h4w3SuPPDwvdnsOM6dSAbQ7XEbBn69QHE5EhZiF25hUr3I48qa7M2rHO2MRUjK6uvFx+uiOZWxZPQfut0JxcviWFQqOxrLFt+FWLJsBlBQe8U4jZlPO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577131; c=relaxed/simple;
	bh=AXDlCvBTKudPltKiO8Rm2aB9/JkO+VJc8l2PXCZYDgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6W5NH5r7LjviTMBPq0pyOtS0drGYW8riZ2cyXssstWN8IRfNRRQn+43IUP1PP9FARCQkaoT8AUzePw53d6aYbcJkOLBAkCEkMaaUZtpp9NaoZRtwmfljcdNTXWFJTkS7lU2vPvFHv07YZXCad2nLzgYG/xKwwoyTzNyRwRnSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEKzbNCm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e39fbad5fso47275ad.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746577129; x=1747181929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOxJ2ZleJ6jrErKcMxnacgjBMyxg2WYmX0Aa16MkjwU=;
        b=mEKzbNCmuBXaj/dcf12KIlWj8utwR5FxOwLwvkJgzzGk8HbpMmsLpYzXFPobX1EYwL
         sHYrBVLOPndG7cdVoF51G9+iu340GyNXwn93icYLcJpcz1SXOCxY4jbV16EnjyF53vQP
         JFzzR/r0T9m4D0FYoifCDzeJOOSOqjwEzvoAtYddmBW0IECv3ismnYGNdzV7GRcAocDT
         X9BRiOAoKuhgCRbwJawexFryMsSW4dp7dHlsVMKymFW2NuxDPCZj19N4Hia2mzzn3J8C
         yw7M1m07IHFIJhu+GQDcEwgPxKAdOotblhqcd0HahfDtsalTQrgh0yS14lULItw8C+6h
         9M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746577129; x=1747181929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOxJ2ZleJ6jrErKcMxnacgjBMyxg2WYmX0Aa16MkjwU=;
        b=PnMXpB3nqqPAw+dyPBI7C0lvlD6f/pRj0k9GTxt76y+7JjPJa8lYuYeB1IEb4ONxfu
         aOzagGcrM13lqvqanAyFfJ6cbtGZ/iFylEbw1cxRadn3KHkCBE+yw+A9jtdtHKZ9TopK
         cylgx6NCgrDEkLbCczwX/xaXeSJExL92/iMdXXzzXfJrR1kFPSy2YL+cgP0riXi0Iwj1
         HIiDZ+Gwc2FMqhCJHh6KKN243gn1XbnltasgFX9hWWC6GzEd1Yo8QZdFrWa2/wQ5DjfN
         eQh82jyPqfdFJEut12buaUquNOdSTVSp09yyGatJshtEvljh7HWp2axD7BtKM13cI0gQ
         4vjw==
X-Gm-Message-State: AOJu0YxfyuG3UkCptey+K7fUHWRQoy1+9ONTXInwCibygcb9wOmIt+hm
	CewCWtio8VXLL+eh3uDgoB3vmXewZ45t8GvNOQFxDlBLLVRGhQ4ZcohuRNPnsA==
X-Gm-Gg: ASbGncuoLHtgv2EaU0lNLNwa7jUq27tV48nsURoo3h8QBexSpxEOhhKQ3Yxc8iergAB
	fbd9jRWL6k2SUjTLy55fF650Du4D8qcClpx3/bLCGJkGp2gHXiENotEq8EtJ/4bAOHrMjrtqyel
	FGnUKr3D0AdCZQTulVCD8ff3Da0dS2R81/jAXUCwJ8GAuDByO063iAXVfeqbBtT+y8BsslzUW5s
	GKlzBMmsfgjjSPtvREBwOVVsRt0L9weX4JegDa9TQt/cg6DP83iRMKDYgIwfAxi1RmVVwCFWber
	L+eH2Hryq+1CP7cCT6RJEzD+vZlh6H+SvUXAhlFNfecHIYvHYSB1EQDn70XvJIzy/x1IikGGhk9
	QXRhYNw==
X-Google-Smtp-Source: AGHT+IFmGem4PNyUmSVD8zL0fRN7LffVd//g6xDAdzb1nlkNZSOB6w7YBuoQbUG985u6qDaMChHTrQ==
X-Received: by 2002:a17:902:e74e:b0:21f:4986:c7d5 with SMTP id d9443c01a7336-22e5ee8be88mr1763875ad.8.1746577129359;
        Tue, 06 May 2025 17:18:49 -0700 (PDT)
Received: from google.com (202.108.125.34.bc.googleusercontent.com. [34.125.108.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905d067sm9661814b3a.126.2025.05.06.17.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 17:18:48 -0700 (PDT)
Date: Wed, 7 May 2025 00:18:43 +0000
From: Peilin Ye <yepeilin@google.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Andrea Parri <parri.andrea@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>
Subject: Re: [PATCH bpf-next 1/8] bpf/verifier: Handle BPF_LOAD_ACQ
 instructions in insn_def_regno()
Message-ID: <aBqm4-CsZyWXRwp_@google.com>
References: <cover.1745970908.git.yepeilin@google.com>
 <2c1ec0e60974f8438730dc5126f9ed986b32a3f6.1745970908.git.yepeilin@google.com>
 <83698e73-3b47-4cdc-af50-c4f3ca479b7a@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83698e73-3b47-4cdc-af50-c4f3ca479b7a@huawei.com>

Hi Lehui,

On Tue, May 06, 2025 at 10:03:59PM +0800, Pu Lehui wrote:
> On 2025/4/30 8:50, Peilin Ye wrote:
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3649,13 +3649,16 @@ static int insn_def_regno(const struct bpf_insn *insn)
> >   	case BPF_ST:
> >   		return -1;
> >   	case BPF_STX:
> > -		if ((BPF_MODE(insn->code) == BPF_ATOMIC ||
> > -		     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) &&
> > -		    (insn->imm & BPF_FETCH)) {
> > +		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
> > +		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
> >   			if (insn->imm == BPF_CMPXCHG)
> >   				return BPF_REG_0;
> > -			else
> > +			else if (insn->imm == BPF_LOAD_ACQ)
> > +				return insn->dst_reg;
> > +			else if (insn->imm & BPF_FETCH)
> >   				return insn->src_reg;
> > +			else
> > +				return -1;
> >   		} else {
> >   			return -1;
> >   		}
> 
> How about simplify like this:
> ```
> static int insn_def_regno(const struct bpf_insn *insn)
> {
>         switch (BPF_CLASS(insn->code)) {
>         case BPF_JMP:
>         case BPF_JMP32:
>         case BPF_ST:
>                 return -1;
>         case BPF_STX:
>                 if (BPF_MODE(insn->code) == BPF_ATOMIC ||
>                     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
>                         if (insn->imm == BPF_CMPXCHG)
>                                 return BPF_REG_0;
>                         else if (insn->imm == BPF_LOAD_ACQ)
>                                 return insn->dst_reg;
>                         else if (insn->imm & BPF_FETCH)
>                                 return insn->src_reg;
>                 }
>                 return -1;
>         default:
>                 return insn->dst_reg;
>         }
> }
> ```

I see, I'll change it in v2.  Thanks for the suggestion!

Peilin Ye


