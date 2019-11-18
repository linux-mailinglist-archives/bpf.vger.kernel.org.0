Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F152100F4C
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 00:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKRXKR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 18:10:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45905 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfKRXKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 18:10:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id v8so15254754lfa.12
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 15:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=9xM0e/QS2uYriiw7OeCGNLzIbJDBwuc4Tb1vFYaZiH4=;
        b=1DVgpVmmAd383T/jQHrR0BxPF68Nm3W1GWG4Kaa9f6gNYNrmOmQS0mM6W4xz0hOpQn
         71rA2EuMUcnR/yLFK767HrnE25xvDV2mfANXvl0mw7GnzZ7+HF6cpiceMyF8FfW2OoFo
         bbhi3S1EHAs1QUNEyR9kSUq0v3zkbKL3n/+rJiElQwgU2jciFMd8VHrGzo3iCU/YPu9B
         riO2in9+Y1yGnhLajBKCIVv+LTnXkfaj0XnJf6tjOVnNXN5T55LNiQ3SfU/NTWRO5IqB
         B0Wv3ILQ4smgi2MeuWWXkUmxsUorXN0114tLAEY85dMiWPsdP96rtvf5NwKs4jTJuQRo
         MhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9xM0e/QS2uYriiw7OeCGNLzIbJDBwuc4Tb1vFYaZiH4=;
        b=Kv8q6FeyVTI2Xhgw2Ixagk9jm6SlMX5T8DaBS48uAZc6melXV1mJMqHKCkWSdnbfYk
         0LFC4CeH7lHon4X+HTlLg2/1XZZOqDTYRwyQRLA5jjK0tp8z33Olg5i7jMrEbmLvjfkY
         xOtSdt0GgVlUTo5bdCiXarmrQfZioPK5WsucReGEQcQHAOrn3i5McIEioIhu91dp/4zt
         LVOvWCJI6DbKYDKPgW8wkoe+hUdq8G1m0Oixd3aBi4h6LCnTZ5b0yGlKkJH2cUfWnVrz
         ffQw+ApwsBiar8N+K/RIZzNmYqpSWFMYBF4gFds3btTL8arHq6Mn+x7vGTfMY7XXtz+h
         kLTw==
X-Gm-Message-State: APjAAAXapdxnoOQeYcqk0+ugF8JxwLx/BjetM7f6NbDNXEpyU8z6QfvS
        2Xxwf8qAmF6BsCrj1xViqrl7wg==
X-Google-Smtp-Source: APXvYqys97VIwVdC/Te8MUKOMPRyq5Se3PRs9z5zUJGdj4Ucja5C0Czotjee0dObMUZEjpAZGwHC2A==
X-Received: by 2002:a19:5509:: with SMTP id n9mr1251891lfe.27.1574118614768;
        Mon, 18 Nov 2019 15:10:14 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o10sm4244600lfn.64.2019.11.18.15.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 15:10:14 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:10:01 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com,
        jonathan.lemon@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, rizzo@iet.unipi.it
Subject: Re: [PATCH] net-af_xdp: use correct number of channels from ethtool
Message-ID: <20191118151001.2f5cdcc5@cakuba.netronome.com>
In-Reply-To: <20191118225523.41697-1-lrizzo@google.com>
References: <20191118225523.41697-1-lrizzo@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 18 Nov 2019 14:55:23 -0800, Luigi Rizzo wrote:
> Drivers use different fields to report the number of channels, so take
> the maximum of all fields (rx, tx, other, combined) when determining the
> size of the xsk map. The current code used only 'combined' which was set
> to 0 in some drivers e.g. mlx4.
> 
> Tested: compiled and run xdpsock -q 3 -r -S on mlx4
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

thanks, this seems mostly correct

> diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
> index 74d84f36a5b24..8e12269428d08 100644
> --- a/tools/lib/bpf/xsk.c
> +++ b/tools/lib/bpf/xsk.c
> @@ -412,6 +412,11 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
>  	return 0;
>  }
>  
> +static inline int max_i(int a, int b)
> +{
> +	return a > b ? a : b;
> +}

There's already a max in tools/lib/bpf/libbpf_internal.h, could you
possible just use that?

>  static int xsk_get_max_queues(struct xsk_socket *xsk)
>  {
>  	struct ethtool_channels channels = { .cmd = ETHTOOL_GCHANNELS };
> @@ -431,13 +436,18 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
>  		goto out;
>  	}
>  
> -	if (err || channels.max_combined == 0)
> +	if (err) {
>  		/* If the device says it has no channels, then all traffic
>  		 * is sent to a single stream, so max queues = 1.
>  		 */
>  		ret = 1;
> -	else
> -		ret = channels.max_combined;
> +	} else {
> +		/* Take the max of rx, tx, other, combined. Drivers return
> +		 * the number of channels in different ways.
> +		 */
> +		ret = max_i(max_i(channels.max_rx, channels.max_tx),
> +			      max_i(channels.max_other, channels.max_combined));

The continuation line should be aligned to the opening bracket.

I don't think we need to care about other, other is for non-traffic
interrupts.

> +	}
>  
>  out:
>  	close(fd);

