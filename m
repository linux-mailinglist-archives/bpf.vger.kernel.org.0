Return-Path: <bpf+bounces-6688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D672F76C7D5
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 10:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B2F1C2125D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 08:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A614553B1;
	Wed,  2 Aug 2023 08:02:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68953A6
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 08:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233E8C433C8;
	Wed,  2 Aug 2023 08:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690963371;
	bh=5Cmwg1OSJW9YIeItjL/DKDCrSrb/G35k9uKL7G8eV1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vdmy5RwAWWhTIDxBfKEk1DiYQPdPB7qwaJ0K6hNWiYPG2hIOx4SEO9uI+p+HhqJ/c
	 ffuKbMQlWE5naMPlvjDgSPB4UOET6gmHSzS5aYb9yiEMrQdMFRYekqt1eEmJ0aFUY4
	 /R7V1wiXTKW7j2h67MmwIG6J+Zer1RkfpiXnvt1d0FU1UAaOZFt12YDV3dnvvbpTI1
	 mhQijCVUdBXPN5mdJGsLXveDdG3+hheR8GbcDDuAXxK1TbylTKsYkT1ew5Wszd/n+0
	 rayjQs9I3s2nn3YLlwiMikQwiSJqSJCGlaYUjLQEysX3lGTHib9I3JDJEpRJvpVq/G
	 fJWoMRwRYe7Zw==
Date: Wed, 2 Aug 2023 17:02:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, "cc: Jiri Olsa"
 <olsajiri@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 dwarves@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, bpf
 <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: Fwd: [RESEND] BTF is not generated for gcc-built kernel with
 the latest pahole
Message-Id: <20230802170247.1f91f98ebe354608f6e8e36f@kernel.org>
In-Reply-To: <CA+JHD93MiFyJEP+1K7dAey+2d8v-az6qqwAKBgUzk9USXmmbzg@mail.gmail.com>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
	<ZMDvmLdZSLi2QqB+@krava>
	<20230726200716.609d8433a7292eead95e7330@kernel.org>
	<6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
	<20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
	<20230727105102.509161e1f57fd0b49e98b844@kernel.org>
	<c5accb4d-21d1-d8d9-85a0-263177a06208@oracle.com>
	<20230801100148.defdc4c41833054c56c53bf0@kernel.org>
	<bba3b423-8e38-ade3-7ce7-23b1be454d1f@oracle.com>
	<CA+JHD93Liq95RvfChifmnE7E9mKR42_W7rtpqgY9KAgYyGTZwQ@mail.gmail.com>
	<CA+JHD93MiFyJEP+1K7dAey+2d8v-az6qqwAKBgUzk9USXmmbzg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 1 Aug 2023 15:28:38 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> Sorry, replied only to Alan :-\
> 
> - Arnaldo
> 
> ---------- Forwarded message ---------
> From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Date: Tue, Aug 1, 2023 at 3:26 PM
> Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with
> the latest pahole
> To: Alan Maguire <alan.maguire@oracle.com>
> 
> 
> On Tue, Aug 1, 2023 at 2:37 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> > On 01/08/2023 02:01, Masami Hiramatsu (Google) wrote:
> > > On Mon, 31 Jul 2023 16:45:24 +0100
> > > Alan Maguire <alan.maguire@oracle.com> wrote:
> 
> > >> Unfortunately (or fortunately?) I haven't been able to reproduce so far
> > >> I'm afraid. I used your config and built gcc 13 from source; everything
> > >> worked as expected, with no warnings or missing functions (aside from
> > >> the ones skipped due to inconsistent prototypes etc).
> > >
> > > Yeah, so I think gcc-11.3 is suspicious too (and it seems fixed in gcc-13).
> 
> See below, but this one is interesting, gcc-13 works with
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y?

I'm using gcc-11.3, and it seems to work.

> 
> > >> One other thing I can think of - is it possible libdw[arf]/libelf
> > >> versions might be having an effect here? I'm using libdwarf.so.1.2,
> > >> libdw-0.188, libelf-0.188. I can try and match yours. Thanks!
> > >
> > > Both libdw/libelf are 0.181. I didn't install libdwarf.
> > > Hmm, I should update the libdw (elfutils) too.
> >
> > That might help. Thanks!
> 
> Probably he needs to tweak these CONFIG_ entries:
> 
> ⬢[acme@toolbox perf-tools]$ grep DWARF ../build/v6.2-rc5+/.config
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> ⬢[acme@toolbox perf-tools]$
> 
> And make it use CONFIG_DEBUG_INFO_DWARF4=y,
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=n

OK, interesting. Let me check again with DWARF4.

Thank you!

> 
> For DWARF5 I need to forward port what I have in:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=WIP-imported-unit
> 
> - Arnaldo


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

