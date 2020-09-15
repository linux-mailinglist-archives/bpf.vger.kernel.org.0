Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BCE26A140
	for <lists+bpf@lfdr.de>; Tue, 15 Sep 2020 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgIOIry (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 04:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIOIrs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Sep 2020 04:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600159667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gHqMMhcef71Vz4nIIhCc753F8Sj6cnpzNuOswe+NHDE=;
        b=ijHgiMEaxio/304CLIQhvh2Jf5vOeQS4Ld6QHsH+1Uq4JGaH+AHrlQrUo+KXwKV4RxYJgg
        fhPBThaKH/4cFMWYU0xbYmVAY3cJdCYT3IrrUcmh8iCImvlebpogkACqQljK8CbdugqWH5
        5sRZAiSjHukeA7Nb13dBuwjlCOE5CE4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-bXR2-nRbOGeFjejPhJE9TQ-1; Tue, 15 Sep 2020 04:47:39 -0400
X-MC-Unique: bXR2-nRbOGeFjejPhJE9TQ-1
Received: by mail-wm1-f70.google.com with SMTP id y18so916910wma.4
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 01:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gHqMMhcef71Vz4nIIhCc753F8Sj6cnpzNuOswe+NHDE=;
        b=Yb9duxS0aeiWWZQD+wArQDpwOklcWFPK9DWA4DnBR92SCQGmCoWDLtoLZI/1i331iR
         ESGPw5GBY0qVyxewaHkJc/Xxy8uClzHVGabTQUrFTulbVz/7Uk8g4GlP0blqdk+V1dmt
         +flFG+/tcIhUvrMUrhasXeaA7oGK8rf6gtdiyfyJ3mb+n3ogafkbgpYzTtOqTyj7f4et
         uJfvTcHq8pVLBKJZDlo5oo0dxfD+Pwc4QTQoyi+rJfbhgFjemLx2CNCTIpmtWYohmq6E
         vrd2hZ2zV0zlIu22IqLT9/3HHGdVodT7SIOJdTfhOBx8Z7vU/sfpoK+om4zZ0So0De5J
         Ndww==
X-Gm-Message-State: AOAM5313pcLrgwAEl8w/uHzkabSpGZBmA03HHYSFWCKy89KgpEPOLS77
        1UL6TW0en/eCoHwOPE9NEb0ydtDKLvrcF4LGKMJ7T3Vcuvcx1Qq+qpe+ktnoKPbpN3AUCnRZxHO
        AxG8JdrQDD1x3
X-Received: by 2002:adf:e407:: with SMTP id g7mr20040882wrm.349.1600159657884;
        Tue, 15 Sep 2020 01:47:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbWanePA3VlARamVJW+Nyg1rmLNkw3TQwnaiY4YIqTex+hDI5pSlEWKYWWhGWrf9aw3oq7Gg==
X-Received: by 2002:adf:e407:: with SMTP id g7mr20040856wrm.349.1600159657574;
        Tue, 15 Sep 2020 01:47:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u66sm23666792wmg.44.2020.09.15.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 01:47:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 68E401829CB; Tue, 15 Sep 2020 10:47:36 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux NetDev <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: don't check against device MTU in
 __bpf_skb_max_len
In-Reply-To: <CANP3RGftg2-_tBc=hGGzxjGZUq9b1amb=TiKRVHSBEyXq-A5QA@mail.gmail.com>
References: <159921182827.1260200.9699352760916903781.stgit@firesoul>
 <20200904163947.20839d7e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200907160757.1f249256@carbon>
 <CANP3RGfjUOoVH152VHLXL3y7mBsF+sUCqEZgGAMdeb9_r_Z-Bw@mail.gmail.com>
 <20200914160538.2bd51893@carbon>
 <CANP3RGftg2-_tBc=hGGzxjGZUq9b1amb=TiKRVHSBEyXq-A5QA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 15 Sep 2020 10:47:36 +0200
Message-ID: <87ft7jzas7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ just jumping in to answer this bit: ]

> Would you happen to know what ebpf startup overhead is?
> How big a problem is having two (or more) back to back tc programs
> instead of one?

With a jit'ed BPF program and the in-kernel dispatcher code (which
avoids indirect calls), it's quite close to a native function call.

> We're running into both verifier performance scaling problems and code
> ownership issues with large programs...
>
> [btw. I understand for XDP we could only use 1 program anyway...]

Working on that! See my talk at LPC:
https://linuxplumbersconf.org/event/7/contributions/671/

Will post a follow-up to the list once the freplace multi-attach series
lands.

-Toke

