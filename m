Return-Path: <bpf+bounces-56597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B2A9ADF9
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BB61B60511
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738C827B516;
	Thu, 24 Apr 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLnTmRLC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9427A908;
	Thu, 24 Apr 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499100; cv=none; b=lyZsUJJ6er6IriyiicfohL60Ef7r888jKkL7hYfas0j4OL0KYJZE+25rH7T75IledkRbVCzgdoSlBusrCpUib/jU6sXv3IE0ExrlgtXOnbCEG9RA+KtHO8zgC8yMELAODI0qFcoTpDrdcYvzsw2Z5nhdXh69TcWIWOUK7eEGVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499100; c=relaxed/simple;
	bh=MHKn+EdWhAhoB/tNSI0aX59JflxZSZo+kWrmGYyIxlA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/H+lUejkUnZQEaBzftG+DS0X44eim3AC7npPtdu0foBX0IQkojdiUSBtzw/MF9ST8tp8aPeNFkNP9M1HLJwzhXNVDt6lHnIl8dy+XsHzetVh8f8RAujIz21lMry0Gqy9su83M5b759A1oYUXsQsqt1nMW9DYtUrXjnh5npbNcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLnTmRLC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaecf50578eso152556466b.2;
        Thu, 24 Apr 2025 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745499096; x=1746103896; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WoCqvs1DJYai/uMoUc+wigTMUqKQl+TiJoeJOKS4hLA=;
        b=QLnTmRLCuiRGqTwilaJFV5VQcGo/vm63fYKjmPUtOoZamZU8+m6sXQDq1K2sQTr/1a
         nZ08hGeNDPjPKG5ESi5v1Tez2ncP+aiXJRVENrn6ashwQEjjmqGIbBeJpOepmmMfgy0r
         PCOk0ZXbHYsVLgset81WqTyRlzJU7uymh3gPzSQ+2fNn54aVmywV1kDn4bGA/luCdWYV
         hZt3Ur45VwUzaaS+6yBOPLAcDupHKZLw/srqPSOaoNy1qvcGBKNPG1rHFY3xRwD13TyP
         y7glBemejnlCrZ6jwrZ8Z24jUMlIXuCSfXRR8IYIsYJgkBAvSXknMDo+nd02jR3NyBhY
         iGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499096; x=1746103896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoCqvs1DJYai/uMoUc+wigTMUqKQl+TiJoeJOKS4hLA=;
        b=ZTfplFDTfnfJcA/xtPVlKm+hc5UshAkgoaDX2RcTS5L5YsfRoH9E08FGeT6HQfTSSi
         Gb4OkFMypnguD07SgxDyFqoNRIW0s09PUaArWwhOBeJvFXoJa5qg0pfE4QZkb8D6prfP
         LAog/dPUAZ2k/mm8IuXOSNhb5ZtZmom0Hbcgajtg6Bi8jDJdvChG89lkUVxYKLHIydYR
         PcISh8MUkLtRzNQYKED9GzB9iPZf6SAZnsghlWNCpGdS3txdaOua09kxHu378wYA2f+5
         CT4DgQptOGlAyj/PPU/RLNxhBDoZozq2IzTvzKp5X1LNL/XOdbYz6Mo0ntRgqu9hJTNQ
         7qPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF29BMOMxuBupGx/IOyAymV4j5bGKsHHdJ4gKYx/QLSvyvEIKhKPobwtnDEru36nia7zAMhwVeDG50j2+6@vger.kernel.org, AJvYcCWxSbe5cLAQUZrQzWU5T0/Fpx9vZCgjafC8PV1NjBpkQfFCpnXIgVELmj+QstOznZZxENWwXUSC7rAxEwzRXLU7WLIu@vger.kernel.org, AJvYcCXVMNrdIDxGSdDk4bBsnSucoElyQfXEQqWPAE7tCwolMVN0kTAyNHlGGQVXKlKLLOyYvwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9drhqxUmqdbAkKNB49St9ORSrIKXzH9u7nDXkVNZY0YRlqM6o
	v5k9OYCK1udGCie1tBg5teAQz4cL11CZXtlBqukMcHdZHPj2hjwV
X-Gm-Gg: ASbGncuQm1JuaAyha3p9289FclSHxGVYmNtGWCfhJXX0nIxGc0boMt+1BH48nHksmzJ
	3ve97FqPB5GeRgy6SScKPKHxLpozLK2VueW61THf7le7JO+datCi+9B4l3UI0+ex+yGfgfvmKjv
	X5+aBCAJLnd5koR69tT34cYU4dWthfXlA1LDlTUQHUoX1NphTUXloOxQHm9HBuZWVv9eT7K/Jfs
	zj/TlbQ09r4n6bZi/pK8f2DckWQfGjVPIR9E+cgQeZivl1ayJmHvE1VFpotmj/DOmerxZLngS2u
	A6zK2waoy0Io40khX0yZjFF4lmH/0KVzzdPUPw==
X-Google-Smtp-Source: AGHT+IEWuZYGNBXx1lEdhEESLbtbRgcdGI6jeUaJBjEsoBL/886QU1Pi4aziijH3FrEv7xXHvq9Tww==
X-Received: by 2002:a17:907:2689:b0:abf:6ec7:65e9 with SMTP id a640c23a62f3a-ace573a7236mr256549266b.43.1745499096131;
        Thu, 24 Apr 2025 05:51:36 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace598205f4sm104200066b.8.2025.04.24.05.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:51:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Apr 2025 14:51:33 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 18/22] selftests/bpf: Add uprobe_regs_equal test
Message-ID: <aAoz1ZBL2WahMa4m@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-19-jolsa@kernel.org>
 <CAEf4BzZu0T5DLROi6oisneB3PyGDKZrME9+5qvw4aHeyOyNiYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZu0T5DLROi6oisneB3PyGDKZrME9+5qvw4aHeyOyNiYQ@mail.gmail.com>

On Wed, Apr 23, 2025 at 10:46:24AM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 21, 2025 at 2:48 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Changing uretprobe_regs_trigger to allow the test for both
> > uprobe and uretprobe and renaming it to uprobe_regs_equal.
> >
> > We check that both uprobe and uretprobe probes (bpf programs)
> > see expected registers with few exceptions.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 58 ++++++++++++++-----
> >  .../selftests/bpf/progs/uprobe_syscall.c      |  4 +-
> >  2 files changed, 45 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index f001986981ab..6d88c5b0f6aa 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -18,15 +18,17 @@
> >
> >  #pragma GCC diagnostic ignored "-Wattributes"
> >
> > -__naked unsigned long uretprobe_regs_trigger(void)
> > +__attribute__((aligned(16)))
> > +__nocf_check __weak __naked unsigned long uprobe_regs_trigger(void)
> >  {
> >         asm volatile (
> > -               "movq $0xdeadbeef, %rax\n"
> > +               ".byte 0x0f, 0x1f, 0x44, 0x00, 0x00     \n"
> 
> Is it me not being hardcore enough... But is anyone supposed to know
> that this is nop5? ;) maybe add /* nop5 */ comment on the side?

ok, will add the comment :)

> 
> > +               "movq $0xdeadbeef, %rax                 \n"
> 
> ret\n doesn't align newline, and uprobe_regs below don't either. So
> maybe don't align them at all here?

ok

thanks,
jirka

