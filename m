Return-Path: <bpf+bounces-51580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF5A3649F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 18:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596B57A4C5E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F9268C44;
	Fri, 14 Feb 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiyuDjGF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89E2686BB
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554244; cv=none; b=QRz56SqPL/c9gkU8tZnqov0Dwtz5eC2lpmM6FqY6T7A8tPzoKPy9Ed9UtxjYb7Na1xLAeLVLul8CpvZLXPbU8XBPsvX+2CD7ql/F2H6e3efniC9E7Mv6Ad+xwVdHusILRPsMsdDcgJVS5FOV8sAADZOwhe+rKucfuwUplBBWz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554244; c=relaxed/simple;
	bh=q0XD2l3jSIsUEEdOceXrFOi4WtnUKWLlznNEsVDXcLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g78UTyr2/NvPGUKvT1EamQf+rsniPn6MfCpdejCTyelt7v6Ll+oTqClJBPKBccIjD0xBsrEQKPpV7ovw2iNlRXMqJMZAs3306cyLRsS09ze5b3lcWN+2+H01yUDTRciipoqPKoMa9+2ti9lQ9r7zMENyWlVVlUc7kQwtCUgXo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiyuDjGF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1192907f8f.3
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739554240; x=1740159040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VMTSKwURggSo5Mlnz/Kucu7i/qmfWc2/gCaDve9pMk=;
        b=eiyuDjGF5UfuNGWitktP5cy3kK2JJoKPOXwUILQiXpU1tfHU84ebW8cUu+i00R7NU7
         5NEMiHU8X5CLbE3P1PepldlGHEC+aseRKTSA+lnhzsI4d+N2Os4XwKWL4oA7BddvPohw
         hGW2gBksX+KtTHUr2iZE0FxMDmg82fP2cLK46lY+5epIwKRCf8nXl1kNOQ2G5gVj4nkK
         pBLW/udBNpqj/gflf3wi1aJ2+74XXa7z1dCI28XiIyK53teoPaVi+jYbxI4fDEXpC/o0
         qik2iPHzRPpRkYl7TfiwC/t9sPgmE1yEVoWm0xi6EH1Q7lSeLOlAsdwwlTBiuIC28Y3z
         mSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554240; x=1740159040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VMTSKwURggSo5Mlnz/Kucu7i/qmfWc2/gCaDve9pMk=;
        b=QjeXUB72gItnrrENZnrzA9OuNz3aO0Q8WzSpUutIBDTYC2lm9yohjQexecuZ9gEsN/
         2Q1qqF/RNLYMGWpPYxvpO24q1OS91j72vvdrZzJK3X6tfNqYBhc/Gz1DL3t/AjYYzImS
         pWbIWHhr1EyxW71PzrfaaPlx/otP6H6nlQC8JYdrDyIh1O667hV8p/srTP9blAblkIhe
         fJ+sTyi1rUUCd+9f58yBsl9jmJoFe34L0pvw9QwwdR5HPjFQOP6ltxqHKmlv2047yUYM
         IfdIbGWM0RC91A/MK7T56CStDIyveNp+sqFzJHIEGtZYvYIvYSROz1nfTlSi7856Kbqu
         AHMw==
X-Gm-Message-State: AOJu0YxBoqLjfs2P5gtOdoxPe7GPpcykO4YevG8rjizlwj+58vH1zT/J
	7KpucgzRgqMqlTVCNGdeeM411a17qVCKo5rlg3NQCUP4nhri2TvsMSJtMGAZe9itBIPu4az6Mlv
	7t2iYRZ9kcTzHcUMb814W6/3bWjQ=
X-Gm-Gg: ASbGnct2lM2k81d7f5UkwvDH4iPEE+DhTgfy3m3WmucWW+wChEVSGEzrn6gBvpj0bp/
	XiANFjCOi+W1QmTO3K5laTboWILXekVBRFCmhTH6QT5aVzbJ67NkZZ2FmxeOMql1mLljwtSUYZ5
	jK5JwA+gPgnhNwSfS2utxTrQpA31v4
X-Google-Smtp-Source: AGHT+IHYjuIOmJbA6dvTkP4DHqyustF8RuAv6N82xVBeovAxVk4dDKKTH5VrJzPLRa5DUbXwfwJ3ypRJAj7b0AxFpEo=
X-Received: by 2002:a5d:6d0a:0:b0:38f:2990:c08d with SMTP id
 ffacd0b85a97d-38f2990c189mr8778808f8f.14.1739554239509; Fri, 14 Feb 2025
 09:30:39 -0800 (PST)
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
In-Reply-To: <012917a0-e707-0527-f1f2-bb3f38464c7e@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Feb 2025 09:30:27 -0800
X-Gm-Features: AWEUYZkiIMgp-7HiozHX1EwX6y3p3W1Fm5qjKIXktTL-CpSP65io_mudMMgnf1Y
Message-ID: <CAADnVQ+ng5wPns+tbFAumWLoZzNnho8pRVaorKGBA=6h9NsYhw@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 11:25=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> Hi,
>
> On 2/14/2025 2:49 PM, Hou Tao wrote:
> > Hi,
> >
> > On 2/14/2025 12:17 PM, Alexei Starovoitov wrote:
> >> On Thu, Feb 13, 2025 at 8:12=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >>> Hi,
> >>>
> >>> On 2/14/2025 7:56 AM, Alexei Starovoitov wrote:
> >>>> On Sat, Jan 25, 2025 at 2:59=E2=80=AFAM Hou Tao <houtao@huaweicloud.=
com> wrote:
> >>>>> From: Hou Tao <houtao1@huawei.com>
> >>>>>
> >>>>> When there is bpf_dynptr field in the map key btf type or the map k=
ey
> >>>>> btf type is bpf_dyntr, set BPF_INT_F_DYNPTR_IN_KEY in map_flags.
> >>>>>
> >>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>>> ---
> >>>>>  kernel/bpf/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
> >>>>>  1 file changed, 36 insertions(+)
> >>>>>
> >>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>>>> index 07c67ad1a6a07..46b96d062d2db 100644
> >>>>> --- a/kernel/bpf/syscall.c
> >>>>> +++ b/kernel/bpf/syscall.c
> >>>>> @@ -1360,6 +1360,34 @@ static struct btf *get_map_btf(int btf_fd)
> >>>>>         return btf;
> >>>>>  }
> >>>>>
> > SNIP
> >>>>>  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
> >>>>>  /* called via syscall */
> >>>>>  static int map_create(union bpf_attr *attr)
> >>>>> @@ -1398,6 +1426,14 @@ static int map_create(union bpf_attr *attr)
> >>>>>                 btf =3D get_map_btf(attr->btf_fd);
> >>>>>                 if (IS_ERR(btf))
> >>>>>                         return PTR_ERR(btf);
> >>>>> +
> >>>>> +               err =3D map_has_dynptr_in_key_type(btf, attr->btf_k=
ey_type_id, attr->key_size);
> >>>>> +               if (err < 0)
> >>>>> +                       goto put_btf;
> >>>>> +               if (err > 0) {
> >>>>> +                       attr->map_flags |=3D BPF_INT_F_DYNPTR_IN_KE=
Y;
> >>>> I don't like this inband signaling in the uapi field.
> >>>> The whole refactoring in patch 4 to do patch 6 and
> >>>> subsequent bpf_map_has_dynptr_key() in various places
> >>>> feels like reinventing the wheel.
> >>>>
> >>>> We already have map_check_btf() mechanism that works for
> >>>> existing special fields inside BTF.
> >>>> Please use it.
> >>> Yes. However map->key_record is only available after the map is creat=
ed,
> >>> but the creation of hash map needs to check it before the map is
> >>> created. Instead of using an internal flag, how about adding extra
> >>> argument for both ->map_alloc_check() and ->map_alloc() as proposed i=
n
> >>> the commit message of the previous patch ?
> >>>> map_has_dynptr_in_key_type() can be done in map_check_btf()
> >>>> after map is created, no ?
> >>> No. both ->map_alloc_check() and ->map_alloc() need to know whether
> >>> dynptr is enabled (as explained in the previous commit message). Both=
 of
> >>> these functions are called before the map is created.
> >> Is that the explanation?
> >> "
> >> The reason for an internal map flag is twofolds:
> >> 1) user doesn't need to set the map flag explicitly
> >> map_create() will use the presence of bpf_dynptr in map key as an
> >> indicator of enabling dynptr key.
> >> 2) avoid adding new arguments for ->map_alloc_check() and ->map_alloc(=
)
> >> map_create() needs to pass the supported status of dynptr key to
> >> ->map_alloc_check (e.g., check the maximum length of dynptr data size)
> >> and ->map_alloc (e.g., check whether dynptr key fits current map type)=
.
> >> Adding new arguments for these callbacks to achieve that will introduc=
e
> >> too much churns.
> >>
> >> Therefore, the patch uses the topmost bit of map_flags as the internal
> >> map flag. map_create() checks whether the internal flag is set in the
> >> beginning and bpf_map_get_info_by_fd() clears the internal flag before
> >> returns the map flags to userspace.
> >> "
> >>
> >> As commented in the other patch map_extra can be dropped (I hope).
> >> When it's gone, the map can be destroyed after creation in map_check_b=
tf().
> >> What am I missing?
> > If I understanding correctly, you are suggesting to replace
> > (map->map_flags & BPF_INT_F_DYNPTR_IN_KEY) with !!map->key_record, righ=
t
> > ? And you also don't want to move map_check_btf() before the invocation
> > of ->map_alloc_check() and ->map_alloc(), right ? However, beside the
> > checking of map_extra, ->map_alloc_check() also needs to know whether
> > the dynptr-typed key is suitable for current hash map type or map flags=
.
> > ->map_alloc() also needs to allocate a bpf mem allocator for the dynptr
> > key. So are you proposing the following steps for creating a dynkey has=
h
> > map:
> >
> > 1) ->map_alloc_check()
> > no change
> >
> > 2) ->map_alloc()
> > allocate bpf mem allocator for dynptr unconditionally
> >
> > 3) map_check_btf()
> > invokes an new map callback (e.g., ->map_alloc_post_check()) to check
> > whether the created map is mismatched with the dynptr key and destroy i=
t
> > if it is.
>
> Sorry, I misread the code, so the third steps is:
>
> 3) ->map_check_btf()
>
> In ->map_check_btf() callback, check whether the created map is
> mismatched with the dynptr key. If it is, let map_create() destroys the m=
ap.

map_check_btf() itself can have the code to filter out unsupported maps
like it does already:
                        case BPF_WORKQUEUE:
                                if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
                                    map->map_type !=3D BPF_MAP_TYPE_LRU_HAS=
H &&
                                    map->map_type !=3D BPF_MAP_TYPE_ARRAY) =
{
                                        ret =3D -EOPNOTSUPP;

I don't mind moving map_check_btf() before ->map_alloc_check()
since it doesn't really need 'map' pointer.
I objected to partial move where btf_get_by_fd() is done early
while the rest after map allocation.
Either all map types do map_check_btf() before alloc or
all map types do it after.

If we move map_check_btf() before alloc
then the final map->ops->map_check_btf() should probably
stay after alloc.
Otherwise this is too much churn.

So I think it's better to try to keep the whole map_check_btf() after
as it is right now.
I don't see yet why dynptr-in-key has to have it before.
So far map_extra limitation was the only special condition,
but even if we have to keep (which I doubt) it can be done in
map->ops->map_check_btf().

