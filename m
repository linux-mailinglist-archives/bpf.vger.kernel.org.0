Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790645E863D
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiIWXPa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 19:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiIWXP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:15:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DF4661F
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:15:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z13so3559481ejp.6
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kP3vb1VULbbUUEjMlGxEP71rAshyWWplwKuOhDlkq6g=;
        b=HspDlGpmgAIP7R7XG0+s5SMeeOjgTt8YYNoCjDOqX4UTOp146xdHG6+TPlpp0c8P/q
         A4vv4OHtOBTwEJ1lVlcDpNbxtUxlTFju0xTeIBmcKJG1Dhlqvcw4R6tOMvk5NsGvNV9i
         sT3hOUpNropRsEXhkezaeFwTMaQEkGoPiSCSh/t6xYWmcGWAXt5Iu6EnVVlWGaP7y6i+
         o6hUaBHkoEUcUuCSlav80fFcd0ftCo7Nbc14d3gYNgTBdNU2CtIySntvqsW2APt+K/2U
         A4lgR3GQyiEQRVIVNRxSXFLj+yrKRv8uGqeWIaVVC0SL6UxqcDJKPY+5tNnS6T6k9XF2
         n7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kP3vb1VULbbUUEjMlGxEP71rAshyWWplwKuOhDlkq6g=;
        b=kkk348uMMcvkmC9epUI7cVnhC5NELHta4dbLrcI5kUD7phPOk4gZd0nmArYv0kE3Ey
         xKx6Gz2v2tJA9RVO9S47bC7RN3hGqivJWW3cfcV/SkDReCc7UsksHoLd0+/Gna0rM26m
         jgv7eG2eNr1R+7qNOashs9cz1xdFVNi+ejPMybe2iS8GYOoqdAx7NAxAr5EMUe6xRkY7
         KWK2JpvOwCR2/vfTideO2tzNIZNYLByxwxRhyh3674VmpUlbU5DZtny2KkOCr4CFrXP2
         bny3zZ59CThqV2x0kjQ2H9maWIHqwK/1pkW49wLWGCTTgnk7JtDtat2KZ2M/EFhVLi5x
         fA2A==
X-Gm-Message-State: ACrzQf14J2qT6V9qflHd1xpF8+ZNm7f27+4PPS2ahHVOlTRDylflX6dA
        kbksmw1R4Io4GOOzyh0kKZUv8x9Dhf+H/tjBfHg=
X-Google-Smtp-Source: AMsMyM7WVas5UJ0SAZNuHyzp4o/Vi+thP3mKEvR/n1ySixMpqS85JR2QHVakXpC08mGZzUIUMP2YSbEwRZqDTHSst/o=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr9200771ejc.676.1663974925941; Fri, 23
 Sep 2022 16:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop> <YyihFIOt6xGWrXdC@infradead.org>
 <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com>
 <YyrMpAPJrP851vE1@syu-laptop> <CAADnVQJAJaBaU_bsGZNqq8pRso4pNceXBprUwSENJSomq8UDaQ@mail.gmail.com>
 <Yyvr3v5yFXcq/wK0@syu-laptop>
In-Reply-To: <Yyvr3v5yFXcq/wK0@syu-laptop>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 23 Sep 2022 16:15:14 -0700
Message-ID: <CAADnVQJfcFOEi0MHSSR8DExREKV-7V7g-3TYo3OLy1OgGe6cAg@mail.gmail.com>
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

On Wed, Sep 21, 2022 at 10:00 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> On Wed, Sep 21, 2022 at 06:50:54AM -0700, Alexei Starovoitov wrote:
> > On Wed, Sep 21, 2022 at 1:34 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > >
> > > Subject changed to reflect this reply is out of scope of the original topic
> > > (ISA doc).
> > >
> > > On Tue, Sep 20, 2022 at 04:39:52PM -0700, Alexei Starovoitov wrote:
> > > > On Tue, Sep 20, 2022 at 12:51 PM Dave Thaler <dthaler@microsoft.com> wrote:
> > > > > > -----Original Message-----
> > > > > > From: Christoph Hellwig <hch@infradead.org>
> > > > > > Sent: Monday, September 19, 2022 10:04 AM
> > > > > > To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > > > > Cc: Dave Thaler <dthaler@microsoft.com>; bpf <bpf@vger.kernel.org>
> > > > > > Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
> > > > > >
> > > > > > On Wed, Sep 14, 2022 at 02:22:51PM +0800, Shung-Hsi Yu wrote:
> > > > > > > As discussed in yesterday's session, there's no graceful abortion on
> > > > > > > division by zero, instead, the BPF verifier in Linux prevents division
> > > > > > > by zero from happening. Here a few additional notes:
> > > > > >
> > > > > > Hmm, I thought Alexei pointed out a while ago that divide by zero is now
> > > > > > defined to return 0 following.  Ok, reading further along I think that is what
> > > > > > you describe with the pseudo-code below.
> > > > >
> > > > > Based on the discussion at LPC, and the fact that older implementations,
> > > > > as well as uBPF and rbpf still terminate the program, I've added this text
> > > > > to permit both behaviors:
> > > >
> > > > That's not right. ubpf and rbpf are broken.
> > > > We shouldn't be adding descriptions of broken implementations
> > > > to the standard.
> > > > There is no way to 'gracefully abort' in eBPF.
> > > > There is a way to 'return 0' in cBPF, but that's different. See below.
> > > >
> > > > > > If eBPF program execution would result in division by zero,
> > > > > > the destination register SHOULD instead be set to zero, but
> > > > > > program execution MAY be gracefully aborted instead.
> > > > > > Similarly, if execution would result in modulo by zero,
> > > > > > the destination register SHOULD instead be set to the source value,
> > > > > > but program execution MAY be gracefully aborted instead.
> > >
> > > While this makes implementation a lot easier, come to think of it though,
> > > this behavior actually is more like a hack around having to deal with
> > > division/modulo-on-zero at runtime. User doing statistic calculations with
> > > BPF will get bit by this sooner or later, arriving at the wrong calculation
> > > (fast-math comes to mind).
> >
> > lol. If that was the case arm64 would be on fire long ago
> > and users would complain in masses.
> > Same with risc-v.
>
> whoa, I had no idea.
>
> And looking around I don't see complains. Taking what I said back and +1 for
> using the current division/modulo-by-zero behavior as standard.
>
> > > This seems to go against some general BPF principle[1] of preventing the
> > > users from shooting themselves in the foot.
> > >
> > > Just like how BPF verifier prevents a _possible_ out-of-bound memory access,
> > > e.g. arr[i] when `i` is not bound-checked. Ideally I'd expect a coherent
> > > approach toward division/modulo-on-zero as well; the verifier should prevent
> > > program that _might_ do division-on-zero from loading in the first place.
> > > (Maybe possible to achieve if we introduce something like SCALAR_OR_NULL
> > > composed type, but that's definitely not easy)
> > >
> > > Admittedly even if achievable, this is a radical approach that is not
> > > backward compatible. If such check is implemented, programs that used to
> > > load may now be rejected. (Usually new BPF verifier feature allows more BPF
> > > program to pass the verifier, rather then the other way around)
> > >
> > > So, I don't have a good proposal at the moment. The purpose to this email is
> > > to point what I see as an issue out and hope to start a discussion.
> > >
> > > 1: Okay, I'm making this up a bit, strictly speaking the BPF foundation is
> > > safe program (one of Alexei's talk) rather than preventing users from
> > > shooting themselves in the foot.
> >
> > Safe != invalid.
> > BPF doesn't prevent invalid programs.
> > BPF ensures safety only, not crashing the kernel, not leaking data, etc.
> > For example: under speculation arr[i] can go out of bounds
> > and to prevent data leaks we insert masking operations.
>
> Point taken, thanks for clarifying the difference between safe and invalid.
>
> > Similar with div_by_0. If the verifier can detect that it will reject
> > the prog, otherwise it will insert if(==0) xor, because not
> > all architectures behave like arm64.
>
> Speaking of which, should the "if(==0) xor" patching in do_misc_fixups() be
> moved into JIT implementations and the interpretor?
>
> Given that the standard now mandates BPF_DIV with divisor of zero to return
> zero, it would be rather confusing to see the output of `bpftool prog dump
> xlated` contains the extra "if(==0) xor" instruction that's inserted by the
> verifier.
>
> Also, maybe there'll be performance benefit for arm64 and riscv where
> "if(==0) xor" is not needed.

Tiny perf gain is not worth extra complexity in JITs.
Integer divide is the slowest operation in a CPU.
We're trying to do everything in the verifier and as little
as possible in JITs.
