Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A806A19560D
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0LLW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 07:11:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42548 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgC0LLW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Mar 2020 07:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585307482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qqiOcFCD3/rFVzbufpuYaK5OO8+xWz6BEOItVPyTmOM=;
        b=TlnwuMBxhJh3EEp8NA32bPYMdFctRMmJCYuzMoBwLDlt6kZjMmBaWDLpvVz7DJfsRn7Whs
        K0Z2JwPVaGapKscv6B1/SqCpbThbxZZxJmiJtFYL1nlyXYWbZUwkvckKXL8qaVY9p3GXVN
        PgjnahIebF5zvyatiRh+fNvFalQAHeQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-oNFMyjtpP9GRLgn7TYkQ-A-1; Fri, 27 Mar 2020 07:11:19 -0400
X-MC-Unique: oNFMyjtpP9GRLgn7TYkQ-A-1
Received: by mail-lf1-f69.google.com with SMTP id l3so3399038lfe.22
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 04:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qqiOcFCD3/rFVzbufpuYaK5OO8+xWz6BEOItVPyTmOM=;
        b=fV3qWnQLcwTqYOKBsO09X3OpHDJSlKS6TPr60P06EaKZtBYYV7z+4P/VvFQH74A+qv
         AjVUbMrqsGZBziCD+9r3Ei1tBUoaiwB8450i34Q3lpP45zW5T2shqgHH5cONjOrRrAet
         WU+ZsM7a66qiyKkaK94PtNzu0jTbGFK1b5WhHY82zZwDmoQXPragfUTe4hozIDDs4ahH
         NxDDEXvCn5IKGdj1X7wHK/02aU52ZO3Ele+ZffONowEX/oR5T4uLx3JgpS4VmGqljnKY
         DvbmfECH4KncPlRNzw+0yvmo2PVvRbWrhA4lDd5E6T7irypUqvZhdssCgbE4fasqzu9v
         uXWQ==
X-Gm-Message-State: AGi0PuaqvX/0CiAf2B5RxsQH16GtPoEo8aE/XYyB/3j/w6CVlIFgtfW4
        b+Hk9/DBvvMNVBIX/x3arTAhvOyYSjrjFNvKVUUjRAdttFuiFS4AYmYmJIt3FL1ndMN5Mqv7NpR
        CgXwKm93zBFxV
X-Received: by 2002:a2e:9852:: with SMTP id e18mr7978995ljj.249.1585307477567;
        Fri, 27 Mar 2020 04:11:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ+k1pjLeXZQGccUP/uckxHVHP+fyP4qa8BGa4ZZb/VsFDT0iiFsMmNcrv/chbbOIqVyVo5Iw==
X-Received: by 2002:a2e:9852:: with SMTP id e18mr7978982ljj.249.1585307477351;
        Fri, 27 Mar 2020 04:11:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id o68sm3203372lff.81.2020.03.27.04.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 04:11:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 57ABC18158B; Fri, 27 Mar 2020 12:11:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
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
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <20200326195340.dznktutm6yq763af@ast-mbp>
References: <CAEf4BzbWa8vdyLuzr_nxFM3BtT+hhzjCe9UQF8Y5cN+sVqa72g@mail.gmail.com> <87tv2f48lp.fsf@toke.dk> <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com> <87h7ye3mf3.fsf@toke.dk> <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com> <87tv2e10ly.fsf@toke.dk> <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com> <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com> <CACAyw9-FrwgBGjGT1CYrKJuyRJtwn0XUsifF_uR6LpRbcucN+A@mail.gmail.com> <20200326195340.dznktutm6yq763af@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Mar 2020 12:11:15 +0100
Message-ID: <87o8sim4rw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> libxdp (and now renamed to libdispatcher, right Toke?)

Not yet :)

I want to get it to initial feature completeness for XDP first, then
think about generalising the dispatcher bits (which has additional
issues, such as figuring out how to manage the dispatcher programs for
different program types).

Current code is in [0], for those following along. There are two bits of
kernel support missing before I can get it to where I want it for an
initial "release": Atomic replace of the dispatcher (this series), and
the ability to attach an freplace program to more than one "parent".
I'll try to get an RFC out for the latter during the merge window, but
I'll probably need some help in figuring out how to make it safe from
the verifier PoV.

-Toke


[0] https://github.com/xdp-project/xdp-tools/tree/xdp-multi-prog

