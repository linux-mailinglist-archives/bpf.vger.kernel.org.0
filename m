Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59703352C00
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBO5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 10:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBO5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 10:57:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5314461041;
        Fri,  2 Apr 2021 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617375460;
        bh=1EDxYdEkvBzV79vRsA7FHxJBG8WfRFBqvyPxRWuHldk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdlODsdoDoUNWhl4ZaVhheiKgJvC5gKOIe+NR6jHmydy8kVqGhOMwBdr0+w7Hg2cX
         azH0HE9Q/d0auwBi9RE0lhB3VH8q2548G18PjdZfYzNOZWDukn/I9r701dqZb/VFv/
         HH4Bdmmd6RTZK/95jLNUj9fwBY+aUapyc/fR8ypn1Bzftt/qntEnai1n65RoFbaRxo
         Xy+icYXy7NHfUVROLfffBjq+6JfNkE0kDxHtPkaR7NbYRByqzIF1R1TBf6R874x4bS
         VYST2uihc4DccSBv1DCrENkF8AaCJ5LfsIvahUosa4EY86nEQC4g1//smNQ3JbyqpL
         nU5rowAn8EYNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F4DA40647; Fri,  2 Apr 2021 11:57:38 -0300 (-03)
Date:   Fri, 2 Apr 2021 11:57:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     David Blaikie <dblaikie@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
Message-ID: <YGcw4iq9QNkFFfyt@kernel.org>
References: <20210401213620.3056084-1-yhs@fb.com>
 <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
 <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGckYjyfxfNLzc34@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Apr 02, 2021 at 11:04:18AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 01, 2021 at 05:00:46PM -0700, David Blaikie escreveu:
> > On Thu, Apr 1, 2021 at 4:41 PM Yonghong Song <yhs@fb.com> wrote:
> > > On 4/1/21 3:27 PM, David Blaikie wrote:
> > > > Though people may come up with novel uses of DWARF features. What would
> > > > happen if this constraint were violated/what's your motivation for
> > > > asking (I don't quite understand the connection between test_progs
> > > > failure description, and this question)

> > > I have some codes to check the tag associated with abstract_origin
> > > for a subprogram must be a subprogram. Through experiment, I didn't
> > > see a violation, so I wonder that I can get confirmation from you
> > > and then I may delete that code.

> > > The test_progs failure exposed the bug, that is all.

> > > pahole cannot handle all weird usages of dwarf, so I think pahole
> > > is fine only to support well-formed dwarf.

> > Sounds good. Thanks for the context!

> David, since you took the time to go thru the changes and to agree that
> Yonghong's fix is good, can I add a:

> Acked-by: David Blaikie <dblaikie@gmail.com>

> to this patch?

> Maybe even a:

> Reviewed-by: David Blaikie <dblaikie@gmail.com>

What I have is at tmp.master, please take a look and check that
everything is ok, the only think I wished to fix but I think can be left
for later is in the tmp.master branch at:

 git://git.kernel.org/pub/scm/devel/pahole/pahole.git tmp.master

I did some testing for this ret type fix:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master

And for the LTO ELF notes:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master&id=7a79d2d7a573a863aa36fd06f540fe9fa824db4e

The only remaining thing, which I think can be left for 1.22 is:

[acme@five pahole]$ btfdiff vmlinux.clang.thin.LTO
vmlinux.clang.thin.LTO           vmlinux.clang.thin.LTO+ELF_note
[acme@five pahole]$ btfdiff vmlinux.clang.thin.LTO+ELF_note
--- /tmp/btfdiff.dwarf.CtLJpQ	2021-04-02 11:55:09.658433186 -0300
+++ /tmp/btfdiff.btf.d3L3vy	2021-04-02 11:55:09.925439277 -0300
@@ -67255,7 +67255,7 @@ struct cpu_rmap {
 	struct {
 		u16                index;                /*    16     2 */
 		u16                dist;                 /*    18     2 */
-	} near[0]; /*    16     0 */
+	} near[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 5 */
 	/* last cacheline: 16 bytes */
@@ -101181,7 +101181,7 @@ struct linux_efi_memreserve {
 	struct {
 		phys_addr_t        base;                 /*    16     8 */
 		phys_addr_t        size;                 /*    24     8 */
-	} entry[0]; /*    16     0 */
+	} entry[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 4 */
 	/* last cacheline: 16 bytes */
@@ -113516,7 +113516,7 @@ struct netlink_policy_dump_state {
 	struct {
 		const struct nla_policy  * policy;       /*    16     8 */
 		unsigned int       maxtype;              /*    24     4 */
-	} policies[0]; /*    16     0 */
+	} policies[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 4 */
 	/* sum members: 12, holes: 1, sum holes: 4 */
[acme@five pahole]$

- Arnaldo
