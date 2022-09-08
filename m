Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2635C5B27C6
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 22:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIHUfZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIHUfY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 16:35:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE8C5F7C5;
        Thu,  8 Sep 2022 13:35:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z17so12693268eje.0;
        Thu, 08 Sep 2022 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SNgD9OT6RcD4kQFejhxXeO9dxZOjMwO4MJs4p9XvJGg=;
        b=K9KK5+khQwnCnFJ0VDgcYEYtmwrm83d77Hwsb4aj1W9cVdpohxrSfqi/jgFvLr3KGT
         3o19C1JKzDlKqK9wKA837WZfCZnUxVoDhzOhJfeSwhF+wy8AIyynywSx7tJSGPf1k08H
         ZOUPCjN23a2nFiZa/oTEskoKBPXs3RLiUKdNh9iqFG6tayb3IzE38TifFwi8TveJalfp
         YVRL1bKF6/1yB8I1y/Yg/LRWgfQ+iEzNkvJIYbJKiMhUSCePj8kfFWGysyxVMtHYIbW8
         V3GR6fKmpHmIiwyuJZQjT8IqfnPi8AS7251PdKNuajjyes694YG+zUIWql9Bju6Kyj4z
         QBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SNgD9OT6RcD4kQFejhxXeO9dxZOjMwO4MJs4p9XvJGg=;
        b=iql+xEOLgJaBRYHI+ApTUElrAcx/xg92a407XizfGcCSi00kyvhkrYZ0ijgf5wmhZJ
         o5ySiimJ2abnSECbmyXUvo5P9vzayfx4sNbUFwPtOcAP6Wla7ZhWOb9XuaApkgm49E7X
         ofIU2/CiT94BpUKXSrYSlCF9EUAuVc3FNhkrtyOFm/dDjZ0j1pkb4J3hxqO7XRCr9QlB
         mV2gP3ubgVkbc4K2j9gdAywwzml/2FP1Dv7/GyqcF2KB4rGy1w9RC+4S5DwRaOEaM6XB
         sH39BeLYLeECar/0udo8jGFcQg6whEnIfs6VV1GDum7xOsgup7p8abUu51uAPg7RCM+1
         ELgA==
X-Gm-Message-State: ACgBeo3scp/VXeXPyC/dqV5LjoQ8ofhezzslPWGmAxLMo+BqDPIOeCzY
        zBFU5O3X7LtZcEECGmF5nJAMTRK2uz4IA7a8uFo=
X-Google-Smtp-Source: AA6agR49ih8mcdhQkCrkWpdGYTHETt7LV3q0ck77mmw90jXDqUdJETTWi052mPQ4qvsPqwXrDK3hQPF7U22y18yXlhg=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr7458394ejc.676.1662669321059; Thu, 08
 Sep 2022 13:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
 <CAADnVQKbK__y8GOD4LqaX0aCgT+rtC5aw54-02mSZj1-U6_mgw@mail.gmail.com>
 <87sfl3j966.fsf@oracle.com> <CAADnVQKbf5nEBnuSLmfZ_kGLmUzeD5htc1ezbJsVg72adF4bLw@mail.gmail.com>
 <87v8pylukf.fsf@oracle.com>
In-Reply-To: <87v8pylukf.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Sep 2022 13:35:09 -0700
Message-ID: <CAADnVQJCQdL4j1FFdSE=K6mUaoVGJkcVK-xzgJ_5MSvb2tEkFw@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/7] Add support for generating BTF for all variables
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
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

On Wed, Sep 7, 2022 at 2:54 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> > On Wed, Sep 7, 2022 at 12:07 PM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >>
> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >> > On Fri, Aug 26, 2022 at 11:54 AM Stephen Brennan
> >> > <stephen.s.brennan@oracle.com> wrote:
> >> [...]
> >> >> Future Work
> >> >> -----------
> >> >>
> >> >> If this proves acceptable, I'd like to follow-up with a kernel patch to
> >> >> add a configuration option (default=n) for generating BTF with all
> >> >> variables, which distributions could choose to enable or not.
> >> >>
> >> >> There was previous discussion[3] about leveraging split BTF or building
> >> >> additional kernel modules to contain the extra variables. I believe with
> >> >> this patch series, it is possible to do that. However, I'd argue that
> >> >> simpler is better here: the advantage for using BTF is having it all
> >> >> available in the kernel/module image. Storing extra BTF on the
> >> >> filesystem would break that advantage, and at that point, you'd be
> >> >> better off using a debuginfo format like CTF, which is lightweight and
> >> >> expected to be found on the filesystem.
> >> >
> >> > With all or nothing approach the distros would have a hard choice
> >> > to make whether to enable that kconfig, increase BTF and consume
> >> > extra memory without any obvious reason or just don't do it.
> >> > Majority probably is not going to enable it.
> >> > So the feature will become a single vendor only and with
> >> > inevitable bit-rot.
> >>
> >> I'd intend to support it even if just a single distribution enabled it.
> >> But I do see your concern.
> >
> > This thread was dormant for 8 days.
> > That's a poor example of "intend to support".
>
> You're right, I definitely could have replied sooner. I'm sorry for that.
>
> >> > Whereas with split BTF and extra kernel module approach
> >> > we can enable BTF with all global vars by default.
> >> > The extra module will be shipped by all distros and tools
> >> > like bpftrace might start using it.
> >>
> >> Split BTF is currently limited to a single base BTF file. We'd need more
> >> patches for pahole to support multiple --btf_base files: e.g.
> >> vmlinux.btf and vmlinux-variables.btf. There's also the question of
> >> modules: presumably we wouldn't try to have "$MODULE" and
> >> "$MODULE-btf-extra" modules due to the added complexity. I doubt the
> >> space savings would be worth it.
> >>
> >> I can look into these concerns, but if possible I would like to proceed
> >> with this series, as it is a separate concern from the exact mechanism
> >> by which we include extra BTF into the kernel.
> >
> > Not an option. Sorry.
>
> Ok, so let me describe what I understand to be the proposed design as of
> the previous thread, and see if it satisfies your concerns. We can work
> from there to make sure we've got a concensus design before going
> further.

I was hoping Andrii and others will provide their opinion.
Here are my .02

> Option #1
> ---------
>
> * A new module, "vmlinux-btf-extra" (or something roughly like that) is
>   added, which contains BTF only. It is generated with
>   --encode_all_btf_vars and uses --btf_base=path/to/vmlinux_btf so that
>   it contains only BTF variables. The vmlinux BTF would be generated
>   same as always (without the --encode_all_btf_vars).
>
> * In the previous thread, it was proposed [1] that modules could
>   include variables in their BTF in order to reduce the complexity of
>   the change. Modules would have their BTF generated using
>   --encode_all_btf_vars and --btf_base=path/to/vmlinux_btf. The
>   resulting hierarchy would look like this:
>
>   vmlinux_btf  [ functions and percpu vars only ]
>   |- vmlinux-btf-extra [ all other vars for vmlinux ]
>   |- $MODULE   [ functions and all vars ]
>   ...
>
> This option is desirable because it means that we only need 2-level
> split BTF, and so we don't actually need to make changes to pahole for
> multiple --btf_base files. There are two downsides I see:
>
> (a) While we save space on vmlinux BTF, each module will have a bit of
>     extra data for variable types. On my laptop (5.15 based) I have 9.8
>     MB of BTF, and if you deduct vmlinux, you're still left with 4.7 MB.
>     If we assume the same overhead of 23.7%, that would be 1.1 MB of
>     extra module BTF for my particular use case.
>
>     $ ls -l /sys/kernel/btf | awk '{sum += $5} END {print(sum)}'
>     9876871
>     $ ls -l /sys/kernel/btf/vmlinux
>     -r--r--r-- 1 root root 5174406 Sep  7 14:20 /sys/kernel/btf/vmlinux
>
> (b) It's possible for "vmlinux-btf-extras" and "$MODULE" to contain
>     duplicate type definitions, wasting additional space. However, as
>     far as I understand it, this was already a possibility, e.g.
>     $MODULE1 and $MODULE2 could already contain duplicate types. So I
>     think this downside is no more.

Both concerns are valid, but I'm a bit puzzled with (a).
At least in the networking drivers the number of global vars is very small.
I expected other drivers to be similar.
So having "functions and all vars" in ko-s should not add
that much overhead.

Maybe you're seeing this overhead because pahole is adding
all declared vars and not only the vars that are actually present?
That would explain the discrepancy.
(b) with a bunch of duplicates is a sign that something is off as well.

>
>
> Option #2
> ---------
>
> * The vmlinux-btf-extra module is still added as in Option #1.
>
> * Further, each module would have its own "$MODULE-btf-extra" module to
>   add in extra BTF. These would be built with a --btf_base=$MODULE.ko
>   and of course that BTF is based on vmlinux, so we would have:
>
>   vmlinux_btf              [ functions and percpu vars only ]
>   |- vmlinux-btf-extras    [ all other vars for vmlinux ]
>   |- $MODULE               [ functions and percpu vars only ]
>      |- $MODULE-btf-extra  [ all  other vars for $MODULE ]
>
> This is much more complex, pahole must be extended to support a
> hierarchy of --btf_base files. The kernel itself may not need to
> understand multi-level BTF since there's no requirement that it actually
> understand $MODULE-btf-extra, so long as it exposes it via
> /sys/kernel/btf/$MODULE-btf-extra. I'd also like to see some sort of
> mechanism to allow an administrator to say "please always load
> $MODULE-btf-extras alongside $MODULE", but I think that would be a
> userspace problem.
>
> This resolves issue (a) from option #1, of course at implementation
> cost.
>
> Regardless of Option #1 or #2, I'd propose that we implement this as a
> tristate, similar to what Alan proposed [2]. When set to "m" we use the
> solutions described above, and when set to "y", we don't bother with it,
> instead using --encode_all_btf_vars for all generation.
>
> If we go with Option #1, no changes to this series should be necessary.
> If we go with Option #2, I'll need to extend pahole to support at least
> two BTF base files. Please let me know your thoughts.

Completely agree that two level btf-extra needs quite a bit more work.
Before we proceed with option 2 let's figure out
the reason for extra space in option 1.
