Return-Path: <bpf+bounces-52653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C864A46512
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 16:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F943B8A09
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07DE22259F;
	Wed, 26 Feb 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho3Na673"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C19A22259C
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583911; cv=none; b=HxEJqaG2yWCEJUzDGpj9cHBGUpVXMdTVAUvtNexWaL0sIIT6smIFGMfHG3QiCabPIO1bpbQIYFGqiVp6jNaolOL671xomWJhhFDy2xpgBRkdf0OVM1N0pzPAr5A6ljpdL72SX0vI89dX8yNzfi1Ohl4gVyZJXGt1QInNIDv+6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583911; c=relaxed/simple;
	bh=4lu2U3A83vpPlz0sJCXenjhaAGMlS2iG9cdfs51b18E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZBEJ3Y94pzyqeEZGz+BYbrVayUK1CeQXcEeNDOiiN3mhsAsU2JiAvWatMhWAit4iBBXXT6GdsyQLMIpk52XCHpL+bKlgcOKhasWf0GOOePUOEJ7aTDMGhREF1zGiokVWW2H6ereS/OaZ5WqhUVxA7kD9f+QJ62iflw5C8415L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho3Na673; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so3501536f8f.0
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 07:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740583908; x=1741188708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+wj3tPq0fazdAG+IZCpmc8VLDa2jp1IUF/mFXVjD4k=;
        b=ho3Na673G+jSgIg5g/drowiw55H6YXPXaXY+Q+GOCYbV2hzhrq18sjFbRvVAc5f2q+
         abhp/AYjJ3vEPtelyGjMA1ryIO1EpM+2KHCFUPTBDTj1KEdccf+OI8Otb9cW6d+IyT36
         84kSEwtztDXq37LKuK+GQCUTwotIXpkNZMMfuSMfGzpTSj2CprXK2y6sYe88kXmKrN5/
         2sw2xU4nIJI9bodntKcSWkKcg+GhBWsq3oOf865bf8Mmm+0Ndk8JKGtjidnFZBQH/d8/
         FFfQeNPBV9VknK4IfJ0Dp4s3N4B/1e2BzWd0wjwxtGGK7DXDn2bniwKWMAdbrYPodEsi
         DWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583908; x=1741188708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+wj3tPq0fazdAG+IZCpmc8VLDa2jp1IUF/mFXVjD4k=;
        b=bBdkEgmDaBiEUaFmh9+GPrbIO/WzPtue09tqARMbMQdCQU0fqCUN1jWMJOam0dM8OV
         0pf4vESJgZW0xz3Y43+tLqRkSYXAkk9E2gSJWWG2axBUPhXX0TLvGxQF45YaWfbBj9Ho
         StJ5YOpUsMGZ0wLTbG79ZYbtBkPys7UgTVyhtxh7hfuH3W+8cE+qgbsu6EmiM7iWSMWE
         N7Sn4zESMNU7Zs5gDaSj9GCJf2M/HwB9Pge4LqkhHfZs//0qZc881u5g4eoB6mI5isyW
         prIrNot/JTGq4DWnTfX4eOV0gJpDNtg0pfKvmKyaM2Z9pjhUbtDQjshW9N4XrPa+DKw9
         CDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7v7ICPk2WYxSUyqnPQy4TeYnkfCkJfcAKnp8y5IfzvNKOaCKmnoC6lzTiWmqymyom150=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0o1VBhPBZrQMrSSIsISob+V65XtdU8DT653NGClUkWK3kPsf
	7zrGk/hJeZ7qjhPdiV6QToEu1uDkfwK3NXDo3QkhAHiTopBXeTY+QuUfYTXXi3L6mmH06BTmE3n
	7QZRzlfmRV87PVf72IO8s+bgA080=
X-Gm-Gg: ASbGnct1kMdPfa8vM0HWPrFQDrUwPMTdx7yLUvALXbJG6LOk5RL3daO9Ldx5mdHYQL0
	nK2old2bXgsWCoQYxNS2A9H93PjkHl52xzjrIpiK2MDA8Hc/Zab9dlLxSwz7+2RHsGL+kKMRzZ5
	j3pwUomtfhcKKM17Nv+pncNpc=
X-Google-Smtp-Source: AGHT+IE4G5Y2+tpsDZ9bQXEd5vO2z+u32R+iLXxCuMSBPVhIJRNmeWP6AIlbMhjdeYdXqhA/Qwoz6c4jEuqpdu3jfM4=
X-Received: by 2002:a05:6000:1fa3:b0:38d:d603:ff46 with SMTP id
 ffacd0b85a97d-38f7d1ffbfemr15629685f8f.14.1740583907475; Wed, 26 Feb 2025
 07:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213161931.46399-1-leon.hwang@linux.dev> <20250213161931.46399-2-leon.hwang@linux.dev>
 <913e4bbd-473e-9118-03bd-992ba737032d@huaweicloud.com> <b49cbd71-6b2d-4c83-be5d-4fc56fdb3447@linux.dev>
In-Reply-To: <b49cbd71-6b2d-4c83-be5d-4fc56fdb3447@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Feb 2025 07:31:35 -0800
X-Gm-Features: AQ5f1Jq0cjf-lu2mdswr3Zz2arJMQ4dhaoJsuiqZwJ53vrEN7DWJjzCtq3hJiHI
Message-ID: <CAADnVQLFtSGjHxdY4Q8Rjw0WVJJaXsvCuaQwPYZUX+N5w8AcHw@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v2 1/4] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Eddy Z <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:54=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/2/26 10:19, Hou Tao wrote:
> > Hi,
> >
>
> [...]
>
> >> @@ -815,6 +850,8 @@ const struct bpf_map_ops percpu_array_map_ops =3D =
{
> >>      .map_get_next_key =3D array_map_get_next_key,
> >>      .map_lookup_elem =3D percpu_array_map_lookup_elem,
> >>      .map_gen_lookup =3D percpu_array_map_gen_lookup,
> >> +    .map_direct_value_addr =3D percpu_array_map_direct_value_addr,
> >> +    .map_direct_value_meta =3D percpu_array_map_direct_value_meta,
> >>      .map_update_elem =3D array_map_update_elem,
> >>      .map_delete_elem =3D array_map_delete_elem,
> >>      .map_lookup_percpu_elem =3D percpu_array_map_lookup_percpu_elem,
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 9971c03adfd5d..5682546b1193e 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -6810,6 +6810,8 @@ static int bpf_map_direct_read(struct bpf_map *m=
ap, int off, int size, u64 *val,
> >>      u64 addr;
> >>      int err;
> >>
> >> +    if (map->map_type !=3D BPF_MAP_TYPE_ARRAY)
> >> +            return -EINVAL;
> >
> > Is the check still necessary ? Because its caller has already added the
> > check of map_type.
>
> Yes. It should check here in order to make sure the code logic in
> bpf_map_direct_read() is robust enough.
>
> But in check_mem_access(), if map is a read-only percpu array map, it
> should not track its contents as SCALAR_VALUE, because the read-only
> .percpu, named .ropercpu, hasn't been supported yet.
>
> Should we implement .ropercpu in this patch set, too?

Absolutely not and not tomorrow either. There is no use case
for readonly percpu data. It's only a waste of memory.

> >>      err =3D map->ops->map_direct_value_addr(map, &addr, off);
> >>      if (err)
> >>              return err;
> >> @@ -7322,6 +7324,7 @@ static int check_mem_access(struct bpf_verifier_=
env *env, int insn_idx, u32 regn
> >>                      /* if map is read-only, track its contents as sca=
lars */
> >>                      if (tnum_is_const(reg->var_off) &&
> >>                          bpf_map_is_rdonly(map) &&
> >> +                        map->map_type =3D=3D BPF_MAP_TYPE_ARRAY &&
> >>                          map->ops->map_direct_value_addr) {
> >>                              int map_off =3D off + reg->var_off.value;
> >>                              u64 val =3D 0;
> >
> > Do we also need to check in check_ld_imm() to ensure the dst_reg of
> > bpf_ld_imm64 on a per-cpu array will not be treated as a map-value-ptr =
?
> No. The dst_reg of ld_imm64 for percpu array map must be treated as
> map-value-ptr, just like the one for array map.

I suspect what Hou is hinting at that if percpu array rejected
BPF_F_RDONLY_PROG in map_alloc_check() there would be no need
to special case everything but "+ map->map_type =3D=3D BPF_MAP_TYPE_ARRAY"
here.

