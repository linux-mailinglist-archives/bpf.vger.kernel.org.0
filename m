Return-Path: <bpf+bounces-49707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2AA1BD1B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 21:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B817A560A
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 20:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9DF224AFC;
	Fri, 24 Jan 2025 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIdU02w/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFD155726;
	Fri, 24 Jan 2025 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749077; cv=none; b=MS67yHNzXrYM+hqUZK9oh0Wt4e96i4SY5edVHnWgENFDTmmEiOHr2xhJOsak8rywrOQpn0NelRzebLL5TxQQDr6E3vVIN3C13VqhQomKGRdvhwbisVbsWGED/d3W2AKzVJ3Tp54cOGhVDbLoSKtSzFjKIUY51Lnr3Q8P34IDEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749077; c=relaxed/simple;
	bh=p4c8+EXEqWoOgOD9nyaPz0HgC7LOqV8Qkb8hvEJjQBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8Qmyzj88bRHc8zGx47LazPkBmsnAhluixHKXA/13IsJ3PwzGkh2vIel6QUnDRrTuRnM3xQidtX+WAmMUuMWp4LHYCy/ZEklNDYjRJ/ybxzy556NId8+FemxoKOxqmEOKRtQlxCYzbafpH4kQguuEtjdPE5C5xkvEbnpm3lRX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIdU02w/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94338C4CED2;
	Fri, 24 Jan 2025 20:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737749076;
	bh=p4c8+EXEqWoOgOD9nyaPz0HgC7LOqV8Qkb8hvEJjQBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIdU02w/ne0Uz0CNL2H4xsPGqHa065XBTLtSudAZgwqTt7AhIVuta7xzMUDZiCw7e
	 F8nvkBMhHW6QoRil+uj+4q81Iu8QbwcYSTeEXMK1Urvi7npQG8qyol8KHP20YmG9aC
	 aHA5xeJ/JLgzWZ2c31Gmw9D81SvJQwhGVSq6WpD2qrD9ZL6YkFeBr9JHt+NkUg5eMW
	 jkOPjUpttEnQrwoPtatNbS9BBml0d9zhE2uhP3khoO+nPJpnObrSPKTPkxgECB88aZ
	 gBVp4bUDGkNCqTOTIzDNgGnnUKccBZWx/MmlQe2MJtRuxmCrPVfcgUlxisQkqEPqEi
	 D0rpUs4Lu3jxQ==
Date: Fri, 24 Jan 2025 21:04:26 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jinghao Jia <jinghao7@illinois.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <n.schier@avm.de>, Ruowen Qin <ruqin@redhat.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] samples/{bpf,hid}: fix broken vmlinux path
 for VMLINUX_BTF
Message-ID: <2sxhtfdzspkn5umtfpxiueb67v4jhl3nad6i66qtfry52o7sip@nm5oeplybppa>
References: <20250123081950.173588-1-jinghao7@illinois.edu>
 <20250123081950.173588-3-jinghao7@illinois.edu>
 <CAEf4BzbCm4=NLV4DOyRxvxEtZUONzqmXBOFMp5cg=4hPEEYUtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbCm4=NLV4DOyRxvxEtZUONzqmXBOFMp5cg=4hPEEYUtA@mail.gmail.com>

On Jan 24 2025, Andrii Nakryiko wrote:
> On Thu, Jan 23, 2025 at 12:20 AM Jinghao Jia <jinghao7@illinois.edu> wrote:
> >
> > Commit 13b25489b6f8 ("kbuild: change working directory to external
> > module directory with M=") changed kbuild working directory of bpf and
> > hid samples to samples/{bpf,hid}, which broke the vmlinux path for
> > VMLINUX_BTF, as the Makefiles assume the current work directory to be
> > the kernel output directory and use a relative path (i.e., ./vmlinux):
> >
> >   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
> >
> > Correctly refer to the kernel output directory using $(objtree).
> >
> > Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> > Tested-by: Ruowen Qin <ruqin@redhat.com>
> > Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> > ---
> >  samples/bpf/Makefile | 2 +-
> >  samples/hid/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> 
> can you please split samples/bpf from samples/hid changes, so we can
> land samples/bpf fix through bpf-next tree independently from other
> changes?

FWIW, I don't mind if this goes through the bpf-next tree all at once.

Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

> 
> pw-bot: cr
> 
> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index 96a05e70ace3..f5865fbbae62 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
> >
> >  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
> >                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
> > -                    $(abspath ./vmlinux)
> > +                    $(abspath $(objtree)/vmlinux)
> >  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
> >
> >  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> > diff --git a/samples/hid/Makefile b/samples/hid/Makefile
> > index 69159c81d045..db5a077c77fc 100644
> > --- a/samples/hid/Makefile
> > +++ b/samples/hid/Makefile
> > @@ -164,7 +164,7 @@ $(obj)/hid_surface_dial.o: $(obj)/hid_surface_dial.skel.h
> >
> >  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
> >                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
> > -                    $(abspath ./vmlinux)
> > +                    $(abspath $(objtree)/vmlinux)
> >  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
> >
> >  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> > --
> > 2.48.1
> >

