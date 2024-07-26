Return-Path: <bpf+bounces-35710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153DC93CEDC
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0A5281EF7
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 07:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5BD175568;
	Fri, 26 Jul 2024 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v5VzcPvD"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F33320B
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979088; cv=none; b=QeFhQO+XfBY/16MSDflEkVrnUf82vroqDNfn/jXn4+8dfqIgt4oV+qB3/i7WdxmFVT87atKNsj12B9lz5dg/G3wVGWoiTgJu39tDw6nRCNPrbT4T8S8X+p3EwYWusVRTB3YYVM8EuLYIDggTiKMTEo+UHk4Kly2onIW6Z1Fnczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979088; c=relaxed/simple;
	bh=iDBTOtUG4xboU/pePzV/T+ZvR06bSqB3YRQYJ5RKU+A=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=pBAMUgflmjd+uxjT1M9h8Qn3W++Ob/sBcs7Vl1vw7m7pXZUUhQ8vldwwlpnXrH/L3sjC7P10o0AOiQb8XLPv5nSdEhwJOy0d+OcibtZShN9SBzKU7Y8OyuhYraFUpgkQR2UTcvlKRU+TKvjIJova0ODIh4ymEVU0CIse5kvHfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v5VzcPvD; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721979083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/wyza7KnpMgFQndmrVK0zIAQeBuzAKRl//SgbMvIcw=;
	b=v5VzcPvDVfCddnPkDKUEtXUcBsVgf5+3iVB3oTVo7NXUvyxr6DnnCrTJtOaMtF4jYKNufX
	XmNolIIb9Sy9JRyHDT+lakbUZSKR7pLgVmvMV61hN//5qCSEh6r189NZ/tIOL5dOVsRdB1
	CbR1NKe0dno3jShvyNwO60KEti4N7Yc=
Date: Fri, 26 Jul 2024 07:31:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
Message-ID: <62cecceacbc0ea9d59445c828857f6af195e542c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix updating attached freplace prog to
 PROG_ARRAY map
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
In-Reply-To: <1a31ef08-e252-46ec-9cd5-a3ddcb895dfd@linux.dev>
References: <20240725003251.37855-1-leon.hwang@linux.dev>
 <20240725003251.37855-2-leon.hwang@linux.dev>
 <181a9753-717c-4eb4-b788-74468f68c0ff@linux.dev>
 <603c6bac4236b4e6632b00dbe222d5213ff8b9e7@linux.dev>
 <1a31ef08-e252-46ec-9cd5-a3ddcb895dfd@linux.dev>
X-Migadu-Flow: FLOW_OUT

26 July 2024 at 14:15, "Yonghong Song" <yonghong.song@linux.dev> wrote:

>=20
>=20On 7/25/24 8:27 PM, leon.hwang@linux.dev wrote:
>=20
>=20>=20
>=20> 26 July 2024 at 04:58, "Yonghong Song" <yonghong.song@linux.dev> wr=
ote:
> >=20
>=20> >=20
>=20> > On 7/24/24 5:32 PM, Leon Hwang wrote:
> > >=20
>=20>=20
>=20>  The commit f7866c3587337731 ("bpf: Fix null pointer dereference in
> >=20
>=20>  resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed the following pa=
nic,
> >=20
>=20>  which was caused by updating attached freplace prog to PROG_ARRAY =
map.
> >=20
>=20> >=20
>=20> > I am confused here. You mentioned that commit f7866c3587337731
> > >=20
>=20> >  fixed the panic below. But looking at commit message:
> > >=20
>=20> >  https://lore.kernel.org/bpf/20240711145819.254178-2-wutengda@hua=
weicloud.com
> > >=20
>=20> >  it does not seem the case.
> > >=20
>=20>=20
>=20>  The commit fixed this panic meanwhile.
> >=20
>=20>  This panic seems confusing. I'll remove it in patch v2.
> >=20
>=20
> [...]
>=20
>=20>=20
>=20> ---
> >=20
>=20>  include/linux/bpf_verifier.h | 4 ++--
> >=20
>=20>  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
>=20>  diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_veri=
fier.h
> >=20
>=20>  index 5cea15c81b8a8..387e034e73d0e 100644
> >=20
>=20>  --- a/include/linux/bpf_verifier.h
> >=20
>=20>  +++ b/include/linux/bpf_verifier.h
> >=20
>=20>  @@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
> >=20
>=20>  /* only use after check_attach_btf_id() */
> >=20
>=20>  static inline enum bpf_prog_type resolve_prog_type(const struct bp=
f_prog *prog)
> >=20
>=20>  {
> >=20
>=20>  - return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->dst_pr=
og) ?
> >=20
>=20>  - prog->aux->dst_prog->type : prog->type;
> >=20
>=20>  + return prog->type =3D=3D BPF_PROG_TYPE_EXT ?
> >=20
>=20>  + prog->aux->saved_dst_prog_type : prog->type;
> >=20
>=20> >=20
>=20> > If prog->aux->dst_prog is NULL, is it possible that prog->aux->sa=
ved_dst_prog_type
> > >=20
>=20> >  (0, corresponding to BPF_PROG_TYPE_UNSPEC) could be returned? Do=
 we need to do
> > >=20
>=20> >  return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->saved_=
dst_prog_type) ?
> > >=20
>=20> >  prog->aux->saved_dst_prog_type : prog->type;
> > >=20
>=20> >  Maybe I missed something here?
> > >=20
>=20>=20
>=20>  It seems better to check prog->aux->saved_dst_prog_type. But I don=
't think so.
> >=20
>=20>  prog->aux->saved_dst_prog_type is set in check_attach_btf_id(). An=
d there is no
> >=20
>=20>  resolve_prog_type() before check_attach_btf_id() in bpf_check().
> >=20
>=20>  Therefore, resolve_prog_type() must be called after check_attach_b=
tf_id().
> >=20
>=20
> In check_attach_btf_id(), I see
>=20
>=20 if (tgt_prog) {
>=20
>=20 prog->aux->saved_dst_prog_type =3D tgt_prog->type;
>=20
>=20 prog->aux->saved_dst_attach_type =3D tgt_prog->expected_attach_type;
>=20
>=20 }
>=20
>=20So it is possible prog->aux->saved_dst_prog_type is 0 (default value)=
.
>=20
>=20I don't know that if tgt_prog is NULL, whether later resolve_prog_typ=
e()
>=20
>=20will be called or not. Need more checking here.
>

This is the case that commit f7866c3587337731 ("bpf: Fix null pointer der=
eference
in resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed, which is loading fr=
eplace
prog without tgt_prog.

With this patch, while loading freplace prog without tgt_prog, resolve_pr=
og_type()
returns 0 instead of BPF_PROG_TYPE_EXT.

It's better to return a meaningful prog type in resolve_prog_type() anywa=
y.

I accept your suggestion.

Thanks,
Leon

