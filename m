Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CCC287D8A
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 22:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgJHU5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Oct 2020 16:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728622AbgJHU5y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Oct 2020 16:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602190673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98YAahm8Cm7X3j4oM917dZyzd2CrTbVmRZhlcb9BHnI=;
        b=gC5RThajBCGnRn3ZDgM7FUQ52zo4pd8eiMpznT80z64RVS9GyQW7LPPj6PgneYsuBcgvkF
        cJA5UeABEywfM9McDow68wvAf44UKQd9f0YqtNEuTZru6p7l420lXrlDPFkfL/Fs9r5cYR
        uk/GbSSAo3B8m3Xs46Vug39kMRa+tHQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-w4iH9p8zOum-P8qHoiaQrg-1; Thu, 08 Oct 2020 16:57:51 -0400
X-MC-Unique: w4iH9p8zOum-P8qHoiaQrg-1
Received: by mail-ua1-f71.google.com with SMTP id b1so1621113uad.11
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 13:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=98YAahm8Cm7X3j4oM917dZyzd2CrTbVmRZhlcb9BHnI=;
        b=Swmx21ZeLNcj9le4ETGuSqKZJQQedS5UaJaD1W5JRashjgnc9sys2WsoNl586+NZu4
         DgD/ZOiCqqObaFtKGudC0iYF1h/xS2UBDSCCKTIxmSxJDItnr3jaJHk4nojm2F9/j5Tu
         BylCkNd49Bhl2BMo5m8dusEMneSAQPLzyn2D6u5bR6YpQaDWuieuM9H/55xdkO8HWTLb
         CzEnN2eRGRnQGUl3FTkN75+X2faraKKCRwM7OAQT9MYsc7Wmn0uTcYGnLBWW0yIDC4gT
         akfOYd+C87Gub/m4kBWenZWYgOo/EZj0qrlg2sNEMojs5ssDg/lbBMCn7atJyMPQvpPS
         KP6g==
X-Gm-Message-State: AOAM533pCX9tOOP4IiqmVN0TfMKQa9KHYJmS39iiKyRqA6MYKvmp+DnP
        PJkZGBQHhuGxT4aPgGEGh4oTECmujI1FOKfLXo33KigtB4ZNeVVvQVRWoLT8m3XRSRP7E397yQy
        jlB1GjBe9Vjs/
X-Received: by 2002:a05:6102:30b2:: with SMTP id y18mr6043497vsd.51.1602190670901;
        Thu, 08 Oct 2020 13:57:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl62iRU2I+0hZas3qXVggXJusiCKXH/8uEZdY+4D+fE4swFs9yYsv66jRXkToI6I4mRolgvQ==
X-Received: by 2002:a05:6102:30b2:: with SMTP id y18mr6043484vsd.51.1602190670583;
        Thu, 08 Oct 2020 13:57:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m125sm854438vkh.15.2020.10.08.13.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:57:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 46D201837DC; Thu,  8 Oct 2020 22:57:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     David Ahern <dsahern@gmail.com>, daniel@iogearbox.net, ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf_fib_lookup: return target ifindex even if
 neighbour lookup fails
In-Reply-To: <da1b5e5f-edb3-4384-c748-8170f51f6f6d@gmail.com>
References: <20201008145314.116800-1-toke@redhat.com>
 <da1b5e5f-edb3-4384-c748-8170f51f6f6d@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 08 Oct 2020 22:57:47 +0200
Message-ID: <87d01se8qc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Ahern <dsahern@gmail.com> writes:

> On 10/8/20 7:53 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
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
>
> There are a lot of assumptions in this program flow and redundant work.
> fib_lookup is generic and allows the caller to control the input
> parameters. direct_neigh does a fib lookup based on network header data
> from the skb.
>
> I am fine with the patch, but users need to be aware of the subtle detail=
s.

Yeah, I'm aware they are not equivalent; the code above was just meant
as a minimal example motivating the patch. If you think it's likely to
confuse people to have this example in the commit message, I can remove
it?

-Toke

