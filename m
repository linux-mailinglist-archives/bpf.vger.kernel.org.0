Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26862890FF
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbgJISeW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390457AbgJISdR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF74C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 11:33:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t20so4057000edr.11
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BDHGaFTqL6L6bPE8lEXeg2u1BSgddktYVKT7sz7ip/0=;
        b=FuoV2s9qytxjh1/2kXFAz4VagRzLDAzSJfUvoOBfS4gp6qunbWg+h4n+8H845vOF28
         Jj+g0lMs2a0QD4+TGjsf1QUEzQ4u3you1ZdyX1TxJB9fYGCYx6pB6jQyQ4hS1HNm5jxd
         ZN+OY9cKoiG/VSB7tt1foRsA7pQkXWQAbfO63shmrQh1Ann/9jMbQhOstcZByATVsL0C
         tc4mqQroKZGwyOwCan39jNjTSA/QLG0Jc5I/gtEX9gnAODsSwLmJlaW0TE6k6oQ2aM/Z
         9kH99WbnSriT2hztXApWJvZ9DS1NLyyS3MIFIM2Rm4sXiQNnkwybAkFpKgs50OcFBuo+
         CNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BDHGaFTqL6L6bPE8lEXeg2u1BSgddktYVKT7sz7ip/0=;
        b=oQRf3gQkcyT6CyDYD0c3EE6SsHexbVEfcjSPesWBYErspdvOhlpxV1MzGJ1xOwCOYM
         VLntKGxXwFlnCKv1kXXqYaBgUuefebZg6dOBqQn2Fexw4N5cJftAi4rYKWCYD+cUietd
         ZhS5SVPpUH/FCjsOFJmg3LmJp4ALvpz4+A38PIZcdkRD1PGKkRsOx645azJtZHUiOvpy
         lpb5JIpB9x3MRo6f3ugGopuAYWL2fhXnzWafudQQi6ctD5KQf8kTZVWhAMWdUh3A3hkl
         OMmS3Fo7oKZ0ybKKwFj8LTcvAVH61bPT9egjgIvIBB6opSW2OtXZcgr38Mz954Nk78AD
         8YNw==
X-Gm-Message-State: AOAM531SWd2Mxx6L3y5B15flLe8EXEa6UKzZ/HdzGEa1LeSYJPbHBNvG
        HcmoDZnuK+bXD+lw/Jr/U/ow1MR62tgpYybRU0DUg0WI5ma79g==
X-Google-Smtp-Source: ABdhPJz8xL2QnyUZG0D8YxeiJ9yWjymyNq2mGp1nhqXisKBTVdv/OELX0fyyp8Vqw0wcld1WsToKfB/25o8/2EWe7cw=
X-Received: by 2002:aa7:cd90:: with SMTP id x16mr549857edv.302.1602268395651;
 Fri, 09 Oct 2020 11:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net>
In-Reply-To: <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Fri, 9 Oct 2020 21:33:04 +0300
Message-ID: <CAMy7=ZW6B+aHN-3dAf7-=kK8WpMZ0NmEmeVh67jVPrjsryx9sQ@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=
=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:21 =D7=9E=D7=90=D7=AA =
=E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
<=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
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

Thanks!
Does this happen because I'm first compiling using "emit-llvm" and
then using llc?
I wish I could use bpf target directly, but I'm then having problems
with includes of asm code (like pt_regs and other stuff)

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
