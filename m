Return-Path: <bpf+bounces-48053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ECCA039BE
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D1C3A5296
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ABE1E0DE3;
	Tue,  7 Jan 2025 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yfRxdKJ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42E1DF27C
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238368; cv=none; b=ntfeuooOtKdp8uLFFYHngBsgwfLufwxRS1LdwK14T+vYPUnFb9nwyK7oYv+pbmpWGp83zr+mbHCi3J/8vTT0p0R2OlRxKEp740h6ORPbSFarWEqB7truDaHJj2uFNIfFQxsK9TGEQEz9FDalIEDfsO72JpxZ1MByG9+pDI8GRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238368; c=relaxed/simple;
	bh=HtlsEtsFsJGish6stmWjmXW/GeifErkx0ytxa6TSYfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+c1diH6Si+puzcHMRecgMf0SQA4hVk8zldfL3jZNzsupRNvfNqRDcFhiKfgEgctR/hs3rEx0Jobgsas4nK/yHPwdyoQeVXSocv/qmQnMxtgVa9aRS97D/kjzkrOXgw9AF+NeQReOZ2vTAwrZjt5h569Mz9xGxDgYzc+PeM375Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yfRxdKJ1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2163affd184so71295ad.1
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 00:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736238364; x=1736843164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1qZMGCcqwi5aCbBXdyd+j5H+Th5vroNusHmLfehDdw=;
        b=yfRxdKJ1gYhdLjmJcKr6CrH+xcDRa+dGjTJroKsjH9+H+VtboZUzrFeAeQ0sTmirfd
         625uKQu2zxAed8atdkTmwuC3CEU4DRlAl0KRQ2GVtMz7jSljt62Ym/+E8s5dxvKtswy2
         G1FfLmWrw1JF32wo2mWuVE7lLljVJUjeq3wJeP+mvHW8LiM6dcNkozQalrZMOoHut5hO
         d4bwG1D9lsqcHmrRxWGriYXUBDokBCR4TISw++cYFQo2p+RtWAwE/ejZ1aEW/7uoJ7dy
         N8QHDsAIFBGncRqQMyiUI1IRwP0CIUcFLRrAw98TWyu9d1gyaf+wIRIkEkHt+ICr7mLb
         9PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736238364; x=1736843164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1qZMGCcqwi5aCbBXdyd+j5H+Th5vroNusHmLfehDdw=;
        b=ZBEXq5cAGDhzkU673DHJGF6p43+2Z/otikTPkcAXpNh/tXuC0FGP/l+fydAsyhrANw
         ogHp2HGd/tA4SPy8qNVrKuY1tm8pIehk6E5meaudxa7o6n9H0WHbDEnPu+6x0/RpsS5Z
         hCrERo4OGJF0yt3dbqh7wjCkJdwrR4RIZkFsY18LP0JJtoh4Pk5g5ytuiPcDnOG6G2sV
         uJ0xJsIwyhhJV5m38S32HoAWauKDrx5pgVrcJVPQxYpYHlmsf63jAfmnb3vb53bgj0mu
         S1cs8j5knKifDql9Q5STA20jKMj9SYdCI4mNfKKZCQonVqDwqY8gIdjiPTf4hdozWbiP
         ZVQA==
X-Gm-Message-State: AOJu0YyYDLhz63LTrTU4jyu/bOIjdMqVVx99S4U/Eur2Rg7LerQC91Te
	Yogg87FkCDAUCf/1EXICgKuXYUVol9tFgNWjGI786Wq4fuIAxNQ0IWeWHUYBXQ==
X-Gm-Gg: ASbGncvjtaiclLwLtrmVkjLssut/TZYgoEjoEDbomCrincrRu6GpiOqT8kO9jXajQ3p
	0OD1lkYPuGQDj6zkKL/Y5XN8W9586gImaz9LQg7fD1UHOLpoR059eyAL5+gjKhWAxuArkkPnwmo
	6oGTf1/dcKNwBjz7JGPnqCeIf4wTda8lRgrpd/pqEgBYgxWTHt0ReSFR9nk4N0CD8JTzutP7O2p
	F+jhdRA5HBgUmfCOzDCCZW0Brr1NbghzH8yLE1Vw1Tlv0PCPNRleSncoknOhcqGouZ4gNpG8C91
	Ta3QrqFbWV7VL4lW3GQQFg==
X-Google-Smtp-Source: AGHT+IEfmW9COHiHVgZffGJI4jEMYyqaXVLbTIzkgQqeA5/VYlBTcDC1DT0MD1e8oN+Ek6aEkjNcDA==
X-Received: by 2002:a17:902:cec4:b0:215:591e:f90f with SMTP id d9443c01a7336-21a7acaaa14mr1779725ad.20.1736238363826;
        Tue, 07 Jan 2025 00:26:03 -0800 (PST)
Received: from google.com (101.150.125.34.bc.googleusercontent.com. [34.125.150.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm29947154a12.23.2025.01.07.00.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 00:26:03 -0800 (PST)
Date: Tue, 7 Jan 2025 08:25:58 +0000
From: Peilin Ye <yepeilin@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z3zlFvVkqawxK810@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
 <9941341e8bd78f3563e0027a59cac8966f1e3666.camel@gmail.com>
 <Z3x-qSHxWTw5je1O@google.com>
 <e294e3c318e2c7a646e4b2e43516378a0689ea3b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e294e3c318e2c7a646e4b2e43516378a0689ea3b.camel@gmail.com>

On Mon, Jan 06, 2025 at 05:20:56PM -0800, Eduard Zingerman wrote:
> > > > --- a/kernel/bpf/disasm.c
> > > > +++ b/kernel/bpf/disasm.c
> > > > @@ -267,6 +267,20 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
> > > >  				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> > > >  				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> > > >  				insn->dst_reg, insn->off, insn->src_reg);
> > > > +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> > > > +			   insn->imm == BPF_LOAD_ACQ) {
> > > > +			verbose(cbs->private_data, "(%02x) %s%d = load_acquire((%s *)(r%d %+d))\n",
> > > > +				insn->code,
> > > > +				BPF_SIZE(insn->code) == BPF_DW ? "r" : "w", insn->dst_reg,
> > > 
> > > Nit: I think that 'BPF_DW ? "r" : "w"' part is not really necessary.
> > 
> > We already do that in other places in the file, so I wanted to keep it
> > consistent:
> > 
> >   $ git grep "? 'w' : 'r'" kernel/bpf/disasm.c | wc -l
> >   8
> > 
> > (Though I just realized that I could've used '%c' instead of '%s'.)
> 
> These are used for operations that can have either BPF_ALU or
> BPF_ALU32 class. I don't think there is such distinction for
> BPF_LOAD_ACQ / BPF_STORE_REL.

I see; I just realized that the same instruction can be disassembled
differently by llvm-objdump, depending on --mcpu= version.  For example:

  63 21 00 00 00 00 00 00
  opcode (0x63): BPF_MEM | BPF_W | BPF_STX

  --mcpu=v3:           *(u32 *)(r1 + 0x0) = w2
  --mcpu=v2 (NoALU32): *(u32 *)(r1 + 0x0) = r2
                                            ^^

So from kernel's perspective, it doesn't really matter if it's 'r' or
'w', if the encoding is the same.  I'll remove the 'BPF_DW ? "r" : "w"'
part and make it always use 'r'.

> > > >  static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
> > > >  {
> > > > +	const int bpf_size = BPF_SIZE(insn->code);
> > > > +	bool write_only = false;
> > > >  	int load_reg;
> > > >  	int err;
> > > >  
> > > > @@ -7564,17 +7566,21 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> > > >  	case BPF_XOR | BPF_FETCH:
> > > >  	case BPF_XCHG:
> > > >  	case BPF_CMPXCHG:
> > > > +		if (bpf_size != BPF_W && bpf_size != BPF_DW) {
> > > > +			verbose(env, "invalid atomic operand size\n");
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		break;
> > > > +	case BPF_LOAD_ACQ:
> > > 
> > > Several notes here:
> > > - This skips the 'bpf_jit_supports_insn()' call at the end of the function.
> > > - Also 'check_load()' allows source register to be PTR_TO_CTX,
> > >   but convert_ctx_access() is not adjusted to handle these atomic instructions.
> > >   (Just in case: context access is special, context structures are not "real",
> > >    e.g. during runtime real sk_buff is passed to the program, not __sk_buff,
> > >    in convert_ctx_access() verifier adjusts offsets of load and store instructions
> > >    to point to real fields, this is done per program type, e.g. see
> > >    filter.c:bpf_convert_ctx_access);
> > 
> > I see, thanks for pointing these out!  I'll add logic to handle
> > BPF_LOAD_ACQ in check_atomic() directly, instead of introducing
> > check_load().  I'll disallow using BPF_LOAD_ACQ with src_reg being
> > PTR_TO_CTX (just like all existing BPF_ATOMIC instructions), as we don't
> > think there'll be a use case for it.
>  
> (Just in case: the full list of types currently disallowed for atomics is:
>  is_ctx_reg, is_pkt_reg, is_flow_key_reg, is_sk_reg,

>  is_arena_reg,

...if !bpf_jit_supports_insn(), right.

>  see slightly below in the same function).

Thanks,
Peilin Ye


