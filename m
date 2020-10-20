Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CB294110
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 19:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395119AbgJTRHD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389534AbgJTRHC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Oct 2020 13:07:02 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0E5C0613CE
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 10:07:02 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id h196so2543741ybg.4
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=M4moeZsT/gRK0c8JL0PI/kuTTRsQ0gF3kdY3ZQfWQ2o=;
        b=c6I1JUemmDGYjgP/AZnfSdMiJddsmFPNBAn4BhDUA0XH1XRy6d7FL2Bwvh2mNu3+lK
         814LTRk/qmgX0EmBHbhM6OfumQa8Ptyld8bgaSKrV0c3DCwQYIpwmLAbUXCIUt6aU2Wt
         fJ/wSESzkFpQK8s0Gkd7FmfqUxSoeTrtJamxYSoBdBR+25n8XzU15e24s9QuYkDwnjYd
         NQHqjxn/WuEJm4wIMdtvenqzmSN7P61/udcgkDbckZctMOIXd0liYuuM/dKyWeuZMG1B
         ywPxwpv5kQXFCxsgZcx+Z45Gdz5rODNX+dTHeKqofIMqabRF5CFl52Kt6IoGVmiCN/xJ
         4OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=M4moeZsT/gRK0c8JL0PI/kuTTRsQ0gF3kdY3ZQfWQ2o=;
        b=BR+QCIdZgzQLYuZKlZ5HbyCa4fdG8TIKEh04Vy4031TP+91uPcSgW2cQo1ppwnL86F
         66Vk7xEGuoxsnIxPav+DnMYQyMy9PC4rePo9yWiN8eg3e63gvs+uqc+XU6Z4UYe+0/3g
         F/zu3cu+nR9463LwtRTICYxDJB+K0RdAAWYIJz7wjKjzorK8UnRqmRU03RVMYps3OdA+
         u2UYkWJcSN4D9ryRL0wz+Ukz04u72nSvsgqQUwZ6nQXgKpJHeXlqdmHmUirGOqELME+A
         F1+SI9n/KbvClMTOF+bujvHNGimfBv2S5ZYTqMaP1Cp5Mh7WK1KeRDKGBm7eDElTUy7N
         kW3g==
X-Gm-Message-State: AOAM532m+TOBITSx/gyXrzTdh4bHxJqRUFs7kd50g2iLV4Dnz59Kv2TR
        dO1/ug771zdarvCUCiBFcNTEjvl1UCLqiIROzLfxtkl7
X-Google-Smtp-Source: ABdhPJxvWCGn/AEJVVfOL5iXrhhrv7BYQI2PHBCqxg7qeHvFUIUqY5dKbNa99IkFmHFFvtJp68Pce9H5oqSnz6PNbQc=
X-Received: by 2002:a25:bdc7:: with SMTP id g7mr5752094ybk.260.1603213621604;
 Tue, 20 Oct 2020 10:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAON2a1G_rqvOLumP-0Vcw0v2qiAiwc0hR32TegvNYyEd26e9bA@mail.gmail.com>
 <CAEf4BzZBKco0=-HDfjOKPOJDXnicxOVyOY6ouAu+00s78_CJng@mail.gmail.com> <CAON2a1ERRSkk-o5xBqvJoZwp0Y6aL5+9k1NONgg35HMOoC8Czw@mail.gmail.com>
In-Reply-To: <CAON2a1ERRSkk-o5xBqvJoZwp0Y6aL5+9k1NONgg35HMOoC8Czw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Oct 2020 10:06:50 -0700
Message-ID: <CAEf4BzaTEauBV6XnzZfO4R-ibmSuYSuPPgAOKh33VNANoo6EdQ@mail.gmail.com>
Subject: Re: help using bpf_probe_read_user with uprobe on linux 4.19 for aarch64
To:     sheng chen <eason.sheng.chen@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 19, 2020 at 8:43 PM sheng chen <eason.sheng.chen@gmail.com> wro=
te:
>
> Hi Andrii,
>

[...]

>
> I'm using vendor qcom's kernel 4.19, and want to use bpf_probe_read_user(=
available on linux 5.5) on linux 4.19, so I need to apply the bpf_probe_rea=
d_user
>   function patches from upstream linux 5.5 to my local kernel 4.19, is th=
at a suitable solution?

On older kernels that don't yet support bpf_probe_read_user() you can
just use bpf_probe_read() instead and get the same results. Again, I
don't know bpftrace specifics and whether you can do that easily, but
you don't really have to backport any kernel changes just to read
user-space memory from BPF program.

>
> Thanks
> Eason
>
>
>
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:58=E5=86=99=E9=81=
=93=EF=BC=9A
>>
>> This is the third identical email you've sent, please don't spam the
>> mailing list. Sometimes it takes a bit of time on the mailing list to
>> get an answer. Re-sending your email will just annoy people and won't
>> help you get an answer.
>>
>> As an advice for the future, please try to formulate your problem
>> clearly, before asking a seemingly-random set of questions. See below,
>> I tried to answer your questions as best as I could.
>>
>>
>> On Mon, Oct 19, 2020 at 6:45 PM sheng chen <eason.sheng.chen@gmail.com> =
wrote:
>> >
>> > Hi Andrii,
>> >
>> > I'm developing bpftrace tools for Android aarch64 devices to analyze p=
erformance, mostly using uprobe/uretprobe and kprobe/kretprobe.
>> >
>> > I'm using the project https://github.com/facebookexperimental/Extended=
AndroidTools for build bpftrace cmd tool. libbpf still not included.
>> >
>> >
>> > First question:
>> >
>> > Currently there is an issue(https://github.com/iovisor/bpftrace/issues=
/1503) block me to correctly access the pointer address of the uprobe param=
eters.
>> >
>> > Seems like this require bpf_probe_read_user on linux 5.5(as mension in=
 https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md), if I =
use the older kernel, I need to apply the patch about the function bpf_prob=
e_read_user, is there any reference code I need to apply as well?
>>
>> I don't understand what reference code you mean. And given this is a
>> bpftrace question, it's probably best to route it to bpftrace Github
>> repo? This mailing list is discussing kernel BPF subsystem and libbpf,
>> for the most part.
>>
>> >
>> > like the following parts:
>> >
>> > linux/include/linux/bpf.h
>> > linux/include/uapi/bpf.h
>> > linux/include/linux/filter.h
>> > linux/include/uapi/filter.h
>> > linux/kernel/bpf/
>> > linux/net/core/filter.c
>> > linux/kernel/trace/bpf_trace.c
>> > linux/tools/bpf/
>> > linux/tools/lib/bpf/
>> >
>> >
>> > Second question:
>> >
>> > Does the trace program like using uprobe/uretprobe and kprobe/kretprob=
e need libbpf built-in?
>> >
>>
>> I don't think bpftrace relies on libbpf, so I suppose no?
>>
>> > For a specific kernel(like 4.19), how to choose the right version of l=
ibbpf for build as the dependency for bcc?
>>
>> You should build with whatever version of libbpf BCC depends on. But
>> then I'm even more confused between you talking about bpftrace, BCC,
>> and libbpf. All three are quite independent projects, with libbpf used
>> by BCC for some functionality.
>>
>> >
>> > Third question:
>> >
>> > Does my kernel need support BTF? Since I need to access the struct mem=
bers from kernel and userspace.
>>
>> I don't know, because I don't know which kernel is *your* kernel.
>> bpftrace has --btf parameter with which it can use kernel BTF, so I'm
>> guessing that's what you are asking about? If yes, kernels starting
>> from 5.2 version support emitting kernel BTF, but you need to enable
>> it through CONFIG_DEBUG_INFO_BTF=3Dy config value.
>>
>> >
>> >
>> > Thanks
>> >
>> > Eason
