Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152AC46F75
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2019 12:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfFOKKE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 15 Jun 2019 06:10:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35513 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfFOKKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Jun 2019 06:10:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so7455491edr.2
        for <bpf@vger.kernel.org>; Sat, 15 Jun 2019 03:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=E5g/m2oNw0FmOnRwBHRfp/fjjyfTq1G4GJO9NWyBiak=;
        b=sHUe8kJGlHFkK8pl0xt7mBgSRTv5nzVnqxMcxvuzgMDHPP0Ze3QmfqQqgibBNyOjqx
         30i5OcXYIXn7Bev3VKDYNq98vwKxbgzpAGH4CxVVlotq0+Hx0RcoKG0RXftW0Aw24K7T
         MlGrmDRowqzDyjX0EyurVQebJWFcViYu7w9plpZhMCeMICcRS3NRKxbZ7GRvBr2SVZEj
         kNUDSGBF4PByfC98sTnbIJFZBej+CYf9I8JcfLpAbEGkzJQhjvwoUZRHvUjnUA694UD9
         zpHIVE7mESJ2GSplWOnGwDYJPSlUTx9wXVxpJS8uFP8vHUBtU4q83OAGnmoVx1dbZVpn
         AidA==
X-Gm-Message-State: APjAAAVSaDpIi0oX8rcqHMyotJKj27X7XVn9pif2KiTAknxcaPWE/EjI
        /rb4cgTww6oTHMB217KDrFrYLQ==
X-Google-Smtp-Source: APXvYqzCPAU0G5SPBb3xNUalstBRFbSLtXj+BEgB2SaVj0rv4Pog5MGdF0GDUelBpwAAa2JHfqQ8Qg==
X-Received: by 2002:a50:8974:: with SMTP id f49mr52230644edf.95.1560593402393;
        Sat, 15 Jun 2019 03:10:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id k51sm1753562edb.7.2019.06.15.03.10.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:10:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 013981804AF; Sat, 15 Jun 2019 12:10:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     netdev@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH bpf 1/3] devmap: Fix premature entry free on destroying map
In-Reply-To: <5f6efec8-87f8-4ac5-46ee-47788dbf1d44@iogearbox.net>
References: <20190614082015.23336-1-toshiaki.makita1@gmail.com> <20190614082015.23336-2-toshiaki.makita1@gmail.com> <877e9octre.fsf@toke.dk> <87sgscbc5d.fsf@toke.dk> <fb895684-c863-e580-f36a-30722c480b41@gmail.com> <87muikb9ev.fsf@toke.dk> <5f6efec8-87f8-4ac5-46ee-47788dbf1d44@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 15 Jun 2019 12:10:00 +0200
Message-ID: <87r27v9n2f.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 06/14/2019 03:09 PM, Toke Høiland-Jørgensen wrote:
>> Toshiaki Makita <toshiaki.makita1@gmail.com> writes:
> [...]
>>>> Alternatively, since this entire series should probably go to stable, I
>>>> can respin mine on top of it?
>>>
>>> Indeed conflict will happen, as this is for 'bpf' not 'bpf-next'.
>>> Sorry for disturbing your work.
>> 
>> Oh, no worries!
>> 
>>> I'm also not sure how to proceed in this case.
>> 
>> I guess we'll leave that up to the maintainers :)
>
> So all three look good to me, I've applied them to bpf tree. Fixes to
> bpf do have precedence over patches to bpf-next given they need to
> land in the current release. I'll get bpf out later tonight and ask
> David to merge net into net-next after that since rebase is also
> needed for Stanislav's cgroup series. We'll then flush out bpf-next so
> we can fast-fwd to net-next to pull in all the dependencies.

Right, I'll wait for that, then rebase my series and resubmit

-Toke
