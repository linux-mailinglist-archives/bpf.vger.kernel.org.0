Return-Path: <bpf+bounces-3677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC87419FB
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 23:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD5F1C2028E
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 21:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91611187;
	Wed, 28 Jun 2023 21:02:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471711181
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 21:02:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E27198E
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 14:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687986131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9506tjdRUpf919lvfhcv2C6YbXpf1fvzNXoPxI/AF8=;
	b=YROtpBH+O2GkHKb1V7ofnViwuC7hJJn+4N6sK/Ljb1iTn5StmK+0Gxq/8rYb1FgifpagI+
	e2ngPgYmy7JQA8RVsFxFtbgpKKudSdH3MqykWLtCeAKbPJSTixDHHjw78mwTvJvHCf+a/w
	+m9fca1RIS3n4eyKMiz7khGzBIUDRoI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-qoxZHR3HMpeh24XdTCOdXQ-1; Wed, 28 Jun 2023 17:02:09 -0400
X-MC-Unique: qoxZHR3HMpeh24XdTCOdXQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa83859fa4so1721865e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 14:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687986128; x=1690578128;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9506tjdRUpf919lvfhcv2C6YbXpf1fvzNXoPxI/AF8=;
        b=lgjbepunVFi90YwjICg/tq4mjIIF26WRtpKjZuLaVWYI6AQ4rphThdPS2JBmI9R0dW
         opPeHSIXb8C6JPq4BmpWCYLPEchUsadm781ozaq936Ib49dD+mU4yBJ1PLZ+4aa2Rv7j
         9tLwJ1rVeYvHCqQOlKWj+8urSYwGAs0ORendFw0m/b5GuE/ZEZ1mm/ouI0QQ13alhc2L
         ICUSRpK+4S8Bma+P1KULmc+d0HFi3md2fpAp5sQLD5S5Mmm/qCkaTk2xFHI3uE27rhnN
         HrtijuoglLIZMWQD6miw5l7vRA1fFeQaUyERzD7Lhdu58DVf8MRj8IbcYyhuUvezS5Sb
         EjaA==
X-Gm-Message-State: AC+VfDywSNm83Km9lFtbDc7PBPpOOIb+sYkd4matjzVxRRWZrJRHhWYP
	lGdSkbSTItvSd8Ci8MOW/+0MeNKu6YahGC9IJcyw3FIZ3emLAne1TgutD/Pb76jt/pXorwgG6S8
	rrFGYqfHw3n+i
X-Received: by 2002:a1c:750a:0:b0:3f5:878:c0c2 with SMTP id o10-20020a1c750a000000b003f50878c0c2mr25649659wmc.3.1687986128201;
        Wed, 28 Jun 2023 14:02:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ555s0Uauaywa+YUbpgGLrI/eB4NrymjZvBeM3Ccx8OEyCLZQopFxpFybHVInNG5cu5CiBqYg==
X-Received: by 2002:a1c:750a:0:b0:3f5:878:c0c2 with SMTP id o10-20020a1c750a000000b003f50878c0c2mr25649640wmc.3.1687986127792;
        Wed, 28 Jun 2023 14:02:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm14621588wmb.26.2023.06.28.14.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:02:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 51EA7BC0244; Wed, 28 Jun 2023 23:02:06 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, tirthendu.sarkar@intel.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
In-Reply-To: <ZJx9WkB/dfB5EFjE@boxer>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-16-maciej.fijalkowski@intel.com>
 <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk>
 <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
 <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
 <875y7flq8w.fsf@toke.dk> <ZJx9WkB/dfB5EFjE@boxer>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 28 Jun 2023 23:02:06 +0200
Message-ID: <87edlvgv1t.fsf@toke.dk>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index a4270fafdf11..b24244f768e3 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -19,6 +19,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
>  		return -EMSGSIZE;
>  
>  	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
> +	    nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
> +			netdev->xdp_zc_max_segs) ||

Should this be omitted if the driver doesn't support zero-copy at all?

-Toke


