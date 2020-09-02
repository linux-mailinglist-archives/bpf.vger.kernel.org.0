Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA3025B5EB
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 23:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgIBVdO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 17:33:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46983 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726226AbgIBVdL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Sep 2020 17:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599082390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H368D3ZjVszsjbdmoLuZGFudZhOJwJboSRtKlrtcivk=;
        b=FxDpm4Y+N4QTcA/vXbvoAHzwNGX/51LZ9FXWey007J7zgMgo3WmF6bgJUXS24OO4CMSOe0
        wXudWg6hcacBTGjkKSL5NNP40ziRnFC1f/bFtPNTZlDHb54xL+xjiOU3TBi2lFqJ89zvCf
        jjeIv0hCR8MUj15lEvPk7CfFZmeAKlg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-RF3zZ9UWM4-r51oRQkaw8w-1; Wed, 02 Sep 2020 17:33:08 -0400
X-MC-Unique: RF3zZ9UWM4-r51oRQkaw8w-1
Received: by mail-wr1-f70.google.com with SMTP id 3so211446wrm.4
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 14:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=H368D3ZjVszsjbdmoLuZGFudZhOJwJboSRtKlrtcivk=;
        b=lbWcaA1oizuiJVRlR6TL52/8jduC7AnRi3ghXj9CprXfQ36orcJAdCClH9FeSVmGVd
         9Wo/FUj6SGjfW0W0yHXz2XnhHaIHH66CgdBMA9JL0MLjof6f2n3N4UGH/y+dvG3xOGQ+
         4vJiGqhxGLCNH9vziR8RcgNi21h1u1CKbWbZCb13hdsycn5BYGF+p0aoI/HfrmnNBWWq
         xlhCSw57wM0L+IgMQ2vbYrCaGd3RKRWMnZJJcccRhh8TM5OaG0afZTEtfOyozs0LWlam
         8znwu1yJ32xa+N3Tr+jrd7uFcEygMdawz9ErIx5hUrVPWxeCTkSTvEtNggPMkMm714SE
         VuzA==
X-Gm-Message-State: AOAM530ISTMN9/elb22tFrHSh+XUk2ixn8IYLmvrfWg3QwLd5BvoJnLN
        Z6qL0shdZAFAw9lWcQbecmNYrj8dWcqTTUAY7/fqilsfBWZfxlzlx0OxPzFs7eaEZTsqDqW8yGe
        Bb4Xc4LPDm96p
X-Received: by 2002:adf:fed1:: with SMTP id q17mr150048wrs.85.1599082387242;
        Wed, 02 Sep 2020 14:33:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqjl/bk2vtNzUV5BZ+vtYlr0do4LkWozLBdXJxVrkZrd+zoFCCub4riumE9gvW2BKew1UZ3g==
X-Received: by 2002:adf:fed1:: with SMTP id q17mr150031wrs.85.1599082386990;
        Wed, 02 Sep 2020 14:33:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l126sm1217435wmf.39.2020.09.02.14.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 14:33:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 03798182009; Wed,  2 Sep 2020 23:33:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        YiFei Zhu <zhuyifei1999@gmail.com>, andriin@fb.com
Subject: Re: [PATCH bpf-next v3 4/8] libbpf: implement bpf_prog_find_metadata
In-Reply-To: <20200902210838.7a26mfi54dufou5a@ast-mbp.dhcp.thefacebook.com>
References: <20200828193603.335512-1-sdf@google.com>
 <20200828193603.335512-5-sdf@google.com> <874koma34d.fsf@toke.dk>
 <20200831154001.GC48607@google.com>
 <20200901225841.qpsugarocx523dmy@ast-mbp.dhcp.thefacebook.com>
 <874kogike9.fsf@toke.dk>
 <20200902210838.7a26mfi54dufou5a@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 02 Sep 2020 23:33:05 +0200
Message-ID: <87mu27hnji.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Sep 02, 2020 at 11:43:26AM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> >
>> > I don't feel great about this libbpf api. bpftool already does
>> > bpf_obj_get_info_by_fd() for progs and for maps.
>> > This extra step and extra set of syscalls is redundant work.
>> > I think it's better to be done as part of bpftool.
>> > It doesn't quite fit as generic api.
>>=20
>> Why not?=20
>
> It's a helper function on top of already provided api and implemented
> in the most brute force and inefficient way.
> bpftool implementation of the same will be more efficient.

Right, certainly wouldn't mind something more efficient. But to me, the
inefficiency is outweighed by convenience of having this canonical
reference for 'this is the metadata map'.

>> so. If we don't have it, people will have to go look at bpftool code,
>> and we'll end up with copied code snippets, which seems less than ideal.
>
> I'd like to see the real use case first before hypothesising.

For me, that would be incorporating support for this into
libxdp/xdp-tools; which was the reason I asked for this to be split into
a separate API in the first place. But okay, not going to keep arguing
about this, I can copy-paste code as well as the next person.

-Toke

