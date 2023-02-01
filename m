Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF945687100
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 23:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBAWcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 17:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBAWcK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 17:32:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFC26866
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 14:32:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC0761984
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 22:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC94C433D2;
        Wed,  1 Feb 2023 22:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675290727;
        bh=rpTlLzgXtx565vpRycYm0Zw43SLrLXIajjwdFrawzrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzUCiaUGKO/Y0vnUlkRCORfr3tOqsIu1586Pk2BZpATy5WBxnQeGoj5fiZI4nlC0d
         EI7X1aWOkjqta7vo7YsVSE1kWUgW6+Nx3tXwmVUtRqsg2idmQ0y0+J2VAix7ABnhPV
         mvIXzBBTWwNsvpHL8j+UzfMwg4D867JBML8YKwXZsb2ZuqAt+cAIME1oDggGrMrRv0
         doIcExue60m47YPOYYAo1VKslyUsoky5lzhjree40UDZXvuYN/e8hvIekMzOmnt6TO
         u5Mq/Tk59Qn9oEHsjIYY/Jf9X5tTwe5bgZ09WCT/uVS95gLB7L4tChDcz5mzjBwW1s
         Gy66wK42vaJRA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 76BDE405BE; Wed,  1 Feb 2023 19:32:04 -0300 (-03)
Date:   Wed, 1 Feb 2023 19:32:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9roZNTWuuQOcQ39@kernel.org>
References: <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge>
 <9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com>
 <Y9p+70RzH7QiO2Mw@kernel.org>
 <Y9qC5UQaw9g6cPwz@maniforge>
 <CAADnVQJQQQNw0X-jDXquFYcYeSb0f5T3657KqC8+YevFO6A0cA@mail.gmail.com>
 <Y9qa+yFq+8jT+niu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qa+yFq+8jT+niu@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 01, 2023 at 02:01:47PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Feb 01, 2023 at 08:49:07AM -0800, Alexei Starovoitov escreveu:
> > On Wed, Feb 1, 2023 at 7:19 AM David Vernet <void@manifault.com> wrote:
> > >
> > > On Wed, Feb 01, 2023 at 12:02:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, Feb 01, 2023 at 01:59:30PM +0000, Alan Maguire escreveu:
> > > > > On 01/02/2023 03:02, David Vernet wrote:
> > > > > > On Tue, Jan 31, 2023 at 04:14:13PM -0800, Alexei Starovoitov wrote:
> > > > > >> On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
> > > > > >>>
> > > > > >>> On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
> > > > > >>>> On 31/01/2023 18:16, Alexei Starovoitov wrote:
> > > > > >>>>> On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
> > > > > >>>>> <alexei.starovoitov@gmail.com> wrote:
> > > > > >>>>>>
> > > > > >>>>>> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > > > >>>>>>>
> > > > > >>>>>>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> > > > > >>>>>>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > >>>>>>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> > > > > >>>>>>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> > > > > >>>>>>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > >>>>>>>>>>>> +++ b/dwarves.h
> > > > > >>>>>>>>>>>> @@ -262,6 +262,7 @@ struct cu {
> > > > > >>>>>>>>>>>>   uint8_t          has_addr_info:1;
> > > > > >>>>>>>>>>>>   uint8_t          uses_global_strings:1;
> > > > > >>>>>>>>>>>>   uint8_t          little_endian:1;
> > > > > >>>>>>>>>>>> + uint8_t          nr_register_params;
> > > > > >>>>>>>>>>>>   uint16_t         language;
> > > > > >>>>>>>>>>>>   unsigned long    nr_inline_expansions;
> > > > > >>>>>>>>>>>>   size_t           size_inline_expansions;
> > > > > >>>>>>>>>>>
> > > > > >>>>>>>>>
> > > > > >>>>>>>>>> Thanks for this, never thought of cross-builds to be honest!
> > > > > >>>>>>>>>
> > > > > >>>>>>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
> > > > > >>>>>>>>>> into one small thing on one system; turns out EM_RISCV isn't
> > > > > >>>>>>>>>> defined if using a very old elf.h; below works around this
> > > > > >>>>>>>>>> (dwarves otherwise builds fine on this system).
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Ok, will add it and will test with containers for older distros too.
> > > > > >>>>>>>>
> > > > > >>>>>>>> Its on the 'next' branch, so that it gets tested in the libbpf github
> > > > > >>>>>>>> repo at:
> > > > > >>>>>>>>
> > > > > >>>>>>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> > > > > >>>>>>>>
> > > > > >>>>>>>> It failed yesterday and today due to problems with the installation of
> > > > > >>>>>>>> llvm, probably tomorrow it'll be back working as I saw some
> > > > > >>>>>>>> notifications floating by.
> > > > > >>>>>>>>
> > > > > >>>>>>>> I added the conditional EM_RISCV definition as well as removed the dup
> > > > > >>>>>>>> iterator that Jiri noticed.
> > > > > >>>>>>>>
> > > > > >>>>>>>
> > > > > >>>>>>> Thanks again Arnaldo! I've hit an issue with this series in
> > > > > >>>>>>> BTF encoding of kfuncs; specifically we see some kfuncs missing
> > > > > >>>>>>> from the BTF representation, and as a result:
> > > > > >>>>>>>
> > > > > >>>>>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> > > > > >>>>>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> > > > > >>>>>>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
> > > > > >>>>>>>
> > > > > >>>>>>> Not sure why I didn't notice this previously.
> > > > > >>>>>>>
> > > > > >>>>>>> The problem is the DWARF - and therefore BTF - generated for a function like
> > > > > >>>>>>>
> > > > > >>>>>>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > > > > >>>>>>> {
> > > > > >>>>>>>         return -EOPNOTSUPP;
> > > > > >>>>>>> }
> > > > > >>>>>>>
> > > > > >>>>>>> looks like this:
> > > > > >>>>>>>
> > > > > >>>>>>>    <8af83a2>   DW_AT_external    : 1
> > > > > >>>>>>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
> > > > > >>>>>>>     <8af83a6>   DW_AT_decl_file   : 5
> > > > > >>>>>>>     <8af83a7>   DW_AT_decl_line   : 737
> > > > > >>>>>>>     <8af83a9>   DW_AT_decl_column : 5
> > > > > >>>>>>>     <8af83aa>   DW_AT_prototyped  : 1
> > > > > >>>>>>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
> > > > > >>>>>>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
> > > > > >>>>>>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
> > > > > >>>>>>>     <8af83b3>   DW_AT_name        : ctx
> > > > > >>>>>>>     <8af83b7>   DW_AT_decl_file   : 5
> > > > > >>>>>>>     <8af83b8>   DW_AT_decl_line   : 737
> > > > > >>>>>>>     <8af83ba>   DW_AT_decl_column : 51
> > > > > >>>>>>>     <8af83bb>   DW_AT_type        : <0x8af421d>
> > > > > >>>>>>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
> > > > > >>>>>>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
> > > > > >>>>>>>     <8af83c4>   DW_AT_decl_file   : 5
> > > > > >>>>>>>     <8af83c5>   DW_AT_decl_line   : 737
> > > > > >>>>>>>     <8af83c7>   DW_AT_decl_column : 61
> > > > > >>>>>>>     <8af83c8>   DW_AT_type        : <0x8adc424>
> > > > > >>>>>>>
> > > > > >>>>>>> ...and because there are no further abstract origin references
> > > > > >>>>>>> with location information either, we classify it as lacking
> > > > > >>>>>>> locations for (some of) the parameters, and as a result
> > > > > >>>>>>> we skip BTF encoding. We can work around that by doing this:
> > > > > >>>>>>>
> > > > > >>>>>>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > > > > >>>>>>
> > > > > >>>>>> replied in the other thread. This attr is broken and discouraged by gcc.
> > > > > >>>>>>
> > > > > >>>>>> For kfuncs where aregs are unused, please try __used and __may_unused
> > > > > >>>>>> applied to arguments.
> > > > > >>>>>> If that won't work, please add barrier_var(arg) to the body of kfunc
> > > > > >>>>>> the way we do in selftests.
> > > > > >>>>>
> > > > > >>>>> There is also
> > > > > >>>>> # define __visible __attribute__((__externally_visible__))
> > > > > >>>>> that probably fits the best here.
> > > > > >>>>>
> > > > > >>>>
> > > > > >>>> testing thus for seems to show that for x86_64, David's series
> > > > > >>>> (using __used noinline in the BPF_KFUNC() wrapper and extended
> > > > > >>>> to cover recently-arrived kfuncs like cpumask) is sufficient
> > > > > >>>> to avoid resolve_btfids warnings.
> > > > > >>>
> > > > > >>> Nice. Alexei -- lmk how you want to proceed. I think using the
> > > > > >>> __bpf_kfunc macro in the short term (with __used and noinline) is
> > > > > >>> probably the least controversial way to unblock this, but am open to
> > > > > >>> other suggestions.
> > > > > >>
> > > > > >> Sounds good to me, but sounds like __used and noinline are not
> > > > > >> enough to address the issues on aarch64?
> > > > > >
> > > > > > Indeed, we'll have to make sure that's also addressed. Alan -- did you
> > > > > > try Alexei's suggestion to use __weak? Does that fix the issue for
> > > > > > aarch64? I'm still confused as to why it's only complaining for a small
> > > > > > subset of kfuncs, which include those that have external linkage.
> > > > > >
> > > > >
> > > > > I finally got to the bottom of the aarch64 issues; there was a 1-line bug
> > > > > in the changes I made to the DWARF handling code which leads to BTF generation;
> > > > > it was excluding a bunch of functions incorrectly, marking them as optimized out.
> > > > > The fix is:
> > > > >
> > > > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > > > index dba2d37..8364e17 100644
> > > > > --- a/dwarf_loader.c
> > > > > +++ b/dwarf_loader.c
> > > > > @@ -1074,7 +1074,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> > > > >                         Dwarf_Op *expr = loc.expr;
> > > > >
> > > > >                         switch (expr->atom) {
> > > > > -                       case DW_OP_reg1 ... DW_OP_reg31:
> > > > > +                       case DW_OP_reg0 ... DW_OP_reg31:
> > > > >                         case DW_OP_breg0 ... DW_OP_breg31:
> > > > >                                 break;
> > > > >                         default:
> > > > >
> > > > > ..and because reg0 is the first parameter for aarch64, we were
> > > > > incorrectly landing in the "default:" of the switch statement
> > > > > and marking a bunch of functions as optimized out
> > > > > because we thought the first argument was. Sorry about this,
> > > > > and thanks for all the suggestions!
> > >
> > > Great, so inline and __used with __bpf_kfunc sounds like the way forward
> > > in the short term. Arnaldo / Alexei -- how do you want to resolve the
> > > dependency here? Going through bpf-next is probably a good idea so that
> > > we get proper CI coverage, and any kfuncs added to bpf-next after this
> > > can use the macro. Does that work for you?
> > 
> > It feels fixed pahole should be done under some flag
> > otherwise when people update the pahole the existing and older
> > kernels might stop building with warns:
> > WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> > WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> > ...
> > 
> > Arnaldo, could you check what warns do you see with this fixed pahole
> > in bpf tree ?
> 
> Sure.

These appeared on a distro like .config:

  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
WARN: resolve_btfids: unresolved symbol bpf_cpumask_any
WARN: resolve_btfids: unresolved symbol bpf_ct_change_status

I'll do it with allmodconfig
 
> > If there are only few warns then we can manually add __used noinline
> > to these places, push to bpf tree and push to stable.
> > 
> > Then in bpf-next we can clean up everything with __bpf_kfunc.
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
