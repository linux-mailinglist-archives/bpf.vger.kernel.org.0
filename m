Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ACE28912D
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgJISgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgJISfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:35:48 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D9FC0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 11:35:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id o70so4125608ybc.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7uReneuAexSQAr/LzhAIacCmwPTUtE3QJg6/N8ljM3k=;
        b=BBRA4dmRV4mWcy9v6I+pbrWnhAandNd1vqXvFEV7RWD9qMkruo6Wa2t0dRKWJmQTIZ
         ixQ55U50LHmKRy5NE1xj4ELrwof5riYwPvDbp4uMMZ31cFfYcjWgvqsvvk0pDUvH5KVU
         sRpG9zhj7rkoLiJQc6BXsDvD2GCYiH3THJMbrClRBUV9szbxcgUx1QfDzGKqYJqPFs4j
         qgzTpotsAofvwZxCsHxsAnWCmrvIEa0J8DFMQ1EiOA72+orl2K0/L2peq3XQtlSBf8qi
         6tbZdKVJddWQO9f8kanNqHr2S38Y+vcl62XnCb9iA0mQRUN+iDq+wvSQWkDtFiytowOw
         IEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7uReneuAexSQAr/LzhAIacCmwPTUtE3QJg6/N8ljM3k=;
        b=nnPgFCWd00/m+iLcj4HaPRAJJXEQgm1zJJQcvd3Pw3gTadaq19xt2N/bA5nolBNHeZ
         AFp2DfnOktHyYAYN/wT1GChjf2KDBTZXdFzXhhCGZ0Qny3vIv/hbXCBcpLDyMQbaQ5Xr
         wKAGGRtg1T+wUreJOxiAwGdpshwmljR07lZEpAWhl9Lh54oXzikZXuIDQxJaP/nTZ0D/
         EhCTZ/WJJmwEpg/kQw42kJQVhCum5/yXaIuMmTHmtptnGR0eHLfuSCeDj6pWa2sge+Tm
         hr9Q06aNbRqrNJa5YZ2HZjAwpzYuSF0neifVfPEpMRDfAREYHrHc3E39GVs6H6wH3Frm
         4uQA==
X-Gm-Message-State: AOAM533zZQz9cxys6wWFM60QVeMtjZyxhHk7kCSECfuNJZuvz3BLeDxL
        iC181zgzX0x6gr5fYDp/srgeIBfs4AR7Aq+2XG725K1aer0=
X-Google-Smtp-Source: ABdhPJxwYDl6Wb9Dd5D5ODeAVmJEtXzuY+/1P7wgM3XGK/jOxP1GDmqSNsW2FlHZpyA3935ekNv85/cTqjrfsk+TJqI=
X-Received: by 2002:a25:8541:: with SMTP id f1mr17510939ybn.230.1602268547376;
 Fri, 09 Oct 2020 11:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net>
In-Reply-To: <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Oct 2020 11:35:36 -0700
Message-ID: <CAEf4Bza4KFJ_j7vmg-x_Zinp0PUM-zmWYHMq_y+2zWmX485sBQ@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yaniv Agman <yanivagman@gmail.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 11:21 AM Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
>
> On 10/9/20 8:09 PM, Yaniv Agman wrote:
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=D7=90=D7=
=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>
> >> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=D7=90=
=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> >>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>
> >>>> [ Cc +Yonghong ]
> >>>>
> >>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> >>>>> Pulling the latest changes of libbpf and compiling my application w=
ith it,
> >>>>> I see the following error:
> >>>>>
> >>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
> >>>>> unknown register name 'r0' in asm
> >>>>>                         : "r0", "r1", "r2", "r3", "r4", "r5");
> >>>>>
> >>>>> The commit which introduced this change is:
> >>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> >>>>>
> >>>>> I'm not sure if I'm doing something wrong (missing include?), or th=
is
> >>>>> is a genuine error
> >>>>
> >>>> Seems like your clang/llvm version might be too old.
> >>>
> >>> I'm using clang 10.0.1
> >>
> >> Ah, okay, I see. Would this diff do the trick for you?
> >
> > Yes! Now it compiles without any problems!
>
> Great, thx, I'll cook proper fix and check with clang6 as Yonghong mentio=
ned.
>

Am I the only one confused here?... Yonghong said it should be
supported as early as clang 6, Yaniv is using Clang 10 and is still
getting this error. Let's figure out what's the problem before adding
unnecessary checks.

I think it's not the clang_major check that helped, rather __bpf__
check. So please hold off on the fix, let's get to the bottom of this
first.

> >> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> >> index 2bdb7d6dbad2..31e356831fcf 100644
> >> --- a/tools/lib/bpf/bpf_helpers.h
> >> +++ b/tools/lib/bpf/bpf_helpers.h
> >> @@ -72,6 +72,7 @@
> >>    /*
> >>     * Helper function to perform a tail call with a constant/immediate=
 map slot.
> >>     */
> >> +#if __clang_major__ >=3D 10 && defined(__bpf__)
> >>    static __always_inline void
> >>    bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> >>    {
> >> @@ -98,6 +99,9 @@ bpf_tail_call_static(void *ctx, const void *map, con=
st __u32 slot)
> >>                       :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
> >>                       : "r0", "r1", "r2", "r3", "r4", "r5");
> >>    }
> >> +#else
> >> +# define bpf_tail_call_static  bpf_tail_call
> >> +#endif /* __clang_major__ >=3D 10 && __bpf__ */
> >>
> >>    /*
> >>     * Helper structure used by eBPF C program
>
