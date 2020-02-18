Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C216360D
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 23:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgBRWX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Feb 2020 17:23:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41012 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbgBRWX3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Feb 2020 17:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582064607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzniXuxGG3xuNTREj2X9iqbFXp/dsAkbv0yAly6KfyY=;
        b=Cyrw7i/14fdvbw8jR1eW+sfDAhSU8K9VpmVy/LXOPRbJ88btgYRaBMdVxDEaBuu3KgtgbF
        a/APVnhOjjnibJOOvyd/Z37ARdwnmYtqnDI2di+koQVCqVqhxJQapVj7oxgEwdODwfgbfQ
        lv2ypXdiungGfNvBHcfNITEuE0Csmu0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-4R07EQ4_NjegNphyyNQ5FA-1; Tue, 18 Feb 2020 17:23:25 -0500
X-MC-Unique: 4R07EQ4_NjegNphyyNQ5FA-1
Received: by mail-lf1-f72.google.com with SMTP id v19so2336928lfg.2
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 14:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KzniXuxGG3xuNTREj2X9iqbFXp/dsAkbv0yAly6KfyY=;
        b=kXFUkU/MKQQM1VIpjf4VbELWDdlxCYiRHTvYTWochXbbJJD6eSOgJfXuHmfYxG5atj
         huFvMiJWU/GH7frBTbwt4wbKaO14NNHOP9kfVVTNR20eiaiea3wAei1TFE9oh3eQ3O5b
         FD9Cr3wiZpf5paxvlRKS89HpE+c9i5SYXPrlydHzypYYsvUbIwD2tzg78l7MwisjHX0m
         A/Fons1K6k6cdMGKR+VJEB7olJ9teiZ/Q5wGFjMIt1ssB3yBf9cmEAHO1MRRmvNXJqZC
         LrNb9A6GvUBxLp6uhsFwcSHXxeRL4jXkWl1k6I1wWBvz53jrPcpuAtpd+QUOhb0S0c5O
         7/dA==
X-Gm-Message-State: APjAAAVXOGTFI6L6Y+VR/89HfzgsKpV8mitRI7vaqDa/NoHzjdDlUoUw
        ccS4qNmsJFnwMbCIxMiGMb7WhkK1biXJOUsQT9omsxlH8T+zp1VY83nIBtLlmODB0dVdZojRs/K
        NpXpvaE9ilk/Q
X-Received: by 2002:a2e:888b:: with SMTP id k11mr14325321lji.197.1582064604203;
        Tue, 18 Feb 2020 14:23:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYWLZAyv8CoD8AZ/XywYZzw4bS9wLMvINlzJFDMHl7GteVE53+Up4eF5q8jg0FySo7bFGPNA==
X-Received: by 2002:a2e:888b:: with SMTP id k11mr14325313lji.197.1582064603932;
        Tue, 18 Feb 2020 14:23:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n2sm67763ljj.1.2020.02.18.14.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 14:23:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4FB19180365; Tue, 18 Feb 2020 23:23:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     netdev@vger.kernel.org, ilias.apalodimas@linaro.org,
        davem@davemloft.net, lorenzo.bianconi@redhat.com, andrew@lunn.ch,
        brouer@redhat.com, dsahern@kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC net-next] net: mvneta: align xdp stats naming scheme to mlx5 driver
In-Reply-To: <20200218132921.46df7f8b@kicinski-fedora-PC1C0HJN>
References: <526238d9bcc60500ed61da1a4af8b65af1af9583.1581984697.git.lorenzo@kernel.org> <20200218132921.46df7f8b@kicinski-fedora-PC1C0HJN>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 18 Feb 2020 23:23:22 +0100
Message-ID: <87eeury1ph.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 18 Feb 2020 01:14:29 +0100 Lorenzo Bianconi wrote:
>> Introduce "rx" prefix in the name scheme for xdp counters
>> on rx path.
>> Differentiate between XDP_TX and ndo_xdp_xmit counters
>> 
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Sorry for coming in late.
>
> I thought the ability to attach a BPF program to a fexit of another BPF
> program will put an end to these unnecessary statistics. IOW I maintain
> my position that there should be no ethtool stats for XDP.
>
> As discussed before real life BPF progs will maintain their own stats
> at the granularity of their choosing, so we're just wasting datapath
> cycles.
>
> The previous argument that the BPF prog stats are out of admin control
> is no longer true with the fexit option (IIUC how that works).

So you're proposing an admin that wants to keep track of XDP has to
(permantently?) attach an fexit program to every running XDP program and
use that to keep statistics? But presumably he'd first need to discover
that XDP is enabled; which the ethtool stats is a good hint for :)

-Toke

