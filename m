Return-Path: <bpf+bounces-56510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C7A99601
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B722B5A7107
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E359728A1EB;
	Wed, 23 Apr 2025 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBl9SIb+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586E1EFFBB;
	Wed, 23 Apr 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427915; cv=none; b=LxAZXipolWjaIxdk4zdWyy0w4o7/43OeoEOPAoj3ZcCAizVG7FZW41Dlz6wEnqW1qtqn2odPLQPLBNa88NFNjfQNfQxYYgwXhuf0NMM0/Hgut8/TN39nrC3supdGgrelkyhvT+9W+CYCnVrWObtWMrBpFmJKju7BPiipFm4h8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427915; c=relaxed/simple;
	bh=6zKpPS9+zRAIYHWO5bW9Y1SGeFtJzszIk1IQ9wX2yuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwWSzEj0q2cZu9x64OltwDYVqTW2erUtycrAqI/B9EYSMEd0Tv0ZGOxb0q1iX5nSBjKnozivaTwtugfyNwqm1c3IZQFAmikJZ5MidbzNaYQ9Wefv7P3fxWF8uuryJY4Au0AkEJwvusN1Fis9FMK6xrQpJ95fdzmH/VhrDgpG2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBl9SIb+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22928d629faso690575ad.3;
        Wed, 23 Apr 2025 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745427913; x=1746032713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zKpPS9+zRAIYHWO5bW9Y1SGeFtJzszIk1IQ9wX2yuU=;
        b=IBl9SIb+EIhbiykHnqaHS8wFZrzxK3u9PlE+0wI+wYskPPz6kw3z8DuzJSe253erdc
         lXjpeFxIdhIIBBmLp+pZmFLF2DwbX7XYd07p6q6ZFXK/+Hc1J7VUJwD8eQDkaYh7E00x
         /rVskkbhIoZFJnX0KO0SDj1NL5WIJJkODnrDr7J0v2+MwIN6SZNyaVAhIaghy1LeF6Kk
         wVX981hEQxgGyfKUh13TVCcJWvRZew2ZN5sGc9xazN+wErwSapRtlMyuqHHKBdMish2S
         ZQ4XFqWt5nWglIPEoG4d2ZmD6tyG7k9yKVKuK3y8gciCwtGxhSFahGizRD8uJs79KSnt
         SOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427913; x=1746032713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zKpPS9+zRAIYHWO5bW9Y1SGeFtJzszIk1IQ9wX2yuU=;
        b=Cp0FfCH/I0/lTiRFhJAy9NwkBhhd4ltUWETtrubvSKcwwFTLtACK3WFv2y3G/X8qpL
         cNfyMxbvBgLay7nVVhp8hAS5TEFh3/7eD0SNaO+1Zblt3S3K2WL3r9b+kjQaCcA4LUXY
         Noyd+N7z8+QFvnwfY5YaYA+q4zB9p1xiu1EO2sEWS1p7dIQ9cW9hi1sCCLgaqFeZDuxt
         +NZnZv+1NGVReroouowgeBiBfbpawEoakHU5YAQ02v4vafIfkkORmw5/6yuMpaxQcxYY
         LUTvCIyr4r2nZNP2/gBHUiEeMnPegp/nKXK1LfEdtDvjkYFtRPR53mK+UV82eJbrL0aS
         lAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVliKPwMfRP8jR6j7bLjkyk+qWOiWgLppe/qeLwS0MYsU4RQZOFR6COAd/zTihkVdMjB69btDsLj0s2EuY+CU/18+Ey@vger.kernel.org, AJvYcCWbC9nKiEqXrMHG8egeixIZMQuBsd7Uu3raeOoqkGw/RQwkOww8r/LzGUEQ95sOxVGqcSM=@vger.kernel.org, AJvYcCWjiTa4k1NYU29sbGvgLq3MZZCamq0QTf+ErcFp2svJbbQsuOEBgyX/zesIQcy5Tf4qlsuW7TtTxx39N/kx@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFimf267bjrowWFHPcyxWrpxrbuypJgfCu60XeuaaZlUsbqp3
	c4PU88O8Ulfr23gp34IvEbnKurRm+Zqhw/+eVgteqm9H6aWS41p6NkgKHKBf6wjeLDT6C9pjgZS
	b4HVAQSHn+NnOOF3Kt349V4/wciy/hA==
X-Gm-Gg: ASbGncvp9gJLfZK/vYblTJ+npVx9y2yNGXZ8wGageqgHrTPbkrMmhWpMdbOHJcjova1
	SM6ueS2faoDZRjgUBXlni8rwoodrvasqk8GHAVE7/eEOrJN90MFqLSTNICnd3uiEWsTGsrFUh0S
	71AHR6Zf1lLEOPjUimTlQ0W2n2NF4a0rCHzFyhgg==
X-Google-Smtp-Source: AGHT+IGMZQKwDubGKkLCAEJvDU99u5TZOFapB+c2J61U8leklrLSHzo/pkQaNbIOUkY2y9M+FjfNNc4gRUsis+yKnzI=
X-Received: by 2002:a17:90a:d010:b0:2fe:7f40:420a with SMTP id
 98e67ed59e1d1-3087bb69218mr31482113a91.17.1745427912929; Wed, 23 Apr 2025
 10:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410070258.276759-1-yangfeng59949@163.com>
 <CAEf4Bzai7NL-3=1SVi4-WWYWEY6Lzrb8GBfKnt6FG8sNm2OMRQ@mail.gmail.com> <CAC1LvL2SOKojrXPx92J46fFEi3T9TAWb3mC1XKtYzwU=pzTEbQ@mail.gmail.com>
In-Reply-To: <CAC1LvL2SOKojrXPx92J46fFEi3T9TAWb3mC1XKtYzwU=pzTEbQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:05:00 -0700
X-Gm-Features: ATxdqUGMzy3AYWGX5UwpIo9ghrB61M-1gmWsamJS27T0RdXOwdL9vKenW5sik14
Message-ID: <CAEf4BzZtOUWyQego7Uj5GH48-bLM1stSyi-uZ=+JTtGzYojFAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Remove redundant checks
To: Zvi Effron <zeffron@riotgames.com>
Cc: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:44=E2=80=AFPM Zvi Effron <zeffron@riotgames.com> =
wrote:
>
> On Wed, Apr 16, 2025 at 2:56=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 10, 2025 at 12:03=E2=80=AFAM Feng Yang <yangfeng59949@163.c=
om> wrote:
> > >
> > > From: Feng Yang <yangfeng@kylinos.cn>
> > >
> > > Many conditional checks in switch-case are redundant
> > > with bpf_base_func_proto and should be removed.
> > >
> > > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > > Acked-by: Song Liu <song@kernel.org>
> > > ---
> > > Changes in v3:
> > > - Only modify patch description information.
> > > - Link to v2: https://lore.kernel.org/all/20250408071151.229329-1-yan=
gfeng59949@163.com/
> > >
> > > Changes in v2:
> > > - Only modify patch description information.
> > > - Link to v1: https://lore.kernel.org/all/20250320032258.116156-1-yan=
gfeng59949@163.com/
> > > ---
> > > kernel/trace/bpf_trace.c | 72 ---------------------------------------=
-
> > > 1 file changed, 72 deletions(-)
> > >
> >
> > All this looks good, I checked that those functions indeed are allowed
> > in bpf_base_func_proto. The only (minor) differences are capabilities,
> > bpf_base_func_proto() correctly guards some of the helpers with
> > CAP_BPF and/or CAP_PERFMON checks, while bpf_tracing_func_proto()
> > doesn't seem to bother (which is either a bug or any tracing prog
> > implies CAP_BPF and CAP_PERFMON, I'm not sure, didn't check).
> >
> > But I think we can take it further and remove even more stuff from
> > bpf_tracing_func_proto and/or add more stuff into bpf_base_func_proto
> > (perhaps as a few patches in a series, so it's easier to review and
> > validate).
> >
> > Basically, except for a few custom implementations that depend on
> > tracing program type (like get_stack and others like that), if
> > something is OK to call from a tracing program it should be ok to call
> > from any program type. And as such it can (should?) be added to
> > bpf_base_func_proto, IMO.
>
> Is this true? Does it make sense? (See below.)
>
> > P.S. I'd name the patch/series as "bpf: streamline allowed helpers
> > between tracing and base sets" or something like that to make the
> > purpose clearer
> >
> > [...]
> >
> > > case BPF_FUNC_get_current_uid_gid:
> > > return &bpf_get_current_uid_gid_proto;
> > > case BPF_FUNC_get_current_comm:
> > > return &bpf_get_current_comm_proto;
> >
> > I'm surprised these two are not part of bpf_base_func_proto, tbh...
> > maybe let's move them there while we are cleaning all this up?
>
> Do these make sense in all BPF program types such that they belong in
> bpf_base_func_proto? For example, XDP programs don't have a current uid a=
nd
> gid, do they?

everything in the kernel, whether NMI handler, hardirq, softirq, or
whatnot runs with *some* current task. So in that sense there is
always pid/tgid and uid/gid. It might not be very relevant for XDP
programs, but it's there, and so if we allow to get current pid/tgid,
why not allow the current comm and uid/gid?

>
> > pw-bot: cr
> >
> > > - case BPF_FUNC_trace_printk:
> > > - return bpf_get_trace_printk_proto();
> > > case BPF_FUNC_get_smp_processor_id:
> > > return &bpf_get_smp_processor_id_proto;
> >
> > this one should be cleaned up as well and
> > bpf_get_smp_processor_id_proto removed. All BPF programs either
> > disable CPU preemption or CPU migration, so bpf_base_func_proto's
> > implementation should work just fine (but please do it as a separate
> > patch)
> >
> > > - case BPF_FUNC_get_numa_node_id:
> > > - return &bpf_get_numa_node_id_proto;
> > > case BPF_FUNC_perf_event_read:
> > > return &bpf_perf_event_read_proto;
> >
> > [...]
> >

