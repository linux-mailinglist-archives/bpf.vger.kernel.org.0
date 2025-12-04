Return-Path: <bpf+bounces-76036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A5CA2BEE
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 09:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC7343080823
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1AC328242;
	Thu,  4 Dec 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+VGH1LY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB4328255
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835349; cv=none; b=ABQS+3M0A8IdtI9xerCPYqkq72DcHi4AO+9E/grrurT4VzBRPlGa5Jvi35ulwKno2Pxf0XteZ8p3cUTl9J5s1Y1qtHQ2SM8GZMBkuS03RNm2zed44lEESzYVTCF+0grAyPsrxJVEXLjLqge8QZ4n1blGIIG6+qdfTUU806aUe8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835349; c=relaxed/simple;
	bh=lJ9GLo6qNwbYdObJpEz2p3lrlzvPyzim33dW1EpuxrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNg5WFG0uDNWIoaEu36vcnEZxl/T687ENMTm79LwDmNOGP2kgQByjKHU4RyIppwaCrtO6ZKWXaRDjWNKHgjrMwf9ws1p0YcIF+Y227BILd3+zPxVo61u5QHjdj/AC/D3LrQQKgTU8oRdko4FsrAa9fo61L067xMNeMjseOEzf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+VGH1LY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so992380a12.2
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 00:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764835338; x=1765440138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8hGtBMRD+rcVPyTTCewFCBFo6dX8+Tj2kyRZznjtWs=;
        b=G+VGH1LY2FEAoktnd7MEhL0HB/ogcmXvRW7ngVxLTS2HrCP236mdmktNhENGQybORr
         Q58HLX08Q5gpoDt6S1ZlRPENEaaP7SqoBpFsdGBexLJ5kXuquVi8luzuW/qn9qzQEwkj
         3POnD4vbopIGAwbmMRSlOA18CFnbxtsIr8XO+ZfYAb6WBVlmSStY98H619/CIIAWhSwH
         v7jlNBBELOemKkOEmd0pJgMYtU8X5cs6gLFNX1RyjvKBsnBBXhrfrKCVSU8k8xvI+yt8
         8fd0kKlSdc/+JuhaIDsAofaBqP4LydYbf6IvWq4SfUb4gA6UdSqOMdqRbB7Kdu9CrAIA
         dEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764835338; x=1765440138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8hGtBMRD+rcVPyTTCewFCBFo6dX8+Tj2kyRZznjtWs=;
        b=Ao8un/jpUXEGnwvgXxtBs7wsYhxUyAng3LJ+fdcJxS19sV+DuHhhZvqYA/FZbsE4aZ
         zbmiwEGxk4y7GSy0t3Rr50yu7OSwdyr60HbG1NQoNsFvqXFq5qzrXONR/LuirXkUFIac
         ocXq1DpxABUIFNkX42UwNNAVnEJEPXhdhPQ7n4GkW+5opibJwoJWmizMViA0z2nEhiw+
         vS9ZB97HdiDCAbbDrR1ICD1TDLKvOeEXXOgzNYzJeAtCqMMm6+6R+xhuabOeWPnYcQp1
         CAPvEdV2mN+JaZEdmDNIPYi2b+61bNcfhEXHwhHW5Hqek2tM/B30Cju/SJb6MRBQIxCx
         bmLQ==
X-Gm-Message-State: AOJu0YzLhW0vYah7pKCp3DrpA/QAGc/sZ+2lYPZf9XLz83YYn1VPBh4M
	1JV0XxFISwIiUge31YNplDjqB9/RUJss6NV8lNIgfzyZFTEzNInl5aZE
X-Gm-Gg: ASbGncvJ2vRARBHmPFME7CZWCOggLccU3TO0yjrNNF5AzTr9eyR0gPjqb7E8qTceflD
	SFxh0A1rYkvUzF6zvkPMNFc/J4G3hkPaIoJnFK8pc+kExP2fjUluuaFz721rqnX2MzQvYKBO9IN
	RepR55XlgiGFDt8hAQyFu4/qdA9+tjpzhacbu1sxr6mEhLgQ2UGkuDGQcWrjE9T343NG3BUNCP0
	i63ysybuV1nGPbyn1jih0DeuzihHZZGK/wnzTa4y09eE+Mf9thVfIXeOhcWflNs+ciTf8CfIem1
	KH3oA8MhbRvl3As2N21koc22fTYECBljpypMlUkcB+oTFfHfvpo+sOOFiZZy5ffei8DweDnzGxj
	hZG70hFCYtaR6QxQabRWfoTyIgfQn061deCIImACKkrA583iAqg/TiW9A1ccvK+YB4sO+VgSue5
	Z/Yw+o/nv8JOJ11ibg2WBg
X-Google-Smtp-Source: AGHT+IF/XgyufGZSoLe7qqHojiTFunMrzxOx3gZ5NmM5lO/sjEagtxgC3dq0+bhv4pQVvs0RHK/ltw==
X-Received: by 2002:a05:6402:1ed1:b0:641:8d6b:88cb with SMTP id 4fb4d7f45d1cf-6479c519a4emr5058123a12.28.1764835337680;
        Thu, 04 Dec 2025 00:02:17 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b368dc2asm580736a12.20.2025.12.04.00.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 00:02:17 -0800 (PST)
Date: Thu, 4 Dec 2025 08:09:19 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Message-ID: <aTFBrxSsaBoOhB7Z@mail.gmail.com>
References: <20251127140318.3944249-1-xukuohai@huaweicloud.com>
 <aSh4QCd27MUHMVdp@mail.gmail.com>
 <aSiAeTnrh9JQ0EGh@mail.gmail.com>
 <3fd352f0-2445-4fee-8c0a-8fb24efc2dc8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd352f0-2445-4fee-8c0a-8fb24efc2dc8@huaweicloud.com>

On 25/12/04 02:47PM, Xu Kuohai wrote:
> On 11/28/2025 12:46 AM, Anton Protopopov wrote:
> 
> [...]
> 
> > > > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > > > index 61ce52882632..ed20b186a1f5 100644
> > > > --- a/kernel/bpf/bpf_insn_array.c
> > > > +++ b/kernel/bpf/bpf_insn_array.c
> > > > @@ -299,3 +299,46 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
> > > >   		}
> > > >   	}
> > > >   }
> > > > +
> > > > +bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> > > > +		if (is_insn_array(prog->aux->used_maps[i]))
> > > > +			return true;
> > > > +	}
> > > > +	return false;
> > > > +}
> > > 
> > > I think a different check is needed here (and a different function
> > > name, smth like "bpf_prog_has_indirect_jumps"), and a different
> > > algorithm to collect jump targets in the chunk below. A program can
> > > have instruction arrays not related to indirect jumps (see, e.g.,
> > > bpf_insn_array selftests + in future insns arrays will be used to
> > > also support other functionality). As an extreme case, an insn array
> > > can point to every instruction in a prog, thus a BTI will be
> > > generated for every instruction.
> > > 
> > > In verifier it is used a bit differently, namely, all insn arrays for
> > > a given subprog are collected when an indirect jump is encountered
> > > (and non-deterministic only in check_cfg). Later in verification, an
> > > exact map is used, so this is not a problem.
> > > 
> > > Initially I wanted to have a map flag (in map_extra) to distingiush between
> > > different types of instruction arrays ("plane ones", "jump targets",
> > > "call targets", "static keys"), but Andrii wasn't happy with it,
> > > so eventually I've dropped it. Maybe it is worth adding it until
> > > the code is merged to upstream? Eduard, Alexei, wdyt?
> > 
> > Actually, this is even better to mark a map as containing indirect
> > jump targets in check_indirect_jump(). This will be the most precise
> > set of targets, and won't require any userspace-visible changes/flags.
> > 
> > Something like this:
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 6498be4c44f8..c2d708213330 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -292,6 +292,10 @@ struct bpf_map_owner {
> >   	enum bpf_attach_type expected_attach_type;
> >   };
> > +/* map_subtype values for map_type BPF_MAP_TYPE_INSN_ARRAY */
> > +#define BPF_INSN_ARRAY_VOID		0
> > +#define BPF_INSN_ARRAY_JUMP_TABLE	1
> > +
> >   struct bpf_map {
> >   	u8 sha[SHA256_DIGEST_SIZE];
> >   	const struct bpf_map_ops *ops;
> > @@ -331,6 +335,7 @@ struct bpf_map {
> >   	bool frozen; /* write-once; write-protected by freeze_mutex */
> >   	bool free_after_mult_rcu_gp;
> >   	bool free_after_rcu_gp;
> > +	u32 map_subtype; /* defined per map type */
> >   	atomic64_t sleepable_refcnt;
> >   	s64 __percpu *elem_count;
> >   	u64 cookie; /* write-once */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 766695491bc5..60bbd32e793a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20293,6 +20293,12 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
> >   		return -EINVAL;
> >   	}
> > +	/*
> > +	 * Explicitly mark this map as a jump table such that it can be
> > +	 * distinguished later from other instruction arrays
> > +	 */
> > +	map->map_subtype = BPF_INSN_ARRAY_JUMP_TABLE;
> > +
> >   	for (i = 0; i < n - 1; i++) {
> >   		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
> >   					  env->insn_idx, env->cur_state->speculative);
> > 
> 
> Looks good to me. Would you like to submit it as a separate patch, or
> shall I include it in my patch with your SOB?

Ok if you just include it, makes sense as part of your changes.

