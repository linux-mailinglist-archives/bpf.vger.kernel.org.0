Return-Path: <bpf+bounces-47075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF0F9F3ED3
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 01:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A8188788A
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 00:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD77CF9FE;
	Tue, 17 Dec 2024 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyqhEjMo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888B1B960;
	Tue, 17 Dec 2024 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395709; cv=none; b=q4VAj6T4z7b0VyY/qC0xjwcIqKsh5MPwz253FIyYfCiZOql5V8n/97oTIm5LHOrCFv1dBxEjfSI29NsUv6+cyQQEIE0HBpgqRO6JGUcZI6vfy51Aptp0II7X6Ca0zRirULUmrvWdezRR7bnmn6sy7tJAbnlOKliwHigwM1Dt++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395709; c=relaxed/simple;
	bh=nzV6TjDFSBjutRgntlrNn4irfm3ffqlGprhmats+x4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi/velEU8Z6fNtFQ55quFHaZ+iGoOrzqU7RJxU3kLa3nJpQ5aYckJQOqDwM4ofAGMkmHrDLUkhCtObBSXxeQO+iY2Cir0+dZqYBLkE6U6UpFrdAa9/uAhLzdJqKQYu+CFKIpZaWi5dP4aBNZR2vpZuDyWPdp/SJorHVOx4M14do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyqhEjMo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361e82e3c3so6463385e9.0;
        Mon, 16 Dec 2024 16:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734395706; x=1735000506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGevOgBhWZKJ0GVhF1SPi9w+aHO2yKpIaCvBZOXrsuI=;
        b=JyqhEjMoxpjkWLDJy2pls3+YefJi58/1HyiwKgUhV23c50RrEzsu8dKP6wn+UGWaH3
         owFRJ2XzosyrWPUpHWKYnYYlV62fXmMrDbVP4UC2s2xJ2y2FDwDe8DEqa2McmmgdTJ74
         ZYS4w6Y8u23qq8R0mEYiySYaTGzuXUXLTepg3jPqK+XY06bZvvVbuSs0piO1+eoMqMcJ
         D1isUU0JcWawk+tMF+8WrZcDMYlUJDSIFLEY+Dzu0jIZsXZ2ywK03v5MsM/XxmZe+Uvh
         NmPZ25H0KBia7f/lOjDs5vN+sPRK5EG3vGDLGQQ3eHIN4SDi7LS7/bUjt2RmYgfMijrr
         ap8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734395706; x=1735000506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGevOgBhWZKJ0GVhF1SPi9w+aHO2yKpIaCvBZOXrsuI=;
        b=MKvCNGpmCG0A1CVr9chI2NvHfL9rCvrvOSJr1gbbtAOrKpvZKUT9AaSabx38Lo0anR
         JuKpMiop7gnApar7m9vvvYc4MS0VvQvk8s1py7N5YUlIuVUVKY/Q1Zx3TYcjOrciYjY9
         Jbd0ikztK5h036xXiQB5y4N821V72ElkX4AhzEamgstMbOU6osbmctHPn+XWO7dF4AxM
         9H3qgYuABltFoZ38xW3E5ET+vD7jBC7ookoNJoY+qYggSUfN1hOfSuZ89Dy6ve0oWAfn
         9Ix4A5lBIAatkkaEBwLrj4gSjhBw7vzGkHpzeRHAyH1F1qLjCr2XzyjSaDNqUjoy4mm1
         92MA==
X-Forwarded-Encrypted: i=1; AJvYcCUMQdRlElgdnTIMQl9hK9rwQ4BVp7OxyIztxFVBQjL6+eBPWJ3KD7N+TsLMD+hQLEjqN60691y6EnPJ0geU@vger.kernel.org, AJvYcCUPX6wR/Dyc1DV8UXloNIG+pPjl6uLQeqfj/CbipjUrmAA20KVShkMmbN2EVCDMhY35fy70M/An@vger.kernel.org, AJvYcCX2FHoT3n5knLmZUOuVq4Cxs4XHC6cT/UOcwCOltnmT94cHA/9qgrmlBaGuc5NFcVhzuvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXp+xDoidAXr11US5uLSwaDxvIkQJj7BqmjsjABasPQnx12zV
	FPp4CZ3ypSOPirV096253+4qt7q8Whl6w8K2AzRJ5WRPrnR+keT1
X-Gm-Gg: ASbGncshJqQ/7DoljEAq10tdIaFKkC3XQlB2Nj0rJhdsfqXUA5zmmsEavVuVJQo7oAY
	+9G6aNxg0hy1OxHIHWkmYK3AFdcInkHTX2Uq+7feNJ0snD+C1O9THyt8FyLTFyMiR1O4xNEEUs1
	euPSiDqZyNw5nxINPOtbgNNioPiqxCc5fkU7HO/gNcJLntHeIZHRjnq1lW3JqpbrfjOeiEKN+ZE
	Em6PJSyFW6XBhBx0xMwPC5+kEzEiOKZBRCAIwStM0k/
X-Google-Smtp-Source: AGHT+IHugxZXWJBSpUs2r7E1lOtK0oUnw2iWlt5HBlZMmw0+kMHWyErJBeAT4hYbtRUUDFrGnAehWg==
X-Received: by 2002:a5d:5f4b:0:b0:382:41ad:d8e1 with SMTP id ffacd0b85a97d-3888e0b6691mr4012198f8f.14.1734395705528;
        Mon, 16 Dec 2024 16:35:05 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801a349sm9607246f8f.46.2024.12.16.16.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 16:35:04 -0800 (PST)
Date: Tue, 17 Dec 2024 02:35:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 8/9] igc: Add support to get MAC Merge data via
 ethtool
Message-ID: <20241217003501.ar3nk6utdjllqjbk@skbuf>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-9-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-9-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216064720.931522-9-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-9-faizal.abdul.rahim@linux.intel.com>

On Mon, Dec 16, 2024 at 01:47:19AM -0500, Faizal Rahim wrote:
> Implement "ethtool --show-mm" callback for IGC.
> 
> Tested with command:
> $ ethtool --show-mm enp1s0.
>   MAC Merge layer state for enp1s0:
>   pMAC enabled: on
>   TX enabled: on
>   TX active: on
>   TX minimum fragment size: 252
>   RX minimum fragment size: 252

I'm going to ask "why so high?" and then I'm going to answer that I
suspect this is a positive feedback loop created by openlldp, because of
the driver incorrectly reporting:

- 60 as 68, ..., 252 as 260, and openlldp always (correctly) rounding up
  these non-standard values to the closest upper multiple of an
  addFragSize, which is all that can be advertised over LLDP
- on RX what was configured on TX (see below), which in turn makes the
  link partner again want to readjust (increase) its TX, to satisfy the
  new RX requirement

But I'm open to hearing the correct answer, coming from you :)

>   Verify enabled: on
>   Verify time: 128
>   Max verify time: 128
>   Verification status: SUCCEEDED
> 
> Verified that the fields value are retrieved correctly.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 7cde0e5a7320..16aa6e4e1727 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -1782,6 +1782,25 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static int igc_ethtool_get_mm(struct net_device *netdev,
> +			      struct ethtool_mm_state *cmd)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	struct fpe_t *fpe = &adapter->fpe;
> +
> +	cmd->tx_min_frag_size = fpe->tx_min_frag_size;
> +	cmd->rx_min_frag_size = fpe->tx_min_frag_size;

This is most likely a mistake. rx_min_frag_size means what is the
smallest fragment size that the i225 can receive. Whereas tx_min_frag_size
means what minimum fragment size it is configured to transmit (based,
among others, on the link partner's minimum RX requirements).
To say that the i225's minimum RX fragment size depends on how small it
was configured to transmit seems wrong. I would expect a constant, or if
this is correct, an explanation. TI treats rx_min_frag_size != ETH_ZLEN
as errata.

> +	cmd->pmac_enabled = fpe->pmac_enabled;
> +	cmd->verify_enabled = fpe->verify_enabled;
> +	cmd->verify_time = fpe->verify_time;
> +	cmd->tx_active = igc_fpe_is_tx_preempt_allowed(&adapter->fpe);
> +	cmd->tx_enabled = fpe->tx_enabled;
> +	cmd->verify_status = igc_fpe_get_verify_status(&adapter->fpe);
> +	cmd->max_verify_time = MAX_VERIFY_TIME;
> +
> +	return 0;
> +}

