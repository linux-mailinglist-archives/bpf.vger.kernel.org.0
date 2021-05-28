Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EDA393D0F
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 08:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhE1G0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 02:26:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38708 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhE1G0R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 02:26:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A03F91FD2E;
        Fri, 28 May 2021 06:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622183082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7O16xmQehx80n7fVVBeuMQ81Au9qauhcCf9P3KVa6HM=;
        b=dGed2PMDS6s5Tjfp2/y9GXu3gsBolu2eTmGGc1lndrnGRe/9lu9xconJyR/NWp+vFTyHia
        ogcHIXMAiR/mnZBv7Z+x6U2SHwqKo8mXjsmntR9KL/ABoDbN3Ic0Nq80OTIoqsRafLvdhD
        aP4owL9u2LALkxnsBpQ0pUzQjhF319Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622183082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7O16xmQehx80n7fVVBeuMQ81Au9qauhcCf9P3KVa6HM=;
        b=djEs2zWPnsnI0YOR+Ds9bPwCWxyQOF1MFxYLghSYNHo0acdrwkzj7uJBsLeo0xP6RBe6aa
        iAxG7WR/wwDO51AA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 8570611A98;
        Fri, 28 May 2021 06:24:42 +0000 (UTC)
Date:   Fri, 28 May 2021 08:24:41 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, jolsa@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves] btf_encoder: fix and complete filtering out
 zero-sized per-CPU variables
Message-ID: <20210528062441.GJ8544@kitsune.suse.cz>
References: <20210524234222.278676-1-andrii@kernel.org>
 <YK+yzpPKVhNvm7/n@kernel.org>
 <YK+zkOOAUzFYsLBy@kernel.org>
 <20210527152758.GI8544@kitsune.suse.cz>
 <YK+8/lg7ZUJIH7Kv@kernel.org>
 <YK/NLcM9ww2eXlmT@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YK/NLcM9ww2eXlmT@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 01:47:41PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 27, 2021 at 12:38:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, May 27, 2021 at 05:27:58PM +0200, Michal Suchánek escreveu:
> > > Hello,
> > > 
> > > On Thu, May 27, 2021 at 11:58:24AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Thu, May 27, 2021 at 11:55:10AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Mon, May 24, 2021 at 04:42:22PM -0700, Andrii Nakryiko escreveu:
> > > > > > btf_encoder is ignoring zero-sized per-CPU ELF symbols, but the same has to be
> > > > > > done for DWARF variables when matching them with ELF symbols. This is due to
> > > > > > zero-sized DWARF variables matching unrelated (non-zero-sized) variable that
> > > > > > happens to be allocated at the exact same address, leading to a lot of
> > > > > > confusion in BTF.
> > > > >  
> > > > > > See [0] for when this causes big problems.
> > > > >  
> > > > > >   [0] https://lore.kernel.org/bpf/CAEf4BzZ0-sihSL-UAm21JcaCCY92CqfNxycHRZYXcoj8OYb=wA@mail.gmail.com/
> > > > 
> > > > I also added this:
> > > > 
> > > > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > > > 
> > > > Michal, so you tested this patch and verified it fixed the problem? If
> > > > so please let me know so that I also add:
> > > 
> > > This is the first time I see this patch.
> > > 
> > > Given that linux-next does not build for me at the moment
> > > I don't think I will test it soon.
> > 
> > Ok, I'm test building with torvalds/master, will try with linux-next
> > afterwards,
> 
> I build and booted torvalds/master, all seems to work, now moving to
> linux-next.

[    9s] /usr/bin/qemu-kvm -nodefaults -no-reboot -nographic -vga none -cpu host -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-pci,rng=rng0 -runas qemu -net none -kernel /var/cache/obs/worker/root_2/.mount/boot/kernel -initrd /var/cache/obs/worker/root_2/.mount/boot/initrd -append root=/dev/disk/by-id/virtio-0 rootfstype=ext4 rootflags=noatime ext4.allow_unsupported=1 mitigations=off panic=1 quiet no-kvmclock elevator=noop nmi_watchdog=0 rw rd.driver.pre=binfmt_misc console=ttyS0 init=/.build/build -m 8192 -drive file=/var/cache/obs/worker/root_2/root,format=raw,if=none,id=disk,cache=unsafe -device virtio-blk-pci,drive=disk,serial=0 -drive file=/var/cache/obs/worker/root_2/swap,format=raw,if=none,id=swap,cache=unsafe -device virtio-blk-pci,drive=swap,serial=1 -serial stdio -chardev socket,id=monitor,server,nowait,path=/var/cache/obs/worker/root_2/root.qemu/monitor -mon chardev=monitor,mode=readline -smp 8
[    9s] c[?7l[2J[0mSeaBIOS (version rel-1.14.0-0-g155821a-rebuilt.opensuse.org)
[   15s] Booting from ROM..c[?7l[2J### VM INTERACTION END ###
[   15s] 2nd stage started in virtual machine
[   15s] machine type: x86_64
[   15s] Linux version: 5.13.0-rc3-next-2[    5.210478] sysrq: Changing Loglevel
[   15s] 0210526-2.g3bd43[    5.211566] sysrq: Loglevel set to 4
[   15s] 9f-vanilla #1 SMP Thu May 27 18:27:17 UTC 2021 (3bd439f)
[   15s] Increasing log level from now on...
[   15s] Enable sysrq operations
[   15s] Setting up swapspace version 1, size = 2 GiB (2097147904 bytes)
[   15s] no label, UUID=6e22796c-6df5-4859-a291-24acde2e92e5
[   15s] swapon: /dev/vdb: found signature [pagesize=4096, signature=swap]
[   15s] swapon: /dev/vdb: pagesize=4096, swapsize=2097152000, devsize=2097152000
[   15s] swapon /dev/vdb
[   15s] WARNING: udev not running, creating extra device nodes
[   15s] logging output to //.build.log...

next-20210527 does not build becuase of missing symbol but next-20210526 built with the patched pahole boots.

Tested-by: Michal Suchánek <msuchanek@suse.de>

Thanks

Michal
>  
> > Thanks,
> > 
> > - Arnaldo
> >  
> > > Thanks
> > > 
> > > Michal
> > > 
> > > > 
> > > > Tested-by: Michal Suchánek <msuchanek@suse.de>
> > > > 
> > > > Thanks,
> > > > 
> > > > - Arnaldo
> > > >  
> > > > > > +++ b/btf_encoder.c
> > > > > > @@ -550,6 +551,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > > > >  
> > > > > >  		/* addr has to be recorded before we follow spec */
> > > > > >  		addr = var->ip.addr;
> > > > > > +		dwarf_name = variable__name(var, cu);
> > > > > >  
> > > > > >  		/* DWARF takes into account .data..percpu section offset
> > > > > >  		 * within its segment, which for vmlinux is 0, but for kernel
> > > > > > @@ -582,11 +584,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > > > >  		 *  modules per-CPU data section has non-zero offset so all
> > > > > >  		 *  per-CPU symbols have non-zero values.
> > > > > >  		 */
> > > > > > -		if (var->ip.addr == 0) {
> > > > > > -			dwarf_name = variable__name(var, cu);
> > > > > > +		if (var->ip.addr == 0)
> > > > > >  			if (!dwarf_name || strcmp(dwarf_name, name))
> > > > > >  				continue;
> > > > > > -		}
> > > > > >  
> > > > > >  		if (var->spec)
> > > > > >  			var = var->spec;
> > > > > > @@ -600,6 +600,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > > > 
> > > > > I just changed the above hunk to be:
> > > > > 
> > > > > @@ -583,7 +585,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > > >                  *  per-CPU symbols have non-zero values.
> > > > >                  */
> > > > >                 if (var->ip.addr == 0) {
> > > > > -                       dwarf_name = variable__name(var, cu);
> > > > >                         if (!dwarf_name || strcmp(dwarf_name, name))
> > > > >                                 continue;
> > > > >                 }
> > > > > 
> > > > > 
> > > > > Which is shorter and keeps the {} around a multi line if block, ok?
> > > > > 
> > > > > Thanks, applied!
> > > > > 
> > > > > - Arnaldo
> > > > 
> > > > -- 
> > > > 
> > > > - Arnaldo
> > 
> > -- 
> > 
> > - Arnaldo
> 
> -- 
> 
> - Arnaldo
