Return-Path: <bpf+bounces-49595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA316A1A982
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41063188DBD6
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15CB15ECDF;
	Thu, 23 Jan 2025 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4/ZwXGx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC3154C07;
	Thu, 23 Jan 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656376; cv=none; b=Yak7HCCQ62UUVCHaCZUv7t95Zn2L6D849wleN/XSYsJ6uXcRN0bd9rc1l6QvFyEJfL0/l1i4d7P66GasnOF/1oswlWwoG72jVU4jlWk0QjJHC1TZFPL/9MFnh3xTlJKnKl9LJK5AGf1Eike/K9W+nYp2A+Y0SESprs1kBz1qlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656376; c=relaxed/simple;
	bh=Qo5fWj1zKBNd9HzU4UOFr1uVC2RZQehBoYz2peB7k04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lh64nWkrw7dzcYCtiD6xyLrX216rAx4yqWZGMN4mOltEz0uzwoCxjccqRNkmE+/GaclO2EUqPl9xlUFK1wufpG+IUjQ+x0qo0Jyd5axBU39WSLAByFDBxCj5zAPV2+d5HWKgKoz0RQO49nE1QaD2P40aTVPYziD++qgAfFNl/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4/ZwXGx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216281bc30fso29670425ad.0;
        Thu, 23 Jan 2025 10:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737656374; x=1738261174; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sMZ2jYFfZhsuTH44ef3hdfzU42i+idlx+oq2MqBXpG4=;
        b=Q4/ZwXGxTScWGbbIoXDT9sGDyftLuYwIO9dTN6iqfZeZMC7+qhX8aAG36gpVr8FTPE
         0NOLMD1XkrCCaNm3AnV2rAUhn5HB/RVnKWIjbSoSgdzH99z2CmBB1LvVqvcpkwLUWLFl
         /kbrucYrWuET+/u/hztVMNBz4A79h3r36GhZwe0khTjaxnB7ZGtSmgqClKgB00ZMdg55
         bizhfzJV95W+lVoB1taRTlbaoQaDaErgZ54AuLNJ2AE3ACQyeUvyC7pn0UyEsI7eiIuZ
         QkcnWJ095VIj574zHQQg8XW+2W+G9mJYxJl7hEBgFiLb3GGcT1nnzG8OXdFVti+IMs4w
         Yvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737656374; x=1738261174;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMZ2jYFfZhsuTH44ef3hdfzU42i+idlx+oq2MqBXpG4=;
        b=Y4KHONMECVbCRYkmmZcELJq5nq2pbs7f4YdnWE2Kcr9JyCUkgNg+Wrks4mMWQ0zQ6a
         24r33ozREL7KS8ttd+YLHV53LfmNIlJKSb00zUeeY6fCAzA/Vh1k2cJYnv3/FVSoE1lp
         GovjkiMqqjYMc2xwV2pXq+E69ACLgzWItED/yHnstjG2xcJHkaBPAWmIWHIMMikFf9CO
         ikxId18CBpOICJODv9Fvvr7u2ATuv5Ll1UTZw/csxzVpRosQKTP2IkmRKkRoNvq6P5bv
         C0JKozidRZfjJhvAzghP11ypP86Z1HZcyWGispxGrDSIgNGbh1E30wu3Ld/g7UPk8Vz0
         Kqcw==
X-Forwarded-Encrypted: i=1; AJvYcCVWPcVd/a/Fum+n/c2rTSgJ+fBSXucBky6rbXtT0t6g0H9pDq+qYX4vsjV8leVp/QARexolrGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLPPHF/lF0tKVboH5aNjV+N58Pu5srTeC9CxF8d9uDV1o1A4h
	Q+bbTUQPaSIYetbebCBY2SMvT+MVl+/EPc6rDQ4CTJwj68cGRTxP
X-Gm-Gg: ASbGncsj4u3rEi+FhjIeQj3vhPcY+eEFsvJK2F1Qe+YNXqXQPNplmuPbb5fKpKjrnyC
	+9jkHOV+GlrN/NaeC3PP7EmVOMMS8a3vrqVnb51v9ZuQQfpHyzfKXrKpI6k001IOpTrwQ2/QpGe
	sESvUUBp7b4xBVTcIEBHEd99cjpDZUkSgReJDVnDdH22ozeKi6qVERwD9mA8ocqqo3Wt7d/E4fg
	2ysN2YWR0fyL4jIHukgrdtQuPM2o1Xh9mbHSSz0dE+6NBCMuko1dfTijYBs2YGIA+GlCpYG/BVi
	Lw==
X-Google-Smtp-Source: AGHT+IGs5y/ivod26h5zsRDQNQx+qoRNcCRTJcZAMbw4lS8UC+jTLrDiY/OyghhNk597BkOYKN3GjA==
X-Received: by 2002:a05:6a21:78a5:b0:1e0:f05b:e727 with SMTP id adf61e73a8af0-1eb21460228mr45119443637.2.1737656374123;
        Thu, 23 Jan 2025 10:19:34 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a7614c4sm226336b3a.120.2025.01.23.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 10:19:33 -0800 (PST)
Message-ID: <ce0ecfc9685515cffd878ba3a326527df7ad7ccf.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/14] bpf: Allow struct_ops prog to return
 referenced kptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Date: Thu, 23 Jan 2025 10:19:28 -0800
In-Reply-To: <37a51a1f055f61911f7a4df9e8072f76412ad136.camel@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
			 <20241220195619.2022866-4-amery.hung@gmail.com>
	 <37a51a1f055f61911f7a4df9e8072f76412ad136.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-23 at 01:57 -0800, Eduard Zingerman wrote:

[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 26305571e377..0e6a3c4daa7d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10707,6 +10707,8 @@ record_func_key(struct bpf_verifier_env *env, s=
truct bpf_call_arg_meta *meta,
> >  static int check_reference_leak(struct bpf_verifier_env *env, bool exc=
eption_exit)
> >  {
> >  	struct bpf_verifier_state *state =3D env->cur_state;
> > +	enum bpf_prog_type type =3D resolve_prog_type(env->prog);
> > +	struct bpf_reg_state *reg =3D reg_state(env, BPF_REG_0);
> >  	bool refs_lingering =3D false;
> >  	int i;
> > =20
> > @@ -10716,6 +10718,12 @@ static int check_reference_leak(struct bpf_ver=
ifier_env *env, bool exception_exi
> >  	for (i =3D 0; i < state->acquired_refs; i++) {
> >  		if (state->refs[i].type !=3D REF_TYPE_PTR)
> >  			continue;
> > +		/* Allow struct_ops programs to return a referenced kptr back to
> > +		 * kernel. Type checks are performed later in check_return_code.
> > +		 */
> > +		if (type =3D=3D BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &&
> > +		    reg->ref_obj_id =3D=3D state->refs[i].id)
> > +			continue;
> >  		verbose(env, "Unreleased reference id=3D%d alloc_insn=3D%d\n",
> >  			state->refs[i].id, state->refs[i].insn_idx);
> >  		refs_lingering =3D true;
> > @@ -16320,13 +16328,14 @@ static int check_return_code(struct bpf_verif=
ier_env *env, int regno, const char
> >  	const char *exit_ctx =3D "At program exit";
> >  	struct tnum enforce_attach_type_range =3D tnum_unknown;
> >  	const struct bpf_prog *prog =3D env->prog;
> > -	struct bpf_reg_state *reg;
> > +	struct bpf_reg_state *reg =3D reg_state(env, regno);
> >  	struct bpf_retval_range range =3D retval_range(0, 1);
> >  	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> >  	int err;
> >  	struct bpf_func_state *frame =3D env->cur_state->frame[0];
> >  	const bool is_subprog =3D frame->subprogno;
> >  	bool return_32bit =3D false;
> > +	const struct btf_type *reg_type, *ret_type =3D NULL;
> > =20
> >  	/* LSM and struct_ops func-ptr's return type could be "void" */
> >  	if (!is_subprog || frame->in_exception_callback_fn) {
> > @@ -16335,10 +16344,26 @@ static int check_return_code(struct bpf_verif=
ier_env *env, int regno, const char
> >  			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> >  				/* See below, can be 0 or 0-1 depending on hook. */
> >  				break;
> > -			fallthrough;
> > +			if (!prog->aux->attach_func_proto->type)
> > +				return 0;
> > +			break;
> >  		case BPF_PROG_TYPE_STRUCT_OPS:
> >  			if (!prog->aux->attach_func_proto->type)
> >  				return 0;
> > +
> > +			if (frame->in_exception_callback_fn)
> > +				break;
> > +
> > +			/* Allow a struct_ops program to return a referenced kptr if it
> > +			 * matches the operator's return type and is in its unmodified
> > +			 * form. A scalar zero (i.e., a null pointer) is also allowed.
> > +			 */
> > +			reg_type =3D reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NUL=
L;
> > +			ret_type =3D btf_type_resolve_ptr(prog->aux->attach_btf,
> > +							prog->aux->attach_func_proto->type,
> > +							NULL);
>=20
> This does not enforce the kernel provenance of the pointer.
> See my comment for the next patch for an example.
>=20
> I think such return should only be allowed for parameters marked with
> __ref suffix. If so, pointer provenance check would just compare
> reg->ref_obj_id value with known ids of __ref arguments.

After looking at the selftests in patch #13, it appears that I
misunderstood the line:

"2) The pointer originally comes from the kernel (not locally allocated)"

And the only thing you'd like to exclude here is 'bpf_obj_new'.
In which case my comments for patches #3,4 are invalid.
Sorry for the noise.

[...]


