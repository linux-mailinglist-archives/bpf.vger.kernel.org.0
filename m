Return-Path: <bpf+bounces-51517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22DDA355A0
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 05:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135A7189116C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 04:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D16154C1D;
	Fri, 14 Feb 2025 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8N2CpiR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFDC2753EE
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506665; cv=none; b=UZVUeZqYv1/kSAHVQiqpo2slxuBCUp2Jc46+fODmjf5p51xh1T+jzrWZZKLCAxGXlnNygwV6hwhXfuh8fknnFMYM50W/LhNLIsk+1mNJmgtyonJuy0hjCewSkjaakXI5RIYVHsFhk+9IVpNLtK/XIRQy0Lchj3rxuUihtEXlWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506665; c=relaxed/simple;
	bh=iseD36MDxDoQ8YZNAGl3EFmfoMJYAm4Hvcuw98SLPsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POd2D1I3+/gaEHm7cvKDmYqkhuAxOICFDGxCYdI93+IwmqcfiaNYv5h58rYiWzXs9DaWV450xA4B8F/hHf9dnOvQbQz0n9Snh8WbhI1GJq27ziI//00xKZoho6/HWE8kPnrxuT4aCNhXbR8lwruQExk+oyhqj9sy5rvIHswcKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8N2CpiR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dd14c9a66so728631f8f.0
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 20:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739506662; x=1740111462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ULpYy2Sp5/vojvXzawMg4wZdKp9Fk8So9EvFM6vNOo=;
        b=B8N2CpiRfcoloofJWanbv6Ywo2PAjyvL57H0N2VyTPdMLizJo6YMy4QZr9hQAGJXRP
         UTHdGIG9Lbh9B5EAZHGxB7tf6W3DhSv+cgULh2v8XAT4FrsPBvAKYHXpokJehfcAMfaf
         N/k6Kgvn/BMefpCJWrcnjaRg3O6cdgMcTUqa8qyu9wfZfWGtYptL9Pza4VeVzSQhXo9m
         7mF8j+OsldZzKL76PQpZvcNrshyl3QEIMvEPYWeOgJp285SPsnEyWBFw6z7rqB0uUltC
         K1dKNkkOsbcHXw6piE6CGqn37+S/H6eQxzRQvg4fbHnFeM9xRrAlqw47GKXV4jKdBPXR
         UxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739506662; x=1740111462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ULpYy2Sp5/vojvXzawMg4wZdKp9Fk8So9EvFM6vNOo=;
        b=dcsB+mrIpY2/Xk1L8nJOTpfawz+/886hs2OdnsM6uTzqOmsne0cdyWK3gxGYi5nOs3
         sqX2Htrymu2jyqTXCwuwLbf3ltkWrv8UKfs5/n8D3/TC4rX/Gdp15AY0FrACnIHwc/7y
         YJsWRGFF0CAKQjnupZag6pn3Gd/ppsDkSsHdGk4oJVoYUe+ql7+Il01XEjSTVZWlD76Q
         m/pWop0nJzO5JMCnQF3fgEHJWedlGDgk/TsaT5LoA4p4ALIHhxih/DSzCGGgpc+l/jX7
         1QkGeIhazYo2SJgzDQZ1OXHYBodSeMI0I3iWQ5mr5yGd03GNErNqSCX+6tFxpqwjY9Wr
         1VCw==
X-Gm-Message-State: AOJu0YymfbkIA19HVymRTY2ThQduk0Mz3xTlkXKC1G92/oYRl23r6HNQ
	iTJtZP8YKUjFC5Mi4H/IYPT/oSr5gnpSkwvv/4lUoGjIu+E3Vyvu5iM378oUhshcf3NGiqU54JL
	m8hFeLVjL/f3/BG+Ir6k4GBI8xs8=
X-Gm-Gg: ASbGnct7NgtKr4T2VDrAt+M/4SIGiM3jgXpsj3Gsbxp/uXO002ErUgjjNNDn/BKBr0C
	7u2gn6YLTMyKVr29X7BgrH+watcYZ8F1EiclkJNTPOVAuXhl2rFQQS7u30M5ZnO62pOMP9iZrXV
	OQOyQG5hDlMf6l2gK11ARjf2K+FkBt
X-Google-Smtp-Source: AGHT+IGBtKWN2USXxhMnzAkbSS03Tz2sPPR64vaY/Jt+JreHiKZ9g5KbRl1wDyD+Ayymnfa2I5oOdXzASO5Tz5DKnBk=
X-Received: by 2002:a05:6000:1f81:b0:38f:2173:b7b7 with SMTP id
 ffacd0b85a97d-38f2173b9aemr8086924f8f.18.1739506661502; Thu, 13 Feb 2025
 20:17:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125111109.732718-1-houtao@huaweicloud.com>
 <20250125111109.732718-7-houtao@huaweicloud.com> <CAADnVQL+866m69rv+PC_V1y1-PjL4=w3obTwqLPgW3=kA_BjEg@mail.gmail.com>
 <6223b1f5-b491-fcec-b50c-222f1075f952@huaweicloud.com>
In-Reply-To: <6223b1f5-b491-fcec-b50c-222f1075f952@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 20:17:30 -0800
X-Gm-Features: AWEUYZlAXdt_FLBgs9P38qMnAXmUMToceDlPfJUpC1U_S3K0-pHakJNgoQS4uh8
Message-ID: <CAADnVQ+G9YQyj8-Q7UFT9y26tD1Rud_AgRu-D-s1LruYE03NZQ@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 8:12=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/14/2025 7:56 AM, Alexei Starovoitov wrote:
> > On Sat, Jan 25, 2025 at 2:59=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> When there is bpf_dynptr field in the map key btf type or the map key
> >> btf type is bpf_dyntr, set BPF_INT_F_DYNPTR_IN_KEY in map_flags.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 07c67ad1a6a07..46b96d062d2db 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -1360,6 +1360,34 @@ static struct btf *get_map_btf(int btf_fd)
> >>         return btf;
> >>  }
> >>
> >> +static int map_has_dynptr_in_key_type(struct btf *btf, u32 btf_key_id=
, u32 key_size)
> >> +{
> >> +       const struct btf_type *type;
> >> +       struct btf_record *record;
> >> +       u32 btf_key_size;
> >> +
> >> +       if (!btf_key_id)
> >> +               return 0;
> >> +
> >> +       type =3D btf_type_id_size(btf, &btf_key_id, &btf_key_size);
> >> +       if (!type || btf_key_size !=3D key_size)
> >> +               return -EINVAL;
> >> +
> >> +       /* For dynptr key, key BTF type must be struct */
> >> +       if (!__btf_type_is_struct(type))
> >> +               return 0;
> >> +
> >> +       if (btf_type_is_dynptr(btf, type))
> >> +               return 1;
> >> +
> >> +       record =3D btf_parse_fields(btf, type, BPF_DYNPTR, key_size);
> >> +       if (IS_ERR(record))
> >> +               return PTR_ERR(record);
> >> +
> >> +       btf_record_free(record);
> >> +       return !!record;
> >> +}
> >> +
> >>  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
> >>  /* called via syscall */
> >>  static int map_create(union bpf_attr *attr)
> >> @@ -1398,6 +1426,14 @@ static int map_create(union bpf_attr *attr)
> >>                 btf =3D get_map_btf(attr->btf_fd);
> >>                 if (IS_ERR(btf))
> >>                         return PTR_ERR(btf);
> >> +
> >> +               err =3D map_has_dynptr_in_key_type(btf, attr->btf_key_=
type_id, attr->key_size);
> >> +               if (err < 0)
> >> +                       goto put_btf;
> >> +               if (err > 0) {
> >> +                       attr->map_flags |=3D BPF_INT_F_DYNPTR_IN_KEY;
> > I don't like this inband signaling in the uapi field.
> > The whole refactoring in patch 4 to do patch 6 and
> > subsequent bpf_map_has_dynptr_key() in various places
> > feels like reinventing the wheel.
> >
> > We already have map_check_btf() mechanism that works for
> > existing special fields inside BTF.
> > Please use it.
>
> Yes. However map->key_record is only available after the map is created,
> but the creation of hash map needs to check it before the map is
> created. Instead of using an internal flag, how about adding extra
> argument for both ->map_alloc_check() and ->map_alloc() as proposed in
> the commit message of the previous patch ?
> >
> > map_has_dynptr_in_key_type() can be done in map_check_btf()
> > after map is created, no ?
>
> No. both ->map_alloc_check() and ->map_alloc() need to know whether
> dynptr is enabled (as explained in the previous commit message). Both of
> these functions are called before the map is created.

Is that the explanation?
"
The reason for an internal map flag is twofolds:
1) user doesn't need to set the map flag explicitly
map_create() will use the presence of bpf_dynptr in map key as an
indicator of enabling dynptr key.
2) avoid adding new arguments for ->map_alloc_check() and ->map_alloc()
map_create() needs to pass the supported status of dynptr key to
->map_alloc_check (e.g., check the maximum length of dynptr data size)
and ->map_alloc (e.g., check whether dynptr key fits current map type).
Adding new arguments for these callbacks to achieve that will introduce
too much churns.

Therefore, the patch uses the topmost bit of map_flags as the internal
map flag. map_create() checks whether the internal flag is set in the
beginning and bpf_map_get_info_by_fd() clears the internal flag before
returns the map flags to userspace.
"

As commented in the other patch map_extra can be dropped (I hope).
When it's gone, the map can be destroyed after creation in map_check_btf().
What am I missing?

