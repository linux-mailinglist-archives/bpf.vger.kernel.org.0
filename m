Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B294AFEFD
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 22:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiBIVKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 16:10:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiBIVKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 16:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1925BC050CF8
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 13:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7EFC61B7A
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 21:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DADC340EB;
        Wed,  9 Feb 2022 21:10:18 +0000 (UTC)
Date:   Wed, 9 Feb 2022 16:10:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: Re: [RFC PATCH 2/3] powerpc/ftrace: Override
 ftrace_location_lookup() for MPROFILE_KERNEL
Message-ID: <20220209161017.2bbdb01a@gandalf.local.home>
In-Reply-To: <1644426751.786cjrgqey.naveen@linux.ibm.com>
References: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <fadc5f2a295d6cb9f590bbbdd71fc2f78bf3a085.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220207102454.41b1d6b5@gandalf.local.home>
        <1644426751.786cjrgqey.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 09 Feb 2022 17:50:09 +0000
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> However, I think we will not be able to use a fixed range.  I would like 
> to reserve instructions from function entry till the branch to 
> _mcount(), and it can be two or four instructions depending on whether a 
> function has a global entry point. For this, I am considering adding a 
> field in 'struct dyn_arch_ftrace', and a hook in ftrace_process_locs() 
> to initialize the same. I may need to override ftrace_cmp_recs().

Be careful about adding anything to dyn_arch_ftrace. powerpc already adds
the pointer to the module. Anything you add to that gets multiplied by
thousands of times (which takes up memory).

At boot up you may see something like:

  ftrace: allocating 45363 entries in 178 pages

That's 45,363 dyn_arch_ftrace structures. And each module loads their own
as well. To see how many total you have after boot up:


  # cat /sys/kernel/tracing/dyn_ftrace_total_info 
55974 pages:295 groups: 89

That's from the same kernel. Another 10,000 entries were created by modules.
(This was for x86_64)

What you may be able to do, is to add a way to look at the already saved
kallsyms, which keeps track of the function entry and exit to know how to
map an address back to the function.

   kallsyms_lookup(addr, NULL, &offset, NULL, NULL);

Should give you the offset of addr from the start of the function.

-- Steve
