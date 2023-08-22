Return-Path: <bpf+bounces-8282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C6784878
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C23A1C20B55
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30C02B57B;
	Tue, 22 Aug 2023 17:36:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3ED2B545
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:36:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24D65B72
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692725767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hz7Z8y2P7m45R2UBTeGN2JuhmC8I5fCqRqJcDftK6rI=;
	b=SPh28lwzDjwl1Uin4OpmYaTFJcseZNnYEvBapBQwk82rXgmRE9AgYB9b/urLOyG+bLBwhe
	94xZd6+lwlMMq/k1q9Ag9wYa0ua1a5EAlWK0fUiSt6WWMRbpjSnUgz/XS27DYN10WPlYQa
	zM9gez39skA1YDpNodNy/pSagNkilLU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-5mO2w0leNWCrjffIti1q4A-1; Tue, 22 Aug 2023 13:36:00 -0400
X-MC-Unique: 5mO2w0leNWCrjffIti1q4A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bb93f9a54fso47856331fa.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725759; x=1693330559;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz7Z8y2P7m45R2UBTeGN2JuhmC8I5fCqRqJcDftK6rI=;
        b=OWnu7SZCPhpqVXX06F/ygxI+BxZsdp5or/QNxG/RHTe9Bcvtypv9V8qCZWejkh/sso
         +nSTZjQg1Tp92HzjXfgt//GTLM79kujf2IlKEHhI2cI640odbiyqgYNVjw9YFSbA4jlG
         /gCHFitEaVtEMpnuuzd0ZpkbaLHDLeYQ74mab473L+nswembo0v66daVUOJNgcjBEQLd
         +SIAs4JaJ5yqIcf67pNzMBJeN2w2D1rc6n7ch9M9taOemep7Gohb3Y9yAgI0WCfgVika
         IsZyEq2F0tUcPVKBNURvE6AYK4AvhRxZlDSqN1R1KIYu/uHHiRCpTTOk2Vb2D1daex1C
         HSKQ==
X-Gm-Message-State: AOJu0Yw8PC5g4s6jgctu60BEh6ZV73SdKoccblA6IGWg4x7QMxBOElx0
	3JhPhQ0sNIZneJjcG6VDau8iCitm0Nn+6ZLmyaLe8z2OMPbRCrkzcM4+Pm4fapPssucwTzgz8H8
	iwOcfdW3CKCk7
X-Received: by 2002:a2e:320c:0:b0:2b9:e93e:65e6 with SMTP id y12-20020a2e320c000000b002b9e93e65e6mr7647430ljy.35.1692725758695;
        Tue, 22 Aug 2023 10:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEaliFX53rXvTcqcEnmCJyi1Pl+k86CRgOTzWYinO3AVLwjYDMLIqFkUd69rkXPS8IFj5usA==
X-Received: by 2002:a2e:320c:0:b0:2b9:e93e:65e6 with SMTP id y12-20020a2e320c000000b002b9e93e65e6mr7647408ljy.35.1692725758245;
        Tue, 22 Aug 2023 10:35:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l4-20020a1709062a8400b00997e00e78e6sm8483372eje.112.2023.08.22.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:35:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 88C3FD3CCEB; Tue, 22 Aug 2023 19:35:57 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org, Samuel
 Dobron <sdobron@redhat.com>, Ondrej Lichtner <olichtne@redhat.com>, Rick
 Alongi <ralongi@redhat.com>
Subject: Re: [PATCH bpf-next 4/6] samples/bpf: Remove the xdp1 and xdp2
 utilities
In-Reply-To: <b3d2080d-e593-283b-cf97-d39256cfd4e9@redhat.com>
References: <20230822142255.1340991-1-toke@redhat.com>
 <20230822142255.1340991-5-toke@redhat.com>
 <721e5240-ab19-507a-c80e-ce5d133c0a9f@kernel.org> <87cyzf9fsp.fsf@toke.dk>
 <b3d2080d-e593-283b-cf97-d39256cfd4e9@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Aug 2023 19:35:57 +0200
Message-ID: <877cpn9dz6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jesper Dangaard Brouer <jbrouer@redhat.com> writes:

> On 22/08/2023 18.56, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> On 22/08/2023 16.22, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> The functionality of these utilities have been incorporated into the
>>>> xdp-bench utility in xdp-tools. Remove the unmaintained versions in
>>>> samples.
>>>>
>>>
>>> I think it will be worth our time if we give some examples of how the
>>> removed utility translates to some given xdp-bench commands.  There is
>>> not a 1-1 mapping.
>>>
>>> XDP driver changes need to be verified on physical NIC hardware, so
>>> these utilities are still being run by QA.  I know Red Hat, Intel and
>>> Linaro QA people are using these utilities.  It will save us time if we
>>> can reference a commit message instead of repeatable describing this.
>>> E.g. for Intel is it often contingent workers that adds a tested-by
>>> (that all need to update their knowledge).
>>=20
>> I did think about putting that in the commit message for these, but I
>> figured it was too obscure a place to put it, compared to (for instance)
>> putting it into the xdp-bench man page.
>>=20
>> If you prefer to have it in the commit message as well, I can respin
>> adding it - WDYT?
>>=20
>
> It is super nice that xdp-bench already have a man page, but I was=20
> actually looking at this and it was a bit overwhelming (520 lines)=20
> explaining every possible option.

Haha, I think that's the first time I've had anyone complain that I
write too *much* documentation ;)

> I really think its worth giving examples in the commit, to ease the=20
> transition to this new tool.

OK, I'll respin tomorrow with some examples in the commit messages...

-Toke


