Return-Path: <bpf+bounces-66149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD23B2ECA2
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 06:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFF93AC96A
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 04:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E7826656D;
	Thu, 21 Aug 2025 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4TN4DpN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C723C509
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749256; cv=none; b=B/OkIp29QKn+z0pr+GehKax1PHtWv3LMjFTd0BzMTdhAxYvFpRJttkUAtSv7kMcB3KTAj2G1FzyMQ72+YTmhKwdCRJjYSpdUXLPszC9b4vPzvCr2Uesx/Xh+wiC4D8jDCWVCgAmUWgLov6hF/eS/WW/tA/eFvSEOAuhDlrb109s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749256; c=relaxed/simple;
	bh=5oirP7WiNifHumklvNdf1HOpwUeGPcRbhlJLskwX9hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCEhBia/nhk6zxeO9LLUiwKrIM3ofVo/O8+g3cTb/DfZc4dm9RdwKyS23PhYXw1G55Ycgc371DY+ComhCrsBiJ1MPZDfIJw3sjTFAPfzBed5zFw1S1xFXQHWbwdIWJVzEScg2mYvekpvBIEjy2ordtjHheXmICk7W3L52Gbe6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4TN4DpN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61a207a248cso7151a12.0
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755749252; x=1756354052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2zfCcSJOzjARkXqmrK2VbK9VW5RbRjtX977JzOFSGY=;
        b=f4TN4DpNGOUC91OZ4sACkuUfzsOB7BCcfva7qX/8nCC7M1sTdmQPHiQDYT47nK4V1w
         4FPmCvkdnuPZM+fVBCIN7atWpoGca6DBEI4qom+uvjjEOkRppLtg/AdebGa4Wr/B/C1U
         3Wao/GaQlSi6m4d5cuKTGbz2Ck6+azpfjcilozM56ob+g76dTu385g4Zm0c6ELKGJ5uN
         G4fpvLA7uQyk5YPGpGc8Qcj35ZHAY2gIBpgq9dIkA4ddic8M9lvw7bbt6NqMPfoMmYtm
         RtSY/0+AH4MFtDtkZ3mL/xRfcoKEwuT6PjSl0AIns1FPhYpx3bls7mPBuAqHL2Wk5SMK
         ZPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755749252; x=1756354052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2zfCcSJOzjARkXqmrK2VbK9VW5RbRjtX977JzOFSGY=;
        b=se+oPHQjt+EYVEDO6E1oG921Jngy2DPeMIn/gifL9+ycD4hbuV+J9FMCOowx2R80z4
         49ZnoV6pt0UmOyu3WacwJtcoEyy07cr3pz/LEN8d1Jjs89xXUqcVxmBnvTfwqNKBup8+
         A2scwgfdAZ6LhDkbmEUx44zHaGRsIsS1y+lzn8bROccaJmc3m6QxZofpT/nmcBpDV71D
         fd6O7igPZB5OCn/7CXhoPGW6q5ZEr3Tcb1TaYHq7HS/MVmmJHVQf8UVnE8IBr/JVa5OT
         n8TDI7R24Jz+wqKdkitL1l1Zfmh/9piZgDC3HbcRuXb+2YiVV5vXfhudbmsjW4YcUTeO
         S0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGubcBG7f08GJr9MaySgM6G65WMqQ66bgHr/tKFmSUI4XprCIwu7KRCoF3LdFoFWpgr9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvQr483sEwCYKPv3AkCoT7UCTr+M8JGv51VRZoY31DDyLE8+C
	T0XUi6lr3+Td47XZV8jVY0jUprghGkX9Dyj8IAwH9p3/gYjogz6+opVhPaDkUpPlVr3Okjc7AKK
	0t57l4WQA3cGWa+Czg4QWFmxmx5hKVL4pOlvDfxQi
X-Gm-Gg: ASbGncvSdaHMJE3HZKKuaBZxAvvbfchksZajNRboVY/1e0+N7P/NFFOlts1+724TfDy
	odwfw3Cl3gJrq4ZuhLXpswenkLVJKMfQt7h7EtFbkPaFwGn1clPA+yuV2GoXkNmmAU9Cf3gNkgl
	Om5vBIQpQHRM1zN5lWqErl7b7z+81H3F8eYP8c7mtQHWcOZPuP3F/OHTfuHxLUFStdl7n/TkQ9N
	WEzaj4Iyq7s9Wx7DlEZ6HJY2VMkDrUGNwq2Xuif/Gc=
X-Google-Smtp-Source: AGHT+IFrsPEyM2E5GeeRSvRDPHxWAC8MsuCNQnD2ZE2YVMx9fd6Zq4+VAYIDnVwZC2VKlhk7LZVLABzTWFCADUsy7rk=
X-Received: by 2002:a50:d658:0:b0:61b:f987:42d9 with SMTP id
 4fb4d7f45d1cf-61bf98753a1mr20993a12.2.1755749251625; Wed, 20 Aug 2025
 21:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813073955.1775315-1-maze@google.com> <6df59861-8334-49ac-8dca-2b0bac82f2d7@linux.dev>
In-Reply-To: <6df59861-8334-49ac-8dca-2b0bac82f2d7@linux.dev>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 20 Aug 2025 21:07:19 -0700
X-Gm-Features: Ac12FXwOFUmHRzE1mYnem_hnpYjz3EZEML8HNI_-8PwFPwygE3VYTkye6feLPsg
Message-ID: <CANP3RGek2nTodF_niyenmrLg2_g=BCPV6MQkwXT4SpZ6W8+9pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: hashtab - allow BPF_MAP_LOOKUP{,_AND_DELETE}_BATCH
 with NULL keys/values.
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 1:58=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
> On 8/13/25 12:39 AM, Maciej =C5=BBenczykowski wrote:
> > BPF_MAP_LOOKUP_AND_DELETE_BATCH keys & values =3D=3D NULL
> > seems like a nice way to simply quickly clear a map.
>
> This will change existing API as users will expect
> some error (e.g., -EFAULT) return when keys or values is NULL.

No reasonable user will call the current api with NULLs.

This is a similar API change to adding a new system call
(where previously it returned -ENOSYS) - which *is* also a UAPI
change, but obviously allowed.

Or adding support for a new address family / protocol (where
previously it -EAFNOSUPPORT)
Or adding support for a new flag (where previously it returned -EINVAL)

Consider why userspace would ever pass in NULL, two possibilities:
(a) explicit NULL - you'd never do this since it would (till now)
always -EFAULT,
  so this would only possibly show up in a very thorough test suite
(b) you're using dynamically allocated memory and it failed allocation.
  that's already a program bug, you should catch that before you call bpf()=
.

> We have a 'flags' field in uapi header in
>
>          struct { /* struct used by BPF_MAP_*_BATCH commands */
>                  __aligned_u64   in_batch;       /* start batch,
>                                                   * NULL to start from be=
ginning
>                                                   */
>                  __aligned_u64   out_batch;      /* output: next start ba=
tch */
>                  __aligned_u64   keys;
>                  __aligned_u64   values;
>                  __u32           count;          /* input/output:
>                                                   * input: # of key/value
>                                                   * elements
>                                                   * output: # of filled e=
lements
>                                                   */
>                  __u32           map_fd;
>                  __u64           elem_flags;
>                  __u64           flags;
>          } batch;
>
> we can add a flag in 'flags' like BPF_F_CLEAR_MAP_IF_KV_NULL with a comme=
nt
> that if keys or values is NULL, the batched elements will be cleared.

I just don't see what value this provides.

> > BPF_MAP_LOOKUP keys/values =3D=3D NULL might be useful if we just want
> > the values/keys and don't want to bother copying the keys/values...
> >
> > BPF_MAP_LOOKUP keys & values =3D=3D NULL might be useful to count
> > the number of populated entries.
>
> bpf_map_lookup_elem() does not have flags field, so we probably should no=
t
> change existins semantics.

This is unrelated to this patch, since this only touches 'batch' operation.
(unless I'm missing something)

> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > ---
> >   kernel/bpf/hashtab.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 5001131598e5..8fbdd000d9e0 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1873,9 +1873,9 @@ __htab_map_lookup_and_delete_batch(struct bpf_map=
 *map,
> >
> >       rcu_read_unlock();
> >       bpf_enable_instrumentation();
> > -     if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
> > +     if (bucket_cnt && (ukeys && copy_to_user(ukeys + total * key_size=
, keys,
> >           key_size * bucket_cnt) ||
> > -         copy_to_user(uvalues + total * value_size, values,
> > +         uvalues && copy_to_user(uvalues + total * value_size, values,
> >           value_size * bucket_cnt))) {
> >               ret =3D -EFAULT;
> >               goto after_loop;

