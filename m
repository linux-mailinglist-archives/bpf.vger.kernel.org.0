Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CB9288F45
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 18:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbgJIQ5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 12:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgJIQ5L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 12:57:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30ECC0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 09:57:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c22so14115225ejx.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PUwdEIAQx9fh2/XuXe5+sZ6jgB+87H5H6MmkLMEvx+M=;
        b=jdEr/kxTeS/9SpuXRGsTf+/lahJaQpFIUYjscG+5fhth5up1dEfqHJAe53hyd3OIdH
         aqhAyoo+wCFdigoBJUkFz0fz2R2IcgRDGnpuG5rx28wzsNvY5lbUn8SPB/qzupUqcEkh
         uT4MOVuaB9Z89O9MPZJIKCT+8Eo9TgMYoZugOEGbOZ9l/90/0Us17pvs2iiKLTunzhNu
         I41XxLIxwmf3wmvvSkvRFqCL4ppvVzUDR6oWd596ewxin+KpNS+mAfb9f4eUW4aHPVas
         KS9qlcnTMQH+DtL6wE7fVQFrgkQBwu4W7l860dIGNgzGS9nKyuv5I1CmOUAjHxBSx0En
         U4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PUwdEIAQx9fh2/XuXe5+sZ6jgB+87H5H6MmkLMEvx+M=;
        b=LQqQ5AI2yLM66P4yTUaUlnj3sVWHfYYQOFEun30KSLDh40V6xgSkCDyq9t1ouhNtsr
         DPPwRURcH/cPZihtcbiN04gziIrawonF2hnLJ5nZQLoXEFzoBuyPUnlxDL5O6uuUo8Yf
         xzxsHHL45xSOvXCHGJ4+7bw3iCbckDrh5cXvjbr0r/Rqt/c/Gs7PqGICCnEbUm6b4olw
         YlkdCZB80f+psneFctjmfD//KUWVKpzGZjbHhHYjVeH2e3Yv8OJurDLudrEWuqkl6qwP
         OMYce6JYT1zY0gAlEXxOZuqd96htHT/+X1VcGm14WnN3LR48XFpHoGS3/OmcTb2JkZ6E
         SqKA==
X-Gm-Message-State: AOAM530xwHi4DHrjS3pmSWn5DUnZiHf7hKNCQ5QHuOufTsL0oYG74HtG
        q3j53VA4K1g804XjmHbiigIa5P4aXEhSh9OxYRI=
X-Google-Smtp-Source: ABdhPJwUoxsKnLh0EQ5vupg4iHRVAk8oAGlIXupOnT7ftIC1QxvFfO6Ou/KQF1BM4wkPviLUhTc3lO+CdbJeD4hqcJo=
X-Received: by 2002:a17:906:6d89:: with SMTP id h9mr14743123ejt.152.1602262628474;
 Fri, 09 Oct 2020 09:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net>
In-Reply-To: <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Fri, 9 Oct 2020 19:56:57 +0300
Message-ID: <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
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
=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=D7=90=D7=AA =
=E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
<=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> [ Cc +Yonghong ]
>
> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> > Pulling the latest changes of libbpf and compiling my application with =
it,
> > I see the following error:
> >
> > ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
> > unknown register name 'r0' in asm
> >                       : "r0", "r1", "r2", "r3", "r4", "r5");
> >
> > The commit which introduced this change is:
> > 80c7838600d39891f274e2f7508b95a75e4227c1
> >
> > I'm not sure if I'm doing something wrong (missing include?), or this
> > is a genuine error
>
> Seems like your clang/llvm version might be too old.

I'm using clang 10.0.1

>
> Yonghong, do you happen to know from which version onwards there is prope=
r support
> for bpf inline asm? We could potentially wrap this around like this:
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 2bdb7d6dbad2..0d6abc91bfc6 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -72,6 +72,7 @@
>   /*
>    * Helper function to perform a tail call with a constant/immediate map=
 slot.
>    */
> +#if __clang_major__ >=3D 10
>   static __always_inline void
>   bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>   {
> @@ -98,6 +99,7 @@ bpf_tail_call_static(void *ctx, const void *map, const =
__u32 slot)
>                       :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>                       : "r0", "r1", "r2", "r3", "r4", "r5");
>   }
> +#endif /* __clang_major__ >=3D 10 */
>
>   /*
>    * Helper structure used by eBPF C program
>
>
>
> > Yaniv
> >
>
