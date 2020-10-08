Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB96287D93
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgJHU72 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Oct 2020 16:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730874AbgJHU7Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Oct 2020 16:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602190764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gN3Ln5Vu/RDE/s48yZNAciHUYcjsvxHecDlnVYzl5AQ=;
        b=WGdx7oObjDNY14JtnGZuUFzPs1bMY67zlJkU9X8KlmoXqXGbF9mFdmIjjZHjtaATFmsg3R
        geCMqyi1Ld81MTlvkoVYSmzccFJxthVrclBoQQJq4youxdhCyM2Kyo+udWRPe+9Qx57SrB
        LRccMaM1X1p2klV1UvFOMAaIvMXvwws=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-m4alKyBCN7O-Ql4KbLbbFg-1; Thu, 08 Oct 2020 16:59:20 -0400
X-MC-Unique: m4alKyBCN7O-Ql4KbLbbFg-1
Received: by mail-wm1-f69.google.com with SMTP id a25so3553085wmb.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 13:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gN3Ln5Vu/RDE/s48yZNAciHUYcjsvxHecDlnVYzl5AQ=;
        b=VoQjV3wxulAjDkSfiR4SGdzqw9QObZf5ikmNGEH3WqxiZLWVLAf6H6sh2xKSzm3Qlm
         +3loAQuDXJVf+h02gFPjHOlQlc5NyGRf8sABeOhZ2LJK+R8N33iVaW+GMOYZGZ0W8GZ8
         0v9FLrHwVrHlg7/cqi2/B0lFnmdtiL+0qvtv1ocJpJmf7EXCL0/tGL8/wDGyWe0+et4U
         BAZY4O43fQ2Knh6C9BfkA5Wl/X7BX9dDf17HpbP6wSvhOnwl1/6CF33Q+gFLefNjY/Nx
         73dJ2VvAp4BIm35fXCwNppVkM9P7YRIkU9lfLJQqamlZGv3G1i2BQz++Uvari1wuiAJx
         blDw==
X-Gm-Message-State: AOAM5321v5NffDiUXQgqDUMgG9rWBNs2rD+u/CX05mbL1bCJM1XBmlZX
        BKJh9iwkgLMhYdn02YplN2WYcfw3xXDgH0x3rr/86PYTOPKqfzAZ9fRFLLtNq1dq8j0TDKom+NA
        +wDDbswDMv0SO
X-Received: by 2002:adf:e445:: with SMTP id t5mr10847387wrm.387.1602190759367;
        Thu, 08 Oct 2020 13:59:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2ioZa9AYDi6mbBOBwLtMRCgTFP019XkC4U1pMpogLYweKytdKZz/hzqEeMy986RhSKPwNcA==
X-Received: by 2002:adf:e445:: with SMTP id t5mr10847356wrm.387.1602190758897;
        Thu, 08 Oct 2020 13:59:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h3sm4063675wrw.78.2020.10.08.13.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:59:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DC16D1837DC; Thu,  8 Oct 2020 22:59:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH bpf-next] bpf_fib_lookup: return target ifindex even if
 neighbour lookup fails
In-Reply-To: <bf190e76-b178-d915-8d0d-811905d38fd2@iogearbox.net>
References: <20201008145314.116800-1-toke@redhat.com>
 <bf190e76-b178-d915-8d0d-811905d38fd2@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 08 Oct 2020 22:59:17 +0200
Message-ID: <87a6wwe8nu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 10/8/20 4:53 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The bpf_fib_lookup() helper performs a neighbour lookup for the destinat=
ion
>> IP and returns BPF_FIB_LKUP_NO_NEIGH if this fails, with the expectation
>> that the BPF program will pass the packet up the stack in this case.
>> However, with the addition of bpf_redirect_neigh() that can be used inst=
ead
>> to perform the neighbour lookup.
>>=20
>> However, for that we still need the target ifindex, and since
>> bpf_fib_lookup() already has that at the time it performs the neighbour
>> lookup, there is really no reason why it can't just return it in any cas=
e.
>> With this fix, a BPF program can do the following to perform a redirect
>> based on the routing table that will succeed even if there is no neighbo=
ur
>> entry:
>>=20
>> 	ret =3D bpf_fib_lookup(skb, &fib_params, sizeof(fib_params), 0);
>> 	if (ret =3D=3D BPF_FIB_LKUP_RET_SUCCESS) {
>> 		__builtin_memcpy(eth->h_dest, fib_params.dmac, ETH_ALEN);
>> 		__builtin_memcpy(eth->h_source, fib_params.smac, ETH_ALEN);
>>=20
>> 		return bpf_redirect(fib_params.ifindex, 0);
>> 	} else if (ret =3D=3D BPF_FIB_LKUP_RET_NO_NEIGH) {
>> 		return bpf_redirect_neigh(fib_params.ifindex, 0);
>> 	}
>>=20
>> Cc: David Ahern <dsahern@gmail.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> ACK, this looks super useful! Could you also add a new flag which would s=
kip
> neighbor lookup in the helper while at it (follow-up would be totally fin=
e from
> my pov since both are independent from each other)?

Sure, can do. Thought about adding it straight away, but wasn't sure if
it would be useful, since the fib lookup has already done quite a lot of
work by then. But if you think it'd be useful, I can certainly add it.
I'll look at this tomorrow; if you merge this before then I'll do it as
a follow-up, and if not I'll respin with it added. OK? :)

-Toke

