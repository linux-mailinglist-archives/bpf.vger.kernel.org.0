Return-Path: <bpf+bounces-48036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137B1A03458
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 02:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2383A4EB8
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 01:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BFC7080E;
	Tue,  7 Jan 2025 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWsYKhmr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384541C72
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736212145; cv=none; b=Gb1+8URyFcWJPtNyd73zAB84N0PDYsJGMhV0PlO00fi2oDgdXcTRDMFYe7sWH+/OixE4gNPKTyAkFyEzusaQF9VeNigR+znGGZArmjoeju1S1uxZxYbqAPk9IH7BDWuuSSQ1HYGY46JcDMkkLQLDHd1NGTRU1pPNgJi8qL8vNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736212145; c=relaxed/simple;
	bh=dWvCcqgYzlWU41Yy0Wv8f7DUIk+aKxcBFiPyrBnUGUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAEAHxEe8bjxrtfCCsWkldiUh7jL4bE8e7UZ1fMqu9Durb1KEOawaSzqZF9K8YfEa3+BAx26IUf+MVvAqhSUiK5P5LH7D3+zZzyvflTPi+VD62p5/pk54J0BP/ohGcMP4dn1itjplAnV/RdPKECqKRlhFQ6M0Ci/yYGX7nlxuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWsYKhmr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f6ca9a81so29545ad.1
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 17:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736212142; x=1736816942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NaXtirEOVSs2pKiw/u+G+r+AK5LZ2CYTQMgPGzN3WlU=;
        b=KWsYKhmrb7Ovt/eoEZv7rEuv5fR2wjXxZZwnjmGzUaukwg21MmETKpZuEql0eJL9fm
         kcp4/0Gsn8w04OZ/xdmKHYmXO1B4eeAHUv9u/A57bRgtujV+rfl/pkBXQX7+brNvp84q
         5B82wz5GrEsyX3jeVf5FGH76GzQ12PsDBQVifHbmvmF+zzNvmV1JsXoBk0uKGvfqXcym
         E5ykbb9AMy8b/qfxKk603QzJVj6Co6r+ou1bQ8Bfnp9bNFzZ7KlpsGrZuHXawDuasIoG
         7gbbDA235q+ddjR0EB3BwiZyuEj6ZXe4JugbSnISjNv+Kz5HYySpn7WQHs/0ySCtsO8X
         6OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736212142; x=1736816942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaXtirEOVSs2pKiw/u+G+r+AK5LZ2CYTQMgPGzN3WlU=;
        b=eIFBwTF3PTr7LMqugYLHCQ58f6rSdZx/5kDP8/k27m9MX3iYHan6KW9HxeFx7XzMpk
         6qC6MCew9v31cEXV8nJ51p6oVLUuyGQAk7/kpmTlmsG9RoFdTIqvb4G4Qn2WP+1IoKBB
         fmIdO0YtzsU+/E4IPicJBwI5vt0tHXsm8A1pjB2xhxHNOhS/VF6WKnF50vfYvXzmjXU8
         gfpwnmvTOXwqcYtMgMRrgil0Rns0Aolpb/z/iBjvsKM/2B7BqWBLQwCeGduFxC5eRjur
         pSzbHLkUezTVpxsOi6wikq9l68raJVILnvaDsa0bpX+NWlZjojwpwxs9YG3ls/g0DV85
         qkOg==
X-Gm-Message-State: AOJu0YwjH8aCmD7S9UGiLENGeQZ/lOPWzS5fLul+IjOoD+h0UOrz8z95
	REhUwVK/ZQiOutpZUTsg5DTL2RNT2h9rYUlbA2Mnts2IOvklKwy5w4U03agSmw==
X-Gm-Gg: ASbGncsxJC419ZoR69sftDTCNA3BZF6LqZGWvuw3GWkHhBcWI1q2KdUrne+1cOeV/dr
	zgg4+LpDbj0VOC8B71OMGcFkIKiiVkagDaDgldJdJfGjaebXlnNlX/pW3okemwZoiMzV1dSghDb
	e+l25cYKbIQvRhhl075rw2vHnXtMY/YTmCrK8STh9VyLLvcoEzYIVhFUfcJY/s1fAJ3+2Krvq91
	9mIQ3HwdYAVSv0JcArqar3sh9iBTcZaGrTpwTyZf+Itmdlj9JkpmddX+yBuQ/3W7dDR1fVWe+4v
	JiLC7o1wXLoRb7ejpVIzJw==
X-Google-Smtp-Source: AGHT+IHmMuRhgt9xM9yw0yf+rzEm+k3s0k5zNhz4frDF1RqjzjPQOH9MFbTwpxQuGeiIyyXxG9TYsw==
X-Received: by 2002:a17:902:d4ce:b0:217:8612:b690 with SMTP id d9443c01a7336-21a7aca0588mr1033345ad.8.1736212142135;
        Mon, 06 Jan 2025 17:09:02 -0800 (PST)
Received: from google.com (101.150.125.34.bc.googleusercontent.com. [34.125.150.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a6c81e0besm32380575ad.157.2025.01.06.17.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 17:09:01 -0800 (PST)
Date: Tue, 7 Jan 2025 01:08:57 +0000
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
Message-ID: <Z3x-qSHxWTw5je1O@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
 <9941341e8bd78f3563e0027a59cac8966f1e3666.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9941341e8bd78f3563e0027a59cac8966f1e3666.camel@gmail.com>

Hi Eduard,

Thanks for the review!

On Fri, Jan 03, 2025 at 04:12:08PM -0800, Eduard Zingerman wrote:
> On Sat, 2024-12-21 at 01:25 +0000, Peilin Ye wrote:
> > Introduce BPF instructions with load-acquire and store-release
> > semantics, as discussed in [1].  The following new flags are defined:
> 
> The '[1]' link is missing.

Oops, thanks.

[1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/

> > --- a/kernel/bpf/disasm.c
> > +++ b/kernel/bpf/disasm.c
> > @@ -267,6 +267,20 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
> >  				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> >  				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> >  				insn->dst_reg, insn->off, insn->src_reg);
> > +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> > +			   insn->imm == BPF_LOAD_ACQ) {
> > +			verbose(cbs->private_data, "(%02x) %s%d = load_acquire((%s *)(r%d %+d))\n",
> > +				insn->code,
> > +				BPF_SIZE(insn->code) == BPF_DW ? "r" : "w", insn->dst_reg,
> 
> Nit: I think that 'BPF_DW ? "r" : "w"' part is not really necessary.

We already do that in other places in the file, so I wanted to keep it
consistent:

  $ git grep "? 'w' : 'r'" kernel/bpf/disasm.c | wc -l
  8

(Though I just realized that I could've used '%c' instead of '%s'.)

> >  static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
> >  {
> > +	const int bpf_size = BPF_SIZE(insn->code);
> > +	bool write_only = false;
> >  	int load_reg;
> >  	int err;
> >  
> > @@ -7564,17 +7566,21 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >  	case BPF_XOR | BPF_FETCH:
> >  	case BPF_XCHG:
> >  	case BPF_CMPXCHG:
> > +		if (bpf_size != BPF_W && bpf_size != BPF_DW) {
> > +			verbose(env, "invalid atomic operand size\n");
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case BPF_LOAD_ACQ:
> 
> Several notes here:
> - This skips the 'bpf_jit_supports_insn()' call at the end of the function.
> - Also 'check_load()' allows source register to be PTR_TO_CTX,
>   but convert_ctx_access() is not adjusted to handle these atomic instructions.
>   (Just in case: context access is special, context structures are not "real",
>    e.g. during runtime real sk_buff is passed to the program, not __sk_buff,
>    in convert_ctx_access() verifier adjusts offsets of load and store instructions
>    to point to real fields, this is done per program type, e.g. see
>    filter.c:bpf_convert_ctx_access);

I see, thanks for pointing these out!  I'll add logic to handle
BPF_LOAD_ACQ in check_atomic() directly, instead of introducing
check_load().  I'll disallow using BPF_LOAD_ACQ with src_reg being
PTR_TO_CTX (just like all existing BPF_ATOMIC instructions), as we don't
think there'll be a use case for it.

> - backtrack_insn() needs special rules to handle BPF_LOAD_ACQ same way
>   it handles loads.

Got it, I'll read backtrack_insn().

> > +		return check_load(env, insn, "atomic");
> > +	case BPF_STORE_REL:
> > +		write_only = true;
> >  		break;
> >  	default:
> >  		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (BPF_SIZE(insn->code) != BPF_W && BPF_SIZE(insn->code) != BPF_DW) {
> > -		verbose(env, "invalid atomic operand size\n");
> > -		return -EINVAL;
> > -	}
> > -
> >  	/* check src1 operand */
> >  	err = check_reg_arg(env, insn->src_reg, SRC_OP);
> >  	if (err)
> 
> Note: this code fragment looks as follows:
> 
> 	/* check src1 operand */
> 	err = check_reg_arg(env, insn->src_reg, SRC_OP);
> 	if (err)
> 		return err;
> 
> 	/* check src2 operand */
> 	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
> 	if (err)
> 		return err;
> 
> And there is no need for 'check_reg_arg(env, insn->dst_reg, SRC_OP)'
> for BPF_STORE_REL.

Why is that?  IIUC, 'check_reg_arg(..., SRC_OP)' checks if we can read
the register, instead of the memory?  For example, doing
'check_reg_arg(env, insn->dst_reg, SRC_OP)' prevents BPF_STORE_REL from
using an uninitialized dst_reg.

We also do this check for BPF_ST in do_check():

  } else if (class == BPF_ST) {
          enum bpf_reg_type dst_reg_type;
<...>
          /* check src operand */
          err = check_reg_arg(env, insn->dst_reg, SRC_OP);
          if (err)
                  return err;

Thanks,
Peilin Ye


