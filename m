Return-Path: <bpf+bounces-73523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB40C33609
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751533AFBF9
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFDD2DF147;
	Tue,  4 Nov 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2MLQOXB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD42DCF5B
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298783; cv=none; b=kP7Gf10BxjanS00sDv3o/Ru8CykYNNxKDzpmQmZ2whweL5DQXNCsLuYKMgHGZUgRcK+tqi27WKCHODOnKpp1LVJuXV9Qme8MBJhoI6yI+/BDIEwPCP0zdFfzOhGCy1JnzIoidv28qS1QhUEZouxZAJMtlYxMU7bpy+WrP/k81ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298783; c=relaxed/simple;
	bh=kTxxj2mQfgeacg33dNTEEX/y+5Iq8awGfY1rVTjRgRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRY/rOdbtPO9gYi9Qge2YVRj35rI7vHtfhrT+ytS3IdKfCafut5cjLPer4P2JHrBxJ+ZDIsjAxlON13VB4aWbra/HOEW/59J4edLi+LpSnE+U9vRlP4k3GCt9ws5Fk4q2jgkBGVTn7FfpHlni6bzFNOeCcfaBeXqGYz/LSFB2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2MLQOXB; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63fd493ea10so273315d50.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 15:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298781; x=1762903581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRzyYOcGI3gkLHnDNazvDtWXeIGerHIP3pO9uFGiEwo=;
        b=e2MLQOXBJTlhedDeLpi2C6GxxvBmvt9959w3zEFvApn34Ba8Sv2xAZFgoqsHtUI+xp
         aMCwLVSLqKTlcnSyUBCMG9XlXI9NW79n/Knfj3vikdMKDHLEKrfuZQyMC/XuVcYBNFYx
         w8dqKB9FfYiVIT03BTwX63PwLI1sXgDfrPEgL1/W0eLofPPIGCeDxP2JtdmSz1FWfhxy
         xEWO/Ug5/Kk08hNC7AUUQ9wFkRURzv2ExcMvSSfjIuAHlexVwJb1khNSMhMKSKjfk+xG
         dGPmLTOp2fmKdJoMsjv3p8i/Z1dK4KlJxxeU6MfWEmghFMTMPKghPPM2KuxA0h5hSjZR
         XjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298781; x=1762903581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRzyYOcGI3gkLHnDNazvDtWXeIGerHIP3pO9uFGiEwo=;
        b=wzl0O8KF1320CBUdzg7ic+chYgoPZ6sA3LC3oDh53Jkgjp0mzJmUkB+ovqeoGgfsnG
         8qBkNerZAmRjRKaBOtQljzR/j3jLMJPlz8SYYajDRun9/zvNRjzonETaIPTQbUZvKsdW
         I7T8lLXl6Q6qK3frFq/0r4Uho/rsjmWYBGKDnPZmifmlKgl0BmyCT2dLaYpZmTn9I2tL
         Ya4qxE+IlfKXUeu8i59expPgnMjNFS9q7frdfGK0BU6K89oA40kAhySX3tqsUZHT2LPY
         AhbIo/ZsMy+/6LwntTTJf5cJJdNoRDhage4fsEVYHD9dYuuNC5R0V2Z7PH65nIUugVNl
         G2+w==
X-Gm-Message-State: AOJu0YxMzhhIFv0T5r7bGsZOjbEHTs2CdTOB9EHV27kCiYsjpG8IlgjH
	eWUwd0OEikauwfuMFmf2DWX5OQ1u4M5X+RXWiJhi8MBCFqRu1qznxWQ/qWU0DPvsgdmtP+WHMgS
	XgqLqSh8yOFnNDCUczKAqjnoJ+K9/Fao=
X-Gm-Gg: ASbGncs+Rl2m/cn/HUS7bYn8NRXvJ0zN84AxI0/y4ntswk5f+yqiQYWeVvYyvtwkfD1
	wjat6tVXyZxtOuBapMwqPMZsxcYot+5fgrnYBdxkxVGkQhfVYSAO8SMq25lp/2Nsz94ObRQJtNg
	Y21kw8XS9hiHV6sEN3Ib4DzqLrh5uLdS81+b67m54qbtpzswNwW9bZJ4XTZFCBS3f6Gzw/dwxzI
	FiW0A8cE13uGnjsJfFjBrEoapZq/E+61YaBRdFQ849qgqrLNJcEiQ3WYzKP105jShLacZJjDrs4
X-Google-Smtp-Source: AGHT+IEgkWnT1C6QrRig9LGJdFusLhlbIws2IJvDD4+6PCQuprFldOGVT8vm1bnSEVQAFDDt8PT+jeAZ7iP9BD7/ErU=
X-Received: by 2002:a05:690e:1206:b0:63f:aa88:5f6b with SMTP id
 956f58d0204a3-63fc74aebfemr3815563d50.6.1762298780593; Tue, 04 Nov 2025
 15:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-3-ameryhung@gmail.com>
 <5525A04E-70F7-4E13-AB12-A6905FB3697A@meta.com>
In-Reply-To: <5525A04E-70F7-4E13-AB12-A6905FB3697A@meta.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Nov 2025 15:26:07 -0800
X-Gm-Features: AWmQ_bkQCJ3pEABuJZjX9lC6281A5_Ea2-b9Orf4thPgw0VolO3x6D7XZ-MhBdE
Message-ID: <CAMB2axPqceLCLcF4FnwhKPP6DenxSx36XP6W43wCcCv6MviTkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with struct_ops
To: Song Liu <songliubraving@meta.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "tj@kernel.org" <tj@kernel.org>, 
	"martin.lau@kernel.org" <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 2:00=E2=80=AFPM Song Liu <songliubraving@meta.com> w=
rote:
>
>
>
> > On Nov 4, 2025, at 9:26=E2=80=AFAM, Amery Hung <ameryhung@gmail.com> wr=
ote:
> >
> > Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
> > a BPF program with a struct_ops map. This command takes a file
> > descriptor of a struct_ops map and a BPF program and set
> > prog->aux->st_ops_assoc to the kdata of the struct_ops map.
> >
> > The command does not accept a struct_ops program nor a non-struct_ops
> > map. Programs of a struct_ops map is automatically associated with the
> > map during map update. If a program is shared between two struct_ops
> > maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
> > associated struct_ops is ambiguous. The pointer, once poisoned, cannot
> > be reset since we have lost track of associated struct_ops. For other
> > program types, the associated struct_ops map, once set, cannot be
> > changed later. This restriction may be lifted in the future if there is
> > a use case.
> >
> > A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
> > the associated struct_ops pointer. The returned pointer, if not NULL, i=
s
> > guaranteed to be valid and point to a fully updated struct_ops struct.
> > For struct_ops program reused in multiple struct_ops map, the return
> > will be NULL.
> >
> > To make sure the returned pointer to be valid, the command increases th=
e
> > refcount of the map for every associated non-struct_ops programs. For
> > struct_ops programs, the destruction of a struct_ops map already waits =
for
> > its BPF programs to finish running. A later patch will further make sur=
e
> > the map will not be freed when an async callback schedule from struct_o=
ps
> > is running.
> >
> > struct_ops implementers should note that the struct_ops returned may or
> > may not be attached. The struct_ops implementer will be responsible for
> > tracking and checking the state of the associated struct_ops map if the
> > use case requires an attached struct_ops.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> > include/linux/bpf.h            | 16 ++++++
> > include/uapi/linux/bpf.h       | 17 +++++++
> > kernel/bpf/bpf_struct_ops.c    | 90 ++++++++++++++++++++++++++++++++++
> > kernel/bpf/core.c              |  3 ++
> > kernel/bpf/syscall.c           | 46 +++++++++++++++++
> > tools/include/uapi/linux/bpf.h | 17 +++++++
> > 6 files changed, 189 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a47d67db3be5..0f71030c03e1 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1726,6 +1726,8 @@ struct bpf_prog_aux {
> > struct rcu_head rcu;
> > };
> > struct bpf_stream stream[2];
> > + struct mutex st_ops_assoc_mutex;
> > + struct bpf_map *st_ops_assoc;
> > };
>
> In the bpf-oom thread, we agreed (mostly agreed?) that we will allow
> attaching a struct_ops map multiple times.
>
> To match this design, shall we associate a BPF program with a
> bpf_struct_ops_link instead of bpf_map? This requires one more
> pointer deref to get the pointer to the struct_ops map. But the
> solution will be more future proof.
>
> Does this make sense?

I think it makes sense and can be a future work to have the ability to
associate attachments. The command can be extended to take a link to
struct_ops map and a link to bpf program.

For this patchset, I think firstly we should still aim for providing a
way to associate the implementation (think of it as C++ class).

>
> Thanks,
> Song
>
>
>

