Return-Path: <bpf+bounces-31031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E398D6459
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752561F27690
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402D18C22;
	Fri, 31 May 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fke6JQ1y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E43848D;
	Fri, 31 May 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165314; cv=none; b=HDs01QG4mPUIdF4wzpZ9sz1LyirkBYtT2+2u/FM3EwhMFw9pvG8uPmNvSXpOZKebJEVuSDhFCSLM10HPbpRS464sykDoa6LkAeNG82dswpgsgDQc7roN7a0MaHRlkGVB+IGL2PevEEGohjRK6ZZ33qaP+GUPnQejVeipXmNW/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165314; c=relaxed/simple;
	bh=8nEyMcmOODdeONTsC8wpVc94p9KoyJfbS8L/Ynv2Hhk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ2ltyA20UKI2gaPs4oCkM+ippCPDGDTHlviIPLv3m38jB0ZqXToEkMG0QBxyaZl1Ip9cmWiuVx3/ihijl49o0e78/cg8dhF1n/Q74jm6ndtKzVCfU+C+Oszjvav5wA4jK44QoQK1WDeZYtNCGOqUi0urmg14WA7B8AHgViEOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fke6JQ1y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5785f7347cdso2211863a12.0;
        Fri, 31 May 2024 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717165311; x=1717770111; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pomN/Xpb8FWb9W5YcIsXIJHRyYmucfPDfmz7UT/s81k=;
        b=fke6JQ1y5W29hs0g5PQGywiV8vH0wgZlxXgkPIytnM+qkiby6pNrOG/J+58oUY9O1W
         VAKJ3bOku7bjZN8Wry5aKdSE1Q6ZZqHZWzYRJvRmWFYmb7tHrWJP0gC2oUcidDeYnGcB
         RDWogUcwtTZg3Xgm/XmSlWgJYBvjfNQqkgXnnGfZ2tevXA0mWpM5EUO0fNL3aSkmW+XJ
         f4Q0GkF8pnGCvFYwjOhg449o5m2LmQLK+IBpDDw8ECqmR0R9nMGbGDOxIT9j0avjCGI8
         J/gNAmqSv85wUBn43gRoVzKO2keACqlCxR5QWkpAPmTHZ2TdHKaQWqiMCf85TC+pFye8
         Fw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717165311; x=1717770111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pomN/Xpb8FWb9W5YcIsXIJHRyYmucfPDfmz7UT/s81k=;
        b=QBdxwYGw7l8i+wXgyLO1GtNi7o24sWU6/TmMFueK+qOLWlAQ3M7IWfCZ4H6+3GETbN
         aVlY1NxaM67TsEt6EQkyaCB772BFvhtyNHJ7TuvRtnY1IZ+LkK0NNbSTykcAW0OK+lk0
         Y+XpdrjIuVSdPq9kQ9h4GyDLiZLoKFN7xLTnsLJ2kO+xqKrCNBKteKGfWJw2VjuPa7em
         3KWfBR/ItZO2J1PGxfsthk+i0WDmFfybolvkSVvNgV1WssUbTGQn+hLbn8pbB1TyjsEa
         DhkopZNl/m+jRhUWV6FBUr1Lv7b2Gwcn3NyPEuu6VGdDPiga+AdwIu9X/AOraQqEcIcZ
         1s0A==
X-Forwarded-Encrypted: i=1; AJvYcCXQHhKlsVGsHub5g6dvx9nj+goG65rw3dxFXkAz2e7OJJoTjdyu/OR6INlhb9n9DFEcG1M9no6uXaOrBCg5AKq4FUY2FyauEYLQjaCsbDcwoXWd4iC6KzKcoDKMgw==
X-Gm-Message-State: AOJu0Yyv7mSEnGnURiFr4dQU5u9xn4oRwFExNO7Pny5g5WKpPDVWJCvY
	Ycq1TFWL2P9ufdmQ47C9yMFzrq5ZneTEBgNj8ph9SuTRx+flVteGmeN4kg==
X-Google-Smtp-Source: AGHT+IEdXgW242Z55RqPRhsU1BQxlRoYArOwcgQ43rDC35kpI+4v/jqAi4NAjE2RpAluKwGZFvYqOA==
X-Received: by 2002:a17:906:158c:b0:a66:c400:ff22 with SMTP id a640c23a62f3a-a681f87e614mr139455566b.5.1717165310608;
        Fri, 31 May 2024 07:21:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a685e3cccd4sm63492966b.179.2024.05.31.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 07:21:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 31 May 2024 16:21:48 +0200
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Hengqi Chen <hengqi.chen@gmail.com>,
	bpf@vger.kernel.org, dwarves@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <Zlnc_Kkd2o6ADgkO@krava>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmGoT9KiYLZd91S@krava>
 <Zlm2UNWHrGtRROGS@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zlm2UNWHrGtRROGS@kodidev-ubuntu>

On Fri, May 31, 2024 at 04:36:48AM -0700, Tony Ambardar wrote:
> Hi Jiri,
> 
> On Fri, May 31, 2024 at 10:13:21AM +0200, Jiri Olsa wrote:
> > On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> > > Hi Tony,
> > > 
> > > On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > For some time now I'm seeing multiple issues during BTF generation while
> > > > building recent kernels targeting mips64el, and would appreciate some help
> > > > to understand and fix the problems.
> > > >
> > > > Some relate to resolve_btfids:
> > > >
> > > > >   LD      vmlinux
> > > > >   BTFIDS  vmlinux
> > > > > WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> > > > > WARN: resolve_btfids: unresolved symbol bpf_session_cookie
> > > > > WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> > > > > WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> > > > > WARN: resolve_btfids: unresolved symbol bpf_key_put
> > > > > WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> > > > > WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> > > > > WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> > > > > WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> > > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> > > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> > > > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> > > > > WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> > > > >   NM      System.map
> > > > >   SORTTAB vmlinux
> > > > >   OBJCOPY vmlinux.32
> > > >
> > > > These do not appear to be #ifdef-related and have similar past reports [1].
> > 
> > I can reproduce the warning just for bpf_session_cookie,
> > which has fix in progress:
> >   https://lore.kernel.org/bpf/20240531071557.MvfIqkn7@linutronix.de/T/#t
> 
> I gather there are different root causes for these warnings. From the link,
> the issue with bpf_session_cookie seems related to conditional compilation,
> which have come up before on the mailing list IIRC.
> 
> In comparison, consider my above warning for bpf_key_put, which is defined
> in kernel/trace/bpf_trace.c. This kfunc is guarded by CONFIG_KEY, which is
> enabled in my config and so not the issue. I can in fact see the global
> text symbol for bpf_key_put in bpf_trace.o, but not in vmlinux.

yes, that would be a problem, the resolve_btfids goes through the BTF
lists and needs to resolve the function in vmlinux, when it's not there,
it will output the warning above

> 
> So I suspect the warnings might come from linker or optimization problems,
> or perhaps even an issue related to the __bpf_kfunc annotation. WDYT?

I can reproduce now resolve_btfids warnings:

  LD      vmlinux
  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
WARN: resolve_btfids: unresolved symbol bpf_session_is_return
WARN: resolve_btfids: unresolved symbol bpf_session_cookie
WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
WARN: resolve_btfids: unresolved symbol bpf_key_put
WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages

when I call bpf_key_put to make it 'used' it stays in vmlinux, so I wonder
the __bpf_kfunc flags do not work properly on this cross compile chain..
and linker just optimize it away?

#define __bpf_kfunc __used noinline

thanks,
jirka

> 
> > 
> > > >
> > > > I also see many pahole failures during BTF encoding of modules, such as:
> > > >
> > > > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > > > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > > > >   CC [M]  net/psample/psample.mod.o
> > > > >   LD [M]  crypto/cmac.ko
> > > > >   BTF [M] crypto/cmac.ko
> > > > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > > > or DW_TAG_skeleton_unit expected got member (0xd)!
> > > 
> > > The issue seems to be related to elfutils. Have you tried build from
> > > the latest elfutils source ?
> > > I saw the latest MIPS backend in elfutils already implemented the
> > > reloc_simple_type hook.
> > 
> > hi,
> > +1, could you also check the pahole version you used?
> 
> No luck I'm afraid with using the latest elfutils as suggested.
> 
> I used pahole v1.26 in my original testing for this bug report, as noted
> below (might have been buried a bit).
> 
> > 
> > jirka
> > 
> > SNIP
> >
> > > > Details of the git commit and build environment are as follows:
> > > >
> > > > > $ git log -1 --oneline  bpf/master
> > > > > 9dfdb706e164 (bpf/master) selftests/bpf: fix inet_csk_accept prototype in
> > > > > test_sk_storage_tracing.c
> > > > >
> > > > > $ lsb_release -a
> > > > > Description:    Ubuntu 22.04.4 LTS
> > > > >
> > > > > $ cat gcc-compile.txt
> > > > > ARCH=mips CROSS_COMPILE=mips64el-linux-gnuabi64- CC="ccache ${CROSS_COMPILE}gcc" make -j6
> > > > >
> > > > > $ mips64el-linux-gnuabi64-gcc --version
> > > > > mips64el-linux-gnuabi64-gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0
> > > > >
> > > > > $ mips64el-linux-gnuabi64-ld --version
> > > > > GNU ld (GNU Binutils for Ubuntu) 2.38
> > > > >
> > > > > $ pahole --version
> > > > > v1.26
> > 
> > SNIP
> >
> > > > I'd be grateful if some of the BTF/pahole experts could please review this
> > > > issue and share next steps or other details I might provide.
> > > >
> > > > Thanks,
> > > > Tony Ambardar
> > > >
> > > > Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1]
> > > > Link: https://github.com/acmel/dwarves/issues/45 [2]
> > > 
> > > Cheers,
> > > Hengqi
> 
> Thanks,
> Tony

