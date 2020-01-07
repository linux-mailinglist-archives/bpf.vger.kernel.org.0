Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E81324C3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2020 12:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgAGLZx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jan 2020 06:25:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21283 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727787AbgAGLZx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jan 2020 06:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578396351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZbtnM4x0me9hDAVIpjenEUCeTRb6s5y4/BXN+VJl+vU=;
        b=TQiRpzYvkmaylJ4varu6dr/J9DWz2s3h/1g+VMEwVPljuaKXKKlRw1aDsZkpbU0mBi14ZJ
        6Q7KyraUs43KUwkrzFl2QRZFEKcc8tzLnnP8mzNRAR/31BH0sEbIkzxjidAWgHDBjPy+n9
        HZm/7qdFGIi+xRzDA50yf9mZLqzyFEk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-S-WHbwIYPY61JmNYomk72Q-1; Tue, 07 Jan 2020 06:25:50 -0500
X-MC-Unique: S-WHbwIYPY61JmNYomk72Q-1
Received: by mail-wm1-f71.google.com with SMTP id 7so1852633wmf.9
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2020 03:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZbtnM4x0me9hDAVIpjenEUCeTRb6s5y4/BXN+VJl+vU=;
        b=iMfo8iVWG/tU5OX3kOOco7bS3u1mgP/J3vIRSdJmNsHvpLLP9mQBS1/Ensh4vq977Q
         GbM3Xk3EC4TO6fCmIUIfOT7w5M+v6FGqyO2ON71ldpTqZiPxr+jWi4R2Grr/6PkclNNo
         zxnoyLW3h0ptmWyX1niynBwAltDMNxvHbEuk6AlEkf8m6FVY1ecZ0a6gjT9wk0UwqCEh
         Ha9WX/QepauuTbuqlauqDVG10giUpe/qiGeLcrg12wZWz/vlPz1o9rftXiHwLOperk2w
         C8tTA6FvKbo08+SWy7WV3cgdzp8x8WGY6jH0A0ufeqNDGqhlWSNj2YrNN71Em3CW5y/I
         eEEg==
X-Gm-Message-State: APjAAAVPAOF2kwL2MpVjfd69YaxHNKtR2cwGokxzJ3MQc68w3Fj1bb4n
        6cSBdGRs0ALY82gM+4bmMxTKGqMI/XxUzaoikJLpra4SyMP/6BzyuhUhGUSytCqKztwXvQRYvCt
        1L8ZmdZirArv8
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr40701377wmk.68.1578396348782;
        Tue, 07 Jan 2020 03:25:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzTGCIRSmR3eU0JK3ZIYRYUz48eBF3BETcgpexoZLmwRMm8ICeBNHAjXoW+wOYUIvrTzKTrvA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr40701345wmk.68.1578396348621;
        Tue, 07 Jan 2020 03:25:48 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o4sm75692154wrw.97.2020.01.07.03.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 03:25:47 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 84496180960; Tue,  7 Jan 2020 12:25:47 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Karlsson\, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/8] Simplify xdp_do_redirect_map()/xdp_do_flush_map() and XDP maps
In-Reply-To: <CAJ+HfNhLDi1MJAughKFCVUjSvdOfPUcbvO9=RXmXQBS6Q3mv3w@mail.gmail.com>
References: <20191219061006.21980-1-bjorn.topel@gmail.com> <CAADnVQL1x8AJmCOjesA_6Z3XprFVEdWgbREfpn3CC-XO8k4PDA@mail.gmail.com> <20191220084651.6dacb941@carbon> <20191220102615.45fe022d@carbon> <87mubn2st4.fsf@toke.dk> <CAJ+HfNhLDi1MJAughKFCVUjSvdOfPUcbvO9=RXmXQBS6Q3mv3w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 Jan 2020 12:25:47 +0100
Message-ID: <87zhezik3o.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> On Fri, 20 Dec 2019 at 11:30, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>>
>> Jesper Dangaard Brouer <brouer@redhat.com> writes:
>>
> [...]
>> > I have now went over the entire patchset, and everything look perfect,
>> > I will go as far as saying it is brilliant.  We previously had the
>> > issue, that using different redirect maps in a BPF-prog would cause the
>> > bulking effect to be reduced, as map_to_flush cause previous map to get
>> > flushed. This is now solved :-)
>>
>> Another thing that occurred to me while thinking about this: Now that we
>> have a single flush list, is there any reason we couldn't move the
>> devmap xdp_bulk_queue into struct net_device? That way it could also be
>> used for the non-map variant of bpf_redirect()?
>>
>
> Indeed! (At least I don't see any blockers...)

Cool, that's what I thought. Maybe I'll give that a shot, then, unless
you beat me to it ;)

-Toke

