Return-Path: <bpf+bounces-37963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435B995D3F7
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF088281E89
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4345187855;
	Fri, 23 Aug 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i42VaVwU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB24187FFC
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432587; cv=none; b=prMODB6T3mVOVbIzrWK1gCYhvq3fTAOOXgk0IU+8YMxuu6pGOaJalRNYBRa6bhV0L4AUF0PbniI1e+ZpWZNJaJgUkXwaoSfwlBIUmncBmhZ1bZJUw1Tz/nH8mVmRl9PXH9fo08N+0rje5t9k88uCJWc9wFYy2cgycNswmGzfBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432587; c=relaxed/simple;
	bh=TaUCPW4kyPdRncUNdoD6gLc93m65hiF8/eOtljDimck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJiOUXs6N7AO1Kflw5nnU3GMl2+QXUhsByHZVdbTvhtixy6hPInt8Dy+tcYQTY7qEP7q5juLZKPAJC+sNj4CScampktoGgltX0hXq4HHxKJtgaVWzhguhVrACjFiZSAUgdu/Xltve04Ag0lS8bLM7N+xPUfy/geL1yQ99+xdZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i42VaVwU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3730749ee7aso1231052f8f.2
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724432584; x=1725037384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TklAvx9t7DJ08Cu5aVELu+3lvjD3Olowh5XY8h63fGM=;
        b=i42VaVwUaKuDyMUNVx3h1If0uiYmOqJagtFMX7fq4wiIU7gq+tSfV1lBaz5ipB0jU4
         Jk1L+A+Gb788jUUiEMcapgb4JkwEK20M0aN3sraFtAHlT56c6pI5pVCd86q5vkdKvFey
         LOh7e1dRBfYKIQND0ymWH6HJfmKa/NlC6iRGpKZNRzk1ulxkW9BEQ43RoAICDOM6+7zk
         VtPj7sVfCdZmsmuualYhPLFsRdRhc/l/0GS/fGg4zhA1aktioJGcQyjcVSBRBYyc293f
         H+D+zMhZoxPnTiYeGtGtPQk+4qs0xVU4vERvSzfjr/1ZnGox4NDwZ/LtXPpUeibeOAKb
         1eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432584; x=1725037384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TklAvx9t7DJ08Cu5aVELu+3lvjD3Olowh5XY8h63fGM=;
        b=jNZOTH82t1qZksnGjN9zp0ByxdI9ieWk+QXhjfFYgHBSVUC3JWoY8U7AVJw+EVgV/a
         Dd2Q0qfhWE14Q5z9Y31xgzXsfko0rV9OJ5o4hCf9jHTDIU5keGlExRpJL8hUf186mlTx
         1whB3Tl9XRKgJZcgiZq8Kko/sCnKO0EXOb8OVHXxCCD+kqQRe8WY6S0IUvq9/BsEttIb
         dUKXZd9cAx+AA7K5weORK6s8bXEU5cKmAsysYvvDg6CklwsvcYjVYxw5M/4zohfpWlfN
         f6ACBRJ+d4oTD9iuF7v32kqsRGNZgXkiriqiifExbj12aamhnD3WGFRsRUuuKCH0bg6I
         jp7w==
X-Forwarded-Encrypted: i=1; AJvYcCUpog1HxnG/Ok+vwfTnYyt/i+1QzKqFNmaxXbl+dL6umbm0SnSVgO3Tbo1xeMDx8vjFscM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHCtomy2bQyH6LpEHX19WOlJJMQ40+3vGE5S2WDmQO9jED1PIa
	iLvCdIx7lRkCh4ssJ7GspYKpmUe6RzjImP8Y/6roCkXYWGnDkb6hHZ12cCYnar8wBmSUMX5l6vZ
	IZpFQJkO/JNyAwTkMTJsSJNGa410=
X-Google-Smtp-Source: AGHT+IEvaqcW7W+RjyIi7tJQVkiklqGgwgBmjYht03gGq+YpnGSh/KtYXEVX8OYSzAlb48Pb8P4Kb5uZcxpcsgtOGxY=
X-Received: by 2002:adf:9599:0:b0:369:e72c:875f with SMTP id
 ffacd0b85a97d-373118d1d4cmr1886591f8f.48.1724432583310; Fri, 23 Aug 2024
 10:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806042935.3867862-1-andrii@kernel.org> <ZrHP31DJAQQjgdQz@krava>
 <CAEf4BzarqEaE+SRG1ivnUG5GdAz7_+Jgo=E1vxu6ESFu-X024g@mail.gmail.com>
In-Reply-To: <CAEf4BzarqEaE+SRG1ivnUG5GdAz7_+Jgo=E1vxu6ESFu-X024g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Aug 2024 10:02:51 -0700
Message-ID: <CAADnVQKpN0fYOiD_87mNDBmYzaMib5d+1B-802LTOkRxdekCFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add multi-uprobe benchmarks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:31=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 6, 2024 at 12:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Mon, Aug 05, 2024 at 09:29:35PM -0700, Andrii Nakryiko wrote:
> > > Add multi-uprobe and multi-uretprobe benchmarks to bench tool.
> > > Multi- and classic uprobes/uretprobes have different low-level
> > > triggering code paths, so it's sometimes important to be able to
> > > benchmark both flavors of uprobes/uretprobes.
> > >
> > > Sample examples from my dev machine below. Single-threaded peformance
> > > almost doesn't differ, but with more parallel CPUs triggering the sam=
e
> > > uprobe/uretprobe the difference grows. This might be due to [0], but
> > > given the code is slightly different, there could be other sources of
> > > slowdown.
> > >
> > > Note, all these numbers will change due to ongoing work to improve
> > > uprobe/uretprobe scalability (e.g., [1]), but having benchmark like t=
his
> > > is useful for measurements and debugging nevertheless.
> > >
> > > uprobe-nop            ( 1 cpus):    1.020 =C2=B1 0.005M/s  (  1.020M/=
s/cpu)
> > > uretprobe-nop         ( 1 cpus):    0.515 =C2=B1 0.009M/s  (  0.515M/=
s/cpu)
> > > uprobe-multi-nop      ( 1 cpus):    1.036 =C2=B1 0.004M/s  (  1.036M/=
s/cpu)
> > > uretprobe-multi-nop   ( 1 cpus):    0.512 =C2=B1 0.005M/s  (  0.512M/=
s/cpu)
> > >
> > > uprobe-nop            ( 8 cpus):    3.481 =C2=B1 0.030M/s  (  0.435M/=
s/cpu)
> > > uretprobe-nop         ( 8 cpus):    2.222 =C2=B1 0.008M/s  (  0.278M/=
s/cpu)
> > > uprobe-multi-nop      ( 8 cpus):    3.769 =C2=B1 0.094M/s  (  0.471M/=
s/cpu)
> > > uretprobe-multi-nop   ( 8 cpus):    2.482 =C2=B1 0.007M/s  (  0.310M/=
s/cpu)
> > >
> > > uprobe-nop            (16 cpus):    2.968 =C2=B1 0.011M/s  (  0.185M/=
s/cpu)
> > > uretprobe-nop         (16 cpus):    1.870 =C2=B1 0.002M/s  (  0.117M/=
s/cpu)
> > > uprobe-multi-nop      (16 cpus):    3.541 =C2=B1 0.037M/s  (  0.221M/=
s/cpu)
> > > uretprobe-multi-nop   (16 cpus):    2.123 =C2=B1 0.026M/s  (  0.133M/=
s/cpu)
> > >
> > > uprobe-nop            (32 cpus):    2.524 =C2=B1 0.026M/s  (  0.079M/=
s/cpu)
> > > uretprobe-nop         (32 cpus):    1.572 =C2=B1 0.003M/s  (  0.049M/=
s/cpu)
> > > uprobe-multi-nop      (32 cpus):    2.717 =C2=B1 0.003M/s  (  0.085M/=
s/cpu)
> > > uretprobe-multi-nop   (32 cpus):    1.687 =C2=B1 0.007M/s  (  0.053M/=
s/cpu)
> >
> > nice, do you have script for this output?
> > we could add it to benchs/run_bench_uprobes.sh
> >
>
> I keep tuning those scripts to my own needs, so I'm not sure if it's
> worth adding all of them to selftests. It's very similar to what we
> already have, but see the exact script below:
>
> #!/bin/bash
>
> set -eufo pipefail
>
> for p in 1 8 16 32; do
>     for i in uprobe-nop uretprobe-nop uprobe-multi-nop uretprobe-multi-no=
p; do
>         summary=3D$(sudo ./bench -w1 -d3 -p$p -a trig-$i | tail -n1)
>         total=3D$(echo "$summary" | cut -d'(' -f1 | cut -d' ' -f3-)
>         percpu=3D$(echo "$summary" | cut -d'(' -f2 | cut -d')' -f1 | cut
> -d'/' -f1)
>         printf "%-21s (%2d cpus): %s (%s/s/cpu)\n" $i $p "$total" "$percp=
u"
>     done
>     echo
> done

Added this script to commit log while applying.

