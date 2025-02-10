Return-Path: <bpf+bounces-51027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE407A2F5C5
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF3618830E3
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA989243945;
	Mon, 10 Feb 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idL8J8HS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531825B66E;
	Mon, 10 Feb 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209758; cv=none; b=G1x1o0NGnZGz0pVpy1UqTaBo/RrDcPuSCer9EgB57B4CM/BX+jUldh1MVOmx4b2ZtPPLn8MtVek5CPAQvcnbP5+uTYcIfns8UwH1sWQYhASVOKmjAooUooJXLw6HJF6Kn7BtG9imsxENhhpnh+KmgAOEVXL0dV5xPfN9h7sL7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209758; c=relaxed/simple;
	bh=sf3+hamH12xc0FshkmkYt8PucfXSBNKQ0p1oax2RSGs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJn33EvHgU+2WvbswJ+U6FjQvTp2JfV8ScRufXfn3DEpJHz+O7IjhzlFbLyJGmu/P6SvzuTijXMOBZ2TlQatxD967Mgj24BShaS4TnWaPJt0JKKMjHJt9MYuDyhC/dqVZ73LoFjc5SJl/MlXYI46X7vXzDn3HGBWcwOnGfY39GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idL8J8HS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dc1dfd9f2so3048572f8f.3;
        Mon, 10 Feb 2025 09:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209755; x=1739814555; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJNDJ3NguU/eYBT9ZFeshvkzjHdrLe1geJc1GHLeeJA=;
        b=idL8J8HSp0dzyJpTBYQmAspNE9C2bPSTZ59AWoe22tMMCLnTzix4NVsWfm1BbMpzP3
         ddPrJIoUZ+mDZz8/EUx3W3FKcmHZnj940/EPM2w1GQLc7Lw6sYvS/FTx5M+6e4mBnQwj
         vP5A0E8Df+1oDq/XyooSdbT/75MUt02lIjnhOTnXLNQjXkP3B813/WgHHOwTOplMBPS3
         UqpG8g5MhNMUzxiURHND4nRh52rjZdkRZAAyKCnID9oUD8RpvxfvGSJLMB/w2J2xR/e1
         N/+BHJRKOHsEecn9fZJgQ29NqbhVeiNuKEqWWUpXcTtiksGdTFTe5r0mDkMhI0YcA6an
         5PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209755; x=1739814555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJNDJ3NguU/eYBT9ZFeshvkzjHdrLe1geJc1GHLeeJA=;
        b=K0s41iSNooCRpNWS3Jixm7Ggp3bE8Zz48QzriXNb0FJrZy4AzGQKne6VB6nrl3hxrA
         QW6zHk96temeEybE8ugDGA1fItUXZWtwhCv1gOzrVTm2OfKrDfK/bGhVwYXyIqi0C1n4
         aHq8Fz4AAr7+LPD/tu5B5dVjyjVN2UKVHZpEg9cY2pXw/wWjePG7HhcAWVpZi/sxCfY5
         iKLoqqRdtFeCC8O3eNUKlveTa2s9r9IiaQhwlFwnR6936zhMxKOL/ASrHLaHyTHsVLTf
         h1Z5vEJyNYyERkYoviqgOFODxGfasQpIu/2rCNbwMvIclYQWBld24JsbK4d7HU9qvH68
         ZJmw==
X-Forwarded-Encrypted: i=1; AJvYcCWvtgaiKwSfDAUpeWxdp/fMgRTLgsNAnHDM3rGScy3GnSWntuDKVX8TpL4VsBAOC2URsQc=@vger.kernel.org, AJvYcCXybX7sfGiBsFNNLTIHcm59dgSyX0oLihwHuMdTpArMda0wRM22YCMowURwLNtQNoJe7mZbPurg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+t9VBdaJaKvMyI+vHOjOLeKJweCujxWhC3vdwXuviqUFTt4qR
	Mz2Pm4KhbTN39KtIpIGtCclMTb5vfcg3rs9qopDiBFi/9BDX3brqqZIwJrXP
X-Gm-Gg: ASbGncvdX4xvUUBxulHQ7PF526TkR7qGnCkVbG6kRcVMNZ3UD9pCfxKCZdAfT86F3c0
	YFLzz5aCih5UusTKhEa2AlZrEUL0prkDFZKcfx2Gtb2P5CNWlYAIto8e124zhgH4n66WJQGgVJ4
	6wH0I16S6iQFqsDryFgmj8mpUiJIucCh68MSJe2tcHlx5cPEAFJaJpJ5TFcLdwAM5knM3VAStUu
	DLGaa2vXhRuJapP/tnd3QTDGDELct1FiguBrN4oBsU0KzNUmZcNcagI6hdbZXfjD8o5hvrOP/7H
	dQ==
X-Google-Smtp-Source: AGHT+IEj77Vn1dlKwhjvXoNME3CjdbE3hdyIy+xUDAzhTpw9VpNfFUB+yC80B9wuJKv4RaRhz7txCA==
X-Received: by 2002:a5d:6d85:0:b0:38d:a713:8e4e with SMTP id ffacd0b85a97d-38dc933e2b2mr10840511f8f.47.1739209754822;
        Mon, 10 Feb 2025 09:49:14 -0800 (PST)
Received: from krava ([173.38.220.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43941c09ee8sm47971825e9.37.2025.02.10.09.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:49:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Feb 2025 18:49:12 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v2 bpf] net: Add rx_skb of kfree_skb to
 raw_tp_null_args[].
Message-ID: <Z6o8GKce9xSDlAC2@krava>
References: <20250201030142.62703-1-kuniyu@amazon.com>
 <Z53Xv-okoj3PDT50@krava>
 <CAADnVQJodt1fBaR5d0wTR2pwipJVVdKSd+7_ou_vE-gRMzbT6w@mail.gmail.com>
 <Z59Donij6yuw9hvB@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z59Donij6yuw9hvB@krava>

On Sun, Feb 02, 2025 at 11:06:26AM +0100, Jiri Olsa wrote:
> On Sat, Feb 01, 2025 at 09:15:28AM +0100, Alexei Starovoitov wrote:
> > On Sat, Feb 1, 2025 at 9:13 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > > v2:
> > > >   * Add kfree_skb to raw_tp_null_args[] instead of annotating
> > > >     rx_skb with __nullable
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Jiri, Kumar,
> > how come that we missed it earlier?
> > Is this a new change in the tracepoint?
> 
> must have slipped, sry.. I'll double check tracepoints again

sry for late reply, I was traveling last week

I overlooked tracepoints defined in drivers directly :-\

however there was one recent change adding the null check:
  9ab96b524dce hugetlb: fix NULL pointer dereference in trace_hugetlbfs_alloc_inode

will send update shortly

jirka

