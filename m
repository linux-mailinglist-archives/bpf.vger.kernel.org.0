Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0DB3A3264
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJRoG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 13:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhFJRoF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 13:44:05 -0400
Received: from mail-qk1-x761.google.com (mail-qk1-x761.google.com [IPv6:2607:f8b0:4864:20::761])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6630AC061574
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 10:41:55 -0700 (PDT)
Received: by mail-qk1-x761.google.com with SMTP id f70so12979132qke.13
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 10:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=R5hQqBIMjZMkI68jqhR/Y4IkTqY12JWoBM7dpNWpZ9U=;
        b=XHPuhVCbg7kh3ep5odn9kNuU8d3jCh/pfsURdAeAjA9vMs/HdnI3jtSCy4NLSufP/1
         IO0hJtFD/ryS5vCT9XldzvqJKB9Y3QwdYWU/NBkXTbXuGprlN0U+hGcJ+L5fMfPhXEen
         TveJ2UbXyEetvHzXBZlpOkOFspyBO1Nfrz6Ibq+Ug0nK6/xuLxwLd0GcjxAV4uPwgtKh
         7F37p6PoSsaabcpdH+Uub4tL2Cyc/7BviELuqbqUTViMr3jkvDxVIN98jHc7cMvpaDcj
         K4xq5cXlEZYvCxLRSBCT98Hn7nAaVt/Dfecr8vofa9On4yrVTrhmxDtuM2TaP86PsSPA
         18Sg==
X-Gm-Message-State: AOAM5319qsRx86zI5BxZFdQ+3kvJGGA9owN8Hoyas2XlIKAJpwTxtjRP
        8pstYzCvxkSVRVizT61rZNx2eGetle8e7ExnkQ5Kxk5YJ1bFtw==
X-Google-Smtp-Source: ABdhPJx8JoYL1E4s9/KP5PEqocY+l0bi9UaUYW7LPJLx+fuKb63NjdC6qmKxuL3J99dGKFIgRZ6Q1/ZVKm6m
X-Received: by 2002:a05:620a:20d6:: with SMTP id f22mr655132qka.117.1623346914594;
        Thu, 10 Jun 2021 10:41:54 -0700 (PDT)
Received: from restore.menlosecurity.com ([34.202.62.170])
        by smtp-relay.gmail.com with ESMTPS id x10sm1474947qkg.6.2021.06.10.10.41.54
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 10:41:54 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02780031cr-re.menlosecurity.com (34.202.62.171)
    by restore.menlosecurity.com (34.202.62.170)
    with SMTP id 24f6de40-ca13-11eb-b2d6-4f7e48d1f4a9;
    Thu, 10 Jun 2021 17:41:54 GMT
Received: from mail-ej1-f69.google.com (209.85.218.69)
    by safemail-prod-02780031cr-re.menlosecurity.com (34.202.62.171)
    with SMTP id 24f6de40-ca13-11eb-b2d6-4f7e48d1f4a9;
    Thu, 10 Jun 2021 17:41:54 GMT
Received: by mail-ej1-f69.google.com with SMTP id n19-20020a1709067253b029043b446e4a03so86651ejk.23
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5hQqBIMjZMkI68jqhR/Y4IkTqY12JWoBM7dpNWpZ9U=;
        b=PcXr9ryPhcnpwgRDEpcAKkF1+SO/f2oyOsZGAQJOVSFHJo8tO4vaQFtYkFCP9MeaOO
         8duWpCVwxxVqoyTUFJJv3yqH4dLxfx2YEsS3AMbQo0WrMEqSZIwe4IVNOIblqHBreKZ1
         g7Q0UWPxMeap31OpzoRaPznyc6o1D1t/KHVmU=
X-Received: by 2002:a17:906:1815:: with SMTP id v21mr733125eje.376.1623346912772;
        Thu, 10 Jun 2021 10:41:52 -0700 (PDT)
X-Received: by 2002:a17:906:1815:: with SMTP id v21mr733113eje.376.1623346912608;
 Thu, 10 Jun 2021 10:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com> <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net> <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
In-Reply-To: <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Thu, 10 Jun 2021 10:41:41 -0700
Message-ID: <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
Subject: Re: bpf_fib_lookup support for firewall mark
To:     David Ahern <dsahern@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> that's the key point on performance - crossing a cacheline. I do not
> have performance data at hand, but it is a substantial hit. That is why
> the struct is so overloaded (and complicated for a uapi) with the input
> vs output setting.

Makes perfect sense now. Thanks for clarifying David and Daniel.

> Presumably you are parsing the packet to id a flow to find the mark that
> should be used with the FIB lookup. correct?

Let me briefly present my high-level use case here to give more colour.
What I am building is an overlay network based on geneve. I have multiple
sites, each of which is going to be represented by a separate routing table.
The selection of the destination site (routing table) is based on firewall marks
and the original packet is preserved intact, encapsulated in geneve. I have a
TC/eBPF program running on the geneve interface which has to query the
appropriate routing table based on the firewall mark and use the
returned next hop
as the tunnel key in the skb. Also worth mentioning is that those routing tables
contain multiple (default) routes as I use ECMP to balance traffic/provide HA
between sites,

> > That said, given h_vlan_proto/h_vlan_TCI are both output parameters,
> > maybe we could just union the two fields with a __u32 mark extension
> > that we then transfer into the flowi{4,6}?
>
> That is one option.
>
> I would go for a union on sport and/or dport. It is a fair tradeoff to
> request users to pick one - policy routing based on L4 ports or fwmark.
> A bit harder to do with a straight up union at this point, but we could
> also limit the supported fwmark to 16-bits. Hard choices have to be made.

A couple of comments on those two options: if the union is between the ports
and the mark then a user of the function would have to choose between
src+dst port or the mark in lookup, correct? If so wouldn't that
result in a loss
of the ability to use multipathing - since the hashing would be static? In my
case that would certainly be another significant drawback.

Having said that, what Daniel suggests looks very interesting to me.
If I understand
it correctly there are 32 bits in h_vlan_proto+h_vlan_TCI that are used only for
output today so if they are merged in a union with a 32 bit mark then we'd stay
at 64B structure and we can pass a full 32 bit mark.

So something like this?
union {
    /* input */
    __u32 mark;

    /* output */
    __be16 h_vlan_proto;
    __be16 h_vlan_TCI;
}

Moreover, there are 12 extra bytes used only as output for the smac/dmac.
If the above works then maybe this opens up the opportunity to incorporate
even more input parameters that way?

Thank you once again for your time and suggestions.

Regards,
Rumen Telbizov
