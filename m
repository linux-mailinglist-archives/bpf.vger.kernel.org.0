Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D801978B4
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 12:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgC3KTZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 06:19:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47986 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729069AbgC3KTZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Mar 2020 06:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585563564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9vx3TGa1czRbhD2gVc641boIWf6QXwts6CeJX/xsgk=;
        b=fxlciVTlhg0z1316zBDrCdexAxzz61NY4HRtMOJxbpNm274v6c1u2cTD9d48dNo2abKNta
        N3Fjmwg4PpakHu8ONO27HrPccK6Nyr/Yxi8GzxSmiQ++XsBwFvtykljQlEclAhhf2nfX2L
        5Bz7mBwOibfrggc5MwBT9opFYhtzG8k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-bZ0omiKpPXmRCnxwJA-_PQ-1; Mon, 30 Mar 2020 06:19:22 -0400
X-MC-Unique: bZ0omiKpPXmRCnxwJA-_PQ-1
Received: by mail-lj1-f200.google.com with SMTP id r18so1377641ljp.13
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 03:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=p9vx3TGa1czRbhD2gVc641boIWf6QXwts6CeJX/xsgk=;
        b=RbCBH0OLts5tZ5fKSb90+BhxUyBrc5hTFYGQ9QbgUNd2iwraUdRTLlpq/35M7dYcK9
         P3OP5fVNOBqv62fVBHHoOv6jzc/NHRjLhGanwCEwdZq32lUDPcSp+ydFaOpBHMNbkGOT
         +D5bsFDGo13mW5d4gd2HSAUoOj/mXqJxH12ejLdDys00npXLcRxI0ZfsPQBWL8AmPbHZ
         GNCoydKgM+EiAwXwTOfqVJFMPamXNSKzIZnQwPlk5AfsPQCCxav6mQCdPjXSfZPztUNZ
         DGgDpyy5tJDjO2C81AVGMRrxmWLEpAzGHDG86LixH5DHzkY0WKGrRjl+qL4xWBX66xKD
         I6gA==
X-Gm-Message-State: AGi0PuZqbhlHknf7KwnnsxirajGB+Y8Tl70MhDoMz5BClQUM9vd5Yq/V
        qOiSnBIodhxIa6kyhK2SHKLuQklj+j3z4m6k44tUeZThwiASlXLuVxaJdiAJhrZDvjDqG+LE4Gx
        +IpjM8BPu9PAv
X-Received: by 2002:a2e:8246:: with SMTP id j6mr6633720ljh.162.1585563560974;
        Mon, 30 Mar 2020 03:19:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypIebnYHjZQesfpOjLMZUMUE4hoFNYgfPZiMPUSAzI9O87KG1d2+xALhoRMbNbd3h0EBeQWmMQ==
X-Received: by 2002:a2e:8246:: with SMTP id j6mr6633706ljh.162.1585563560681;
        Mon, 30 Mar 2020 03:19:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u7sm113lfb.84.2020.03.30.03.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 03:19:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5729218158B; Mon, 30 Mar 2020 12:19:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <20200329192650.w55hcof5ix6tb54s@ast-mbp>
References: <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com> <87pncznvjy.fsf@toke.dk> <20200326195859.u6inotgrm3ubw5bx@ast-mbp> <87imiqm27d.fsf@toke.dk> <20200327230047.ois5esl35s63qorj@ast-mbp> <87lfnll0eh.fsf@toke.dk> <20200328022609.zfupojim7see5cqx@ast-mbp> <87eetcl1e3.fsf@toke.dk> <20200328233546.7ayswtraepw3ia2x@ast-mbp> <87369rla1y.fsf@toke.dk> <20200329192650.w55hcof5ix6tb54s@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 30 Mar 2020 12:19:18 +0200
Message-ID: <87r1xajgbd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sun, Mar 29, 2020 at 12:39:21PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>>=20
>> > I guess all that is acceptable behavior to some libxdp users.
>>=20
>> I believe so.
>
> Not for us. Sadly that's where we part ways. we will not be using your
> libxdp.

Up to you of course, but I must say that I'm a bit surprised that you
state this so categorically at this stage. As far as I'm concerned,
there is still plenty of opportunity for cooperation on this, and I'm
still quite willing to accommodate your needs in libxdp.

> Existing xdp api was barely usable in the datacenter environment. replace=
_fd
> makes no difference.
>
>> exclusivity does come in handy. And as I said, I can live with there
>> being two APIs as long as there's a reasonable way to override the
>> bpf_link "lock" :)
>
> I explained many times already that bpf_link for XDP is NOT a second api =
to do
> the same thing. I understand that you think it's a second api, but when y=
ou
> keep repeating 'second api' it makes other folks (who also don't understa=
nd the
> difference) to make wrong conclusions that they can use either to achieve=
 the
> same thing. They cannot. And it makes my job explaining harder. So please=
 drop
> 'second api' narrative.

I understand that they're different. Really, I do. That doesn't change
the fact that there will be two ways to install an XDP program, though.
Which is all I meant by "two APIs"; I was not implying they would be
completely equivalent in all ways.

-Toke

