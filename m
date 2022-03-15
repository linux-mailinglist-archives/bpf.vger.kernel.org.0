Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124E04DA080
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 17:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbiCOQya (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350199AbiCOQy3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 12:54:29 -0400
X-Greylist: delayed 914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 09:53:15 PDT
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC58E4C
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 09:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1647362272; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=A8RdSMK0i0tjp+gKj2YA+kHDk9v1Jfsf00CwmHnln8J7gD+0X64TqAz6Ic7r2Uj3FRnLIb/1XJzU9wKPSLoYFwUii0qmdFsaU4Wl+0ZbFA9HSOkcyX52iV5Zlej6scdoYBl1oXOJyNlI/bqAw7RTjBa6JoTrKgzo2aV1DE7/ITg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1647362272; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=pl3dq/WyaQ/JfhHHl4TWKQ5H5jwfyWguMV2LUDIWHrE=; 
        b=J7b9fMcXRpL1PGNpz9LFtjwv9Vx6rwDtf9fIcAXRJ3EHWsQt6ZCrjVQAj2uXwQ7GUdXt4oPUOceOaOhCybc8ZTC8l4K+dqc7XG1u66rFw+Ns9SImf9T3jrYtiLg5SAUON+HjUzz57WyC4llHsb9yWXHD9HyIPqDUc+AI8PRcCW4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1647362272;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
        bh=pl3dq/WyaQ/JfhHHl4TWKQ5H5jwfyWguMV2LUDIWHrE=;
        b=smM7NLyvT2xBlmf//q0OddppOzTYkXdQClUJHzIwvdtm04ZGHoJRIjuXRnyiAPAE
        4I4p93dAWCj0zQsNaHx3M4o2kgStGUpDr3bHCK0P4BwqTHrTOcb/WZMlIOY3pMLaGoL
        BDtiRgjgRtoKlp2Y793CRHerxJMAj7fv3w6kTpRM=
Received: from localhost (12.202.152.3 [12.202.152.3]) by mx.zohomail.com
        with SMTPS id 1647362269102148.31101709246354; Tue, 15 Mar 2022 09:37:49 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Yonghong Song <yhs@fb.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
In-Reply-To: <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com>
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop>
 <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com>
Date:   Tue, 15 Mar 2022 09:37:46 -0700
Message-ID: <8735jjw4rp.fsf@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:
> On 3/14/22 12:09 AM, Shung-Hsi Yu wrote:
>> On Wed, Mar 09, 2022 at 03:20:47PM -0800, Stephen Brennan wrote:
>>> Hello everyone,
>>>
>>> I've been recently learning about BTF with a keen interest in using it
>>> as a fallback source of debug information. On the face of it, Linux
>>> kernels these days have a lot of introspection information. BTF provides
>>> information about types. kallsyms provides information about symbol
>>> locations. ORC allows us to reliably unwind stack traces. So together,
>>> these could enable a debugger (either postmortem, or live) to do a lot
>>> without needing to read the (very large) DWARF debuginfo files. For
>>> example, we could format backtraces with function names, we could
>
> For backtraces with function names, you probably still need ksyms since
> BTF won't encode address => symbol translation.

Yes, kallsyms is definitely required in this scheme. In practice, it
seems very common for distributions to be compiled not just with
CONFIG_KALLSYMS, but CONFIG_KALLSYMS_ALL.

Kallsyms is critical for mapping names to addresses (and vice versa).

>
>>> pretty-print global variables and data structures, etc. This is nice
>
> This indeed is a potential use case.
> We discussed this during adding per-cpu
> global variables. Ultimately we just added per-cpu global variables 
> since we didn't have a use case or request for other global variables.
>
> But I still would like to know beyond this whether you have other needs
> which BPF may or may not help. It would be good to know since if 
> ultimately you still need dwarf, then it might be undesirable to
> add general global variables to BTF.

I think that kallsyms, BTF, and ORC together will be enough to provide a
lite debugging experience. Some things will be missing:

- mapping backtrace addresses to source code lines
- intelligent stack frame information from DWARF CFI (e.g.
  register/variable values)
- probably other things, I'm not a DWARF expert.

However, I do have two interesting branches of drgn which demonstrate
the utility of just BTF+kallsyms:

1. https://github.com/osandov/drgn/pull/162
2. https://github.com/brenns10/drgn/tree/kallsyms_plus_btf

#1 adds preliminary BTF support, and #2 adds basic kallsyms support,
building on #1. Finally, I have some unpublished patches which add some
symbols into vmcoreinfo, which help us locate kallsyms info. From there,
drgn is able to take a core dump, and lookup symbols and get their
corresponding type info!

The only real blocker I see here is that the BTF data is mainly limited
to functions, so most of what you're doing is looking up function names
and viewing their signatures :)

>
>>> given that depending on your distro, it might be tough to get debuginfo,
>>> and it is quite large to download or install.
>>>
>>> As I've worked toward this goal, I discovered that while the
>>> BTF_KIND_VAR exists [1], the BTF included in the core kernel only has
>>> declarations for percpu variables. This makes BTF much less useful for
>>> this (admittedly odd) use case. Without a way to bind a name found in
>>> kallsyms to its type, we can't interpret global variables. It looks like
>>> the restriction for percpu-only variables is baked into the pahole BTF
>>> encoder [2].
>>>
>>> [1]: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-var
>>> [2]: https://github.com/acmel/dwarves/blob/master/btf_encoder.c
>>>
>>> I wonder what the BPF / BTF community's thoughts are on including more
>>> of these global variable declarations? Perhaps behind a
>>> CONFIG_DEBUG_INFO_BTF_ALL, like how kallsyms does it? I'm aware that
>
> Currently on my local machine, the vmlinux BTF's size is 4.2MB and
> adding 1MB would be a big increase. CONFIG_DEBUG_INFO_BTF_ALL is a good
> idea. But we might be able to just add global variables without this
> new config if we have strong use case.

And unfortunately 1MiB is really just a shot in the dark, guessing
around 70k variables with no string data.

I'd love to use kallsyms to avoid adding new strings into BTF. If the
"all variables BTF" config added a dependency on "CONFIG_KALLSYMS_ALL",
then we could use the BTF "kind_flag" to indicate that string values
should be looked up in the kallsyms table, not the BTF strings section.
This could even be used to reduce the string footprint for BTF
function names.

Of course it's a more complex change to dwarves :(

>
>>> each declaration costs at least 16 bytes of BTF records, plus the
>>> strings and any necessary type data. The string cost could be mitigated
>>> by allowing "name_off" to refer to the kallsyms offset for variable or
>>> function declaration. But the additional records could cost around 1MiB
>>> for common distribution configurations.
>>>
>>> I know this isn't the designed use case for BTF, but I think it's very
>>> exciting.
>> 
>> I've been wondering about the same (possibility of using BTF for postmortem
>> debugging without debuginfo), though not to the extend that you've
>> researched.
>> 
>> I find the idea exciting as well, and quite useful for distros where the
>> kernel package changes quite often that the debuginfo package may be long
>> gone by the time a crash dump for such kernel is captured.
>
> I would love to use BTF (including global variables in BTF) for crash 
> dump. But I suspect we may still have some gaps. Maybe you can
> explore a little bit more on this?

Hopefully my above explanation gives more context here. There is code
(not production-ready) which can make use of these features together.
The next step for me has been trying to get the dwarves/pahole BTF
encoder to output *all* functions but I've hit some issues with it. If I
can get that to work, then I can present a full demo of these pieces
working together and we can be confident that there are no gaps.

Maybe this is a topic worth discussing at LSF/MM/BPF conference? Though
it's quite late for that...

Thanks,
Stephen

>
>> 
>> Shung-Hsi
>> 
>>> Thanks for your attention!
>>> Stephen
>> 
