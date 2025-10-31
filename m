Return-Path: <bpf+bounces-73155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07998C24CDF
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 12:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B997A4EEDED
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 11:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4F23469E4;
	Fri, 31 Oct 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmczZhTo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41879345CB4
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910543; cv=none; b=mz9geMh0jzW0zDWtLNlOV5heUXezzYf+epywRnwNcKPQXTpzK7H19ZeEGIIKBNg0HHH6SEzOZC6I1Py+TiHZcmV+aBnq11ILSb2iqBvxDZXmGDaGn7tZJSXXu5BmNTGofK8DBw4azi3qJEusKc8RUe7WwjmPY8/Iuns0+djxDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910543; c=relaxed/simple;
	bh=zGfOY1YKgFGvpQyOBRrxFHQgGi+qTE8E9CATiNKrKcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCxAR5QunhPJhvjpd7YGRlrbRxVFu7jK6tw7G2AzM8mSiU8nLgsC/Vo65s3RYRzjhNx3CnGpENtxBR6+boc4yk/zI8X+rcmth92hxyYA2RFaZTs4LhzpWj0MnzXnL4vxvPK5EWwn6E+9rakfZItnlKmpraLCHHD9HXRE/ty7PCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmczZhTo; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63e336b1ac4so3576670d50.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761910541; x=1762515341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbYQROsqbxlCCT18FcNDkFe0rlrcvGndQ8kTMkEAgwk=;
        b=dmczZhTocGyCImgJzd+gMPfbpRCRNsfJ9UXVNKH/CVsAL/s3WuxWysiP44c1xxC3kn
         ps5fkQC0HjvhMKdADrLKUZqrOFIisFoE+fNa9O+8qS8NHkPrHwcumEArGFIzEZtDjMZj
         7ufN9FR7SqYBpZVnZUbwiiqTj3hhEZnxJcXoLJ26BLpIZGBVYcszIMCBdDsEyS+69yzm
         Dil7VXnVT22pZCfapyTkeRxpz2kmuM+KFeZACj1QjDiR0WlYS7Vp6WuftAgBIth1dnTA
         rMYQpGj7okJnGUFWOVqwxiqbvMETQUYLsSJC/zZgY8/Q/HlUcXLfF6F3J9QrUO131zLd
         lT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910541; x=1762515341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbYQROsqbxlCCT18FcNDkFe0rlrcvGndQ8kTMkEAgwk=;
        b=rwfRs3c0bIJejP8na7WmDRaxsGe/lMdusFyU5DrVQnRMNCkJmvEuFwhGo5KQrHo5vR
         chcnMfrKISQUOnu6LT0gWn1kd3kw6yhvXDlkIE2u1PvJGmpPcwMgYJbAJQpZGNTfUsOt
         kYbXSCbY26xhMt8sr0ImyHcslAPorZpolcNdjI1Q4/h3d8qLjtlvRHbZSY/2drSImNj9
         9PZVpSDIMK7xgHRkqHJqlVkB1boaFGOZawXaLWB9DX5piSnpNX1JVU+KvP4i3N/N0fE+
         X/R1dCIreWbAu6eYpwhIg/B/1aYWuUwN4zOXThVVZMnYFhYUTwD7BNc9d0NQjBibqiFK
         Ekyw==
X-Forwarded-Encrypted: i=1; AJvYcCXw456GkrXgoBilmWQwHUb2GiIJz7mN3voY8tK1GBKvun4q9xt2Mil/dOo0bd0joh+Zq9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFNpFII0LVAAGjVRhwTbMk2hzqPssj8hPDA1Azz1YS0B2RUQ6
	k1hogvhXieJJ0+SfBzRZA+iYdHenQVY/JNUCIRIs3FyQ+80bnoU/GWWPgR843a70ADTVZVkqyCu
	9530zs0uRaoSNmDLmeamxV37TBHieIRs=
X-Gm-Gg: ASbGncubgmAZIduGxk0Ice1sELt6yFbSr9FvyMgm7UTlXSLRNM10Tm1eixzraXOZnJc
	kYQVNq6A8Inezz2X7RVrdcXuRpE54xu6F+hKOur52cj19ZxqnkZorhGmDK4PimwaDpxoCzpxX55
	utcOR0OZuf+ELkWOxgC8Y8th4/L9d5CD5kwKxFcErB2SJyfjaY5x2qTpY+n4vujmBcnz+D7fIhj
	bw0+enIr+ejSP/mcF/c01twjhTVGPBrRZvj4Fz81BaGDNYPfoUC7tMoCKaDXA==
X-Google-Smtp-Source: AGHT+IEu9dWSv5Gv4oIclWkYCdwjipk6IKPGLuplrWhNfsF2BSjzskyBODi71LrFaVQiUOiO05FML1vQlRoaBoKLGH4=
X-Received: by 2002:a05:690e:4311:b0:63f:471b:c949 with SMTP id
 956f58d0204a3-63f828dc3f4mr4262945d50.8.1761910541181; Fri, 31 Oct 2025
 04:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev> <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
 <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
 <877bwcus3h.fsf@linux.dev> <CAADnVQJGiH_yF=AoFSRy4zh20uneJgBfqGshubLM6aVq069Fhg@mail.gmail.com>
 <87bjloht28.fsf@linux.dev> <CAHzjS_vRrxTLR0kFJvm4R3kO0s8hyN5Onsr6XfbA3Peyasz+Cg@mail.gmail.com>
In-Reply-To: <CAHzjS_vRrxTLR0kFJvm4R3kO0s8hyN5Onsr6XfbA3Peyasz+Cg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 31 Oct 2025 19:35:05 +0800
X-Gm-Features: AWmQ_bnhSoJ6Ut36XhdxJDrXBHOIvRPVygYW6oOyCo1P7xEhTIcG9Z7qxfxs8eM
Message-ID: <CALOAHbAAjx+OAOd=2y-fQUTbPd6gxVeybJd3RoTLYahb_ZO8DA@mail.gmail.com>
Subject: Re: bpf_st_ops and cgroups. Was: [PATCH v2 02/23] bpf: initial
 support for attaching struct ops to cgroups
To: Song Liu <song@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 2:14=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 4:24=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >
> > > On Thu, Oct 30, 2025 at 12:06=E2=80=AFPM Roman Gushchin
> > > <roman.gushchin@linux.dev> wrote:
> > >>
> > >> Ok, let me summarize the options we discussed here:
> > >>
> > >> 1) Make the attachment details (e.g. cgroup_id) the part of struct o=
ps
> > >> itself. The attachment is happening at the reg() time.
> > >>
> > >>   +: It's convenient for complex stateful struct ops'es, because a
> > >>       single entity represents a combination of code and data.
> > >>   -: No way to attach a single struct ops to multiple entities.
> > >>
> > >> This approach is used by Tejun for per-cgroup sched_ext prototype.
> > >
> > > It's wrong. It should adopt bpf_struct_ops_link_create() approach
> > > and use attr->link_create.cgroup.relative_fd to attach.
> >
> > This is basically what I have in v2, but Andrii and Song suggested that
> > I should use attr->link_create.target_fd instead.
> >
> > I have a slight preference towards attr->link_create.cgroup.relative_fd
> > because it makes it clear that fd is a cgroup fd and potentially opens
> > a possibility to e.g. attach struct_ops to individual tasks and
> > cgroups, but I'm fine with both options.
>
> relative_fd and relative_id have specific meaning. When multiple
> programs are attached to the same object (cgroup, socket, etc.),
> relative_fd and relative_id (together with BPF_F_BEFORE and
> BPF_F_AFTER) are used to specify the order of execution.
>
> >
> > Also, as Song pointed out, fd=3D=3D0 is in theory a valid target, so in=
stead of
> > using the "if (fd) {...}" check we might need a new flag. Idk if it
> > really makes sense to complicate the code for it.
> >
> > Can we, please, decide on what's best here?
>
> How about we add a new attach_type BPF_STRUCT_OPS_CGROUP?

I'm concerned that defining a unique BPF_STRUCT_OPS_XXX for each type
might lead to a maintainability challenge. To keep the design clean
and forward-looking, we might want to consider a more generic
abstraction that could easily accommodate other kernel structures
(task_struct, mm_struct, etc.) without duplication.

--=20
Regards
Yafang

