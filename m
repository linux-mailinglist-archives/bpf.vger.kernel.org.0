Return-Path: <bpf+bounces-57595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3D3AAD23F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABDC468AB0
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B5FBF6;
	Wed,  7 May 2025 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIgl0JVb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88124E555
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577402; cv=none; b=JnYv16xF6WueK9ZUgDF2fJpSeLKET4f4VX4LYdOZXWTg4MTckgrSVZI/+TcnhuS589l/SgDD1FJaT6cV3FRYMEdqXLDboNSehSCjAy478fFNMmc+A0tAlkZaA1gm5LYlDtqYuHhQ7AaoqZcVJoHrK1eYqvVgtfZlF6FnwslZ3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577402; c=relaxed/simple;
	bh=IoeZU1MSO1yq2zs++QyNVBlCWyTeG5+D3PI+rHUjr+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJi8z2dlyMzKuji7Je7s23SnS3TwTlYqlMwfq+yfaTTGXMpp7fJkBv1WNSsqGi9F6YBHr0h+rfBz5NwS2Ch4VZRdhA0aFsM+Iudmav+pJysqI2DhRn/J27gYi+GRvp1Ifd2/7YQzqj6dQzJRGMqGuYta812arRRRuol6PmEfy2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIgl0JVb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2242ac37caeso42735ad.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 17:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746577399; x=1747182199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sI1txssI9jFxvw1ed/mZEava9GNou9j0LjvsUinfGHw=;
        b=zIgl0JVb8ghQULQREBrl4I6BzpberSXQKUjqNeccLy2NDy8TFV5Z7nEO4Q8lkPfmIM
         6fuPHd6wdePcTwlXHC2gjfuiFiACoJaEhJiL4kj1wlVd3KqpEbssNhASmIn5pEZt3CMy
         Cupb6zeN+rAoykquUqd5u6qyVwBvEnsTnmvTxB9IfqhTDh+9lN8s7A3hcmUxpROgfymj
         aiKdnNj5Y3hSuZ82DY93WqdazNLY7bd1ZH24PIv4FWJ6sNUve/FJdA9MNT8K/3llcQ8o
         e1RzjxinKZWVjRXcxgiQN18ZAse2yo3Z/2AVz7wZ12EbJ4nloCDOqwwtXsFCSf7280+N
         FL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746577399; x=1747182199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sI1txssI9jFxvw1ed/mZEava9GNou9j0LjvsUinfGHw=;
        b=k7oGeZIsBHcFLzv76RyxA+UiUpI5vjWyzUvgD0iDWCaSCCu2HNXtiSiIh8A7QzB4FD
         AJf57XECo+4Ftht1SGpUChpwLRX17yOTh4pRFOfOmPJrcL+MFDhyBYySkLEjGrkowZh8
         TJHuRRKq9dq8EVl03QQEQeb8jAp6b+rxXHuXDY2sdAnDy7X7sTWCux98R3krzXETWiqn
         t/Qa6Wo04vYS4+MryLXMwzhb3h/ib/Rk1WOyr0x4G4wT/P5Y0y/s8nPY3xCUsWH2qo4q
         TMZvSZZ89nwJT/Y2GtxvYdMcErmpNd3YosBX8nYsd5KQ+dzInCuKlPPlP+EOW8WOvTHj
         b8KA==
X-Gm-Message-State: AOJu0Yx8Ck+DDOmcwNAIV9aMcDwpyPPeSVKoO/2diTMeZNONLuAuzF64
	D/H5jXHgNeNUL8Zn8rMb1lmOa1EXHnj5OijjH3R1NpY32N7TegM2B7ZqWrfmZA==
X-Gm-Gg: ASbGncvyrvspsSaXtf0gXv++8D7FrAS3oC1C5xFYEftOl3Ug2gkRTl/XeRJKu4q1+QM
	V3i5vDRkIJdRpBpHlVXhpbyxWXgA33V8sR13itwGqvrFzUeakMcKjCOCrVzrLm0SvjmqjSEeF4c
	3tbj/LXpGEfWkZmu+helsxDFJkE0zE+XofpnUOIWQUFZUoSg+XarrKCvkQV5gf625bK+vVwdl4s
	T35mHGWUrUnyrtBqI4V0qH7SYIB44wdR6zE1yYzWTWPmNJjAqsDrWCgr/U8OL4sDn1RyS3eRlS4
	2G6MKMX4Pi2Czi40dR00qzuxVkmxD3wE3ECctmL/xTGK97YaUEGsK/t5veIQkzQy7ub9cnxMg3O
	apWg2rw==
X-Google-Smtp-Source: AGHT+IEzK5qlbI0uu6IJ+MI/sf09eqJCBljxYneKmD8E0EnlSPJPFhlneErsLBo7GPHLcOUfATUmBg==
X-Received: by 2002:a17:902:cccf:b0:216:27f5:9dd7 with SMTP id d9443c01a7336-22e62a0496cmr777455ad.11.1746577398520;
        Tue, 06 May 2025 17:23:18 -0700 (PDT)
Received: from google.com (202.108.125.34.bc.googleusercontent.com. [34.125.108.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fb61sm80215915ad.144.2025.05.06.17.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 17:23:18 -0700 (PDT)
Date: Wed, 7 May 2025 00:23:12 +0000
From: Peilin Ye <yepeilin@google.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: bpf@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
	linux-riscv@lists.infradead.org,
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
Subject: Re: [PATCH bpf-next 3/8] bpf, riscv64: Support load-acquire and
 store-release instructions
Message-ID: <aBqn8C6Iz3tk6dAk@google.com>
References: <cover.1745970908.git.yepeilin@google.com>
 <248aa4b0ef7e439e0446d25732af7246d119c6a9.1745970908.git.yepeilin@google.com>
 <a50a1c64-683b-4356-99ec-103017f7a6be@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a50a1c64-683b-4356-99ec-103017f7a6be@huawei.com>

On Tue, May 06, 2025 at 10:20:04PM +0800, Pu Lehui wrote:
> On 2025/4/30 8:50, Peilin Ye wrote:
> > @@ -1259,7 +1318,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
> >   {
> >   	bool is64 = BPF_CLASS(insn->code) == BPF_ALU64 ||
> >   		    BPF_CLASS(insn->code) == BPF_JMP;
> > -	int s, e, rvoff, ret, i = insn - ctx->prog->insnsi;
> > +	int s, e, rvoff, ret = 0, i = insn - ctx->prog->insnsi;
> >   	struct bpf_prog_aux *aux = ctx->prog->aux;
> >   	u8 rd = -1, rs = -1, code = insn->code;
> >   	s16 off = insn->off;
> > @@ -1962,10 +2021,14 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
> >   	case BPF_STX | BPF_MEM | BPF_DW:
> >   		emit_store_64(rd, off, rs, ctx);
> >   		break;
> > +	case BPF_STX | BPF_ATOMIC | BPF_B:
> > +	case BPF_STX | BPF_ATOMIC | BPF_H:
> >   	case BPF_STX | BPF_ATOMIC | BPF_W:
> >   	case BPF_STX | BPF_ATOMIC | BPF_DW:
> > -		emit_atomic(rd, rs, off, imm,
> > -			    BPF_SIZE(code) == BPF_DW, ctx);
> > +		if (bpf_atomic_is_load_store(insn))
> > +			ret = emit_atomic_ld_st(rd, rs, off, imm, code, ctx);
> > +		else
> > +			ret = emit_atomic_rmw(rd, rs, off, imm, code, ctx);
> >   		break;
> >   	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
> > @@ -2050,7 +2113,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
> >   		return -EINVAL;
> >   	}
> > -	return 0;
> > +	return ret;
> 
> `ret` may be a value greater than zero, which will potentially cause
> build_body to skip the next instruction. Let's `return 0` here, and `return
> ret` if the above fails.

Sure, I'll change this in v2.

Thanks,
Peilin Ye


