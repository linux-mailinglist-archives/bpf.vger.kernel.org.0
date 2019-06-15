Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D34470FD
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2019 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFOPmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Jun 2019 11:42:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36855 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfFOPmN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Jun 2019 11:42:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id f21so3297752pgi.3
        for <bpf@vger.kernel.org>; Sat, 15 Jun 2019 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=E+0MPB3I9a6s5D5jezF+LFmb2tl4ibToyP9AXLMOIag=;
        b=NXfaGKFtyw0+mBa8pU6K36dqbbBtA+oFue0XQ0oQnrFbW7yGvyJNOfFELJ2wLjQNkk
         Sp+/VaEAQ19U3f6pkEnB2j74PpxsxZMmNjyNz24X209uqOYLgFs5mjinjeQxbVG7EG7E
         rvylHzfKr7HBxZfXijEZgLF6MamqlSnh6zwb3qcJHUyE7qBjtBOACJXILFeD/s7kVXBE
         6gEuwv16cOPOuCarwMnn4o1HyuRK6Ri29vpgcnISVcmuz0ulfTTW3eoLyAXT5c1wOTxD
         IfvvCz+A3g4nXQ2GeDKpfMi5xxxiLZFO/JdoJUSpmE3QB1Uf1Pg7LoBnVkCyUZRkw69g
         V2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=E+0MPB3I9a6s5D5jezF+LFmb2tl4ibToyP9AXLMOIag=;
        b=LiHdhQD05CEqnyXMx97Dr1KQTRDI/ofwZDDgnSRn74HMwbarx5RmH9bKZ6ECnIRVp+
         LRHXYlIGxiJBnE/bZkZG22TMhkh/G7YpTx3sHSe9m6m1QxfogopmmBzw4ttHlvG4UILL
         6hPlG4WiCqNyrQQwraZ7x2GhKx7wb0FCJ85eqajbmsHIBh0KCGwoGdMd63ziGyOe3ddi
         AL8iqAdFFTM0Qvfks4ysz24sW4sqwOzzzXuJPdA2fCTHNR76yOheosAdDMMz23Ds6qea
         GbYaNFENcDEu5ZyEeZBBLEA7TOPpwvk+PQ5HxHIWja+oUc7VD1TCHrUt2h2LrzjsV+S+
         VBbQ==
X-Gm-Message-State: APjAAAUwUxRqgUKcyRuGDDpeYs9R+FVe0VrT1zfE4DyEOhscSLDwQWV9
        skaNHeHdqYWPNwm1ldFkoLew3g==
X-Google-Smtp-Source: APXvYqyL5kKuZOKeiSyb+LPg6wgIgucH375Zp97mBdJVED4Keg/3XzJGXmM/rO84YSCOteqvgHuDQw==
X-Received: by 2002:a65:5344:: with SMTP id w4mr40733913pgr.8.1560613332717;
        Sat, 15 Jun 2019 08:42:12 -0700 (PDT)
Received: from cakuba.netronome.com (c-71-204-185-212.hsd1.ca.comcast.net. [71.204.185.212])
        by smtp.gmail.com with ESMTPSA id j23sm6298281pff.90.2019.06.15.08.42.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 08:42:12 -0700 (PDT)
Date:   Sat, 15 Jun 2019 08:42:08 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maxim Mikityanskiy <maximmi@mellanox.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jonathan Lemon <bsd@fb.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>
Subject: Re: [PATCH bpf-next v4 17/17] net/mlx5e: Add XSK zero-copy support
Message-ID: <20190615084208.1a9fc711@cakuba.netronome.com>
In-Reply-To: <20190612155605.22450-18-maximmi@mellanox.com>
References: <20190612155605.22450-1-maximmi@mellanox.com>
        <20190612155605.22450-18-maximmi@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 12 Jun 2019 15:57:09 +0000, Maxim Mikityanskiy wrote:
> @@ -390,6 +391,12 @@ void mlx5e_ethtool_get_channels(struct mlx5e_priv *priv,
>  {
>  	ch->max_combined   = mlx5e_get_netdev_max_channels(priv->netdev);
>  	ch->combined_count = priv->channels.params.num_channels;
> +
> +	/* XSK RQs */
> +	ch->max_rx         = ch->max_combined;
> +	/* rx_count shows the number of XSK RQs up to the highest active one. */
> +	ch->rx_count       = mlx5e_xsk_first_unused_channel(&priv->channels.params,
> +							    &priv->xsk);
>  }

Ah, Maciej pointed out to me this is why you want the patch 7 to do
what it does.  This count is for stack's queues.

Nacked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

