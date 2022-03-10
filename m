Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673FB4D3E48
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 01:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiCJAjo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 19:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiCJAjn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 19:39:43 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2297117C90
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 16:38:43 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i1so2699329ila.7
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AH1Ryok58z365yesvDKuxOdyN+Y3/Jp3lFo3kUZXrk=;
        b=XJUy0cc+kwqbriMvbKj+oIgRizvrFcTnKrbMHuv+sn/zgyBBdgDWiGhXmJcmXZ+jGx
         iJ98QiqWjmsdL18k7STO0UTPZoEYOEfysl7c5nZWiTu2ROIjBw9LKGS8lqJGyXrnWFlT
         qRzRTafhHUcpaZ4kgDw2rOJoGEiO1RBY/iXUoxq3o9MfTcUcasoOtRcl4BUEh+2gdUSz
         Hp/H5KsR5IhQz+cGCl3lgR3sJ/X4Oer2eZo2Beu7hO6PAj0uxm1EbtfD17wGNUw+4lXu
         55X8TIaVPHZghQDzkTa+n+AEGY7f/+c15jGDFFQd0WbTvl9Uj+GZNNTOEXMEmFsyk0zY
         8ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AH1Ryok58z365yesvDKuxOdyN+Y3/Jp3lFo3kUZXrk=;
        b=jp5+tZOayTSWHFww0ryBpVsV78Tx6V6TCPBhCPnRZT86Klou0DgSbCkZdcDiDaspEG
         Z7k+W+Pjb03dN87UiQpPB7Z3frUO2S22Bo2UjmOeS6x7HX4bfvKx0UjpBk53bkl7pFbd
         +BW4TLsb+FDaNUiYbze4loCwos2cfjoqWATHwC+CsY5TgLIp5JE5uqN5yDeKA4/k5LbD
         AI7zbZY32h5uowXdHhQiRtDOtTZ/Bi0CkLQu1LoCMCPx+7LagABLKxu6BnWEAE5mgHmo
         40ZZ4rTQcNU6PJ2gA7S0tm7POZ/WMMXGC26tww+pa3ma0fsp+f/Wu66cqH1EICaXrtuI
         SNMQ==
X-Gm-Message-State: AOAM532LM8Ns1MCHGFkpD/h7XDqrujvolg1wslACEjJkyThRga/iUy5s
        CjixmEBOwTS+Lo0TR8eWS5XbaFLRnFHEE1VEnRE=
X-Google-Smtp-Source: ABdhPJx0EDBwsHEnAXkD/RuKm8RP/ZkmjpYOUDlRJ6Ui2+DmjTqYblivS2T5fuzfRo0c0jVlUQaCnyrFSESb4/J+B2o=
X-Received: by 2002:a05:6e02:1a8e:b0:2c6:3b01:1ffe with SMTP id
 k14-20020a056e021a8e00b002c63b011ffemr1622216ilv.239.1646872723324; Wed, 09
 Mar 2022 16:38:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646188795.git.delyank@fb.com> <a679538775e08c6f7686c2aec201589b47eda483.1646188795.git.delyank@fb.com>
 <CAEf4BzZzAToLHESKrddn2y1FoLHHUVGzJe7=1ih0E3EA7BBdHg@mail.gmail.com>
 <9028e60f908d30d5f156064cebfd5af8d66c5c9c.camel@fb.com> <CAEf4BzbuQ+7vkKw0ozkwX7E1D7ygfTbyhaUMJitxTgiYq9y7Fg@mail.gmail.com>
 <8d80bcf5802fc707e0f8a31812625d717f133300.camel@fb.com>
In-Reply-To: <8d80bcf5802fc707e0f8a31812625d717f133300.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Mar 2022 16:38:32 -0800
Message-ID: <CAEf4BzZPXAj11LsFD8rOchHSjykGJNoWsNgALbHkeqXPPU-LOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Wed, Mar 9, 2022 at 4:10 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Sorry, missed this question originally.
>
> On Fri, 2022-03-04 at 11:29 -0800, Andrii Nakryiko wrote:
> > Split BTF added on top makes it a bit more
> > tolerable (though there is still a bunch of unnecessary complexity and
> > overhead just for that pesky asterisk).
> >
> > Another alternative would be:
> >
> > typeof(char[123]) *my_ptr;
> >
> > This can be done without generating extra BTF. For complex types it's
> > actually even easier to parse, tbh. I initially didn't like it, but
> > now I'm thinking maybe for arrays and func_protos we should do just
> > this? WDYT?
>
> typeof is _technically_ not standard C (I think it'll make it into C23). GCC and
> Clang do both support it but I would guess we'd want the generated userspace
> code to be compatible with as many toolchains and configurations as possible?
> (e.g. people using c99 instead of gnu99)

that ship has sailed, I'm afraid. btf.h and xsk.h (I'm not even
talking about BPF-side headers) both use typeof()

>
> Beyond that, I feel that any complexity saved by the typeof is lost in special-
> casing arrays and function prototypes when the current code is uniform across
> all types.
>
> If you insist, I can go down this path but I'm not super enthusiastic about it
> (and it's harder to read on top of everything).

I can tell you are not :)

I do think that typeof() makes it much easier to follow complicated
cases. Just look at the example below:

static int blah_fn(int x, int y) { return x + y; }

struct S {
        typeof(char[24]) *my_ptr1;
        char (*my_ptr2)[24];

        int (**my_func1)(int, int);
        typeof(int (*)(int, int)) *my_func2;
};


int main() {
        static struct S s;
        char blah[24];
        int (*fptr)(int, int);

        s.my_ptr1 = &blah;
        s.my_ptr2 = &blah;

        s.my_func1 = &fptr;
        s.my_func2 = &fptr;

        return 0;
}


Which one is easier to follow, my_ptr1 or my_ptr2? func pointer is a
bit more hypothetical (hard to come up with realistic BPF program that
would need func pointer type as global variable type), but I still did
it for completeness.


So it's not like I'm dead set against this split BTF approach, I just
do really think that array variable case is better with typeof().

>
> -- Delyan
