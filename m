Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C54352AFE
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhDBN1H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 09:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234448AbhDBN1H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 09:27:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8D41610D2;
        Fri,  2 Apr 2021 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617370026;
        bh=Z4l/Sy0ejmkvR6DGKh/xjckcgDiC9qtwAG0Kff2bGiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Au76g/frwqrBdkWZPNq8A8QRcqIBldjqPc+BfEH6uBVStAYotSNY2RhePe45Bpl6R
         4sxaKmxRt0md4Bi6QmAWNFKMw1dkw53CqfEjiQsYDaPBQTjxfQlLxHKyOoL5hfq0GO
         mRMVf1GRJbYpzWjUFcr3ILAeq+5xlo335elH39XmAwMn7vy4Of47xTwINDyS09Zhn8
         e+sKJdTBD3U79nZyZQTPUoF1gBbw62tR5/WSunJEaRd/HoKhLLoDwCJbPaQu3O1X5g
         VkVnWx/geBTTcf3FwM44m8/ufLCFY93iuvABeb2hiLxltX3DaeUR76vkBditBBf3DE
         ymwiv4iJ4r0+w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D85740647; Fri,  2 Apr 2021 10:27:03 -0300 (-03)
Date:   Fri, 2 Apr 2021 10:27:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGcbp5Y+RRWzGSia@kernel.org>
References: <20210401025815.2254256-1-yhs@fb.com>
 <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Apr 01, 2021 at 12:35:45PM -0700, Bill Wendling escreveu:
> On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:

> > Function cus__merging_cu() is introduced in Commit 39227909db3c
> > ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
> > binary") to test whether cross-cu references may happen.
> > The original implementation anticipates compilation flags
> > in dwarf, but later some concerns about binary size surfaced
> > and the decision is to scan .debug_abbrev as a faster way
> > to check cross-cu references. Also putting a note in vmlinux
> > to indicate whether lto is enabled for built or not can
> > provide a much faster way.

> > This patch set implemented this two approaches, first
> > checking the note (in Patch #2), if not found, then
> > check .debug_abbrev (in Patch #1).

> > Yonghong Song (2):
> >   dwarf_loader: check .debug_abbrev for cross-cu references
> >   dwarf_loader: check .notes section for lto build info

> >  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 55 insertions(+), 21 deletions(-)

> With this series of patches, the compilation passes for me with
> ThinLTO. You may add this if you like:

> Tested-by: Bill Wendling <morbo@google.com>

Thanks, added, and also this "Committer testing" section:

Committer testing:

Using a thin-LTO built vmlinux that doesn't have the
LINUX_ELFNOTE_BUILD_LTO note:

  $ readelf --notes vmlinux.clang.thin.LTO

  Displaying notes found in: .notes
    Owner                Data size 	Description
    Xen                  0x00000006	Unknown note type: (0x00000006)
     description data: 6c 69 6e 75 78 00
    Xen                  0x00000004	Unknown note type: (0x00000007)
     description data: 32 2e 36 00
    Xen                  0x00000008	Unknown note type: (0x00000005)
     description data: 78 65 6e 2d 33 2e 30 00
    Xen                  0x00000008	Unknown note type: (0x00000003)
     description data: 00 00 00 80 ff ff ff ff
    Xen                  0x00000008	Unknown note type: (0x0000000f)
     description data: 00 00 00 00 80 00 00 00
    Xen                  0x00000008	NT_VERSION (version)
     description data: c0 e1 33 83 ff ff ff ff
    Xen                  0x00000008	NT_ARCH (architecture)
     description data: 00 20 00 81 ff ff ff ff
    Xen                  0x00000029	Unknown note type: (0x0000000a)
     description data: 21 77 72 69 74 61 62 6c 65 5f 70 61 67 65 5f 74 61 62 6c 65 73 7c 70 61 65 5f 70 67 64 69 72 5f 61 62 6f 76 65 5f 34 67 62
    Xen                  0x00000004	Unknown note type: (0x00000011)
     description data: 01 88 00 00
    Xen                  0x00000004	Unknown note type: (0x00000009)
     description data: 79 65 73 00
    Xen                  0x00000008	Unknown note type: (0x00000008)
     description data: 67 65 6e 65 72 69 63 00
    Xen                  0x00000010	Unknown note type: (0x0000000d)
     description data: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
    Xen                  0x00000004	Unknown note type: (0x0000000e)
     description data: 01 00 00 00
    Xen                  0x00000004	Unknown note type: (0x00000010)
     description data: 01 00 00 00
    Xen                  0x00000008	Unknown note type: (0x0000000c)
     description data: 00 00 00 00 00 80 ff ff
    Xen                  0x00000008	Unknown note type: (0x00000004)
     description data: 00 00 00 00 00 00 00 00
    Xen                  0x00000008	Unknown note type: (0x00000012)
     description data: e0 02 00 01 00 00 00 00
    Linux                0x00000017	OPEN
     description data: 34 2e 31 39 2e 34 2d 33 30 30 2e 66 63 32 39 2e 78 38 36 5f 36 34 00
    GNU                  0x00000014	NT_GNU_BUILD_ID (unique build ID bitstring)
      Build ID: 354f81317b1b3c35f3f81f8d9f04d0c8caccb09a
  $

Then with one with the new ELF note stating that this binary was built
with LTO:

  [acme@five pahole]$ readelf --notes vmlinux.clang.thin.LTO+ELF_note 
  
  Displaying notes found in: .notes
    Owner                Data size 	Description
    Xen                  0x00000006	Unknown note type: (0x00000006)
     description data: 6c 69 6e 75 78 00 
    Xen                  0x00000004	Unknown note type: (0x00000007)
     description data: 32 2e 36 00 
    Xen                  0x00000008	Unknown note type: (0x00000005)
     description data: 78 65 6e 2d 33 2e 30 00 
    Xen                  0x00000008	Unknown note type: (0x00000003)
     description data: 00 00 00 80 ff ff ff ff 
    Xen                  0x00000008	Unknown note type: (0x0000000f)
     description data: 00 00 00 00 80 00 00 00 
    Xen                  0x00000008	NT_VERSION (version)
     description data: c0 e1 33 83 ff ff ff ff 
    Xen                  0x00000008	NT_ARCH (architecture)
     description data: 00 20 00 81 ff ff ff ff 
    Xen                  0x00000029	Unknown note type: (0x0000000a)
     description data: 21 77 72 69 74 61 62 6c 65 5f 70 61 67 65 5f 74 61 62 6c 65 73 7c 70 61 65 5f 70 67 64 69 72 5f 61 62 6f 76 65 5f 34 67 62 
    Xen                  0x00000004	Unknown note type: (0x00000011)
     description data: 01 88 00 00 
    Xen                  0x00000004	Unknown note type: (0x00000009)
     description data: 79 65 73 00 
    Xen                  0x00000008	Unknown note type: (0x00000008)
     description data: 67 65 6e 65 72 69 63 00 
    Xen                  0x00000010	Unknown note type: (0x0000000d)
     description data: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 
    Xen                  0x00000004	Unknown note type: (0x0000000e)
     description data: 01 00 00 00 
    Xen                  0x00000004	Unknown note type: (0x00000010)
     description data: 01 00 00 00 
    Xen                  0x00000008	Unknown note type: (0x0000000c)
     description data: 00 00 00 00 00 80 ff ff 
    Xen                  0x00000008	Unknown note type: (0x00000004)
     description data: 00 00 00 00 00 00 00 00 
    Xen                  0x00000008	Unknown note type: (0x00000012)
     description data: e0 02 00 01 00 00 00 00 
    Linux                0x00000017	OPEN
     description data: 34 2e 31 39 2e 34 2d 33 30 30 2e 66 63 32 39 2e 78 38 36 5f 36 34 00 
    Linux                0x00000004	func
     description data: 01 00 00 00 
    GNU                  0x00000014	NT_GNU_BUILD_ID (unique build ID bitstring)
      Build ID: aeba9ffc929acd3cd573b4d1afc8df9af4f3694d
  $

Now to see the diff:

  $ readelf --notes vmlinux.clang.thin.LTO+ELF_note > with-note
  $ readelf --notes vmlinux.clang.thin.LTO > without-note
  $ diff -u without-note with-note 
  --- without-note	2021-04-02 10:23:57.545349084 -0300
  +++ with-note	2021-04-02 10:23:50.690196102 -0300
  @@ -37,5 +37,7 @@
      description data: e0 02 00 01 00 00 00 00 
     Linux                0x00000017	OPEN
      description data: 34 2e 31 39 2e 34 2d 33 30 30 2e 66 63 32 39 2e 78 38 36 5f 36 34 00 
  +  Linux                0x00000004	func
  +   description data: 01 00 00 00 
     GNU                  0x00000014	NT_GNU_BUILD_ID (unique build ID bitstring)
  -    Build ID: 354f81317b1b3c35f3f81f8d9f04d0c8caccb09a
  +    Build ID: aeba9ffc929acd3cd573b4d1afc8df9af4f3694d
  $

Signed-off-by: Yonghong Song <yhs@fb.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Bill Wendling <morbo@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: David Blaikie <dblaikie@gmail.com>
Cc: Fāng-ruì Sòng <maskray@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: bpf@vger.kernel.org
Cc: dwarves@vger.kernel.org
Cc: kernel-team@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
