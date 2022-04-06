Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6E4F6C61
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiDFVQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiDFVQH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 17:16:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D52E095
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 13:01:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c15so4703713ljr.9
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilern9kZVXc0gNSzx1aaX6P0kMwsHspcdD2r4OhVN3U=;
        b=KDfUuJ2wUGVBglh+slmXFyPEnZdVy/Mw16+aheRPlp3NvLJ6f5EB+SVjDUlz7Iz3gu
         pC9y2fpyVLPrWAE+AMzLfXp+tuQ8VQOF6BBF3HxJEPdz8gcLDbKy+ch4GQouwo3q5CdP
         I7S/R2ZXIaMv8hhofEr12bPreHF90ptL+jS/T4MTNOlEl2aSZJV2ymax/cLmVifb2d//
         biIE6Emd9gNwJovOdUee3dLAivGcKmm6Q44N55xk+KQ3GMPvibLqvVQU6GYKyJQvPfhG
         wHRO0sUuTm/Sd8e3C0zXfqb4NTq9vZr892fbV7bMEPui/f75dFwlSttMQkShnnyriqYy
         4e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilern9kZVXc0gNSzx1aaX6P0kMwsHspcdD2r4OhVN3U=;
        b=UCpGfz+bKdOpIGitH9F+1+5PwyzD9LiHpk94FdW/X/zdFojVK3xXWxbQCNOcLWEeS2
         zjvehG8IcGxnoIGYprtttBbJJIvrKh+pt98EePVLo8WIRbPR3tEyMpfBkDBipOcvgFrP
         nOn0bfREfKkBSVfbXWnvKCKcXcxafz/6QC6pjVX1OfDbzOeyC3JhPQioWghlXhvKQzk1
         THEq74hPk9TReMH5iiqlXPaVbLiorK2w9uIc+tc2kSJpkCd4g1mDm7yenuTOWRpAVq+z
         TjkahfSMDyJJLEc6c3j0M73OWNX4TSw/MR5LIkHPRffifwit9qdADU5IyshF3c3qzaKR
         on+g==
X-Gm-Message-State: AOAM532CC+4EmW/GWVrJTO71mjLhMZVOVYtmbmywYLQHwX8kz1GmxjlW
        Bm0ySd8++yZI4YLOeVPKDu8CZsGtZio36DVurzi+43aogeiuoez6
X-Google-Smtp-Source: ABdhPJyGoSywdpw/rb05LZ124JFPXztlyZy5eO0Te6N4327huXEFsiorHqfd0w3y4ajj2I4jrJpjkCOMbp1FlepW/VQ=
X-Received: by 2002:a05:651c:1585:b0:24a:f34d:43e1 with SMTP id
 h5-20020a05651c158500b0024af34d43e1mr6194083ljq.299.1649275306952; Wed, 06
 Apr 2022 13:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oVD+0Ltuww1F-AZdPtSE4O4M-BH5NP_R-oSBWszZ3oZiQ@mail.gmail.com>
 <CAEf4BzY8kjQDrkKU2gZox8J9gF7iQ9ht=2GVmXuktCRg0sRqjA@mail.gmail.com>
In-Reply-To: <CAEf4BzY8kjQDrkKU2gZox8J9gF7iQ9ht=2GVmXuktCRg0sRqjA@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Wed, 6 Apr 2022 16:01:36 -0400
Message-ID: <CAO658oUbXfuYzK1fxTrEdHJffhxpvL9QBZLdOtY6uG98H1e0Lg@mail.gmail.com>
Subject: Re: Questions on BPF_PROG_TYPE_TRACING & fentry/fexit
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Sun, Apr 3, 2022 at 7:47 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 7:27 AM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > Hi there,
> >
> > I'm looking to implement programs of type BPF_PROG_TYPE_TRACING to
> > replace kprobe/tracepoints because from what I can tell there's less
> > performance overhead. However, I'm trying to understand restrictions
> > and use cases.
> >
> > I see that there's a generic `bpf_program__attach()` which can be used
> > to attach programs and it will attempt to auto-detect type and attach
> > them accordingly.
> >
> > In practice, I'm curious what I can attach programs of this type to,
> > and how are they specified? `bpf_program__attach()` doesn't take any
> > parameters outside of the program itself. Does it attach based on the
> > name of the program's name/section? If so, is there an idiomatic way
> > of making sure this is correctly done?
>
> You can specify destination either in SEC() definition:
> SEC("fentry/some_kernel_func") or you can use
> bpf_program__set_attach_target(...) before BPF object is loaded.

Can you elaborate more on `bpf_program__set_attach_target()`? I've
been working through the selftests and understand that you can use it
to attach bpf programs to other bpf programs, and kernel modules. Are
there only certain types of bpf programs that can be attached to? Are
there restrictions on what kind of programs can attach to others?

> >
> > My follow up question is to ask how fentry/fexit relate. I've seen
> > these referred to as program types but in code they appear as attach
> > types, not program types. Can someone clarify?
>
> Formally they are different expected attach types for
> BPF_PROG_TYPE_TRACING program type. There is also fmod_ret, which is
> yet another expected attach type with still different semantics. But
> it's like kprobe and kretprobe, they have very different semantics, so
> we talk about them as two different types of BPF program.
>
> >
> > As always I'm partly asking so that I can document this and avoid
> > other people having the same confusion :-)
> >
>
> Yep, I appreciate it. Please send follow up questions if you still
> have some. Please check relevant selftests to see possible usages.
>
> > Thank you very much!
> > Grant
