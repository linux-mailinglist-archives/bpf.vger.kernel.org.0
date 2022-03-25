Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7463E4E79A9
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377186AbiCYRJQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 13:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244508AbiCYRJN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 13:09:13 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63788E6162
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 10:07:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id b9so5612899ila.8
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWgA+/2pIvQjK41iFHFvWRydEbuLY4ATf1zz+o+sHkg=;
        b=j/JaCxK3C6vxIVngeTfYGArKcVm9+W3dmtYzabgN69DecNJ5Oi5qjnetG9fWhbFj5m
         N5Ct3zR9Fk7NDo438EILWXq6NSxfqQdhWWhQ3fGUdMeQ44RgBdEZzkrjS+J4DJtlcQ8r
         zOnrMRArk+g+IzgXXK68SZTsekd6Jy8D6M8SiNmSeIQa/QKYpDzs14YozSGg4bkQXNGN
         iWYyUCjYwcnhjXPjJ+dXpqyFZ3zuoMuQgVn4TR88gZdiDGAN38kUcz+15dKib/u7jTHV
         xqrZkPGPNk67J7PZRnINztd0g10p50wO73nf8Q6PlDGlSgC3QQKPSr16MYqCvJpciu2Q
         iT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWgA+/2pIvQjK41iFHFvWRydEbuLY4ATf1zz+o+sHkg=;
        b=aCtNPx/Kijt5W9jb9Idj4SacwJe+oPLZ8LaCQ+8Q2FzNRr909ITmlP6NchTfqibIZZ
         AmJNRDWVJYXZChZZ7eod9nsSVjuNfQP9CJDciMhtyJsJRK174Qjq2NBQ+goxe8Y++PiT
         bYee1RJ/lTwwTqR/fczfRDls3i4WmDxsqcShJRU8xLfsrmMjbZWe4GahHAgdoR1XQdeB
         wUnvCb1DP6dObdS8xm0CT9rvR27f4/iMmWbEteKlfyX5Wx8iY6jqvP8DP1QyRJScFHkk
         u5ctIRslDSeg5M2+wWiIR1al6uqg4R+4+aZYn/tzpKYeB3Q9ckDl5phmaH1BZerJyufV
         SA6g==
X-Gm-Message-State: AOAM531+zVd2gVsk9nr1tE00gLjSpw5Iso1bISbYhoc98KfQ23g2jlhi
        gYkBtnM3+d2Pa0LoyX0Rk8OgwUolK36HasCj1K1XiPb1
X-Google-Smtp-Source: ABdhPJx2TmLsBfcXAH8Vy6ycK8RhPLPK77wb5qOUOUpIZjUxkW+ZYg2w12uN9qj8lGLEztjf95g+mZGCd1hDW8QotaE=
X-Received: by 2002:a92:cd8a:0:b0:2c8:60b7:bed9 with SMTP id
 r10-20020a92cd8a000000b002c860b7bed9mr5433955ilb.252.1648228058675; Fri, 25
 Mar 2022 10:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop> <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com>
 <8735jjw4rp.fsf@brennan.io> <YjDT498PfzFT+kT4@kernel.org> <878rt9hogh.fsf@brennan.io>
In-Reply-To: <878rt9hogh.fsf@brennan.io>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 25 Mar 2022 10:07:27 -0700
Message-ID: <CAEf4BzbiFNnsu9pji5ifzj4nVEyAYYdqP=QVZ3XFwzL48prP3A@mail.gmail.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
To:     Stephen Brennan <stephen@brennan.io>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        bpf <bpf@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 16, 2022 at 11:11 PM Stephen Brennan <stephen@brennan.io> wrote:
>
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> [...]
> >> I think that kallsyms, BTF, and ORC together will be enough to provide a
> >> lite debugging experience. Some things will be missing:
> >
> >> - mapping backtrace addresses to source code lines
> >
> > So, BTF has provisions for that, and its present in the eBPF programs,
> > perf annotate uses it, see tools/perf/util/annotate.c,
> > symbol__disassemble_bpf(), it goes like:
> >
> >         struct bpf_prog_linfo *prog_linfo = NULL;
> >
> >         info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
> >                                                  dso->bpf_prog.id);
> >         if (!info_node) {
> >                 ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> >                 goto out;
> >         }
> >         info_linear = info_node->info_linear;
> >         sub_id = dso->bpf_prog.sub_id;
> >
> >         info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
> >         info.buffer_length = info_linear->info.jited_prog_len;
> >
> >         if (info_linear->info.nr_line_info)
> >                 prog_linfo = bpf_prog_linfo__new(&info_linear->info);
> >
> >                 addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
> >                 count = disassemble(pc, &info);
> >
> >                 if (prog_linfo)
> >                         linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
> >                                                                 addr, sub_id,
> >                                                                 nr_skip);
> >                               if (linfo && btf) {
> >                         srcline = btf__name_by_offset(btf, linfo->line_off);
> >                         nr_skip++;
> >                 } else
> >                         srcline = NULL;
> >
> > etc.
> >
> > Having this for the kernel proper is thus doable, but then we go on
> > making BTF info grow.
> >
> > Perhaps having this as optional, distros or appliances wanting to have a
> > kernel with this extra info would add it and then tools would use it if
> > available?
>
> I didn't know about the source code mapping support! And I certainly see
> the utility of it for BPF programs. However, I'm not sure that a "lite"
> kernel debugging experience *needs* source line mapping. I suppose I
> should have made it more clear, but I don't think of that list of
> "missing" features as a checklist of things we'd want feature parity
> for.
>
> The advantage of BTF for debugging would be that it is small, and that
> it is part of the kernel image without referencing any other file,
> build-id, or kernel version. Ideally, a debugger could load a crash dump
> with no additional information, and support a reasonable level of
> debugging. I think looking up typed data structure values via global
> symbols is part of that level, as well as simple backtraces and other
> memory access.
>
> I wouldn't want to try to re-implement DWARF for debuginfo. If you have
> the DWARF debuginfo, then your experience should be much better.
>
> >> - intelligent stack frame information from DWARF CFI (e.g.
> >>   register/variable values)
> >> - probably other things, I'm not a DWARF expert.
> [...]
> >> > Currently on my local machine, the vmlinux BTF's size is 4.2MB and
> >> > adding 1MB would be a big increase. CONFIG_DEBUG_INFO_BTF_ALL is a good
> >> > idea. But we might be able to just add global variables without this
> >> > new config if we have strong use case.
> >
> >> And unfortunately 1MiB is really just a shot in the dark, guessing
> >> around 70k variables with no string data.
> >
> > Maybe we can have a separate BTF file with all this extra info that
> > could be fetched from somewhere, keyed by build-id, like is now possible
> > with debuginfod and DWARF?
>
> For me, this ranges into the territory of duplicating DWARF. If you lose
> the one key advantage of "debuginfoless debugging", then you might as
> well use the build-id to lookup DWARF debuginfo as we can today.
>
> This is why I'm trying to propose the means of combining the kallsyms
> string data with BTF. Anything that can make the overall size increase
> manageable so that all the necessary data can stay in the kernel image.

I think this quirk of using kallsyms strings is a no-go. But we should
experiment and see how much bigger BTF becomes when including all the
variables. Can you try to prototype pahole's support for this? As you
said, we can guard this extra information with KConfig and pahole
flags, so distros can always opt-out of bigger BTF if that's too
prohibitive. As it is right now, without firm understanding how big
the final BTF is it's hard to make a good decision about go or no-go
for this.

As for including source code itself, it going to be prohibitively
huge, so it's probably out of the question for now as well.

>
> Thanks,
> Stephen
