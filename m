Return-Path: <bpf+bounces-52700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ECFA46F47
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 00:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DD73ACDBD
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29AB2702B7;
	Wed, 26 Feb 2025 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="C6My71cp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC32702A9
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611848; cv=none; b=Z3xYzLTNGa3clUXdc6AVeEGzQbWa3ZWoYUZYmLwde2HfPEtcTgE6rZGGNiDUUaB3vpxdyy5h1KVryfkRh8xM0xba5vPT0k/1GMjVBUBfXMv2xRH7wvJKeBpMxRDuv1cqS8MYmO+GfNNw6cP7t+FmPFLnnfoFEo1tSOXW2NyriAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611848; c=relaxed/simple;
	bh=PJUAT1UbrdAic8VAB7QjIajmD0h4o2bimcIQyhoFfDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLI35UAWgyu8maigAyj2nX72KWh5ucCfSqmFf2lFD18E4+1ItblKJj7RXYvDT6vMO15DpQUZLueYi1ij+A7jV3mn/5zBirWs589yOlVQKyW97YxGLFxzLAg0A+Fi3CPv24ariIY5zGB27Zg78UfsutNnEiKdBj3Z6thLYmAC4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=C6My71cp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so594222a91.2
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 15:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1740611846; x=1741216646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJUAT1UbrdAic8VAB7QjIajmD0h4o2bimcIQyhoFfDY=;
        b=C6My71cpTdFeKgahQKlHh22WyoeAmKeOx/RtpDQ21rKgsv2cBoP86MPCN2afTzoy4v
         LnZ+6lErxCUPKVmRlJta4OqBgI615F5iBdAq1JOkiXCMpt/diYknh/AVspjsmCQKrpCD
         eScALRzvbZWydxIU1eLY3trdBchRWI1+VbF4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740611846; x=1741216646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJUAT1UbrdAic8VAB7QjIajmD0h4o2bimcIQyhoFfDY=;
        b=NTg5afzBAKzTugm7xE6VCruwzcQhprf4jN5Bif5grPxJGY9NgDVlKtj60FF2n0RxBo
         hjaKoeQTaOsuLP4VMsfgYP40xwJlGzSb7M25mMurxODWSXk9epsr+4KN0L9+EytfYmEy
         TkDlW0hRZzqGEsWZSXrlAyPTmGxqlTxterZv+ommCPL0HnyeNLxX4KZgKNMG5O4JcTLC
         Bxz7AUGf3ITlO9KYs23oKjpslcGt5MYH2O5Jx3k50KudIx/m8cs8n7rIwRSl/eVH0HiQ
         oMYePb44C9iNn3Ng1iWpp4EYOkkChjMkfc31jKNnT8H+JOv56Cage5exy5ixeSlby8p3
         dZqg==
X-Forwarded-Encrypted: i=1; AJvYcCX396qGNapPDiTK/6ndCpEfooq2bX4+TpraEdD9NHfdWw7fx9FpVUwVLV4rQSGikVu7gzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6VF7fnlIinRO+VVBb1O8g+/qAjdFsTM7H/4GHvkFrYoNKLQb
	Bqoi4/pj070Q+bAvd1tYLpfcwhe394wxWCS+/wD++8fozp/aRP98zxlanSbxLukMZN8P29t5rPJ
	WaRanvr8ofThLPUdGCEsl2qFGWJ9NkMw+ggdBIg==
X-Gm-Gg: ASbGncvYfE0Srz7oeamac5BjBkGGIF6GzNnfJ+Xg7tlu102HnUkbyIDD/5BiYzLNOpJ
	Amnv41UZjQ1oq5YQxUtqpAROmdMZH/10liKrEpBZsx0JRdJbk8be+9/8nGKbxWTLERMJtqKmVah
	GOhvAbugI=
X-Google-Smtp-Source: AGHT+IEFSFQpC1vvlRzXzOjcyg1fQE3hX7hbLnAFjkXiFucaHDeDsXZs+BP3a/ZA6RIOas9YZDSaZ69cex2B1uL826E=
X-Received: by 2002:a17:90b:2dc2:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-2fe7e3b3240mr7975884a91.35.1740611845842; Wed, 26 Feb 2025
 15:17:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204082848.13471-1-hotforest@gmail.com> <20250204082848.13471-3-hotforest@gmail.com>
 <cca6daf2-48f4-57b9-59a9-75578bb755b9@huaweicloud.com> <8734gr3yht.fsf@toke.dk>
 <d191084a-4ab4-8269-640f-1ecf269418a6@huaweicloud.com> <CAADnVQKD94q-G4N=w9PJU+k6gPhM8GmUYcyfj=33B_mKX6Qbjw@mail.gmail.com>
 <6a84a878-0728-0a19-73d2-b5871e10e120@huaweicloud.com> <CAADnVQLrJBOSXP41iO+-FtH+XC9AmuOne7xHzvgXop3DUC5KjQ@mail.gmail.com>
In-Reply-To: <CAADnVQLrJBOSXP41iO+-FtH+XC9AmuOne7xHzvgXop3DUC5KjQ@mail.gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Wed, 26 Feb 2025 15:17:14 -0800
X-Gm-Features: AQ5f1JqnWHge4_a8Nx5GCdGvYNw8UYZYFEyDjK-1r2wSfSaoAGChMAU20a6lTCQ
Message-ID: <CAC1LvL0ntdrWh_1y0EcVR6C1_WyqOQ15EhihfQRs=ai7pcE-Sw@mail.gmail.com>
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	bpf <bpf@vger.kernel.org>, rcu@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, Cody Haas <chaas@riotgames.com>, 
	Hou Tao <hotforest@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 25, 2025 at 8:05=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> > Hi,
> >
> > On 2/26/2025 11:24 AM, Alexei Starovoitov wrote:
> > > On Sat, Feb 8, 2025 at 2:17=E2=80=AFAM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> > >> Hi Toke,
> > >>
> > >> On 2/6/2025 11:05 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > >>> Hou Tao <houtao@huaweicloud.com> writes:
> > >>>
> > >>>> +cc Cody Haas
> > >>>>
> > >>>> Sorry for the resend. I sent the reply in the HTML format.
> > >>>>
> > >>>> On 2/4/2025 4:28 PM, Hou Tao wrote:
> > >>>>> Currently, the update of existing element in hash map involves tw=
o
> > >>>>> steps:
> > >>>>> 1) insert the new element at the head of the hash list
> > >>>>> 2) remove the old element
> > >>>>>
> > >>>>> It is possible that the concurrent lookup operation may fail to f=
ind
> > >>>>> either the old element or the new element if the lookup operation=
 starts
> > >>>>> before the addition and continues after the removal.
> > >>>>>
> > >>>>> Therefore, replacing the two-step update with an atomic update. A=
fter
> > >>>>> the change, the update will be atomic in the perspective of the l=
ookup
> > >>>>> operation: it will either find the old element or the new element=
.
> > > I'm missing the point.
> > > This "atomic" replacement doesn't really solve anything.
> > > lookup will see one element.
> > > That element could be deleted by another thread.
> > > bucket lock and either two step update or single step
> > > don't change anything from the pov of bpf prog doing lookup.
> >
> > The point is that overwriting an existed element may lead to concurrent
> > lookups return ENOENT as demonstrated by the added selftest and the
> > patch tried to "fix" that. However, it seems using
> > hlist_nulls_replace_rcu() for the overwriting update is still not
> > enough. Because when the lookup procedure found the old element, the ol=
d
> > element may be reusing, the comparison of the map key may fail, and the
> > lookup procedure may still return ENOENT.
>
> you mean l_old =3D=3D l_new ? I don't think it's possible
> within htab_map_update_elem(),
> but htab_map_delete_elem() doing hlist_nulls_del_rcu()
> then free_htab_elem, htab_map_update_elem, alloc, hlist_nulls_add_head_rc=
u
> and just deleted elem is reused to be inserted
> into another bucket.
>
> I'm not sure whether this new hlist_nulls_replace_rcu()
> primitive works with nulls logic.
>
> So back to the problem statement..
> Are you saying that adding new to a head while lookup is in the middle
> is causing it to miss an element that
> is supposed to be updated assuming atomicity of the update?
> While now update_elem() is more like a sequence of delete + insert?
>
> Hmm.

Yes, exactly that. Because update_elem is actually a delete + insert (actua=
lly
an insert + delete, I think?), it is possible for a concurrent lookup to se=
e no
element instead of either the old or new value.

>
> > I see. In v2 I will fallback to the original idea: adding a standalone
> > update procedure for htab of maps in which it will atomically overwrite
> > the map_ptr just like array of maps does.
>
> hold on. is this only for hash-of-maps ?

I believe this was also replicated for hash as well as hash-of-maps. Cody c=
an
confirm, or use the reproducer he has to test that case.

> How that non-atomic update manifested in real production?
>

See [1] (in the cover letter for this series, also replicated below).

[1] : https://lore.kernel.org/xdp-newbies/07a365d8-2e66-2899-4298-b8b158a92=
8fa@huaweicloud.com/T/#m06fcd687c6cfdbd0f9b643b227e69b479fc8c2f6

