Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51A71E29EB
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 20:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgEZSVF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 14:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgEZSVF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 14:21:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2E2C03E96D
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 11:21:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b27so11629862qka.4
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yksq0Gk7EO9BQXXQrQv4jc1ibntI1mkpLBx9Ini2KS8=;
        b=TgbvdU4RV8pnvsU+vSZ5+qagtJWoAiz0doNxc7jiC1y8EBCl/n8qzeRhMeGKXcBpLa
         eIiTKYCIRP7rJICMpmV9ccGIo+cUIs8fkfO2R42WixUrd8xng5NzbEOeRQTmo/1zUte+
         9AjV57GV/94WyDyJdI8/vLJVVOAt5r/NEXtdWMe8bPNWlLPoD9ciMncs7myXRBjxoshI
         g7/WEKHSOaipdsQkG2KO1JQE5uSlCjzG8Z2huH9VZHRGB5mXTUFQpWAJUqS/OB3m90v9
         4vwFIl534Q8c9gxJ+QxgD38RHBKK9ofW6vie1ndk2cyA+eiSnX5c3nEUfMALwyfXqd+R
         aojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yksq0Gk7EO9BQXXQrQv4jc1ibntI1mkpLBx9Ini2KS8=;
        b=NnkmV4QgwtzAAV58R1OiODzWV7dmQ3+csRU6rXZ4puzGaqRqYk0eO93Je+MyY/bhPp
         GhYBCw+Wd8WiIWk40ie8JmfFZhvB8JERhevKRumODzKIO5bL/rU4iZGm18PVk+vx8sIe
         sDatGT1zn3ASNxeaxnKj4+hNouXXJzNEdNJo8TSnr+aDIVmA04nK0OqSQlxmUPbx2RBA
         uTgXJZ4Hwo2TCyjX61x+dUV6JHb9yRGj4fGXTxEAiGxoXk8fnhrmF1YT1rg2IR0c/OZP
         E8XShlQnGS1Qzk27ae8+jyyIJvZT+KiL2PqR/Giwq4CpiN48vfkoJyK4S3PiAkPXLN47
         0D6g==
X-Gm-Message-State: AOAM530zNsgBvF1V16BbQSwY+xMzu31Ma1V2TfdGW63hu1CfATQt+xdg
        QvqQX01CzRXnGt6aD3A78l/r12im3ZZa2Gvh+8oeyjVf958=
X-Google-Smtp-Source: ABdhPJxbqQly7YnCUZ3qNS/9EKdBMiwtfuYKQSCv4PkeJmKOH5vymf4t4fb6woQ8/mfkPySvdHQXFQJtYqe+hPIffBA=
X-Received: by 2002:a37:a89:: with SMTP id 131mr130925qkk.92.1590517264459;
 Tue, 26 May 2020 11:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQJwqH2XFnTeXLnqbONtaU3akNh9BZ-tXk8r=NcGGY_noQ@mail.gmail.com>
 <CAEf4BzZVVgMbNE4d7b5kPUoWPJz-ENgyP1BfC+h-X29r1Pk2fA@mail.gmail.com>
 <20200522142813.GF14034@kernel.org> <CA+khW7j=ejncVYgY=hKEnkrkwA=Wjwa6Y2PFWgzrV1EV_8rvpw@mail.gmail.com>
In-Reply-To: <CA+khW7j=ejncVYgY=hKEnkrkwA=Wjwa6Y2PFWgzrV1EV_8rvpw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 11:20:53 -0700
Message-ID: <CAEf4Bza9TP50Rtdg1s2qZ7t4547wQr=E-72_6m81ZX8vwZOPEA@mail.gmail.com>
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

On Tue, May 26, 2020 at 12:58 AM Hao Luo <haoluo@google.com> wrote:
>
> Hi, Arnaldo and Andrii,
>
> Thanks for taking a look and checking.
>
> On Fri, May 22, 2020 at 7:28 AM Arnaldo Carvalho de Melo <acme@kernel.org=
> wrote:
>>
>> Em Thu, May 21, 2020 at 11:58:47AM -0700, Andrii Nakryiko escreveu:
>> > On Thu, May 21, 2020 at 10:07 AM Alexei Starovoitov <alexei.starovoito=
v@gmail.com> wrote:
>> > > 2. teach pahole to store ' A ' annotated kallsyms into vmlinux BTF a=
s
>> > > BTF_KIND_VAR.
>> > > There are ~300 of them, so should be minimal increase in size.
>> >
>> > I thought we'd do that based on section name? Or we will actually
>> > teach pahole to extract kallsyms from vmlinux image?
>>
>> No need to touch kallsyms:
>>
>>   net/core/filter.c
>>
>>   DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
>>
>>   # grep -w bpf_redirect_info /proc/kallsyms
>>   000000000002a160 A bpf_redirect_info
>>   #
>>   # readelf -s ~acme/git/build/v5.7-rc2+/vmlinux | grep bpf_redirect_inf=
o
>>   113637: 000000000002a2e0    32 OBJECT  GLOBAL DEFAULT   34 bpf_redirec=
t_info
>>   #
>>
>> Its in the ELF symtab.
>>
>> [root@quaco ~]# grep ' A ' /proc/kallsyms | wc -l
>> 351
>> [root@quaco ~]# readelf -s ~acme/git/build/v5.7-rc2+/vmlinux | grep "OBJ=
ECT  GLOBAL" | wc -l
>> 3221
>> [root@quaco ~]#
>>
>> So ' A ' in kallsyms needs some extra info from the symtab in addition
>>
>> to being OBJECT GLOBAL, checking...
>
>
> After playing a bit, I found 'A' symbols in kallsyms include the per_cpu =
variables (e.g. runqueues and sched_clock_data), either global or local. An=
 example of the global var is 'runqueues' and the example of local one is '=
sched_clock_data'.
>
> The OBJECT GLOBAL symbols in vmlinux include the global variables such as=
 runqueues. It also includes those symbols annotated as other capital lette=
rs such as 'R' or 'B' in kallsyms. For example, __per_cpu_offset is OBJECT =
GLOBAL in vmlinux and it's annotated as 'R', implying a global const variab=
le.
>
> I think either the vmlinux approach or the kallsyms approach is good enou=
gh. I will continue experimenting while working on step 1.
>

/proc/kallsyms is available in runtime (if configured, of course),
while vmlinux image might not be available at runtime at all in some
environments. This is one of the reasons for BTF to be exposed in
runtime through /sys/kernel/btf/vmlinux, instead of just keeping it in
vmlinux image. So I think kallsyms approach is better and more
reliable.

As for 'A', 'R', 'B', etc. Can we please look at source code of
whatever in kernel defines those lettera in ksyms, instead of guessing
based on a subset of symbols? Guessing like this makes me nervous :)

> Thanks,
> Hao
>
>>
>> > There was step 1.5 (or even 0.5) to see if it's feasible to add not
>> > just per-CPU variables as well.
>>
>> - Arnaldo
