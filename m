Return-Path: <bpf+bounces-69241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC73B92215
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC263B3EAB
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10C310768;
	Mon, 22 Sep 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBuq0FFI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D82E36F1
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557215; cv=none; b=oDY1i9H7i5FgRfDgjbBR0QUF4PCA7zsoccXlznPtsDIgjLb+uVK4p09dL4+48x+bapP9ZW/tra+eTI0rrBHVLOWQvqe2RVQJwq6Gi/huvkH16p7Q6KwAohy55+W+zN346baf9LAXCmhHv/j3Tz7AWzu7Mi5/A7bkf7dG+NWw5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557215; c=relaxed/simple;
	bh=3Ubh+Ltrg5bTipTfPS+WcJFx3UuztPB8Qcf+YIECBe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXGin417jja7bsrmHuRydsFfIEo4q7xmb/GFJEmDJQ1mlqTWDiU/FCPVYNISmPX1DIBJm637MoxcOx+kr0DN+ensmC0S2W2l9Fap7+fMYga93nArb3/zsYomAV6fHqPCYqKbhW0QpjnEm2xDvnKQ5af/QWoi99bGDKUHv7G2yTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBuq0FFI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f1f8a114bso1459619b3a.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758557213; x=1759162013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xsq/S5eo1/dC1z71IpbYUCzGRErRKR/1pP9hHqx+ZKM=;
        b=TBuq0FFIKgJoPIwEr5IOZTCvSl8ATKbUS85+5qmFCb7odNDahiJMmose8xs/rKP31Z
         1MhYhThroi3F96s8VIBZahscYhsuDSwmY/iRv4NSnqHZq8O0bdIS8V21NMgZyy/uRbFY
         QWtEUNyDxmRycNnw/5Blkpd8RU2NF7gIhK96eLSQlIEkWJDL0JSE1PRiEtaVMpbk7FNt
         4jG3ah8Trl+8m8bc3In25pghftxlWxhChc/7Pik2NjK8GHKxTCK/O1DfaYNWxxZCf9Qb
         Qx3DSgQG7iAXRqJnUqcDf57wxlO7tBjpiyUuL1H7Iojsh/Xzkw/EYFfHux+kIYm/xl/p
         z/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557213; x=1759162013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsq/S5eo1/dC1z71IpbYUCzGRErRKR/1pP9hHqx+ZKM=;
        b=lEqsIHxYEXjSzbfJMd925ZbekmI6sXH7f7UOvbuQf9LTWZeTQk3Aa2wCi5wMzmNEQL
         LOj9OL8KhCFAdiER68CM+g7IE0GcILGN/SrZxzbz6oJLO05RkBoHOEMZCGcnybSc3eQi
         HZjc3dTqvLvUjoQV3y5Q7kAWh48O3dK9UhFQOh6ZEi4sLff+X4O92YIJ1uNLBDAnQYz4
         etJNrEmRwMbEVU7RaPUNas2RhxFp1yZlJTU8aYOfw2tcwzEdTZ5+0iTIbP46PWyIEu4A
         4hL2dV1DO5rdxsFVwlvsxhaTcNGLDbrKJwdDhzR7DqFoJTaxPSNNCU8tts3MgY4V1cqD
         cEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXluxAAYfnzJNSGknncaHziHDWfg3gBBl6TGDr7A7dawSRKi/45zZdgoDGI0CfxkEFpW2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOce4lF4BaE2aI/96/CnEv3ymIoRhEGFtaf+s46aUObZyPadqj
	78aHAcHFe6WPwoIOoQtYtQd7H/aw0+dnSvsKdXfZEqmIfNYI5/1W6pc=
X-Gm-Gg: ASbGnctSESabJ2zU7/JhWWk5i12DOf0I33bWfT128Vz3enxStjYJqqreYVK5XJZ2ydm
	LEZr0oYzBivVAXpV9i3FwTAucG9FPGYtH6LHxRa+2dIilQeB4JxQrPFTgOqKeAfW/FPclA9fmvv
	OPU6T3xZK47QIRXOU+JAoLGvJYVUopvO8iRw9RmMWQ6p43h7PF4AjNmUMp6A9+K0kGdskrh5nGS
	RNYMwZz8OXUQw3Hd2qBnGdbLR0uCHOgfhHchVvO0IogMooxAJJf7wwi27NtJ5sa9DVrQM2pE5N5
	UxX5mp3KtfujQdYeXyWtQPhrfoQCrRALyIp313pPBMipRPcrxiu0/VT4+iNZmoIN3aqvJCn2wqH
	+xnlRD+5YxQRupddlceuhJO80DqGfKcNlU2NfwBxrkkSn6WaBA2SEvpFw3BWFPKMrpGZKoE+E2z
	0E8r5nq7Q1ee8njjuSUDfl5mNgABgmki8Z+MUU2HnpVz72klxekSGUam/zgxRaw3v7PcNnhNcdn
	q67
X-Google-Smtp-Source: AGHT+IFCO135Y8R4+/omcz/1dIBtNBJbJWcxcTpYOFxbAjmZK4OznS1qy6MqgmMYpyy9B1wRIoGbLw==
X-Received: by 2002:a05:6a21:6d85:b0:263:375b:885e with SMTP id adf61e73a8af0-2921c724b6emr17341980637.26.1758557212819;
        Mon, 22 Sep 2025 09:06:52 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77f3a9f6e88sm3376655b3a.10.2025.09.22.09.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:06:52 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:06:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 05/20] net, ynl: Implement
 netdev_nl_bind_queue_doit
Message-ID: <aNF0G6UyjYCJIEO5@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-6-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-6-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Implement netdev_nl_bind_queue_doit() that creates a mapped rxq in a
> virtual netdev and then binds it to a real rxq in a physical netdev
> by setting the peer pointer in netdev_rx_queue.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  net/core/netdev-genl.c | 117 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b0aea27bf84e..ed0ce3dbfc6f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1122,6 +1122,123 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> +	u32 src_ifidx, src_qid, dst_ifidx, dst_qid;
> +	struct netdev_rx_queue *src_rxq, *dst_rxq;
> +	struct net_device *src_dev, *dst_dev;
> +	struct netdev_nl_sock *priv;
> +	struct sk_buff *rsp;
> +	int err = 0;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_DST_IFINDEX))
> +		return -EINVAL;
> +
> +	src_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX]);
> +	src_qid = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID]);
> +	dst_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_DST_IFINDEX]);
> +	if (dst_ifidx == src_ifidx) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination driver cannot be same as source driver");
> +		return -EOPNOTSUPP;
> +	}
> +

[..]

> +	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);

Why do you need genl_sk_priv_get and mutex_lock?

