Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76452C837
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 01:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiERX4d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 19:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiERX4E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 19:56:04 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9A0A7E1D
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 16:54:48 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6B981240028
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 01:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652918085; bh=LSiPzor9GicDb5gEK6kPeTpKLCkgtShe+z2oPp1K/6U=;
        h=Date:From:To:Cc:Subject:From;
        b=fXlujwrWyRbwwUBbpYnJMPCmiwNDQj/wNY4oDU9EyP9vmVHk4gzIpjD89e2F/GPhX
         GM4mP3lWHXK2lui8OBCZYnd6pePX+t4BIKJsf/wFqBAUV+CR9R1tTx+VmNVMV8uIX5
         gKgOo+C5WjwdBsLCzPS60XW1oTboM/PYaKgguULzicmMZ2EaH9tpNXfj01+kTH4HB/
         rpXaeSOKKe+YiWpjXqXD1OITAO5vhz0OImRcR8/3+QkvImDCmQo7A5izE8bWXX5HFw
         XDyvhh3Mh5Q9hDVHForjL/WuFiDJfZROt36ebxT3EIgLcccqmHFT1qp7k2NxqxmEsN
         UYdqBpv5bY/3A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L3VGB2FBwz9rxD;
        Thu, 19 May 2022 01:54:41 +0200 (CEST)
Date:   Wed, 18 May 2022 23:54:38 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 09/12] bpftool: Use libbpf_bpf_attach_type_str
Message-ID: <20220518235438.4zavvpccirmmzlvw@muellerd-fedora-MJ0AC3F3>
References: <20220516173540.3520665-1-deso@posteo.net>
 <20220516173540.3520665-10-deso@posteo.net>
 <CAEf4BzYXxSerQnw3U5SKU10HAbM1KrTj9z_DvX+tQqaq7+2CUQ@mail.gmail.com>
 <a1a518b6-4006-7a65-178d-6100ada34a2d@isovalent.com>
 <20220517185427.tafxhqk7vplj6ie4@devvm5318.vll0.facebook.com>
 <1198532c-3be3-badd-cfc2-052aa435d697@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1198532c-3be3-badd-cfc2-052aa435d697@isovalent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 18, 2022 at 02:31:40PM +0100, Quentin Monnet wrote:
> 2022-05-17 18:54 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> > On Tue, May 17, 2022 at 03:18:41PM +0100, Quentin Monnet wrote:
> >> 2022-05-16 16:41 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >>> On Mon, May 16, 2022 at 10:36 AM Daniel Müller <deso@posteo.net> wrote:
> >>>>
> >>>> This change switches bpftool over to using the recently introduced
> >>>> libbpf_bpf_attach_type_str function instead of maintaining its own
> >>>> string representation for the bpf_attach_type enum.
> >>>>
> >>>> Note that contrary to other enum types, the variant names that bpftool
> >>>> maps bpf_attach_type to do not follow a simple to follow rule. With
> >>>> bpf_prog_type, for example, the textual representation can easily be
> >>>> inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
> >>>> remaining string. bpf_attach_type violates this rule for various
> >>>> variants. In order to not brake compatibility (these textual
> >>>> representations appear in JSON and are used to parse user input), we
> >>>> introduce a program local bpf_attach_type_str that overrides the
> >>>> variants in question.
> >>>> We should consider removing this function and expect the libbpf string
> >>>> representation with the next backwards compatibility breaking release,
> >>>> if possible.
> >>>>
> >>>> Signed-off-by: Daniel Müller <deso@posteo.net>
> >>>> ---
> >>>
> >>> Quentin, any opinion on this approach? Should we fallback to libbpf's
> >>> API for all the future cases or it's better to keep bpftool's own
> >>> attach_type mapping?
> >> Hi Andrii, Daniel,
> > 
> > Hi Quentin,
> > 
> >> Thanks for the ping! I'm unsure what's best, to be honest. Maybe we
> >> should look at bpftool's inputs and outputs separately.
> >>
> >> For attach types printed as part of the output:
> >>
> >> Thinking about it, I'd say go for the libbpf API, and make the change
> >> now. As much as we all dislike breaking things for user space, I believe
> >> that on the long term, we would benefit from having a more consistent
> >> naming scheme for those strings (prefix + lowercase attach type); and
> >> more importantly, if querying the string from libbpf spreads to other
> >> tools, these will be the reference strings for the attach types and it
> >> will be a pain to convert bpftool's specific exceptions to "regular"
> >> textual representations to interface with other tools.
> >>
> >> And if we must break things, I'd as well have it synchronised with the
> >> release of libbpf 1.0, so I'd say let's just change it now? Note that
> >> we're now tagging bpftool releases on the GitHub mirror (I did 6.8.0
> >> earlier today), so at least that's one place where we can have a
> >> changelog and mention breaking changes.
> > 
> > Thanks for the feedback. This sounds good to me. I can make the change. But do
> > you think we should do it as part of this stack? We could make this very stack a
> > behavior preserving step (that can reasonably stand on its own). Given the
> > additional changes to tests & documentation that you mention below, it would
> > make sense to me to keep individual patches in this series similar in nature.
> > I'd be happy to author a follow-on, but can also amend this series if that's
> > preferred. Please let me know your preference.
> 
> So I would have a slight preference for having everything together, but
> at the same time I understand that the current patchset is already in
> a good state and that you don't want to "overgrow" it too much. So
> follow-up is fine by me, mostly (see next paragraph), if it lands before
> libbpf v1.0 is released. If I understand correctly, you would have the
> addition of the new names as an alternative for input parameters in this
> set, and follow-up with the breaking changes (using the new names for
> output, and switching to new names for input in docs) as a follow-up, is
> this correct?

Correct, that was my initial plan. But I had a look at the test code and given
how much it relies on the current source code (without this patch), my suggested
approach is actually no longer tenable (or at least would require significantly
more work, I'd say). I am now adjusting everything in this patch and also added
the fallbacks as you suggested.

> Still, the tests in test_bpftool_synctypes.py should be updated in this
> PR, because the bpftool tests in the CI break otherwise [0]. This is due
> to the removal of the lists of names in bpftool: the test parses them to
> compare the lists with what's present in UAPI bpf.h, bpftool man pages,
> etc. I believe it would be best to keep this in a running state.
> 
> [0]
> https://github.com/kernel-patches/bpf/runs/6459959177?check_suite_focus=true#step:6:678

Thanks for the pointer. I've updated the test. It has become a rather large
patch now, though. What I ended up doing is to mostly rely on uapi/linux/bpf.h
enum definitions as the source of truth. Let me know if you want me to poke into
libbpf instead. I'd honestly rather avoid doing that.

Are there additional tests that I should run to give me some more confidence in
my changes? I tried running test_bpftool.sh, but it fails for a reason not
apparent to me. I did not investigate, because it also fails on master and one
of the commands that failed, bpftool feature probe macros, when run directly,
succeeds both with and without my patch set (which strongly suggests to me that
there is something else amiss here).

> >> Now for the attach types parsed as input parameters:
> >>
> >> I wonder if it would be worth supporting the two values for attach types
> >> where they differ, so that we would avoid breaking bpftool commands
> >> themselves? It's a bit more code, but then the list would be relatively
> >> short, and not expected to grow. We can update the documentation to
> >> mention only the new names, and just keep the short compat list hidden.
> > 
> > Yes, that should be easily possible. I do have a similar question to above,
> > though (as it involves updating documentation for new preference): can/should
> > that be a separate patch?
> > 
> >> Some additional notes on the patch:
> >>
> >> There is also attach_type_strings[] in prog.c where strings for attach
> >> types are re-defined, this time for when non cgroup-related programs are
> >> attached (through "bpftool prog attach"). It's used for parsing the
> >> input, so should be treated the same as the attach list in commons.c.
> > 
> > Good point. If we want to use libbpf text representations moving forward then I
> > can adjust this array as well. Do I assume correctly that we would want to keep
> > the existing variants as hidden fallbacks here too, as you mentioned above?
> 
> Yes, exactly.

I've adjusted this array now as well.

> >> If changing the attach type names, we should also update the following:
> >> - man pages: tools/bpf/bpftool/Documentation/bpftool-{cgroup,prog}.rst
> >> - interactive help (cgroup.c:HELP_SPEC_ATTACH_TYPES + prog.c:do_help())
> >> - bash completion: tools/bpf/bpftool/bash-completion/bpftool
> >>
> >> Some of the tests in
> >> tools/testing/selftests/bpf/test_bpftool_synctypes.py, related to
> >> keeping those lists up-to-date, will also need to be modified to parse
> >> the names from libbpf instead of bpftool sources. I can help with that
> >> if necessary.
> > 
> > Sounds good; will do that here or as a follow-on (and reach out to you if I need
> > assistance), depending on your preference as inquired above.
> 
> Sounds like a plan :)

Done. Though I did go with bpf.h as the source of truth. Please let me know if
you want me to use libbpf instead.

Will update to v2 soon.

Thanks,
Daniel
