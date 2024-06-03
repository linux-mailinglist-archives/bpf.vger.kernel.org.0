Return-Path: <bpf+bounces-31183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2018D7E03
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 11:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454F0B20BA4
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B8537E7;
	Mon,  3 Jun 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwrmYOFd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7F7E574;
	Mon,  3 Jun 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405371; cv=none; b=YsP47F/gNLEhGGxFGKBOzFSmH4I6XQyN+hl2pLqJLl1sqqV9GDlXaxANqOChA3dCej+R98M+AOaQfhz1e3+sZnjgBjH+lHu8DFFHhvvgPlFPastdFN0dlNkEO0u9Zd2VVEOBGrybdNAFT/b2vy+HLkyQkHBAsIaa38t+9bVymRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405371; c=relaxed/simple;
	bh=SPF5vYq2Bz+QLSYK2fjeqR2QfYX3fA8jp9temU6aHno=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn1PiYTwZvXGBTNoA3P14p0wYLWxEexvUpbeMFg9DY0VT51DfACkrhZeZqwYoZ8hbv8cbux03ezX4NvphStuhZdSyEmDNZ2kl8a+oL3Y1/hjX2Wxx8aLUicESlykie4pQ3v87qXw1h7b58vMpkICsziYjMWz0TupUJMqo1M9FB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwrmYOFd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f63642ab8aso20946575ad.3;
        Mon, 03 Jun 2024 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717405369; x=1718010169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ycgHEhOjcNcyqbebTXKq5zR8iqQL1GlvtGGEcGSK7PM=;
        b=cwrmYOFdKo70At1YXDmhL4d6Z/Z71Op3/+3z5Mzj8nfpYqXfPXzHpXj+shnd4Xu+PV
         0vmpi1ESfPHfCucEsHoDx+9JpGonpfPLW96G/4nMa8igCmyiOATgN8/9YNJWIREpcG0x
         Q5VDVnQ440sqdSWPjRA3AJhd5RSUucnfCUdtHFRhmfj26uZD7l59w6WDXvmjsuIG5MWR
         MK/T4WRB+cF+xGrtJDyM7ZdZDUtTY6i+SVtQv5fkPQHfdrkt0DZHXXWAFAslR/tHsbzz
         Qta7pnj0W7jYuRQAPUsxfFie9NToBhTMwN3fyV/7zMsh0Xj393fWGbgT6BDT/jnKOD3F
         rwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405369; x=1718010169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycgHEhOjcNcyqbebTXKq5zR8iqQL1GlvtGGEcGSK7PM=;
        b=ucTugdNTGZhN5dHRhWJ6TeFssTvECX5kGCEX5jY+auNhsLEOYbAbitC0kmvUDOGscV
         ah4TYgGvQOD5JGNXrN+E8pkhgqZJ8sZvdhva8T4uAFq0IgGEq2m42DHhhACdppdFRDmN
         j51qV1LEK1GLJ6movdK1CpEpe3MYfjlbSVePjAnWOTQb5EQG0+ccBCLDCcwl2imDG4x9
         q171P4WfxYDHacf+k7P0Kqw9cJA934oEndem9bPVPWmBi94jHMM3LN50cuw/O/1uk+cy
         PzeBb7cJGcOg2nXH3ps/HtjJVxDkvC7l8h9OImDUZ++SQQBKXeWZsRUxxDJR2QlI9b5u
         yM3w==
X-Forwarded-Encrypted: i=1; AJvYcCUcHUp2XL3bQIEWN/0jiyShMe7J105Dae92PRQpqKDbJf+EnWvyxEOOLBqY9BXanZdFehxOQHLJUwqGyhuyJssK6F7hiN5S3vexU8Sk5YBsdI+JaoJ8l0jNLLx3+g==
X-Gm-Message-State: AOJu0YypiQjrS9wQTdT6J58JuMT1ol+XD+uWGDkDGMojnlXjlNsFG9p6
	N8QTKmNQUeriB17pwSP2TywUi5Of2PHgNFRU9HqRAFJnzh9of/AjLRsxYvXu
X-Google-Smtp-Source: AGHT+IHzD5inovb4qNPKvPSlfnNlJbDGhW5W8hn/VnXRHFTT/jB7glR/nIXeXS7plt0oxorQ7MEFGw==
X-Received: by 2002:a17:902:fcc8:b0:1f4:bcef:e970 with SMTP id d9443c01a7336-1f6370cda21mr66036885ad.55.1717405368412;
        Mon, 03 Jun 2024 02:02:48 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6358079bdsm58163865ad.263.2024.06.03.02.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 02:02:47 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 3 Jun 2024 02:02:45 -0700
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <Zl2GtXy7+Xfr66lX@kodidev-ubuntu>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmGoT9KiYLZd91S@krava>
 <Zlm2UNWHrGtRROGS@kodidev-ubuntu>
 <Zlnc_Kkd2o6ADgkO@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zlnc_Kkd2o6ADgkO@krava>

On Fri, May 31, 2024 at 04:21:48PM +0200, Jiri Olsa wrote:
> On Fri, May 31, 2024 at 04:36:48AM -0700, Tony Ambardar wrote:
> > Hi Jiri,
> > 
> > On Fri, May 31, 2024 at 10:13:21AM +0200, Jiri Olsa wrote:
> > > On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> > > > Hi Tony,
> > > > 
> > > > On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > For some time now I'm seeing multiple issues during BTF generation while
> > > > > building recent kernels targeting mips64el, and would appreciate some help
> > > > > to understand and fix the problems.
> > > > >
> > > > > Some relate to resolve_btfids:
> > > > >
> > > > > >   LD      vmlinux
> > > > > >   BTFIDS  vmlinux
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_session_cookie
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_key_put
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> > > > > > WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> > > > > >   NM      System.map
> > > > > >   SORTTAB vmlinux
> > > > > >   OBJCOPY vmlinux.32
> > > > >
> > > > > These do not appear to be #ifdef-related and have similar past reports [1].
> > > 
> > > I can reproduce the warning just for bpf_session_cookie,
> > > which has fix in progress:
> > >   https://lore.kernel.org/bpf/20240531071557.MvfIqkn7@linutronix.de/T/#t
> > 
> > I gather there are different root causes for these warnings. From the link,
> > the issue with bpf_session_cookie seems related to conditional compilation,
> > which have come up before on the mailing list IIRC.
> > 
> > In comparison, consider my above warning for bpf_key_put, which is defined
> > in kernel/trace/bpf_trace.c. This kfunc is guarded by CONFIG_KEY, which is
> > enabled in my config and so not the issue. I can in fact see the global
> > text symbol for bpf_key_put in bpf_trace.o, but not in vmlinux.
> 
> yes, that would be a problem, the resolve_btfids goes through the BTF
> lists and needs to resolve the function in vmlinux, when it's not there,
> it will output the warning above
> 
> > 
> > So I suspect the warnings might come from linker or optimization problems,
> > or perhaps even an issue related to the __bpf_kfunc annotation. WDYT?
> 
> I can reproduce now resolve_btfids warnings:
> 

That's great to hear! Did you also use mips64el? And were you able to see
the various "die__proc:" errors from pahole during BTF generation?

>   LD      vmlinux
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> WARN: resolve_btfids: unresolved symbol bpf_session_is_return
> WARN: resolve_btfids: unresolved symbol bpf_session_cookie
> WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> WARN: resolve_btfids: unresolved symbol bpf_key_put
> WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> 
> when I call bpf_key_put to make it 'used' it stays in vmlinux, so I wonder
> the __bpf_kfunc flags do not work properly on this cross compile chain..
> and linker just optimize it away?

Yes, I verified the problem occurs during link-time garbage cleaning, when
LTO is enabled through e.g. LD_DEAD_CODE_DATA_ELIMINATION=y.

> 
> #define __bpf_kfunc __used noinline
> 

After researching, I believe this isn't a mips problem specifically, rather
the __bpf_kfunc tag only partly works. It appears the __used macro works at
the compiler and IR-level but is ignored by the linker. I have a working
fix that also handles the linker level, so I'll post the patches shortly.

Unfortunately, that still leaves the pahole errors generating BTF, which
are serious as they seem to break module loading.

> thanks,
> jirka

Cheers,
Tony
> 
> > 
> > > 
> > > > >
> > > > > I also see many pahole failures during BTF encoding of modules, such as:
> > > > >
> > > > > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > > > > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > > > > >   CC [M]  net/psample/psample.mod.o
> > > > > >   LD [M]  crypto/cmac.ko
> > > > > >   BTF [M] crypto/cmac.ko
> > > > > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > > > > or DW_TAG_skeleton_unit expected got member (0xd)!
> > > > 
> > > > The issue seems to be related to elfutils. Have you tried build from
> > > > the latest elfutils source ?
> > > > I saw the latest MIPS backend in elfutils already implemented the
> > > > reloc_simple_type hook.
> > > 
> > > hi,
> > > +1, could you also check the pahole version you used?
> > 
> > No luck I'm afraid with using the latest elfutils as suggested.
> > 
> > I used pahole v1.26 in my original testing for this bug report, as noted
> > below (might have been buried a bit).
> > 
> > > 
> > > jirka
> > > 
> > > SNIP
> > >
> > > > > Details of the git commit and build environment are as follows:
> > > > >
> > > > > > $ git log -1 --oneline  bpf/master
> > > > > > 9dfdb706e164 (bpf/master) selftests/bpf: fix inet_csk_accept prototype in
> > > > > > test_sk_storage_tracing.c
> > > > > >
> > > > > > $ lsb_release -a
> > > > > > Description:    Ubuntu 22.04.4 LTS
> > > > > >
> > > > > > $ cat gcc-compile.txt
> > > > > > ARCH=mips CROSS_COMPILE=mips64el-linux-gnuabi64- CC="ccache ${CROSS_COMPILE}gcc" make -j6
> > > > > >
> > > > > > $ mips64el-linux-gnuabi64-gcc --version
> > > > > > mips64el-linux-gnuabi64-gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0
> > > > > >
> > > > > > $ mips64el-linux-gnuabi64-ld --version
> > > > > > GNU ld (GNU Binutils for Ubuntu) 2.38
> > > > > >
> > > > > > $ pahole --version
> > > > > > v1.26
> > > 
> > > SNIP
> > >
> > > > > I'd be grateful if some of the BTF/pahole experts could please review this
> > > > > issue and share next steps or other details I might provide.
> > > > >
> > > > > Thanks,
> > > > > Tony Ambardar
> > > > >
> > > > > Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1]
> > > > > Link: https://github.com/acmel/dwarves/issues/45 [2]
> > > > 
> > > > Cheers,
> > > > Hengqi
> > 
> > Thanks,
> > Tony

