Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F078305154
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 05:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbhA0EpM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 23:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392490AbhA0Bmz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 20:42:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40B5E2054F;
        Wed, 27 Jan 2021 01:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611711731;
        bh=q3fl+AqaHUpl8oSKS49a3q3xuvlYipyvIkNT2pZDOrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBGqrUEydgRCZJ+E31IPdkBBQwZdsH3lcJCY4Pqg39e7u0CJOfyDe5++yY4AqbJEF
         f4eJwi+sl4a4WRTDH/Gu7eumWD0omDzdeOedDHdYAwKyCw4gQB9ksrPm8xHSrDaVVG
         a7/wxeP0+YtpWkRhCoCrQMozFPL5gMF6Xm4v5z5NtWyMbKSkoqXd7wm/JBVAbLc4Ao
         4a5ZIHf4461aMICcwGmrKDPCCIi2uF86DQyTSpHUUjL5Hva/C8AZI7ClBAhp8WjWx8
         EiwOsqigWvb+tP3mqW0RzYD70pPK/6cLSDgjWtt12t3Z5jmnoGA9Of2LTy+afXq+KR
         Iq5tTj7sYQd2g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A90A840513; Tue, 26 Jan 2021 22:42:08 -0300 (-03)
Date:   Tue, 26 Jan 2021 22:42:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Giuliano Procida <gprocida@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, dwarves@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Matthias =?iso-8859-1?Q?M=E4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves 0/4] BTF ELF writing changes
Message-ID: <20210127014208.GD106434@kernel.org>
References: <20210125130625.2030186-1-gprocida@google.com>
 <20210126195542.GB120879@krava>
 <CAGvU0H=CFBmGeNx_4zJt9ou8r31knPcq0doOi-3p5JqnaQbp7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGvU0H=CFBmGeNx_4zJt9ou8r31knPcq0doOi-3p5JqnaQbp7w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jan 27, 2021 at 01:10:40AM +0000, Giuliano Procida escreveu:
> Hi.
> 
> On Tue, 26 Jan 2021 at 19:56, Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Jan 25, 2021 at 01:06:21PM +0000, Giuliano Procida wrote:
> > > Hi.
> > >
> > > This follows on from my change to improve the error handling around
> > > llvm-objcopy in libbtf.c.
> > >
> > > Note on recipients: Please let me know if I should adjust To or CC.
> > >
> > > Note on style: I've generally placed declarations as allowed by C99,
> > > closest to point of use. Let me know if you'd prefer otherwise.
> > >
> > > 1. Improve ELF error reporting
> > >
> > > 2. Add .BTF section using libelf
> > >
> > > This shows the minimal amount of code needed to drive libelf. However,
> > > it leaves layout up to libelf, which is almost certainly not wanted.
> > >
> > > As an unexpcted side-effect, vmlinux is larger than before. It seems
> > > llvm-objcopy likes to trim down .strtab.
> > >
> > > 3. Manually lay out updated ELF sections
> > >
> > > This does full layout of new and updated ELF sections. If the update
> > > ELF sections were not the last ones in the file by offset, then it can
> > > leave gaps between sections.
> > >
> > > 4. Align .BTF section to 8 bytes
> > >
> > > This was my original aim.
> > >
> > > Regards.
> > >
> > > Giuliano Procida (4):
> > >   btf_encoder: Improve ELF error reporting
> > >   btf_encoder: Add .BTF section using libelf
> > >   btf_encoder: Manually lay out updated ELF sections
> > >   btf_encoder: Align .BTF section to 8 bytes
> >
> > hi,
> > I can't apply this on dwarves git master, which commit is it based on?
> >
> 
> It's based on:
> https://www.spinics.net/lists/dwarves/msg00775.html (0/3)
> https://www.spinics.net/lists/dwarves/msg00774.html (1/3, unrelated fix)
> https://www.spinics.net/lists/dwarves/msg00773.html (2/3, this is the
> one you'll need for a clean git am; obsoleted by this new series)
> (3/3 was abandoned)
> 
> Arnaldo did say the two commits were applied... but perhaps they
> haven't been pushed to public master yet.

I pushed what I have now, please check if anything is missing.

I'm now working on DWARF4's DW_AT_data_bit_offset, that gcc uses when
dwarf-5 is asked for, I should have something usable tomorrow and
hopefully this will be the last stuff to get into 1.20.

dd

thanks,

- Arnaldo
 
> > thanks,
> > jirka
> >
> 
> You're welcome.
> Giuliano.
> 
> > >
> > >  libbtf.c | 222 +++++++++++++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 175 insertions(+), 47 deletions(-)
> > >
> > > --
> > > 2.30.0.280.ga3ce27912f-goog
> > >
> >

-- 

- Arnaldo
