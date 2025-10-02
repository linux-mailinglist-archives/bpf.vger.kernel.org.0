Return-Path: <bpf+bounces-70185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769EBB2C69
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 10:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E7B1C75A4
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 08:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222D2BE651;
	Thu,  2 Oct 2025 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvV6NcXS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05F18FC80
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392592; cv=none; b=jwGGteiSpbgGv7Ez5QTWexy0U6XPHtnc9BeynAFlm/tYciagTLywnLVqYdguxXPVtY4qWeZGcssGNgH/Q9pj6gO/qp8xX/ah68liqNWSMMeRiPEjpTUyVNCqNNw2wKNvnj/dvwOfhcPbrrwGqXD31QDo2J+CU5jVL0VGYmWpcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392592; c=relaxed/simple;
	bh=XwO8hPzLy3v2E5oYkMY0gR9xVxA/A1xD8sotvCtcEj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHnSCnlXvaAObugtKBB1V6ey/BdClamf0ZhZZPVg84/9xEyURk/olGgb4LXrGdtlPurCAXFcQ4cPXgzBmEt2rkYAW/Wga/iG8rQ5y/a00GaQHtnAmFus6kLROHGcYi4KjOJjjiirM7lkv4KwiDx9GLt+C2cmjbpPs5HXWdjq8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvV6NcXS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so8174615e9.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759392589; x=1759997389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsfImNFh0wexkZZqwrZ23A1aiTQQ60Sh9Gi+ePUbwFU=;
        b=FvV6NcXSdvRgfj3iUCzwam4C4t1v6GMDrY4zyWJ+3txFaBqKsJEKuuTVCxwaCKkPSg
         b8HYw6u5wdz8jCwFGi6a4zwsMzTGN/YRAGSvm9+Wzt8F9vFGJKb4lvFUQSlnjwu1dLfs
         pWwHm4FFAAfB9/FO+DBax1DZKYjF2bkoFsNIUnHpoh1p1rMbgs0iTYZ7d30h731BP1L7
         7Zq/j5i8p5wz1U4T0G64KQi2TN+geB36rMmR+Oi2kKy+kB3RfDm4cppFH5CtaP/YrQ9u
         cdX1fceKWUEQNZ5QtQEzA8T9F30M6PoIMxTCUvwV4HYKtDC/XqhTJ5RXlfgWmMJ5sXBy
         LjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759392589; x=1759997389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsfImNFh0wexkZZqwrZ23A1aiTQQ60Sh9Gi+ePUbwFU=;
        b=YmTczGPNSs1VVUkuC9R3+c+bVyGX+D9JqZtz5t+ZTug2+c+ESB12qBewmg+1FHSOWi
         heN++Nomw7dHTSRb66+ZFkOJbLqMDhEKJmkva7mpsO4Qf1NG+tVbLlsC9g13ceFKj0YW
         4Jrb1gnVoNGUWcUOei7Gn9O+i6VpasixkrIe456PinBMRjKgErWsQ7kcxVuTQuzxtrvJ
         +hc41HuF6ZE4Wcf+sacVt9zULZY8itJ2T2fBgWZRIhDZmNkPCYFtrjck9lNpMGLsBn2y
         L6MAYfEamQItf/quf11HTUpONsRdztvZYpjKoKfTkabFwtOl0e8k2W8lfFcUK9TjCuY8
         sEXg==
X-Gm-Message-State: AOJu0YyrypKpN0WKEZwyoOb42ZkLZu8Gs5YXYt3Ux7FqEkBjL0/wikSs
	OS9VsofVIxwbsgiUoAKeLipkZ/XUrAHWL4I9uK8UHnSJy4P7LQPdG1RCtoz3+A==
X-Gm-Gg: ASbGnctvLtWgnp73bX/5OXuIed/je7UXWyFZZT4CKfi3XZa5cB5K/pUEkVVL9TQhAi7
	0HWIx2d40l4vhOoFmGV2EjVIlwPuEX5iuS/BabbVzdXc9Y608mksTO5DoWb2BqBT38Uqv2Vg6iD
	P0bUzTOgk55dB6/JMdFoRQHb7EhfKCemGFRaExRR8pQzdDItRuewlnTvr97Ck1BBVH5ThUH+fbN
	tyktbcO+bwNgFSuzGqVGn5cLk/KN2wUIZEzve6EVyyhkhN9hpi2uPwPuLIsmUq36DS/mX26y7OB
	sWi5g5dG8jh9EqdnqmE4QprP2yfLOlDjnKCvPDyunVWrgOyrbBo5wuLxs1ey9WGmJLXewvfQz/f
	7EHwCiFj0EtVLOlR6A1D4NXaUX2FFyfn2yMV66srdjn/3aLYYHV1KhWSk
X-Google-Smtp-Source: AGHT+IGRkr0OQy8mqukTtBs9YFPrGkOcGBKIfeAAJyMC1CbcdRQHV3SJjZW/jYUergXRagfaVhBA/g==
X-Received: by 2002:a05:600c:6306:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-46e612e54acmr46659875e9.34.1759392588375;
        Thu, 02 Oct 2025 01:09:48 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a0241bsm68960895e9.11.2025.10.02.01.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:09:47 -0700 (PDT)
Date: Thu, 2 Oct 2025 08:16:09 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 09/15] bpf: make bpf_insn_successors to
 return a pointer
Message-ID: <aN40ya0mv5Rp8F/v@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-10-a.s.protopopov@gmail.com>
 <eddce884140f3df9e6c3c7e1b873a570b163ce1d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eddce884140f3df9e6c3c7e1b873a570b163ce1d.camel@gmail.com>

On 25/10/01 03:39PM, Eduard Zingerman wrote:
> On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> > The bpf_insn_successors() function is used to return successors
> > to a BPF instruction. So far, an instruction could have 0, 1 or 2
> > successors. Prepare the verifier code to introduction of instructions
> > with more than 2 successors (namely, indirect jumps).
> > 
> > To do this, introduce a new struct, struct bpf_iarray, containing
> > an array of bpf instruction indexes and make bpf_insn_successors
> > to return a pointer of that type. The storage for all instructions
> > is allocated in the env->succ, which holds an array of size 2,
> > to be used for all instructions.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> (but please fix the IS_ERR things, see below).
> 
> [...]
> 
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -509,6 +509,15 @@ struct bpf_map_ptr_state {
> >  #define BPF_ALU_SANITIZE		(BPF_ALU_SANITIZE_SRC | \
> >  					 BPF_ALU_SANITIZE_DST)
> >  
> > +/*
> > + * An array of BPF instructions.
> > + * Primary usage: return value of bpf_insn_successors.
> > + */
> > +struct bpf_iarray {
> > +	int off_cnt;
> > +	u32 off[];
> > +};
> > +
> 
> Tbh, the names `off` and `off_cnt` are a bit strange in context of
> instruction successors.

insn_offsets / insn_offset_cnt?

> [...]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 705535711d10..6c742d2f4c04 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17770,6 +17770,22 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
> >  	return 0;
> >  }
> >  
> > +static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
> > +{
> > +	size_t new_size = sizeof(struct bpf_iarray) + n_elem * 4;
> 
> Nit: n_elem * 4 -> n_elem * sizeof(*old->off) ?

Yes, thanks.

> > +	struct bpf_iarray *new;
> > +
> > +	new = kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
> > +	if (!new) {
> > +		/* this is what callers always want, so simplify the call site */
> > +		kvfree(old);
> > +		return NULL;
> > +	}
> > +
> > +	new->off_cnt = n_elem;
> > +	return new;
> > +}
> 
> [...]
> 
> > @@ -24325,14 +24342,18 @@ static int compute_live_registers(struct bpf_verifier_env *env)
> >  		for (i = 0; i < env->cfg.cur_postorder; ++i) {
> >  			int insn_idx = env->cfg.insn_postorder[i];
> >  			struct insn_live_regs *live = &state[insn_idx];
> > -			int succ_num;
> > -			u32 succ[2];
> > +			struct bpf_iarray *succ;
> >  			u16 new_out = 0;
> >  			u16 new_in = 0;
> >  
> > -			succ_num = bpf_insn_successors(env->prog, insn_idx, succ);
> > -			for (int s = 0; s < succ_num; ++s)
> > -				new_out |= state[succ[s]].in;
> > +			succ = bpf_insn_successors(env, insn_idx);
> > +			if (IS_ERR(succ)) {
> 
> This error check is no longer necessary.

Yes, thanks. I've removed these checks, but these chunks escaped
to the "indirect jumps" patch. Moved them back.

> [...]

