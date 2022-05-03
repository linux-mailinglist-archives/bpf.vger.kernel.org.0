Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853DF5186EA
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiECOmw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 May 2022 10:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiECOmv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 May 2022 10:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720F35877
        for <bpf@vger.kernel.org>; Tue,  3 May 2022 07:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B49D617EC
        for <bpf@vger.kernel.org>; Tue,  3 May 2022 14:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527F3C385A4;
        Tue,  3 May 2022 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651588758;
        bh=CS2zAsquoDYrnlAR3H/iaX6OZsbg9Vkx++mlmtpVBQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbidaDAM1pj18x+dwnGpeWpjhjpe3oZ5T3GSHYcn2vIQBw3cR75yaZlrfG07PyzU1
         i8Wsaovhg/xjo07BU3W5sStS/xOPBlUjlGKu4x3v/eB7xmOIh5ETCEQOUCDjRiQLL0
         58lzpLIzMt/R5aahc9+aS25yrvqWxz8pZ3mIH6n+sTI3YqqSPQoWKuyzPlO8b06y05
         bZMcwoEiJMueZSCF+9Wh4ghIbni955ROhxbqjcvYIia8Ze+yiImAMZ0NDqIkJnVXl/
         wMys1cXvFgYKrb8ZypXcJ36yRaWf6Mbnh5Nb31/urRzATNcRvMbsE+UnLQOtpxb8O6
         M5poheek5E/hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D9CC400B1; Tue,  3 May 2022 11:39:15 -0300 (-03)
Date:   Tue, 3 May 2022 11:39:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        bpf <bpf@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
Message-ID: <YnE+k33iUtLH7Lks@kernel.org>
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop>
 <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com>
 <8735jjw4rp.fsf@brennan.io>
 <YjDT498PfzFT+kT4@kernel.org>
 <878rt9hogh.fsf@brennan.io>
 <CAEf4BzbiFNnsu9pji5ifzj4nVEyAYYdqP=QVZ3XFwzL48prP3A@mail.gmail.com>
 <87r15iv0yd.fsf@stepbren-lnx.us.oracle.com>
 <CAADnVQ+YuxB8gZGjx+RP=04z4SgYEmPjEjDa_=Q6HmUecxK8QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+YuxB8gZGjx+RP=04z4SgYEmPjEjDa_=Q6HmUecxK8QQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Apr 29, 2022 at 10:10:01AM -0700, Alexei Starovoitov escreveu:
> On Wed, Apr 27, 2022 at 11:43 AM Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> > [2]: https://github.com/brenns10/drgn/tree/kallsyms_plus_btf

> > Combining these three things, I've got a debugger which can open up a
> > vmcore _without DWARF debuginfo_ and allow you to print out typed
> > variable values. It just relies on BTF + kallsyms.

> > So the proof of concept is proven, and I'm quite excited about it!

> Exciting indeed. This is pretty cool.

Indeed!
 
> I'm afraid we cannot justify 2.5 Mb kernel memory increase for pure
> debugging. The existing vmlinux BTF is used by the kernel itself to
> validate bpf prog access.  bpf progs cannot access normal global vars.
> If/when they are we can reconsider.
 
> As an alternative path I think we could introduce hierarchical
> split BTF.

Which we already have in the form of BTF for modules that use vmlinux as
a base for common types.

> Currently vmlinux BTF and BTF of kernel modules is a tree
> of depth 2.

> We can keep such representation of BTFs and introduce a fake kernel
> module that contains kernel global vars.

pahole would generate a naked BTF just with variables and types not
present in the main vmlinux BTF and refer to it for all the other types.

> drgn can parse vmlinux BTF plus BTFs of all ko-s including fake one
> and obtain the same amount of debug info as if global vars
> were part of vmlinux BTF.

Right.

> Consuming 2.5Mb on demand via ko would be acceptable in some scenarios
> whereas unconditionally burning that much memory in vmlinux BTF (even
> optional via kconfig) is probably not.

And since it would be just an extra kernel module, the existing
packaging processes (in distros, embedded systems, etc) that care about
BTF would carry this without any modification to existing practices,
i.e. selecting CONFIG_DEBUG_INFO_BTF=y would bt default enable
CONFIG_DEBUG_INFO_GLOBAL_VARIABLES_BTF=y, which could be optionally
disabled by people not wanting to carry this extra info.

I.e. it would be always available but not always loaded.

> Ideally we structure BTFs as a multi level tree.  Where BTF with
> global vars and other non essential BTF info can be added to vmlinux
> BTF at run-time. BTF of kernel mods can add on top and mods can have
> split BTF too.

Yeah, reuses existing mechanizm, doesn't increase the kernel BTF
footprint by default, allows for debuggers, profilers, tracers, etc to
ask for extra info in the form of just loading btf_global_variables.ko.

- Arnaldo
