Return-Path: <bpf+bounces-3744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70534742886
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 16:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDE0280EF7
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1FC144;
	Thu, 29 Jun 2023 14:35:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF510FA
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 14:35:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0939D359C
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688049340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8R5NWbxG8vczdgWdFQsQrHOmepgax0uH77iAdWT6/Y=;
	b=I0x3NIsEck4Ojsqmax/A12cY8yK7l3q4G/LMqrY3pBXhDLjXt1uhzBj7jcR01l6FMPmRwW
	dL7TKwDltcbnpMuHVriepyOAR2W0lpVzq9UBF2syl34eukgipYkMBse2Wo8UB/uhrvZGGc
	z24cMTXRgyGVhWSBKK5mtDJi5mNQD1A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-7mDJK1oFMpeBIJoqexIwwQ-1; Thu, 29 Jun 2023 10:35:38 -0400
X-MC-Unique: 7mDJK1oFMpeBIJoqexIwwQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f810b4903fso3921435e9.2
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 07:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688049337; x=1690641337;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8R5NWbxG8vczdgWdFQsQrHOmepgax0uH77iAdWT6/Y=;
        b=isdMrIw6EhphdanLQ/xX6NFMpOVPGKtE3Cv5byqq0saMIX8J9ry9l8bUi1OhpzUcYA
         L6yHLaYQAEcZkeTeJrrY/x16cR97t4yOqZV0h1ozHNM9roHzZwl/Z1v431k3gqi5DN3y
         0ZvKlnkYpCo+uSfTBrS1c0OcNxwqGUGBVWYhECQymcv81T6W1/IfyBviG4c+tNwZJf+q
         NAMV/bgeeLk/4CFif81sP4iBVnd168DMh/RVxWZnxdDkf1wsJ2iZpcE+fn3piBtwffp/
         68NFWpYTpBbRelidBvjhu5FrEz3HBDZMHkBNnOn91qimhN631nxT5TnbC8JGe28jIUzT
         beFA==
X-Gm-Message-State: AC+VfDxpN2VSHFXgB3wsD7rLs9GNQtgIcjumMTepbl1IxMxfTN4PugwA
	9Jh0mpYE/ZUB4h6bK+ZbUP1IRzAA6ZDYzRqs4crHxEiH1uboU4+235l6kJ7zN9och7lk2AqZ0Zd
	M6v91W/kblixp
X-Received: by 2002:a7b:cd1a:0:b0:3fb:7184:53eb with SMTP id f26-20020a7bcd1a000000b003fb718453ebmr7354224wmj.18.1688049336966;
        Thu, 29 Jun 2023 07:35:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6h7QlIhkGzTRnVyTU2NsDFOF3dILJkeijSsCDj9Q06ewfBcGoUzfIOspcHXewvLQsf+b6htQ==
X-Received: by 2002:a7b:cd1a:0:b0:3fb:7184:53eb with SMTP id f26-20020a7bcd1a000000b003fb718453ebmr7354206wmj.18.1688049336544;
        Thu, 29 Jun 2023 07:35:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003fba92fad35sm4237514wmi.26.2023.06.29.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:35:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5FF87BC0476; Thu, 29 Jun 2023 16:35:35 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: Florian Westphal <fw@strlen.de>, Daniel Xu <dxu@dxuuu.xyz>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in BPF
In-Reply-To: <20230629132141.GA10165@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz> <874jmthtiu.fsf@toke.dk>
 <20230627154439.GA18285@breakpoint.cc> <87o7kyfoqf.fsf@toke.dk>
 <20230629132141.GA10165@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 29 Jun 2023 16:35:35 +0200
Message-ID: <87leg2fia0.fsf@toke.dk>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Florian Westphal <fw@strlen.de> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>> Florian Westphal <fw@strlen.de> writes:
>> > For bpf a flag during link attachment seemed like the best way
>> > to go.
>>=20
>> Right, I wasn't disputing that having a flag to load a module was a good
>> idea. On the contrary, I was thinking we'd need many more of these
>> if/when BPF wants to take advantage of more netfilter code. Say, if a
>> BPF module wants to call into TPROXY, that module would also need go be
>> loaded and kept around, no?
>
> That seems to be a different topic that has nothing to do with
> either bpf_link or netfilter?
>
> If the program calls into say, TPROXY, then I'd expect that this needs
> to be handled via kfuncs, no? Or if I misunderstand, what do you mean
> by "call into TPROXY"?
>
> And if so, thats already handled at bpf_prog load time, not
> at link creation time, or do I miss something here?
>
> AFAIU, if prog uses such kfuncs, verifier will grab needed module ref
> and if module isn't loaded the kfuncs won't be found and program load
> fails.

...

> Or we are talking about implicit dependencies, where program doesn't
> call function X but needs functionality handled earlier in the pipeline?
>
> The only two instances I know where this is the case for netfilter
> is defrag + conntrack.

Well, I was kinda mixing the two cases above, sorry about that. The
"kfuncs locking the module" was not present in my mind when starting to
talk about that bit...

As for the original question, that's answered by your point above: If
those two modules are the only ones that are likely to need this, then a
flag for each is fine by me - that was the key piece I was missing (I'm
not a netfilter expert, as you well know).

Thanks for clarifying, and apologies for the muddled thinking! :)

-Toke


