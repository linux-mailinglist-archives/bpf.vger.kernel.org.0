Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9211E6CFB
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 22:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407444AbgE1U64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 16:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407425AbgE1U6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 16:58:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DDFC08C5C6
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 13:58:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q8so259315qkm.12
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2fY9YymXzrw7LU6lLyvoWgWwgRDO5sayxiT5HA4ckPI=;
        b=FVjFsBjc8s71ABUepwnW8TuA73DC9HFLn0ePRFr69H8/wzpdOCMTAZxYEPgsOaz82a
         c8BrLWOaD85zw3E1lQdZgpbsLFSNljVBpvYI/hJPDBDMWCFjP8psvwwb98LWn77WDEBk
         qSJlsqr4CFjJqFFmXhuJ1YNVgFTZOmLEG2U9jQboHDmbHx6Fup9+wVgtFQAefPpweB41
         dYPCYR7mF2NhgKNDxu3oHvDULJwWE0/bprHA55Ix8fveLP6hO6AtG7QcYTLTB4kXW1K0
         621N8EJgpkioTZTTnHJHyxIB2kc6AYKnoMcxIrswbGa0UnL09BMa9IouY0XU6piUgo87
         RfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2fY9YymXzrw7LU6lLyvoWgWwgRDO5sayxiT5HA4ckPI=;
        b=V+1CfLXDtleA/4xuiFD70qgKZTQHEup3QOG4CZ7zAjwpBdxuCskyqR5VctTWiSZ8ER
         jitoDeQwF87fj5i/ijDkSyDG65A1RcX4l59g8YRKBVQiGNJDfYynvwzqXHqzTrjHT+U1
         SXIBXLYDhcpH50//oiwS+MuXcAkDlsTAb5xrzgxdCprmK5FvSIXC0OfViL8jpRXgdw6e
         50/E6o8lVyN+CTPyZx5UHtCy26o3YFrgVOoRggOEwZya5HyOj5MmyWnseivcDYlKK0OL
         sSqV6ZCz+nyPKZtG9hX5yrnfz+/kLU4nzZzw1S0AvYeS3BQuxITfvJ0MOidekg2Hju1A
         zTrw==
X-Gm-Message-State: AOAM530DUPBvFh0H8A16jniBcrR6urYHv1/8tPhUdBinbPPGouUepSBk
        RVYE9MsJne4OXv9h68RL+mJ14brRmkgsB9klcWg=
X-Google-Smtp-Source: ABdhPJwMjlzVSWtKRHC5uHBCT6fSMVhGR3rAZCboptrmojlUvqkvZy1Zo3fYuGtiLGKXOREqM/0GWONe1ccuYeZVKOE=
X-Received: by 2002:a05:620a:12d2:: with SMTP id e18mr5089986qkl.437.1590699530661;
 Thu, 28 May 2020 13:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQJwqH2XFnTeXLnqbONtaU3akNh9BZ-tXk8r=NcGGY_noQ@mail.gmail.com>
 <CAEf4BzZVVgMbNE4d7b5kPUoWPJz-ENgyP1BfC+h-X29r1Pk2fA@mail.gmail.com>
 <20200522142813.GF14034@kernel.org> <CA+khW7j=ejncVYgY=hKEnkrkwA=Wjwa6Y2PFWgzrV1EV_8rvpw@mail.gmail.com>
 <CAEf4Bza9TP50Rtdg1s2qZ7t4547wQr=E-72_6m81ZX8vwZOPEA@mail.gmail.com>
 <CA+khW7ha-5YSgm5kARO=+JEtf-Ahmc1N_TBJ2iLSntk12pfy3w@mail.gmail.com> <CA+khW7hqemc+xsbMQq-DW3X+mHKO+Lm64hNpWNRyZ75MkUa0Gg@mail.gmail.com>
In-Reply-To: <CA+khW7hqemc+xsbMQq-DW3X+mHKO+Lm64hNpWNRyZ75MkUa0Gg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 May 2020 13:58:39 -0700
Message-ID: <CAEf4BzZo7RMQb6HzhqROLjTASXzfCi82f4-ySRBN2UshR73KEA@mail.gmail.com>
Subject: Re: accessing global and per-cpu vars
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Oleg Rombakh <olegrom@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 28, 2020 at 1:51 PM Hao Luo <haoluo@google.com> wrote:
>
> A quick update on this thread.
>
> I came up with a draft patch that fulfills step 1. I added a ".ksym" sect=
ion for extern vars. The libbpf fills these vars' values by reading /proc/k=
allsyms at load time. I think I am going to upload this patch for review to=
gether with step 3 and 4 after I work them out.
>
> Regarding step 2, I have also worked out a patch in pahole that inserts t=
he kernel's percpu vars into BTF. I realized, because step 2 happens at com=
pile time, there is no kallsyms file available to extract symbols, so we ha=
ve to read the global vars from vmlinux. Currently on v5.7-rc7, I was able =
to extract 291 percpu vars, static or global. The .BTF size increases from =
2d2c10 to 2d4dd0. A clean build on my local workstation increases from 10m1=
3s to 11m24s (wall time). Common global percpu vars can be found in .BTF.

For humans among us, that's 8640 bytes increase, it seems, not a big
deal at all. Have you checked how much would it increase if you
include not just per-cpu variables?

Also I wonder what adds more than a minute to the build process? Is it
all pahole's BTF generation step? If yes, why it's so much slower now?

>
> haoluo@haoluo:~/kernel/tip/pkgs/images/boot$ bpftool btf dump file vmlinu=
x-5.7.0-smp-DEV | grep runqueues
>
> [14098] VAR 'runqueues' type_id=3D13725, linkage=3Dglobal-alloc
>
> haoluo@haoluo:~/kernel/tip/pkgs/images/boot$ bpftool btf dump file vmlinu=
x-5.7.0-smp-DEV | grep cpu_stopper
>
> [17589] STRUCT 'cpu_stopper' size=3D72 vlen=3D5
>
> [17609] VAR 'cpu_stopper' type_id=3D17589, linkage=3Dglobal-alloc
>
> Arnaldo, would you please advise on how to upload the pahole patch for re=
view? I am going to polish it a bit and think I can upload it for review.
>
> Thanks,
> Hao
>
> On Tue, May 26, 2020 at 2:04 PM Hao Luo <haoluo@google.com> wrote:
>>
>> I just did some poking and found the source of the format. TLDR is these=
 letters are of the same semantic of 'nm' output [1]. So we can put the sym=
bols of 'A' in BTF first, as these symbols have absolute addresses in runti=
me and it's the safest choice to start with, I think.
>>
>> More details. So during linking for vmlinux, the intermediate obj is pas=
sed to nm and its output is used by the kallsyms to generate a .S file [2].=
 That .S file builds a data blob 'kallsyms_names' in vmlinux [3] which is u=
sed to generate /proc/kallsyms [4]. The types of the symbols are carried fr=
om the output of nm to the kallsyms_names, mostly untouched. The only excep=
tion is, if CONFIG_KALLSYMS_ABSOLUTE_PERCPU is configured, percpu symbols a=
re forced to have absolute addresses.
>>
>> [1] https://linux.die.net/man/1/nm
>> [2] https://github.com/torvalds/linux/blob/master/scripts/link-vmlinux.s=
h#L168
>> [3] https://github.com/torvalds/linux/blob/master/scripts/kallsyms.c#L44=
6
>> [4] https://github.com/torvalds/linux/blob/master/kernel/kallsyms.c#L115
>>
>> On Tue, May 26, 2020 at 11:21 AM Andrii Nakryiko <andrii.nakryiko@gmail.=
com> wrote:
>>>
>>> On Tue, May 26, 2020 at 12:58 AM Hao Luo <haoluo@google.com> wrote:
>>> >
>>> > Hi, Arnaldo and Andrii,
>>> >
>>> > Thanks for taking a look and checking.
>>> >
>>> > On Fri, May 22, 2020 at 7:28 AM Arnaldo Carvalho de Melo <acme@kernel=
.org> wrote:
>>> >>
>>> >> Em Thu, May 21, 2020 at 11:58:47AM -0700, Andrii Nakryiko escreveu:
>>> >> > On Thu, May 21, 2020 at 10:07 AM Alexei Starovoitov <alexei.starov=
oitov@gmail.com> wrote:
>>> >> > > 2. teach pahole to store ' A ' annotated kallsyms into vmlinux B=
TF as
>>> >> > > BTF_KIND_VAR.
>>> >> > > There are ~300 of them, so should be minimal increase in size.
>>> >> >
>>> >> > I thought we'd do that based on section name? Or we will actually
>>> >> > teach pahole to extract kallsyms from vmlinux image?
>>> >>
>>> >> No need to touch kallsyms:
>>> >>
>>> >>   net/core/filter.c
>>> >>
>>> >>   DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
>>> >>
>>> >>   # grep -w bpf_redirect_info /proc/kallsyms
>>> >>   000000000002a160 A bpf_redirect_info
>>> >>   #
>>> >>   # readelf -s ~acme/git/build/v5.7-rc2+/vmlinux | grep bpf_redirect=
_info
>>> >>   113637: 000000000002a2e0    32 OBJECT  GLOBAL DEFAULT   34 bpf_red=
irect_info
>>> >>   #
>>> >>
>>> >> Its in the ELF symtab.
>>> >>
>>> >> [root@quaco ~]# grep ' A ' /proc/kallsyms | wc -l
>>> >> 351
>>> >> [root@quaco ~]# readelf -s ~acme/git/build/v5.7-rc2+/vmlinux | grep =
"OBJECT  GLOBAL" | wc -l
>>> >> 3221
>>> >> [root@quaco ~]#
>>> >>
>>> >> So ' A ' in kallsyms needs some extra info from the symtab in additi=
on
>>> >>
>>> >> to being OBJECT GLOBAL, checking...
>>> >
>>> >
>>> > After playing a bit, I found 'A' symbols in kallsyms include the per_=
cpu variables (e.g. runqueues and sched_clock_data), either global or local=
. An example of the global var is 'runqueues' and the example of local one =
is 'sched_clock_data'.
>>> >
>>> > The OBJECT GLOBAL symbols in vmlinux include the global variables suc=
h as runqueues. It also includes those symbols annotated as other capital l=
etters such as 'R' or 'B' in kallsyms. For example, __per_cpu_offset is OBJ=
ECT GLOBAL in vmlinux and it's annotated as 'R', implying a global const va=
riable.
>>> >
>>> > I think either the vmlinux approach or the kallsyms approach is good =
enough. I will continue experimenting while working on step 1.
>>> >
>>>
>>> /proc/kallsyms is available in runtime (if configured, of course),
>>> while vmlinux image might not be available at runtime at all in some
>>> environments. This is one of the reasons for BTF to be exposed in
>>> runtime through /sys/kernel/btf/vmlinux, instead of just keeping it in
>>> vmlinux image. So I think kallsyms approach is better and more
>>> reliable.
>>>
>>> As for 'A', 'R', 'B', etc. Can we please look at source code of
>>> whatever in kernel defines those lettera in ksyms, instead of guessing
>>> based on a subset of symbols? Guessing like this makes me nervous :)
>>>
>>> > Thanks,
>>> > Hao
>>> >
>>> >>
>>> >> > There was step 1.5 (or even 0.5) to see if it's feasible to add no=
t
>>> >> > just per-CPU variables as well.
>>> >>
>>> >> - Arnaldo
