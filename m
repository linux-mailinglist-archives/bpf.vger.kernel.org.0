Return-Path: <bpf+bounces-69239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0814B921EB
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1A83AA2C6
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D531063B;
	Mon, 22 Sep 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT4wUjgZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BFE30BF7A
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557056; cv=none; b=uuh05quAb1R0PVoIqNJ7pErwWPHNX5QodNDfB8M8k9ioLNmH347W5NPLRwJhPWYp219zVKIZhsLYZ+dsyUC6sHpL8wWTK78R/JJCcM6WS7VWDeQsannHa/Vw0mgFkiimi46o6kBcC4pmtahyZV/mAkf8L1yHsF1COeWQxcCCmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557056; c=relaxed/simple;
	bh=nePZdJQEdMGUmKC8gBR3fRA0GVeZWURrR0NM9HeSVYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQm+s/v93lonQS7nWxnc277MsZ29aTKkC3zFAGWa0PYJug0HFBv5lmf4v54GC4hka8ZdMo3jkxjVY7vKNZJRf8vrScQ3AAFdK6MhUuIzfklzVdKUnsLdUbk10bv3a8k1vuSXZHQ8Sd5O7nkNpPdNZamynd293a80+ZFp0UKrDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT4wUjgZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457f581aeso45487865ad.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758557054; x=1759161854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfndncaynqr5cPm/dhwenv1OsDSwnszaccEfIEf8Fz8=;
        b=CT4wUjgZU3FI2a2P3/7W2XvsrG/DxFM38UTUCiUkHGPixpC/Hg5apeO/W0Aln9VfVP
         e05HFwNVWan8ZivhMQYZ1zTL1kmfaBUvvMcIom21rHJq4d7ZJitDmgy6UnyqYwIk3guz
         eYvF3HDvfIXTImdPbftyYsr5tLYrSaJUUbOq391YK+anz0qO/hCqInyFv33HY4EQ13xb
         92znrLHYmgTdFHeD1b5tiyieFwtqCUWqypZw3vgZYcZrGrH3lnKtcbp9pyF37SSxjpx/
         ynXJCHALFIcTIAlNL8IAtCAKOmLGsgI/A2qFIq5ABHOcOER0ob5uHN2bDLfj+2HuQK6I
         HwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557054; x=1759161854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jfndncaynqr5cPm/dhwenv1OsDSwnszaccEfIEf8Fz8=;
        b=okGjfCWq6tSPsZHYLovs5n9G6a9uYaSPEKGMlKlSz1DeFMkE50Bhvd2Qoh8jRRHmvx
         z9ZyIPOdnbLiaPx8+BKEl3HKw9N1Ycdmmsuu7fxBsvtDr37aOTR66C+biEXTWb3znDu5
         uGOG6kyHOteXk/igbJlDNONjK39zs4hmf+xqK8PTPX95xMuDyukJMJfPuuYC/0qZGzIR
         Gmym60vDQVeJaj7taOJVYCxaYiL9eDQnUEN28KpzY36oDvzHoKP7oXSpSuSv7PRMXKEz
         66aU4Uny00fWRljre34mAvZhg07OTVb5OgZu1jbCIGUrnrrBYmx+OoGmHcVTriDCPVjH
         7e6w==
X-Forwarded-Encrypted: i=1; AJvYcCUJT2anl0C7eeSytlRwOEkBjDni0bhKXgqOc5WyWWZk00B4FYm/5FSAmU2rCzIGjuXC3qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymxjVqGUW7KbA7rNVhSdNQMUNj0y9Znfo8NO05/4DfyY5wruSL
	wpCVe/7TG5x08PG7zqJJFvFho/9+jWiQ6LHntuR3/5AIQah4MA2foxQ=
X-Gm-Gg: ASbGncuFDJXWRIO9nvlj3z23GxNNZQLQncQ9oV2Rte8DbA0WWTLx6CUru6Eyv3iy9fm
	3QRdAPB1NfFdH78VgLIyyc7OCBuw+LyBuSxrqg+X8VVKh2AHD4HK0QM8CX3kXwC0mxKXFLIWYrn
	Oy9tKE7dq/5cY8Rdvxd+ugKi8eVrCq0qFIPQtKleAgSHdyqrdFBGjlljSb6bIh6+lBhZiCv0BVB
	zfYaqg4atvSqB8tdVm4VfUfshRYmD4El90xK/KJ/xcYJcNwlrNdIpmbs8E3ZxP4WWCtpTIJRdQK
	91ZCEnCTxMdTTfwPXXOKasnLJ50ANDkW7TjosLo+VqC1Rncb7Qw6PUqvthTe27YgRHKPc4cpR4G
	aHnMvU3zg7jLipIzON6FpjrLUYDkkSBNS+2Lckcs1n9le0R/EKGAaBmDTUs4yQueha+FQZUCwpS
	zEgzOM+nOFGzjS+RJHdCTX37qQ2fEUklVMdRozEDR7GK6Ad52cV9HosXPQ0ALqVR2HukAloTAsq
	1gaGn1AQmDY44Q=
X-Google-Smtp-Source: AGHT+IHthF9UCrCMuFfFgoDWVFLDnbsUIS9LX9WdPXoFUpRRiYxWpe5bnA1lKHjS2SyUSLmZsrvunQ==
X-Received: by 2002:a17:902:ccd2:b0:252:50ad:4e6f with SMTP id d9443c01a7336-269ba566603mr194252475ad.54.1758557054025;
        Mon, 22 Sep 2025 09:04:14 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-269a7dcafb6sm117270915ad.83.2025.09.22.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:04:13 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:04:13 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 01/20] net, ynl: Add bind-queue operation
Message-ID: <aNFzfbIFkOY1f2bL@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-2-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a ynl netdev family operation called bind-queue that _binds_ an
> rxq from a real netdev to a virtual netdev i.e. netkit or veth. This
> bound or _mapped_ rxq in the virtual netdev acts as a proxy for the
> parent real rxq, and can be used by processes running in a container
> to use memory providers (io_uring zero-copy rx or devmem) or AF_XDP.
> An early implementation had only driver-specific integration [0],
> but in order for other virtual devices to reuse, it makes sense to
> have this as a generic API.
> 
> src-ifindex and src-queue-id is the real netdev and rxq respectively.
> dst-ifindex is the virtual netdev. Note that this op doesn't take
> dst-queue-id, because the expectation is that the op will _create_ a
> new rxq in the virtual netdev. The virtual netdev must have
> real_num_rx_queues less than num_rx_queues at the time of calling
> bind-queue.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
> ---
>  Documentation/netlink/specs/netdev.yaml | 37 +++++++++++++++++++++++++
>  include/uapi/linux/netdev.h             | 11 ++++++++
>  net/core/netdev-genl-gen.c              | 14 ++++++++++
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/netdev-genl.c                  |  4 +++
>  tools/include/uapi/linux/netdev.h       | 11 ++++++++
>  6 files changed, 78 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index e00d3fa1c152..99a430ea8a9a 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -561,6 +561,29 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +  -
> +    name: queue-pair
> +    attributes:
> +      -
> +        name: src-ifindex
> +        doc: netdev ifindex of the physical device
> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: src-queue-id
> +        doc: netdev queue id of the physical device
> +        type: u32
> +      -
> +        name: dst-ifindex
> +        doc: netdev ifindex of the virtual device
> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: dst-queue-id
> +        doc: netdev queue id of the virtual device
> +        type: u32
>  
>  operations:
>    list:
> @@ -772,6 +795,20 @@ operations:
>            attributes:
>              - id
>  
> +    -
> +      name: bind-queue
> +      doc: Bind a physical netdev queue to a virtual one
> +      attribute-set: queue-pair
> +      do:
> +        request:
> +          attributes:
> +            - src-ifindex
> +            - src-queue-id
> +            - dst-ifindex
> +        reply:
> +          attributes:
> +            - dst-queue-id
> +
>  kernel-family:
>    headers: ["net/netdev_netlink.h"]
>    sock-priv: struct netdev_nl_sock
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 48eb49aa03d4..05e17765a39d 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -210,6 +210,16 @@ enum {
>  	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
>  };
>  
> +enum {
> +	NETDEV_A_QUEUE_PAIR_SRC_IFINDEX = 1,
> +	NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID,
> +	NETDEV_A_QUEUE_PAIR_DST_IFINDEX,
> +	NETDEV_A_QUEUE_PAIR_DST_QUEUE_ID,
> +
> +	__NETDEV_A_QUEUE_PAIR_MAX,
> +	NETDEV_A_QUEUE_PAIR_MAX = (__NETDEV_A_QUEUE_PAIR_MAX - 1)
> +};
> +
>  enum {
>  	NETDEV_CMD_DEV_GET = 1,
>  	NETDEV_CMD_DEV_ADD_NTF,
> @@ -226,6 +236,7 @@ enum {
>  	NETDEV_CMD_BIND_RX,
>  	NETDEV_CMD_NAPI_SET,
>  	NETDEV_CMD_BIND_TX,
> +	NETDEV_CMD_BIND_QUEUE,
>  
>  	__NETDEV_CMD_MAX,
>  	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index e9a2a6f26cb7..10b2ab4dd500 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -106,6 +106,13 @@ static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1]
>  	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
>  };
>  
> +/* NETDEV_CMD_BIND_QUEUE - do */
> +static const struct nla_policy netdev_bind_queue_nl_policy[NETDEV_A_QUEUE_PAIR_DST_IFINDEX + 1] = {
> +	[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
> +	[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID] = { .type = NLA_U32, },
> +	[NETDEV_A_QUEUE_PAIR_DST_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
> +};
> +
>  /* Ops table for netdev */
>  static const struct genl_split_ops netdev_nl_ops[] = {
>  	{
> @@ -204,6 +211,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
>  		.maxattr	= NETDEV_A_DMABUF_FD,
>  		.flags		= GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		= NETDEV_CMD_BIND_QUEUE,
> +		.doit		= netdev_nl_bind_queue_doit,
> +		.policy		= netdev_bind_queue_nl_policy,
> +		.maxattr	= NETDEV_A_QUEUE_PAIR_DST_IFINDEX,
> +		.flags		= GENL_CMD_CAP_DO,
> +	},
>  };
>  
>  static const struct genl_multicast_group netdev_nl_mcgrps[] = {
> diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> index cf3fad74511f..309248fe2b9e 100644
> --- a/net/core/netdev-genl-gen.h
> +++ b/net/core/netdev-genl-gen.h
> @@ -35,6 +35,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
>  int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
>  int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info);
> +int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info);
>  
>  enum {
>  	NETDEV_NLGRP_MGMT,
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 470fabbeacd9..b0aea27bf84e 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1120,6 +1120,10 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> +int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
> +{

nit: return 'not supported' for now or something similar?


