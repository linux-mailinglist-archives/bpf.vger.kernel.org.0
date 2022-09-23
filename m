Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D623F5E865B
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiIWXjP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 19:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiIWXjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:39:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E13120BF2;
        Fri, 23 Sep 2022 16:39:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l14so3623346eja.7;
        Fri, 23 Sep 2022 16:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=O2WS419477RItHrjYJA066CK5ec0ER13Ochk3uWzcRw=;
        b=YtDNWo8aa2e8EPr0eQx490+jhBz3mbtQYz8NiyRRatYXl7k0Wq4xk8CeMtW3ERnHoy
         6rfqmphNYr2PU5hreqrDBrOBvbhNQayGvC2bILAwjTu0sTvkAHrHZ5TjvqcuMQLvoAkm
         w8X90awComo5FeBolI9Dhyiao1dhrKYu+rutmywQFF3B+L57VhDE43X6HRrD/bH/WsPx
         2305yT+PU0tssuAaSs1+77DkApop9cQbGvCNUzL6zjv9dvf9ZPXPWqPuNZEeCZHxHgqf
         dPssdBt4YkfsSzuXDZ8J70mkcSOf1oRxN/dstBWrHD1/w1jMQjSlm9KEIS2ZZ7T35GSU
         LJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O2WS419477RItHrjYJA066CK5ec0ER13Ochk3uWzcRw=;
        b=Wv/fr9pfeyvlOL/Cj3V9NUzrRK4EV4NNNlWeN9miOmPXAF0K/TtwUwCLd3mQOi4QeH
         fIxO40tbPB7lJcT0qcbK2Onho31IhAKPHqVaTJRRKbck62e2/EIYhu3Tqb4PN+moAtI7
         7lH1Kvys1xm0BpPrVj4ebG7UX5dI0LCKJs1KqcGIELRrjqAeARRW0Oeqtoiia4W/13R3
         zSaff4CBE5IJHT97KPfXQ8manyDaumBz0cBxNEXdCbFlJm94SplS07liudkg/MXJw1w7
         65cNxv0SC2NHoiaN1fa/szXeRzeMQ97K1hieboUaQiPtb8qYkIvSeuMmsnjHFYtr9ofG
         9yqA==
X-Gm-Message-State: ACrzQf3GUY7KJBvgcTZy0nZ7q36UB2ntA0Q4U7gw0lyQ89OwyeFFgfPo
        1h4eUNedgJRuMcrQxqEqTz9/gdSSzRi/3O0iNFCPwmDG
X-Google-Smtp-Source: AMsMyM7OLyR4LnIvYk7o59+lejA7K4po6/bsGPZRTtaJhoSZDyjJYvAqsJQrs2o7GvfckC0lC8AIN3SRnCTQLQ58RuY=
X-Received: by 2002:a17:907:3fa9:b0:782:ed33:df8d with SMTP id
 hr41-20020a1709073fa900b00782ed33df8dmr904241ejc.745.1663976351222; Fri, 23
 Sep 2022 16:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
 <CAADnVQKbK__y8GOD4LqaX0aCgT+rtC5aw54-02mSZj1-U6_mgw@mail.gmail.com>
 <87sfl3j966.fsf@oracle.com> <CAADnVQKbf5nEBnuSLmfZ_kGLmUzeD5htc1ezbJsVg72adF4bLw@mail.gmail.com>
 <87v8pylukf.fsf@oracle.com> <CAADnVQJCQdL4j1FFdSE=K6mUaoVGJkcVK-xzgJ_5MSvb2tEkFw@mail.gmail.com>
 <87sfl0l4z7.fsf@oracle.com>
In-Reply-To: <87sfl0l4z7.fsf@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 16:38:59 -0700
Message-ID: <CAEf4Bzac5H0hfTCLa+hDP=ct_7fEOfUfyuC5TQ5mUk0xK3_DDw@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/7] Add support for generating BTF for all variables
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 12:31 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> >> (a) While we save space on vmlinux BTF, each module will have a bit of
> >>     extra data for variable types. On my laptop (5.15 based) I have 9.8
> >>     MB of BTF, and if you deduct vmlinux, you're still left with 4.7 MB.
> >>     If we assume the same overhead of 23.7%, that would be 1.1 MB of
> >>     extra module BTF for my particular use case.
> >>
> >>     $ ls -l /sys/kernel/btf | awk '{sum += $5} END {print(sum)}'
> >>     9876871
> >>     $ ls -l /sys/kernel/btf/vmlinux
> >>     -r--r--r-- 1 root root 5174406 Sep  7 14:20 /sys/kernel/btf/vmlinux
> >>
> >> (b) It's possible for "vmlinux-btf-extras" and "$MODULE" to contain
> >>     duplicate type definitions, wasting additional space. However, as
> >>     far as I understand it, this was already a possibility, e.g.
> >>     $MODULE1 and $MODULE2 could already contain duplicate types. So I
> >>     think this downside is no more.
> >
> > Both concerns are valid, but I'm a bit puzzled with (a).
> > At least in the networking drivers the number of global vars is very small.
> > I expected other drivers to be similar.
> > So having "functions and all vars" in ko-s should not add
> > that much overhead.
> >
> > Maybe you're seeing this overhead because pahole is adding
> > all declared vars and not only the vars that are actually present?
> > That would explain the discrepancy.
> > (b) with a bunch of duplicates is a sign that something is off as well.
>
> Sorry, I didn't actually have an analysis for module BTF, I was just
> extrapolating the result I had seen for vmlinux. I went ahead and did a
> proper test, generating BTF for a distribution kernel from Oracle Linux
> (kernel-uek-5.15.0-1.43.4.1.el9uek.x86_64) - something that I easily had
> on hand and could regenerate the BTF for quickly.
>
> Basically, the steps were:
>
>     pahole -J vmlinux --btf_encode_detached=vmlinux.btf
>     pahole -J vmlinux --btf_encode_detached=vmlinux.btf.all \
>            --encode_all_btf_vars
>
>     # For each module
>     pahole -J $MODULE --btf_encode_detached=$MODULE.btf \
>            --btf_base=vmlinux.btf
>     pahole -J $MODULE --btf_encode_detached=$MODULE.btf.all \
>            --btf_base=vmlinux.btf --encode_all_btf_vars
>
>     # what if we based the module BTF on the "vmlinux.btf.all" instead?
>     pahole -J $MODULE --btf_encode_detached=$MODULE.btf.all.all \
>            --btf_base=vmlinux.btf.all --encode_all_btf_vars
>
> And then using ls/awk to sum up the bytes of each BTF file. Results are:
>
> vmlinux:
>
> -rw-r-----. 1 opc opc 4904193 Sep  9 18:58 vmlinux.btf
> -rw-r-----. 1 opc opc 6534684 Sep  9 18:58 vmlinux.btf.all
>
> In this case there's a 33% increase in BTF size.
>
> modules:
>
> $ ls -l *.btf | awk '{sum += $5} END {print(sum)}'
> 43979532
> $ ls -l *.btf.all | awk '{sum += $5} END {print(sum)}'
> 44757792
> $ ls -l *.btf.all.all | awk '{sum += $5} END {print(sum)}'
> 44696639
>
> So the "*.btf.all.all" modules were just an experiment to see if the
> extra data inside "vmlinux.btf.all" could reduce some duplication in
> module BTF. The answer was yes, but not enough to make up for the
> increase in the vmlinux BTF size.
>
> The "*.btf.all" modules are the ones we would actually expect to use in
> Option #1, where we have a vmlinux-btf-extras and the rest of the
> modules include their globals in their BTF sections directly, and are
> based off of the vmlinux BTF. This test shows on average, that the
> module BTF size would grow by 1.6% with Option #1. Of course the exact
> memory size that accounts for will vary by workload, depending on how
> many modules are loaded. But I'd imagine, assuming you have around 5MB
> of module BTF *actually loaded*, then the overhead would be around 85k
> bytes.  I don't know about how you feel, but I think that sounds
> acceptable, it's just 22 pages at 4k size :)
>
> Let me know how it sounds to you.
>
> Thanks,
> Stephen
>
> >>
> >>
> >> Option #2
> >> ---------
> >>
> >> * The vmlinux-btf-extra module is still added as in Option #1.
> >>
> >> * Further, each module would have its own "$MODULE-btf-extra" module to
> >>   add in extra BTF. These would be built with a --btf_base=$MODULE.ko
> >>   and of course that BTF is based on vmlinux, so we would have:
> >>
> >>   vmlinux_btf              [ functions and percpu vars only ]
> >>   |- vmlinux-btf-extras    [ all other vars for vmlinux ]
> >>   |- $MODULE               [ functions and percpu vars only ]
> >>      |- $MODULE-btf-extra  [ all  other vars for $MODULE ]
> >>
> >> This is much more complex, pahole must be extended to support a
> >> hierarchy of --btf_base files. The kernel itself may not need to
> >> understand multi-level BTF since there's no requirement that it actually
> >> understand $MODULE-btf-extra, so long as it exposes it via
> >> /sys/kernel/btf/$MODULE-btf-extra. I'd also like to see some sort of
> >> mechanism to allow an administrator to say "please always load
> >> $MODULE-btf-extras alongside $MODULE", but I think that would be a
> >> userspace problem.
> >>
> >> This resolves issue (a) from option #1, of course at implementation
> >> cost.
> >>
> >> Regardless of Option #1 or #2, I'd propose that we implement this as a
> >> tristate, similar to what Alan proposed [2]. When set to "m" we use the
> >> solutions described above, and when set to "y", we don't bother with it,
> >> instead using --encode_all_btf_vars for all generation.
> >>
> >> If we go with Option #1, no changes to this series should be necessary.
> >> If we go with Option #2, I'll need to extend pahole to support at least
> >> two BTF base files. Please let me know your thoughts.
> >
> > Completely agree that two level btf-extra needs quite a bit more work.
> > Before we proceed with option 2 let's figure out
> > the reason for extra space in option 1.

I don't think an extra module for each module just for keeping those
all-var-BTFs is acceptable, so Option #2 doesn't even seem like an
option.

But given a very small increase in size of BTF for modules when
including variables, I think Option #1 is quite reasonable.
