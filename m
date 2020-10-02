Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E4281AF5
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 20:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBSmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 14:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBSmN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 14:42:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47AC0613D0
        for <bpf@vger.kernel.org>; Fri,  2 Oct 2020 11:42:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k2so1849422ybp.7
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2020 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pgzU7gFlVfzUEcPPHczDf1BMPPp8y8h1G2UPzi4GtYg=;
        b=h/JbAyet6waY0WVrV51QWISYYgat9TLr675jTz5xWnesVpGxNGea5T9CySxB/YJsJB
         aG7O8kJX47AwDmEiVGUBF8lWI9vqQLzMxlqqy+hg4aL2K5wis0b+2NsejAMK8R6rgiAf
         WEcqFnRUpRn4Z24YrPmQSPFvRhNbRXdCPR2LXh6/9CvrsXvavD/sxgiTdZ1zN/C1OjLO
         OJWXECmG6y7rW8SWxF3Er5TvcHFkPWoDDP/FLtPXdrvRD7B1ocDre59QbDw3GgLjWitS
         Lr6Oc8c/gXxWdhk3qt+5z4mHTKHMd6uRPcIgMqRuT5On7UNW+hgdsg5weaSL6hwodqiL
         D+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgzU7gFlVfzUEcPPHczDf1BMPPp8y8h1G2UPzi4GtYg=;
        b=I2qzHT+9fo3KFQjbFwjMCpfcfPscdPpjnb5bRwe/UR2fNZ9tKMUplgD7q9wrhhjbaY
         XeVT/woOV+MmaHP7vOt4/fQx9V3LEFbgHiHr2KgHi7n9+0JoUl1fWEq6c+Y3yFcHZV1X
         YZIw1qISuNHfPWYGWXd4yQA4Bk58XeNxNOdaIfbpR3SYSn7QxRhbq70u+VepZ6yc2S2Y
         m4oSXsko9n+SpxhQ4+FKYWiL11Sosv6UA0Ge8KpNHNGeiCv6LSTyiMHzo2mvzw0j9TkX
         jVZfWubhJ3TTH7+c4Z1Go/KPRvQP7uSeznkvTfHm3oK8SGMzIEcpnAazw7XdHxNVWsIr
         xWyA==
X-Gm-Message-State: AOAM533s7keg83Gqhq2bC9emTzlHSzEHetwDyB/IsZqvhLsbhCtf2NhS
        XRAk8qOUkbrsw87+Zl+TVNoWttpoEENVyHRTqfM=
X-Google-Smtp-Source: ABdhPJyrb7kVG2zzRcya1qVZeoh/9ttqu76f+Z07oWDEaEJ0hpIFoSksZ72QCwrguQO5ylh7o8ZMIX6J7k/8iHllc24=
X-Received: by 2002:a25:2596:: with SMTP id l144mr4399061ybl.510.1601664130216;
 Fri, 02 Oct 2020 11:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_R4_ib0KvcuQC4nSOy5+Hn8-Xq-G8geDdLsNztX=0Fsw@mail.gmail.com>
In-Reply-To: <CACAyw9_R4_ib0KvcuQC4nSOy5+Hn8-Xq-G8geDdLsNztX=0Fsw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 2 Oct 2020 11:41:59 -0700
Message-ID: <CAEf4BzZst8uF-zf_o-mJvo53UG6WgTXHWyz5NgFFO1DbK22Khw@mail.gmail.com>
Subject: Re: BTF CO-RE bitfield relocation: why is the load size rounded?
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 2, 2020 at 4:25 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Hi Andrii,
>
> I'm trying to understand the following code from
> bpf_core_calc_field_relo in libbpf.c:
>
>     if (bitfield) {
>         byte_sz = mt->size;
>         byte_off = bit_off / 8 / byte_sz * byte_sz;
>         /* figure out smallest int size necessary for bitfield load */
>         while (bit_off + bit_sz - byte_off * 8 > byte_sz * 8) {
>             if (byte_sz >= 8) {
>                 ...
>                 return -E2BIG;
>             }
>             byte_sz *= 2;
>             byte_off = bit_off / 8 / byte_sz * byte_sz;
>         }
>     }
>
> It's used to calculate the load size (byte_sz) and load offset
> (byte_off) for a bitfield member of a struct. Can you explain to me
> why byte_off is rounded to byte_sz? Is it to preserve alignment?
>
> It seems like the rounding can lead to reading past the end of a
> struct. An example:
>
>     struct foo {
>         unsigned short boo:4;
>     } __attribute__((packed));
>
>     [2] STRUCT 'foo' size=1 vlen=1
>         'boo' type_id=3 bits_offset=0 bitfield_size=4
>     [3] INT 'unsigned short' size=2 bits_offset=0 nr_bits=16 encoding=(none)
>
> The result of the calculation for this is byte_sz = 2 and byte_off =
> 0, but the structure is only 1 byte in length.
>
> Would it be possible to replace the calculation with the following?
>
>     byte_off = bit_off / 8
>     byte_sz = ((bit_off + bit_sz + 7) - byte_off*8) / 8

Yes, it's for alignment. See BPF_CORE_READ_BITFIELD(), which reads the
underlying integer directly, which means that it has to be a
naturally-aligned memory read. Yes, it technically could be a problem
that we'll read 2 bytes in this case, but I don't think the kernel is
using that many packed structs and bitfields of interest are in the
very last byte of a packed struct... Packed structs are special and
annoying, but luckily not all that popular.

In this particular case reading one byte would be enough, so we could
change the logic to always start with a byte and see what's the
smallest int type we can get away with, ignoring what's the underlying
integer type (unsigned short in this case) was declared. But I'm not
sure that's a real problem worth solving.

But first, do you see any real issues in production with the current logic?

>
> Thanks
> Lorenz
>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
