Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0246315E3
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKTTkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTkf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:40:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF9F21245
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:40:34 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l11so13598815edb.4
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xFYDS2aau4MKn/ATqtDZiZEU9N1gGH2d5wRsOzH0Jrg=;
        b=lIyrjB+5Nn67+rb4OYnlI22eqI7GMvyuNBvzlz84hfW8yJfzMkgUuJMZhyEiYtj8cf
         6fszBtmka032nfJeGHzcvl12nmF0PAMidYEb3FNW4I9QVR/dpBW4K3o/aPVL7YXIzbZQ
         737uk2lAlonyTi6TNLN1jQGl0IAGFJwvaymTXjgl/nru6ZPYWB0q25Tm1LR7jukA5XbH
         ilYfHTqvQqX0tdM3m4u8pyR1AJPLeg3EH5NaMv4z5RtreI6ChVeUYIPe0JUym9hUiddd
         1HEEUAnlQTN5fU5LhmUQi78vYsQ/JOVyE7DdkdYKXHofpM3EYl8yduM7xoZ0E1a2jCQQ
         uqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFYDS2aau4MKn/ATqtDZiZEU9N1gGH2d5wRsOzH0Jrg=;
        b=sJh6/iFIY6A1/07D8xViPnGVoiE014fgPdh2QaL+1w5eW7JLDKCkL6p5RqQIluLJIv
         zeYNXAdkJfB4EKsxSBDrwLH0SJ/+oOZgnb7U4yyLz7IN9RczPc8sc9jYHsI1sIKJXBf9
         8KCh2fuPDbQhzM7NoGZw8NgDC6/UEUqDeO3oII9FVCI9fWNXowv7UgJo5bkS94UT9Z7z
         EAUlRNkK1dUaGyuuYjYonVnMBgEcIqkhAAWy79w8gEzPeL5uotgqcx5qgPWA55ih8tk8
         Ww4K/Cb+CwJhEj2KTq+wHb+2TlD/tUCuWpdEgDayEU1CDO66teKlzN1f6iHR/Yn9m+58
         GZOw==
X-Gm-Message-State: ANoB5plkTOa+qw+eMqTmFaMdK7uRN9Vp+NCGZFrACZFWPzJKSPN0zNTl
        Uztnr2J+lUZ4B63klOUzF0qY6yqww7hyTW3Ud+0=
X-Google-Smtp-Source: AA0mqf6a3xqISJxFHW6tKUwuseaOAlMDMPmmmgUWJ+cHD5gVGl/ZMJaSbUREFaMImZryvm858zsluRpKtRfrVU1OYIE=
X-Received: by 2002:a05:6402:5289:b0:462:70ee:fdb8 with SMTP id
 en9-20020a056402528900b0046270eefdb8mr13779296edb.66.1668973232772; Sun, 20
 Nov 2022 11:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20221115000130.1967465-1-memxor@gmail.com> <20221115000130.1967465-6-memxor@gmail.com>
 <Y3bIhyOWs1r22R+2@maniforge.lan> <20221120191013.plzlna24vwluxebk@apollo>
In-Reply-To: <20221120191013.plzlna24vwluxebk@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 20 Nov 2022 11:40:21 -0800
Message-ID: <CAADnVQKcHObiPJ0Hs_5+QnEZwtZQ+9eezvpv_HcLWeq1z+PwqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Move PTR_TO_STACK alignment check to process_dynptr_func
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 11:10 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> IMO, there are a certain set of properties that check_func_arg_reg_off provides,
> you could say that if each register type was a class, then the checks there
> would be what you would do while constructing them on calling:
>
> PtrToStack(off, var_off /* can be const or variable */)
> PtrToMapValue(off, var_off /* can be const or variable */)
> PtrToBtfId(off /* must be >= 0 */) /* no var_off */

Just to complicate things a bit... ;)
There was a request to allow var_off in ptr_to_btf_id.
Sometimes there are fixed size arrays in structs and
programs need to iterate those arrays in a loop.
Another case is to access flex_array at the end of a struct.
Like cgroup->ancestors[].
Both are currently impossible, but the verifier has to
get this capability.
