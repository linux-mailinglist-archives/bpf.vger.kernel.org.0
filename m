Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48162349B14
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 21:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhCYUhx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 16:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230354AbhCYUhc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Mar 2021 16:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616704651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=REsFlZWaFwS94cOpiKJC4aSsPkmlLN6+AWHGbguhTj8=;
        b=VdHpXVm9QFmdDFuHlRkmiuS2R8KsLtKQbyEaGskuHrQdeRTNIES2k5LhShqhhPqnGGMg4q
        m9JAttmJka6vp5bp6z0xZOfFlVt7nCukxqtCT13xZRCy1JPl3kjsN8uA+l2vPy/MBbBGKk
        Dp3pIcMdoGx9nc4whMRS223DJ8ltdr8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-2iCyPzWcPgaMxCT9q-HBAw-1; Thu, 25 Mar 2021 16:37:27 -0400
X-MC-Unique: 2iCyPzWcPgaMxCT9q-HBAw-1
Received: by mail-ed1-f71.google.com with SMTP id o24so3266257edt.15
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 13:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=REsFlZWaFwS94cOpiKJC4aSsPkmlLN6+AWHGbguhTj8=;
        b=EJbc82uyz0kgc3Sio6wpSX4wJ+uv4aVgeeGHuX3VCXrRNmwO+PpOvmP1JWpspIquZy
         I3ZLeaDjvBkr2RHinWiXVq2COPaAXxb8Qyjh9/YrHPOSKChxwWlEfc3Qg6Ix3CYTi64U
         iZ2Iu3hI5nMwYISRKR1bc6a55O8UiPJHk4Sjd1lvc1DWZgapiSlBjAeiTVdxhPE2StyD
         Pi5Tynog0Jyu/vPuhpDUryTJjr+WiLrD0AVUhkg6kar6W1M7PrvDdCMZJZUgiI7IGCUa
         BgatnOhv0PRubhojde3vPm+qIDqZ45h5sCjP7MfVmWb7YlkpuIPhmv5bQXrZzw0ImWfI
         WHnQ==
X-Gm-Message-State: AOAM531es6RnlE0OcBOcKQnjIS9aRD9cmkhVLOv21LN1fnHfCZuGmete
        vTpHyEw+V60kBPv0+ntdaK+OjyKRVJC7ZFGSohVZoal/ZR9z4615AyGhMq9H8FtH+fsRkpp6tcx
        w/fMzlHWdgnKk
X-Received: by 2002:aa7:cd63:: with SMTP id ca3mr11193249edb.265.1616704645672;
        Thu, 25 Mar 2021 13:37:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkbOGE64UOQhq5XOv0nezdIfl0kw0onM/WxrxplPAk6znBQ+pwjh7nm9uKsjX0kBwOkLW11g==
X-Received: by 2002:aa7:cd63:: with SMTP id ca3mr11193211edb.265.1616704645214;
        Thu, 25 Mar 2021 13:37:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l18sm2888629ejk.86.2021.03.25.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 13:37:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EA6F31801A3; Thu, 25 Mar 2021 21:37:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Clark Williams <williams@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: enforce that struct_ops programs be GPL-only
In-Reply-To: <20210325181552.ottuv7shqgfwxlsg@kafai-mbp.dhcp.thefacebook.com>
References: <20210325154034.85346-1-toke@redhat.com>
 <20210325181552.ottuv7shqgfwxlsg@kafai-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 25 Mar 2021 21:37:23 +0100
Message-ID: <87blb7dl6k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Thu, Mar 25, 2021 at 04:40:33PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> With the introduction of the struct_ops program type, it became possible=
 to
>> implement kernel functionality in BPF, making it viable to use BPF in pl=
ace
>> of a regular kernel module for these particular operations.
>>=20
>> Thus far, the only user of this mechanism is for implementing TCP
>> congestion control algorithms. These are clearly marked as GPL-only when
>> implemented as modules (as seen by the use of EXPORT_SYMBOL_GPL for
>> tcp_register_congestion_control()), so it seems like an oversight that t=
his
>> was not carried over to BPF implementations. And sine this is the only u=
ser
>> of the struct_ops mechanism, just enforcing GPL-only for the struct_ops
>> program type seems like the simplest way to fix this.
>>=20
>> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  kernel/bpf/verifier.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 44e4ec1640f1..48dd0c0f087c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -12166,6 +12166,11 @@ static int check_struct_ops_btf_id(struct bpf_v=
erifier_env *env)
>>  		return -ENOTSUPP;
>>  	}
>>=20=20
>> +	if (!prog->gpl_compatible) {
>> +		verbose(env, "struct ops programs must have a GPL compatible license\=
n");
>> +		return -EINVAL;
>> +	}
>> +
> Thanks for the patch.
>
> A nit.  Instead of sitting in between of the attach_btf_id check
> and expected_attach_type check, how about moving it to the beginning
> of this function.  Checking attach_btf_id and expected_attach_type
> would make more sense to be done next to each other as in the current
> code.

Yeah, good point. Not sure what I was thinking stuffing it in the middle
there; will fix and send a v2!

> Acked-by: Martin KaFai Lau <kafai@fb.com>

Thanks! :)

-Toke

