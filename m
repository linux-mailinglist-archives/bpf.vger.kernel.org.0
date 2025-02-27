Return-Path: <bpf+bounces-52806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D44A48A51
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 22:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0E57A3A1A
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D626E976;
	Thu, 27 Feb 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBs92nra"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B121A9B2A
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740690634; cv=none; b=Dr26hkrbhZvgz5BBrLePD4GLghq8+IViO5RBLHM/pog/EYnYTNFqMgsf8wotsxxIuT08smI+8XtVzrvkR7B0KqY8ZapRpc/Stx4LwougxIDEHwQDEzigVYjEya5ZoyWXB+KBVd2keijAYBoHLRiV6dWMVXTYltanhFFL0n1lMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740690634; c=relaxed/simple;
	bh=fZK71nzhBOfAnu1qSrHD09vs73EBNLbInzSrNMq9prU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbmQN5nEZrnuBjcHBsJv7UB/eu5sYA6/u3khb5epdS33czlbtwVev8ZKw6IqYxHaHf937p+NdtXTbixm+u2gFYzA/QW+AjwQXvGaXHivO9CfvRz44VXgz7knp3NVEoNeGlF+NYpAAmgIN7whVWpzVeW0Ntw8Hs8D2zsVrudplgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBs92nra; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948021a45so13440725e9.1
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 13:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740690629; x=1741295429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pjIoWmeWUnPi/JKLx8SsC6WsNWVk4r0E807buW9Y6E=;
        b=fBs92nraNv8IO6dAtb89szKeGrcKAZZCj+baNhVuUcEuq9gbpv9O6inQ0NwsmcF8UY
         rWjQil2uuHtjHHBnTUSwEcVMWuM71WeKq340NXEd1+CLzP2PPO/J2/NuQBKhijaKsyi6
         pmvcjgHMIkJAlYHm7obdkQyjmHPw+x1e+SDb9RJ8C+3vEXnSd5Z5P7dKdZ4ua6bTNiNc
         s5i/BMxbw8B8F918RNUqjTlMdprH9IiEy7Ouj16h2Sv3puhuMxqk6hV1pnKXiFCoWzbu
         NHAVj1/NGPfzp1mP8Pxb+w3aN81d1ju4wREhdOySqo3OPn00LUMCK4SLCRnGcx7EN9PQ
         9D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740690629; x=1741295429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pjIoWmeWUnPi/JKLx8SsC6WsNWVk4r0E807buW9Y6E=;
        b=u3ntFdvRyzBcylqCBXhoO/McRwp5manMiHyvtM0SzE0ZAkq8uLAKR0Vqq85Yb2Q26w
         s7SCyE5GQuxW1XySyVmlhWSpw8MIS0aMB1CeU2GXuzKhgNsYDxJSnZRkR9lvXjst2TZn
         nM2xboPsTrc8Zzx7UY0YIrbTWmdjEhpS2i/0EMCkVMJe+ccTnOJPd59/6kBDWxEQMwtf
         b8cxVebcZX2Q63C3TgEEjKm2BGgXl6P3cK1Dd0R2KK979tCVd1VyZhGYEVVC0Qi+DUf5
         M0Lf5GekJHHk/ez3hrVdXR+8q/WWpE1Bp4ZXTrPJ5d5T/MO+T/MadGFhLbP1Vnfe1thj
         hkRw==
X-Gm-Message-State: AOJu0YyahhJJZ1O9JqaYdzwJ1tZA05leJeJDiUsfaHdYpLBT8H2S4Qhh
	dXkGuyVO4G/YhkDyWdK4hVnkqyKXnUNzKe4creC+QslBPWNLipKaenaQNcGA9zZjrPSjhObcZv6
	V8EFUauHTCFlyzVBvpD3Nn2OWFEs=
X-Gm-Gg: ASbGncvYUqC99u7TUaz002TFfsKKQmfy5oAR+B1aiCykO9J2eGoyLIyb1wIWJWqguDi
	dxPHibgV+pzbxz5SxDkyn4+wRW764S12L2+KG65oPyToo1UNiJ7Y5i3RXRWVz3K6egeyG9rwCJL
	WgKBaA0GH+HFPnCymRF5XfAqA=
X-Google-Smtp-Source: AGHT+IE87dR/695C4p+/x1A2rYFb3+pQJapspZ+Jfhk6u7dSk0Y3iv0whgo1nZskxcZy3c7JRqYsHebtwYUP/kcxWEY=
X-Received: by 2002:a05:6000:1568:b0:38f:23ed:2c7 with SMTP id
 ffacd0b85a97d-390ec7d2f25mr689721f8f.14.1740690627370; Thu, 27 Feb 2025
 13:10:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125111109.732718-1-houtao@huaweicloud.com>
 <20250125111109.732718-7-houtao@huaweicloud.com> <CAADnVQL+866m69rv+PC_V1y1-PjL4=w3obTwqLPgW3=kA_BjEg@mail.gmail.com>
 <6223b1f5-b491-fcec-b50c-222f1075f952@huaweicloud.com> <CAADnVQ+G9YQyj8-Q7UFT9y26tD1Rud_AgRu-D-s1LruYE03NZQ@mail.gmail.com>
 <01e5b3ca-86d3-46a9-742a-3b69f378d141@huaweicloud.com> <012917a0-e707-0527-f1f2-bb3f38464c7e@huaweicloud.com>
 <CAADnVQ+ng5wPns+tbFAumWLoZzNnho8pRVaorKGBA=6h9NsYhw@mail.gmail.com>
In-Reply-To: <CAADnVQ+ng5wPns+tbFAumWLoZzNnho8pRVaorKGBA=6h9NsYhw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Feb 2025 13:10:15 -0800
X-Gm-Features: AQ5f1JokOVnjJJweRzwtfD05rzWWCfOkh0UAiavpzoIwsvfaKaJCw956raSRgDw
Message-ID: <CAADnVQ+o=2XQ2Wo-Roe35ahq=zgHjC19ptsbRJa1DVir5umqxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/20] bpf: Set BPF_INT_F_DYNPTR_IN_KEY conditionally
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 9:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 13, 2025 at 11:25=E2=80=AFPM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >
> > Hi,
> >
> > On 2/14/2025 2:49 PM, Hou Tao wrote:
> > > Hi,
> > >
> > > On 2/14/2025 12:17 PM, Alexei Starovoitov wrote:
> > >> On Thu, Feb 13, 2025 at 8:12=E2=80=AFPM Hou Tao <houtao@huaweicloud.=
com> wrote:
> > >>> Hi,
> > >>>
> > >>> On 2/14/2025 7:56 AM, Alexei Starovoitov wrote:
> > >>>> On Sat, Jan 25, 2025 at 2:59=E2=80=AFAM Hou Tao <houtao@huaweiclou=
d.com> wrote:
> > >>>>> From: Hou Tao <houtao1@huawei.com>
> > >>>>>
> > >>>>> When there is bpf_dynptr field in the map key btf type or the map=
 key
> > >>>>> btf type is bpf_dyntr, set BPF_INT_F_DYNPTR_IN_KEY in map_flags.
> > >>>>>
> > >>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > >>>>> ---
> > >>>>>  kernel/bpf/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
> > >>>>>  1 file changed, 36 insertions(+)
> > >>>>>
> > >>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > >>>>> index 07c67ad1a6a07..46b96d062d2db 100644
> > >>>>> --- a/kernel/bpf/syscall.c
> > >>>>> +++ b/kernel/bpf/syscall.c
> > >>>>> @@ -1360,6 +1360,34 @@ static struct btf *get_map_btf(int btf_fd)
> > >>>>>         return btf;
> > >>>>>  }
> > >>>>>
> > > SNIP
> > >>>>>  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
> > >>>>>  /* called via syscall */
> > >>>>>  static int map_create(union bpf_attr *attr)
> > >>>>> @@ -1398,6 +1426,14 @@ static int map_create(union bpf_attr *attr=
)
> > >>>>>                 btf =3D get_map_btf(attr->btf_fd);
> > >>>>>                 if (IS_ERR(btf))
> > >>>>>                         return PTR_ERR(btf);
> > >>>>> +
> > >>>>> +               err =3D map_has_dynptr_in_key_type(btf, attr->btf=
_key_type_id, attr->key_size);
> > >>>>> +               if (err < 0)
> > >>>>> +                       goto put_btf;
> > >>>>> +               if (err > 0) {
> > >>>>> +                       attr->map_flags |=3D BPF_INT_F_DYNPTR_IN_=
KEY;
> > >>>> I don't like this inband signaling in the uapi field.
> > >>>> The whole refactoring in patch 4 to do patch 6 and
> > >>>> subsequent bpf_map_has_dynptr_key() in various places
> > >>>> feels like reinventing the wheel.
> > >>>>
> > >>>> We already have map_check_btf() mechanism that works for
> > >>>> existing special fields inside BTF.
> > >>>> Please use it.
> > >>> Yes. However map->key_record is only available after the map is cre=
ated,
> > >>> but the creation of hash map needs to check it before the map is
> > >>> created. Instead of using an internal flag, how about adding extra
> > >>> argument for both ->map_alloc_check() and ->map_alloc() as proposed=
 in
> > >>> the commit message of the previous patch ?
> > >>>> map_has_dynptr_in_key_type() can be done in map_check_btf()
> > >>>> after map is created, no ?
> > >>> No. both ->map_alloc_check() and ->map_alloc() need to know whether
> > >>> dynptr is enabled (as explained in the previous commit message). Bo=
th of
> > >>> these functions are called before the map is created.
> > >> Is that the explanation?
> > >> "
> > >> The reason for an internal map flag is twofolds:
> > >> 1) user doesn't need to set the map flag explicitly
> > >> map_create() will use the presence of bpf_dynptr in map key as an
> > >> indicator of enabling dynptr key.
> > >> 2) avoid adding new arguments for ->map_alloc_check() and ->map_allo=
c()
> > >> map_create() needs to pass the supported status of dynptr key to
> > >> ->map_alloc_check (e.g., check the maximum length of dynptr data siz=
e)
> > >> and ->map_alloc (e.g., check whether dynptr key fits current map typ=
e).
> > >> Adding new arguments for these callbacks to achieve that will introd=
uce
> > >> too much churns.
> > >>
> > >> Therefore, the patch uses the topmost bit of map_flags as the intern=
al
> > >> map flag. map_create() checks whether the internal flag is set in th=
e
> > >> beginning and bpf_map_get_info_by_fd() clears the internal flag befo=
re
> > >> returns the map flags to userspace.
> > >> "
> > >>
> > >> As commented in the other patch map_extra can be dropped (I hope).
> > >> When it's gone, the map can be destroyed after creation in map_check=
_btf().
> > >> What am I missing?
> > > If I understanding correctly, you are suggesting to replace
> > > (map->map_flags & BPF_INT_F_DYNPTR_IN_KEY) with !!map->key_record, ri=
ght
> > > ? And you also don't want to move map_check_btf() before the invocati=
on
> > > of ->map_alloc_check() and ->map_alloc(), right ? However, beside the
> > > checking of map_extra, ->map_alloc_check() also needs to know whether
> > > the dynptr-typed key is suitable for current hash map type or map fla=
gs.
> > > ->map_alloc() also needs to allocate a bpf mem allocator for the dynp=
tr
> > > key. So are you proposing the following steps for creating a dynkey h=
ash
> > > map:
> > >
> > > 1) ->map_alloc_check()
> > > no change
> > >
> > > 2) ->map_alloc()
> > > allocate bpf mem allocator for dynptr unconditionally
> > >
> > > 3) map_check_btf()
> > > invokes an new map callback (e.g., ->map_alloc_post_check()) to check
> > > whether the created map is mismatched with the dynptr key and destroy=
 it
> > > if it is.
> >
> > Sorry, I misread the code, so the third steps is:
> >
> > 3) ->map_check_btf()
> >
> > In ->map_check_btf() callback, check whether the created map is
> > mismatched with the dynptr key. If it is, let map_create() destroys the=
 map.
>
> map_check_btf() itself can have the code to filter out unsupported maps
> like it does already:
>                         case BPF_WORKQUEUE:
>                                 if (map->map_type !=3D BPF_MAP_TYPE_HASH =
&&
>                                     map->map_type !=3D BPF_MAP_TYPE_LRU_H=
ASH &&
>                                     map->map_type !=3D BPF_MAP_TYPE_ARRAY=
) {
>                                         ret =3D -EOPNOTSUPP;
>
> I don't mind moving map_check_btf() before ->map_alloc_check()
> since it doesn't really need 'map' pointer.
> I objected to partial move where btf_get_by_fd() is done early
> while the rest after map allocation.
> Either all map types do map_check_btf() before alloc or
> all map types do it after.
>
> If we move map_check_btf() before alloc
> then the final map->ops->map_check_btf() should probably
> stay after alloc.
> Otherwise this is too much churn.
>
> So I think it's better to try to keep the whole map_check_btf() after
> as it is right now.
> I don't see yet why dynptr-in-key has to have it before.
> So far map_extra limitation was the only special condition,
> but even if we have to keep (which I doubt) it can be done in
> map->ops->map_check_btf().

Any update on this ?
Two weeks have passed.
iirc above was the only thing left to resolve.

