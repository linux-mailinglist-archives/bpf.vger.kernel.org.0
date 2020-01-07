Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FBD13278B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2020 14:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgAGN1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jan 2020 08:27:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60654 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727559AbgAGN1r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Jan 2020 08:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578403665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMfocC79KEEX1M+QAjVMMUyocf9wSjOM37B8czKfGfU=;
        b=ARu+z3urT5CT1tnzAex3P8/zUY3vUhAsjhAZrTYgm1itIqKku2mZkZEQqh9Kfvovqnf0yG
        6ZY9FxeGp1is6d8ecr+dgQdm3f9sH4yV6H8BLe/fpd18jGtS5Mgrpb6wKB7g506i1JggXH
        71gvrfeGxPNTSqqHu6OUNrwoP3ffrNQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-oppjhcPyPKWY8hjtPsXLfQ-1; Tue, 07 Jan 2020 08:27:43 -0500
X-MC-Unique: oppjhcPyPKWY8hjtPsXLfQ-1
Received: by mail-wm1-f72.google.com with SMTP id h130so4102391wme.7
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2020 05:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rMfocC79KEEX1M+QAjVMMUyocf9wSjOM37B8czKfGfU=;
        b=APP1EemdJ6D2Grf+dPUCDtcghWmzqwQmzb8Bs6JfES74YmC+l1kILx3nxAjLOJtx0U
         VkZGa2dDmvMz/+j8DjNQ4wQMO/7ruLu8SsKz2ISNAd0VFqO1IrvlHJq5+BTWZ9/rbrKW
         uJbpmfLS3peyKYeqjjJ2TmS8fig3vNSQrOqJiECpWqRyU9bg5p87BVWuOYOCR/MDo7eV
         v4djf3aphacwZVGKPwzL50cRurm/+UAOM3cnFWCw3yKs4vM0QzqOq6YDX9fppiN7g1BZ
         QhymF5BoesX+Nelbvqnau3yJ/KPIA1f2DHamyN/g2V8fWuNAQPRsifBXRIuoaQNqt2QK
         8d6A==
X-Gm-Message-State: APjAAAUukojyb926U8nQQdnuxmH6vBtp1+jrvxeMJpEyhk769fwo1vEZ
        dA1rSsH5F38mUkbuP74dbU38KycAr4nlu2rQgW+GQMZO/2hV+jz9gWULFPMzi5kwLMGqRhG478C
        KJbcsCwqw5JHo
X-Received: by 2002:adf:df0e:: with SMTP id y14mr41745963wrl.377.1578403662705;
        Tue, 07 Jan 2020 05:27:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUXaHz6hx2/7xO//JHMw8mPcHq9qVdsCJpaSZeLyVlrM5Rsv9kmTnJNT2coB/nD3fr5/7AnA==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr41745935wrl.377.1578403662501;
        Tue, 07 Jan 2020 05:27:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g21sm82342017wrb.48.2020.01.07.05.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:27:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 206FA180960; Tue,  7 Jan 2020 14:27:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Karlsson\, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>, brouer@redhat.com
Subject: Re: [PATCH bpf-next v2 0/8] Simplify xdp_do_redirect_map()/xdp_do_flush_map() and XDP maps
In-Reply-To: <20200107140544.6b860e28@carbon>
References: <20191219061006.21980-1-bjorn.topel@gmail.com> <CAADnVQL1x8AJmCOjesA_6Z3XprFVEdWgbREfpn3CC-XO8k4PDA@mail.gmail.com> <20191220084651.6dacb941@carbon> <20191220102615.45fe022d@carbon> <87mubn2st4.fsf@toke.dk> <CAJ+HfNhLDi1MJAughKFCVUjSvdOfPUcbvO9=RXmXQBS6Q3mv3w@mail.gmail.com> <87zhezik3o.fsf@toke.dk> <20200107140544.6b860e28@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 Jan 2020 14:27:41 +0100
Message-ID: <87r20biegi.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Tue, 07 Jan 2020 12:25:47 +0100
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>
>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>=20
>> > On Fri, 20 Dec 2019 at 11:30, Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:=20=20
>> >>
>> >> Jesper Dangaard Brouer <brouer@redhat.com> writes:
>> >>=20=20
>> > [...]=20=20
>> >> > I have now went over the entire patchset, and everything look perfe=
ct,
>> >> > I will go as far as saying it is brilliant.  We previously had the
>> >> > issue, that using different redirect maps in a BPF-prog would cause=
 the
>> >> > bulking effect to be reduced, as map_to_flush cause previous map to=
 get
>> >> > flushed. This is now solved :-)=20=20
>> >>
>> >> Another thing that occurred to me while thinking about this: Now that=
 we
>> >> have a single flush list, is there any reason we couldn't move the
>> >> devmap xdp_bulk_queue into struct net_device? That way it could also =
be
>> >> used for the non-map variant of bpf_redirect()?
>> >>=20=20
>> >
>> > Indeed! (At least I don't see any blockers...)=20=20
>>=20
>> Cool, that's what I thought. Maybe I'll give that a shot, then, unless
>> you beat me to it ;)
>=20=20
> Generally sounds like a good idea.
>
> It this only for devmap xdp_bulk_queue?

Non-map redirect only supports redirecting across interfaces (the
parameter is an ifindex), so yeah, this would be just for that.

> Some gotchas off the top of my head.
>
> The cpumap also have a struct xdp_bulk_queue, which have a different
> layout. (sidenote: due to BTF we likely want rename that).
>
> If you want to generalize this across all redirect maps type. You
> should know, that it was on purpose that I designed the bulking to be
> map specific, because that allowed each map to control its own optimal
> bulking.  E.g. devmap does 16 frames bulking, cpumap does 8 frames (as
> it matches sending 1 cacheline into underlying ptr_ring), xskmap does
> 64 AFAIK (which could hurt-latency, but that is another discussion).

Bj=C3=B6rn's patches do leave the per-type behaviour, they just get rid of
the per-map flush queues... :)

-Toke

