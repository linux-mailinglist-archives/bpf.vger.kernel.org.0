Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0854718C92E
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 09:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgCTIsj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Mar 2020 04:48:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59380 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgCTIsi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Mar 2020 04:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584694117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwZKxgPtr217y9j+8LCqGiZ1aUiHBLkFAj8B3Yqj8Lk=;
        b=VrfCnN2YvIxYyNB56BAcIu52SRQ2/vrTOGQK2BtpmcxFLrkk33FVEwjxTqE6aBorVmvBMp
        ymB0IGVKksMypkS7Y2/d7syRvwJ9IpFnz28TDaQIYHj7XW5lNSssPC1q6Av0ToVWxKYqld
        NMxchAaZvdqYJ4iD/iodKUl4x2i8y28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-WxOqXGhtP6maj_-XKW_FJw-1; Fri, 20 Mar 2020 04:48:36 -0400
X-MC-Unique: WxOqXGhtP6maj_-XKW_FJw-1
Received: by mail-wr1-f71.google.com with SMTP id i18so2291620wrx.17
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2020 01:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NwZKxgPtr217y9j+8LCqGiZ1aUiHBLkFAj8B3Yqj8Lk=;
        b=AurdlZy8e5xthJWzK60l6jlbtBNk5jX5oUa/OpgDvkMZUdQuYpFHsXVhjOEi1zMtzW
         xPf5MnBJWGtaczqphPeGJ6oTxaiwsj/DvG04GoNVJ+5jAT3KlabHS0pXNQyxkdUrXOqw
         zXkLKsLeQVVq6L8WYp3aMy+gkcB1cIeOYK8QMjs3E//rSGICWREWGCYCUGRCe3GBg5jO
         r/lqIFFPHm45+aT41OODQPrK/q1gsNdT8U8bDJP8WVCJa+1w/tITP8FpNZnpLOL9K03u
         +7R/f3XP9pJTJLgwIpMTw8YyLgDjIhwbS9UZD31yj/0xxUiLY8Sxfgm5/QEycGrzELji
         6i9w==
X-Gm-Message-State: ANhLgQ1HuL6f2H2tEkBTUwxu/tuUIBypO3lAh72UAUGx3D+rmVbzpMJz
        awiS/G+g2LMvBSje2UCCbUu83uiC2dgz7VzKVNJL2BpFwsm363bs1tvNBeHL9bfGDG7z3rhAAo1
        QL/as9jGZl8nu
X-Received: by 2002:a05:600c:2190:: with SMTP id e16mr2184316wme.42.1584694115376;
        Fri, 20 Mar 2020 01:48:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vug8W1V6BPAASIQ46ykCcec8tf0lmHsc2mVRHRnwlW+zdwKGKBo2hvYwmGbMntAOR8NEfwaVg==
X-Received: by 2002:a05:600c:2190:: with SMTP id e16mr2184304wme.42.1584694115217;
        Fri, 20 Mar 2020 01:48:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f12sm6929143wmh.4.2020.03.20.01.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 01:48:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 41F0D180371; Fri, 20 Mar 2020 09:48:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <8bfc64a1-f673-51d3-6721-7e8596e6295f@fb.com>
References: <158462359206.164779.15902346296781033076.stgit@toke.dk> <158462359315.164779.13931660750493121404.stgit@toke.dk> <8bfc64a1-f673-51d3-6721-7e8596e6295f@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 20 Mar 2020 09:48:34 +0100
Message-ID: <8736a376ot.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 3/19/20 6:13 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> While it is currently possible for userspace to specify that an existing
>> XDP program should not be replaced when attaching to an interface, there=
 is
>> no mechanism to safely replace a specific XDP program with another.
>>=20
>> This patch adds a new netlink attribute, IFLA_XDP_EXPECTED_FD, which can=
 be
>> set along with IFLA_XDP_FD. If set, the kernel will check that the progr=
am
>> currently loaded on the interface matches the expected one, and fail the
>> operation if it does not. This corresponds to a 'cmpxchg' memory operati=
on.
>
> The patch set itself looks good to me. But previously there is a
> discussion regarding a potential similar functionality through bpf_link.
> I guess maintainers (Alexei and Daniel) need to weigh in as some
> future vision is involved.

Right, sure. See my reply to Jakub for why I went ahead with this
anyway.

-Toke

