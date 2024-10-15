Return-Path: <bpf+bounces-41957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2560A99DCF8
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B141F22FB9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC21714CD;
	Tue, 15 Oct 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Q3NOsR4y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718F38DE9
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963873; cv=none; b=sCll7DpMbHSroF88MBZejifCmPkDqzu3eS77kQk8btBPm+PjMlr77wB2eS2w1rFtRKdkY+K2rVbXZRlOUMr3vKBcpmm9gBkMc9m3gx+IGeGIuO6V2vAjYBRd0QGnckUnvmaOxLgJMTfZ33cM51uJiJp0nl5A6EDHZjTW9r2xUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963873; c=relaxed/simple;
	bh=tPXJZ6DBR0RbTNq6xSXoIJN5pttnShBOZz60RgiyTEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEIkyQ/E5b35CEt4ZQgO0hmKLPIrtrj4ZXD1HUTVikswrS8o3GfkEuQQnLA+R/vI5Anz/Kpyf70Cu7uXXBP3yFBjBDWJBjRs7MXb2UAmRkqc2z8q30RYKJTuh0BtSlIyp4XXOGc4PvNA5/Dkd+qDlwmdRciCnXzk9lGQ3ubSW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Q3NOsR4y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-207115e3056so39898425ad.2
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728963872; x=1729568672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPS/SalmTp6hHiIGdkF/lInIYP1J29HJmrfUXpyO3Lk=;
        b=Q3NOsR4yyIXtqHp3ReQ+j0ou72kPx7kRN0OMR0qR0vC7wQnc0duMMx9JPRq0cn5EFt
         P/mrKvdwk5ZhkJn/0dZsI6RqIEJJ3JqdXKip6sqNqkWb2B8BKTBnzawWcI2jjCLTeVSV
         dgX6x7H246ZFhy53Y2jzf/HAyBrASLLht59kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728963872; x=1729568672;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPS/SalmTp6hHiIGdkF/lInIYP1J29HJmrfUXpyO3Lk=;
        b=NUOakBT4I1ZwZ3EacZjjnjgiK/o9FIOIVocO2iEK+6envVZ1fzGq0rchF5fQqggIsI
         6310uTsUvRIajQdUI9Uj4faFeTLf3Q8KsGJLkFR6JmmiHuce/PEBoNBHu0Rnh8RjFAp+
         lUZDgxPTY45O7YuTgKeegcOzG7QUuf+kxSRqA1IK/aqC0E97bVmDvk5K+LkF3kzjAKRT
         qaIkL9A2HGebX3uO9MvKQr4UWh+e3UcgJcZyZjHZqhJ9CVwQa+NcfaaWPPkqjz+Dv+NN
         zHeV89PEczQKQ03MrstahbFaUSaGF3I9TbBD6yxsG4c1tON8zzeSTufUa13T67ryODsK
         9PSA==
X-Forwarded-Encrypted: i=1; AJvYcCWKW1QPgWJjRVWIImjM95KMgBAFqz9yLaFSIdCsVCAmKnJtceE5ee+vgVT20ol8Su7+CjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6unsp0o6Sx3UxziDCwwe47fYeVCmq6u4udN2RuC3AklDyMnS
	5jpPwvnJzJHAQFNRQnN9Mc1712eqJAIontAvbeSJfZP2hdwgtyEMNSZCn5ZY9rA=
X-Google-Smtp-Source: AGHT+IGg6hD/+JJd3rH0wFYpKIRy4eosYrxoFe5WCFe2nT/KI2r4xFW8hvdy6hjzYV7PyQUOvHMFVg==
X-Received: by 2002:a17:902:e882:b0:20c:c1bc:2253 with SMTP id d9443c01a7336-20cc1bc5122mr124496535ad.32.1728963871718;
        Mon, 14 Oct 2024 20:44:31 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806c744sm2846525ad.309.2024.10.14.20.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 20:44:31 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:44:28 -0700
From: Joe Damato <jdamato@fastly.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, kurt@linutronix.de,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] igc: Link queues to NAPI instances
Message-ID: <Zw3lHHEuMt_llNt8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	netdev@vger.kernel.org, kurt@linutronix.de,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
References: <20241014213012.187976-1-jdamato@fastly.com>
 <20241014213012.187976-3-jdamato@fastly.com>
 <87ldyqnneq.fsf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldyqnneq.fsf@intel.com>

On Mon, Oct 14, 2024 at 06:51:57PM -0700, Vinicius Costa Gomes wrote:
> Joe Damato <jdamato@fastly.com> writes:

[...]

> > +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> > +			struct napi_struct *napi)
> > +{
> > +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> > +		netif_queue_set_napi(adapter->netdev, q_idx,
> > +				     NETDEV_QUEUE_TYPE_RX, napi);
> > +		netif_queue_set_napi(adapter->netdev, q_idx,
> > +				     NETDEV_QUEUE_TYPE_TX, napi);
> > +	} else {
> > +		if (q_idx < adapter->num_rx_queues) {
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_RX, napi);
> > +		} else {
> > +			q_idx -= adapter->num_rx_queues;
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_TX, napi);
> > +		}
> > +	}
> > +}
> > +
> > +void igc_unset_queue_napi(struct igc_adapter *adapter, int q_idx)
> > +{
> > +	struct net_device *netdev = adapter->netdev;
> > +
> > +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> > +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
> > +				     NULL);
> > +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
> > +				     NULL);
> > +	} else {
> > +		if (q_idx < adapter->num_rx_queues) {
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_RX, NULL);
> > +		} else {
> > +			q_idx -= adapter->num_rx_queues;
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_TX, NULL);
> > +		}
> > +	}
> > +}
> 
> It seems that igc_unset_queue_napi() is igc_set_queue_napi(x, y, NULL),
> so I would suggest either implementing "unset" in terms of "set", or
> using igc_set_queue_napi(x, y, NULL) directly in the "unlink" case (I
> have a slight preference for the second option).

Ah, yes, of course. That is much simpler; I'll go with the second
option for the v3. Thank you for catching that in your review.

Unless any other significant feedback comes in, I'll likely send the
v3 as a PATCH instead of an RFC later this week.

