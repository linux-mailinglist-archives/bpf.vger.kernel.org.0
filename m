Return-Path: <bpf+bounces-48905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698ACA117AF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 04:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4A11654DD
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C222DFA5;
	Wed, 15 Jan 2025 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noOWt4pG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA32AE6A;
	Wed, 15 Jan 2025 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736910820; cv=none; b=LEB6h/g3xKQNM213BY9eTZ0ow2do74r45HCyNh+E0HBxbBIiWWZfzJ+InH3XwDBANwIDNmDaO5bOlUyQi3z6pkQqYSIt/v/nwKqtFIZAqFRi7Zk4jgNmNUrzgnG3KbiwqFdSnmrNVnbiM865Ou4KAIvDApHSdcGwYtnlixyCaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736910820; c=relaxed/simple;
	bh=6GTcMx3vLk5bajSKbOiTL+/pzHZtzvIcGicvObWykwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX7m0KLnnkrtdkm7zj/gyoXwq5B5WULRSlTk3+mlHBgBE1jmqcN8X75G8/+Jy/ZnuZDLFk3aJShfMSODg8ahkpd6EspG6I+Tu1TNbli4akudVoZ7klwZtL6l8qp5UVmPO3KtPyt6EY2AH71qrbEzwiqCmEuQ1DF2eEyjuZdVbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noOWt4pG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dccccd429eso50514946d6.3;
        Tue, 14 Jan 2025 19:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736910817; x=1737515617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpTzoD/ye+KTP7gxymR/okpXKgS/beqVqNicgHEcvMw=;
        b=noOWt4pG5TanTS8KUtLHpn8YkrGotQkqJD7HC+MWrMTxdrS4Aftzyz+cZM99Yo3Jh9
         M1qja10ttQ9a2rnd+6K/rbKFaXkweS52icSRshslb98SuRoBfeJrJpO5bX15ilUGpGRg
         hb8nRP3VfPlLt8xae6GF0Wmsl+7D6OKx+ZtQrcWMKEoKTLkXD/2//9fwBnh9LOZstV/r
         RG74gxwexyOWqTaPcGxAYtJndLitj+K8dVPyR2Yyp90mus15xUBobGkAM7L2fAE9ax7z
         65avUYybotegCtyM5DhMeFFOBvnp2XSvj7JPn86IBKm7BzmjhIrvERjYvKCxOJBnRur+
         DcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736910817; x=1737515617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpTzoD/ye+KTP7gxymR/okpXKgS/beqVqNicgHEcvMw=;
        b=iU/OcfkHdeeft/rWuF2e90UQixPVqvbcMRnRws6Ayo1Eacwo/WKoUL+tzgNPnD9H2J
         MwjLoYJ8Ofy6SFuUL0m2I7PfTXfU7F3eAlf+J9ltK1FeUPg4IOawq/SQqeY9sbInXbXi
         2Kvti7pvK7LDeO4XJscmB8u/FD4J6dkcaosaccXPrICPLuWRZiPtBExZkNKhXYvgskFs
         J9B+rnQdOUQ3ffrYue/IkhoqkCzsUjTa+2PXA50fkmUAcy480wE4RPIRuAENu6JT7Lve
         huK6K5TK416q+UOLYUzRcK8pMi4s+Wj6/rDiopVqDFvS3xuGlg8AuCCeY0TA6IE1oMjx
         BJcw==
X-Forwarded-Encrypted: i=1; AJvYcCU+cB6HtzHJm6OFcsT7oBXKQPshRqOyb60EBPTbIho5+YvjRQScjiDRxVIY0A+DW/5jk9MfMV89@vger.kernel.org, AJvYcCXrlp0lYvhbXZLX3r8jx9IBqe9wIEry4BB5hUDsDDQXDMW8YI9U+jVCY16VGSwuT1Nl9kY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7JTDsmt5e6Bly2h/Ozz/JTTGzTYKBI43spuKodv5tWcdGGDKk
	Rx2uaJi4NaS/Oy3JqTl0Uz4UkypWcQ3lM9PbVu87PicNFo4iLJ2cOF+qgXCE1XyELle46a3Bl0a
	nYn85T2xWy4N8cbwvscKvQ/AcB70=
X-Gm-Gg: ASbGncuFFDkKdi/gibFMecocDvy9GSbHRi/cahrhOw+KMLB3HhJrMgpNTnMLWNFk2Av
	WDPj8BqB3xBfijvhOsCVmZpxusq86KLSxl9fF
X-Google-Smtp-Source: AGHT+IH+CYAX72SyvQcFDJ6GsVSqiWWWnfYTSL8/Vuh7YS8GGSnaq9CzrCMo6/DAaet4t0ruECPcbQgAusL5xo+lkGo=
X-Received: by 2002:a05:6214:5a08:b0:6d8:aa04:9a5d with SMTP id
 6a1803df08f44-6df9b1d1fa1mr406581456d6.4.1736910817485; Tue, 14 Jan 2025
 19:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112064513.883-1-laoar.shao@gmail.com> <CAEf4BzZcs6YP067-KJYQRsMJMLooypepq8iiX7wXu7CZwVhD3g@mail.gmail.com>
In-Reply-To: <CAEf4BzZcs6YP067-KJYQRsMJMLooypepq8iiX7wXu7CZwVhD3g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 15 Jan 2025 11:13:01 +0800
X-Gm-Features: AbW1kvb-dIXz4uBz4Mj9_8CuK_ym1PsFudUg4rh-ljRRu-iM2RKnrYCFoIBjtjQ
Message-ID: <CALOAHbAXyLy6gcRLwtF9rz8v5hcpx5ua4En25sst3pgUu0K=xA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] libbpf: Add support for dynamic tracepoints
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, edumazet@google.com, dxu@dxuuu.xyz, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 6:32=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Jan 11, 2025 at 10:45=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > The primary goal of this change is to enable tracing of inlined kernel
> > functions with BPF programs.
> >
> > Dynamic tracepoints can be created using tools like perf-probe, debugfs=
, or
> > similar utilities. For example:
> >
> >   $ perf probe -a 'tcp_listendrop sk'
> >   $ ls /sys/kernel/debug/tracing/events/probe/tcp_listendrop/
> >   enable  filter  format  hist  id  trigger
> >
> > Here, tcp_listendrop() is an example of an inlined kernel function.
> >
> > While these dynamic tracepoints are functional, they cannot be easily
> > attached to BPF programs. For instance, attempting to use them with
> > bpftrace results in the following error:
> >
> >   $ bpftrace -l 'tracepoint:probe:*'
> >   tracepoint:probe:tcp_listendrop
> >
> >   $ bpftrace -e 'tracepoint:probe:tcp_listendrop {print(comm)}'
> >   Attaching 1 probe...
> >   ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
> >   ERROR: Error attaching probe: tracepoint:probe:tcp_listendrop
> >
> > The issue lies in how these dynamic tracepoints are implemented: despit=
e
> > being exposed as tracepoints, they remain kprobe events internally. As =
a
> > result, loading them as a tracepoint program fails. Instead, they must =
be
> > loaded as kprobe programs.
> >
> > This change introduces support for such use cases in libbpf by adding a
> > new section: SEC("kprobe/SUBSYSTEM/PROBE")
> >
> > - Future work
> >   Extend support for dynamic tracepoints in bpftrace.
>
> Seems like the primary motivation is bpftrace support, so let's start
> there.

I believe we should extend support for this feature in BCC as well.
Since this is a common and widely applicable feature, wouldn't it make
sense to include it directly in libbpf?

> I'm hesitant to include this in libbpf right now. The whole
> SEC("kprobe") that calls "attach_tracepoint()" underneath makes me
> uncomfortable.

I reused the bpf_program__attach_tracepoint() function, but if we
examine its implementation closely, we can see that it actually
creates a DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts); rather
than a bpf_tracepoint_opts.

If naming is a significant concern, it wouldn=E2=80=99t be difficult to
reimplement the same logic with a more appropriate name, such as
attach_kprobe_based_tracepoint().

>
> You can still attach to such dynamic probe today with pure libbpf
> (e.g., if bpftrace needs to do this, for example) by creating
> perf_event FD from tracefs' id, and then using
> bpf_program__attach_perf_event_opts() to attach to it. It will be on
> the user to use either tracepoint or kprobe BPF program for such
> attachment.

You're right=E2=80=94we can manually attach it in the tools, but if we can
make it auto-attachable in libbpf, why not take advantage of that and
simplify the process?


>
> Yes, this doesn't work "declaratively" with a nice SEC("...") syntax,
> but at least it's doable programmatically, and that's what matters for
> bpftrace.


--
Regards
Yafang

