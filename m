Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04084DB594
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 17:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiCPQHe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiCPQHd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 12:07:33 -0400
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FEF5AEF2
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 09:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1647446768; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=c6E64swYfAMj3jaZGllyRYT42/i4gp/Zxwk6T8vgnC2PqZvK5Rsa/WN1H2xlcwHJ4rWb7i/J5t5CjI40q7bQFPsyzlR3fFMK19kEGYDY2NMiWa6MFsUG/bx3+fcNcMqLZTr9WOhn8kmPnK/81FGxml4CnOypcNo1/QID5KUz+w0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1647446768; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nLE4s/b0K7t6e6CvPQ0PX43i02G/GBAZnV92cGCqigk=; 
        b=GHo8VgKwPw3aYU57lDxt+4tCWBUpO1t8x8W+8LvRfL9Dcb0h0crOeYVDYRAw5IYzHoAOT9z0+U1/e8exrTmpC2OjqDaPpDKrBE7oJRXAFf/i51LlOjIBG0kap0MazPfIxY6LqOgw0ovgEuawioqXKxH7Z0+DEmgZYaQpoJRJoMI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1647446768;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
        bh=nLE4s/b0K7t6e6CvPQ0PX43i02G/GBAZnV92cGCqigk=;
        b=esdqnTZdiVBt4svU8C5RLIgwTsE0wkBTW9GuEm0C/jxjyoC+2IuOkHdK6Gaaw2Nd
        KKNRL0+h4wIMuFBxs/1+o5g2tYJnklLck6sfeFBiNMaQ5SnOaCRpPenigPBvBv+FaFb
        5HT41cnCKx1ZJYA446RxsooRR1EIyRsTKPdMPLYw=
Received: from localhost (192-80-2-21.cab.webpass.net [192.80.2.21]) by mx.zohomail.com
        with SMTPS id 1647446767288683.4829321789126; Wed, 16 Mar 2022 09:06:07 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        bpf@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
In-Reply-To: <YjDT498PfzFT+kT4@kernel.org>
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop>
 <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com> <8735jjw4rp.fsf@brennan.io>
 <YjDT498PfzFT+kT4@kernel.org>
Date:   Wed, 16 Mar 2022 09:06:06 -0700
Message-ID: <878rt9hogh.fsf@brennan.io>
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

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
[...]
>> I think that kallsyms, BTF, and ORC together will be enough to provide a
>> lite debugging experience. Some things will be missing:
>
>> - mapping backtrace addresses to source code lines
>
> So, BTF has provisions for that, and its present in the eBPF programs,
> perf annotate uses it, see tools/perf/util/annotate.c,
> symbol__disassemble_bpf(), it goes like:
>
>         struct bpf_prog_linfo *prog_linfo = NULL;
>
>         info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
>                                                  dso->bpf_prog.id);
>         if (!info_node) {
>                 ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
>                 goto out;
>         }
>         info_linear = info_node->info_linear;
>         sub_id = dso->bpf_prog.sub_id;
>
>         info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
>         info.buffer_length = info_linear->info.jited_prog_len;
>
>         if (info_linear->info.nr_line_info)
>                 prog_linfo = bpf_prog_linfo__new(&info_linear->info);
>
>                 addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
>                 count = disassemble(pc, &info);
>
>                 if (prog_linfo)
>                         linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
>                                                                 addr, sub_id,
>                                                                 nr_skip);
> 		                if (linfo && btf) {
>                         srcline = btf__name_by_offset(btf, linfo->line_off);
>                         nr_skip++;
>                 } else
>                         srcline = NULL;
>
> etc.
>
> Having this for the kernel proper is thus doable, but then we go on
> making BTF info grow.
>
> Perhaps having this as optional, distros or appliances wanting to have a
> kernel with this extra info would add it and then tools would use it if
> available?

I didn't know about the source code mapping support! And I certainly see
the utility of it for BPF programs. However, I'm not sure that a "lite"
kernel debugging experience *needs* source line mapping. I suppose I
should have made it more clear, but I don't think of that list of
"missing" features as a checklist of things we'd want feature parity
for.

The advantage of BTF for debugging would be that it is small, and that
it is part of the kernel image without referencing any other file,
build-id, or kernel version. Ideally, a debugger could load a crash dump
with no additional information, and support a reasonable level of
debugging. I think looking up typed data structure values via global
symbols is part of that level, as well as simple backtraces and other
memory access.

I wouldn't want to try to re-implement DWARF for debuginfo. If you have
the DWARF debuginfo, then your experience should be much better.

>> - intelligent stack frame information from DWARF CFI (e.g.
>>   register/variable values)
>> - probably other things, I'm not a DWARF expert.
[...]
>> > Currently on my local machine, the vmlinux BTF's size is 4.2MB and
>> > adding 1MB would be a big increase. CONFIG_DEBUG_INFO_BTF_ALL is a good
>> > idea. But we might be able to just add global variables without this
>> > new config if we have strong use case.
>  
>> And unfortunately 1MiB is really just a shot in the dark, guessing
>> around 70k variables with no string data.
>
> Maybe we can have a separate BTF file with all this extra info that
> could be fetched from somewhere, keyed by build-id, like is now possible
> with debuginfod and DWARF?

For me, this ranges into the territory of duplicating DWARF. If you lose
the one key advantage of "debuginfoless debugging", then you might as
well use the build-id to lookup DWARF debuginfo as we can today.

This is why I'm trying to propose the means of combining the kallsyms
string data with BTF. Anything that can make the overall size increase
manageable so that all the necessary data can stay in the kernel image.

Thanks,
Stephen
