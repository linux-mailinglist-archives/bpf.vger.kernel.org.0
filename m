Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4902CEB32
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 10:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgLDJlN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 04:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727430AbgLDJlN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 04:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607074786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jjINtwvJCiGdXQ3CnWEPhNnh3LSONttoILNEJIyo78=;
        b=R5vzz/e9wP4WoypX1aHiljo7E7dg2BVuflhwZjJGqFEJ47ZzKxxAvcWP6fOoPNj4qUzHfd
        zfjSckVy+F48XQfTk8wRMEIqbkgqIxzJKixnSXPKZkhNNUaL21sd1bVSbJc6dodDpaT925
        ndR+ZFg1l94plLFBV/ojtq4xBETyV/M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Q5gedV-nPKS2V8L5VJkukg-1; Fri, 04 Dec 2020 04:39:44 -0500
X-MC-Unique: Q5gedV-nPKS2V8L5VJkukg-1
Received: by mail-ej1-f71.google.com with SMTP id f2so1859691ejx.22
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 01:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0jjINtwvJCiGdXQ3CnWEPhNnh3LSONttoILNEJIyo78=;
        b=NASEyX8HbAOqI9jF+Z1HS7mFdvaYDLeu2OX7Fevhvyg8sOMFMxDBzJjnF5T0er+tVK
         uA+i6/3RB5p9SiHiKbUy4ZJzGk+U4bUCtQMo8o3Y5fYj8M5NcxLthNptNfknwgq5OFio
         xx60YpE6AFmC4sm1vQp+JvgGcZJnfpGaWZtRSNvXEKdBzuJ4YaPtz7DaKgslO1RhrW3w
         87JpehmyjWy6Pe6rhb8QAnf3xs0UCNChicX5vhfZYhLozCeKK9GWSFsS71Z/1aVTZavh
         yIbUS7/OyVFdYNGWdAl0dCTMvl9naEZEF7trGmFlI6UqRYkDN3K5K6A1q4EjiNX+3Ho6
         0GTQ==
X-Gm-Message-State: AOAM531qZO6WSSW0z7UnCwBdfbJWaTbn0rW1oEXidT+JTn401cLgs0eb
        ls/weVvFSOEC9HQu/iqcfagn4mEvGMjtjTtfQ9Gw9n59sPCGqZ+E0Q4ic1l5jESka6PSkEUD5ey
        lp089rdvN8WE+
X-Received: by 2002:a50:bec4:: with SMTP id e4mr6735679edk.65.1607074783653;
        Fri, 04 Dec 2020 01:39:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5IofxI5GxincoDqkd8oJ6iR7fUjDjNYLGczOvN1YbjkTCAYvTsz2dQOkDmTW8+SVmWvjfew==
X-Received: by 2002:a50:bec4:: with SMTP id e4mr6735661edk.65.1607074783460;
        Fri, 04 Dec 2020 01:39:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q26sm2752395ejt.73.2020.12.04.01.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:39:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 95150182EEA; Fri,  4 Dec 2020 10:39:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jiri Benc <jbenc@redhat.com>, oss-drivers@netronome.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf 3/7] netdevsim: Add debugfs toggle to reject BPF
 programs in verifier
In-Reply-To: <20201203174417.46255de5@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <160703131710.162669.9632344967082582016.stgit@toke.dk>
 <160703132036.162669.7719186299991611592.stgit@toke.dk>
 <20201203174417.46255de5@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Dec 2020 10:39:42 +0100
Message-ID: <87lfed9ag1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 03 Dec 2020 22:35:20 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/n=
etdevsim.h
>> index 827fc80f50a0..d1d329af3e61 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -190,6 +190,7 @@ struct nsim_dev {
>>  	struct bpf_offload_dev *bpf_dev;
>>  	bool bpf_bind_accept;
>>  	u32 bpf_bind_verifier_delay;
>> +	bool bpf_bind_verifier_accept;
>>  	struct dentry *ddir_bpf_bound_progs;
>
> nit: if you respin please reorder the bpf_bind_verifier_* fields so
> that the structure packs better.

Ah, good point, will do!

> Acked-by: Jakub Kicinski <kuba@kernel.org>
>
> Thanks for fixing this test!

You're welcome :)

I'll see if I can't get our CI people to also run it regularly so we can
avoid it regressing again...

-Toke

