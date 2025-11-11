Return-Path: <bpf+bounces-74117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B44C4A59F
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1606434BFAE
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 01:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326223451CE;
	Tue, 11 Nov 2025 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaZbM9iw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1D3451B3
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823626; cv=none; b=oK6ImkAz0BFcOV+ZJj5+DcaG9ZxTclxNlWHAUMO3QqbimNRmjN5EsmJrrpsDopMXwibi+3Et0obvSDFKVEPXXAy91VJusuozffTGAeBsQhDZf7cl73RRzDmyXTFnisxcjtq72YD2db8XtmYiOI7COFMKrI7S9PuDEiXlTWAbi6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823626; c=relaxed/simple;
	bh=hhTQfqMQdGEWKu0SUeKoHBg4J6We+sM4NTOOcIt5Y04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdCX8suXBGzjlxb2Q9Kx8VQ0CPy8H02k3g0q222Y+XOugiT+BK4euwOL0a9+8NEEBVkMcNa0T/wWaLgOGggZi93tVpvu03L8K8SLIUnFySkt1wBUxRzamiNsZ0YNC9/wLMOLFdwrPzUz3MWSlX+NfWM9LhVN+6COocx9cDUry7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaZbM9iw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477442b1de0so24120575e9.1
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 17:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762823623; x=1763428423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wf3pVbyyzLAD2CLCknPpP4/ZnNnWVchFscOhWGWbRa0=;
        b=BaZbM9iwUIIFnq7hGzywn0nfjCBI5jhk0XZUWqhrQaF5XmFbUbSCH6GdvVzKGBkXfR
         EF2iIx8ISIKTIBhabUh49Mh91KARC89FXrCOlkm9+SngHC6VdZ/1F5+XbFr4c9sebEEp
         HGu/S0v2H3//i30r+eO7FRCDl6ntOrxEwjGp5IWYM3sMEP3KylZ+MZzSWxdCwgPkp4xd
         iLdXEafNy9One0kMX3euLQOvZZKA6tCDaABHBLULwk22hAWAxdsR3rGHiDQyg7kMwc06
         fInmVALKMZBZaDPo4UHdFhmORdllRts+1w2vVM+BfwqUXit/a8KfY501MdhT5a303tmC
         Hnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762823623; x=1763428423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wf3pVbyyzLAD2CLCknPpP4/ZnNnWVchFscOhWGWbRa0=;
        b=NK0YNp458pRFjo2c6aZymE/6BbLcVBusz1/4ANK5ZqJ22teBv+Cvvdh44XTIAo1PqF
         /sKX62/Yzv5lbGwze+Voh6HYKQQB8gWk/wgaUL0SEUh/8dgiU41Vm1PjkYSqFQ4fbJTS
         J6/biffgQ08zDl39gLOvm+uMU4xKjzHfZRAOtzs+RbfRfRS1P/ZlDLb92MHwIGbFsbzv
         X9vQ6hRe/AlDDNW3t6FGqfzIApp6QPjFjdzH4F7HjpA7NXXpLkIrdcjreEdsiEoY+zox
         4y/yfn8XN3HK3a9J4XxosLYc8z2Ae+eNCEVavQKyLk6iaR9C+n3RzlXIzKqiT1U9Jmgh
         M53Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrx248NzfdA7XLO/izjaWyDSABnHS63gh1Sn6atnxRwCO54l+VZf+XpMAs5jNnreYxb+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuLYDatkhrIwDCbMDTxfP+YL+yYWx9XihXcyupOzF0/b/+7Qz
	OH15f40ajWBDHze0RDFbdPwMVhroAg8z8CuYr0kJw554VmBlWao8xtR4eeCgOzFYBBG0vzWT3eB
	BgtOV/rGbXCfOzBl+9KX7h/lb0PoU5xQGraER
X-Gm-Gg: ASbGncukFke2Qdu69SWg6oYygz4+isNrIZCOyuggb91puukY25CTASrRj/O2C64Xqkb
	LxK/rhv3rEaWW8SWCqiPi4gxiqbmhlHN4To8sNpsdZp77Spho7W4qKNRizWqwSVnk8avAQS43Ce
	7/Eh3HNkKPm3N8N6Bb8OqUewY1qemtTURvEwArs7IE0x28h5qw80OMBbnYETbaSBl6M5kluFNv+
	3Wufz/W+s5S4ViucZ0WuBepQ1Pxttv9hl1ZXmZOQeiGXm2M6A47nFRABtiAo6nR4uWJ6pt/Pwme
	nzk3/KjlBwJWO59B5crctQ2yDi/O
X-Google-Smtp-Source: AGHT+IGgjr5Qh8PoI/Y9rGsURsnJertRH5j3WbetRE+9UiAMvpNj+22mrAMqySG/abHjU85KO3FMBsxliNMuk8948nQ=
X-Received: by 2002:a05:600c:1c8e:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47773287447mr83262175e9.35.1762823622996; Mon, 10 Nov 2025
 17:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110092536.4082324-1-pulehui@huaweicloud.com> <92ba87bbc6b11234be1925a4dc7262e11cd07305.camel@gmail.com>
In-Reply-To: <92ba87bbc6b11234be1925a4dc7262e11cd07305.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Nov 2025 17:13:31 -0800
X-Gm-Features: AWmQ_bme-fSvninXA5DjX4BklKjaH0KfRc18ik1kTt2xYH8_5Vyq_RSFmfFeelc
Message-ID: <CAADnVQ+2jdSD=HMMq3tKvu08gF49T=290LNzvc5LDOf4AycEuw@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2025-11-10 at 09:25 +0000, Pu Lehui wrote:
> > From: Pu Lehui <pulehui@huawei.com>
> >
> > Syzkaller triggers an invalid memory access issue following fault
> > injection in update_effective_progs. The issue can be described as
> > follows:
> >
> > __cgroup_bpf_detach
> >   update_effective_progs
> >     compute_effective_progs
> >       bpf_prog_array_alloc <-- fault inject
> >   purge_effective_progs
> >     /* change to dummy_bpf_prog */
> >     array->items[index] =3D &dummy_bpf_prog.prog
> >
> > ---softirq start---
> > __do_softirq
> >   ...
> >     __cgroup_bpf_run_filter_skb
> >       __bpf_prog_run_save_cb
> >         bpf_prog_run
> >           stats =3D this_cpu_ptr(prog->stats)
> >           /* invalid memory access */
> >           flags =3D u64_stats_update_begin_irqsave(&stats->syncp)
> > ---softirq end---
> >
> >   static_branch_dec(&cgroup_bpf_enabled_key[atype])
> >
> > The reason is that fault injection caused update_effective_progs to fai=
l
> > and then changed the original prog into dummy_bpf_prog.prog in
> > purge_effective_progs. Then a softirq came, and accessing the stats of
> > dummy_bpf_prog.prog in the softirq triggers invalid mem access.
> >
> > To fix it, we can use static per-cpu variable to initialize the stats
> > of dummy_bpf_prog.prog.
> >
> > Fixes: 4c46091ee985 ("bpf: Fix KASAN use-after-free Read in compute_eff=
ective_progs")
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
> > ---
>
> Hi Pu,
>
> Sorry for the delayed response. This patch looks good to me, but I
> think that your argument about memory consumption makes total sense.
> It might be the case that v1 is a better fix. Let's hear from Alexei.

I don't particularly like either v1 or v2.
Runtime penalty to bpf_prog_run_array_cg() is not nice.
Memory waste with __dummy_stats is not good as well.

Also v1 doesn't really fix it, since prog_array is
used not only by cgroup.
perf_event_detach_bpf_prog() does bpf_prog_array_delete_safe() too.

Another option is to add a runtime check to __bpf_prog_run()
but it isn't great either.

pw-bot: cr

