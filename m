Return-Path: <bpf+bounces-63490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19376B07FCE
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6168F189C644
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39362ECD29;
	Wed, 16 Jul 2025 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2DgX48O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76B2ECD09;
	Wed, 16 Jul 2025 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702152; cv=none; b=FGWiBZxyzFhHxpxj9B3119BlkbJkMZ+9PsZcVnQPYwYwI3RitBl60jC4xOF9EkVZKNgDU+R53u0DbC+VGotJIvuB/HI1INEixXdCUxsPpTMoD321w73Q6Eak2OiINKpqjq3Bi/g2p+31FI/Cy2Y1A0+jE+h+S1FvujBp0MOTPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702152; c=relaxed/simple;
	bh=YC3X17Wf+csd/abWzZ5qjcI79F0DUo2/TywSiQuyw4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXDDHp8TlJonOV43i2ZCZaP9T917YXtPnQ0vHSMVLF3HAV1sVwMf/BbTD/iwJguIne/e56ZAeD0/iKwRfp4PDgGjPIhKKXQO0vSQcN8TJMa+GsHfB3fhaACouitR+jRPWL/eVv1pQEfkDt2RkzJ66ysKxxO5XutYwSNgis6Odgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2DgX48O; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235d6de331fso2887875ad.3;
        Wed, 16 Jul 2025 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752702150; x=1753306950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zk8pfJjm8yU++V7Grl8fR5lNUFOH1+ZINWxCMY+UwQ=;
        b=D2DgX48Oq9DgEx8iBTz7PZxkP6UGH2Eyj7W5N8JGudPGOegzqL2hLAKXr0nveCOBTw
         lk07/P3jeZ8nG9eYx+u6cizFE+aOzBHBsP/FjcmmeDj5bWsjf+SC/rOJxPgbvvWyYVPy
         Epsd/c5XoYrXN40kizKL/2NZh+jWmERJnHR1o801XUxOLvn8OBfHzUphptN/G0rpFiVK
         +bas8Kb2nFaePEFgio0JK9DeWA4fzb+o3xHI+6hPPAD8Xw9y9S/Ecub/s73H0WVz3lIS
         wDUxkkaDqvFmohJdtJKx364TvTlVPU7a4XnbU5I+BTb64n3nCbxuu+HQHgjfRzFfdYfz
         6xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752702150; x=1753306950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zk8pfJjm8yU++V7Grl8fR5lNUFOH1+ZINWxCMY+UwQ=;
        b=dXOHOYtE9LtYyRexUuVFmb+sPd7APtyFgjvMbtgvK2NFxABZMHMYSu9uuIpEy1AET7
         rQ9LtaEcNB7LPDrkylNCZhOoEEtatiVPOw9U/LTPAgNzi9jswFSE1qjcbKugD1ysXH6B
         Wm2TNWjN+igYgDTneWLdPfOR1ABo048lgLNpjizTL/jzjogYfMIlqWLy9EC4CChv+BfP
         D943LqEMmyQD5F92VhwTP/kgvezMxCoWCOhd1DzXF1A+EeGBnRhmyC/ygueiAYLFMwV1
         yjdzxPenXuXx2UAG2uJwp7dj+kn0ZWixQR5l/01iZg2xVvxb+/zGGFKxbJ0abtiYXIgp
         FtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuGbFEWs+ndmmS0oOkV8FAlCECU53HzTgJAPv6u0rzKtb+rMIZ1E6n8Le+4MAkbTqey6A=@vger.kernel.org, AJvYcCXRj/5OcXGoBcob0fBT1hYGRlmB7GUT8ZJDoNYK+jZK4jkmxva0yudVsXT70DfviZNTdMoaCXOD@vger.kernel.org
X-Gm-Message-State: AOJu0YyCueDQtm+OjRoqyLH9sRJk76+KdjpqUMwAXC12tRIJTe/mVoNj
	039Is8jmMGoSzl/PNf4+ZfnYf3bGiuUc6/jtsZzIp3BWxPceS7zISxs=
X-Gm-Gg: ASbGnctdCvtOKKybs8M5fE17wYof/aGXEcjjSubmS0l22HYJB+kzWX655mxZa4XMCBu
	SktI6rPRe7N0Pv58U/veHpxPKFLCTfS/HqmIvUHfxOya8hCb6vfgwTefw43mDDyBvB823/rJCq3
	dsxywAG7NCxQWIzsY8Ultujeo3iBRO/TrgpZYs+ELJ8kTM+FLWK5UMwL0Sl9HvQsE7IVQofUhbQ
	/2iAyOGYJh+J/PaPkhpwtg8lKaCq2lq1fYaZvI/lmvRkpqcKrAm7KvaAGoZOxWZUAgXaaTyvMh7
	Sj0iFq2SPaLX1zqi3famuzWipJ6mswl0BdPT+6RZfiM/fXtBgc1sE2zNkfwD6MDuIK/7y3x9tmW
	wH/yR7yG0YegDi9DD1aoRHxBEhJ/L6g96iNiz+zSX7LxVMvvd4AAIzobKvDs=
X-Google-Smtp-Source: AGHT+IFE973SAu58kAdtLmrGz3o8tMHbYIvR6pDDPnSLsjIP0CNR/mjTXFZnzFDqirzKm3wyAKUb+g==
X-Received: by 2002:a17:903:1249:b0:234:bfcb:5c1d with SMTP id d9443c01a7336-23e2576c215mr72034195ad.40.1752702150069;
        Wed, 16 Jul 2025 14:42:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de432278csm134783785ad.121.2025.07.16.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 14:42:29 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:42:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] xsk: skip validating skb list in xmit path
Message-ID: <aHgcxZ64ksR3eeGN@mini-arch>
References: <20250716122725.6088-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716122725.6088-1-kerneljasonxing@gmail.com>

On 07/16, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch only does one thing that removes validate_xmit_skb_list()
> for xsk.
> 
> For xsk, it's not needed to validate and check the skb in
> validate_xmit_skb_list() in copy mode because xsk_build_skb() doesn't
> and doesn't need to prepare those requisites to validate. Xsk is just
> responsible for delivering raw data from userspace to the driver.
> 
> The __dev_direct_xmit was taken out of af_packet in commit 865b03f21162
> ("dev: packet: make packet_direct_xmit a common function"). And a call
> to validate_xmit_skb_list was added in commit 104ba78c9880 ("packet: on
> direct_xmit, limit tso and csum to supported devices") to support TSO.
> Since we don't support tso/vlan offloads in xsk_build_skb, we can remove
> validate_xmit_skb_list for xsk. Skipping numerous checks somehow
> contributes to the transmission especially in the extremely hot path.
> 
> Performance-wise, I used './xdpsock -i enp2s0f0np0 -t  -S -s 64' to verify
> the guess and then measured on the machine with ixgbe driver. It stably
> goes up by 5.48%, which can be seen in the shown below:
> Before:
>  sock0@enp2s0f0np0:0 txonly xdp-skb
>                    pps            pkts           1.00
> rx                 0              0
> tx                 1,187,410      3,513,536
> After:
>  sock0@enp2s0f0np0:0 txonly xdp-skb
>                    pps            pkts           1.00
> rx                 0              0
> tx                 1,252,590      2,459,456
> 
> This patch also removes total ~4% consumption which can be observed
> by perf:
> |--2.97%--validate_xmit_skb
> |          |
> |           --1.76%--netif_skb_features
> |                     |
> |                      --0.65%--skb_network_protocol
> |
> |--1.06%--validate_xmit_xfrm
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> V2
> Link: https://lore.kernel.org/all/20250713025756.24601-1-kerneljasonxing@gmail.com/
> 1. avoid adding a new flag
> 2. add more descriptions from Stan

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

LGTM, but would be nice if Willem or Magnus can chime in to confirm that
it's safe.

