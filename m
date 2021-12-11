Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845454714F6
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhLKRiM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Dec 2021 12:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhLKRiL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Dec 2021 12:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639244291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ASqsGdqGwmy6tBt5Un+IbVxTDzM4SfmgbGYRPDU4TV4=;
        b=WwniTxJeDwPoz7l0oW6EEOL7h0e+FlqB1eyb/Iwunsr2KmiEC2POqHMZJbLPhy8o7WMAE+
        EiJe3rz81gTIwLZzKUboLHUuGWPdBR0dDrJB1LQ4SzB1QuUNUbFDKdWoZiB0NY15UTzPkH
        s9oYSDIR9CMzZtSJBt4+X1aVhMk3pfs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-5K7fh9jIOv-zjthDtys8Cw-1; Sat, 11 Dec 2021 12:38:09 -0500
X-MC-Unique: 5K7fh9jIOv-zjthDtys8Cw-1
Received: by mail-ed1-f72.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso10681606eds.22
        for <bpf@vger.kernel.org>; Sat, 11 Dec 2021 09:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ASqsGdqGwmy6tBt5Un+IbVxTDzM4SfmgbGYRPDU4TV4=;
        b=5wJ6BfHk1H8mytwiDmvu98X6BQ5AlcTkxoJWhp4jUIbxM1WhRVbT1yMPKl8mgYrUiA
         Sd/rGnTxE4F8ytDAhzBtbaVpiN4L36yv6RN4HzwUWwtyCowQS4vAcN4srthxa54XZPDm
         7YxWw+cHdkSeD2ZAeibvXgq/whmjwuQXlULDT51q7w2qDmsEvlc3KdV1dZo88oOwquU+
         347CEv8rhK67pbC03qcViw+34/Vp6+ZfYzBPX8Mx2/a2hePoVnYj/+DHGiDeQG9koczf
         sMQTqlCINpPeqdqT72O5hB6B2Zn89pNJ2w9LblNKoSsSYoTCaOgM8WSj72D+j3R8wthT
         SeAg==
X-Gm-Message-State: AOAM532YDoOpNKJPWLsyc/0WBiE2lfkZcsVhgS2gzGzxnmEWHsKEGFHM
        zOU9tsFZhUOsLF1Z5R0JC61W6IfzaGUQPuO23NenuNyndWGkyc99Qlo5Q+DiTny8g+3+c4p92RU
        3tCjKlkqXiuce
X-Received: by 2002:a17:906:7109:: with SMTP id x9mr31497215ejj.559.1639244287881;
        Sat, 11 Dec 2021 09:38:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzP4HhgDQhu1cxOhOziOXERhExUHGglniiCh42iZ0X5NFreuCF5NHfjkQ+1xm34DkD4VHok9w==
X-Received: by 2002:a17:906:7109:: with SMTP id x9mr31497114ejj.559.1639244286704;
        Sat, 11 Dec 2021 09:38:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d18sm3385548edj.23.2021.12.11.09.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 09:38:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 40EAC180471; Sat, 11 Dec 2021 18:38:05 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v20 bpf-next 00/23] mvneta: introduce XDP multi-buffer
 support
In-Reply-To: <cover.1639162845.git.lorenzo@kernel.org>
References: <cover.1639162845.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 11 Dec 2021 18:38:05 +0100
Message-ID: <87v8zvujnm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> This series introduce XDP multi-buffer support. The mvneta driver is
> the first to support these new "non-linear" xdp_{buff,frame}. Reviewers
> please focus on how these new types of xdp_{buff,frame} packets
> traverse the different layers and the layout design. It is on purpose
> that BPF-helpers are kept simple, as we don't want to expose the
> internal layout to allow later changes.
>
> The main idea for the new multi-buffer layout is to reuse the same
> structure used for non-linear SKB. This rely on the "skb_shared_info"
> struct at the end of the first buffer to link together subsequent
> buffers. Keeping the layout compatible with SKBs is also done to ease
> and speedup creating a SKB from an xdp_{buff,frame}.
> Converting xdp_frame to SKB and deliver it to the network stack is shown
> in patch 05/18 (e.g. cpumaps).
>
> A multi-buffer bit (mb) has been introduced in the flags field of xdp_{bu=
ff,frame}
> structure to notify the bpf/network layer if this is a xdp multi-buffer f=
rame
> (mb =3D 1) or not (mb =3D 0).
> The mb bit will be set by a xdp multi-buffer capable driver only for
> non-linear frames maintaining the capability to receive linear frames
> without any extra cost since the skb_shared_info structure at the end
> of the first buffer will be initialized only if mb is set.
> Moreover the flags field in xdp_{buff,frame} will be reused even for
> xdp rx csum offloading in future series.
>
> Typical use cases for this series are:
> - Jumbo-frames
> - Packet header split (please see Google=E2=80=99s use-case @ NetDevConf =
0x14, [0])
> - TSO/GRO for XDP_REDIRECT
>
> The three following ebpf helpers (and related selftests) has been introdu=
ced:
> - bpf_xdp_load_bytes:
>   This helper is provided as an easy way to load data from a xdp buffer. =
It
>   can be used to load len bytes from offset from the frame associated to
>   xdp_md, into the buffer pointed by buf.
> - bpf_xdp_store_bytes:
>   Store len bytes from buffer buf into the frame associated to xdp_md, at
>   offset.
> - bpf_xdp_get_buff_len:
>   Return the total frame size (linear + paged parts)
>
> bpf_xdp_adjust_tail and bpf_xdp_copy helpers have been modified to take i=
nto
> account xdp multi-buff frames.
> Moreover, similar to skb_header_pointer, we introduced bpf_xdp_pointer ut=
ility
> routine to return a pointer to a given position in the xdp_buff if the
> requested area (offset + len) is contained in a contiguous memory area
> otherwise it must be copied in a bounce buffer provided by the caller run=
ning
> bpf_xdp_copy_buf().
>
> BPF_F_XDP_MB flag for bpf_attr has been introduced to notify the kernel t=
he
> eBPF program fully support xdp multi-buffer.
> SEC("xdp_mb/"), SEC_DEF("xdp_devmap_mb/") and SEC_DEF("xdp_cpumap_mb/" ha=
ve been
> introduced to declare xdp multi-buffer support.
> The NIC driver is expected to reject an eBPF program if it is running in =
XDP
> multi-buffer mode and the program does not support XDP multi-buffer.
> In the same way it is not possible to mix xdp multi-buffer and xdp legacy
> programs in a CPUMAP/DEVMAP or tailcall a xdp multi-buffer/legacy program=
 from
> a legacy/multi-buff one.
>
> More info about the main idea behind this approach can be found here
> [1][2].

Great to see this converging; as John said, thanks for sticking with it!
Nice round number on the series version as well ;)

For the series:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

