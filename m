Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA1E626F
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2019 13:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfJ0MP1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 27 Oct 2019 08:15:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfJ0MP0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Oct 2019 08:15:26 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 865593DE04
        for <bpf@vger.kernel.org>; Sun, 27 Oct 2019 12:15:26 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id g28so1410306ljl.10
        for <bpf@vger.kernel.org>; Sun, 27 Oct 2019 05:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jrp3HDZF4U7ETNImEv4XdaWW8L0YNGlI70P2aQswsvk=;
        b=DOr3pSByxOWR0uEqoJkmh5gwLkUt6RnnXEV7MPJB5TYVuMtMZz4SZRP1EKCX+fPAkO
         z2y58FPqDTFmdTO4gk2Y1dX91kQTMuI0o3iv4XKwQFgNjiJMmitA/e26uMMVotS4LqvF
         LMwJ3b2KBJkbV1Q9E0UVUlepcNvGYms8F5WgrsLaeqbTTZxoW6NiSdi2f3iYkFtl9Sut
         T35SoJ0UFt5eHKjARsrAtYxdCIUEruLAHvF+7uYZMaai/8qAmJeZon1WDnG5JmbX8Imt
         gIL9Awb4CxijHpQbviwZQYyM0uobusOiIRytebHDtmPJKSNhWUZDoVAPtzn+I5gwX/Nj
         ffBA==
X-Gm-Message-State: APjAAAUenpIjuDtHPZ8C8faL9x5YEJRTQLzbFAgZLo/BxZ3VbOHZjO2K
        t/d8xS0eg90/EJt1/v8yvICj0U1voc0GuQus1HNEU+F7wxVCIEmiSxFSWTewnC8DW6n+Y+M4rdz
        agaaLINj8Kk2F
X-Received: by 2002:a2e:a302:: with SMTP id l2mr8742048lje.190.1572178525131;
        Sun, 27 Oct 2019 05:15:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzvtxIwTRYpVocH++ENF8OywmvPFzHQsDmunuJZ8LRUl4cWTGNO/gMAM+Pi03e7x5mzpsXyog==
X-Received: by 2002:a2e:a302:: with SMTP id l2mr8742043lje.190.1572178524972;
        Sun, 27 Oct 2019 05:15:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id r63sm1618645ljr.10.2019.10.27.05.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 05:15:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 272841818B4; Sun, 27 Oct 2019 13:15:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: bpf indirect calls
In-Reply-To: <CAADnVQKOJZhova8GsUug364+QETPFq1DmGO5-P7YBjyDF99y9Q@mail.gmail.com>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1> <157046883614.2092443.9861796174814370924.stgit@alrua-x1> <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com> <87sgo3lkx9.fsf@toke.dk> <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com> <87o8yqjqg0.fsf@toke.dk> <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com> <87v9srijxa.fsf@toke.dk> <20191016022849.weomgfdtep4aojpm@ast-mbp> <8736fshk7b.fsf@toke.dk> <20191019200939.kiwuaj7c4bg25vqs@ast-mbp> <874l03d6ov.fsf@toke.dk> <CAADnVQKOJZhova8GsUug364+QETPFq1DmGO5-P7YBjyDF99y9Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 27 Oct 2019 13:15:21 +0100
Message-ID: <87lft6jsfa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sun, Oct 20, 2019 at 3:58 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>> Great! I think it's probably more productive for everyone involved if I
>> just wait for you to get around to this, rather than try my own hand at
>> this. I'll go hash out the userspace management semantics of chain calls
>> in the meantime (using my kernel support patch), since that will surely
>> be needed anyway.
>
> No problem. Indirect calls are next on my todo list.
> Shouldn't take long.

Awesome!

> Right now I'm hacking accelerated kretprobes for tracing.
> I've shared first rough draft of patches with few folks and they
> quickly pointed out that the same logic can be used to
> create arbitrary call chains.
> To make kretprobe+bpf fast I'm replacing:
>   call foo
> with
>   prologue
>   capture args
>   call foo
>   capture return
>   call bpf_prog
>   epilogue
> That "call foo" can be anything. Including another bpf prog.
> Patches are too rough for public review.
> I hope to get them cleaned up by the end of next week.
>
> Jesper request to capture both struct xdp_md and return
> value after prog returns will be possible soon.
> xdpdump before and after xdp prog.. here I come :)

Sounds promising! Looking forward to seeing where this is going :)

-Toke
