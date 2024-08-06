Return-Path: <bpf+bounces-36479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A279496D4
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC2728AE32
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF84482E2;
	Tue,  6 Aug 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaF+T9Ry"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99264A2C
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965466; cv=none; b=cI5BJnNUWjC+A4Ix3r2YgfqsVhrHVnCnq1+kgDiQo1baRmXUWSkQTujSvlicjVbviBaw0Kq2EOvK0d+mUMt2akXVQBVgauyQnKG07sIwsdXqsd1DuLBVUKaEOAiMzn/1WLThn8EiBNWF346hlvRcm01CzXrNm6oXnEs9r8AyiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965466; c=relaxed/simple;
	bh=bn39EhGIT7BAzQaVw77v9cY1skmPawtjcdY7ckSCrWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0vhy7HGlzDiRNYgPBg9yX10XSFy78cXAEisgGylptKUBEJVGZXdKZQVR46rfCV7VISBlJNCSkD5WT5ZzNvX4GcwO5EAh6qMeOOZWQBZgSk4gCjNomJG02QQ8DxwJ2V2cf4smYZPDvcJFo5uj/anBGE0uhzdXCdGxnB4USKwa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaF+T9Ry; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so61697a91.0
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722965464; x=1723570264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVVTsB5tLli3oiZY5ZnrRVjQSfyqm3uYHtp6zruHGZk=;
        b=BaF+T9Ry6grTMNQbGHbzN5nIlowXDMkc8Z16LFnR//TbNtMtLZrygAmtLXyHkFFAXB
         kIZbBz+7hZYHJw8Lq9zCoxOYpn8SYhTkXBwNPbwkrd5fK1KZ2z4i/KxyJmP/A33oP4Iz
         +Wn859agekfQYp8QwDEuAQD+j/cTnARYE2Xoxxvt6UBtTwLrsCFrrRE4zmKJZOmqKNW4
         s/jHIo9TjleM00RjeHd26Ihk+AADaEdRJYy02AS6MVkkowkNMOo1h5/yYHsq8BSkshDZ
         3RsTeByj9vTs7fsj18G8KqAnvvRs1FRUEVLfZj30qV5i8lg4QmKVz8UR/OxIP9cWNMhm
         7UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965464; x=1723570264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVVTsB5tLli3oiZY5ZnrRVjQSfyqm3uYHtp6zruHGZk=;
        b=w5ahbmvuAzJk4AY8DfsFhGpHNEm4HSuLJwY5oobANWs2QWMnygwWFZhhrTmuyqZooN
         9MIXKsPxg5Sl394eMO2PBAqxGfNOe33jVKM+rIdPTHhi1/LpW3gccxyIPCa000/3+F0I
         aZC0eVQvzLXaIBRR5IHbR5WpmLStJQnjOrdfmE1NfqldVg70hqGM1wo7z+XYilDKNqF5
         2vhKA/zkgRk/qep7B2QhlIKUaAnmMfrxznxZO17FmUbVOjtzybTzBv1TRoE7Y0MZyUlb
         rebMpJER/Cs4/k7m08NVH+AgG+rdzoRcdxvhg3Uxs7i571nss16PF0+62WcjiScB5M8/
         u7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVCWotutvPyhy0OzDyvD1AxUFrEZuCMgOQa2Bda+kOWnv+y143wjpYWoKaDhk3r2PYDt++eXhTvA3plweKsb8jaL34A
X-Gm-Message-State: AOJu0Yxjs2knJmEj8lDJb4+TvSZ6HvibvmzJS3MMlw0terOhHlyt8p/4
	snmLbndoekcuOYP6Bh3iauOMBkaNPFYfCp0sAQA5r6CEEhwguRZrouxgVK9Cf2cMac+wCwDBybQ
	afNqp7tMgo9fVFWL40AT3ZDcee1w=
X-Google-Smtp-Source: AGHT+IGm5h48voUXirXwpG+XBAyHpvVos1sFF7Og2nP0oIBfNMIeng8GDTpFPxmdobNFQeBjVesfZVehLdY/R/5Xvpg=
X-Received: by 2002:a17:90b:2289:b0:2c3:2f5a:17d4 with SMTP id
 98e67ed59e1d1-2cffa0ada12mr25035445a91.4.1722965463968; Tue, 06 Aug 2024
 10:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806042935.3867862-1-andrii@kernel.org> <ZrHP31DJAQQjgdQz@krava>
In-Reply-To: <ZrHP31DJAQQjgdQz@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Aug 2024 10:30:51 -0700
Message-ID: <CAEf4BzarqEaE+SRG1ivnUG5GdAz7_+Jgo=E1vxu6ESFu-X024g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add multi-uprobe benchmarks
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 12:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Aug 05, 2024 at 09:29:35PM -0700, Andrii Nakryiko wrote:
> > Add multi-uprobe and multi-uretprobe benchmarks to bench tool.
> > Multi- and classic uprobes/uretprobes have different low-level
> > triggering code paths, so it's sometimes important to be able to
> > benchmark both flavors of uprobes/uretprobes.
> >
> > Sample examples from my dev machine below. Single-threaded peformance
> > almost doesn't differ, but with more parallel CPUs triggering the same
> > uprobe/uretprobe the difference grows. This might be due to [0], but
> > given the code is slightly different, there could be other sources of
> > slowdown.
> >
> > Note, all these numbers will change due to ongoing work to improve
> > uprobe/uretprobe scalability (e.g., [1]), but having benchmark like thi=
s
> > is useful for measurements and debugging nevertheless.
> >
> > uprobe-nop            ( 1 cpus):    1.020 =C2=B1 0.005M/s  (  1.020M/s/=
cpu)
> > uretprobe-nop         ( 1 cpus):    0.515 =C2=B1 0.009M/s  (  0.515M/s/=
cpu)
> > uprobe-multi-nop      ( 1 cpus):    1.036 =C2=B1 0.004M/s  (  1.036M/s/=
cpu)
> > uretprobe-multi-nop   ( 1 cpus):    0.512 =C2=B1 0.005M/s  (  0.512M/s/=
cpu)
> >
> > uprobe-nop            ( 8 cpus):    3.481 =C2=B1 0.030M/s  (  0.435M/s/=
cpu)
> > uretprobe-nop         ( 8 cpus):    2.222 =C2=B1 0.008M/s  (  0.278M/s/=
cpu)
> > uprobe-multi-nop      ( 8 cpus):    3.769 =C2=B1 0.094M/s  (  0.471M/s/=
cpu)
> > uretprobe-multi-nop   ( 8 cpus):    2.482 =C2=B1 0.007M/s  (  0.310M/s/=
cpu)
> >
> > uprobe-nop            (16 cpus):    2.968 =C2=B1 0.011M/s  (  0.185M/s/=
cpu)
> > uretprobe-nop         (16 cpus):    1.870 =C2=B1 0.002M/s  (  0.117M/s/=
cpu)
> > uprobe-multi-nop      (16 cpus):    3.541 =C2=B1 0.037M/s  (  0.221M/s/=
cpu)
> > uretprobe-multi-nop   (16 cpus):    2.123 =C2=B1 0.026M/s  (  0.133M/s/=
cpu)
> >
> > uprobe-nop            (32 cpus):    2.524 =C2=B1 0.026M/s  (  0.079M/s/=
cpu)
> > uretprobe-nop         (32 cpus):    1.572 =C2=B1 0.003M/s  (  0.049M/s/=
cpu)
> > uprobe-multi-nop      (32 cpus):    2.717 =C2=B1 0.003M/s  (  0.085M/s/=
cpu)
> > uretprobe-multi-nop   (32 cpus):    1.687 =C2=B1 0.007M/s  (  0.053M/s/=
cpu)
>
> nice, do you have script for this output?
> we could add it to benchs/run_bench_uprobes.sh
>

I keep tuning those scripts to my own needs, so I'm not sure if it's
worth adding all of them to selftests. It's very similar to what we
already have, but see the exact script below:

#!/bin/bash

set -eufo pipefail

for p in 1 8 16 32; do
    for i in uprobe-nop uretprobe-nop uprobe-multi-nop uretprobe-multi-nop;=
 do
        summary=3D$(sudo ./bench -w1 -d3 -p$p -a trig-$i | tail -n1)
        total=3D$(echo "$summary" | cut -d'(' -f1 | cut -d' ' -f3-)
        percpu=3D$(echo "$summary" | cut -d'(' -f2 | cut -d')' -f1 | cut
-d'/' -f1)
        printf "%-21s (%2d cpus): %s (%s/s/cpu)\n" $i $p "$total" "$percpu"
    done
    echo
done


> lgtm
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
> >
> >   [0] https://lore.kernel.org/linux-trace-kernel/20240805202803.1813090=
-1-andrii@kernel.org/
> >   [1] https://lore.kernel.org/linux-trace-kernel/20240731214256.3588718=
-1-andrii@kernel.org/
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bench.c           | 12 +++
> >  .../selftests/bpf/benchs/bench_trigger.c      | 81 +++++++++++++++----
> >  .../selftests/bpf/progs/trigger_bench.c       |  7 ++
> >  3 files changed, 85 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selfte=
sts/bpf/bench.c
> > index 90dc3aca32bd..1bd403a5ef7b 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -520,6 +520,12 @@ extern const struct bench bench_trig_uprobe_push;
> >  extern const struct bench bench_trig_uretprobe_push;
> >  extern const struct bench bench_trig_uprobe_ret;
> >  extern const struct bench bench_trig_uretprobe_ret;
> > +extern const struct bench bench_trig_uprobe_multi_nop;
> > +extern const struct bench bench_trig_uretprobe_multi_nop;
> > +extern const struct bench bench_trig_uprobe_multi_push;
> > +extern const struct bench bench_trig_uretprobe_multi_push;
> > +extern const struct bench bench_trig_uprobe_multi_ret;
> > +extern const struct bench bench_trig_uretprobe_multi_ret;
>
> SNIP

