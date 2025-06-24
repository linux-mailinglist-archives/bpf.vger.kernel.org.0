Return-Path: <bpf+bounces-61385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E203AE6BB1
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC9616A064
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3C242056;
	Tue, 24 Jun 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfyE/4sq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB792274B48;
	Tue, 24 Jun 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780025; cv=none; b=NJAaozrdMyHjw+jEGleAI1jFZo7reqr5aC8lzckgDUSDD7SuXsse0d3EtjV4+BjqimIx6cx/Ti2M9+e2aZEqUZ6MTteoP8ekKj9UMU6h2xXKHNCAQKJnVIK+lhxo3GP+wLmdfMpon4ZbGk32/4NiIz0gpeJgx9uiyV/Ux6+DwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780025; c=relaxed/simple;
	bh=bEgyIF0gPyv3OlmVcxgjuwCT0t8SXvMmMi33RhCZ1p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVR21YUePsS4rHJF84mlGD8PjEE4Mhx8AxR9s79SBh4d91GUnim4+i5BqM/dyQdZ3Afi1b6icORcOo5SH2lANHN3QhuiAN6SLuYf/74dYE/1HDDjsEra8oGoUvxFSTZORuVlYgKD1a8dv4aL4FLHM/2ck4meAGlvfi1pRkV7YWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfyE/4sq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3139027b825so4172542a91.0;
        Tue, 24 Jun 2025 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750780023; x=1751384823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb5SkxmzVeXY2nyivTNrCb1qdDE3QBZTooEdXTe8Kbg=;
        b=lfyE/4sqAP5Y860Qk8cyivXnXNcWKmhZO4Pdelebaem8toR1GKcsSSWyU/cSBbGmqw
         kdbFC1IXc7Awg4ItyXWfC2t7arn5QPSfi0I0EcNA2H7JxXMvIsOsH/yXR+EnE9BOGKjE
         pmFRyYBt7avYei+2j8m8I+GUAnhCjCpARJOS2cTwDfuha6uCnO6czX0o5+IkvpzC9mpM
         bpETxMKzOdKVgcPJEFoGB92T6qhT8lPFphz1oTJUzUGN8ISBtoaFA4VbH2MxjG7mavDY
         KpSJY77jLzDQMRhRQqJGzxsZxU9sbjSPHD1EKrwTuJ2LtX3AcfTYRw9AgvnXE5YqDv55
         Kaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750780023; x=1751384823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zb5SkxmzVeXY2nyivTNrCb1qdDE3QBZTooEdXTe8Kbg=;
        b=ru1/O7IHfq7VhN9Nl/14r3ztWr0TEQSyn8X5DqBUufcA82vMZKkyW3YGfdyePSeSaw
         8LGxqUEBCuZpzWBZxdGJHUuTM0s0PtEnfzuGbGlQo/K3TJqiABlMuvWbkVDC268Zmcie
         fJCwMmnZztO8CbJpZ1F5JXRCqUsXeAHz/FSbjMbiJi4k4PwGoheEDzYIyi0cEJvvyhqE
         ySu2viCgevWhA/+rIyhtqXC3ANsN63s0AWtkN5vKV//eeVHkDxefw8o85JWwufTWwV58
         MosnUCh3YzFnf5ZbX8g5EQF7sInBXgnyv7+7Rcd1nyyAT8EpoEDJfBNVs6scIFCAgbCB
         uVJg==
X-Forwarded-Encrypted: i=1; AJvYcCUWZE0KPs2cjnGITYf6HDV1GS1x4Bw6H2kPR+NbPhmxA8yWKXBHTn4LyuBDPi98GTsuDsIYsRdxFwJtlySj@vger.kernel.org, AJvYcCWatPAjvEbfcyvG7RMk82qsTb1BbHfNTQZ/NFk4XWbeQEbURAxOdiVhRd8lZTGmrJwUTsuJ6KvYEAmZiI6p/AVhHx0X@vger.kernel.org, AJvYcCXTFJrWenCRo9gCOPh7cHuihjPZol5XvsGBg5zQmlFI5Oo1W97FK61cuTaGVqiegoYViFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+PCMccFNArDh0gFYO6nJi4hYEdZrEiKbIc0MxBT09FvQ7mU1
	m1GIm7vL+tDGoggItzTEtOdh6GPK0yjWOnAvstLsQ4ReVQUn1konCR1EF6Hn1Rj/S14nn+4cuBL
	WbA0Thhjm3a+oH1JxM4NNy4+OMEQsMqk=
X-Gm-Gg: ASbGncsZXi1u9o19v9YaHvmHCc6NZHXRLAuQNcUZD06gvhgeI6Bz/tIhZ5dBp36uXOx
	w2UQNyVShohPu0fvG8zpqVdichpYfdzyntkpm/24WHIle8bE8KXTxEUJFDpgsSXyJ7T8OMGFfnt
	u9zd/zjtteXGx+6waG2f+k2xRuVP0tSQsmAUPBWX10Vw==
X-Google-Smtp-Source: AGHT+IGulY4fVHZea0uh0QD4uZ2q/5NrSARZIND+EE0RXmHlYGEoQiRuG5/lEkOddrCSK7x/VHjuhY+SpnN4GrU/orQ=
X-Received: by 2002:a17:90b:274b:b0:313:33ca:3b8b with SMTP id
 98e67ed59e1d1-3159d648829mr28192998a91.9.1750780022856; Tue, 24 Jun 2025
 08:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623134342.227347-1-chen.dylane@linux.dev>
 <CAADnVQ+aZw4-3Ab9nLWrZUg78sc-SXuEGYnPrdOChw8m9sRLvw@mail.gmail.com>
 <CAEf4BzZVw4aSpdTH+VKkG_q6J-sQwSFSCyU+-c5DcA5euP49ng@mail.gmail.com>
 <aFpeyZnOuJ3Xr4J6@krava> <9034e367-e7e1-43b5-bd7c-70fc9a58335d@linux.dev>
In-Reply-To: <9034e367-e7e1-43b5-bd7c-70fc9a58335d@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Jun 2025 08:46:48 -0700
X-Gm-Features: AX0GCFtFWK01FVHEtDIMTXzxZKylAduFaZ6ekC-c7voTtfuHkItGGDWti9hlL7s
Message-ID: <CAEf4BzY7TZRjxpCJM-+LYgEqe23YFj5Uv3isb7gat2-HU4OSng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Show precise link_type for
 {uprobe,kprobe}_multi fdinfo
To: Tao Chen <chen.dylane@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:41=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/6/24 16:16, Jiri Olsa =E5=86=99=E9=81=93:
> > On Mon, Jun 23, 2025 at 01:59:18PM -0700, Andrii Nakryiko wrote:
> >> On Mon, Jun 23, 2025 at 10:56=E2=80=AFAM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >>>
> >>> On Mon, Jun 23, 2025 at 6:44=E2=80=AFAM Tao Chen <chen.dylane@linux.d=
ev> wrote:
> >>>>
> >>>> Alexei suggested, 'link_type' can be more precise and differentiate
> >>>> for human in fdinfo. In fact BPF_LINK_TYPE_KPROBE_MULTI includes
> >>>> kretprobe_multi type, the same as BPF_LINK_TYPE_UPROBE_MULTI, so we
> >>>> can show it more concretely.
> >>>>
> >>>> link_type:      kprobe_multi
> >>>> link_id:        1
> >>>> prog_tag:       d2b307e915f0dd37
> >>>> ...
> >>>> link_type:      kretprobe_multi
> >>>> link_id:        2
> >>>> prog_tag:       ab9ea0545870781d
> >>>> ...
> >>>> link_type:      uprobe_multi
> >>>> link_id:        9
> >>>> prog_tag:       e729f789e34a8eca
> >>>> ...
> >>>> link_type:      uretprobe_multi
> >>>> link_id:        10
> >>>> prog_tag:       7db356c03e61a4d4
> >>>>
> >>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >>>> ---
> >>>>   include/linux/trace_events.h | 10 ++++++++++
> >>>>   kernel/bpf/syscall.c         |  9 ++++++++-
> >>>>   kernel/trace/bpf_trace.c     | 28 ++++++++++++++++++++++++++++
> >>>>   3 files changed, 46 insertions(+), 1 deletion(-)
> >>>>
> >>>> Change list:
> >>>>    v4 -> v5:
> >>>>      - Add patch1 to show precise link_type for
> >>>>        {uprobe,kprobe}_multi.(Alexei)
> >>>>      - patch2,3 just remove type field, which will be showed in
> >>>>        link_type
> >>>>    v4:
> >>>>    https://lore.kernel.org/bpf/20250619034257.70520-1-chen.dylane@li=
nux.dev
> >>>>
> >>>>    v3 -> v4:
> >>>>      - use %pS to print func info.(Alexei)
> >>>>    v3:
> >>>>    https://lore.kernel.org/bpf/20250616130233.451439-1-chen.dylane@l=
inux.dev
> >>>>
> >>>>    v2 -> v3:
> >>>>      - show info in one line for multi events.(Jiri)
> >>>>    v2:
> >>>>    https://lore.kernel.org/bpf/20250615150514.418581-1-chen.dylane@l=
inux.dev
> >>>>
> >>>>    v1 -> v2:
> >>>>      - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
> >>>>      - print func name is more readable and security for kprobe_mult=
i.(Alexei)
> >>>>    v1:
> >>>>    https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@l=
inux.dev
> >>>>
> >>>> diff --git a/include/linux/trace_events.h b/include/linux/trace_even=
ts.h
> >>>> index fa9cf4292df..951c91babbc 100644
> >>>> --- a/include/linux/trace_events.h
> >>>> +++ b/include/linux/trace_events.h
> >>>> @@ -780,6 +780,8 @@ int bpf_get_perf_event_info(const struct perf_ev=
ent *event, u32 *prog_id,
> >>>>                              unsigned long *missed);
> >>>>   int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struc=
t bpf_prog *prog);
> >>>>   int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struc=
t bpf_prog *prog);
> >>>> +void bpf_kprobe_multi_link_type_show(const struct bpf_link *link, c=
har *link_type, int len);
> >>>> +void bpf_uprobe_multi_link_type_show(const struct bpf_link *link, c=
har *link_type, int len);
> >>>>   #else
> >>>>   static inline unsigned int trace_call_bpf(struct trace_event_call =
*call, void *ctx)
> >>>>   {
> >>>> @@ -832,6 +834,14 @@ bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *prog)
> >>>>   {
> >>>>          return -EOPNOTSUPP;
> >>>>   }
> >>>> +static inline void
> >>>> +bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *=
link_type, int len)
> >>>> +{
> >>>> +}
> >>>> +static inline void
> >>>> +bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *=
link_type, int len)
> >>>> +{
> >>>> +}
> >>>>   #endif
> >>>>
> >>>>   enum {
> >>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>>> index 51ba1a7aa43..43b821b37bc 100644
> >>>> --- a/kernel/bpf/syscall.c
> >>>> +++ b/kernel/bpf/syscall.c
> >>>> @@ -3226,9 +3226,16 @@ static void bpf_link_show_fdinfo(struct seq_f=
ile *m, struct file *filp)
> >>>>          const struct bpf_prog *prog =3D link->prog;
> >>>>          enum bpf_link_type type =3D link->type;
> >>>>          char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> >>>> +       char link_type[64] =3D {};
> >>>>
> >>>>          if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_=
strs[type]) {
> >>>> -               seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs=
[type]);
> >>>> +               if (link->type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI)
> >>>> +                       bpf_kprobe_multi_link_type_show(link, link_t=
ype, sizeof(link_type));
> >>>> +               else if (link->type =3D=3D BPF_LINK_TYPE_UPROBE_MULT=
I)
> >>>> +                       bpf_uprobe_multi_link_type_show(link, link_t=
ype, sizeof(link_type));
> >>>> +               else
> >>>> +                       strscpy(link_type, bpf_link_type_strs[type],=
 sizeof(link_type));
> >>>> +               seq_printf(m, "link_type:\t%s\n", link_type);
> >>>
> >>> New callbacks just to print a string?
> >>> Let's find a different way.
> >>>
> >>> How about moving 'flags' from bpf_[ku]probe_multi_link into bpf_link =
?
> >>> (There is a 7 byte hole there anyway)
> >>> and checking flags inline.
> >>>
> >>> Jiri, Andrii,
> >>>
> >>> better ideas?
> >>
> >> We can just remember original attr->link_create.attach_type in
> >> bpf_link itself, and then have a small helper that will accept link
> >> type and attach type, and fill out link type representation based on
> >> those two. Internally we can do the special-casing of  uprobe vs
> >> uretprobe and kprobe vs kretprobe transparently to all the other code.
> >> And use that here in show_fdinfo
> >
> > but you'd still need the flags, no? to find out if it's return probe
> >
> > I tried what Alexei suggested and it seems ok and simple enough
> >
> > jirka
> >
> >
> > ---
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 5dd556e89cce..287c956cdbd2 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1702,6 +1702,7 @@ struct bpf_link {
> >        * link's semantics is determined by target attach hook
> >        */
> >       bool sleepable;
> > +     u32 flags;
> >       /* rcu is used before freeing, work can be used to schedule that
> >        * RCU-based freeing before that, so they never overlap
> >        */
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 56500381c28a..f1d9ee9717a1 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3228,7 +3228,14 @@ static void bpf_link_show_fdinfo(struct seq_file=
 *m, struct file *filp)
> >       char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> >
> >       if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[t=
ype]) {
> > -             seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type=
]);
> > +             if (link->type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI)
> > +                     seq_printf(m, "link_type:\t%s\n", link->flags =3D=
=3D BPF_F_KPROBE_MULTI_RETURN ?
> > +                                "kretprobe_multi" : "kprobe_multi");
> > +             else if (link->type =3D=3D BPF_LINK_TYPE_UPROBE_MULTI)
> > +                     seq_printf(m, "link_type:\t%s\n", link->flags =3D=
=3D BPF_F_UPROBE_MULTI_RETURN ?
> > +                                "uretprobe_multi" : "uprobe_multi");
> > +             else
> > +                     seq_printf(m, "link_type:\t%s\n", bpf_link_type_s=
trs[type]);
> >       } else {
> >               WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u=
\n", type);
> >               seq_printf(m, "link_type:\t<%u>\n", type);
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 0a06ea6638fe..81d7a4e5ae15 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2466,7 +2466,6 @@ struct bpf_kprobe_multi_link {
> >       u32 cnt;
> >       u32 mods_cnt;
> >       struct module **mods;
> > -     u32 flags;
> >   };
> >
> >   struct bpf_kprobe_multi_run_ctx {
> > @@ -2586,7 +2585,7 @@ static int bpf_kprobe_multi_link_fill_link_info(c=
onst struct bpf_link *link,
> >
> >       kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
> >       info->kprobe_multi.count =3D kmulti_link->cnt;
> > -     info->kprobe_multi.flags =3D kmulti_link->flags;
> > +     info->kprobe_multi.flags =3D kmulti_link->link.flags;
> >       info->kprobe_multi.missed =3D kmulti_link->fp.nmissed;
> >
> >       if (!uaddrs)
> > @@ -2976,7 +2975,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
> >       link->addrs =3D addrs;
> >       link->cookies =3D cookies;
> >       link->cnt =3D cnt;
> > -     link->flags =3D flags;
> > +     link->link.flags =3D flags;
> >
> >       if (cookies) {
> >               /*
> > @@ -3045,7 +3044,6 @@ struct bpf_uprobe_multi_link {
> >       struct path path;
> >       struct bpf_link link;
> >       u32 cnt;
> > -     u32 flags;
> >       struct bpf_uprobe *uprobes;
> >       struct task_struct *task;
> >   };
> > @@ -3109,7 +3107,7 @@ static int bpf_uprobe_multi_link_fill_link_info(c=
onst struct bpf_link *link,
> >
> >       umulti_link =3D container_of(link, struct bpf_uprobe_multi_link, =
link);
> >       info->uprobe_multi.count =3D umulti_link->cnt;
> > -     info->uprobe_multi.flags =3D umulti_link->flags;
> > +     info->uprobe_multi.flags =3D umulti_link->link.flags;
> >       info->uprobe_multi.pid =3D umulti_link->task ?
> >                                task_pid_nr_ns(umulti_link->task, task_a=
ctive_pid_ns(current)) : 0;
> >
> > @@ -3369,7 +3367,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
> >       link->uprobes =3D uprobes;
> >       link->path =3D path;
> >       link->task =3D task;
> > -     link->flags =3D flags;
> > +     link->link.flags =3D flags;
> >
> >       bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> >                     &bpf_uprobe_multi_link_lops, prog);
>
> Hi, Jiri, Andrii,
>
> Jiri's patch looks more simple, and i see other struct xx_links wrap
> bpf_link, which have attach_type field like:
> struct sockmap_link {
>          struct bpf_link link;
>          struct bpf_map *map;
>          enum bpf_attach_type attach_type;
> };
> If we create attach_type filed in bpf_link, maybe these struct xx_link
> should also be modified. BTW, as Jiri said, we still can not find return
> probe type from attach_type.

You are right, I somehow was under impression that ret vs non-retprobe
comes from attach type as well.

Ok, moving flags into common bpf_link struct sounds good to me. I'd
still move attach_type into bpf_link, together with flags, for
generality (and update all those links that already include
attach_type as you mentioned). We can make it a single-byte field to
not increase bpf_link size unnecessarily (by using bitfield size).

>
> --
> Best Regards
> Tao Chen

