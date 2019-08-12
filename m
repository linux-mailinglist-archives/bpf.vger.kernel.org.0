Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 135A28A64E
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2019 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfHLS1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Aug 2019 14:27:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:32473 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfHLS1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Aug 2019 14:27:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 11:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="351290033"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2019 11:27:51 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hxF2r-0001n5-ND; Mon, 12 Aug 2019 21:27:49 +0300
Date:   Mon, 12 Aug 2019 21:27:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v1] tools: Keep list of tools in alphabetical order
Message-ID: <20190812182749.GT30120@smile.fi.intel.com>
References: <20190628172209.37290-1-andriy.shevchenko@linux.intel.com>
 <CAPhsuW75_wNSkLeRVL-X+qtdbExU+xcu7Vx5f5ZiH2CL-3TPxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW75_wNSkLeRVL-X+qtdbExU+xcu7Vx5f5ZiH2CL-3TPxA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 28, 2019 at 10:53:27AM -0700, Song Liu wrote:
> On Fri, Jun 28, 2019 at 10:23 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > When `make help` is executed it lists the possible tools to build,
> > though couple of entries is kept unordered. Fix it here.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>

Thank you.
I am wondering who can apply it. Alexei?

> 
> > ---
> >  tools/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/Makefile b/tools/Makefile
> > index 3dfd72ae6c1a..02585735320c 100644
> > --- a/tools/Makefile
> > +++ b/tools/Makefile
> > @@ -10,6 +10,7 @@ help:
> >         @echo 'Possible targets:'
> >         @echo ''
> >         @echo '  acpi                   - ACPI tools'
> > +       @echo '  bpf                    - misc BPF tools'
> >         @echo '  cgroup                 - cgroup tools'
> >         @echo '  cpupower               - a tool for all things x86 CPU power'
> >         @echo '  debugging              - tools for debugging'
> > @@ -22,12 +23,11 @@ help:
> >         @echo '  kvm_stat               - top-like utility for displaying kvm statistics'
> >         @echo '  leds                   - LEDs  tools'
> >         @echo '  liblockdep             - user-space wrapper for kernel locking-validator'
> > -       @echo '  bpf                    - misc BPF tools'
> > +       @echo '  objtool                - an ELF object analysis tool'
> >         @echo '  pci                    - PCI tools'
> >         @echo '  perf                   - Linux performance measurement and analysis tool'
> >         @echo '  selftests              - various kernel selftests'
> >         @echo '  spi                    - spi tools'
> > -       @echo '  objtool                - an ELF object analysis tool'
> >         @echo '  tmon                   - thermal monitoring and tuning tool'
> >         @echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
> >         @echo '  usb                    - USB testing tools'
> > --
> > 2.20.1
> >

-- 
With Best Regards,
Andy Shevchenko


