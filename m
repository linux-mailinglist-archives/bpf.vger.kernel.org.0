Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39674DA1B9
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiCOSAQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 14:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiCOSAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 14:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748525675E
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 10:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D09615C1
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB869C340EE;
        Tue, 15 Mar 2022 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647367142;
        bh=hKYCVv8Nsy9TN/B6nIx9ASu/IZpd3N3FcHwSCqGDqX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1aJNPeIQwpGz756DliDTB3BbFNMGC12tal+E6UQ0Wtkm5H2U4ejW2gyl30FpD3/l
         92yWAng8u7XIOZ6S5eiKlwDhdTgAF8fhr+uRoHrka0pkfaPcvGW1Oj2tkZeQrWrnw9
         Om/XyntIT/U/UTV3wnIzH3ucSDL1M6Ec0wu3bw2ffHSEIgQFCdimGWWbaN16sDKRXb
         7nE89kxPCo22cLRtLoW12UZYEVCMH2k8iVQpuCAWA4NGG/MnAexrw2Dq4GRP8Xa7KU
         KH7Q0RVGQ4cRZNB5CjWAs3K9jcvQzfbYGtCZpfbpSYKZA59ACVCUEitrfd8e9MewY8
         rj3V/iQsYqamg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88ADC40407; Tue, 15 Mar 2022 14:58:59 -0300 (-03)
Date:   Tue, 15 Mar 2022 14:58:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Brennan <stephen@brennan.io>
Cc:     Yonghong Song <yhs@fb.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        bpf@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
Message-ID: <YjDT498PfzFT+kT4@kernel.org>
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop>
 <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com>
 <8735jjw4rp.fsf@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735jjw4rp.fsf@brennan.io>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 15, 2022 at 09:37:46AM -0700, Stephen Brennan escreveu: Yonghong Song <yhs@fb.com> writes:
> > On 3/14/22 12:09 AM, Shung-Hsi Yu wrote:
> >> On Wed, Mar 09, 2022 at 03:20:47PM -0800, Stephen Brennan wrote:
> >>> I've been recently learning about BTF with a keen interest in using it
> >>> as a fallback source of debug information. On the face of it, Linux
> >>> kernels these days have a lot of introspection information. BTF provides
> >>> information about types. kallsyms provides information about symbol
> >>> locations. ORC allows us to reliably unwind stack traces. So together,
> >>> these could enable a debugger (either postmortem, or live) to do a lot
> >>> without needing to read the (very large) DWARF debuginfo files. For
> >>> example, we could format backtraces with function names, we could

> > For backtraces with function names, you probably still need ksyms since
> > BTF won't encode address => symbol translation.
 
> Yes, kallsyms is definitely required in this scheme. In practice, it
> seems very common for distributions to be compiled not just with
> CONFIG_KALLSYMS, but CONFIG_KALLSYMS_ALL.
 
> Kallsyms is critical for mapping names to addresses (and vice versa).
 
> >>> pretty-print global variables and data structures, etc. This is nice

> > This indeed is a potential use case.
> > We discussed this during adding per-cpu
> > global variables. Ultimately we just added per-cpu global variables 
> > since we didn't have a use case or request for other global variables.

> > But I still would like to know beyond this whether you have other needs
> > which BPF may or may not help. It would be good to know since if 
> > ultimately you still need dwarf, then it might be undesirable to
> > add general global variables to BTF.

> I think that kallsyms, BTF, and ORC together will be enough to provide a
> lite debugging experience. Some things will be missing:

> - mapping backtrace addresses to source code lines

So, BTF has provisions for that, and its present in the eBPF programs,
perf annotate uses it, see tools/perf/util/annotate.c,
symbol__disassemble_bpf(), it goes like:

        struct bpf_prog_linfo *prog_linfo = NULL;

        info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
                                                 dso->bpf_prog.id);
        if (!info_node) {
                ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
                goto out;
        }
        info_linear = info_node->info_linear;
        sub_id = dso->bpf_prog.sub_id;

        info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
        info.buffer_length = info_linear->info.jited_prog_len;

        if (info_linear->info.nr_line_info)
                prog_linfo = bpf_prog_linfo__new(&info_linear->info);

                addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
                count = disassemble(pc, &info);

                if (prog_linfo)
                        linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
                                                                addr, sub_id,
                                                                nr_skip);
		                if (linfo && btf) {
                        srcline = btf__name_by_offset(btf, linfo->line_off);
                        nr_skip++;
                } else
                        srcline = NULL;

etc.

Having this for the kernel proper is thus doable, but then we go on
making BTF info grow.

Perhaps having this as optional, distros or appliances wanting to have a
kernel with this extra info would add it and then tools would use it if
available?

> - intelligent stack frame information from DWARF CFI (e.g.
>   register/variable values)
> - probably other things, I'm not a DWARF expert.
 
> However, I do have two interesting branches of drgn which demonstrate
> the utility of just BTF+kallsyms:
 
> 1. https://github.com/osandov/drgn/pull/162
> 2. https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
 
> #1 adds preliminary BTF support, and #2 adds basic kallsyms support,
> building on #1. Finally, I have some unpublished patches which add some
> symbols into vmcoreinfo, which help us locate kallsyms info. From there,
> drgn is able to take a core dump, and lookup symbols and get their
> corresponding type info!
 
> The only real blocker I see here is that the BTF data is mainly limited
> to functions, so most of what you're doing is looking up function names
> and viewing their signatures :)
 
> >>> given that depending on your distro, it might be tough to get debuginfo,
> >>> and it is quite large to download or install.
> >>>
> >>> As I've worked toward this goal, I discovered that while the
> >>> BTF_KIND_VAR exists [1], the BTF included in the core kernel only has
> >>> declarations for percpu variables. This makes BTF much less useful for
> >>> this (admittedly odd) use case. Without a way to bind a name found in
> >>> kallsyms to its type, we can't interpret global variables. It looks like
> >>> the restriction for percpu-only variables is baked into the pahole BTF
> >>> encoder [2].

> >>> [1]: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-var
> >>> [2]: https://github.com/acmel/dwarves/blob/master/btf_encoder.c

> >>> I wonder what the BPF / BTF community's thoughts are on including more
> >>> of these global variable declarations? Perhaps behind a
> >>> CONFIG_DEBUG_INFO_BTF_ALL, like how kallsyms does it? I'm aware that

> > Currently on my local machine, the vmlinux BTF's size is 4.2MB and
> > adding 1MB would be a big increase. CONFIG_DEBUG_INFO_BTF_ALL is a good
> > idea. But we might be able to just add global variables without this
> > new config if we have strong use case.
 
> And unfortunately 1MiB is really just a shot in the dark, guessing
> around 70k variables with no string data.

Maybe we can have a separate BTF file with all this extra info that
could be fetched from somewhere, keyed by build-id, like is now possible
with debuginfod and DWARF?
 
> I'd love to use kallsyms to avoid adding new strings into BTF. If the
> "all variables BTF" config added a dependency on "CONFIG_KALLSYMS_ALL",
> then we could use the BTF "kind_flag" to indicate that string values
> should be looked up in the kallsyms table, not the BTF strings section.
> This could even be used to reduce the string footprint for BTF
> function names.
 
> Of course it's a more complex change to dwarves :(
 
> >>> each declaration costs at least 16 bytes of BTF records, plus the
> >>> strings and any necessary type data. The string cost could be mitigated
> >>> by allowing "name_off" to refer to the kallsyms offset for variable or
> >>> function declaration. But the additional records could cost around 1MiB
> >>> for common distribution configurations.
> >>>
> >>> I know this isn't the designed use case for BTF, but I think it's very
> >>> exciting.
> >> 
> >> I've been wondering about the same (possibility of using BTF for postmortem
> >> debugging without debuginfo), though not to the extend that you've
> >> researched.
> >> 
> >> I find the idea exciting as well, and quite useful for distros where the
> >> kernel package changes quite often that the debuginfo package may be long
> >> gone by the time a crash dump for such kernel is captured.
> >
> > I would love to use BTF (including global variables in BTF) for crash 
> > dump. But I suspect we may still have some gaps. Maybe you can
> > explore a little bit more on this?
> 
> Hopefully my above explanation gives more context here. There is code
> (not production-ready) which can make use of these features together.
> The next step for me has been trying to get the dwarves/pahole BTF
> encoder to output *all* functions but I've hit some issues with it. If I
> can get that to work, then I can present a full demo of these pieces
> working together and we can be confident that there are no gaps.
> 
> Maybe this is a topic worth discussing at LSF/MM/BPF conference? Though
> it's quite late for that...
> 
> Thanks,
> Stephen
> 
> >
> >> 
> >> Shung-Hsi
> >> 
> >>> Thanks for your attention!
> >>> Stephen
> >> 

-- 

- Arnaldo
