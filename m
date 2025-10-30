Return-Path: <bpf+bounces-73080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E42C2289F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 23:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6443BB6FD
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DEA33A038;
	Thu, 30 Oct 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjXjkS1I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213C26E16A
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862766; cv=none; b=Vv2GSDwPWHwVbkg2qq1hqeNRVbu0NfjAW9MmMVkEATLnY/gpZwwk/3BvTf3I7wzHCGQkolH1bLKT0WG7dWaaseCOZGbHRyrhfLUL6aL095jU70iDN/hKvDdcd2kOF5H6Vp3kNv8gGdq/RQ5qL3MgLm0zPtAx7lHnhFvi/LOnN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862766; c=relaxed/simple;
	bh=Q0NLfuAPRCRv2UVmufeZOfqT4b7DmYLGbcb7vMqjN8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXv7mu85NjiZJ72rBV+JnRPXoY5xCHvkgR5FNbz0UQKDi0aZS2u8mfrQjwRQxw9JolKV/MUYkbJqwSj6cNbS6y5N7jmFZTCkl3agnkJgCivzBMySeC7yImk2Eg7IqfAmulCHcC/JAw3KvPZAVt6qjeDbkuipsFKdKzYjps8d5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjXjkS1I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47721293fd3so9750535e9.1
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761862762; x=1762467562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwT0gzXBjfVIjqUHMyMXwgTVGE+oE1n+ZnWlhE9CZ5U=;
        b=OjXjkS1IDRMEsa3JaoykFfeSztq6wJvosHXa64fQAXuZSy9LFVkX7l3vlkq8/9Xd6j
         4f4UP4RhQoGgcVi1IU+M79alMqgX16ZhpM5hC4xzNUKTN4MB25wk/kSCIN5DeJcobX9P
         Sw+xhnHaxvHJKWnr3LlV6KOT2b9BEmn89S9hDxAq1mDT/ypy1YoszhniVjDgQEWLtQ62
         Sx+OBuluhCcDHN3nDx7AqBQO3cKirWQVr+SkC2wh18pMXGw7j5OlnwEqnxO/GcIgccXx
         vgomRqEdiXdL5W5Tg+BZx7JxxaWZX/vSN3Zzmg9ni4GDLOBd9hSTcvixS9Z0HxxxsDV7
         P/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761862762; x=1762467562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwT0gzXBjfVIjqUHMyMXwgTVGE+oE1n+ZnWlhE9CZ5U=;
        b=Qfk7MipaTiNzkekK6pmgeXePEsTyjFEzRohShOjEG5Mtfu8bnzgY9vTdD3+aFHNbYJ
         CM1nDDZejdx9khkqcUnbN8RptdzZ0oZ4K5a2i9X25x/m3KkPbq+LJaH1psEXgPjWEd3A
         DEMwFKGDzvfu1fM6VecwnxUZkLFgPFpTnhYPUS82APlqfZw33Gssc3XtEUhG8d27jAuM
         d568gn0GjqMnP14Tjpqgh0wFk4E75ixGhgTpogHdBCh1jK6bZ7wUeuu3Di66AwpP4qYd
         KMZH4MR56SOueyKbA5r3P/T7mEGzvoJ1jT51/KuH+9njV961v4tM1RbJ6VauXll593bl
         HH4A==
X-Forwarded-Encrypted: i=1; AJvYcCVvuzwdGplbNU+7z6tp/ene0AkaxrEGBXNVd3+6UaXDvLJVLG749KpDpOIP84WGizPwvJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+bwo576iATPTfMBcvDYryAGMLGgZ6BRbpD84yFybisM0Y1y9
	BStCE0pHlUXMa74Od7rK7tNLlaKC1P1v2vtxPprZ/fP3rA72ULypZIP9ZNQFUml+6Y+DjFXDZ2i
	7EbXzxM3/beXyH7I0pQRpU8tAZLcM56A=
X-Gm-Gg: ASbGncurmCPlMRSxaBo3XfQ4eqMdZbAUHmbr05aLf2BL1eFOZ8qz6flDJyKHAydJ5iv
	rszhA/aktoWVn0pnWrk+25Py06lsMkzHpLMyPoycN5BeKKmB8vqpsxg2nsEb/mufjY/3grqEhU5
	kI2hJHz9letPdtGbsb9/RU40xZk0biympBuPt36zZhwThIaPEZHI08QZbgBcSRVrhSKgRCBEYai
	kS8e+VWWkPQQrmZbRMD0KaaLx4GQpeuOh5Kz+ylAk6265tNPdJSxk2cWD8TmoDgL/Qs/uygUHpg
	AbWsyFAw0Q197+TI7ygomN9NpLeO
X-Google-Smtp-Source: AGHT+IFiyX3dJnURSNNpVr0vY2zqjAiRZhDfNNfk8vGHPMc1PF33QyAD/7tk5XU1FaTuD+gAkKoljP+gHiDD9PWESHk=
X-Received: by 2002:a05:600c:8189:b0:475:de75:84c6 with SMTP id
 5b1f17b1804b1-477262a941emr44348555e9.12.1761862762377; Thu, 30 Oct 2025
 15:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev> <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
 <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com> <877bwcus3h.fsf@linux.dev>
In-Reply-To: <877bwcus3h.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 15:19:11 -0700
X-Gm-Features: AWmQ_bncjILdks5wFOJTGOLbyWVnc9Lf7_PQRe6yc5ZnQYFFDm9_YYMU7X8G_V0
Message-ID: <CAADnVQJGiH_yF=AoFSRy4zh20uneJgBfqGshubLM6aVq069Fhg@mail.gmail.com>
Subject: bpf_st_ops and cgroups. Was: [PATCH v2 02/23] bpf: initial support
 for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:06=E2=80=AFPM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Ok, let me summarize the options we discussed here:
>
> 1) Make the attachment details (e.g. cgroup_id) the part of struct ops
> itself. The attachment is happening at the reg() time.
>
>   +: It's convenient for complex stateful struct ops'es, because a
>       single entity represents a combination of code and data.
>   -: No way to attach a single struct ops to multiple entities.
>
> This approach is used by Tejun for per-cgroup sched_ext prototype.

It's wrong. It should adopt bpf_struct_ops_link_create() approach
and use attr->link_create.cgroup.relative_fd to attach.
At that point scx can enforce that it attaches to one cgroup only
if it simplifies things for sched-ext. That's fine.
But api must be link based.
Otherwise cgroup_id inside st_ops all the way from bpf prog
will not be backward compatible if/when people would want
to attach the same sched-ext to multiple cgroups.

> 2) Make the attachment details a part of bpf_link creation. The
> attachment is still happening at the reg() time.
>
>   +: A single struct ops can be attached to multiple entities.
>   -: Implementing stateful struct ops'es is harder and requires passing
>      an additional argument (some sort of "self") to all callbacks.

sched-ext is already suffering from lack of 'this'.
The current workarounds with prog_assoc and aux__prog are not great.
We should learn from that mistake instead of repeating it with bpf-oom.

As far as 'this' I think we should pass
'struct bpf_struct_ops_link *' to all callbacks.
This patch is proposing to have cougrp_id in there.
It can be a pointer to cgroup too. This detail we can change later.

We can brainstorm a way to pass 'link *' in run_ctx,
and have an easy way to access it from ops and from kfuncs
that ops will call.
The existing tracing style bpf_set_run_ctx() should work for bpf-oom,
and 'link *'->cgroup_id->cgrp->memcg will be there for ops
and for kfuncs, but it doesn't quite work for sched-ext as-is
that wants run_ctx to be different for sched-ext-s
attached at different levels of hierarchy.
Maybe additional bpf_set_run_ctx() while traversing
hierarchy will do the trick?
Then we might not even need aux_prog and kf_implicit_args that much.
Though they may be useful on their own though.

> I'm using this approach in the bpf oom proposal.
>
> 3) Move the attachment out of .reg() scope entirely. reg() will register
> the implementation system-wide and then some 3rd-party interface
> (e.g. cgroupfs) should be used to select the implementation.

We went that road with ioctl-s and subsystem specific ways to attach.
All of them sucked. link_create is the only acceptable approach
because it returns FD.

