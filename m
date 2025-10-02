Return-Path: <bpf+bounces-70237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C886BB50DF
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 21:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93BD7AC704
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627E72848B1;
	Thu,  2 Oct 2025 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku4eSs6K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6950276
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759434733; cv=none; b=DSoPvOo/U9Agi0BuB02Kp+FFes6SEJhGr+LOT3RBtD8K7h1ZOzlY/paTa7rM4+JU1FXagx0S3KQqExt6dynlzetSEOQshVJwRHFX7g6hOuPwuEnFltGvQwpVdsx1IbYDPNG0RNyR/dt+MJLUsgUhk9MrMaKUj0IqXqsNVeITS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759434733; c=relaxed/simple;
	bh=5J7nXbjukaFjFhsjdf58r7y3Tjb2GobrHtDlKC5E+BA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+C9rWw/qR7COQwaviGSYJ7UqDIwGZ5HoTN+CgxPp8A0j1nbawJnKYc52qUt9pQ5lA6F998Mw3cXnTQ2fP+vaISUTU1Vv3J7sG3fNwBBoDgEeNEosockPnuSbaT7tmAvufrtJSDs7K7gLnGY+36r5n3TV+knqHZWv1G/1auVvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku4eSs6K; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2897522a1dfso13568395ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759434732; x=1760039532; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sT7R1s43hfC8jGNhB2vCpg2SgdTHfdxif+U3iomqzJM=;
        b=ku4eSs6KvEO1M9AyvX1DROnXKQnMK0QKE0c0++Sh4OCW7jjsU666jKRFLQBVc6RyT4
         P1cTAjji+XntNOjZ4mcUE2uL78QPN6FZKAmFMh5mLHWPvG0rSQecXY2ABL5HYffU7UMx
         YnLI/NpHgphGGZt6Uhyjqf8fJDoz5P94EgLHYMEieUZVnZ48wOV2Iv/y15HReFCKey0w
         SpFA71YHKonuYk65NdLTGAaPXGp+Eam/1FbG8vAJgon383+XYUr7OMB+y07hR5XXveDg
         tcdMRvRHXb52rinhaRuKl789adADpse+N1AZBAtVzritPUpHODDiyHTctFRP+Xnja7LH
         WxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759434732; x=1760039532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sT7R1s43hfC8jGNhB2vCpg2SgdTHfdxif+U3iomqzJM=;
        b=qdZie0T5PPsnqBn5Zg/XsCH1UEdb3LqafAwTghcqjqAoKhi8PTQ7H+8NsZXgYtmDQa
         /PIGfZ/P8on0fZYrITmK5HD30eP16a/Bv7EFTkxdHQNTPSC3W+Fy2L9sNnMb8s+UY2X6
         W/f8eSDjqzgxy0Kjf+Q04Q58sXxZ3rPSFGqCp8MH3K9PjOXLWuQitKai94VRw5Oj4Un3
         wnGGMFhevPuF/MIXNI0lizW6OPalOGz1Q2MtRRbR4VbwzURejfsojE+PrJAa9LRBeJTf
         4n8sWfZx7cZadHBxlA3RwCXYTzi9HcjfjMPaO8QNCJ79Zj+a/3XEKZd3A9kj/cCB0MtF
         BhFA==
X-Gm-Message-State: AOJu0YxPK8mbxOYE+ap0/ozfHJ9/EAMh2DrWUOTYKL1/2BTKkdeg7NtU
	Bw0L04zAdPImp52MiQQmpMLFt+40XF6XnVCg4p/fPMeZXR9FSK67hm9P
X-Gm-Gg: ASbGncuh6LpfRS5788FWxJVohT+CdGsCvpKAPPwfEWXEK6zh/oQap7Y8/DzI11Echqp
	8HNWhV80ROlAU9MNErPBMkzESxf7+X01zPkKZeoGi75/5eiNPwAb5o+At95WwP5X3qYEder7aFL
	UhH4TV0NrhLjYpiq/E50EQBgYPx90L4x0gjpO9Ntuai4DKLnn+wSMoh1WS0I8h0CQtvjahxeK1N
	y4L8ODSXcCbkbhaKLnUA4SEm2eDJ6UCn6qMD4Adu6+VLXRa649Aobl3uSy3AoN/3Q59Di+ajpDB
	xUiOcai2blOh3JpKBHIIZzjYwYJGUJg3XZUSTjbuo6l8wRoc0wDCW8rk9I7AUKt+HqXVgJGoLnx
	NCI83/jSNBdujSVNajp8w/MCVzYUN0AJYyk1I7URWYwmW
X-Google-Smtp-Source: AGHT+IH3ICjFOD8py8c6vXjS4vQxltw9G++o713nSgNygEW+hFc69r0B0CuQWxkikrwIKIQmf6MwZQ==
X-Received: by 2002:a17:902:c94c:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-28e9a5f7246mr5833265ad.39.1759434731578;
        Thu, 02 Oct 2025 12:52:11 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110844sm28421805ad.23.2025.10.02.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 12:52:11 -0700 (PDT)
Message-ID: <f25e1970100d4d39572839e86bbed0fa819d7a05.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/15] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 02 Oct 2025 12:52:08 -0700
In-Reply-To: <aN5FcYKFLMV44igw@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-11-a.s.protopopov@gmail.com>
	 <8143e0481d68bb1793464c2d796fce7602695076.camel@gmail.com>
	 <aN5FcYKFLMV44igw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 09:27 +0000, Anton Protopopov wrote:

[...]

> > > @@ -14685,6 +14723,11 @@ static int adjust_ptr_min_max_vals(struct bp=
f_verifier_env *env,
> > >  				dst);
> > >  			return -EACCES;
> > >  		}
> > > +		if (ptr_to_insn_array) {
> > > +			verbose(env, "R%d subtraction from pointer to instruction prohibi=
ted\n",
> > > +				dst);
> > > +			return -EACCES;
> > > +		}
> >=20
> > Is anything going to break if subtraction is allowed?
> > The bounds are still maintained, so seem to be ok.
>=20
> Ok, I just haven't seen any reason to add because such code
> is not generated on practice. I will add in the next version.

Just less code and less tests if there is no special case.

[...]

> > > @@ -17786,6 +17830,210 @@ static struct bpf_iarray *iarray_realloc(st=
ruct bpf_iarray *old, size_t n_elem)
> > >  	return new;
> > >  }
> > > =20
> > > +#define SET_HIGH(STATE, LAST)	STATE =3D (STATE & 0xffffU) | ((LAST) =
<< 16)
> > > +#define GET_HIGH(STATE)		((u16)((STATE) >> 16))
> > > +
> > > +static int push_gotox_edge(int t, struct bpf_verifier_env *env, stru=
ct bpf_iarray *jt)
> > > +{
> > > +	int *insn_stack =3D env->cfg.insn_stack;
> > > +	int *insn_state =3D env->cfg.insn_state;
> > > +	u16 prev;
> > > +	int w;
> > > +
> >=20
> > push_insn() checks if `t` is in range [0, env->prog->len],
> > is the same check needed here?
>=20
> You wanted to say `w`? (I think `t` is guaranteed to be a valid one.)
> In cas of push_gotox_edge `w` is taken from a jump table which is
> guaranteed to have only correct instructions.

Yes, I meant `w`, sorry.
So, the invalid offsets would be rejected at map construction time?
I'd put a check here just to be consistent with push_insn, but skip it
if you think it's not really necessary.

[...]

> > > +static struct bpf_iarray *
> > > +create_jt(int t, struct bpf_verifier_env *env, int fd)
> > > +{
> > > +	static struct bpf_subprog_info *subprog;
> > > +	int subprog_idx, subprog_start, subprog_end;
> > > +	struct bpf_iarray *jt;
> > > +	int i;
> > > +
> > > +	if (env->subprog_cnt =3D=3D 0)
> > > +		return ERR_PTR(-EFAULT);
> > > +
> > > +	subprog_idx =3D bpf_find_containing_subprog_idx(env, t);
> > > +	if (subprog_idx < 0) {
> > > +		verbose(env, "can't find subprog containing instruction %d\n", t);
> > > +		return ERR_PTR(-EFAULT);
> > > +	}
> >=20
> > Nit: There is now verifier_bug() for such cases.
> >      Also, it seems that all bpf_find_containing_subprog() users
> >      assume that the function can't fail.
> >      Like in this case, there is already access `jt =3D env->insn_aux_d=
ata[t].jt;`
> >      in visit_gotox_insn() that will be an error if `t` is bogus.
>=20
> Could you please explain this once again? The error from
> bpf_find_containing_subprog* funcs is checked in this code.

Point being that there is no need to check if bpf_find_containing_subprog()
returns error:
- If we guarantee that `t` is within program bounds it can't fail
  (which I think we do).  In other places where this function is
  called it's return value is not checked for errors.
- In case if we don't guarantee that `t` is within program bounds,
  then just before call to create_jt() there is an access `jt =3D
  env->insn_aux_data[t].jt;` which would read from some undefined
  location. So, it's already too late to check here.

[...]

> >   /* "conditional jump with N edges" */
> >   static int visit_gotox_insn(int t, struct bpf_verifier_env *env, int =
fd)
> >   {
> >         int *insn_stack =3D env->cfg.insn_stack;
> >         int *insn_state =3D env->cfg.insn_state;
> >         bool keep_exploring =3D false;
> >         struct bpf_iarray *jt;
> >         int i, w;
> >=20
> >         jt =3D env->insn_aux_data[t].jt;
> >         if (!jt) {
> >                 jt =3D create_jt(t, env, fd);
> >                 if (IS_ERR(ptr: jt))
>=20
> (BTW, out of curiosity, do these "ptr: jt" type hints and alike
> come from your environment? What is it, if this is not a secret?)

Oh... sorry about that, I'll suppress those moving forward.
It's a copy-paste from tmux window.
In tmux there is a terminal running emacs in console mode.
Emacs uses eglot mode to integrate with clangd language server.
Eglot displays these parameter name hints, provided by clangd.
The whole thing ends up in copy-paste because in console mode all of
this is just text. Had I run emacs in gui mode, it wouldn't be
copy-pasted. But that's a remote machine, so here were are.

[...]

> > > +static int check_indirect_jump(struct bpf_verifier_env *env, struct =
bpf_insn *insn)
> > > +{

[...]

> > > +	n =3D copy_insn_array_uniq(map, min_index, max_index, env->gotox_tm=
p_buf);
> >=20
> > I still think this might be a problem for big jump tables if gotox is
> > in a loop body. Can you check a perf report for such scenario?
> > E.g. 256 entries in the jump table, some duplicates, dispatched in a lo=
op.
>=20
> Well, for "big jump tables" I want to follow up with some changes in any =
case,
> just didn't get there with this patchset yet. Namely, the `insn_inxed \ma=
pto
> jump table map` must be optimized, otherwise the JIT spends too much time=
 on
> this. So, this would require bin/serach or better a hash to optimize this=
. In
> the latter case, this piece might also be optimized by caching a lookup
> (by the "map[start,end]" key).

Ok, if follow-up is planned, we can stick with a simple implementation
for this patch.

[...]

