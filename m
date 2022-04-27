Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83518510DE0
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 03:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356669AbiD0BaB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 21:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356654AbiD0BaB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 21:30:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CB9403C6
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 18:26:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bx5so162363pjb.3
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 18:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pRgoTFbCsSdcLHOIELuaJbLrkAjKXlE6iTDuTy9dLA=;
        b=KD6tpeeWVnFK1XYgqn2ZcW39FE8pEM9LB6foCLrIgWyw21u8VmHIHzcw8S3ZJAHz6A
         xNxQWF/+t4sKDF4dJ1RBbW6hmbofNS4w/ldGaSmmAuEVo3VkRVYX4Fwgsj1w1A5yxotg
         x1IbbZzUL0PvWwxqfTs+kUbOwB6OXoVMxrIdzrHEa6oPoT37bN+got5e5xisXv0ClAOu
         ljtRlLI+wgucnlmZEkhtoaIzzSYLFGKv5h7KDCFASEfgRX1iCRB9k4IxLEjMiEBM0AKd
         9Yw+vah0bggLzjAWcUVMz2ph89lPrUuao4BSLlNalYjxDvNOIdVSnny1RF4jhiU65z17
         vmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pRgoTFbCsSdcLHOIELuaJbLrkAjKXlE6iTDuTy9dLA=;
        b=zrHvLw2RjjTtTLyMebyz3Knpw1v7BzdYJF1JndwakxcjIDpIzmCN+JKqRtK9sfALzm
         1L8UNHNDc6BDofKDg/o3/IJYUXCzCT3V4UHLsIjxA+vkYM3SYGfD+0wVf2NkLroZbM04
         KogvqVjFMMh7cAkn6YKDGHNKw17cPypEmnk3onRdmHNvqJorQ+V4zvKgn/azEWKkVyp8
         8byr6LC1nSvLpUwM4ugJlkyU0xGpNj2pfkqPO4Wzf3egpbevlqWCaJsPXc0Xj/kjySia
         UxLBPsC1Kurb8KGgnAPI4ndAN5BLy+soOdS55zCwcDqedK4cKEu0QHYr9xoHz2N7+aaV
         cEag==
X-Gm-Message-State: AOAM532GWgKgaCkQkOlD/uFV8AVYphw2EHR8z9yFs8h5BeV1+vVxYwkN
        h7PXOL6IcmRPiMweFDswprqwyT7JcayxJW9K7is=
X-Google-Smtp-Source: ABdhPJyjhwcqk96Fx3NTt6zOlxAVrikgEQADSgVG2ZA+MJLY6OpTuH3zD1AoPg1Le0tvyP0iAebngISSkqy+I/CJIYg=
X-Received: by 2002:a17:90a:8591:b0:1b9:da10:2127 with SMTP id
 m17-20020a17090a859100b001b9da102127mr41027800pjn.13.1651022810975; Tue, 26
 Apr 2022 18:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com> <20220422025212.n4c25z23rj2pp3yu@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAJnrk1ZczWZi4SAGTqoY1764oei8gCzcEA9a7608R4H2XkisrA@mail.gmail.com>
In-Reply-To: <CAJnrk1ZczWZi4SAGTqoY1764oei8gCzcEA9a7608R4H2XkisrA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Apr 2022 18:26:40 -0700
Message-ID: <CAADnVQK9dKfnz=MwWvb67diEMf5XrppGZr5GiOWgvBkaNaX1RA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Tue, Apr 26, 2022 at 4:45 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > I guess it's ok to treat refcnted dynptr special like above.
> > I wonder whether we can reuse check_reference_leak logic?
> I like this idea! My reason for not storing dynptr reference ids in
> state->refs was because it's costly (eg we realloc_array every time we
> acquire a reference). But thinking about this some more, I like the
> idea of keeping everything unified by having all reference ids reside
> within state->refs and checking for leaks the same way. Perhaps we can
> optimize acquire_reference_state() as well where we upfront allocate
> more space for state->refs instead of having to do a realloc_array
> every time.

realloc is decently efficient underneath.
Probably not worth micro optimizing for it.
As far as ref state... Looks like dynptr patch is trying
hard to prevent writes into the stack area where dynptr
was allocated. Then cleans it up after dynptr_put.
For other pointers on stack we just mark the area as stack_misc
only when the stack slot was overwritten.
We don't mark the slot as 'misc' after the pointer was read from stack.
We can use the same approach with dynptr as long as dynptr
leaking is tracking through ref state
(instead of for(each stack slot) at the time of bpf_exit)

iirc we've debugged the case where clang reused stack area
with a scalar that was previously used for stack spill.
The dynptr on stack won't be seen as stack spill from compiler pov
but I worry about the case:
struct bpf_dynptr t;
bpf_dynptr_alloc(&t,..);
bpf_dynptr_put(&t);
// compiler thinks the stack area of 't' is dead and reuses
// it for something like scalar.
Even without dynptr_put above the compiler might
see that dynptr_alloc or another function stored
something into dynptr, but if nothing is using that
dynptr later it might consider the stack area as dead.
We cannot mark every dynptr variable as volatile.

Another point to consider...
This patch unconditionally tells the verifier to
unmark_stack_slots_dynptr() after bpf_dynptr_put().
But that's valid only for refcnt=1 -> 0 transition.
I'm not sure that will be forever the case even
for dynptr-s on stack.
If we allows refcnt=2,3,... on stack then
the verifier won't be able to clear stack slots
after bpf_dynptr_put and we will face the stack reuse issue.
I guess the idea is that refcnt-ed dynptr will be only in a map?
That might be inconvenient.
We allow refcnt-ed kptrs to be in a map, in a register,
and spilled to the stack.
Surely, dynptr are more complex in that sense.
