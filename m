Return-Path: <bpf+bounces-19880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC4832560
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 09:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F681F21C7B
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30DD53E;
	Fri, 19 Jan 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP4ERzYP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66159D52B
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651410; cv=none; b=HzlO+3Nz0rp+Kr6zDURJxOjYKvgFlPT+1aI5S5/CUNJy2iaATJl9+pwQe1OB54oKpOK6GgWl0J3cIvgkSgo01lsy2WqlAoSdisplp3MZd1VL2vtPx6fNuQIyG++dL6JRYUET9yZ4bZJV6KGPXOE7BLAhLhIud3C9u8R1zzahF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651410; c=relaxed/simple;
	bh=abPDcecw5wmLzQ1eKzWmlyi+LPAU0QTm73IHMGZsqG4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW0XRkukDohLf6M16F/CR6GqZ8m34vPA5d7KtB2Fmw97os8FctTas2ldinGPtvevYio0+Kc7aVw7NkyZntdfPuwm4ez9OwCGBBL9AMOhVTA5ymxYIbQJnBPh0nkHhFP6MFqvhnoKCS2tKuJQq4ic5fAwpwMAetXHzhwFvjCuZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP4ERzYP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a064e54a7so922538a12.1
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705651407; x=1706256207; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wixkymS5X7VRcEtpulcy/HuClxfJ1Kdbeq4C8xuhxok=;
        b=EP4ERzYPUd6rVjCL012T8Q1v57eMTxLfLLibC+BAJPIyIBpdpRVl8AvY/xY5LFkvu4
         f7i3ym+Cwf0XIJMjNKy1seoOj//84xQqnZ5OeReXWKX8yTqimxFRS19mSuIdq0ibPKSM
         gwLEW9o/zTNCee3rw7xO0WzF6JEy82OzHeqP9PHBe8SVuxOyqDePCMCYQIa2FnW2z67a
         pPEjfCe05QR/38nyT5bR2I+UCQbdUD29LzhnHZACsGRKzXEQ8e4HBiJHngpDvyleTnjH
         HflkJUttGOnmB7F8QfrzevSD/FF03/ko4CEIN54tO70wX97p99og4EXjEcNBsPnywhn2
         fWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705651407; x=1706256207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wixkymS5X7VRcEtpulcy/HuClxfJ1Kdbeq4C8xuhxok=;
        b=X2VpaYoMkBRIVydrpvpJZ7nHFTjdlhiG+Y3/yIs5In2xrkhs1qRDGCjy0n2niBLFR7
         M+jzAhf/km4YaSK+6V0DvJcI/NGuhEewVYovnAZzAscpVoGRHQK1mobd1DIFflqfZN96
         BSRy/sEVmzcK+7ded4L9yAjxIvA76pRLDj4cKSwNj59khqMPqzhHrIVfqk9vcSlR02L3
         ILZ++M5SktEF8w2RzihgCL8Odi+s+XEqa/8swmBSJ1JFzf5xZvIuonkeIGhEEwtpiBYx
         l9Mlwzivu+tUeY2U3AOWWoh/88QTk/YTONqrMDAiHOrp1jq0FyzgeC3v0B/GVuJZuk7M
         Jt4w==
X-Gm-Message-State: AOJu0YyhWkBxYID4+xIwU9PfOGnNf6YQk3LZCqKJnM6QdopDdNvmwno5
	sDIsyyVaOoOM/NreFE5aKeDyMoEjfl8mleIe//CUX+VYMmZm0tuV
X-Google-Smtp-Source: AGHT+IEKp8CSNCnDZSFqnimH7JRVCueWB4SZA+0ZHCQR/kkBgZZ504vBJENskpS3bTKs6hPyC9Z7uw==
X-Received: by 2002:a05:6402:2d7:b0:559:b99b:fd7d with SMTP id b23-20020a05640202d700b00559b99bfd7dmr590994edx.40.1705651407313;
        Fri, 19 Jan 2024 00:03:27 -0800 (PST)
Received: from krava (78-80-61-208.customers.tmcz.cz. [78.80.61.208])
        by smtp.gmail.com with ESMTPSA id e16-20020a056402191000b0055a331beecesm1387621edz.72.2024.01.19.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:03:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Jan 2024 09:03:25 +0100
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next 0/8] bpf: Add cookies retrieval for perf/kprobe
 multi links
Message-ID: <ZaoszTLcNmbz9Mck@krava>
References: <20240118095416.989152-1-jolsa@kernel.org>
 <CALOAHbD6B+xG=Cn1za8QKf5MvodM7xUDUxkuM7YT-0emhh2e1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbD6B+xG=Cn1za8QKf5MvodM7xUDUxkuM7YT-0emhh2e1g@mail.gmail.com>

On Thu, Jan 18, 2024 at 08:42:29PM +0800, Yafang Shao wrote:
> On Thu, Jan 18, 2024 at 5:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > this patchset adds support to retrieve cookies from existing tracing
> > links that still did not support it plus changes to bpftool to display
> > them. It's leftover we discussed some time ago [1].
> 
> Thanks for your work.
> 
> bpf cookie is also displayed in the pid_iter [0]. After we add support
> for the cookie for other progs like kprobe_multi and uprobe_multi, I
> think we should update this file as well.

ok, I'll check

thanks,
jirka

> 
> [0]. tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> 
> >
> > thanks,
> > jirka
> >
> >
> > [1] https://lore.kernel.org/bpf/CALOAHbAZ6=A9j3VFCLoAC_WhgQKU7injMf06=cM2sU4Hi4Sx+Q@mail.gmail.com/
> > ---
> > Jiri Olsa (8):
> >       bpf: Add cookie to perf_event bpf_link_info records
> >       bpf: Store cookies in kprobe_multi bpf_link_info data
> >       bpftool: Fix wrong free call in do_show_link
> >       selftests/bpf: Add cookies check for kprobe_multi fill_link_info test
> >       selftests/bpf: Add cookies check for perf_event fill_link_info test
> >       selftests/bpf: Add fill_link_info test for perf event
> >       bpftool: Display cookie for perf event link probes
> >       bpftool: Display cookie for kprobe multi link
> >
> >  include/uapi/linux/bpf.h                                |   5 +++++
> >  kernel/bpf/syscall.c                                    |   4 ++++
> >  kernel/trace/bpf_trace.c                                |  15 +++++++++++++
> >  tools/bpf/bpftool/link.c                                |  87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
> >  tools/include/uapi/linux/bpf.h                          |   5 +++++
> >  tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
> >  tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 +++++
> >  7 files changed, 204 insertions(+), 32 deletions(-)
> 
> 
> 
> -- 
> Regards
> Yafang

