Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47E913CFDF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 23:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgAOWL1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 17:11:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31449 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728905AbgAOWL0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 17:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579126285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/sqbYejTlAOzWaaigNEcNtWHJ6yKyvV7eqQmqmzwdc=;
        b=WJtp2hcUKNW/Zhg24kDrqnxnT0qF/HgmnlXaxEfYLSPUrMWHV+z3j++c4BBkDEGloCR9hc
        D84y+kthj0ixBBtVlja7uWMrfSSr7qK7c0JcPUpoSUGNBsCM4dEZVlgWzccPDzHc/EkNbu
        XX9n+NOr7GcQO1P8zKKTAnML5zoeUcY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-AqAog7kJPYOVABKcB0GScw-1; Wed, 15 Jan 2020 17:11:24 -0500
X-MC-Unique: AqAog7kJPYOVABKcB0GScw-1
Received: by mail-lj1-f198.google.com with SMTP id s25so4467881ljm.9
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 14:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=X/sqbYejTlAOzWaaigNEcNtWHJ6yKyvV7eqQmqmzwdc=;
        b=gd/7yExCYzo0QzIJRImuYH/fgD1CPnb+HrPlw/8s10wBDkzkaR/CDY2rvSFSS6uDC5
         RjdjlyLdENEhnX1NcfeqtbdZ7XF4aLIZHGRBa0Dd/IKnd11WixYEGn3RGvn1Ey4ljuNM
         C2c6zD5V9ihe0ivL0CsVGd6EGVAYkLFXscf37/Op1FSWk0NuaSOGPQz4HTf8n8AK+pd1
         9G/JpTUvPC/wgm7x6xSHqBn15Gi85hUYpHR4fA9qiycP3WICOzIO6uGJhlLy0IsporbO
         xDwSIIjiyLDLeiLT1t+Mprkhn6+0I5ZOHzg3SvpuV9NgsWnUd3HpJKrBEfgySiuebB2I
         1u6Q==
X-Gm-Message-State: APjAAAUvIqlX2xftbuC74E5UZNXgTj+AgJhHPFkT03O5+4Ol4UcUOqOV
        rj3VHRawUAeWcvEhb2mJyWdG/LypHNtL3sEqNa+fWcWLIX6C1ApMD4AG06CYKDGiF606ReNHj48
        tFQ4kHrpA16HZ
X-Received: by 2002:a2e:58c:: with SMTP id 134mr345764ljf.12.1579126282708;
        Wed, 15 Jan 2020 14:11:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEou2WE8MV7zAWon3OyRorrTCejlrbvn2EWHiQoOUqmb7YAS+SMOwo/0LnFcHmKRs5WZu1ow==
X-Received: by 2002:a2e:58c:: with SMTP id 134mr345756ljf.12.1579126282577;
        Wed, 15 Jan 2020 14:11:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d4sm9403343lfn.42.2020.01.15.14.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:11:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 408DE1804D6; Wed, 15 Jan 2020 23:11:21 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>, brouer@redhat.com
Subject: Re: [PATCH bpf-next v2 1/2] xdp: Move devmap bulk queue into struct net_device
In-Reply-To: <20200115211734.2dfcffd4@carbon>
References: <157893905455.861394.14341695989510022302.stgit@toke.dk> <157893905569.861394.457637639114847149.stgit@toke.dk> <20200115211734.2dfcffd4@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jan 2020 23:11:21 +0100
Message-ID: <87imlctlo6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Mon, 13 Jan 2020 19:10:55 +0100
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>
>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> index da9c832fc5c8..030d125c3839 100644
>> --- a/kernel/bpf/devmap.c
>> +++ b/kernel/bpf/devmap.c
> [...]
>> @@ -346,8 +340,7 @@ static int bq_xmit_all(struct xdp_bulk_queue *bq, u3=
2 flags)
>>  out:
>>  	bq->count =3D 0;
>>=20=20
>> -	trace_xdp_devmap_xmit(&obj->dtab->map, obj->idx,
>> -			      sent, drops, bq->dev_rx, dev, err);
>> +	trace_xdp_devmap_xmit(NULL, 0, sent, drops, bq->dev_rx, dev, err);
>
> Hmm ... I don't like that we lose the map_id and map_index identifier.
> This is part of our troubleshooting interface.

Hmm, I guess I can take another look at whether there's a way to avoid
that. Any ideas?

-Toke

