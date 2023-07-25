Return-Path: <bpf+bounces-5799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1C97609DF
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 07:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE052817D0
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 05:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900628C1F;
	Tue, 25 Jul 2023 05:54:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0AA848C;
	Tue, 25 Jul 2023 05:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B69C433C8;
	Tue, 25 Jul 2023 05:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690264479;
	bh=aOySNSCJEoaRaJl24Sk+OTpPeYecm1osaIYiLeFOqSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRx0OBU1SEI1SJ4LSmLkEPob1QuK5WFkuUqdVeYph9ed/UsG2IwyOFk7Kxeh+D7xA
	 LawFmu2khRnM9557VkZ83V2GFmQQu/DXj2xET+YiR4qIOIVkir7lORnqdQBDi+c/4c
	 m40Effm/hR8qO96KDgp7YURxsFrLShrUciFeYS6BMeTQUrr0SSDHg+EhkBPdwoEDsq
	 VgSHNlvNLX1Qem3CDFHb5fCdKlTQlOVlNtWuP6iteR1YMcSBbbTBFrhUb36StgyciG
	 2b04uwx98ow9qLqZYrVsbQQcAz2E4cao6cEXLDuGqzOIQqqGSSx2IgOkRBTv/jVN7E
	 YWW79NAqNUNbw==
Date: Tue, 25 Jul 2023 08:54:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, ast@kernel.org, martin.lau@kernel.org,
	yhs@fb.com, void@manifault.com, andrii@kernel.org,
	houtao1@huawei.com, inwardvessel@gmail.com, kuniyu@amazon.com,
	songliubraving@fb.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Message-ID: <20230725055434.GM11388@unreal>
References: <20230725023330.422856-1-linma@zju.edu.cn>
 <20230725044409.GF11388@unreal>
 <15dc24fc.e7c38.1898b81ac08.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15dc24fc.e7c38.1898b81ac08.Coremail.linma@zju.edu.cn>

On Tue, Jul 25, 2023 at 01:24:38PM +0800, Lin Ma wrote:
> Hello Leon,
> 
> > 
> > Jakub, it seems like Lin adds this check to all nla_for_each_nested() loops.
> > IMHO, the better change will be to change nla_for_each_nested() skip empty/not valid NLAs.
> > 
> > Thanks
> 
> I guess you just get these fixes misunderstood. I do not add the nla_len check
> to  **all nla_for_each_nested** :(. I only add checks to those who do not access 
> the attributes without verifying the length, which is buggy.
> 
> The others, either do a similar nla_len check already or just do nla_validate
> somewhere else. That is to say, they **validate** the relevant attributes.
> 
> In short, nla_for_each_nested is just a loop macro that iterates the nlattrs,
> like nla_for_each macro. It is weird for them to do nlattr validation as there
> could have already been a call to nla_validate to ensure those attributes are
> correct. That is, for those who do not, a simple nla_len check is the simplest
> and most efficient choice.

My concern is related to maintainability in long run. Your check adds
another layer of cabal knowledge which will be copied/pasted in other
places.

Thanks

> 
> Regards
> Lin

