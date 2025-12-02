Return-Path: <bpf+bounces-75915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B1C9CAA0
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 19:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29C4F342446
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7AF2C3265;
	Tue,  2 Dec 2025 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIbzuMBe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E21EB5CE
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700674; cv=none; b=a+T6+Zot8tCy0CMJJLPT1rsys8CXf8TC1UFc7ypN0NPmWeMJgfUW0CDSTwczmCr5bLh8GyNFcEic/dYgqxidWadQzYokbT6AEvz51Y9vfzKf00c+uowWy1JUPqeBQafN/H3lEQzkkJlBh1fYHGsD6BWVaKPKjPFuWVcUW5pMUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700674; c=relaxed/simple;
	bh=GnlE4BUxEgEszX3Rd8HFrIVxrRs/MgEFgw9SVZ+Y29A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht5g/fo9p9ZnoHhp6mU+WO+LWEiko6cfyOaihVsCGr5HPR8R67RmjL2ZZhjjJvmkUjM6bKHSw5S4V29GWvhaT7PIsfK98quuIPAfItCaTqSVLVncUsFLQijCviNBYRChxt8gotsmuVJletb0nyrGxqqRvKPbJU9vmmTw7SGcRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIbzuMBe; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-787e7aa1631so1919707b3.1
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 10:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764700672; x=1765305472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=013H9LWKQxOenYGa2r/1ESrD1I2f7WW6c9h6ClwsUZo=;
        b=bIbzuMBepGB9gTuGxfb49vzuqm1Ae4MQL0OHleKXHRORgqM4UD8xbRSweJPbpxkOlp
         7/dH4k+Lpm26+QeHp1LteQjxlCZJ2CYVpvYhung912Sh58qb5RcDybCNMNlpJ8dromek
         Ak/akMvTGB7z3tE5dd5Hppk/FEBAaeUuqqRvLZOnaeLaYbidHuue+JOU0OZaFL/09cuP
         2cvuT/vbIN0BnbQglU8W2vhV0fyGIIlqhPpPT//36FctDVeCpwpTTw+vfx9yOJyLz+lN
         yZ82lyQ967SFy9+w3KLl3jnILFZ6gVD8Nm6OYynBZe0SwYYm1RGTBftMXMPQLi5j+/vm
         aJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764700672; x=1765305472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=013H9LWKQxOenYGa2r/1ESrD1I2f7WW6c9h6ClwsUZo=;
        b=eFWcpZRRx1G2gfa1vpPhtuCMQ9viTBynETDcKrFtDpbD9/ICSgwcTrMHIWKVN4NOv9
         ESW00XhiCbpGqkFYhtNibjSoN0RTvPDvlZCVQKURvfREasjrmydoT9gU8RPR4trmt/6x
         thCTJVPIxOSHWoL5AYWHwUKeNiwpMeIgoj/r6wFuFeYGCJczNavilX7okg4HXqNIsume
         FTRAnmUtbnXFy2Ti9MVwyJDkrx+q5ivHf4hyMvLzO7nx94+RDDzCfIY1lQEKtQTzRjVG
         HZ3S4GV4nm2xVcPSNlxu6PKZ57y79spenyymKChyquYB+SnqOdnuNj5/1Iluy2xx8KAG
         3xpg==
X-Gm-Message-State: AOJu0YwenktHDtNRDQpIT37jW44WZarVGhpksOT/kKiElRh877hmGHgW
	yCgnIBXOX3uTPbr+640igWYbCZhA+v5z72K27IyzSTGJhtmsKC9lJq/vMA7sEgbTngZnngqobLT
	KR5b6LCDyDK0gee4msfdB1PaPGcc2oPs=
X-Gm-Gg: ASbGncv1wq/3TPOjuRQklnkfcFow4nCQNVY3SmZbfSvlsrCwaK/h/MAcvVNydHLAGiB
	w52S2AibiGEuXMp/FyFxwAADY9ldt5mjjiCO2tgmLPKjBda3rBluT3fvdVBOpc4eUWaJBUR/hte
	VfKHEeRM7ZR/GsdpX0ZV3V/hCaifd48XnjRFrIKfYGaxzueuoGlFuWdbsxe6HIkgUJ55h4QsUoR
	gFVOu0XmVUKN36bHu3icJz3QFhNbBm0eWdkXwgypMaMKlufJ5jWtPqzVVDKInrx9LQYkZRTJ060
	l/2U/+qEVUI=
X-Google-Smtp-Source: AGHT+IGxQUGJcsowxZp15tmwe0+PAQoOg6ajEAefLY24giso4wnRkk38jhbCVDDhKMXGevpjzv/Cv8rRbpV8wrCzypU=
X-Received: by 2002:a05:690e:418f:b0:63f:c019:23b2 with SMTP id
 956f58d0204a3-6442f1af4camr3358088d50.28.1764700672147; Tue, 02 Dec 2025
 10:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202171615.1027536-1-ameryhung@gmail.com> <CAP01T75C+Zj12g08q3XE2X+TV8Qwx_dua=s489w71or2bu64gg@mail.gmail.com>
In-Reply-To: <CAP01T75C+Zj12g08q3XE2X+TV8Qwx_dua=s489w71or2bu64gg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 2 Dec 2025 10:37:39 -0800
X-Gm-Features: AWmQ_bkgITNbuXnGNW37tpgOdmT6IZiYZShj5hFi_14YXOZX6TE3EYnqKz6vjMo
Message-ID: <CAMB2axOQDKrobzTVZhdafPks4fqYAN2HUrm_Asq3FG_GPSVw8A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use
 cgroup storage
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 9:27=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Tue, 2 Dec 2025 at 18:16, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
> > by disallowing tail call to programs that use cgroup storage. Cgroup
> > storage is allocated lazily when attaching a cgroup bpf program. With
> > tail call, it is possible for a callee BPF program to see a NULL
> > storage pointer if the caller prorgam does not use cgroup storage.
> >
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> > Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521ad=
b@hust.edu.cn/
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/arraymap.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 1eeb31c5b317..9c3f86ef9d16 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *ma=
p, struct file *map_file,
> >                                  void *key, void *value, u64 map_flags)
> >  {
> >         struct bpf_array *array =3D container_of(map, struct bpf_array,=
 map);
> > +       u32 i, index =3D *(u32 *)key, ufd;
> >         void *new_ptr, *old_ptr;
> > -       u32 index =3D *(u32 *)key, ufd;
> > +       struct bpf_prog *prog;
> >
> >         if (map_flags !=3D BPF_ANY)
> >                 return -EINVAL;
> > @@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *m=
ap, struct file *map_file,
> >         if (IS_ERR(new_ptr))
> >                 return PTR_ERR(new_ptr);
> >
> > +       if (map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY) {
> > +               prog =3D (struct bpf_prog *)new_ptr;
> > +
> > +               for_each_cgroup_storage_type(i)
> > +                       if (prog->aux->cgroup_storage[i])
> > +                               return -EINVAL;
> > +       }
>
> Would a similar check be needed for extension programs (BPF_PROG_TYPE_EXT=
)?

I think BPF_PROG_TYPE_EXT should be free from this NULL pointer
dereference bug. Since tail callee cannot be extended and extended
program cannot be tailcalled, an extension program calling
bpf_get_local_storage() must be directly called from a cgroup program
with a valid storage pointer.

However, I guess we also need to do something similar to [0] to
extension programs as well.

[0] https://lore.kernel.org/all/20250730234733.530041-4-daniel@iogearbox.ne=
t/

>
> > +
> >         if (map->ops->map_poke_run) {
> >                 mutex_lock(&array->aux->poke_mutex);
> >                 old_ptr =3D xchg(array->ptrs + index, new_ptr);
> > --
> > 2.47.3
> >
> >

