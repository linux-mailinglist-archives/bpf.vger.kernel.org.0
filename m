Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D11444B0E9
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 17:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhKIQQT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 11:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhKIQQT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 11:16:19 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C018C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 08:13:33 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p18so21712189plf.13
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8zyL9yEkIvxOu9rt3AL1lNRKfR/GgO+05wA84G2ODJs=;
        b=g0qOja+dPWqNXYf4Rh6B6OZMJ5tEdOYwVQmuzicmdVqDedK1yrz+Fp0yWHCThigxL/
         GsfqnKFCoTtxjowtBL/+S5jg/wBHrShhkfEln+cGAPnVxkIkPHWLye7wZKC+8CBFMYK4
         M1xPp5ebAHzCH/9U3/eSz8REnM3s7ytMch5E+dsFXMk8sV3k3gaqWHDFQQgnHy4BB93z
         t4JdimS5WXFOXvfMNQymD6FJ6ttkaHB21JhK19sPMVRzejX56km+9iJnZGuILEeIHU9b
         6UZ7RTIP8iHG4I+0q4McVDA8cAYBLyKHjCSmG1PKmShTIc4C6DG3RS0ianNIJUAlkuv5
         gAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8zyL9yEkIvxOu9rt3AL1lNRKfR/GgO+05wA84G2ODJs=;
        b=WdO9bQxKWA0lPdJJBZQAnnhVcwPZ8hoc7RyqNCrqiGoRBMtivX6NP6zBguYLRiarxS
         uxKkbw4W/AbM+mZV8woZYHKZpi+b4b12TwzEWyXPyDMnF0wK0XYIpgIxXyafEJTsLfk9
         hJU6d3aPaJWmty8ICHgLCJhctIJ8ubsJCvuG+cbwJTHNv1tmiCUkwmQWjczrEb7/BKQu
         QycB0V6M7rOE2aaujpb8M4vBRUaVUa8F5tkpyBF2ms6MvUaMaNxU1VXhLyvfejJi3jyx
         yGkig4c6nQ9i5X9BFxRaeNgxLvW3mFQbfVT1pMc34cgIEcQhBWUHnMhi+7vFFPlQV7Gr
         voIQ==
X-Gm-Message-State: AOAM531fqWz70BbsD3uWRGIEoHNSxT6ie8+EdJLfYFnDvNGkcbbqdT9m
        n4NqTzY1rbM/OiTLymxLJxXtntYPjXEN2N46VGy9OQzn7e0=
X-Google-Smtp-Source: ABdhPJzWnFhP5TqoRsSW5/vtBgr9b6L7oneWqlUADU2BTpoahs8WLQjeb0UhYL3E3HXOSKG9pRTRWoaFGZqdzOa+xXI=
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr8478954pjj.138.1636474412343;
 Tue, 09 Nov 2021 08:13:32 -0800 (PST)
MIME-Version: 1.0
References: <36467ea3-8b19-f385-c2d0-02e2bd9c934e@polito.it>
 <CAADnVQLszubAWyq+Mch0xRneyhVpqNwQhrW3u_eocN6NzRcpEw@mail.gmail.com> <59fac794-ae38-783c-dd02-7506283cc2c4@polito.it>
In-Reply-To: <59fac794-ae38-783c-dd02-7506283cc2c4@polito.it>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Nov 2021 08:13:20 -0800
Message-ID: <CAADnVQJz_=xCwzG=Da8AgJX6mm_gEv-URjcfEzWmL9+4nzKOMg@mail.gmail.com>
Subject: Re: Add variable offset to packet pointer in XDP/TC programs
To:     Federico Parola <federico.parola@polito.it>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 5:47 AM Federico Parola
<federico.parola@polito.it> wrote:
>
> Thanks for your answer.

Please do not top post and don't drop mailing list.

> If I perform something like:
>
> *(__u16 *)data &= 0xefff;
> data += *(__u16 *)data;
>
> To limit the max value of my offset the program is accepted, is this
> what you mean with "clamping"?

kinda. I don't think you meant to mangle the packet in the above.

> So packet pointers are stored on 16 bits? And every time we add an
> offset we must guarantee not to overflow these size?

no. the pointers are 64-bit, but there could be additional alu ops
on them. So MAX_PACKET_OFF was picked as the practical limit.

Do you have a real life use case where you need to add full u16?

>
> On 09/11/21 06:29, Alexei Starovoitov wrote:
> > On Mon, Nov 8, 2021 at 6:04 AM Federico Parola
> > <federico.parola@polito.it> wrote:
> >>
> >> Dear all,
> >> I found out that every time an offset stored in a 2 (or more) bytes
> >> variable is added to a packet pointer subsequent checks against packet
> >> boundaries become ineffective.
> >> Here is a toy example to test the problem (it doesn't do anything useful):
> >>
> >> int test(struct __sk_buff *ctx) {
> >>       void *data = (void *)(long)ctx->data;
> >>       void *data_end = (void *)(long)ctx->data_end;
> >>
> >>       /* Skipping an amount of bytes stored in __u8 works */
> >>       if (data + sizeof(__u8) > data_end)
> >>           return TC_ACT_OK;
> >>       bpf_trace_printk("Skipping %d bytes", *(__u8 *)data);
> >>       data += *(__u8 *)data;
> >>
> >>       /* Skipping an amount of bytes stored in __u16 works but... */
> >>       if (data + sizeof(__u16) > data_end)
> >>           return TC_ACT_OK;
> >>       bpf_trace_printk("Skipping %d bytes", *(__u16 *)data);
> >>       data += *(__u16 *)data;
> >>
> >>       /* ...this check is not effective and packet access is rejected */
> >>       if (data + sizeof(__u8) > data_end)
> >>           return TC_ACT_OK;
> >>       bpf_trace_printk("Next byte is %x", *(__u8 *)data);
> >>
> >>       return TC_ACT_OK;
> >> }
> >>
> >> My practical use case would be skipping variable-size TLS header
> >> extensions until I reach the desired one (the length of these options is
> >> 2 bytes long).
> >> Another use case can be found here:
> >> https://lists.iovisor.org/g/iovisor-dev/topic/access_packet_payload_in_tc/86442134
> >> After I use the bpf_skb_pull_data() I would like to directly jump to the
> >> part of packet I was working on and avoid re-parsing everything from
> >> scratch, however if I save the offset in a 2 bytes variable and then add
> >> it to the packet pointer I'm no longer able to access it (if the offset
> >> is stored in a 1 byte var everything works).
> >>
> >> Is this a verifier bug?
> >
> > It's because of:
> >          if (dst_reg->umax_value > MAX_PACKET_OFF ||
> >              dst_reg->umax_value + dst_reg->off > MAX_PACKET_OFF)
> >                  /* Risk of overflow.  For instance, ptr + (1<<63) may be less
> >                   * than pkt_end, but that's because it's also less than pkt.
> >                   */
> >                  return;
> >
> > by adding u16 scalar the offset becomes bigger than MAX_PACKET_OFF.
> > Could you try clamping the value before 'data += ' ?
> >
