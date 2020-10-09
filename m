Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4762891C3
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgJITeK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbgJITeK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 15:34:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B57BC0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 12:34:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x1so10569436eds.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Aaix22CaWnRDu3/8LriA9DlXQfNq4WOB0b0IHGrXbsk=;
        b=qFofgwt+tzoy33s24QfV+ZLxZFaDxuZnEBt5psiYsDQGwnSB5kpaxxgDtlDn6shSl0
         qFz/J81Nmn3UirpETwivNpf1APkbvtHlWcYFWgo8D25CsfmyG9BH6ncNi2jGCND4U01p
         wnjprggwybekaLe9XYKl8OwCw+KVLqu4uWsnh191XBemHw1FuHTJilgdcB2bF5xC4+f9
         Y7OyqCTa+hb8cgryvgm7UX0Kk8ObcbDk0NsZLJL7JHIfwrnFicHKg+BFwVCcC7XkQS/Q
         HdIwHZYX2hU4ogSgsDdmecRsaJiRBBoCWBPG6qZ5M5u61Wn6z/AgE+nXuVEC+QTFZ7rD
         95KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Aaix22CaWnRDu3/8LriA9DlXQfNq4WOB0b0IHGrXbsk=;
        b=TNw/q6RMey38PgU2ACjYVyN3dH8oyQ8O8q5z670hs4ueIvlF9rd5VwEH2ERhHChCEs
         PHURtlH+M22GQeg3BVEGn9lGdUGvbpLKIegVBeI6yOkNreUjbagZrwEnR1AX1FiYXXaf
         MA6IHbpW/TFH2kL7zbFw4rVh7WbUAuvDMRrXMoDOBZnhSjcofp1xNKQ0o+QL3FyMdvrC
         h24sAgdX37IfsO9c3dwQA0cbzEfhGfVN6SS4vYLN/8NjGqDsgtnp5AXjnUHW+Ul0XGCd
         d6W8VuQgviqV7p4LmfDHot+hPDqvZDz8rr11KQkipi58Nerlth73kBk45Z8KUlcUVC/Y
         8G+Q==
X-Gm-Message-State: AOAM530MG/lIAKbZfLNLuVMfC21lcacmt/rQgGe+PmoP7+MPVQbmfza8
        j88XgKaOhMh/ekVsl1EEHSfWfV8SknC/GTBkhkg=
X-Google-Smtp-Source: ABdhPJyiXONWzElDjMyqp9Ms7jp5oMTTnHabEGy5BBg71I7HBHpASY/gy4fq0koJAQ521Eh64Dl0UHPA58jaAlRCbRQ=
X-Received: by 2002:a05:6402:b31:: with SMTP id bo17mr856228edb.342.1602272048220;
 Fri, 09 Oct 2020 12:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAEf4Bza4KFJ_j7vmg-x_Zinp0PUM-zmWYHMq_y+2zWmX485sBQ@mail.gmail.com>
 <ece9975d-717c-a868-be51-c97aeae8e011@iogearbox.net> <CAEf4BzawvpsYybaOXf=GvJguiavC16BmdDeJfO4kEAR5naOKug@mail.gmail.com>
 <231e3e6b-0118-f600-05c5-f4e2f2c76129@fb.com>
In-Reply-To: <231e3e6b-0118-f600-05c5-f4e2f2c76129@fb.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Fri, 9 Oct 2020 22:33:56 +0300
Message-ID: <CAMy7=ZWYn9MnmQJU7S_FUz5PArkGtVUcS1czn3oVCqa1aEniXw@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=
=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-22:08 =D7=9E=D7=90=D7=AA =
=E2=80=AAYonghong Song=E2=80=AC=E2=80=8F <=E2=80=AAyhs@fb.com=E2=80=AC=E2=
=80=8F>:=E2=80=AC
>
>
>
> On 10/9/20 11:59 AM, Andrii Nakryiko wrote:
> > On Fri, Oct 9, 2020 at 11:41 AM Daniel Borkmann <daniel@iogearbox.net> =
wrote:
> >>
> >> On 10/9/20 8:35 PM, Andrii Nakryiko wrote:
> >>> On Fri, Oct 9, 2020 at 11:21 AM Daniel Borkmann <daniel@iogearbox.net=
> wrote:
> >>>> On 10/9/20 8:09 PM, Yaniv Agman wrote:
> >>>>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> >>>>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>>>
> >>>>>> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> >>>>>>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> >>>>>>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>>>>>
> >>>>>>>> [ Cc +Yonghong ]
> >>>>>>>>
> >>>>>>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> >>>>>>>>> Pulling the latest changes of libbpf and compiling my applicati=
on with it,
> >>>>>>>>> I see the following error:
> >>>>>>>>>
> >>>>>>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
> >>>>>>>>> unknown register name 'r0' in asm
> >>>>>>>>>                           : "r0", "r1", "r2", "r3", "r4", "r5")=
;
> >>>>>>>>>
> >>>>>>>>> The commit which introduced this change is:
> >>>>>>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> >>>>>>>>>
> >>>>>>>>> I'm not sure if I'm doing something wrong (missing include?), o=
r this
> >>>>>>>>> is a genuine error
> >>>>>>>>
> >>>>>>>> Seems like your clang/llvm version might be too old.
> >>>>>>>
> >>>>>>> I'm using clang 10.0.1
> >>>>>>
> >>>>>> Ah, okay, I see. Would this diff do the trick for you?
> >>>>>
> >>>>> Yes! Now it compiles without any problems!
> >>>>
> >>>> Great, thx, I'll cook proper fix and check with clang6 as Yonghong m=
entioned.
> >>>
> >>> Am I the only one confused here?... Yonghong said it should be
> >>> supported as early as clang 6, Yaniv is using Clang 10 and is still
> >>> getting this error. Let's figure out what's the problem before adding
> >>> unnecessary checks.
> >>>
> >>> I think it's not the clang_major check that helped, rather __bpf__
> >>> check. So please hold off on the fix, let's get to the bottom of this
> >>> first.
> >>
> >> I don't see confusion here (maybe other than which minimal clang/llvm =
version
> >> libbpf should support). If we do `#if __clang_major__ >=3D 6 && define=
d(__bpf__)`
> >> for the final patch, then this means that user passed clang -target bp=
f and
> >> the min supported version for inline assembly was there, otherwise we =
fall back
> >> to bpf_tail_call. In Yaniv's case, he probably had native target with =
-emit-llvm
> >> and then used llc invocation.
> >
> > The "-emit-llvm" was the part that we were missing and had to figure
> > it out, before we could discuss the fix.
>
> Maybe Yaniv can confirm. I think the following properly happens.
>     - clang10 -O2 -g -S -emit-llvm t.c  // This is native compilation
> becasue some header files. Maybe some thing is guarded with x86 specific
> config's which is not available to -target bpf. This is mostly for
> tracing programs and Yanic mentions pt_regs which should be related
> to tracing.
>     - llc -march=3Dbpf t.ll
>

Yes, like I said,  I do use --emit-llvm, and indeed have a tracing program

> So guarding the function with __bpf__ should be the one fixing this issue=
.
>
> guard with clang version >=3D6 should not hurt and may prevent
> compilation failures if people use < 6 llvm with clang -target bpf.
> I think most people should already use newer llvm, but who knows.
>
> >
> >>
> >>>>>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpe=
rs.h
> >>>>>> index 2bdb7d6dbad2..31e356831fcf 100644
> >>>>>> --- a/tools/lib/bpf/bpf_helpers.h
> >>>>>> +++ b/tools/lib/bpf/bpf_helpers.h
> >>>>>> @@ -72,6 +72,7 @@
> >>>>>>      /*
> >>>>>>       * Helper function to perform a tail call with a constant/imm=
ediate map slot.
> >>>>>>       */
> >>>>>> +#if __clang_major__ >=3D 10 && defined(__bpf__)
> >>>>>>      static __always_inline void
> >>>>>>      bpf_tail_call_static(void *ctx, const void *map, const __u32 =
slot)
> >>>>>>      {
> >>>>>> @@ -98,6 +99,9 @@ bpf_tail_call_static(void *ctx, const void *map,=
 const __u32 slot)
> >>>>>>                         :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"=
(slot)
> >>>>>>                         : "r0", "r1", "r2", "r3", "r4", "r5");
> >>>>>>      }
> >>>>>> +#else
> >>>>>> +# define bpf_tail_call_static  bpf_tail_call
> >
> > bpf_tail_call_static has very specific guarantees, so in cases where
> > we can't use inline assembly to satisfy those guarantees, I think we
> > should not just silently redefine bpf_tail_call_static as
> > bpf_tail_call, rather make compilation fail if someone is attempting
> > to use bpf_tail_call_static. _Static_assert could be used to provide a
> > better error message here, probably.
> >
> >>>>>> +#endif /* __clang_major__ >=3D 10 && __bpf__ */
> >>>>>>
> >>>>>>      /*
> >>>>>>       * Helper structure used by eBPF C program
> >>>>
> >>
