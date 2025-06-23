Return-Path: <bpf+bounces-61314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C782AE4E6B
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 22:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16FE178C9E
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 20:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2109218ABA;
	Mon, 23 Jun 2025 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDORCNeS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC811E1A05;
	Mon, 23 Jun 2025 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712373; cv=none; b=gJ8oWfRBIAyvx3gnI/39fFR0dUDLaxny/ALTxvqjA7pWTysoipVUftW5gRev8DgvBnk6cDCRVHAKpAJMG10ujSCrnVedoC52ljJ7srZL1+WNgdPpC/UZPuypWEXp+3IivmQbhwCSbxs7WR6JI/yz7W5h/sTN6a1k3p37bCEVGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712373; c=relaxed/simple;
	bh=WZruAnztn6MF7xWYnIIM0veISFiEsNO/iHg0h++rAR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBN7MiPs7rW4z0tYqinBuzeZDtbBxjaTSXmqqQEHrqjiTjsXlB4/bJQWbhLmQ/QJhLZ/KxqeE7qYz4yPgaGs8V1d+NWfe5NvIaYsVIEJauUKblZL0iZgUkEOOF/a8hcCu/BFgHpHY/yxLg8F9pB1VVfwa2ERcJtHU9JMu0OiMsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDORCNeS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so3876565a91.3;
        Mon, 23 Jun 2025 13:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750712371; x=1751317171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIYisaKrEPvbF6CacQ7ic1VL3m70GVRp4DrkFHHRCLY=;
        b=QDORCNeSCVl1JtQtBtOxKNm9nAEJGOdmxzHbc1sttgNVNqGFw4IHvJuE04iDyxzfnO
         4nPW6ZlejzUwXmJfs7yVyv1KR0gpbI2v9rU7tTo5edI/2dPMMr217ypvXbC8w7iZOlpD
         P36naLaIxCv8H60REsDim6Og4eRfq4glC32J6qnz0A+K0d0sVg20Lme9UwLMkWizX4Xm
         VLMa3AQWtMdXsKYgvs8UpTUQ57QMPckQRIsOIquItqocIC3N7Jqyv2D3Tx7/N6Vee8vc
         cEVyhnWi+hVB2xVQdSKSIHumH3Km5Ib92fKXAusijpoO5OcmB3rweJNaD33nW3/LIvcy
         UcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750712371; x=1751317171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIYisaKrEPvbF6CacQ7ic1VL3m70GVRp4DrkFHHRCLY=;
        b=kSfWchIMl0cJaAksWwXD269Y40cuqGWk3Jwy+8cKphyk1JyEwcIs4n/3Bt0S7X1r+6
         iovTZQpVLCYui+9fecSQipKfblLVQjjjogFmggzzgKVY6WXNfGahfU1F2rllaD1eKGTj
         w5lX4U2rM/o3G7DCUbMcuJxHsOYffxe++inFECj6tHv2R7YqFP6T4m3oKktl0lK14L2d
         LLhbtLR/uhih5GDtHbKjQqtUQOsQlDIyYVQurXhakb9wuMedZ+eLf0177GIq6cj/YNH2
         us3aXTgGOMzt3KwJrMFmfKgPLlkp8LXtQerJhJ08Q8tqc70n/u0ogYjYXBl9wRXLJVl2
         d2wg==
X-Forwarded-Encrypted: i=1; AJvYcCWGiTHcm+yD3c1jMvhWn1ceMqN/KSpqv/0UZmJHdX4/J79CX11xwZGbiY9O+6EuaMmBK+Y=@vger.kernel.org, AJvYcCWtqapkDigzczgrhF+E0nFyJfF7oYQzFn4NaFdLQFzUQsiK/NI3paD9D49P61tkvLPsURw0FsJ8Rv/tYRuJ@vger.kernel.org, AJvYcCXkTeeTLlvyvjulSe8E8d/yvpV1HXVBBVZy308Z+M5zOBTzCLGa8PoMG36MMEB2ej/58NLXLyFrwfiGOaYdGT1qEyDZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlp+zrkOP9RSrENEeKuyjkMMTS5/wJ9CxmtupR3JRQ1kw2N9X8
	4x4wEE7xGGBWbPxLNE76zOWNA/8i8yPEqLSvv5P9DezNU0ut6yK3N5tILZ2/XZw2xBVKgnrkrGN
	8Ra0G16gVit0kMwx9qehrwd79zdWh+wsVl7EXkb8=
X-Gm-Gg: ASbGncvuPwORb1zBVuxHrexjYeRJ0NdEf4daMB0w/XO10Ll2bVxX4gdI9gXm64YYr9R
	udkU2EAOCM2rz1CU7atyTQaDuwnewgXxVlCZSl2WWgZPsHzJMaKG0kPK6IEtH0KAslmFcTwK0I0
	EW21033wZ8gctnGcdf/g76z4TGWy+epRyQuX3GlBBm8xwtNQ2Umuc+nPRtNUw=
X-Google-Smtp-Source: AGHT+IEJ1r4+4S62s8+RfRSEKVsBZin0OkzARoxCIjvu0jINETaQLPIEbbajvP2ZXPmd5Aq+ABd5ORvmmb5Gx2HKCUA=
X-Received: by 2002:a17:90b:3802:b0:312:e8ed:758 with SMTP id
 98e67ed59e1d1-3159d64cb4cmr22831896a91.13.1750712370575; Mon, 23 Jun 2025
 13:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623134342.227347-1-chen.dylane@linux.dev> <CAADnVQ+aZw4-3Ab9nLWrZUg78sc-SXuEGYnPrdOChw8m9sRLvw@mail.gmail.com>
In-Reply-To: <CAADnVQ+aZw4-3Ab9nLWrZUg78sc-SXuEGYnPrdOChw8m9sRLvw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Jun 2025 13:59:18 -0700
X-Gm-Features: AX0GCFvcaaDX9RNsqxJ0KrpocEQKEc9AnYShotDaNDti4oIGI457khj9jcSwtPc
Message-ID: <CAEf4BzZVw4aSpdTH+VKkG_q6J-sQwSFSCyU+-c5DcA5euP49ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Show precise link_type for
 {uprobe,kprobe}_multi fdinfo
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 23, 2025 at 6:44=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> =
wrote:
> >
> > Alexei suggested, 'link_type' can be more precise and differentiate
> > for human in fdinfo. In fact BPF_LINK_TYPE_KPROBE_MULTI includes
> > kretprobe_multi type, the same as BPF_LINK_TYPE_UPROBE_MULTI, so we
> > can show it more concretely.
> >
> > link_type:      kprobe_multi
> > link_id:        1
> > prog_tag:       d2b307e915f0dd37
> > ...
> > link_type:      kretprobe_multi
> > link_id:        2
> > prog_tag:       ab9ea0545870781d
> > ...
> > link_type:      uprobe_multi
> > link_id:        9
> > prog_tag:       e729f789e34a8eca
> > ...
> > link_type:      uretprobe_multi
> > link_id:        10
> > prog_tag:       7db356c03e61a4d4
> >
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >  include/linux/trace_events.h | 10 ++++++++++
> >  kernel/bpf/syscall.c         |  9 ++++++++-
> >  kernel/trace/bpf_trace.c     | 28 ++++++++++++++++++++++++++++
> >  3 files changed, 46 insertions(+), 1 deletion(-)
> >
> > Change list:
> >   v4 -> v5:
> >     - Add patch1 to show precise link_type for
> >       {uprobe,kprobe}_multi.(Alexei)
> >     - patch2,3 just remove type field, which will be showed in
> >       link_type
> >   v4:
> >   https://lore.kernel.org/bpf/20250619034257.70520-1-chen.dylane@linux.=
dev
> >
> >   v3 -> v4:
> >     - use %pS to print func info.(Alexei)
> >   v3:
> >   https://lore.kernel.org/bpf/20250616130233.451439-1-chen.dylane@linux=
.dev
> >
> >   v2 -> v3:
> >     - show info in one line for multi events.(Jiri)
> >   v2:
> >   https://lore.kernel.org/bpf/20250615150514.418581-1-chen.dylane@linux=
.dev
> >
> >   v1 -> v2:
> >     - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
> >     - print func name is more readable and security for kprobe_multi.(A=
lexei)
> >   v1:
> >   https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux=
.dev
> >
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.=
h
> > index fa9cf4292df..951c91babbc 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -780,6 +780,8 @@ int bpf_get_perf_event_info(const struct perf_event=
 *event, u32 *prog_id,
> >                             unsigned long *missed);
> >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bp=
f_prog *prog);
> >  int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bp=
f_prog *prog);
> > +void bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char=
 *link_type, int len);
> > +void bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char=
 *link_type, int len);
> >  #else
> >  static inline unsigned int trace_call_bpf(struct trace_event_call *cal=
l, void *ctx)
> >  {
> > @@ -832,6 +834,14 @@ bpf_uprobe_multi_link_attach(const union bpf_attr =
*attr, struct bpf_prog *prog)
> >  {
> >         return -EOPNOTSUPP;
> >  }
> > +static inline void
> > +bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *lin=
k_type, int len)
> > +{
> > +}
> > +static inline void
> > +bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *lin=
k_type, int len)
> > +{
> > +}
> >  #endif
> >
> >  enum {
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 51ba1a7aa43..43b821b37bc 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3226,9 +3226,16 @@ static void bpf_link_show_fdinfo(struct seq_file=
 *m, struct file *filp)
> >         const struct bpf_prog *prog =3D link->prog;
> >         enum bpf_link_type type =3D link->type;
> >         char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
> > +       char link_type[64] =3D {};
> >
> >         if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs=
[type]) {
> > -               seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[ty=
pe]);
> > +               if (link->type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI)
> > +                       bpf_kprobe_multi_link_type_show(link, link_type=
, sizeof(link_type));
> > +               else if (link->type =3D=3D BPF_LINK_TYPE_UPROBE_MULTI)
> > +                       bpf_uprobe_multi_link_type_show(link, link_type=
, sizeof(link_type));
> > +               else
> > +                       strscpy(link_type, bpf_link_type_strs[type], si=
zeof(link_type));
> > +               seq_printf(m, "link_type:\t%s\n", link_type);
>
> New callbacks just to print a string?
> Let's find a different way.
>
> How about moving 'flags' from bpf_[ku]probe_multi_link into bpf_link ?
> (There is a 7 byte hole there anyway)
> and checking flags inline.
>
> Jiri, Andrii,
>
> better ideas?

We can just remember original attr->link_create.attach_type in
bpf_link itself, and then have a small helper that will accept link
type and attach type, and fill out link type representation based on
those two. Internally we can do the special-casing of  uprobe vs
uretprobe and kprobe vs kretprobe transparently to all the other code.
And use that here in show_fdinfo

