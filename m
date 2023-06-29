Return-Path: <bpf+bounces-3730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B0742584
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A41280E28
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5843A14AA8;
	Thu, 29 Jun 2023 12:16:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E313AC2
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 12:16:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7722E2D55
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688040972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRtfZg4SPW/dfExfHKxyTm+z8to08LGorkhnQOIa1Ew=;
	b=DcXCcey3hZQkbG7IOdhT4/gA367sqKMgOz7kmRT3lXwccO6FcRg1ZyjjL8FOcFsa1XDwhp
	YUZNvWnJR+bpfUn4EH07EkBEGs4fgJCt53mjC0WgBUETTb/F2m8Q5J8NYi6l30NKssgIE5
	fxQ5AjZNxUCJizzbVQfxdcFofdrsetk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-ThSLFDJWN36R9H22hNRVsw-1; Thu, 29 Jun 2023 08:16:11 -0400
X-MC-Unique: ThSLFDJWN36R9H22hNRVsw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34e35f57so42740666b.3
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 05:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688040970; x=1690632970;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRtfZg4SPW/dfExfHKxyTm+z8to08LGorkhnQOIa1Ew=;
        b=R/35rQf6NPor688YvRAmLq8bOQ38YxTVtlwKGAWDOdv5MC7jI/RTL/EURovST69yWI
         PbjnyZ2TgImBDyE2uBEPFFDMHxeTXagyXLIhsXwFdet1U3GaCpTCdPrJatZhQoUOF1v3
         rhbFnLAxfpeHmEHnQIGd9/z4Rc2xm2u2MnvHn7RZQbKZfv9I7cIo7DeDr9P1OdhZ1WhM
         4skNBL8t9oSt/cbgJQcOJZ9lIuH3TyAJcBdpKy0LiKLnLeMCc1jBV7l3svxls4kCGgBD
         PXgrIc0ahPKu6xie7jPn/khSsCvv5+0g+B62nHUoVj0MR3apgVyUb7/40VyWzzqNJiCA
         C6uA==
X-Gm-Message-State: AC+VfDzCOrdMbpmUw+GWcrY+1wQeFIStsAHhInJ5lpdyt5aNtQqU55nC
	zRI127fBwqBFPXLVogkp9E1ys7G/TVM6iUdNA2DIVUx2oCnCGDkOE7cAlTpyS+yjn96qCkF4vHb
	5kuPQHO9R6X62
X-Received: by 2002:a17:907:7ba5:b0:982:9b01:a57c with SMTP id ne37-20020a1709077ba500b009829b01a57cmr35983867ejc.12.1688040970186;
        Thu, 29 Jun 2023 05:16:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ440Dob8tg/t5hFb4HMywtZ2vhJhTJbVaJ/t/Vr2iJNg951ErahzdstJyCHl3lyIqlaAIFN+A==
X-Received: by 2002:a17:907:7ba5:b0:982:9b01:a57c with SMTP id ne37-20020a1709077ba500b009829b01a57cmr35983845ejc.12.1688040969798;
        Thu, 29 Jun 2023 05:16:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id qq2-20020a17090720c200b00992aea2c55dsm589147ejb.153.2023.06.29.05.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:16:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 940D2BC0450; Thu, 29 Jun 2023 14:16:08 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 coreteam@netfilter.org, netfilter-devel@vger.kernel.org, fw@strlen.de,
 daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in BPF
In-Reply-To: <20230627154439.GA18285@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz> <874jmthtiu.fsf@toke.dk>
 <20230627154439.GA18285@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 29 Jun 2023 14:16:08 +0200
Message-ID: <87o7kyfoqf.fsf@toke.dk>
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
>> > The basic idea is we bump a refcnt on the netfilter defrag module and
>> > then run the bpf prog after the defrag module runs. This allows bpf
>> > progs to transparently see full, reassembled packets. The nice thing
>> > about this is that progs don't have to carry around logic to detect
>> > fragments.
>>=20
>> One high-level comment after glancing through the series: Instead of
>> allocating a flag specifically for the defrag module, why not support
>> loading (and holding) arbitrary netfilter modules in the UAPI?
>
> How would that work/look like?
>
> defrag (and conntrack) need special handling because loading these
> modules has no effect on the datapath.
>
> Traditionally, yes, loading was enough, but now with netns being
> ubiquitous we don't want these to get enabled unless needed.
>
> Ignoring bpf, this happens when user adds nftables/iptables rules
> that check for conntrack state, use some form of NAT or use e.g. tproxy.
>
> For bpf a flag during link attachment seemed like the best way
> to go.

Right, I wasn't disputing that having a flag to load a module was a good
idea. On the contrary, I was thinking we'd need many more of these
if/when BPF wants to take advantage of more netfilter code. Say, if a
BPF module wants to call into TPROXY, that module would also need go be
loaded and kept around, no?

I was thinking something along the lines of just having a field
'netfilter_modules[]' where userspace could put an arbitrary number of
module names into, and we'd load all of them and put a ref into the
bpf_link. In principle, we could just have that be a string array of
module names, but that's probably a bit cumbersome (and, well, building
a generic module loader interface into the bpf_like API is not
desirable either). But maybe with an explicit ENUM?

> At the moment I only see two flags for this, namely
> "need defrag" and "need conntrack".
>
> For conntrack, we MIGHT be able to not need a flag but
> maybe verifier could "guess" based on kfuncs used.

If the verifier can just identify the modules from the kfuncs and do the
whole thing automatically, that would of course be even better from an
ease-of-use PoV. Not sure what that would take, though? I seem to recall
having discussions around these lines before that fell down on various
points.

> But for defrag, I don't think its good to add a dummy do-nothing
> kfunc just for expressing the dependency on bpf prog side.

Agreed.

-Toke


