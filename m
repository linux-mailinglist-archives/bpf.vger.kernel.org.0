Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E1057118A
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 06:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGLEuc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 00:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLEub (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 00:50:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1202C32DBC
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:50:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eq6so8628723edb.6
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ii7pwlAa5b/FO+c9Vd/5idXbZ0PMVufp3scPnGgs1yU=;
        b=A1syNp7SWQuFL6/L5PVW/p8jge4tSyB81OOJPEKADMFtdS86Clrsgl3Rk2VH3MWYs7
         1PzCxAJ2WjQMXKhGyakdm5UHX6YGpAsfWC7+zrBcnh0Y0xlb+bLtsgSGuID5ltMDTSV1
         yy7OtefFo/dg2mfjVViqbCFiihIBmr9nXAzFP3hlxh9jvNN45WpHErPk7Q0TWpWtZpw4
         e4Oe5zTacPkl2T+D6qdLoi/7cTfRNZzxOqohy6HKPW9dXl9lF/+e2Yo3cvi+VanDkwSZ
         cXOIy5/TYnZDHDT9FVXziUw3wVLvIIZ71fdCgxw707oQGU3Lk8x8h5OVDq7v1sXf1CPM
         j4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ii7pwlAa5b/FO+c9Vd/5idXbZ0PMVufp3scPnGgs1yU=;
        b=7KfrUBL2Kv+T8HA7DDdYhNky0CTxItsp2ndWyiGCoIuPPD1knkbWXl0RLDCzFVjGMV
         h1mIgjqgpDvGd3YjCCYZh1fSLPzoJSLdT4r6HtXvHn10rrIsigp+r44rg2uR+EaasxLx
         DM1f/qn3edA1cigg6IshhQPqFKBBWPPb25++wPWnlPAmpIagAMk0JoHy880oi9KMGnjq
         1TGjkzw8IIF0dLmS7voxWhyVMhxce85fLi0wj0SRr01DXv6FMslap8hfnNP1c/X/QNdP
         uhgzE8SnAg5HDmH0vMq0Hy1cohDmFWeoyRz2KRHXbUIlT3UN1aJ0ZBzRu5bxgxwPhYQW
         lpoA==
X-Gm-Message-State: AJIora8IldXMT/LDubOIfQkSos0Q8ZAD+s9AbmR0FY3mgI3b1Wvb1UI/
        Ql5GlCM+A9/xCvrkvULbzAgxFDeosDSv256zagwJl6OceAI=
X-Google-Smtp-Source: AGRyM1u/tJjnkHwqL7JU0xLIZpZCHSaq8OUENxeVG5QoIjM3aNj/ChS/5gtgcF81GLUHZ6NXfuD2CLfMT8IozzTQNWs=
X-Received: by 2002:aa7:c784:0:b0:43a:caa8:75b9 with SMTP id
 n4-20020aa7c784000000b0043acaa875b9mr15343278eds.311.1657601428612; Mon, 11
 Jul 2022 21:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220708060416.1788789-1-arilou@gmail.com> <20220708060416.1788789-2-arilou@gmail.com>
 <CAEf4BzZkfWTQppe97E1CTLKEqgtxP9gUQqbXB1EKRm5pK_ZmDA@mail.gmail.com>
 <YsjtxLuTvn8DWEA6@jondnuc> <CAADnVQLmAg9_StyD9_pMO0YUn-Yi1ozxfinxuQmkL0BYoTjbjw@mail.gmail.com>
 <CAP7QCohvoDZ0sk6sqA3112xsM4xzUc9uRHXiDNyt7M4jc3oUmg@mail.gmail.com>
 <CAADnVQJ7RaQyaSaRJ8aE=-0b2URNQFnCLhKX4GpL0H-yQyrTiA@mail.gmail.com>
 <CAP7QCogdYrsfGvEvhg5R8rQvWDe=o-nxgmqubZtfucH1zNc-RA@mail.gmail.com>
 <CAEf4BzYdhOF2wbnEZsMC6+hDz74Jss2_m1DHb_S3EiPqZborUQ@mail.gmail.com> <CAP7QCog2hiDsb1Z-hNNsUPTja3hXfNa-auv1yrwb0YWWrymWow@mail.gmail.com>
In-Reply-To: <CAP7QCog2hiDsb1Z-hNNsUPTja3hXfNa-auv1yrwb0YWWrymWow@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Jul 2022 21:50:17 -0700
Message-ID: <CAEf4Bzb33bP1jajRPfQVZ6RfXxpeWHOC9bWOw9k-aaE8ve+0dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] libbpf: perfbuf: allow raw access to buffers
To:     Jon Doron <arilou@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

On Mon, Jul 11, 2022 at 9:19 PM Jon Doron <arilou@gmail.com> wrote:
>
>
>
> On Tue, Jul 12, 2022, 07:01 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>
>> On Sun, Jul 10, 2022 at 10:07 AM Jon Doron <arilou@gmail.com> wrote:
>> >
>> >
>> > On Sun, Jul 10, 2022, 18:16 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> >>
>> >> On Sat, Jul 9, 2022 at 10:43 PM Jon Doron <arilou@gmail.com> wrote:
>> >> >
>> >> > I was referring to the following:
>> >> > https://github.com/libbpf/libbpf-rs/blob/master/libbpf-rs/src/perf_buffer.rs
>> >>
>> >> How does your patch help libbpf-rs?
>> >>
>> >> Please don't top post.
>> >
>> >
>> > You will be able to implement a custom perf buffer consumer, as it already has good bindings with libbpf-sys which is built from the C headers
>> >
>> > Sorry for the top posting I'm not home and replying from my phone
>> >
>>
>> I can see us exposing per-CPU buffers for (very) advanced users, something like:
>>
>> int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void
>> **buf, size_t buf_sz);
>
>
> Not sure I'm fully following what this API does, you will get a pointer to a message in the ring buffer?
> If so how do you consume without setting up a new tail?
>
> Or do you get a full copy of the current ring buffer (because that will mean you would have to alloc and copy which might hurt performance), but in that case you no longer a set tail or drain function.

No, it returns a pointer to mmap()'ed per-CPU buffer memory, including
its header page which contains head/tail positions. As I said, it's
for an advanced user, you need to know the layout and how to consume
data.

>
> Also perhaps regardless if this patchset will be approved or not it would probably be nice to have something like
> int perf_buffer__state(perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, size_t *free_space, size_t *used_space);
>
> Cheers,
> --Jon.
>
>>
>> Then in combination with perf_buffer__buffer_fd() you can implement
>> your own polling and processing. So you just use libbpf logic to setup
>> buffers, but then don't call perf_buffer__poll() at all and read
>> records and update tail on your own.
>>
>> But this combination of perf_buffer__raw_ring_buf() and
>> perf_buffer__set_ring_buf_tail() seems like a bad API, sorry.
>>
>>
>> >>
>> >> > Thanks,
>> >> > -- Jon.
>> >> >
>> >> > On Sun, Jul 10, 2022, 08:23 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> >> >>
>> >> >> On Fri, Jul 8, 2022 at 7:54 PM Jon Doron <arilou@gmail.com> wrote:
>> >> >> >
>> >> >> > On 08/07/2022, Andrii Nakryiko wrote:
>> >> >> > >On Thu, Jul 7, 2022 at 11:04 PM Jon Doron <arilou@gmail.com> wrote:
>> >> >> > >>
>> >> >> > >> From: Jon Doron <jond@wiz.io>
>> >> >> > >>
>> >> >> > >> Add support for writing a custom event reader, by exposing the ring
>> >> >> > >> buffer state, and allowing to set it's tail.
>> >> >> > >>
>> >> >> > >> Few simple examples where this type of needed:
>> >> >> > >> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>> >> >> > >>    to handle the wrap-around in some other way.
>> >> >> > >> 2. Since perf buf is per-cpu then the order of the events is not
>> >> >> > >>    guarnteed, for example:
>> >> >> > >>    Given 3 events where each event has a timestamp t0 < t1 < t2,
>> >> >> > >>    and the events are spread on more than 1 CPU, then we can end
>> >> >> > >>    up with the following state in the ring buf:
>> >> >> > >>    CPU[0] => [t0, t2]
>> >> >> > >>    CPU[1] => [t1]
>> >> >> > >>    When you consume the events from CPU[0], you could know there is
>> >> >> > >>    a t1 missing, (assuming there are no drops, and your event data
>> >> >> > >>    contains a sequential index).
>> >> >> > >>    So now one can simply do the following, for CPU[0], you can store
>> >> >> > >>    the address of t0 and t2 in an array (without moving the tail, so
>> >> >> > >>    there data is not perished) then move on the CPU[1] and set the
>> >> >> > >>    address of t1 in the same array.
>> >> >> > >>    So you end up with something like:
>> >> >> > >>    void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>> >> >> > >>    and move the tails as you process in order.
>> >> >> > >> 3. Assuming there are multiple CPUs and we want to start draining the
>> >> >> > >>    messages from them, then we can "pick" with which one to start with
>> >> >> > >>    according to the remaining free space in the ring buffer.
>> >> >> > >>
>> >> >> > >
>> >> >> > >All the above use cases are sufficiently advanced that you as such an
>> >> >> > >advanced user should be able to write your own perfbuf consumer code.
>> >> >> > >There isn't a lot of code to set everything up, but then you get full
>> >> >> > >control over all the details.
>> >> >> > >
>> >> >> > >I don't see this API as a generally useful, it feels way too low-level
>> >> >> > >and special for inclusion in libbpf.
>> >> >> > >
>> >> >> >
>> >> >> > Hi Andrii,
>> >> >> >
>> >> >> > I understand, but I was still hoping you will be willing to expose this
>> >> >> > API.
>> >> >> > libbpf has very simple and nice binding to Rust and other languages,
>> >> >> > implementing one of those use cases in the bindings can make things much
>> >> >> > simpler than using some libc or syscall APIs, instead of enjoying all
>> >> >> > the simplicity that you get for free in libbpf.
>> >> >> >
>> >> >> > Hope you will be willing to reconsider :)
>> >> >>
>> >> >> The discussion would have been different if you mentioned that
>> >> >> motivation in the commit logs.
>> >> >> Please provide links to "Rust and other languages" code that
>> >> >> uses this api.
