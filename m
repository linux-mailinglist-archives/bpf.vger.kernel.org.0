Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1443D519E
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 05:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGZDJO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 23:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhGZDJO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Jul 2021 23:09:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E98C061757
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 20:49:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u12so8787464eds.2
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 20:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilOAMxuaikWA+pICJBet5a6sT1SOXKULzJ0Yr0GrSn8=;
        b=KKNQA8ciIvmIByJ2d8A1nqymcp1wQDlmFnXNFovYdQ3roO/bJIZPx9IcKDZrPsjuKa
         imZVle85Srbk3ThTE2g10SsZI5F0ktnbcd+VjTas7tUfmKrUt7UaE9YYc5tfqpC6+Tnd
         PRlR1myAosnfLHcXGtx02oNaAGQy89T+WcioupRzylUsbAtml5YLCQ1pG8uFOEbob49r
         isiM16P1WfxKYek7hWQax6iJGaAKkh0hmbrq/fkSL21i+zFRLm7kOv7sOyrastInSfyJ
         +kio6f+wHTsHSD8RvOgzPOL6pJxpzacrlU+fBUtqesQ3Ix8l8FbkT9ya3xt/0oZpuPgI
         8Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilOAMxuaikWA+pICJBet5a6sT1SOXKULzJ0Yr0GrSn8=;
        b=qzMiDyQgLJBZIgoVA0LFy6Z9KbxqykRDcygp7S8I51RLD8jKHZVPwoa2fbgZOOSlKw
         kxO0Z830M2Ll4NLZqOy4U1iSKcTUGAKJfK7H7Wb/aFaIfbttsazttfzCefanLtT/24LW
         cf8g9LICaJQj+Oq7sKjD28/OV5Y9GDmhioEoUfAlyV1Jf9sNwqr7DYsRGfxr6q5d2VOd
         DSf+bK7u6kVvUD2X9G/16eZ0bMK+nUNUpYjSptPmDmnFlXtg78QIrtGtOUW8P6S1WJ+1
         XyXY9yKBMGnaaBJ5kZiwbbNuuHiJdgMzoMi9KOkCtQR9lCLT+1QHPo9J9MmmMg1/H4yQ
         7xGw==
X-Gm-Message-State: AOAM5338DbMMJLDVEo9i2gaNMHtYtvYSjM8LoSToMDByRV1SzsgEKx9q
        E4gw62G5mXo1254oSOS8YoBWmLDEr5H9Dpi0VPk=
X-Google-Smtp-Source: ABdhPJyynNq1oP2j6Cgaxl063RSRWpgItSjg/OyJijhuHT8flLfIWG0p6o9uWGLF7D5cV7D/FmVMmGGhjdCE4lo+6m8=
X-Received: by 2002:a05:6402:60e:: with SMTP id n14mr19226567edv.363.1627271381325;
 Sun, 25 Jul 2021 20:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <a1ae15c8-f43c-c382-a7e0-10d3fedb6a@gmail.com> <CAK3+h2z+V1VNiGsNPHsyLZqdTwEsWMF9QnXZT2mi30dkb2xBXA@mail.gmail.com>
 <8af534e8-c327-a76-c4b5-ba2ae882b3ae@gmail.com> <7ba1fa1f-be6-1fa2-1877-12f7b707b65@gmail.com>
 <441e955a-0e2a-5956-2e91-e1fcaa4622aa@fb.com> <CAK3+h2w=CO8vvo_Td=w08zKxfko1DA96xk4fvCXvUA1wLZvOMA@mail.gmail.com>
 <e1a2904f-1b43-e1a8-e20d-0449798274bb@fb.com>
In-Reply-To: <e1a2904f-1b43-e1a8-e20d-0449798274bb@fb.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Sun, 25 Jul 2021 20:49:30 -0700
Message-ID: <CAK3+h2z=qxzDm=-isjuM01n8Mt5NpoAHCkwHNzOWFXNMAczUdw@mail.gmail.com>
Subject: Re: Prog section rejected: Argument list too long (7)!
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 25, 2021 at 7:39 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/25/21 6:14 PM, Vincent Li wrote:
> > On Sun, Jul 25, 2021 at 6:01 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 7/25/21 8:22 AM, Vincent Li wrote:
> >>>
> >>>
> >>>
> >>> On Sat, 24 Jul 2021, Vincent Li wrote:
> >>>
> >>>>
> >>>>
> >>>> On Sat, 24 Jul 2021, Vincent Li wrote:
> >>>>
> >>>>> On Fri, Jul 23, 2021 at 7:17 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>> Hi BPF experts,
> >>>>>>
> >>>>>> I have a cilium PR https://github.com/cilium/cilium/pull/16916 that
> >>>>>> failed to pass verifier in kernel 4.19, the error is like:
> >>>>>>
> >>>>>> level=warning msg="Prog section '2/7' rejected: Argument list too long
> >>>>>> (7)!" subsys=datapath-loader
> >>>>>> level=warning msg=" - Type:         3" subsys=datapath-loader
> >>>>>> level=warning msg=" - Attach Type:  0" subsys=datapath-loader
> >>>>>> level=warning msg=" - Instructions: 4578 (482 over limit)"
> >>>>>> subsys=datapath-loader
> >>>>>> level=warning msg=" - License:      GPL" subsys=datapath-loader
> >>>>>> level=warning subsys=datapath-loader
> >>>>>> level=warning msg="Verifier analysis:" subsys=datapath-loader
> >>>>>> level=warning subsys=datapath-loader
> >>>>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
> >>>>>> level=warning msg="Unable to load program" subsys=datapath-loader
> >>>>>>
> >>>>>> then I tried to run the PR locally in my dev machine with custom upstream
> >>>>>> kernel version, I narrowed the issue down to between upstream kernel
> >>>>>> version 5.7 and 5.8, in 5.7, it failed with:
> >>>>>
> >>>>> I further narrow it down to between 5.7 and 5.8-rc1 release, but still
> >>>>> no clue which commits in 5.8-rc1 resolved the issue
> >>>>>
> >>>>>>
> >>>>>> level=warning msg="processed 50 insns (limit 1000000) max_states_per_insn
> >>>>>> 0 total_states 1 peak_states 1 mark_read 1" subsys=datapath-loader
> >>>>>> level=warning subsys=datapath-loader
> >>>>>> level=warning msg="Log buffer too small to dump verifier log 16777215
> >>>>>> bytes (9 tries)!" subsys=datapath-loader
> >>
> >> The error message is "Log buffer too small to dump verifier log 16777215
> >> bytes (9 tries)!".
> >>
> >> Commit 6f8a57ccf8511724e6f48d732cb2940889789ab2 made the default log
> >> much shorter. So it fixed the above log buffer too small issue.
> >>
> >
> > Thank you for the confirmation, after I remove 'verbose' log, indeed
> > the problem went away for kernel 5.x- 5.8, but the
> > "Prog section '2/7' rejected: Argument list too long.." issue
> > persisted even after I remove the "verbose" logging
> > for kernel version 4.19, any clue on that?
>
> No, I don't.
>
> You need to have detailed verifier log. In verifier, there are quite
> some places which returns -E2BIG.
>
I will do another round of bisect,  correct myself, the "The argument
list too long" occurred in 5.1, but not in 5.2

> >
> >
> >>>>>> level=warning msg="Error filling program arrays!" subsys=datapath-loader
> >>>>>> level=warning msg="Unable to load program" subsys=datapath-loader
> >>>>>>
> >>>>>> 5.8 works fine.
> >>>>>>
> >>>>>> What difference between 5.7 and 5.8 to cause this verifier problem, I
> >>>>>> tried to git log v5.7..v5.8 kernel/bpf/verifier, I could not see commits
> >>>>>> that would make the difference with my limited BPF knowledge. Any clue
> >>>>>> would be appreciated!
> >>>>
> >>>> I have git bisected to this commit:
> [...]
