Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747E0302476
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 12:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbhAYLq7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 06:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727723AbhAYLqe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Jan 2021 06:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611575071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHdkSW7IR3/Ta55fw+aNpZ8wmGr6kIeF4oZRSyYjqFc=;
        b=e3qE8VGL1NcAkRuDzQ3trlWYzkgk1dflnWoazQsYUPAXqK+iI5YS7uY5NqGY0c1JI5ACCi
        RFRwUMrkWOY0jbQxzX878HTX0aeHqor7ICdjTkD5oh6OfadeI0Gl+4bLk2EQr59FTS+mkd
        bYLAx7gwZyV3o9t9WqSa3diZKwo0/N4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-If7eiaK4PRW-K6HjonfEwQ-1; Mon, 25 Jan 2021 06:21:28 -0500
X-MC-Unique: If7eiaK4PRW-K6HjonfEwQ-1
Received: by mail-ed1-f72.google.com with SMTP id u17so7214533edi.18
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 03:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=eHdkSW7IR3/Ta55fw+aNpZ8wmGr6kIeF4oZRSyYjqFc=;
        b=hJHtyeFT6UHhcc1UHBxGnuRj4L8RpRJzO6Rjlm9YtEc25K7vddaJgxpipAP1lPicV/
         lCUix0c2XqOF0aYZkU2vtFp6o2/FPSxqy3jxtMFzgPuJLjdElG3b6hZGN6cZUtxBhtRO
         l856VMwc9vVzs/KF7KU+UcR4YQxw48RlDIMzisbnlpSNyA68QT49f9qZOJaK6aLkAVn9
         eEGS7gaKbe5+v8VOAdnC7+Pwqyp4BgY14y/gbYKkALry6B1B+tpBBpZd4n7G5uHUz5KM
         5OaIBjOYJvwaHh/1Sty74kqrK8XJruVv0oKMZ0fjj4z1lBGJ+xs6YWnHN4MDarfnaF+w
         bsQA==
X-Gm-Message-State: AOAM533pIWmk9Io41dmuoYpsCKYj/yXzpExbEVEsh0WEaO1Xh7J0znYb
        46CPqCTkiLVS7/dmdPhmqwFxtYCDvUoPBTx6qdQdInxUoHVqPy+qCi8JM75VAWA1skCsrCC67T7
        URxMo5ykMNKm5
X-Received: by 2002:aa7:c6cc:: with SMTP id b12mr17755eds.67.1611573687237;
        Mon, 25 Jan 2021 03:21:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGuRwlf5DctnjkbyQm3Qvy9VicrSSSlvYXaqqsPfZLUd+0Y/hLfx+NGJowpHioUtLsi7B0mw==
X-Received: by 2002:aa7:c6cc:: with SMTP id b12mr17736eds.67.1611573686945;
        Mon, 25 Jan 2021 03:21:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id br6sm6404022ejb.46.2021.01.25.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 03:21:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 29FA418033D; Mon, 25 Jan 2021 12:21:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCHv16 bpf-next 1/6] bpf: run devmap xdp_prog on flush
 instead of bulk enqueue
In-Reply-To: <20210125033025.GL1421720@Leo-laptop-t470s>
References: <20210120022514.2862872-1-liuhangbin@gmail.com>
 <20210122074652.2981711-1-liuhangbin@gmail.com>
 <20210122074652.2981711-2-liuhangbin@gmail.com>
 <20210122105043.GB52373@ranger.igk.intel.com> <871red6qhr.fsf@toke.dk>
 <20210125033025.GL1421720@Leo-laptop-t470s>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 25 Jan 2021 12:21:26 +0100
Message-ID: <87r1m9mfd5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Fri, Jan 22, 2021 at 02:38:40PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> >>  out:
>> >> +	drops =3D cnt - sent;
>> >>  	bq->count =3D 0;
>> >>=20=20
>> >>  	trace_xdp_devmap_xmit(bq->dev_rx, dev, sent, drops, err);
>> >>  	bq->dev_rx =3D NULL;
>> >> +	bq->xdp_prog =3D NULL;
>> >
>> > One more question, do you really have to do that per each bq_xmit_all
>> > call? Couldn't you clear it in __dev_flush ?
>> >
>> > Or IOW - what's the rationale behind storing xdp_prog in
>> > xdp_dev_bulk_queue. Why can't you propagate the dst->xdp_prog and rely=
 on
>> > that without that local pointer?
>> >
>> > You probably have an answer for that, so maybe include it in commit
>> > message.
>> >
>> > BTW same question for clearing dev_rx. To me this will be the same for=
 all
>> > bq_xmit_all() calls that will happen within same napi.
>>=20
>> I think you're right: When bq_xmit_all() is called from bq_enqueue(),
>> another packet will always be enqueued immediately after, so clearing
>> out all of those things in bq_xmit_all() is redundant. This also
>> includes the list_del on bq->flush_node, BTW.
>>=20
>> And while we're getting into e micro-optimisations: In bq_enqueue() we
>> have two checks:
>>=20
>> 	if (!bq->dev_rx)
>> 		bq->dev_rx =3D dev_rx;
>>=20
>> 	bq->q[bq->count++] =3D xdpf;
>>=20
>> 	if (!bq->flush_node.prev)
>> 		list_add(&bq->flush_node, flush_list);
>>=20
>>=20
>> those two if() checks can be collapsed into one, since the list and the
>> dev_rx field are only ever modified together. This will also be the case
>> for bq->xdp_prog, so putting all three under the same check in
>> bq_enqueue() and only clearing them in __dev_flush() would be a win, I
>> suppose - nice catch! :)
>
> Thanks for the advice, so how about modify it like:

Yup, exactly! :)

-Toke

