Return-Path: <bpf+bounces-7040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2D7709F0
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E501C20D42
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1C71DA2E;
	Fri,  4 Aug 2023 20:42:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710381DA21;
	Fri,  4 Aug 2023 20:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCC3C433C8;
	Fri,  4 Aug 2023 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691181766;
	bh=h38XqAf/cJuAIlpBpr4KFvmbr9bN/47iqdte68UwsFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eir7av81r/doV7BE+4HwQFpwwtTYplldGx/4AWT4vOhTRbOI0yFoD3TvFECqE86Qr
	 22pjN3cW2OUBfeeaTUSGfG6R+aebkt4+TpCYUGq2ahP2c7L2yw+ANcRUVTE1Lbh2G+
	 fRW2lTYdPFJekqGBV/z3r2MQsT5ni690118tow1ghkzYie2sXMTP1f+Z+CROaqMHkv
	 mr4nXnYSHdxlNDqgsrM2gJ/rD5Q0y54IGvXsVGC4N1YV3SBeRV//7qUKTz50NUBN66
	 UkX6ithIAj+PzhLVKUEniqcQoqNRgtH2DnINfoI+2NdAPa9v9VoaUpTqv1eZLUF6pn
	 7khrR6hFrEXtA==
Date: Fri, 4 Aug 2023 22:42:41 +0200
From: Simon Horman <horms@kernel.org>
To: "huangjie.albert" <huangjie.albert@bytedance.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 02/10] xsk: add
 dma_check_skip for  skipping dma check
Message-ID: <ZM1iwWnQ+derTtfS@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-3-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-3-huangjie.albert@bytedance.com>

On Thu, Aug 03, 2023 at 10:04:28PM +0800, huangjie.albert wrote:
> for the virtual net device such as veth, there is
> no need to do dma check if we support zero copy.
> 
> add this flag after unaligned. beacause there are 4 bytes hole

nit: beacause there are 4 bytes hole
  -> Because there is a 4 byte hole.

