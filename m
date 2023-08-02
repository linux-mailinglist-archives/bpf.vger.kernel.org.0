Return-Path: <bpf+bounces-6735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2C76D5EA
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BA7281DFE
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35922100D3;
	Wed,  2 Aug 2023 17:47:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E12100C4;
	Wed,  2 Aug 2023 17:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D2CC433C8;
	Wed,  2 Aug 2023 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690998463;
	bh=kV9NfAwEiyRC6suvZbE0jpxaoqklhAtkhU0iiN3U7S8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CEMIiX+wwTlL3uCSxU1l8G9VXsCpuXq8hyDVlZnhhkIKz2JpIuLqaD+0nV4bvVADc
	 oyqtT5QFdccdh4r2tYLzDXQ6BIhdgN3WXFdgIpknr6ZI1WaEhtml/Gynui9cOMJpYt
	 a3rbdk+xoiCYZIjshBxYaNUiS94JxcL9q/RBRBTvnbA5h8iEbTA/qyaAkBZdR6gQzi
	 J6UFH9WyBs3GhIuxBXFZ0JRpMO3Hsbv/qyMvPMgRMl2ifks8RxPOpl2Mko5cSLYN8S
	 G6EtfS9M0PHlLKRisHamCUTkIT+oZJ/BpHZpDzidJLwZCvI1ZVDHFgF1YOJv/vviDz
	 fdW9PpIf/0XSg==
Date: Wed, 2 Aug 2023 10:47:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, larysa.zaremba@intel.com, linux-imx@nxp.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V4 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230802104742.2f129238@kernel.org>
In-Reply-To: <20230802024857.3153756-1-wei.fang@nxp.com>
References: <20230802024857.3153756-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Aug 2023 10:48:57 +0800 Wei Fang wrote:
> The XDP_TX feature is not supported before, and all the frames
> which are deemed to do XDP_TX action actually do the XDP_DROP
> action. So this patch adds the XDP_TX support to FEC driver.
> 
> I tested the performance of XDP_TX feature in XDP_DRV and XDP_SKB
> modes on i.MX8MM-EVK and i.MX8MP-EVK platforms respectively, and
> the test steps and results are as follows.

There were changes requested on v3, so marking it as
pw-bot: changes-requested

