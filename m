Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9384D19CC53
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 23:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbgDBVXV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 17:23:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38458 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390127AbgDBVXU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 17:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585862599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVG1s12+16EEZJ0q7BaqOZsQVAZZgTsCxHanP+oPFyI=;
        b=QBAfcqRwC1aZ46JBA7N2T/oyEEyO0OavZexHD7OC7izJhp0DYnIc2+D3bm17R2I8mrjjCF
        QU6ZsUwby/RYj5DF7iWr1189rpEIbFcYQ4PcfLUufrngxcmeZ2b4LX0CkbbboDEdnTD13g
        o/EeJLd4hGpnpFa303VURNpKZzKuSa0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-abN8JmvYPFObmVUW3JpqUQ-1; Thu, 02 Apr 2020 17:23:17 -0400
X-MC-Unique: abN8JmvYPFObmVUW3JpqUQ-1
Received: by mail-lf1-f70.google.com with SMTP id y19so1222623lfk.13
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 14:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vVG1s12+16EEZJ0q7BaqOZsQVAZZgTsCxHanP+oPFyI=;
        b=YvHskp57C1xKPe3oCUapur7OkYajPoPbXavPtMVMULo4OWHpXkSq3UJQwiHLhELZNG
         OfUjYIYUB8x+uRRLbjQUA6Ofoq43ta9JjUz7Vs9agvIJ42P6AN8QFA7TDhoF49S99Q2W
         P7w+7AzTtK1D319k1+U/udCTgg28HFJZydaefWuVf3lO5aE1Kw0wokn8pzXIpxuhbHJH
         +M7axrIpmXiDc4EULSVzyaLvF3T/Y2Y8+uVqwExgXhLTdT2nwEyX0S+u4cWSCzFvZE/d
         Cohq7uiDgxzbZn3rpvX1Ee/02lLo+T0JnnSe73Rd5dEOFe5R0aYFUAiWPXGCM/5JMkJZ
         B9PQ==
X-Gm-Message-State: AGi0PuYX7EKyDr1Vz/TOlKJU3cC23jbxSdjCFYsffIUE/B2r80Fi6Sat
        2uRsQJcY3pRbFi5EeokBw/Wnds9MQlykm6zrXot1FgnWdsbg4r92eb9KGvkCJ5SCzx6OHkLDJG5
        L11tXpSY8fh0O
X-Received: by 2002:a19:c895:: with SMTP id y143mr2790153lff.123.1585862595783;
        Thu, 02 Apr 2020 14:23:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypLn1tnu9OzY33qbyfuFBasj576WXdfE9HkucC6zxIig+X5+tP/eMvy+99N9Gt6T4IWUB4MMQA==
X-Received: by 2002:a19:c895:: with SMTP id y143mr2790145lff.123.1585862595545;
        Thu, 02 Apr 2020 14:23:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z23sm3818586ljz.52.2020.04.02.14.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 14:23:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BB2E418158C; Thu,  2 Apr 2020 23:23:12 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: bpf: ability to attach freplace to multiple parents
In-Reply-To: <20200402202156.hq7wpz5vdoajpqp5@ast-mbp>
References: <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com> <87h7ye3mf3.fsf@toke.dk> <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com> <87tv2e10ly.fsf@toke.dk> <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com> <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com> <CACAyw9-FrwgBGjGT1CYrKJuyRJtwn0XUsifF_uR6LpRbcucN+A@mail.gmail.com> <20200326195340.dznktutm6yq763af@ast-mbp> <87o8sim4rw.fsf@toke.dk> <20200402202156.hq7wpz5vdoajpqp5@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 02 Apr 2020 23:23:12 +0200
Message-ID: <87o8s9eg5b.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Mar 27, 2020 at 12:11:15PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>>=20
>> Current code is in [0], for those following along. There are two bits of
>> kernel support missing before I can get it to where I want it for an
>> initial "release": Atomic replace of the dispatcher (this series), and
>> the ability to attach an freplace program to more than one "parent".
>> I'll try to get an RFC out for the latter during the merge window, but
>> I'll probably need some help in figuring out how to make it safe from
>> the verifier PoV.
>
> I have some thoughts on the second part "ability to attach an freplace
> to more than one 'parent'".
> I think the solution should be more generic than just freplace.
> fentry/fexit need to have the same feature.
> Few folks already said that they want to attach fentry to multiple
> kernel functions. It's similar to what people do with kprobe progs now.
> (attach to multiple and differentiate attach point based on parent IP)
> Similarly "bpftool profile" needs it to avoid creating new pair of fentry=
/fexit
> progs for every target bpf prog it's collecting stats about.
> I didn't add this ability to fentry/fexit/freplace only to simplify
> initial implementation ;) I think the time had come.

Yup, I agree that it makes sense to do the same for fentry/fexit.

> Currently fentry/fexit/freplace progs have single prog->aux->linked_prog =
pointer.
> It just needs to become a linked list.
> The api extension could be like this:
> bpf_raw_tp_open(prog_fd, attach_prog_fd, attach_btf_id);
> (currently it's just bpf_raw_tp_open(prog_fd))
> The same pair of (attach_prog_fd, attach_btf_id) is already passed into p=
rog_load
> to hold the linked_prog and its corresponding btf_id.
> I'm proposing to extend raw_tp_open with this pair as well to
> attach existing fentry/fexit/freplace prog to another target.
> Internally the kernel verify that btf of current linked_prog
> exactly matches to btf of another requested linked_prog and
> if they match it will attach the same prog to two target programs (in cas=
e of freplace)
> or two kernel functions (in case of fentry/fexit).

API-wise this was exactly what I had in mind as well.

> Toke, Andrey,
> if above kinda makes sense from high level description
> I can prototype it quickly and then we can discuss details
> in the patches ?
> Or we can drill further into details and discuss corner cases.

I have one detail to discuss: What would the bpf_raw_tp_open() call
return on the second attachment? A second reference to the same bpf_link
fd as the initial attachment, or a different link?

For the dispatcher use case, the former would make sense: If the
bpf_link is returned to the application as a canonical reference to its
program's attachment, it should persist even when the dispatcher program
itself is replaced from underneath it. But I'm not sure if the same is
true for all such secondary attachments?

-Toke

