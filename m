Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF352165292
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 23:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBSWeq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 17:34:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51523 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727232AbgBSWep (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Feb 2020 17:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582151684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nl8XmgRfVXFQsqJYp+U1pyKQ6mhV4WooSWhRcLVnvo=;
        b=AfPgRIyqzigqHLLavjV0ABIHwrvYH3mOxqVx3KdhPhwTBDGDJA4I5ipLmcwWj4dkI2zLJc
        10K20+aXw4A0fb+ConNCmPfASeaYucCRFE5MkjwbnJmL6xqJprf3E1qbZy6WLrgJULWC4S
        lJtfBLEb1w7Wd8HDRCnM4OwQA2WeSLE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-fylyb6sFMxGrxVUy_UqrLg-1; Wed, 19 Feb 2020 17:34:42 -0500
X-MC-Unique: fylyb6sFMxGrxVUy_UqrLg-1
Received: by mail-lj1-f199.google.com with SMTP id m1so167862lji.5
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2020 14:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7nl8XmgRfVXFQsqJYp+U1pyKQ6mhV4WooSWhRcLVnvo=;
        b=nPQDgAZJ9jfx8s1bIS9/9+KMHqkEGe3/BcM8TzZK46YRqsbZEmHc3PjxjRYJoc3XJa
         qBelq4vqWSO7GuK+E24BB3CNTRb5kUt3BD2qcE3MqZapC0UHtgOysrMMujXNzdP2fP++
         8dO1D9ez+eyryGJKCXUCoZs2CoRArROjzM091HKMvZ+fXE7wP78tvwuEih/aI+Tixvm/
         coD45yPGOLctHDBl/l9r7Olk9wNgF+hyqU6/zBHgw0bWum+uTaLP6pjs/fM/twsfTud3
         akt1DAPLlkmU7f5I8Lc3bVIkfPu9F2KattthKuiczHSdH6UdUUKBQ++SAdiBNUJ1Fpqw
         ThXA==
X-Gm-Message-State: APjAAAWVa42h16ZiZqZPAYwY69E6QQ7wXDfQ6CW863+qTDG3u/69MOXs
        y2upRybLa5/ScmLk9E8xDOt/CeO80zlPVvINmWUjTUb6GGfN4sScyGxvraFzMQvW2jbhNJ4+Etf
        k2O803tbfxmT8
X-Received: by 2002:a2e:721a:: with SMTP id n26mr17063387ljc.128.1582151681032;
        Wed, 19 Feb 2020 14:34:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvWQFtxPjk1/T6HMqQjAhCQGTZZ+/vNOQhiEwlpDfZyoOdoBkZV6JpADcyTcoKqcxKbmS3Bw==
X-Received: by 2002:a2e:721a:: with SMTP id n26mr17063368ljc.128.1582151680748;
        Wed, 19 Feb 2020 14:34:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x23sm538480lff.24.2020.02.19.14.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:34:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3320E180365; Wed, 19 Feb 2020 23:34:39 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eelco Chaudron <echaudro@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Xdp <xdp-newbies@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: Capture xdp packets in an fentry BPF hook
In-Reply-To: <CAADnVQJzbAu3tdqn1DbyK+VFwYjp5rpgJOpPFLEcoe_mEr3YEw@mail.gmail.com>
References: <F844EC8A-902B-4BF7-95E3-B0D6DC618F1B@redhat.com> <20200219203626.ozkdoyhyexwxwbbt@ast-mbp> <87o8tuw7gj.fsf@toke.dk> <CAADnVQJzbAu3tdqn1DbyK+VFwYjp5rpgJOpPFLEcoe_mEr3YEw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 19 Feb 2020 23:34:39 +0100
Message-ID: <87ftf6w6io.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Feb 19, 2020 at 2:14 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Wed, Feb 19, 2020 at 03:38:40PM +0100, Eelco Chaudron wrote:
>> >> Hi Alexei at al.,
>> >>
>> >> I'm getting closer to finally have an xdpdump tool that uses the bpf
>> >> fentry/fexit tracepoints, but I ran into a final hurdle...
>> >>
>> >> To stuff the packet into a perf ring I'll need to use the
>> >> bpf_perf_event_output(), but unfortunately, this is a program of trac=
e type,
>> >> and not XDP so the packet data is not added automatically :(
>> >>
>> >> Secondly even trying to pass the actual packet data as a reference to
>> >> bpf_perf_event_output() will not work as the verifier wants the data =
to be
>> >> on the fp.
>> >>
>> >> Even worse, the trace program gets the XDP info not thought the ctx, =
but
>> >> trough the fentry/fexit input value, i.e.:
>> >>
>> >>      SEC("fentry/func")
>> >>      int BPF_PROG(trace_on_entry, struct xdp_buff *xdp)...
>> >>
>> >>      struct net_device {
>> >>          int ifindex;
>> >>      } __attribute__((preserve_access_index));
>> >>
>> >>      struct xdp_rxq_info {
>> >>          struct net_device *dev;
>> >>          __u32 queue_index;
>> >>      } __attribute__((preserve_access_index));
>> >>
>> >>      struct xdp_buff {
>> >>          void *data;
>> >>          void *data_end;
>> >>          void *data_meta;
>> >>          void *data_hard_start;
>> >>          unsigned long handle;
>> >>          struct xdp_rxq_info *rxq;
>> >>      } __attribute__((preserve_access_index));
>> >>
>> >> Hence even trying to copy in bytes to a local buffer is not allowed b=
y the
>> >> verifier, i.e. __u8 *data =3D (u8 *)(long)xdp->data;
>> >>
>> >> Can you let me know how you envisioned a BPF entry hook to capture pa=
ckets
>> >> from XDP. Am I missing something, or is there something missing from =
the
>> >> infrastructure?
>> >
>> > Tracing of XDP is missing a helper similar to bpf_skb_output() for skb.
>> > Its first arg will be 'struct xdp_buff *' and .arg1_type =3D ARG_PTR_T=
O_BTF_ID
>> > then it will work similar to bpf_skb_output() in progs/kfree_skb.c.
>>
>> What about freplace? Since that is also using the tracing
>> infrastructure, will the replacing program also be considered a tracing
>> program by the verifier? Or is it possible to load a program with an XDP
>> type, but still use it for freplace?
>
> Please see freplace example in progs/fexit_bpf2bpf.c
> freplace is not a separate type of program.
> It's not tracing and it's not networking.
> It's an extension of the target program.
> If target prog is xdp prog the extension will have access
> to the same struct xdp_md and the same xdp helpers.

Ah, great! It would seem I had not really looked at those examples,
other than to notice they were there. Thanks for the pointer, and sorry
for being dense! :)

-Toke

