Return-Path: <bpf+bounces-69161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1587B8E3B4
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 21:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4027189828E
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579C2367AD;
	Sun, 21 Sep 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8mR7XgO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB027282E1
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758481953; cv=none; b=VWRiqwHzFtNd4v5UJD5Qoiy5tQCijjX13fwGrCUrzrrKfrjfcDHUEY8EO34Ufnplb7DjJwvuw+uRCCLFiv93UG/4S5FvZI9wdjVnJXkl5kK3jzKH3yTjHpTaw94L29EPmes0WWZpjjUOveS6Pv6BcczD5SCC/WUy9nufgnIhT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758481953; c=relaxed/simple;
	bh=W/iq39lgU/NA9p5HGaQ4t0v1Xju0saU+1/8JX79EhBA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qra1plXpRt2GFPUEvS08JJL6d7FrPbAOBTTtkwtaqxxm8hBf8mQYOXhmV1y8M+KE6qeeHjt8lryxMqmVBmri3BpMz21K5kath2FkNYiLZgw+/rME4Cn3o7dBWBKABiXBbpkjMhOenWGhBd1f8BsuqXXR9HxCBt+MblMcNALv7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8mR7XgO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso1798757a12.1
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758481951; x=1759086751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikpKvhuCkzVcFDlfjNUH5e49bXHzls1vrOqXMJ3tOE4=;
        b=F8mR7XgOybCR12g0it/GYzjfi3lcs8ZFbL3igGJPDkpN40J4b6EHkR/6Qutmb4ex3a
         PyvocTXt4+T5vAAJEZKLUsQLL73d07x9J9Qa9cbFn/U564mCTmXUZaLXjehXpKO1YVd/
         0NUSmpTdG/Fh4+1Wk5N/a0qXJXeCRGjettI/g9v024k3DfPm95dJSRlf49a1AQAZPG5I
         0NF7ezJP5wE2b5TJjv4QkCDz4oW3lrqFJB6L7KnZoupEJgrCRameLg33kX6zQkpS2gv9
         bYev4uRd3LstYUV+158BCcifLVYzRXju4QueNrr+nZDa6F2RcIf7xt0Qqa9PPOFNza3i
         9o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758481951; x=1759086751;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikpKvhuCkzVcFDlfjNUH5e49bXHzls1vrOqXMJ3tOE4=;
        b=OVgm1UUCw8XLuQhUwR4JCM56UQ95FCdx9CCmB1hD+ChK8ntodDyHjmm1kSXQR6XW0F
         5IJl15ylfCziaHt2PY56dlQQTyRpzRRfIc6T7Avh5/cQAGQCcSdUrXPJ9sZxN1XWYnpu
         ku31mFjnALC5QlfvxD43xNEyoVfm6HpjNvP99kBsG9HPrqtpQltrSRa4tODnlANhxOdR
         XQeWZ3Mb2gGakpyC1S6TbT/aptJff5rvVoUyduDXSaFpu54FJjnQe4Y1UdQej8WhsXI7
         P/7VIT1okVHqTKacDcjMLWmp22RElI6jB0KF125ABX9HoMfEcX2OLA5EHspdUw0+xtUS
         vSfg==
X-Forwarded-Encrypted: i=1; AJvYcCWJiCFQaItd77OmnJNdxu9PwR6cOHFnk3SgjIU7UUc84DcCdH/j1mlu5Ml0RbZq0PCxYPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzljQp4yOUgnprqiB8Q7655vxRr0TOdbUASHxuJNHMAfOEc37Iu
	8i0ieQ5dD2yT93WAvs9WHLUU9Go4kzLcQGCE5YtrivwtDdIyI2jU/Oj1xbWnsw==
X-Gm-Gg: ASbGncuQE4BHjnZ1PUSEWMk4WKLgHJCdIqGfN/BpW5mxnoedmeseMhfBKkPjMegzGYa
	9NZzUpWaEX8BmB5havMWeMRRfqEIo3B8ekxjAaK4ZNdFnU7ItsFE4sFqg+crJfq/hSLcRRsWdEh
	0IwE7j2ZTKCTDfy4472pXrkxG/2MPpNbsxmEY5rrw52YspW++UOd7TU3h9FH4BAWByjZB0akXvm
	tSn2NW8apmJCoBZsX/4L1z8uXbKPQgluOZvWZ64JccPH6JQ56pM+CLVzcYX3oI6/QV5ApF3JIYf
	Wu4ASMtqbNbW9A6oznZQ1YOBJthNClkJUcbWygofKM15PzDIj0fmFsRg3J6xFE9zXIfgCKxJPuS
	vg7uBHY8JRfHThslH1tA=
X-Google-Smtp-Source: AGHT+IEE/7Qu+seYGSuyEb5ynpY1pTdcjNmd1co/6KxkmaXKfVhZ5UP9+x1Dr6Npo2iQhqFlNtI2Gg==
X-Received: by 2002:a17:902:f711:b0:265:a159:2bab with SMTP id d9443c01a7336-269ba271a17mr118149045ad.0.1758481950899;
        Sun, 21 Sep 2025 12:12:30 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803601e3sm111431155ad.144.2025.09.21.12.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 12:12:30 -0700 (PDT)
Message-ID: <4aaabc828a1b768ab03c68ae521e55993b808f43.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/13] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Sun, 21 Sep 2025 12:12:27 -0700
In-Reply-To: <61861bfd86d150b86c674ef7bea2b23e3482e1f2.camel@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
		 <20250918093850.455051-9-a.s.protopopov@gmail.com>
	 <61861bfd86d150b86c674ef7bea2b23e3482e1f2.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 17:28 -0700, Eduard Zingerman wrote:

[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5c1e4e37d1f8..839260e62fa9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c

[...]

> > +/* gotox *dst_reg */
> > +static int check_indirect_jump(struct bpf_verifier_env *env, struct bp=
f_insn *insn)
> > +{
> > +	struct bpf_verifier_state *other_branch;
> > +	struct bpf_reg_state *dst_reg;
> > +	struct bpf_map *map;
> > +	u32 min_index, max_index;
> > +	int err =3D 0;
> > +	u32 *xoff;
> > +	int n;
> > +	int i;
> > +
> > +	dst_reg =3D reg_state(env, insn->dst_reg);
> > +	if (dst_reg->type !=3D PTR_TO_INSN) {
> > +		verbose(env, "R%d has type %d, expected PTR_TO_INSN\n",
> > +			     insn->dst_reg, dst_reg->type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	map =3D dst_reg->map_ptr;
> > +	if (verifier_bug_if(!map, env, "R%d has an empty map pointer", insn->=
dst_reg))
> > +		return -EFAULT;
> > +
> > +	if (verifier_bug_if(map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY, env,
> > +			    "R%d has incorrect map type %d", insn->dst_reg, map->map_type))
> > +		return -EFAULT;
> > +
> > +	err =3D indirect_jump_min_max_index(env, insn->dst_reg, map, &min_ind=
ex, &max_index);
> > +	if (err)
> > +		return err;
> > +
> > +	xoff =3D kvcalloc(max_index - min_index + 1, sizeof(u32), GFP_KERNEL_=
ACCOUNT);
> > +	if (!xoff)
> > +		return -ENOMEM;
>=20
> Let's keep a buffer for this allocation in `env` and realloc it when need=
ed.
> Would be good to avoid allocating memory each time this gotox is visited.

On a second thought, maybe put this array into bpf_subprog_info for
each function and avoid copy/sort on each gotox instruction as well?

> > +
> > +	n =3D copy_insn_array_uniq(map, min_index, max_index, xoff);
> > +	if (n < 0) {
> > +		err =3D n;
> > +		goto free_off;
> > +	}
> > +	if (n =3D=3D 0) {
> > +		verbose(env, "register R%d doesn't point to any offset in map id=3D%=
d\n",
> > +			     insn->dst_reg, map->id);
> > +		err =3D -EINVAL;
> > +		goto free_off;
> > +	}

[...]

