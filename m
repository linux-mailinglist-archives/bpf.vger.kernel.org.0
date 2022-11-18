Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5150F62EA6A
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 01:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiKRAig (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 19:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiKRAif (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 19:38:35 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB0C28E17
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:38:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f18so9311072ejz.5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbCH+H8HP4R73zev7jPb6d+6pdGqkhhzFjUW3p9uOLw=;
        b=GcmdHwMoynjW4Z7rwRMm0rElQ5vbZxXNRLeJ9p57sJii6kkOXzyg+q/dxteHl+BYXD
         xh29rg4X4YOCfopVbBERpUv6qy4Tv1YhwoMiTlz4R28hq1Q10NrloJaKcZsgmYp8qv1H
         MOiQmq9Uw8urQV4NmI0Sqm2q7irLVRxthpiDfAd34sNrPEs5oCqxIJYdsh0GcHD11wo/
         ZdURC5RvSRxendYUFPalfC5CbZGPeNn8XhqPXsSn6seTUkwwJpbj6oXcGW+uDSZO5ThO
         RSbtrBtEBJlZBWmgcix2BSjLzOMbLk+Vg3cNMPaSp3r/FtNXlmHP3gUMKoM3Wuq6l8WT
         xZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbCH+H8HP4R73zev7jPb6d+6pdGqkhhzFjUW3p9uOLw=;
        b=SWLi0a80iVRWdgTzpVamv/nfZWPNu3rxhyUCXoqrufaxsebOOUCDvtWIPbruguY588
         xrYz3OQsvUqH5N5b2RULMl6HkPLyW4lHQKKoPh4eWg1esGWLUl7Jt3KrajRY7Cm2dTZw
         W4hTbU0QGY4qtRzv9E92zjPsz6DsZEej7nzSGflynYmOQuZ0kFP6Dn3NS9uCKVhNW3Co
         aygW4Irfmjg+tDOlVEx41ni7FwqSG+3N45CtzYjKrFOBs1Cz7dlqjgb7UEIh65UU+Aos
         +pU1vX9kp42guM2vjTxv+XBE9Q7so+8s2aLekaxIILAVPxnQ20soahGchCAgaRCEUhOr
         nzaA==
X-Gm-Message-State: ANoB5pl0S/Lug1+Y6UkYs7n4hwke4HJXzVsi9iPZtpvp8n+6Ja7T8Tms
        9ulFiQLUWckwWhcoBrapJ6sbSz0wfEYcP3uixO0=
X-Google-Smtp-Source: AA0mqf5hiFmuXVwe+JU3znUdiLk91UE1nUO85wfX9TOOUDNf0ZJ0/Rt+1DmGyfOqXAD5d21nYGVmgPKSmuCYf44d0Og=
X-Received: by 2002:a17:906:584b:b0:7ae:25ba:5e4a with SMTP id
 h11-20020a170906584b00b007ae25ba5e4amr4148376ejs.745.1668731911580; Thu, 17
 Nov 2022 16:38:31 -0800 (PST)
MIME-Version: 1.0
References: <CAO658oUrud+RaV4dAWQ+JYkDttgW00xyDmsoa8-vCeknQNjVtg@mail.gmail.com>
 <91787040-3612-e847-b512-a38a3dae199e@meta.com> <CAO658oXVoDsiNt3NtC0qDECOCA8XnLh+aOb4kR=-HhFvddo1aA@mail.gmail.com>
In-Reply-To: <CAO658oXVoDsiNt3NtC0qDECOCA8XnLh+aOb4kR=-HhFvddo1aA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Nov 2022 16:38:19 -0800
Message-ID: <CAEf4BzY4AV9DCVjt-ctUcBNBX-e1HPedcJqega3Rt=qFxeH2qw@mail.gmail.com>
Subject: Re: Best way to share maps between multiple files/objects?
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@meta.com>,
        bpf <bpf@vger.kernel.org>
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

On Mon, Nov 14, 2022 at 11:04 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Fri, Nov 11, 2022 at 2:34 AM Dave Marchevsky <davemarchevsky@meta.com> wrote:
> >
> > On 11/10/22 7:32 PM, Grant Seltzer Richman wrote:
> > > Hi folks,
> > >
> > > I want to organize my BPF programs so that I can load them
> > > individually. I want this so that if loading one fails (because of
> > > lack of kernel support for BPF features), I can load a fall-back
> > > replacement program. To do so, I've organized the BPF programs into
> > > their own source code files and compiled them individually. Each BPF
> > > program references what is supposed to be the same ringbuffer. Using
> > > libbpf I open them and attempt to load each in order.
> > >
> > > My question is, how am I supposed to share maps such as ringbuffers
> > > between them? If I have identical map definitions in each, they have
> > > their own file descriptors. Is the best way to call
> > > `bpf_map__reuse_fd()` on each handle of the maps in each BPF object?
> >
> > Sounds like each of the source files have the exact same map definitions,
> > including name? And each is compiled into a separate BPF object?
> >
> > If so, adding __uint(pinning, LIBBPF_PIN_BY_NAME); to
> > each definition will probably be the easiest way to get the map reuse
> > behavior you want. The first bpf object in the set that successfully loads
> > will pin its maps by name in /sys/fs/bpf and future objects which load same
> > maps will reuse them instead of creating new maps.
>
> This worked beautifully, thank you for the suggestion!
>
> >
> > selftests/bpf/progs/test_pinning.c demonstrates this behavior.
> >
> > I'm curious, though: is this a single BPF program with various fallbacks,
> > with goal of running only one? Or a set of N programs working together using
> > same maps, each of which might have fallbacks, with goal of running some
> > version of all N programs?
>
> The latter. We have N programs all sharing M maps. Each program might
> have fallbacks but some version should be loaded.
>
> >
> > > I'd also take advice on how to better achieve my overall goal of being
> > > able to load programs individually!
> >
> > You can group each program together with its fallbacks in the same
> > source file / BPF object by disabling autoload for all variants of the
> > program via SEC("?foobar") syntax. Then in userspace you could turn
> > autoload on for the first version you'd like to try after opening
> > the BPF object, try loading the object, try with 2nd variant if that
> > fails, etc.
>
> Thank you for this suggestion as well, but it doesn't seem to work as
> I get: `load can't be attempted twice`. Is this a potential bug?
> `obj->loaded` is set to true regardless of success in
> `bpf_object_load()`

set_autoload() should be set before bpf_object__load().
bpf_object__load() can't be loaded twice.

I'd do proper detection of what kernel features are available and
set_autoload() correspondingly. Then do bpf_object__load() once. And
completely avoid pinning, if I could.

>
> >
> > selftests/bpf/progs/dynptr_fail.c + verify_fail function in
> > selftests/bpf/prog_tests/dynptr.c is an example of this pattern.
> >
> > > Thanks so much for your help,
> > > Grant Seltzer
