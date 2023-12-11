Return-Path: <bpf+bounces-17406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C553780CE78
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE50281B06
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1248CF6;
	Mon, 11 Dec 2023 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFghgW5Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAB2D6;
	Mon, 11 Dec 2023 06:34:39 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so55901661fa.3;
        Mon, 11 Dec 2023 06:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702305278; x=1702910078; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tiX/dpMN3v7eu8p1bMl5yjJ/dzRHBAIxjhFcaH8YSfs=;
        b=mFghgW5ZH8IQCbYTp9AMKDwgfQhX4w3ER8HnwItJSkyj5sOcEZyqskAyeyjaeavyfB
         qTYwe/r0nezQ6OdTzvjBLFisCVnk2DjL9pekw6lgBHj8bEDJi2Kbu2wWfmjerI+cB8IF
         0HX/UxTIieMzdGW82cOH0sycex6ZqTXiE56Z1+IHjBmiDhojpHlw6gFnYKI32fncEJWB
         rZATXtzQrtw1vU2xsM4Euul6UkHF2hDNwo3avxfKpmxmZXxBhDaJPPchhZnasL5lnJw8
         veFtVUVM+LUSNaDtz4w+5EE6auHgR3ncoD6mveeXGlA0TAaqe5GrIwkYfiv6x1IRqZmN
         kh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702305278; x=1702910078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiX/dpMN3v7eu8p1bMl5yjJ/dzRHBAIxjhFcaH8YSfs=;
        b=jWVEEypkaTph79HxcF+ED06yjbYFd8VHt2JIu8bUk8ihcK5o9Yr1TkSNeFlYmro+Lu
         Zb61BHeEPjGusozewoxnwzXuw0rQTPiGw/J9ccd51boR1F65GzLCHAiqUxFzM4TT0Z0r
         Iru/0dAYrqS8i6j0cvWUELoyruT7Ilnz0JoRUIpqgK13CtTpOHq1RW29O+m3wxuwFU2a
         5+A/FfiuORADEmrMOKCUPZTCRuKSh/+B3yVhim/lqIs19LQr0UBTY6Da4qnPLvvUXMAA
         Zk4NzO/6dkm23UQ3eRthMb5WCCC0D0DbEWQKmY8l4CxAVcjloYD9/fuKFBVLVzpwws/b
         jvSw==
X-Gm-Message-State: AOJu0YzbH0gobSXba3pncseAKULE3mOT9m9UxUlXAHL0YmtVXtBHfn75
	gpRFwst/R1kJm5m6Z2y5Lzc=
X-Google-Smtp-Source: AGHT+IFJ662sze6P6FXjb3itAgJ2Il9SUQ02ZJ3x3wK3HC95jjrbQQ6mk1Z4uxxTPawqRvBGBgMY5g==
X-Received: by 2002:a05:6512:39c9:b0:50b:fe38:53fe with SMTP id k9-20020a05651239c900b0050bfe3853femr1612043lfu.5.1702305277605;
        Mon, 11 Dec 2023 06:34:37 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e10-20020adffd0a000000b003334675634bsm8733512wrr.29.2023.12.11.06.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:34:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Dec 2023 15:34:35 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, mhiramat@kernel.org,
	xingwei lee <xrivendell7@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: WARNING: kmalloc bug in bpf_uprobe_multi_link_attach
Message-ID: <ZXcd-_lVhoiWBh-4@krava>
References: <CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com>
 <689db41e-90f5-c5ba-b690-00586f22d616@huaweicloud.com>
 <ZXcIN-odFOCWX8Ox@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXcIN-odFOCWX8Ox@krava>

On Mon, Dec 11, 2023 at 02:01:43PM +0100, Jiri Olsa wrote:
> On Mon, Dec 11, 2023 at 07:29:40PM +0800, Hou Tao wrote:
> 
> SNIP
> 
> > 
> > It seems a big attr->link_create.uprobe_multi.cnt is passed to
> > bpf_uprobe_multi_link_attach(). Could you please try the first patch in
> > the following patch set ?
> > 
> > https://lore.kernel.org/bpf/20231211112843.4147157-1-houtao@huaweicloud.com/T/#t
> > > [   68.389633][ T8223]  ? __might_fault+0x13f/0x1a0
> > > [   68.390129][ T8223]  ? bpf_kprobe_multi_link_attach+0x10/0x10
> > 
> > SNIP
> > >   res = syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x20000140ul, /*size=*/0x90ul);
> > >   if (res != -1) r[0] = res;
> > >   memcpy((void*)0x20000000, "./file0\000", 8);
> > >   syscall(__NR_creat, /*file=*/0x20000000ul, /*mode=*/0ul);
> > >   *(uint32_t*)0x20000340 = r[0];
> > >   *(uint32_t*)0x20000344 = 0;
> > >   *(uint32_t*)0x20000348 = 0x30;
> > >   *(uint32_t*)0x2000034c = 0;
> > >   *(uint64_t*)0x20000350 = 0x20000080;
> > >   memcpy((void*)0x20000080, "./file0\000", 8);
> > 
> > 0x20000350 is the address of attr->link_create.uprobe_multi.path.
> > >   *(uint64_t*)0x20000358 = 0x200000c0;
> > >   *(uint64_t*)0x200000c0 = 0;
> > >   *(uint64_t*)0x20000360 = 0;
> > >   *(uint64_t*)0x20000368 = 0;
> > >   *(uint32_t*)0x20000370 = 0xffffff1f;
> > 
> > The value of attr->link_create.uprobe_multi.cnt is 0xffffff1f, so 
> > 0xffffff1f * sizeof(bpf_uprobe) will be greater than INT_MAX, and
> > triggers the warning in mm/util.c:
> > 
> >         /* Don't even allow crazy sizes */
> >         if (unlikely(size > INT_MAX)) {
> >                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> >                 return NULL;
> >         }
> > 
> > Adding __GFP_NOWARN when doing kvcalloc() can fix the warning.
> 
> hi,
> looks like that's the case.. thanks for fixing that
> 
> btw while checking on that I found kprobe_multi bench attach test
> takes forever on latest bpf-next/master
> 
> 	test_kprobe_multi_bench_attach:PASS:bpf_program__attach_kprobe_multi_opts 0 nsec
> 	test_kprobe_multi_bench_attach: found 56140 functions
> 	test_kprobe_multi_bench_attach: attached in  89.174s
> 	test_kprobe_multi_bench_attach: detached in  13.245s
> 	#113/1   kprobe_multi_bench_attach/kernel:OK
> 
> Masami,
> any idea of any change on fprobe/ftrace side recently? I'm going to check ;-)

nah sry, I had IBT enabled.. forgot the reason, but it's slow ;-)

jirka

