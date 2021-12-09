Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B7646EC87
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbhLIQJc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 11:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236564AbhLIQJb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 11:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639065957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZejQbQDCxehKZqduIxF41twQj65ihf/hPSBd0mgmYQ=;
        b=Col+DTVplLZngBJH1u0C913k1C0R2r0FVeeB7oszZR2UsWd4udplEke0GVqdHQ2vaIAj3t
        4nOg+4YbFAmXaDTs8P6NdBriBlgWHGhV4HtOVVOaf4mMr8+FaTMjPuluCeDKcFZOFCmsXO
        +DIZij40fEwElAKS2YR7c4tU3kEulgM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-FOrAZZ-DOLyD2FnqGOxuqQ-1; Thu, 09 Dec 2021 11:05:56 -0500
X-MC-Unique: FOrAZZ-DOLyD2FnqGOxuqQ-1
Received: by mail-ed1-f71.google.com with SMTP id p4-20020aa7d304000000b003e7ef120a37so5623218edq.16
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 08:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AZejQbQDCxehKZqduIxF41twQj65ihf/hPSBd0mgmYQ=;
        b=YDkuJBGISpnl6vG558rYFCWFIhk8yQeXAlkSvjX/4GdLxP/G2SArhV/h6qv9QSqNqP
         KEWH2NizCoXXMGqf08NxeN0wsA8hGIGEKXsTC9sTVQdoSJ2B7IPZbvkPAAuU6JjWuGvg
         Jy584sgttRahXTh9cbpFlyT8mcqj7lc72bahtkpB61StUK2a+ITSniP1MiWIZlEBZ8kr
         RM/WkiwC7GwMj73ifrVbYmJNLEFgVNWscGBz6xUSfwYuUQJUBKW7qiaZsbPPw2xEUR3A
         TQZlF83veEc4Z7HzALxFD4cpmRT7+cNL+g+woVU4ANsIEDFt+ZSorojCEnn5MEZeV9e0
         1tEg==
X-Gm-Message-State: AOAM533M/LMFas+Fg+4wekHCAz1HDBxoMJ9pwcFJo/HgE1V4hSl1ICtw
        9/Xlyjm5SiNHr4+Ft+VEXZq3rXciCYLpsuWKmwzkXfzbgCY0x8XeE9InEf3SPvrtVwnzTZuWdJC
        ADGPmGxflihmc
X-Received: by 2002:aa7:c946:: with SMTP id h6mr30995702edt.190.1639065954382;
        Thu, 09 Dec 2021 08:05:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywPn7TyRBgssPXLO3mnJ5AguEajLMBmJ5OYDuwDzh1EfBliQ/j7l5loknTbVgPUAk23MYu/A==
X-Received: by 2002:aa7:c946:: with SMTP id h6mr30995549edt.190.1639065953388;
        Thu, 09 Dec 2021 08:05:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gt18sm126238ejc.88.2021.12.09.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:05:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 355B8180471; Thu,  9 Dec 2021 17:05:52 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: RE: [PATCH bpf-next 5/8] xdp: add xdp_do_redirect_frame() for
 pre-computed xdp_frames
In-Reply-To: <61b14e4ae483b_979572082c@john.notmuch>
References: <20211202000232.380824-1-toke@redhat.com>
 <20211202000232.380824-6-toke@redhat.com>
 <61b14e4ae483b_979572082c@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 09 Dec 2021 17:05:52 +0100
Message-ID: <87wnkdwyov.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Add an xdp_do_redirect_frame() variant which supports pre-computed
>> xdp_frame structures. This will be used in bpf_prog_run() to avoid having
>> to write to the xdp_frame structure when the XDP program doesn't modify =
the
>> frame boundaries.
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  include/linux/filter.h |  4 ++++
>>  net/core/filter.c      | 28 +++++++++++++++++++++-------
>>  2 files changed, 25 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index b6a216eb217a..845452c83e0f 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1022,6 +1022,10 @@ int xdp_do_generic_redirect(struct net_device *de=
v, struct sk_buff *skb,
>>  int xdp_do_redirect(struct net_device *dev,
>>  		    struct xdp_buff *xdp,
>>  		    struct bpf_prog *prog);
>> +int xdp_do_redirect_frame(struct net_device *dev,
>> +			  struct xdp_buff *xdp,
>> +			  struct xdp_frame *xdpf,
>> +			  struct bpf_prog *prog);
>
> I don't really like that we are passing both the xdp_buff ptr and
> xdp_frame *xdpf around when one is always null it looks like?

Yeah, the problem is basically that AF_XDP uses xdp_buff all the way
through, so we can't pass xdp_frame to that. I do agree that it's a bit
ugly, though; maybe we can just do the XSK disambiguation in the caller;
will take another look at this - thanks!

-Toke

