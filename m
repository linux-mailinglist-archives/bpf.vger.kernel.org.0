Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90764289092
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgJISJP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgJISJP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:09:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262DCC0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 11:09:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dt13so14356209ejb.12
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A0rnLv5kDddHJjGwVe+XaLo3cPSB1RSvJ7gsK59Niss=;
        b=LfZ9/bUnyZUSehi8zjpscDD3gYE9fE7PlsFIIu8Qak3/yZcMViWITKxrX6Kexa56lX
         dC2J325RaNKkwDckjA/6a3TxaNuEF8RMlAxIoQiEaLosB5OJvH6ePbouGKKeCrT0Bv+x
         MjGG9Bds4up4fdHxqMTpwLdjFD1pgLSaQOP2XPHzVzvxMJ9DYTZQ1l+i15iENLPvMfrD
         C2qwUxKYrYMPr+4kODlzSTknn0YbVa2m3QRNpUznRCRBYw0yixZ2atMQLV16QXqzzvsJ
         A5xUc2XtFYQQBQd5e/KGE4AzOqu26mvZ+VfAPG1TRN+A8y4X+9a6XC88Yho6Q/+760cB
         ViVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A0rnLv5kDddHJjGwVe+XaLo3cPSB1RSvJ7gsK59Niss=;
        b=CtOk0td4tza25CAMzmQyjtrUEpe9pSnuzW5nxSZzZ4pMouqEBTicTtSDj8bgeCJX3k
         H1f0Asw+TDOQ5DMzJ8GpAXaT89AFT+geH1KjhaQtyO6cMOUqqne6lMNIl8vI7ydK7xXW
         uHjvZqFwbd/XUwsbj8ac2ZFkgvohcsGSCBZxlbfTfadUaSmL/Kqua6EsTmI4m35+ZUqR
         xNgL53BBTyhwdqcqTJ/auTvEWe/tFp/om10h/o+BHGYjcKXJWVf/TsKEszRtYjn6Bp8c
         9hPRPOr0V/E70DpTZjtia9DRcw1xsh1ad2SBLOCSni4uIcasI7bgMsZ31rjUNVS1DrgC
         4GgQ==
X-Gm-Message-State: AOAM531RlZvkzf3CZ6cB8NEL6o+ASOdQRsEpUh5unPshVJKagQy4xXFu
        pHZfqCd/o8XKQwm2FfzeGF4oAjLq5tvsN0ihpb/GPLyGtHGj/A==
X-Google-Smtp-Source: ABdhPJyIc5hzuXSigsJcTPxH1o+dY8836ai7NRK9SiZogCPCl5oADHaI9XavHMs2mUVObzPDlE15nHmrbXs3B9PstdI=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr16142542ejq.315.1602266953490;
 Fri, 09 Oct 2020 11:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net>
In-Reply-To: <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Fri, 9 Oct 2020 21:09:02 +0300
Message-ID: <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
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
=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=D7=90=D7=AA =
=E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
<=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=D7=90=D7=
=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>
> >> [ Cc +Yonghong ]
> >>
> >> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> >>> Pulling the latest changes of libbpf and compiling my application wit=
h it,
> >>> I see the following error:
> >>>
> >>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
> >>> unknown register name 'r0' in asm
> >>>                        : "r0", "r1", "r2", "r3", "r4", "r5");
> >>>
> >>> The commit which introduced this change is:
> >>> 80c7838600d39891f274e2f7508b95a75e4227c1
> >>>
> >>> I'm not sure if I'm doing something wrong (missing include?), or this
> >>> is a genuine error
> >>
> >> Seems like your clang/llvm version might be too old.
> >
> > I'm using clang 10.0.1
>
> Ah, okay, I see. Would this diff do the trick for you?

Yes! Now it compiles without any problems!

>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 2bdb7d6dbad2..31e356831fcf 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -72,6 +72,7 @@
>   /*
>    * Helper function to perform a tail call with a constant/immediate map=
 slot.
>    */
> +#if __clang_major__ >=3D 10 && defined(__bpf__)
>   static __always_inline void
>   bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>   {
> @@ -98,6 +99,9 @@ bpf_tail_call_static(void *ctx, const void *map, const =
__u32 slot)
>                      :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>                      : "r0", "r1", "r2", "r3", "r4", "r5");
>   }
> +#else
> +# define bpf_tail_call_static  bpf_tail_call
> +#endif /* __clang_major__ >=3D 10 && __bpf__ */
>
>   /*
>    * Helper structure used by eBPF C program
