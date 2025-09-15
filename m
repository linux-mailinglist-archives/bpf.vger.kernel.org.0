Return-Path: <bpf+bounces-68440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A7CB586C9
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 23:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90302204AB6
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C172C029C;
	Mon, 15 Sep 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPFp6fa4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E372DC78E
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971784; cv=none; b=bdBagrcME1UmhoJT4T6WLuN6qcKuqXbZ1lI4m2VBDuiXkLJP60OyfRqRN4he8y8ygG6ZMzkys+Hq2+AbA9MRUJB68gQv1IimFv5l8I86djXUhaCeorwrCM3KzlDKEKOgu2qYZwAnyXuPNw7grKM8olW+EuXtU4FBSDjd2RfUfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971784; c=relaxed/simple;
	bh=RUVduxfW+q1+xIpDUx9oew7SFp3YP2RX1oljyANBXE4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh40zyBjEACGU51XkaxgauSWY5yyK9dFkYXuZ2xbesOhAqupmbeIqQlSVuQyOAbDTEwi/T6oRZ5OeCZJJgKCnr+Gu8wgXSBhJvGijWIf6uv0fYjkeD1MSGkPuwtpM6iQHCl6a6M0cofiAgys/5KYPmJWne0RDwrQSEUof7ObXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPFp6fa4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b046fc9f359so719206966b.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757971781; x=1758576581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QUas9F/ATYTJ0SX50S151v/GKp7Qx1ja4tfTxLpr0QY=;
        b=VPFp6fa4lWuSnwBXuKEYb3/PH/ONtdheIf70Hf+TUw1LE6MaQoRXxtJhoBV5Ch9nXt
         RZSGOFLeYwMLBne2M2oR7XAmP3nbV9ffl1CmYRCa/fEVww2Pj5Jt4NnTaVr7Vr4uwKvb
         35A4bplk5pJ+q4r1lgo+vJjZI1L9m7mnrQvLL0hpbT9dbab3nleNog+3J4DaimlZ/COJ
         z7brMKn594e5NgRfpndVXaq15IsEUCClHzl0ttPUHf6Mx+j23pUomUTj0QRlkKdbqA90
         ci8GvEgEDyCp1q9wRqZsZ1cJxv9B7J2fpL5dxek5uMWHREkQTwFdTY0JYlUx96vD1ijX
         sS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971781; x=1758576581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUas9F/ATYTJ0SX50S151v/GKp7Qx1ja4tfTxLpr0QY=;
        b=PtyIbw6sTaOt1Ym6wciVZSTpb/UDYhP82Tl+4haHujtPPRbikJi5Jiy+cSItoo6Pvz
         ecV/kwW8WySvxmzyzOlJrnfk6Nzc1FrUgz3j0mAT9Q2zwU1VZbW/ZHMJryc9vzETFfyD
         7fV2zodfKASZHjG6kd+JBPpX9YTEXghP8QMkokabkVp2bXgSbRT5YvsZNmfG8TWjC0/t
         IeKRMbnU/W+6VXnuGeddyj+69+U8LDqUp0nwvnJ2InICb+S6wGqlgzFKy/qjgpBs6pKb
         MELIjZja6cji2MlsMIyjGeDrg3kwLu1QSC6KaiROXLw3hgcymz3NPlQcLpOn0KVPMvm3
         FjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/uAeUX+jnJ246N/sIjHEcd8frqrcXPAOaJ0Jns0HVY/GPIuj0fiWFm0CVkPc6riY2tOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfibUqFuhy916NVDy98YkF8q90QehIqbnH+vWaIJjgd4R4RzLv
	aNae2iQy2eD6HxmFWmmPgR2FZxwevP0K8r2rPzrU1OqrUY4JK6Sfxz4A
X-Gm-Gg: ASbGnctJRW8ei7w6Jp6etJQjY18E+Lxxm1Ba/xdry6c2IhdwmmqXnNadLG1ozCPqhBH
	RvZ8R3ZD2alSB0NqW0Bb0ZpXx3yc/1zXq+BcLI663wDuvH4RfSNhpamaXoHOJVg1ttsphhLiYfF
	Hz8GvcIWpv+i7z3lZlNJg/QDohp57cDxenht4WAWg2T8rftPk396qdh29d641qQBXvl46RKNX4Q
	v3YKkUEEWPdKw6lJHY48dr4M8VgpL2FS1vZn6IO6nc4Luimz1qfQC1zvwzU9eYpxUWWGgTg4mgI
	fNzrjVr8oulUIr/9fEbnmenZNBft8G6U7qyjKm9vtC2NWqQ+tK3yfPEIJEGEWjP0PiOYzzoMb2g
	lXxQlCfeNQkKt8JTiZOEaFgkpcU5rB3JG5+mAEjVN4d8/7CFKzw==
X-Google-Smtp-Source: AGHT+IG5wmhrzfoQv6frcbayV8TWGbdyF5my/3S+PId8ITD1HBtsuQZQe3hHDZN00pZEVUVkM/1bmw==
X-Received: by 2002:a17:907:7e9a:b0:afe:ea93:ddbb with SMTP id a640c23a62f3a-b07c38673ccmr1371195966b.45.1757971780425;
        Mon, 15 Sep 2025 14:29:40 -0700 (PDT)
Received: from krava (89-40-234-69.wdsl.neomedia.it. [89.40.234.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b09fea706afsm550131766b.91.2025.09.15.14.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:29:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 15 Sep 2025 23:29:37 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 0/6] uprobe,bpf: Allow to change app
 registers from uprobe registers
Message-ID: <aMiFQRLP3w1APfbU@krava>
References: <20250909123857.315599-1-jolsa@kernel.org>
 <CAEf4Bzb4ErWn=2SajBcyJxqGEYy0DXmtWuXKLskPGLG-Y9POFA@mail.gmail.com>
 <7f591ac9-d3e0-4404-987c-40eceaf51fbb@linux.dev>
 <aMSIr1oItIfWQd5R@krava>
 <CAEf4BzZ21xFq25Vs0xSmCfb1MSbdz_GLs8B6s+h0Q3kCTmnzSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ21xFq25Vs0xSmCfb1MSbdz_GLs8B6s+h0Q3kCTmnzSw@mail.gmail.com>

On Mon, Sep 15, 2025 at 01:10:33PM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 12, 2025 at 1:55 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Sep 12, 2025 at 01:28:55PM -0700, Ihor Solodrai wrote:
> > > On 9/9/25 9:41 AM, Andrii Nakryiko wrote:
> > > > On Tue, Sep 9, 2025 at 8:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > hi,
> > > > > we recently had several requests for tetragon to be able to change
> > > > > user application function return value or divert its execution through
> > > > > instruction pointer change.
> > > > >
> > > > > This patchset adds support for uprobe program to change app's registers
> > > > > including instruction pointer.
> > > > >
> > > > > v3 changes:
> > > > > - deny attach of kprobe,multi with kprobe_write_ctx set [Alexei]
> > > > > - added more tests for denied kprobe attachment
> > > > >
> > > > > thanks,
> > > > > jirka
> > > > >
> > > > >
> > > > > ---
> > > > > Jiri Olsa (6):
> > > > >        bpf: Allow uprobe program to change context registers
> > > > >        uprobe: Do not emulate/sstep original instruction when ip is changed
> > > > >        selftests/bpf: Add uprobe context registers changes test
> > > > >        selftests/bpf: Add uprobe context ip register change test
> > > > >        selftests/bpf: Add kprobe write ctx attach test
> > > > >        selftests/bpf: Add kprobe multi write ctx attach test
> > > > >
> > > >
> > > > For the series:
> > > >
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > >
> > > > Question is which tree will this go through? Most changes are in BPF,
> > > > so probably bpf-next, right?
> > >
> > > Hi Jiri.
> > >
> > > This series does not apply to current bpf-next, see below.
> > >
> > > Could you please respin it with bpf-next tag?
> > > E.g. "[PATCH v4 bpf-next 0/6] ..."
> > >
> >
> > hi,
> > the uprobe change it needs to be on top of the optimized uprobes (tip/perf/core)
> 
> Is this what you happened to base it on (and thus diff context has
> that arch_uprobe_optimize), or those changes are needed for correct
> functioning?

yes

> 
> It seems like some conflict is inevitable, but on uprobe side it's two
> lines of code that would need to be put after arch_uprobe_optimize
> (instead of handler_chain), while on BPF side it's a bit more
> invasive.
> 
> So unless tip/perf/core changes are mandatory for correct functioning,
> I'd say let's rebase on top of bpf-next and handle that trivial merge
> conflict during merge window?

ok, sounds good, will rebase/resend

thanks,
jirka

