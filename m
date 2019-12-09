Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205D5116FCB
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2019 16:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfLIPAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Dec 2019 10:00:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29375 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725956AbfLIPAo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Dec 2019 10:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575903642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0HCUKtQJAbUpJ+ekNPUKFso0jYZjlSODRayx14khF18=;
        b=LqTXEIbDE2KfEWYZxmYjxgzXP5wrP+zo+VAV4zvVYhd6b/Q8pKfPSWum9qLGu4tVcfUq5F
        VMLpNkO1lU+Gwq885MwPjqZSVxxRdsG4h3Okbhha4X1ngCheieKbgoX3kmsG9TNoT63xGa
        k09ylOirQuo/oRRPO2PdMYX1GJrZA/k=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-1ZJ9nafrNamHsk1lrKkOVg-1; Mon, 09 Dec 2019 10:00:40 -0500
Received: by mail-lj1-f199.google.com with SMTP id p90so3391839ljp.23
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2019 07:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0HCUKtQJAbUpJ+ekNPUKFso0jYZjlSODRayx14khF18=;
        b=rz8mBpT2Tr1O7/vBMF6sUK4daYMPU50E62jTOZwbSFGidDjcUQbn2R1qI8K2cPD8Eh
         tIC/J5Ishd/NZDqV6+X5f4XZsOnlvOXIel+FlJE7Hs2DsWFovdCZQ0EbLGbaAvfHgC+y
         Qc/D/Ug9pTy4f/zgtFKLk7ZUhWpG+xKaBsfyZSuwnn5yyjFB3QaQvf3ygvJo+ZYn6jME
         FQc2390IdE3/OxJE/N/Q8WqmCjtWZL7zmw3SIIicBGDOR/DDziEk1aIa9sJztnE/RvLm
         0SoQbM4j+CBltwYdlVLGKNHXFZLFIxXgzkZvcApI7hHTfGAS8XRkENdIzleKJeTl0EWb
         8iiA==
X-Gm-Message-State: APjAAAUpx0cWJeyc21RWBSOdeVzE9l5G+lI/2jxNFcnAt+zlLoqD5v6E
        1LN0dBAlbOmlEG+iY/w1wCj+/y3CoU+WuwX38DOgiHyQV5BG4rmTAQX0RBxoioKMBF+KA4vlhgg
        VrmpKRlPoMZ0D
X-Received: by 2002:a2e:a163:: with SMTP id u3mr9515193ljl.13.1575903638013;
        Mon, 09 Dec 2019 07:00:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFMlkNfAKPZmU0Br64uI/bfbLokfnE+LYIPMMT/kYtH+6ONW5Xf7JzgcnAaQ3f6ABdH8Dsig==
X-Received: by 2002:a2e:a163:: with SMTP id u3mr9515162ljl.13.1575903637772;
        Mon, 09 Dec 2019 07:00:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 22sm73304ljw.9.2019.12.09.07.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 07:00:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 41BC5181938; Mon,  9 Dec 2019 16:00:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        ecree@solarflare.com, thoiland@redhat.com,
        andrii.nakryiko@gmail.com
Subject: Re: [PATCH bpf-next v3 0/6] Introduce the BPF dispatcher
In-Reply-To: <20191209135522.16576-1-bjorn.topel@gmail.com>
References: <20191209135522.16576-1-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Dec 2019 16:00:36 +0100
Message-ID: <87h829ilwr.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 1ZJ9nafrNamHsk1lrKkOVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> This is the 4th iteration of the series that introduces the BPF
> dispatcher, which is a mechanism to avoid indirect calls.
>
> The BPF dispatcher is a multi-way branch code generator, targeted for
> BPF programs. E.g. when an XDP program is executed via the
> bpf_prog_run_xdp(), it is invoked via an indirect call. With
> retpolines enabled, the indirect call has a substantial performance
> impact. The dispatcher is a mechanism that transform indirect calls to
> direct calls, and therefore avoids the retpoline. The dispatcher is
> generated using the BPF JIT, and relies on text poking provided by
> bpf_arch_text_poke().
>
> The dispatcher hijacks a trampoline function it via the __fentry__ nop
> of the trampoline. One dispatcher instance currently supports up to 48
> dispatch points. This can be extended in the future.
>
> In this series, only one dispatcher instance is supported, and the
> only user is XDP. The dispatcher is updated when an XDP program is
> attached/detached to/from a netdev. An alternative to this could have
> been to update the dispatcher at program load point, but as there are
> usually more XDP programs loaded than attached, so the latter was
> picked.

I like the new version where it's integrated into bpf_prog_run_xdp();
nice! :)

> The XDP dispatcher is always enabled, if available, because it helps
> even when retpolines are disabled. Please refer to the "Performance"
> section below.

Looking at those numbers, I think I would moderate "helps" to "doesn't
hurt" - a difference of less than 1ns is basically in the noise.

You mentioned in the earlier version that this would impact the time it
takes to attach an XDP program. Got any numbers for this?

-Toke

