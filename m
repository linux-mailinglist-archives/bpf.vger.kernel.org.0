Return-Path: <bpf+bounces-29094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A2C8C016D
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C8B284E8E
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9290412836A;
	Wed,  8 May 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FhhOMORT"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A21A2C05
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183481; cv=none; b=K2ugBOGaYyzARgxXf5imOd2CD2pL8lq+3ZY8wOrQxAtAYTgS/FKWbsvhxPBwPID5lVHZNFsl2QRaQN54kSDRsdU8nal4xPTRW4eCUmFbSrxPn4pH6e1QNxvu+PvHS4Am9JAg3C/D1wNFKOBvLkTkh2marTC7MuFEuBwj2ShopCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183481; c=relaxed/simple;
	bh=UYSHQAgfNOwt43bZEOV0JwHid6xZIa0OIU6/MOWb4is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQ+XXJOPhur870qrmkL2J19nruKTKG4IFuXjvoCMywzcO7TyaD0cVRQW/1MT4it8sqWde3GuKkkzckKuHIewuCbg26HbDJAwrf0Bk8V1p2lxcM1LQslLtudSQKfxzbXAlHm8CFYc8a1fVf4JS5TVCLKaANpAIFJIhsZoxd0lqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FhhOMORT; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d4afc53-d8fd-4dde-8066-4d0347ca3a86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715183477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ysT1py3uI2eIRktTv8kqlBoosvxgbCWuQRL73aY8WY=;
	b=FhhOMORTZzJTkwNY9umYtFlB8+GnVJ0U610MS0lAZRIFMIfqxkVpR+NYZUG5vY4Jrn31i2
	tnCLC5QcVjJ/IMkFJyefK1px4yZvMOo9PhWg2LB/XSm2fE9tUiQOCRJILS+/6fIbPMadAZ
	DNkAntBJdyBpv+2nZ7jlR2+3YViq/l4=
Date: Wed, 8 May 2024 08:51:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: guard BPF_NO_PRESERVE_ACCESS_INDEX in
 skb_pkt_end.c
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com,
 Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20240508110332.17332-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240508110332.17332-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/8/24 4:03 AM, Jose E. Marchesi wrote:
> This little patch is a follow-up to:
> https://lore.kernel.org/bpf/20240507095011.15867-1-jose.marchesi@oracle.com/T/#u
>
> The temporary workaround of passing -DBPF_NO_PRESERVE_ACCESS_INDEX
> when building with GCC triggers a redefinition preprocessor error when
> building progs/skb_pkt_end.c.  This patch adds a guard to avoid
> redefinition.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


