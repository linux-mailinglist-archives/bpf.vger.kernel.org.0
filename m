Return-Path: <bpf+bounces-31185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F48D7E5B
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8CC1F260E4
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756C27D096;
	Mon,  3 Jun 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfmpfG5Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69976F17;
	Mon,  3 Jun 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406343; cv=none; b=Xl4363aoEFSdE83shYCf0R7bMGi6d+a9fh3PGbqvOhkuc5wyq4n/LawPAbHsX/vlgtY+XfsSV0+RIkR9fknvpFAIZZ5wNU0VGOKkUPLrUyEE7EFjSZLtwQ1aVTr2kF7xsz4yJYPm1EepnFWnPNXK0xNkuaAgyVEWsdUOTuJGqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406343; c=relaxed/simple;
	bh=M5amW5mEH9w2SYAkHwHaM91S64DHLfJRZ1yJvpffb/Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTIwsmw+8D7TjEGV/TEgHlvmmOQJKiC9X3lcVjRjoXPKf7oTnMptFrlm3r2X6kNqzlWMUIN75CPqVT7dkyXRJprMUtXGXpN6uUvfKGXAqULag44HME5MBugykwl8XVaY6XUZupanJ27qxR2esbbGFkMFdLOfoQAySmKVPAOFwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfmpfG5Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42139c66027so8558155e9.3;
        Mon, 03 Jun 2024 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717406339; x=1718011139; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uOYHHw0T0q5arPSe4X67QFZeeKrh4ux45pmxg6IiL9w=;
        b=QfmpfG5Yt5s7citrrfLlzjCcQ4ZOKsSXqV/VAqZkdV3muHqVasBSCOpnwXqhysd7Yg
         Cfy2s38349h4EQzym6M0kmHaj85Lnf2MGqstQ8fzNpw82sQm24PL2qP0/bTkIrjGOgxb
         pZ4K9PSFr1a81auys9cEHWhO2YZIIPkN7ABX0RBBwj5ILE8MoCnXnubnVcPgW4zmCX8y
         w1CT/143UvWEDA9R8r+SPh2LscezIIUx4jOngkBoIq/fYCW2rupUejfcVhT5TBKfUR1l
         SCqhYTEOnJXLkGvCy3YXF3LALT/AanArhNsPFiCZwkwzcDVaYs+6HOUw6oxYLEZ8uapf
         Dzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717406339; x=1718011139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOYHHw0T0q5arPSe4X67QFZeeKrh4ux45pmxg6IiL9w=;
        b=hXKiSOnAozEc5YkRf5QIqRImHwjwUDvFhz5zAeJhrWBQdWlsJmb4zA6NJjjswhETBF
         7/QuZSkkLCmePg6f3Gb4wngTfcxunzkrkpW/kFlXCRpUjobro8GMpZUl8i9wN6dZxsUo
         QH77FOuh+rUFRkFRthE0VrSFBVTvQn3RgECdVdBhptibARXxDveWAohtZjHgH3SS6PIz
         NJs/xNrZLDDtSVpQYi/vkmvBtrHG++BoHGe1v7LDlmUa2vtduBncAq1spM76BhiQTpnH
         zAQqTUC41XOvcniv1XEEvGDIJH8xaoRsOIZuHECUN5hQUKwQ1p9Y93tXsUeZFMEfgXWs
         J5gw==
X-Forwarded-Encrypted: i=1; AJvYcCUBp/7f3V6eUKhkhxgOscvt3SZ0iIUjza6qEy5noslmz4xU6u9Cf3jTyx7PCNgbuDQc84qn8LG4IFkAsjjyOiRuZZthlIeyP+ra0LyP6neXW8BQVzAK8s5wp9qX6Q==
X-Gm-Message-State: AOJu0YyixNRJXqHGjkkRm/fwoTo2ofrKJpL46HjOhCblpL7FGb8NgjvR
	XKQEWpt0UHYYydZBQIQf/z6PSUh+m04yCdyB66CWuUyg+35QcvPI
X-Google-Smtp-Source: AGHT+IFjC5hVoGNL6552kvVwTlLLjuFVzW3zAZ91UH5X7jGb12DxFkC0l7fXdRIRdqz/uFmq7a+HFw==
X-Received: by 2002:a05:600c:4454:b0:420:18e9:86d5 with SMTP id 5b1f17b1804b1-4212e047556mr77153815e9.10.1717406339171;
        Mon, 03 Jun 2024 02:18:59 -0700 (PDT)
Received: from krava ([83.240.61.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b838b55sm111294155e9.5.2024.06.03.02.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 02:18:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 3 Jun 2024 11:18:51 +0200
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Hengqi Chen <hengqi.chen@gmail.com>,
	bpf@vger.kernel.org, dwarves@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <Zl2Ke7K2CAT2cAPa@krava>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmGoT9KiYLZd91S@krava>
 <Zlm2UNWHrGtRROGS@kodidev-ubuntu>
 <Zlnc_Kkd2o6ADgkO@krava>
 <Zl2GtXy7+Xfr66lX@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl2GtXy7+Xfr66lX@kodidev-ubuntu>

On Mon, Jun 03, 2024 at 02:02:45AM -0700, Tony Ambardar wrote:
> On Fri, May 31, 2024 at 04:21:48PM +0200, Jiri Olsa wrote:
> > On Fri, May 31, 2024 at 04:36:48AM -0700, Tony Ambardar wrote:
> > > Hi Jiri,
> > > 
> > > On Fri, May 31, 2024 at 10:13:21AM +0200, Jiri Olsa wrote:
> > > > On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> > > > > Hi Tony,
> > > > > 
> > > > > On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > For some time now I'm seeing multiple issues during BTF generation while
> > > > > > building recent kernels targeting mips64el, and would appreciate some help
> > > > > > to understand and fix the problems.
> > > > > >
> > > > > > Some relate to resolve_btfids:
> > > > > >
> > > > > > >   LD      vmlinux
> > > > > > >   BTFIDS  vmlinux
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_session_cookie
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_key_put
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> > > > > > > WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> > > > > > >   NM      System.map
> > > > > > >   SORTTAB vmlinux
> > > > > > >   OBJCOPY vmlinux.32
> > > > > >
> > > > > > These do not appear to be #ifdef-related and have similar past reports [1].
> > > > 
> > > > I can reproduce the warning just for bpf_session_cookie,
> > > > which has fix in progress:
> > > >   https://lore.kernel.org/bpf/20240531071557.MvfIqkn7@linutronix.de/T/#t
> > > 
> > > I gather there are different root causes for these warnings. From the link,
> > > the issue with bpf_session_cookie seems related to conditional compilation,
> > > which have come up before on the mailing list IIRC.
> > > 
> > > In comparison, consider my above warning for bpf_key_put, which is defined
> > > in kernel/trace/bpf_trace.c. This kfunc is guarded by CONFIG_KEY, which is
> > > enabled in my config and so not the issue. I can in fact see the global
> > > text symbol for bpf_key_put in bpf_trace.o, but not in vmlinux.
> > 
> > yes, that would be a problem, the resolve_btfids goes through the BTF
> > lists and needs to resolve the function in vmlinux, when it's not there,
> > it will output the warning above
> > 
> > > 
> > > So I suspect the warnings might come from linker or optimization problems,
> > > or perhaps even an issue related to the __bpf_kfunc annotation. WDYT?
> > 
> > I can reproduce now resolve_btfids warnings:
> > 
> 
> That's great to hear! Did you also use mips64el? And were you able to see

nope, just mips64, couldn't find mips64el on fedora

> the various "die__proc:" errors from pahole during BTF generation?

yep, I can see them as well

> 
> >   LD      vmlinux
> >   BTFIDS  vmlinux
> > WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> > WARN: resolve_btfids: unresolved symbol bpf_session_is_return
> > WARN: resolve_btfids: unresolved symbol bpf_session_cookie
> > WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> > WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> > WARN: resolve_btfids: unresolved symbol bpf_key_put
> > WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> > WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> > WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> > WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> > WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> > WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> > WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> > WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> > 
> > when I call bpf_key_put to make it 'used' it stays in vmlinux, so I wonder
> > the __bpf_kfunc flags do not work properly on this cross compile chain..
> > and linker just optimize it away?
> 
> Yes, I verified the problem occurs during link-time garbage cleaning, when
> LTO is enabled through e.g. LD_DEAD_CODE_DATA_ELIMINATION=y.
> 
> > 
> > #define __bpf_kfunc __used noinline
> > 
> 
> After researching, I believe this isn't a mips problem specifically, rather
> the __bpf_kfunc tag only partly works. It appears the __used macro works at
> the compiler and IR-level but is ignored by the linker. I have a working
> fix that also handles the linker level, so I'll post the patches shortly.

great, I was wondering how to fix that

thanks,
jirka

> 
> Unfortunately, that still leaves the pahole errors generating BTF, which
> are serious as they seem to break module loading.
> 
> > thanks,
> > jirka
> 
> Cheers,
> Tony
> > 
> > > 
> > > > 
> > > > > >
> > > > > > I also see many pahole failures during BTF encoding of modules, such as:
> > > > > >
> > > > > > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > > > > > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > > > > > >   CC [M]  net/psample/psample.mod.o
> > > > > > >   LD [M]  crypto/cmac.ko
> > > > > > >   BTF [M] crypto/cmac.ko
> > > > > > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > > > > > or DW_TAG_skeleton_unit expected got member (0xd)!
> > > > > 
> > > > > The issue seems to be related to elfutils. Have you tried build from
> > > > > the latest elfutils source ?
> > > > > I saw the latest MIPS backend in elfutils already implemented the
> > > > > reloc_simple_type hook.
> > > > 
> > > > hi,
> > > > +1, could you also check the pahole version you used?
> > > 
> > > No luck I'm afraid with using the latest elfutils as suggested.
> > > 
> > > I used pahole v1.26 in my original testing for this bug report, as noted
> > > below (might have been buried a bit).
> > > 
> > > > 
> > > > jirka
> > > > 
> > > > SNIP
> > > >
> > > > > > Details of the git commit and build environment are as follows:
> > > > > >
> > > > > > > $ git log -1 --oneline  bpf/master
> > > > > > > 9dfdb706e164 (bpf/master) selftests/bpf: fix inet_csk_accept prototype in
> > > > > > > test_sk_storage_tracing.c
> > > > > > >
> > > > > > > $ lsb_release -a
> > > > > > > Description:    Ubuntu 22.04.4 LTS
> > > > > > >
> > > > > > > $ cat gcc-compile.txt
> > > > > > > ARCH=mips CROSS_COMPILE=mips64el-linux-gnuabi64- CC="ccache ${CROSS_COMPILE}gcc" make -j6
> > > > > > >
> > > > > > > $ mips64el-linux-gnuabi64-gcc --version
> > > > > > > mips64el-linux-gnuabi64-gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0
> > > > > > >
> > > > > > > $ mips64el-linux-gnuabi64-ld --version
> > > > > > > GNU ld (GNU Binutils for Ubuntu) 2.38
> > > > > > >
> > > > > > > $ pahole --version
> > > > > > > v1.26
> > > > 
> > > > SNIP
> > > >
> > > > > > I'd be grateful if some of the BTF/pahole experts could please review this
> > > > > > issue and share next steps or other details I might provide.
> > > > > >
> > > > > > Thanks,
> > > > > > Tony Ambardar
> > > > > >
> > > > > > Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1]
> > > > > > Link: https://github.com/acmel/dwarves/issues/45 [2]
> > > > > 
> > > > > Cheers,
> > > > > Hengqi
> > > 
> > > Thanks,
> > > Tony

