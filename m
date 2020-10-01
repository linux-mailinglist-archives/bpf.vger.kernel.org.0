Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC81280216
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbgJAPDn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 11:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732579AbgJAPDn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 11:03:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9906120780;
        Thu,  1 Oct 2020 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601564623;
        bh=1EFFdD0DUAyisWOfdCKeb7Y1Afl+IRxVg8tOPYRG9Ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+TiwDdX3+oKX02t2bkBHr3KeyS2FBU2RzW1Bmz6uam5uQG5oHLY1hNcY9H4K5Dyp
         IAg9i3z3AD6lHn2e9sJ3VnI1ycOE+MJ7ozI49mY9PyAle/QXtADJV5whm0p3zaex40
         aQ11YHRVShmspJu69XjrYosq0en4A/bqZ9YS/QOI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C085B403AC; Thu,  1 Oct 2020 12:03:40 -0300 (-03)
Date:   Thu, 1 Oct 2020 12:03:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: BTF without CONFIG_DEBUG_INFO_BTF=y
Message-ID: <20201001150340.GB18693@kernel.org>
References: <VI1PR83MB02542417DBEF45BBA9C90FF7FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
 <87h7rejkwh.fsf@toke.dk>
 <20201001125029.GE3169811@kernel.org>
 <20201001132250.GF3169811@kernel.org>
 <87v9fuhxt9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9fuhxt9.fsf@toke.dk>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 01, 2020 at 03:37:22PM +0200, Toke Høiland-Jørgensen escreveu:
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> 
> > Em Thu, Oct 01, 2020 at 09:50:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Thu, Oct 01, 2020 at 12:33:18PM +0200, Toke Høiland-Jørgensen escreveu:
> >> > Kevin Sheldrake <Kevin.Sheldrake@microsoft.com> writes:
> >> > > I've seen mention a few times that BTF information can be made
> >> > > available from a kernel that wasn't configured with
> >> > > CONFIG_DEBUG_INFO_BTF. Please can someone tell me if this is true and,
> >> > > if so, how I could go about accessing and using it in kernels 4.15 to
> >> > > 5.8?
> >
> >> > > I have built the dwarves package from the github latest and run pahole
> >> > > with '-J' against my kernel image to no avail - it actually seg
> >> > > faults:
> >
> >> > > ~/dwarves/build $ sudo ./pahole /boot/vmlinuz-5.3.0-1022-azure
> >> > > btf_elf__new: cannot get elf header.
> >> > > ctf__new: cannot get elf header.
> >> > > ~/dwarves/build $ sudo ./pahole -J /boot/vmlinuz-5.3.0-1022-azure
> >> > > btf_elf__new: cannot get elf header.
> >> > > ctf__new: cannot get elf header.
> >> > > Segmentation fault
> >> > > ~/dwarves/build $ sudo ./pahole --version
> >> > > v1.17
> >
> >> > > Judging by the output, I'm guessing that my kernel image isn't the
> >> > > right kind of file. Can someone point me in the right direction?
> >
> >> > vmlinuz is a compressed image. There's a script in the kernel source
> >> > tree (scripts/extract-vmlinux), however the kernel image in /boot/
> >> > probably also has debug information stripped from it, so that likely
> >> > won't help you. You'll need to get hold of a kernel image with debug
> >> > information still intact somehow...
> >
> >> > (Either way, pahole shouldn't be segfaulting, so hopefully someone can
> >> > take a look at that).
> >
> >> Reproduced:
> >
> >> [acme@five pahole]$ cp /boot/vmlinuz-5.9.0-rc6+ .
> >> [acme@five pahole]$ pahole -J vmlinuz-5.9.0-rc6+
> >> btf_elf__new: cannot get elf header.
> >> ctf__new: cannot get elf header.
> >> tag__check_id_drift: subroutine_type id drift, core_id: 1145, btf_type_id: 1143, type_id_off: 0
> >> pahole: type 'vmlinuz-5.9.0-rc6+' not found
> >> libbpf: Unsupported BTF_KIND:0
> >> btf_elf__encode: btf__new failed!
> >> free(): double free detected in tcache 2
> >> Aborted (core dumped)
> >> [acme@five pahole]$
> >  
> >> Working on a fix. Thanks for the report!
> >
> > commit 4e55425d9eaac78689fbd296283e1557bb6ca725
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Thu Oct 1 10:10:50 2020 -0300
> >
> >     pahole: Only try using a single file name as a type name if not encoding BTF or CTF
> >     
> >     Otherwise we end up trying to encode without any debug info and this
> >     causes a segfault:
> >     
> >     Before:
> >     
> >       $ pahole -J vmlinuz-5.9.0-rc6+
> >       tag__check_id_drift: subroutine_type id drift, core_id: 1145, btf_type_id: 1143, type_id_off: 0
> >       pahole: type 'vmlinuz-5.9.0-rc6+' not found
> >       libbpf: Unsupported BTF_KIND:0
> >       btf_elf__encode: btf__new failed!
> >       free(): double free detected in tcache 2
> >       Aborted (core dumped)
> >       $
> >     
> >     The vmlinuz file doesn't contain any debugging info, fixing it we get:
> >     
> >       $ pahole -J vmlinuz-5.9.0-rc6+
> >       pahole: vmlinuz-5.9.0-rc6+: No debugging information found
> >       $
> >     
> >     If debugging info is available, it all works as before:
> >     
> >     Using /sys/kernel/btf/vmlinux
> >     
> >     $ ls -la /sys/kernel/btf/vmlinux
> >     -r--r--r--. 1 root root 3393761 Oct  1 09:50 /sys/kernel/btf/vmlinux
> >     
> >       $ pahole -E fw_cache_entry
> >       struct fw_cache_entry {
> >             struct list_head {
> >                     struct list_head * next;          /*     0     8 */
> >                     struct list_head * prev;          /*     8     8 */
> >             } list; /*     0    16 */
> >             const char  *              name;          /*    16     8 */
> >     
> >             /* size: 24, cachelines: 1, members: 2 */
> >             /* last cacheline: 24 bytes */
> >       };
> >       $
> >     
> >     Or explicitely asking for DWARF, where it will find the appropriate
> >     vmlinux according to its buildid in /sys/kernel/notes:
> >     
> >       $ pahole -F dwarf pm_clock_entry
> >       struct pm_clock_entry {
> >             struct list_head           node;          /*     0    16 */
> >             char *                     con_id;        /*    16     8 */
> >             struct clk *               clk;           /*    24     8 */
> >             enum pce_status            status;        /*    32     4 */
> >     
> >             /* size: 40, cachelines: 1, members: 4 */
> >             /* padding: 4 */
> >             /* last cacheline: 40 bytes */
> >       };
> >       $ pahole -F dwarf --expand_types pm_clock_entry
> >       struct pm_clock_entry {
> >             struct list_head {
> >                     struct list_head * next;          /*     0     8 */
> >                     struct list_head * prev;          /*     8     8 */
> >             } node; /*     0    16 */
> >             char *                     con_id;        /*    16     8 */
> >             struct clk *               clk;           /*    24     8 */
> >             enum pce_status            status;        /*    32     4 */
> >     
> >             /* size: 40, cachelines: 1, members: 4 */
> >             /* padding: 4 */
> >             /* last cacheline: 40 bytes */
> >       };
> >       $
> >     
> >     Reported-by: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> >     Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Yeah, that's much better!
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>

Thanks, adding your Acked-by and pushing it to the public repos at
github and kernel.org
