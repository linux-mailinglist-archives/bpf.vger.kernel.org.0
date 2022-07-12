Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E66257110E
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 06:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiGLEBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 00:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiGLEBm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 00:01:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A426528A5
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:01:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b11so12117414eju.10
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kT2r5bXyyxeN6NrpeFpl2k09VZQrQR0074qwhlmUFjk=;
        b=IU2W7gR++ywMtiYRSMh2hsXWLRHA856l1OAjAaAZx0r5cHGQjc3o9VUKyTL08a9pNF
         2/37iDfRRJxTKKmQSLFtndBlg+8HiwEvVTiV0X5W0fcv8F0a1ZTcak6QmyJ3hLQ0QERQ
         K1KPavQqYNiAr6LNY+Phj76xH4fGesw8ZX9BE5F3bJ0oh1cXpBwKFEUK7pYN7z/mnlCS
         7QkalML95auRnqino6vEPSumxX10+lBd3abpzzt+pEPaj38pjpHgbIRYSz3tJYBuwdhJ
         j8aGO/ywIgBGjDWvGZVOcOqUBeS1oDJQ/jVp9qh00ibsmcWXS2EAEBhsRf/TqwsKvPEa
         VvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kT2r5bXyyxeN6NrpeFpl2k09VZQrQR0074qwhlmUFjk=;
        b=7qPbIOF825tJ3XodKb2rXsO79cWV5RwlrS8OuT6bSeJHTBrEQdljuF16qAtoXYfa4V
         XfM0WrbxvOzJ57eVKEX/ssXYWdWrtPBx0Y7wH589UgDjwGDmwTfTsXzUIKdq78Iw7H2q
         UCAZN8SnASwbBLCs30IIvP0GmctJ9wvYZDLKaOzRrZ9yViVgHPeFB/wZQ1kAQgeKDYx0
         WZnGNkmTLnzo0Nk5e/FjFDPoLi4zrAXGuxuoJZOS8Z84KsTnh8TQX9uuT6dKu+tmZ3D+
         9BJzwngPTNG5hc8oSB/RMDkQpYazSPVw8D1MWUuC+8+TCC+4NjiH4y5onRbSbmnfoj2S
         pIgA==
X-Gm-Message-State: AJIora9XQYgXrtdCxlDrdEwn7iSH7B4M6V0sW0cdas/MRVbICkfwkqe1
        D/XaD1DXtV/Dk3fnkottT67TDmp3yk2kLzYVJufiillbiphYTg==
X-Google-Smtp-Source: AGRyM1v/fj2kdaeCxAnx4UmAMfT8u55MoZuz0aHtQUe5OIXF5XT0vvjZAF95k7zjVJaeNSuw0ZXCAOgtP4jKdclecj8=
X-Received: by 2002:a17:907:2ccc:b0:72b:6907:fce6 with SMTP id
 hg12-20020a1709072ccc00b0072b6907fce6mr5102925ejc.115.1657598499485; Mon, 11
 Jul 2022 21:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220708060416.1788789-1-arilou@gmail.com> <20220708060416.1788789-2-arilou@gmail.com>
 <CAEf4BzZkfWTQppe97E1CTLKEqgtxP9gUQqbXB1EKRm5pK_ZmDA@mail.gmail.com>
 <YsjtxLuTvn8DWEA6@jondnuc> <CAADnVQLmAg9_StyD9_pMO0YUn-Yi1ozxfinxuQmkL0BYoTjbjw@mail.gmail.com>
 <CAP7QCohvoDZ0sk6sqA3112xsM4xzUc9uRHXiDNyt7M4jc3oUmg@mail.gmail.com>
 <CAADnVQJ7RaQyaSaRJ8aE=-0b2URNQFnCLhKX4GpL0H-yQyrTiA@mail.gmail.com> <CAP7QCogdYrsfGvEvhg5R8rQvWDe=o-nxgmqubZtfucH1zNc-RA@mail.gmail.com>
In-Reply-To: <CAP7QCogdYrsfGvEvhg5R8rQvWDe=o-nxgmqubZtfucH1zNc-RA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Jul 2022 21:01:28 -0700
Message-ID: <CAEf4BzYdhOF2wbnEZsMC6+hDz74Jss2_m1DHb_S3EiPqZborUQ@mail.gmail.com>
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

On Sun, Jul 10, 2022 at 10:07 AM Jon Doron <arilou@gmail.com> wrote:
>
>
> On Sun, Jul 10, 2022, 18:16 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>
>> On Sat, Jul 9, 2022 at 10:43 PM Jon Doron <arilou@gmail.com> wrote:
>> >
>> > I was referring to the following:
>> > https://github.com/libbpf/libbpf-rs/blob/master/libbpf-rs/src/perf_buffer.rs
>>
>> How does your patch help libbpf-rs?
>>
>> Please don't top post.
>
>
> You will be able to implement a custom perf buffer consumer, as it already has good bindings with libbpf-sys which is built from the C headers
>
> Sorry for the top posting I'm not home and replying from my phone
>

I can see us exposing per-CPU buffers for (very) advanced users, something like:

int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void
**buf, size_t buf_sz);

Then in combination with perf_buffer__buffer_fd() you can implement
your own polling and processing. So you just use libbpf logic to setup
buffers, but then don't call perf_buffer__poll() at all and read
records and update tail on your own.

But this combination of perf_buffer__raw_ring_buf() and
perf_buffer__set_ring_buf_tail() seems like a bad API, sorry.


>>
>> > Thanks,
>> > -- Jon.
>> >
>> > On Sun, Jul 10, 2022, 08:23 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> >>
>> >> On Fri, Jul 8, 2022 at 7:54 PM Jon Doron <arilou@gmail.com> wrote:
>> >> >
>> >> > On 08/07/2022, Andrii Nakryiko wrote:
>> >> > >On Thu, Jul 7, 2022 at 11:04 PM Jon Doron <arilou@gmail.com> wrote:
>> >> > >>
>> >> > >> From: Jon Doron <jond@wiz.io>
>> >> > >>
>> >> > >> Add support for writing a custom event reader, by exposing the ring
>> >> > >> buffer state, and allowing to set it's tail.
>> >> > >>
>> >> > >> Few simple examples where this type of needed:
>> >> > >> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>> >> > >>    to handle the wrap-around in some other way.
>> >> > >> 2. Since perf buf is per-cpu then the order of the events is not
>> >> > >>    guarnteed, for example:
>> >> > >>    Given 3 events where each event has a timestamp t0 < t1 < t2,
>> >> > >>    and the events are spread on more than 1 CPU, then we can end
>> >> > >>    up with the following state in the ring buf:
>> >> > >>    CPU[0] => [t0, t2]
>> >> > >>    CPU[1] => [t1]
>> >> > >>    When you consume the events from CPU[0], you could know there is
>> >> > >>    a t1 missing, (assuming there are no drops, and your event data
>> >> > >>    contains a sequential index).
>> >> > >>    So now one can simply do the following, for CPU[0], you can store
>> >> > >>    the address of t0 and t2 in an array (without moving the tail, so
>> >> > >>    there data is not perished) then move on the CPU[1] and set the
>> >> > >>    address of t1 in the same array.
>> >> > >>    So you end up with something like:
>> >> > >>    void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>> >> > >>    and move the tails as you process in order.
>> >> > >> 3. Assuming there are multiple CPUs and we want to start draining the
>> >> > >>    messages from them, then we can "pick" with which one to start with
>> >> > >>    according to the remaining free space in the ring buffer.
>> >> > >>
>> >> > >
>> >> > >All the above use cases are sufficiently advanced that you as such an
>> >> > >advanced user should be able to write your own perfbuf consumer code.
>> >> > >There isn't a lot of code to set everything up, but then you get full
>> >> > >control over all the details.
>> >> > >
>> >> > >I don't see this API as a generally useful, it feels way too low-level
>> >> > >and special for inclusion in libbpf.
>> >> > >
>> >> >
>> >> > Hi Andrii,
>> >> >
>> >> > I understand, but I was still hoping you will be willing to expose this
>> >> > API.
>> >> > libbpf has very simple and nice binding to Rust and other languages,
>> >> > implementing one of those use cases in the bindings can make things much
>> >> > simpler than using some libc or syscall APIs, instead of enjoying all
>> >> > the simplicity that you get for free in libbpf.
>> >> >
>> >> > Hope you will be willing to reconsider :)
>> >>
>> >> The discussion would have been different if you mentioned that
>> >> motivation in the commit logs.
>> >> Please provide links to "Rust and other languages" code that
>> >> uses this api.
