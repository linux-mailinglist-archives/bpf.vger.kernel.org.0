Return-Path: <bpf+bounces-50467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CAA2814D
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1916A188754E
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A3322839C;
	Wed,  5 Feb 2025 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OonXhac/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D204A28;
	Wed,  5 Feb 2025 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718848; cv=none; b=cfr3HGntgXtjJn3vEtpWmrjptehac+39AmXXXSdiQmvNY24C0UiNID6o+vWukHwz266klV6WUp2o2WZZgDKErYz7pZWYU815kxHexEhbJQVc1b/zKK5DAqPUvQ9nGdFKNfvBxpp72jIurzwirXhWO4fdDyeFQnk4Rw9J4LGe5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718848; c=relaxed/simple;
	bh=+ANZXGKv/h/FiSlG1zS/x4TdUGLCCZ8+OcdkEve8Kv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFrw14EfkO4bQINo31z7uTKTDFeGR2JhVizz45w6290dn5oTcJZD2NjQK1ypPKFO5B5nx10AYD4MLo+vsG96zo6IVrwiVDD+zbYRCYOObMpoCzL0GagpEhK+mCM5lMlPbvmSWR7sSQCx1zPTuIAfU3GpTSSYbKyxMdeCq9rFwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OonXhac/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF56C2BCB9;
	Wed,  5 Feb 2025 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738718847;
	bh=+ANZXGKv/h/FiSlG1zS/x4TdUGLCCZ8+OcdkEve8Kv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OonXhac/u+XsxTMdDM10AQIJjt9lfDluLPWLkyz72np98vmUimtRMjKwdG8wvKLps
	 7bU7sMWWMqpsNKXhtbgu3YH2mNhJzTncyrEx4o5R2qUS4eUV0QZDi7Pz1kmJnMaFrM
	 JJO5cXciOF3z2uKUVeiY7eSBh9M8fGzJs77dq/ChV0wuF3FxQ2Zb03A+tK/mKJanpR
	 m4SgF3174GXvR4kh/whQidrjg2w78Ho6dFRqanCBXGKgO2/QDli8wQ6ebBQ6xvgnQO
	 Kw66PkVXuJD3vQ1oOhavg5N4CvyyrEcFMi7LEn1WSNn2DIT/HLHeatXVlCDuUEk8GW
	 WpCv+8u1OzIsg==
Date: Tue, 4 Feb 2025 17:27:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com,
 jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 08/18] bpf: net_sched: Support
 implementation of Qdisc_ops in bpf
Message-ID: <20250204172725.30068497@kernel.org>
In-Reply-To: <CAMB2axNNvNMy1o6m2DKFwF7O2AkgxZXUW+6rwhhc=788v_KM+Q@mail.gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
	<20250131192912.133796-9-ameryhung@gmail.com>
	<20250204141851.522ae938@kernel.org>
	<CAMB2axNNvNMy1o6m2DKFwF7O2AkgxZXUW+6rwhhc=788v_KM+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Feb 2025 15:21:27 -0800 Amery Hung wrote:
> On Tue, Feb 4, 2025 at 2:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Fri, 31 Jan 2025 11:28:47 -0800 Amery Hung wrote: =20
> > > +             if (new &&
> > > +                 !(parent->flags & TCQ_F_MQROOT) &&
> > > +                 new->ops->owner =3D=3D BPF_MODULE_OWNER) {
> > > +                     NL_SET_ERR_MSG(extack, "BPF qdisc not supported=
 on a non root");
> > > +                     return -EINVAL;
> > > +             } =20
> >
> > This check should live in bpf_qdisc.c =20
>=20
> Might be a dumb question, but could you explain why this is preferred?
>=20
> I can certainly do the check in Qdisc_ops::init instead though.

Basic SW abstractions, this is the generic layer, bpf_qdisc is just
one implementation that plugs into it.

