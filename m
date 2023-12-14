Return-Path: <bpf+bounces-17870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE659813A87
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 20:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19861C20F29
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317A692A0;
	Thu, 14 Dec 2023 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2vLiHn5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D469293
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d099d316a8so4659867b3a.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 11:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702581335; x=1703186135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMmu34dOJ60TG428lyxZnWyZxGAM75Uca7Pib30MkbA=;
        b=Y2vLiHn5g3hpOLmjwTzeJ0Vuol36QfiHtz8yu/Gi889qOA06zX3cgEhf8A49gOonew
         XlVyO7d8WsF2OLR9tZtuDwGpY/QvYLshXrDsZKuBdMaQ72pio3JZX0Ji40dYhulecDmp
         qpmNtHF3mgrTnKGuVhawFR/9IiPB5mKzXn8RGIPJSa8Tz8p0dLYrYCXzuepyYUmowRvP
         OBLFcP0DD7oBlKWEIoi2IvCPDru/p0uJjJZj50PG23kv1htFgcP6rwD3uGZIBrN5n2hl
         mwPQm+1A5ahAeUGtwnFO0TVjLjvHB83UujnvBbVDLEa3TkE/Szr1doaE6swYPkZyjM2i
         n7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702581335; x=1703186135;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QMmu34dOJ60TG428lyxZnWyZxGAM75Uca7Pib30MkbA=;
        b=EKHM6fGN0MI/cIaWLOwqmFV4NyLIreax5du2SyuJ97jASCkCJc4DxQgZNVrt9PQjRO
         MY0LODgib3Cy4HSeiyRSXT4alN95uYfUx/Pj0K+b1h25wPqPPsRwYVqs0f5bL3Kka00j
         hvnbY/NKRd6MEqL23EYSo5MIYL5moFuB8opJUh6qUC1hO6OZ095DN4ATtgDhySIFKaNr
         kJJn776/vN2+m3+Lh96dNmZV6BHzOesroRBi0ROG/unQzXlwWOD7jDQ0yiodn5YDlKMk
         ginvb5yCHoQgjgk0F0cLubOWjXf5Pnq4B75Blwc4CR2Q2gMw2TnH5v+Aa0HHvjdq4Uow
         Ju/A==
X-Gm-Message-State: AOJu0YyXf7AQ4V9fJRhBP2pWLIFqCjx52VA8R/s1e6hRO2O2ELUMTrEb
	j+UkGDD/7hLJXcZ2muvl0JE=
X-Google-Smtp-Source: AGHT+IErId4+2xPG+fudbpHRCQqSfJ8BY2bmshNf/h+vJhzTAKx2aTxNcTlIgLcTa9F2fk7wW1e9Gg==
X-Received: by 2002:a05:6a21:192:b0:18f:97c:614e with SMTP id le18-20020a056a21019200b0018f097c614emr11583403pzb.75.1702581334616;
        Thu, 14 Dec 2023 11:15:34 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id e4-20020aa79804000000b006d26b1c0848sm911561pfl.101.2023.12.14.11.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:15:33 -0800 (PST)
Date: Thu, 14 Dec 2023 11:15:32 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Hou Tao <houtao@huaweicloud.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 bpf <bpf@vger.kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Song Liu <song@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 xingwei lee <xrivendell7@gmail.com>, 
 Hou Tao <houtao1@huawei.com>
Message-ID: <657b545493a0b_511332086@john.notmuch>
In-Reply-To: <CAADnVQK+C+9BVowRxESJhuH7BM+SWn2u_fTU2wjH0YuA-N9egw@mail.gmail.com>
References: <20231214043010.3458072-1-houtao@huaweicloud.com>
 <20231214043010.3458072-2-houtao@huaweicloud.com>
 <657a9f1ea1ff4_48672208f0@john.notmuch>
 <ba0e18ba-f6be-ceb9-412e-48e8e41cb5b6@huaweicloud.com>
 <CAADnVQK+C+9BVowRxESJhuH7BM+SWn2u_fTU2wjH0YuA-N9egw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Reduce the scope of rcu_read_lock
 when updating fd map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov wrote:
> On Wed, Dec 13, 2023 at 11:31=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >
> > Hi,
> >
> > On 12/14/2023 2:22 PM, John Fastabend wrote:
> > > Hou Tao wrote:
> > >> From: Hou Tao <houtao1@huawei.com>
> > >>
> > >> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or=

> > >> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
> > >> callbacks.
> > >>
> > >> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't =
need
> > >> rcu-read-lock because array->ptrs must still be allocated. For
> > >> bpf_fd_htab_map_update_elem(), htab_map_update_elem() only require=
s
> > >> rcu-read-lock to be held to avoid the WARN_ON_ONCE(), so only use
> > >> rcu_read_lock() during the invocation of htab_map_update_elem().
> > >>
> > >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > >> ---
> > >>  kernel/bpf/hashtab.c | 6 ++++++
> > >>  kernel/bpf/syscall.c | 4 ----
> > >>  2 files changed, 6 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > >> index 5b9146fa825f..ec3bdcc6a3cf 100644
> > >> --- a/kernel/bpf/hashtab.c
> > >> +++ b/kernel/bpf/hashtab.c
> > >> @@ -2523,7 +2523,13 @@ int bpf_fd_htab_map_update_elem(struct bpf_=
map *map, struct file *map_file,
> > >>      if (IS_ERR(ptr))
> > >>              return PTR_ERR(ptr);
> > >>
> > >> +    /* The htab bucket lock is always held during update operatio=
ns in fd
> > >> +     * htab map, and the following rcu_read_lock() is only used t=
o avoid
> > >> +     * the WARN_ON_ONCE in htab_map_update_elem().
> > >> +     */

Ah ok but isn't this comment wrong because you do need rcu read lock to d=
o
the walk with lookup_nulls_elem_raw where there is no lock being held? An=
d
then the subsequent copy in place is fine because you do have a lock.

So its not just to appease the WARN_ON_ONCE here it has an actual real
need?

> > >> +    rcu_read_lock();
> > >>      ret =3D htab_map_update_elem(map, key, &ptr, map_flags);
> > >> +    rcu_read_unlock();
> > > Did we consider dropping the WARN_ON_ONCE in htab_map_update_elem()=
? It
> > > looks like there are two ways to get to htab_map_update_elem() eith=
er
> > > through a syscall and the path here (bpf_fd_htab_map_update_elem) o=
r
> > > through a BPF program calling, bpf_update_elem()? In the BPF_CALL
> > > case bpf_map_update_elem() already has,
> > >
> > >    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held())
> > >
> > > The htab_map_update_elem() has an additional check for
> > > rcu_read_lock_trace_held(), but not sure where this is coming from
> > > at the moment. Can that be added to the BPF caller side if needed?
> > >
> > > Did I miss some caller path?
> >
> > No. But I think the main reason for the extra WARN in
> > bpf_map_update_elem() is that bpf_map_update_elem() may be inlined by=

> > verifier in do_misc_fixups(), so the WARN_ON_ONCE in
> > bpf_map_update_elem() will not be invoked ever. For
> > rcu_read_lock_trace_held(), I have added the assertion in
> > bpf_map_delete_elem() recently in commit 169410eba271 ("bpf: Check
> > rcu_read_lock_trace_held() before calling bpf map helpers").
> =

> Yep.
> We should probably remove WARN_ONs from
> bpf_map_update_elem() and others in kernel/bpf/helpers.c
> since they are inlined by the verifier with 99% probability
> and the WARNs are never called even in DEBUG kernels.
> And confusing developers. As this thread shows.

Agree. The rcu_read needs to be close as possible to where its actually
needed and the WARN_ON_ONCE should be dropped if its going to be
inlined.

> =

> We can replace them with a comment that explains this inlining logic
> and where the real WARNs are.=

