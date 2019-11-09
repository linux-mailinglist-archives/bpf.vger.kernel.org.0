Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDBF5EB1
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKILUj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 9 Nov 2019 06:20:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKILUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Nov 2019 06:20:38 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4BF5C04959B
        for <bpf@vger.kernel.org>; Sat,  9 Nov 2019 11:20:37 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id l12so1755960lji.10
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2019 03:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ulYzhY/X/XliFRvvD51//EKHL7qdHMox+MyseD2je64=;
        b=faFlBm8dBYKQpyjk8yRrybujuQpJbNPCiOVPMMxfoM7EtO/CljWUnbga06gL5gMfeQ
         WCQB/itkBitQADVYsbzG8uoN0uq8h0A9QQZUB9/QhR2O5MtWSsbVbFUDrUZKn8vguisQ
         heEXuwCB3fNQbfhQmg/x9y64S7q8TxRy/T9JIBebEwsvsMaDI1iI2gsX55CwoA6I2JGN
         TwjxPQHy8gbIkix533+hHLxpTqmaKnyWiPE4yp1GumHorry4vFb9QTJWvwMYRARM4it0
         JBsY80i+A3FiOWuOft8M7wa30aRIZrBJn09S6FCw0aYOz+OixzXlZmOKH9V+WRXobitk
         14TQ==
X-Gm-Message-State: APjAAAUFXYxoPS09d86roeb3ceg2a/qKls4W+f7ov4/R2cYabEWACfL+
        /2z1C9qO0rTxPUewIF6MRiuX6Zjinn4w/P6QNpM+sg09MppmHsdly2+Lg6LzVD8pUSu/LV+acUB
        XXrGFKtkh/yAt
X-Received: by 2002:a05:6512:75:: with SMTP id i21mr9616680lfo.180.1573298436475;
        Sat, 09 Nov 2019 03:20:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyicpHK0JXQDny9sWcldFEKAuRW37Y66w039QGvH0p2nWOJ7g+G1XgifCIwSoWC8jPR0uozA==
X-Received: by 2002:a05:6512:75:: with SMTP id i21mr9616668lfo.180.1573298436286;
        Sat, 09 Nov 2019 03:20:36 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id a1sm648286lfg.11.2019.11.09.03.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 03:20:35 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B5EB1800CC; Sat,  9 Nov 2019 12:20:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 5/6] libbpf: Add bpf_get_link_xdp_info() function to get more XDP information
In-Reply-To: <CAEf4BzYvv6pCHygeNyOBE4MRtcLxE1XP4Ww+sxoaPgQw5i1Rjw@mail.gmail.com>
References: <157325765467.27401.1930972466188738545.stgit@toke.dk> <157325766011.27401.5278664694085166014.stgit@toke.dk> <CAEf4BzYvv6pCHygeNyOBE4MRtcLxE1XP4Ww+sxoaPgQw5i1Rjw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 09 Nov 2019 12:20:34 +0100
Message-ID: <87mud5qosd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Nov 8, 2019 at 4:01 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> Currently, libbpf only provides a function to get a single ID for the XDP
>> program attached to the interface. However, it can be useful to get the
>> full set of program IDs attached, along with the attachment mode, in one
>> go. Add a new getter function to support this, using an extendible
>> structure to carry the information. Express the old bpf_get_link_id()
>> function in terms of the new function.
>>
>> Acked-by: David S. Miller <davem@davemloft.net>
>> Acked-by: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>>  tools/lib/bpf/libbpf.h   |   10 ++++++
>>  tools/lib/bpf/libbpf.map |    1 +
>>  tools/lib/bpf/netlink.c  |   82 ++++++++++++++++++++++++++++++----------------
>>  3 files changed, 65 insertions(+), 28 deletions(-)
>>
>
> [...]
>
>>
>> -int bpf_get_link_xdp_id(int ifindex, __u32 *prog_id, __u32 flags)
>> +int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
>> +                         size_t info_size, __u32 flags)
>>  {
>>         struct xdp_id_md xdp_id = {};
>>         int sock, ret;
>>         __u32 nl_pid;
>>         __u32 mask;
>>
>> -       if (flags & ~XDP_FLAGS_MASK)
>> +       if (flags & ~XDP_FLAGS_MASK || info_size < sizeof(*info))
>>                 return -EINVAL;
>
> Well, now it's backwards-incompatible: older program passes smaller
> (but previously perfectly valid) sizeof(struct xdp_link_info) to newer
> version of libbpf. This has to go both ways: smaller struct should be
> supported as long as program doesn't request (using flags) something,
> that can't be put into allowed space.

But there's nothing to be backwards-compatible with? I get that *when*
we extend the size of xdp_link_info, we should still accept the old,
smaller size. But in this case that cannot happen as we're only just
introducing this now?

-Toke
