Return-Path: <bpf+bounces-2949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D497372BA
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 19:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E64B1C20CF6
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4802AB55;
	Tue, 20 Jun 2023 17:25:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B452AB47
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 17:25:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06BE173B
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687281939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WelivlojEg7/Ui+rvmWELsM50z+DhTfitwvWDoBJs90=;
	b=Sfs/rRWo6lhyys/FZJYYAH/50bfIjOxu0oYO/GfOxiRtQWBBq3v1dliMYjL1OlzYt/j//o
	kV6YNK82wmSKDpAHfGhyw40A4YNUUzoUqr68TEmaa6j5ckL7bSxp5nnOW/kw/UfNLLKf0a
	sYHbvM8oVzX0SBS6WMD8n0p4nbFRHu8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-HxrzvNcWNnqsAtvr2wP7aA-1; Tue, 20 Jun 2023 13:25:36 -0400
X-MC-Unique: HxrzvNcWNnqsAtvr2wP7aA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f956a29f2aso191945e87.0
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 10:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281934; x=1689873934;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WelivlojEg7/Ui+rvmWELsM50z+DhTfitwvWDoBJs90=;
        b=NqE5LeWBFTib10IlT/GzfQIE8Nyarl/v+4YNrC8st+z5NsxWrM5osm1A1ERxPzJDMp
         MfrNmx/hGd2sG/N4RqpSi5T6rOoVDHE71vsxVcZaNuO8qTvTaATCdwiYhRrQaVe9/jxb
         3ICcTATWQx8PvQ0eKf29dktoGUho4u5XBDudi5vtdz51iXjWPrUithqBZysnQ1XDkFdG
         6f2wxJKJnuGslBEwr4R/kEKck1I/W1DZTcf01EFsbCHjYOU3No3jsVxstWwK5HN/Z4i4
         yW+9HUbk0hbJ6b2c+faJkHjdo9I7AbdLLIG338TBbIePQAHIyYzkQSKNjknqz+2JW6mt
         U+8w==
X-Gm-Message-State: AC+VfDy0ujnrfDt/hI0yJqMwQOBCI2MYw9XJflv3OgLMXcrrvFaGqOUA
	XhxGyWzjzARTWnpT/KgxPjWXv6ZDtG8UogQrpv62MxGAlQ3YE8KRgQ232Pn702d+jxN/Zu2AQ4g
	zIkArBP+7gXHc
X-Received: by 2002:a19:4f01:0:b0:4f9:5711:2eb6 with SMTP id d1-20020a194f01000000b004f957112eb6mr208927lfb.28.1687281934107;
        Tue, 20 Jun 2023 10:25:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uHsk/RiCH395+1HpLTCiH7Cx0/5T9OaASsbbrdWzEC8sgwk7OYrc5fsB2I/fC9LtWsg/cfw==
X-Received: by 2002:a19:4f01:0:b0:4f9:5711:2eb6 with SMTP id d1-20020a194f01000000b004f957112eb6mr208907lfb.28.1687281933353;
        Tue, 20 Jun 2023 10:25:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003f908ee3091sm9226918wmi.3.2023.06.20.10.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:25:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BA910BBF0AF; Tue, 20 Jun 2023 19:25:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 tirthendu.sarkar@intel.com, maciej.fijalkowski@intel.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 06/22] xsk: introduce wrappers and helpers
 for supporting multi-buffer in Tx path
In-Reply-To: <20230615172606.349557-7-maciej.fijalkowski@intel.com>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-7-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 20 Jun 2023 19:25:31 +0200
Message-ID: <87352mdp10.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>
> In Tx path, xsk core reserves space for each desc to be transmitted in
> the completion queue and it's address contained in it is stored in the
> skb destructor arg. After successful transmission the skb destructor
> submits the addr marking completion.
>
> To handle multiple descriptors per packet, now along with reserving
> space for each descriptor, the corresponding address is also stored in
> completion queue. The number of pending descriptors are stored in skb
> destructor arg and is used by the skb destructor to update completions.
>
> Introduce 'skb' in xdp_sock to store a partially built packet when
> __xsk_generic_xmit() must return before it sees the EOP descriptor for
> the current packet so that packet building can resume in next call of
> __xsk_generic_xmit().
>
> Helper functions are introduced to set and get the pending descriptors
> in the skb destructor arg. Also, wrappers are introduced for storing
> descriptor addresses, submitting and cancelling (for unsuccessful
> transmissions) the number of completions.
>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> ---
>  include/net/xdp_sock.h |  6 ++++
>  net/xdp/xsk.c          | 74 ++++++++++++++++++++++++++++++------------
>  net/xdp/xsk_queue.h    | 19 ++++-------
>  3 files changed, 67 insertions(+), 32 deletions(-)
>
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 36b0411a0d1b..1617af380162 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -68,6 +68,12 @@ struct xdp_sock {
>  	u64 rx_dropped;
>  	u64 rx_queue_full;
>  
> +	/* When __xsk_generic_xmit() must return before it sees the EOP descriptor for the current
> +	 * packet, the partially built skb is saved here so that packet building can resume in next
> +	 * call of __xsk_generic_xmit().
> +	 */
> +	struct sk_buff *skb;

What ensures this doesn't leak? IIUC, when the loop in
__xsk_generic_xmit() gets to the end of a batch, userspace will get an
EAGAIN error and be expected to retry the call later, right? But if
userspace never retries, could the socket be torn down with this pointer
still populated? I looked for something that would prevent this in
subsequent patches, but couldn't find it; am I missing something?

-Toke


