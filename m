Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B813CC486F
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 09:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfJBHZ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 03:25:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbfJBHZ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 03:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570001128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmZV823gGdTvbCQLqNBmGsxwm1rMY79XyCXkVHS7R/k=;
        b=DSjn+75IDOBX3U8Luw3/KOmf6Pp4B30WgQp8HwI4Ew0wqmPtggNPiVR71mHXQ4oAvrkpiS
        sMb0/A/1uUXNpZD7zLwNYPmJeHLcUpPMQXVLT0S8+dOtvpfvnIJk4p5T0S8aQerfi65Ijm
        Wgr9ZjEv2eruvc7rA2L0fK29lWh2lvA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-aKNkmiuyM7e_RrMQrynLYQ-1; Wed, 02 Oct 2019 03:25:24 -0400
Received: by mail-lj1-f197.google.com with SMTP id q185so4560225ljb.20
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 00:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JmZV823gGdTvbCQLqNBmGsxwm1rMY79XyCXkVHS7R/k=;
        b=AsQcNqrL9BhNOS0phxUAKiC2J4Hlvj8mcqKHD/B9JMt5dExl6Tm4pMA9bNmLAaHLWy
         NBz/tck3QbRr2oOoOVT547Hp+NWATb1sT9OxBBEJhNDgTFQxZtcaj9WCC0PstUIq0tQl
         +3dhEm+tlA4vB+hpJ8lk8f2HU4aSmR+ssiY8miSgHzIWpdqrO8ovZsHzuZJWHIVZg53P
         l/SG/GHCnMThz3WjRnmSIwrpT+LCl4mnHTxX2K28auH8O9tCtvUFUJD7gdnkv0b0o4Jw
         Ywk2QpMQh1rt6dyVTg+G6NUdpCyvexuB90fFpXo1n+iME4aWQzk6/Lw2QIyCFnlsFvTw
         7l+g==
X-Gm-Message-State: APjAAAVBZoHzDAKgwoskbGXYpSqAeaNwLwZgFoRDKn+eP+yBKPEgwVOi
        lmGF4JQE8uh+FBNGLxXiQ8b3xHj8+yiuGcr/hd9VsdkB1j1qx3a62ktLYnqqI9Q2Q5uDbwKWyFK
        gJ80wj5G0NmTe
X-Received: by 2002:a2e:7502:: with SMTP id q2mr1309243ljc.202.1570001123009;
        Wed, 02 Oct 2019 00:25:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzlVPLoTMS162SDTzASO2Zz8YVYZQU+kVwH0npGAOwDTRq/RIz/G24+vFRSztp+g3WNhuWO8A==
X-Received: by 2002:a2e:7502:: with SMTP id q2mr1309230ljc.202.1570001122807;
        Wed, 02 Oct 2019 00:25:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id z21sm4415599lfq.79.2019.10.02.00.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 00:25:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1A0D118063D; Wed,  2 Oct 2019 09:25:21 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: move bpf_helpers.h, bpf_endian.h into libbpf
In-Reply-To: <CAEf4Bzb8Q5nUppqBqnXH93U1con3895BJFHP88hQi5r6wohR6Q@mail.gmail.com>
References: <20190930185855.4115372-1-andriin@fb.com> <20190930185855.4115372-3-andriin@fb.com> <87d0fhvt4e.fsf@toke.dk> <5d93a6713cf1d_85b2b0fc76de5b424@john-XPS-13-9370.notmuch> <CAEf4Bzb8Q5nUppqBqnXH93U1con3895BJFHP88hQi5r6wohR6Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 02 Oct 2019 09:25:21 +0200
Message-ID: <875zl7txr2.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: aKNkmiuyM7e_RrMQrynLYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Oct 1, 2019 at 12:18 PM John Fastabend <john.fastabend@gmail.com>=
 wrote:
>>
>> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >
>> > > +struct bpf_map_def {
>> > > +   unsigned int type;
>> > > +   unsigned int key_size;
>> > > +   unsigned int value_size;
>> > > +   unsigned int max_entries;
>> > > +   unsigned int map_flags;
>> > > +   unsigned int inner_map_idx;
>> > > +   unsigned int numa_node;
>> > > +};
>> >
>> > Didn't we agree on no new bpf_map_def ABI in libbpf, and that all
>> > additions should be BTF-based?
>> >
>> > -Toke
>> >
>>
>> We use libbpf on pre BTF kernels so in this case I think it makes
>> sense to add these fields. Having inner_map_idx there should allow
>> us to remove some other things we have sitting around.
>
> We had a discussion about supporting non-BTF and non-standard BPF map
> definition before and it's still on my TODO list to go and do a proof
> of concept how that can look like and what libbpf changes we need to
> make. Right now libbpf doesn't support those new fields anyway, so we
> shouldn't add them to public API.

This was the thread; the context was libbpf support in iproute2:
https://lore.kernel.org/netdev/20190820114706.18546-1-toke@redhat.com/

Basically, we agreed that rather than adding more fields to bpf_map_def
in libbpf itself, we'd support BTF definitions natively, and provide
applications the right callbacks to support custom formats as they see
fit.

-Toke

