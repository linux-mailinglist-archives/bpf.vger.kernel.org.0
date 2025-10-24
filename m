Return-Path: <bpf+bounces-72007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E284FC05500
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAE604E4E21
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A21309EE2;
	Fri, 24 Oct 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqskLpHa"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F7307AE0
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297937; cv=none; b=JxmM5+4aU8Z9DLTkiDUSDIUjaKY3bdk2RML7OnXBfLRYgJsI0LxfspXaWAHGDhR3bk3LimCJHELoeZFZ5V0qDF0vQihg3c7FPBSGNPYJhXW1FDSmdtglGA6YGfL9888BSGglX7aq9W4X9MT5c4JkI9rw2cfXlYOtKg1UcW7Kpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297937; c=relaxed/simple;
	bh=ycwJPNaKXdP7ykIZso5OObT1oMAhKCHRAqkXq/epey0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kl+/ckmCok7J3boFLcgXRn87f6H/RTlrKbi8jldb7D0uz6+hNLuiWk08k8dqOugGXQL1N6CAhmRpLxEgmQv6vvklc/74RoEuYJf4qfN7e8itZlwhqGJeOUn50/NfzS3/qrDXhdQJgvcdXficH3NtDemSEomXmIZINWyACOKCQMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqskLpHa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761297934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bxSCY3ryT9EvARIVKSqFw+MJM7CiAqPgxi/1YTNuRA=;
	b=fqskLpHa00xCUZvuLn87H0iUNlgN54JzUhjUIP2vJydCzuh1cAIYwb76UYUBi3u1SvFNgO
	qD6ynboh+3ob6wUhqiQxH7PL07BtdqMtL7SwaAs/aEaFHxN7HzsTZQ3MEP7IzsHdAjhHuE
	oBJ0hz7w6jxkhoEEUyO0mfuuRKkyqyw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-G_FfH6xGMXqI4uQUbp-Emg-1; Fri, 24 Oct 2025 05:25:32 -0400
X-MC-Unique: G_FfH6xGMXqI4uQUbp-Emg-1
X-Mimecast-MFC-AGG-ID: G_FfH6xGMXqI4uQUbp-Emg_1761297932
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-63c41bc2dfcso1241909a12.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 02:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297931; x=1761902731;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bxSCY3ryT9EvARIVKSqFw+MJM7CiAqPgxi/1YTNuRA=;
        b=r4f/U8siOSOPJhLETQI3LV27ZioO2APrVZH2kZa/ffvu0AxDDdTdNltGI4C935GqfY
         ZtYzyoOvJG4SJfFzAW2OR09dP3HUERasjtYM5/CJewgWvFB9X9KN0MRo6WQjsKBsdJYG
         pdswh1apcHQwGVtAKwnvDIN0viLNXaBiLK712imhQgpqyme2sj4q2gyypHLS15sMPdFv
         5og0BQbsjLeLLQv2l3L5toQ/mDDqRSjlM41AOHMQUiVLWTjvhpC/8DCn0tIkTvYF/Ez5
         ysGpa3KhyclncaYL/Cu5c2KK3uJjOjdGwtasNFEZNdONJ6x/+4Y/EVjPZnKpGgtVjtIA
         hTPA==
X-Forwarded-Encrypted: i=1; AJvYcCXdlubF9wxvuTKHOS2r3drnpJ239WhnXN5Fl6CdFzAOG5YDPjNkFBR3Udidupk/Pm3wymw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyabG8UKsCEAx5+0KpVzhFX+URvEHkum9TIP6i4bdTZKaZJMobM
	UiAFVATtTXYQ/ddHzgZZFz4ek2qTodbmSX9h9XRoMG26Dnh9ZZg4oBiq2sKeZh8yVufVjPfT0c/
	0wgKWgbJ8zh5bqN+LSZvMAW4SRAK8z8YtsXPVS6ce3M6x2K3tMVIvkA==
X-Gm-Gg: ASbGncsA576LvaCvbaLB74gjCoQOgj0C99dOLBTcwvwADtz0FnmqX7sg2rWrWjGfc+K
	AVZdmVSJqEMH8AXRrHLe8V/qfwu23LlLBXCQvzHw19EMBeUAu2W6AWHb1K6TFM3sjL+vKprz/DL
	RNgE6EDRqFAyUlkEayTUwEk2Z+I5KhqE197+8F235rdk5oukugkqZeWEqC2KfXfCB4I9uam0MmX
	iproqAnH0wqNGbTTgP6EUUzxjEzQXHh4J2BabwGrTHU1fjuu1LhpasScQvx9TVcvYzMcAAkC6LB
	Xp2g8R+yauPgS1wVDLA5HNtzspmo+qj2k09gaPtfiHISyOMpPJmEQrZ0PznwcfvCnD4T2zlMiPP
	idB5RXT4HSAz7GSR9Fm6XrDk=
X-Received: by 2002:a05:6402:13cc:b0:63b:dc7d:7308 with SMTP id 4fb4d7f45d1cf-63c1f6364d3mr25741579a12.5.1761297931580;
        Fri, 24 Oct 2025 02:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlOwaUMR8VZbVJ4djy08L7hrr6l8ANdpbOoJ+KZ4mKPMSj4WRf9s7vqK0lEtnMuhu39rcxDw==
X-Received: by 2002:a05:6402:13cc:b0:63b:dc7d:7308 with SMTP id 4fb4d7f45d1cf-63c1f6364d3mr25741560a12.5.1761297931165;
        Fri, 24 Oct 2025 02:25:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb2736sm3659474a12.6.2025.10.24.02.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:25:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6C4782EA50E; Fri, 24 Oct 2025 11:25:26 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org,
 lorenzo@kernel.org, kuba@kernel.org, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v3 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
In-Reply-To: <20251022125209.2649287-2-maciej.fijalkowski@intel.com>
References: <20251022125209.2649287-1-maciej.fijalkowski@intel.com>
 <20251022125209.2649287-2-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 Oct 2025 11:25:26 +0200
Message-ID: <87cy6cfy7t.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> which do not have its XDP memory model registered. There is a case when
> XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
> releases underlying memory. This happens when it consumes enough amount
> of bytes and when XDP buffer has fragments. For this action the memory
> model knowledge passed to XDP program is crucial so that core can call
> suitable function for freeing/recycling the page.
>
> For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
> of mem model registration. The problem we're fixing here is when kernel
> copied the skb to new buffer backed by system's page_pool and XDP buffer
> is built around it. Then when bpf_xdp_adjust_tail() calls
> __xdp_return(), it acts incorrectly due to mem type not being set to
> MEM_TYPE_PAGE_POOL and causes a page leak.
>
> Pull out the existing code from bpf_prog_run_generic_xdp() that
> init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
> embed there rxq's mem_type initialization that is assigned to xdp_buff.
> Make it agnostic to current skb->data position.
>
> This problem was triggered by syzbot as well as AF_XDP test suite which
> is about to be integrated to BPF CI.
>
> Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@g=
oogle.com/
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Co-developed-by: Octavian Purdila <tavip@google.com>
> Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, test=
ing, initiating a fix
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit=
 msg and proposed more robust fix
> ---
>  include/net/xdp.h | 27 +++++++++++++++++++++++++++
>  net/core/dev.c    | 25 ++++---------------------
>  2 files changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..cec43f56ae9a 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -384,6 +384,33 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_=
frame *xdpf,
>  					 struct net_device *dev);
>  struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
>=20=20
> +static inline
> +void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
> +			     struct xdp_rxq_info *xdp_rxq)
> +{
> +	u32 frame_sz, pkt_len;
> +
> +	/* SKB "head" area always have tailroom for skb_shared_info */
> +	frame_sz =3D skb_end_pointer(skb) - skb->head;
> +	frame_sz +=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
> +	pkt_len =3D  skb->tail - skb->mac_header;

Should probably just use the helpers here:

pkt_len =3D skb_tail_pointer(skb) - skb_mac_header(skb);

that way you don't have to open-code the WARN_ON_ONCE, and you get the
right behaviour even when NET_SKBUFF_DATA_USES_OFFSET is set

-Toke


