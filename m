Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369B863C8B3
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiK2Toi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 14:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbiK2ToV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 14:44:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D252874611
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 759BB618A6
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 19:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEB3C433D6;
        Tue, 29 Nov 2022 19:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669750867;
        bh=PgnMVapB4lLRG2KArEtmzUyZoZeDQt7mvc+eI1zKQ60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YyvmHct6wIQI6Q/ok9chIcdpijyGcgHaUO9tujaOFbHWnWGGYUvCqS+D1lTdc0zBz
         nULXZpBYmogQfBioD7M8D2Og/x6t5hmhTfSfmMZQ/K8tjG0rcUBDVCerBzqfx3caQH
         G3qdRsxwRny8QIgbYEFxxoqjFQmh3P4zp5qgUXnlg5S5G9mXEZbrX93JM2GQOZPvsx
         34RdOPyj8ovg7A/b7Iy7Bv+/J3KDGVDpfpBIfg4VsnmTsSh93LQU5UVl+ErjaUS7HG
         kJUsoHUm9YAEI+dka2dvvHH9UW/Pe2lPpQVDonrvwX9lFD/yg7hni8MFngUIk0j9xR
         ziG224eyQjaOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 255E14034E; Tue, 29 Nov 2022 16:41:05 -0300 (-03)
Date:   Tue, 29 Nov 2022 16:41:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: Calling kfuncs in modules - BTF mismatch?
Message-ID: <Y4ZgUVU5SecvT3Lr@kernel.org>
References: <87leoh372s.fsf@toke.dk>
 <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
 <875yfiwx1g.fsf@toke.dk>
 <08fa5e85-4d7b-4725-f340-bcb8525036f1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08fa5e85-4d7b-4725-f340-bcb8525036f1@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Nov 29, 2022 at 04:21:23PM +0000, Alan Maguire escreveu:
> On 13/11/2022 18:04, Toke Høiland-Jørgensen wrote:
> > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> > 
> >>>
> >>> Hi everyone
> >>>
> >>> There seems to be some issue with BTF mismatch when trying to run the
> >>> bpf_ct_set_nat_info() kfunc from a module. I was under the impression
> >>> that this is supposed to work, so is there some kind of BTF dedup issue
> >>> here or something?
> >>>
> >>> Steps to reproduce:
> >>>
> >>> 1. Compile kernel with nf_conntrack built-in and run selftests;
> >>>    './test_progs -a bpf_nf' works
> >>>
> >>> 2. Change the kernel config so nf_conntrack is build as a module
> >>>
> >>> 3. Start the test kernel and manually modprobe nf_conntrack and nf_nat
> >>>
> >>> 4. Run ./test_progs -a bpf_nf; this now fails with an error like:
> >>>
> >>> kernel function bpf_ct_set_nat_info args#0 expected pointer to STRUCT nf_conn___init but R1 has a pointer to STRUCT nf_conn___init
> >>
> >> This week Kumar and I took a look at this issue and we ended up
> >> identifying a duplication of nf_conn___init structure. In particular:
> >>
> >> [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> >> net/netfilter/nf_conntrack.ko format raw | grep nf_conn__
> >> [110941] STRUCT 'nf_conn___init' size=248 vlen=1
> >> [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> >> net/netfilter/nf_nat.ko format raw | grep nf_conn__
> >> [107488] STRUCT 'nf_conn___init' size=248 vlen=1
> >>
> >> Is it the root cause of the problem?
> > 
> > It certainly seems to be related to it, at least. Amending the log
> > message to include the BTF object IDs of the two versions shows that the
> > register has a reference to nf_conn__init in nf_conntrack.ko, while the kernel
> > expects it to point to nf_nat.ko.
> > 
> > Not sure what's the right fix for this? Should libbpf be smart enough to
> > pull the kfunc arg ID from the same BTF ID as the function itself? Or
> > should the kernel compare structs and allow things if they're identical?
> > Andrii, WDYT?
> > 
> 
> There were some dedup issues fixed recently in pahole
> and libbpf; since dwarves libbpf hasn't been synced with
> libbpf recently as far as I can see it won't have the fix 
> for [1]; I suspect it may help with dedup-ing here. Would 
> probably be worth trying rebuilding dwarves with a libbpf 
> with [1] applied and seeing if the dedup issue goes away
> before we go any further. If it fixes the issue, would it
> be worth updating the libbpf that dwarves uses Arnaldo?
> I saw some pretty large improvements in removing
> redundant definitions.

Feel free to send a patch updating the libbpf copy in pahole, so that I
can go on testing it.

I'm working on supporting DW_TAG_imported_unit and split DWARF (.dwz) so
as soon as I get that properly tested and make sure it doesn't regresses
wrt BTF encoding I'll cut a new version.

- Arnaldo
