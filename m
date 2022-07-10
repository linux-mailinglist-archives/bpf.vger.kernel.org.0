Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A057D56CFAF
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiGJPQO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPQN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 11:16:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E11CE1B
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 08:16:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id va17so5081825ejb.0
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POcu02EKR60ZYVKuonGId7+RS7Wi71Fz4XMAu3IBLm0=;
        b=hgE/PbgSGtstHv9HcJ3XukJ6b7M6UBJVrfAcB89KnVy5HVrbf7paeOSX49XKU7RUyc
         SttPy4AAHIqV9K1ugcdCWeQa1pC1Ff6ZpgrAFH9fA1Z1QNiUe2bo2W6bM2gEIqDoPShM
         TS0r64ij7VKOj1OYbBFuqY2Gr8u4k1w0AgjkCx/QCgqBr6GxAwilwUQjMzrSiqO+op84
         vjKUmXg0g0gB0fVVmCEUeiA9sS9QxZzOAXXYZzcuzZx6G4apgoAfzSd2aVi2TbkXUdv2
         ZR0hGnq21cKSMCjmb9h1lPtfiPERCLKVpaagEOrwa7UuthKlhJf4Q/aCYYDdu4PqFuvE
         ehOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POcu02EKR60ZYVKuonGId7+RS7Wi71Fz4XMAu3IBLm0=;
        b=mgdqu5acytas/KfvkCrT1lwqNaSg+w8V75pMnZ+a8HuZIeCMq8LQvLSkq1ZNuKDrpL
         3e++K+9BpAon+QS60kE/xayO7O2ovck2tEgoNo53oSh0YHYraeZ4Yo8VV3tJ5vkOGQwC
         oWuW4POyk0WYYEqLKLA7ypFkgS7qILLe9vCC+akUGqjM+vCzCwff/YCLCvlOCjBlgwOk
         Rs6lX50JIlXinMRhbuIT5JFnnVybWuqpkni14u3RTu1RNVzZuXb3IWXRv4SwJqYF0oEg
         RxqfkOdM/8CKbcZGhQ0UMoRfJ228sMjx6SqQbk1z/DO1gimXqV/9ZvhW9uAXtupN+PlY
         x3hg==
X-Gm-Message-State: AJIora+3SRbfehLZRV8MjNQH9fm+OEkZWSfStcCpptrxcK5gHw2lZaiw
        QqyAKcoiqMRghEwcj87FMwZC2Yt6BcpYPVlNoIrUavvo
X-Google-Smtp-Source: AGRyM1usapgFmNqmnMryy/iwCsQajoOB+/3Y5VDwSVY6rkTgwOe6TW55Wjg21FSdiOCxIhGS/nYuptLkJ1Ol/LyVqEo=
X-Received: by 2002:a17:907:6e03:b0:726:a6a3:7515 with SMTP id
 sd3-20020a1709076e0300b00726a6a37515mr14092519ejc.676.1657466171404; Sun, 10
 Jul 2022 08:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220708060416.1788789-1-arilou@gmail.com> <20220708060416.1788789-2-arilou@gmail.com>
 <CAEf4BzZkfWTQppe97E1CTLKEqgtxP9gUQqbXB1EKRm5pK_ZmDA@mail.gmail.com>
 <YsjtxLuTvn8DWEA6@jondnuc> <CAADnVQLmAg9_StyD9_pMO0YUn-Yi1ozxfinxuQmkL0BYoTjbjw@mail.gmail.com>
 <CAP7QCohvoDZ0sk6sqA3112xsM4xzUc9uRHXiDNyt7M4jc3oUmg@mail.gmail.com>
In-Reply-To: <CAP7QCohvoDZ0sk6sqA3112xsM4xzUc9uRHXiDNyt7M4jc3oUmg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 10 Jul 2022 08:15:59 -0700
Message-ID: <CAADnVQJ7RaQyaSaRJ8aE=-0b2URNQFnCLhKX4GpL0H-yQyrTiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] libbpf: perfbuf: allow raw access to buffers
To:     Jon Doron <arilou@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Jon Doron <jond@wiz.io>
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

On Sat, Jul 9, 2022 at 10:43 PM Jon Doron <arilou@gmail.com> wrote:
>
> I was referring to the following:
> https://github.com/libbpf/libbpf-rs/blob/master/libbpf-rs/src/perf_buffer.rs

How does your patch help libbpf-rs?

Please don't top post.

> Thanks,
> -- Jon.
>
> On Sun, Jul 10, 2022, 08:23 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>
>> On Fri, Jul 8, 2022 at 7:54 PM Jon Doron <arilou@gmail.com> wrote:
>> >
>> > On 08/07/2022, Andrii Nakryiko wrote:
>> > >On Thu, Jul 7, 2022 at 11:04 PM Jon Doron <arilou@gmail.com> wrote:
>> > >>
>> > >> From: Jon Doron <jond@wiz.io>
>> > >>
>> > >> Add support for writing a custom event reader, by exposing the ring
>> > >> buffer state, and allowing to set it's tail.
>> > >>
>> > >> Few simple examples where this type of needed:
>> > >> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>> > >>    to handle the wrap-around in some other way.
>> > >> 2. Since perf buf is per-cpu then the order of the events is not
>> > >>    guarnteed, for example:
>> > >>    Given 3 events where each event has a timestamp t0 < t1 < t2,
>> > >>    and the events are spread on more than 1 CPU, then we can end
>> > >>    up with the following state in the ring buf:
>> > >>    CPU[0] => [t0, t2]
>> > >>    CPU[1] => [t1]
>> > >>    When you consume the events from CPU[0], you could know there is
>> > >>    a t1 missing, (assuming there are no drops, and your event data
>> > >>    contains a sequential index).
>> > >>    So now one can simply do the following, for CPU[0], you can store
>> > >>    the address of t0 and t2 in an array (without moving the tail, so
>> > >>    there data is not perished) then move on the CPU[1] and set the
>> > >>    address of t1 in the same array.
>> > >>    So you end up with something like:
>> > >>    void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>> > >>    and move the tails as you process in order.
>> > >> 3. Assuming there are multiple CPUs and we want to start draining the
>> > >>    messages from them, then we can "pick" with which one to start with
>> > >>    according to the remaining free space in the ring buffer.
>> > >>
>> > >
>> > >All the above use cases are sufficiently advanced that you as such an
>> > >advanced user should be able to write your own perfbuf consumer code.
>> > >There isn't a lot of code to set everything up, but then you get full
>> > >control over all the details.
>> > >
>> > >I don't see this API as a generally useful, it feels way too low-level
>> > >and special for inclusion in libbpf.
>> > >
>> >
>> > Hi Andrii,
>> >
>> > I understand, but I was still hoping you will be willing to expose this
>> > API.
>> > libbpf has very simple and nice binding to Rust and other languages,
>> > implementing one of those use cases in the bindings can make things much
>> > simpler than using some libc or syscall APIs, instead of enjoying all
>> > the simplicity that you get for free in libbpf.
>> >
>> > Hope you will be willing to reconsider :)
>>
>> The discussion would have been different if you mentioned that
>> motivation in the commit logs.
>> Please provide links to "Rust and other languages" code that
>> uses this api.
