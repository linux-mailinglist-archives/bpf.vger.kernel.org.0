Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E08518B52
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 19:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbiECRsk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 May 2022 13:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiECRsk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 May 2022 13:48:40 -0400
X-Greylist: delayed 938 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 10:45:06 PDT
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428413B29F
        for <bpf@vger.kernel.org>; Tue,  3 May 2022 10:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1651598953; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UR3zWkRLv6JX7HNLxRHVeOQ+XixsZkFbogM8vQe+3+MtfSvtAzeO47aC64DQihygjlLGoB+Twbae1/Q2LP+d7uxZknTtXCvs/6ATaGCeCtFr7m1uraN6umoPn+JhNO73Tmre11mFEtmZGQ0GSrHIRqasZyGNFnmgc1MrdwFeg7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1651598953; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9X9DcY/Txpl/zs8ZMzQoBbKLQNuKjgpOLlRgJ0Hn8+o=; 
        b=jtqCW534sK5ZhwL9Ouw8hvhQvvdO/nDkhqdbAIRqhwOXjsXVEvGfALpdSFx37uw+B3Aca11El3uzpOzxN9Ly4VJwOPzLcezIUemTKF8z8MRCFgzeO4KwaKFJBJnAvKplSYGgel+Fe0/8lFkMCQcHTctl+Tfv67Yuyq77HrTwlls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1651598953;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
        bh=9X9DcY/Txpl/zs8ZMzQoBbKLQNuKjgpOLlRgJ0Hn8+o=;
        b=RrHnfa/AtPzjhvbIK5Uocy01StozqiL3qG/fNRNJefCbDyZbSe38A3hixyMrhWwp
        yxnqL4YIGX3duxyGUqtF2nRCq9upCWo9UOphr/0iXgHisqe4f3EH0aAG19Ww4fIQ+bl
        UgqXPRWk8rsB3U1xtCi6LTmiUVyiijkHastBDPGI=
Received: from localhost (136-24-196-55.cab.webpass.net [136.24.196.55]) by mx.zohomail.com
        with SMTPS id 1651598949410368.50832363557925; Tue, 3 May 2022 10:29:09 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        bpf <bpf@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
In-Reply-To: <YnE+k33iUtLH7Lks@kernel.org>
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop>
 <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com> <8735jjw4rp.fsf@brennan.io>
 <YjDT498PfzFT+kT4@kernel.org> <878rt9hogh.fsf@brennan.io>
 <CAEf4BzbiFNnsu9pji5ifzj4nVEyAYYdqP=QVZ3XFwzL48prP3A@mail.gmail.com>
 <87r15iv0yd.fsf@stepbren-lnx.us.oracle.com>
 <CAADnVQ+YuxB8gZGjx+RP=04z4SgYEmPjEjDa_=Q6HmUecxK8QQ@mail.gmail.com>
 <YnE+k33iUtLH7Lks@kernel.org>
Date:   Tue, 03 May 2022 10:29:05 -0700
Message-ID: <87zgjy8qzi.fsf@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> Em Fri, Apr 29, 2022 at 10:10:01AM -0700, Alexei Starovoitov escreveu:
>> On Wed, Apr 27, 2022 at 11:43 AM Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
>> > [2]: https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
>
>> > Combining these three things, I've got a debugger which can open up a
>> > vmcore _without DWARF debuginfo_ and allow you to print out typed
>> > variable values. It just relies on BTF + kallsyms.
>
>> > So the proof of concept is proven, and I'm quite excited about it!
>
>> Exciting indeed. This is pretty cool.
>
> Indeed!
>
>> I'm afraid we cannot justify 2.5 Mb kernel memory increase for pure
>> debugging. The existing vmlinux BTF is used by the kernel itself to
>> validate bpf prog access.  bpf progs cannot access normal global vars.
>> If/when they are we can reconsider.
>
>> As an alternative path I think we could introduce hierarchical
>> split BTF.
>
> Which we already have in the form of BTF for modules that use vmlinux as
> a base for common types.
>
>> Currently vmlinux BTF and BTF of kernel modules is a tree
>> of depth 2.
>
>> We can keep such representation of BTFs and introduce a fake kernel
>> module that contains kernel global vars.

This is an awesome idea :)

>
> pahole would generate a naked BTF just with variables and types not
> present in the main vmlinux BTF and refer to it for all the other types.
>
>> drgn can parse vmlinux BTF plus BTFs of all ko-s including fake one
>> and obtain the same amount of debug info as if global vars
>> were part of vmlinux BTF.
>
> Right.
>
>> Consuming 2.5Mb on demand via ko would be acceptable in some scenarios
>> whereas unconditionally burning that much memory in vmlinux BTF (even
>> optional via kconfig) is probably not.
>
> And since it would be just an extra kernel module, the existing
> packaging processes (in distros, embedded systems, etc) that care about
> BTF would carry this without any modification to existing practices,
> i.e. selecting CONFIG_DEBUG_INFO_BTF=y would bt default enable
> CONFIG_DEBUG_INFO_GLOBAL_VARIABLES_BTF=y, which could be optionally
> disabled by people not wanting to carry this extra info.
>
> I.e. it would be always available but not always loaded.
>
>> Ideally we structure BTFs as a multi level tree.  Where BTF with
>> global vars and other non essential BTF info can be added to vmlinux
>> BTF at run-time. BTF of kernel mods can add on top and mods can have
>> split BTF too.

I see what you mean. It does sound a bit frustrating to have an
additional BTF module to augment every external module, which would be
the third level of that tree.

We'll need to allocate more module structs and pages within the kernel
for that data, I wonder whether it would be cheaper for the
"non-essential" module BTF to just reside in the same BTF section of
that module.

I suppose I can run my modified pahole on some sample modules and see
the BTF size difference, rather than just speculating, I'll do that in a
follow-up here.

> Yeah, reuses existing mechanizm, doesn't increase the kernel BTF
> footprint by default, allows for debuggers, profilers, tracers, etc to
> ask for extra info in the form of just loading btf_global_variables.ko.

I agree, this is a quite elegant solution. Though it'll require a fair
bit of work to achieve, I do think it's important to keep the footprint
down. One thing I'd like to see in this world is a way to instruct the
kernel that "I always want the non-essential BTF loaded", maybe via
cmdline or sysctl. This way, the module loader would know to search for
"$MODNAME-btf" for each module which doesn't end with "-btf".

The reason for this would be to increase the chances that a vmcore you
create would be truly self-contained: any loaded module has all
"non-essential" BTF alongside it. I suppose this would need to be
implemented across the kernel and the userspace tools for loading kernel
modules.

This is all because the only case where BTF+kallsyms would be useful to
you is when you don't have DWARF readily available. In the live case,
you can load the modules you need dynamically, so you don't necessarily
*need* to have the extra BTF loaded at all times. But if you want a
system configured to create vmcores, and you'd like to enable analysis
even in the absence of the DWARF or other data, then you should ensure
that all the non-essential BTF is in memory at all times. Otherwise,
you'd need to go hunting for some .ko files in some kernel package, and
at that point... just go find the DWARF!

It'll take some learning on my part to see how all of this would come
together on the pahole and kbuild side of things. If anybody has any
pointers for this I'd appreciate it :)

Thanks,
Stephen

> - Arnaldo
