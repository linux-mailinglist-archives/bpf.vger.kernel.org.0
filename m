Return-Path: <bpf+bounces-31898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BAF9047FA
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 02:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847D5B21A86
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 00:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0109137E;
	Wed, 12 Jun 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boB711I9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D9391;
	Wed, 12 Jun 2024 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718151530; cv=none; b=Xz9Bm0In+2ewSPe2L6H+grGzft/1EPw9kxhT8j73lAwKsZnXNG7JJprSmSNBMdVnyr3eIQavk9nWBPg7ax4VjPgrdFlJjCn2IwhW+78gOVJIV4cFfGVCdDoFjYOYVxXDxRKAaQyTUWo+MckiU2aJITro2Fy8vADJ03zvlOhXJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718151530; c=relaxed/simple;
	bh=L7soVOkoHX+oYNseA8nyqLLLM4f6KK+d0gaGGxkQCzg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgxlASgO62C+RDTsvJaLJHCc0cypw02+njSAHagn4IT9QoaPwgMO7oCeY/C/p6gN+tS/7HEZ99/swp6B5TE++FFuQK0OS61+is0O/mDxt6T3viLBZRYRCVd3Lbbylv2OqgCjg39rG1966lkme6D1CaaxXd4e3BMqqjuW4IXoAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boB711I9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7024d571d8eso1417662b3a.0;
        Tue, 11 Jun 2024 17:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718151528; x=1718756328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Pb2Odq+F4P6ARiK81c++HGzpoPMo2bMulu5gxz3ZZA=;
        b=boB711I9ZT1KAHWYFGgVKv4xTEqrc+mdjS5e91gEIiwL/SfgRGfe+jjqqcRqLxYfId
         LADLKbjnH12zy3R8GYfzbHSheg8uB11+1QK1thvACYLvs7pcoPcWLLC/XBir2bemwH7t
         dmbTMlVCynxYrE8b2WFeW+HNgxBjBFzvXw3EQXUkbbK/2NFXVs/JKxbuRVngs6RwGyHQ
         LMhEZxjit6J6bpLbVKpr5woMr/tqCX/KwF6Zo1gDAvkQ54bYyI3/krEguTEJIQTLYIIO
         tcXgbqOgT6v4S9L+vDzZXjsJ8RhlgDp6+1kuFV6fSoEvnbUYCm5xeHhZt8z2F2K/ryXG
         aLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718151528; x=1718756328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Pb2Odq+F4P6ARiK81c++HGzpoPMo2bMulu5gxz3ZZA=;
        b=WHZaIO9xHThqHpAyzDF2tfsQ5WtCvK5A4D2yWG5Sz6ECIZNK/9iUvyJUhM/NRLzsdK
         bWs/wu4oJmv8xNyUwbpv5Y2d/Zu1efXRwAO8+/nCqC9BTOyvpqkn/5riqJ03oc4DJqsJ
         KRUEiZGMHiuYXjvp5jWYRbTWPwFx7hC7YC659bzbD9MorZJaRx/LCSc0vfFXkUYtFQiH
         AiKLFSgMEddHKlVAUeNSiR+crO2Ren4fVEMdNT+Okj12+1ukD1FW26M0s8GvYfTx1ATI
         yiX2fv1dkMZePIF2phWY4x599qTEgGaUliBNFUpHoiHV7mh0onio6lIMA6EFIJeo0COo
         5vcw==
X-Forwarded-Encrypted: i=1; AJvYcCUe83CneSitWknuBv8alQu2sX/ZrDCD+d26btLkw3nXhvZBvdGIbTyrbPWoKb/2DzLZjAZRwpZQROOsfRaoDitsdh2OP8Dw2pdnwLlb5DhHP7f1cNxA9mWgIS4D1g==
X-Gm-Message-State: AOJu0Yz344bmUDUnoZLOr25456cHqXL5NvhE444kJnVQUBWaj+0En2lz
	s75FTMVbYGI3ZrbLjkOGBiIxP/x4No6o6fHgseO9IFiFxznfpkG8e3G1/5u7
X-Google-Smtp-Source: AGHT+IGXT/jx1ktzt/CoSZjJtkLVCxzzMfR6Tp4t/2qEcCDfoiY03INxAey/jbxDe1cOpF3SWDMiPA==
X-Received: by 2002:a05:6a00:4b09:b0:704:6ea0:2bba with SMTP id d2e1a72fcca58-705bcdee282mr620635b3a.4.1718151527904;
        Tue, 11 Jun 2024 17:18:47 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70595d901f2sm4235100b3a.211.2024.06.11.17.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 17:18:47 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Tue, 11 Jun 2024 17:18:45 -0700
To: Mark Wielaard <mark@klomp.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ying Huang <ying.huang@oss.cipunited.com>,
	elfutils-devel@sourceware.org, Hengqi Chen <hengqi.chen@gmail.com>,
	bpf@vger.kernel.org, dwarves@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: elfutils DWARF problem was: Re: Problem with BTF generation on
 mips64el
Message-ID: <ZmjpZY2kgEgYDV9j@kodidev-ubuntu>
References: <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
 <Zln1kZnu2Xxeyngj@x1>
 <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu>
 <Zl3Zp5r9m6X_i_J4@x1>
 <Zl4AHfG6Gg5Htdgc@x1>
 <20240603191833.GD4421@gnu.wildebeest.org>
 <Zl6OTJXw0LH6uWIN@kodidev-ubuntu>
 <Zmfwhn6inA2m1ftm@kodidev-ubuntu>
 <45651efb5698e8247e5d056aed7ac522a04b1056.camel@klomp.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45651efb5698e8247e5d056aed7ac522a04b1056.camel@klomp.org>

On Tue, Jun 11, 2024 at 03:07:29PM +0200, Mark Wielaard wrote:
> Hi,
> 
> Adding elfutils-devel to CC to keep everyone up to date on the state of
> the patches.
> 
> On Mon, 2024-06-10 at 23:36 -0700, Tony Ambardar wrote:
> > On Mon, Jun 03, 2024 at 08:47:24PM -0700, Tony Ambardar wrote:
> > > On Mon, Jun 03, 2024 at 09:18:33PM +0200, Mark Wielaard wrote:
> > > > On Mon, Jun 03, 2024 at 02:40:45PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Couldn't find a way to ask eu-readelf for more verbose output, where we
> > > > > could perhaps get some clue as to why it produces nothing while binutils
> > > > > readelf manages to grok it, Mark, do you know some other way to ask
> > > > > eu-readelf to produce more debug output?
> > > > > 
> > > > > I'm unsure if the netdevsim.ko file was left in a semi encoded BTF state
> > > > > that then made eu-readelf to not be able to process it while pahole,
> > > > > that uses eltuils' libraries, was able to process the first two CUs for
> > > > > a kernel module and all the CUs for the vmlinux file :-\
> > > > > 
> > > > > Mark, the whole thread is available at:
> > > > > 
> > > > > https://lore.kernel.org/all/Zl3Zp5r9m6X_i_J4@x1/T/#u
> > > > 
> > > > I haven't looked at the vmlinux file. But for the .ko file the issue
> > > > is that the elfutils MIPS backend isn't complete. Specifically MIPS
> > > > relocations aren't recognized (and so cannot be applied). There are
> > > > some pending patches which try to fix that:
> > > > 
> > > > https://patchwork.sourceware.org/project/elfutils/list/?series=31601
> > > 
> > > Earlier in the thread, Hengqi Chen pointed out the latest elfutils backend
> > > work for MIPS, and I locally rebuilt elfutils and then pahole from their
> > > respective next/main branches. For elfutils, main (935ee131cf7c) includes
> > > 
> > >   e259f126 Support Mips architecture
> > >   f2acb069 stack: Fix stack unwind failure on mips
> > >   db33cb0c backends: Add register_info, return_value_location, core_note mips
> > > 
> > > which partially applies the patchwork series but leaves out the support for
> > > readelf, strip, and elflint.
> > > 
> > > I believe this means the vmlinux and .ko files I shared are OK, or is there
> > > more backend work needed for MIPS?
> > > 
> > > The bits missing in eu-readelf would explain the blank output both Arnaldo
> > > and I see from "$ eu-readelf -winfo vmlinux". I tried rebuilding with the
> > > patchwork readelf patch locally but ran into merge conflicts.
> > 
> > A short update, starting with answering my own question.
> > 
> > No, apparently the above commits *do not* complete the backend work. Ying
> > Huang submitted additional related patches since March 5: [1][2]
> > 
> >     strip: Adapt src/strip -o -f on mips
> >     readelf: Adapt src/readelf -h/-S/-r/-w/-l/-d/-a on mips
> >     elflint: adapt src/elflint --gnu src/nm on mips
> >     test: Add mips in run-allregs.sh and run-readelf-mixed-corenote.sh
> > 
> > Despite the titles, these patches do include core backend changes for MIPS.
> > I resolved the various merge conflicts [3], rebuilt elfutils, and retested
> > kernel builds to now find:
> > 
> >   - pahole is able to read DWARF[45] info and create .BTF for modules
> >   - resolve_btfids can successfully patch .BTF_ids in modules
> >   - kernel successfully loads modules with BTF and kfuncs (tested 6.6 LTS)
> > 
> > Huzzah!
> > 
> > 
> > Ying:
> > 
> > Thank you for developing these MIPS patches. In your view, are the MIPS
> > changes now complete, or do you plan further updates that might improve or
> > impact parsing DWARF debug/reloc info in apps like pahole?
> > 
> > 
> > Mark:
> > 
> > Given that BTF usage on Linux/MIPS is basically broken without these
> > patches, could I request some of your review time for them to be merged? If
> > it's helpful, my branch [3] includes all patches with conflicts fixed, and
> > I also successfully ran the elfutils self-tests (including MIPS from Ying).
> > Please feel free to add for these patches:
> > 
> >     Tested-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> 
> Yes, I would very much like to integrate the rest of these patches. But
> I keep running out of time. The main issues were that, as you noticed,
> the patches mix backend and frontend tool changes a bit. I don't have
> access to a MIPS system to test them on. There are a couple of
> different MIPS abis (I believe all combinations of 32/64 bit and
> big/little endianness), but people have only tested on mips64le (maybe
> that is the only relevant one these days?) And finally the way MIPS
> represents relocations is slightly different than any other ELF
> architecture does. So we have to translate that somewhere to make the
> standards functions work. I have to convince myself that doing that in
> elf_getdata as the patches do is the right place.
> 

Glad to hear there's strong interest. Not much I can add to the code
structure discussion but I *can* confirm my testing included both
mips64el and mips32be, specifically to improve word-size/endianness
coverage. The former is supported by Debian, while the latter can still
be found on many embedded devices like consumer routers. If you need
additional testing for review/merge I can help with that (using
OpenWrt/QEMU primarily).

> > Many thanks everyone for your help,
> > Tony
> > 
> > [1]: https://patchwork.sourceware.org/project/elfutils/list/?series=31601
> > [2]: https://patchwork.sourceware.org/project/elfutils/list/?series=34310
> > [3]:
> > https://github.com/guidosarducci/elfutils/commits/main-fix-mips-support-reloc/
> 

