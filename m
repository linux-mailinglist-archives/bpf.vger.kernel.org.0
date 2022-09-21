Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E75D5BFF34
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiIUNvM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 09:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiIUNvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 09:51:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E833280EA0
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 06:51:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l14so13794668eja.7
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=t+16MiqZqe+rl2HHVshym69cnfXaOcrARW/cJSGuXfs=;
        b=fXvdmslfh0B0uoEMaAtu3cBEeRCMiiaGc+YJ7sk6V1qnIzcfoZcsPFMJn29QmnRhQu
         +/V0NmucJONQnAyz5UpE7KEVQVlsZBIe+FnGYSatYwOLOYRkvxL7TF2vNuAySJeCXdYg
         s9wb77vFdNL5uamXPj8m0fAIQKlOaqaEggnyxZTftY5onUKmXiRMtkYeOMOc525onX4j
         OLhxs+gM5axusJSe/M88aAbUUrApRPxzJfVUDie5o7xW67cxMB0W7YvhKbN4ttCChU/O
         koD9h3Q4gc770/wojYNDuTIRO1mBXAAJ8Q+dLyTTRdXPEs0WRl29dRubpE+6STG+J7eW
         an5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t+16MiqZqe+rl2HHVshym69cnfXaOcrARW/cJSGuXfs=;
        b=PXPzysVHlX3QYf8NLbBasHVFBT/jRoUgs9XpB8niTaW0kRkbvwWRKQpvZ/SNGRe+Vk
         K27zFH38FYFDxvjTRar8UXfwr8ueE1WUpGq+Ft0YC2SE9syokn0Qqt8mbOn5qsQx+RHI
         vkJNzfCWSjlsgDvZeLPykv2HrGbBF8Wfbts9pWMAlZ//3LVVFwmawds436u6Y1AsHGjO
         7/Jrtxn8Nwzd7oULHCl9DdSMRohqQ+FJlrkwbpoMmLAswP6xNOYfpP6Osx/3rd5ZpVIM
         qD+4lMPYomOX6LEmS5AlLJFXdPjj5nEMPFFj44Az9j1dBENd0tC9TskMVfmBlHs5bOjg
         7C0A==
X-Gm-Message-State: ACrzQf0sDebTOjz3VEDogrMQhVx1d6Yxom2exQeag3B46ooyc4PYfWIM
        mwOVp1ZNRsTL0ayXZY1Jy4hkCgFBsMPt+26jOYwBjRVD
X-Google-Smtp-Source: AMsMyM4YO76qrRiHylPgIO5aS7Ro7DdInJM+muKUdZPFTycI583U7of1jluFbyVGlHPJM23VJNzitEmkb/AGMUF362s=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr21464336ejc.676.1663768265285; Wed, 21
 Sep 2022 06:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop> <YyihFIOt6xGWrXdC@infradead.org>
 <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com> <YyrMpAPJrP851vE1@syu-laptop>
In-Reply-To: <YyrMpAPJrP851vE1@syu-laptop>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 21 Sep 2022 06:50:54 -0700
Message-ID: <CAADnVQJAJaBaU_bsGZNqq8pRso4pNceXBprUwSENJSomq8UDaQ@mail.gmail.com>
Subject: Re: Rethink how to deal with division/modulo-on-zero (was Re: FW:
 ebpf-docs: draft of ISA doc updates in progress)
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf <bpf@vger.kernel.org>, Dave Thaler <dthaler@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
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

On Wed, Sep 21, 2022 at 1:34 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> Subject changed to reflect this reply is out of scope of the original topic
> (ISA doc).
>
> On Tue, Sep 20, 2022 at 04:39:52PM -0700, Alexei Starovoitov wrote:
> > On Tue, Sep 20, 2022 at 12:51 PM Dave Thaler <dthaler@microsoft.com> wrote:
> > > > -----Original Message-----
> > > > From: Christoph Hellwig <hch@infradead.org>
> > > > Sent: Monday, September 19, 2022 10:04 AM
> > > > To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > > Cc: Dave Thaler <dthaler@microsoft.com>; bpf <bpf@vger.kernel.org>
> > > > Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
> > > >
> > > > On Wed, Sep 14, 2022 at 02:22:51PM +0800, Shung-Hsi Yu wrote:
> > > > > As discussed in yesterday's session, there's no graceful abortion on
> > > > > division by zero, instead, the BPF verifier in Linux prevents division
> > > > > by zero from happening. Here a few additional notes:
> > > >
> > > > Hmm, I thought Alexei pointed out a while ago that divide by zero is now
> > > > defined to return 0 following.  Ok, reading further along I think that is what
> > > > you describe with the pseudo-code below.
> > >
> > > Based on the discussion at LPC, and the fact that older implementations,
> > > as well as uBPF and rbpf still terminate the program, I've added this text
> > > to permit both behaviors:
> >
> > That's not right. ubpf and rbpf are broken.
> > We shouldn't be adding descriptions of broken implementations
> > to the standard.
> > There is no way to 'gracefully abort' in eBPF.
> > There is a way to 'return 0' in cBPF, but that's different. See below.
> >
> > > > If eBPF program execution would result in division by zero,
> > > > the destination register SHOULD instead be set to zero, but
> > > > program execution MAY be gracefully aborted instead.
> > > > Similarly, if execution would result in modulo by zero,
> > > > the destination register SHOULD instead be set to the source value,
> > > > but program execution MAY be gracefully aborted instead.
>
> While this makes implementation a lot easier, come to think of it though,
> this behavior actually is more like a hack around having to deal with
> division/modulo-on-zero at runtime. User doing statistic calculations with
> BPF will get bit by this sooner or later, arriving at the wrong calculation
> (fast-math comes to mind).

lol. If that was the case arm64 would be on fire long ago
and users would complain in masses.
Same with risc-v.

> This seems to go against some general BPF principle[1] of preventing the
> users from shooting themselves in the foot.
>
> Just like how BPF verifier prevents a _possible_ out-of-bound memory access,
> e.g. arr[i] when `i` is not bound-checked. Ideally I'd expect a coherent
> approach toward division/modulo-on-zero as well; the verifier should prevent
> program that _might_ do division-on-zero from loading in the first place.
> (Maybe possible to achieve if we introduce something like SCALAR_OR_NULL
> composed type, but that's definitely not easy)
>
> Admittedly even if achievable, this is a radical approach that is not
> backward compatible. If such check is implemented, programs that used to
> load may now be rejected. (Usually new BPF verifier feature allows more BPF
> program to pass the verifier, rather then the other way around)
>
> So, I don't have a good proposal at the moment. The purpose to this email is
> to point what I see as an issue out and hope to start a discussion.
>
> 1: Okay, I'm making this up a bit, strictly speaking the BPF foundation is
> safe program (one of Alexei's talk) rather than preventing users from
> shooting themselves in the foot.

Safe != invalid.
BPF doesn't prevent invalid programs.
BPF ensures safety only, not crashing the kernel, not leaking data, etc.
For example: under speculation arr[i] can go out of bounds
and to prevent data leaks we insert masking operations.
Similar with div_by_0. If the verifier can detect that it will reject
the prog, otherwise it will insert if(==0) xor, because not
all architectures behave like arm64.
