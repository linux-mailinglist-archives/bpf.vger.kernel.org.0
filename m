Return-Path: <bpf+bounces-12697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C105B7CFBC9
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA25B20DCA
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035529CF6;
	Thu, 19 Oct 2023 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc74ML9w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30EE29CE9;
	Thu, 19 Oct 2023 13:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BBDC433CA;
	Thu, 19 Oct 2023 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697723768;
	bh=yZ/ARB3p2Ke8tobvsFJ9flTddNYrmRG++q6KJRo0w3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tc74ML9w33RHuzPXDk4Y/0aY9YgCu4WG2S+FQ6bNMA5UdG3O8Mb3PgIAQ7Tc+a3Q/
	 0ZL5nTecGbR8+xaaPo4O/FiCJVYmgI27BJ2lgquzmTQQR8JgyS6Ymj2IdCbyK9IBPa
	 81/sPnuoj7QsXhkHW822S2PbJMLzH+gRvjtTwQVioEcS8HoIf3/WRbPUSwffmZoMJK
	 LOonxjQLVsqd2n+87kEzJst2h5dF/St27OteDkkSqAhF0cccL+nCBW9uWW9aVyLH/f
	 tP04RxZbcGQo0ecHgE6XeIWOsl0kPN+3eczB7zs8or/sOJU2U098PDuONOzIaHv81/
	 v9ZzTgUYDBw9Q==
Date: Thu, 19 Oct 2023 06:56:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, Alexander Duyck
 <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related
 API
Message-ID: <20231019065606.525309a6@kernel.org>
In-Reply-To: <fd8a3e6d-579f-666d-7674-67732e250978@huawei.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
	<20231016182725.6aa5544f@kernel.org>
	<2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
	<20231017081303.769e4fbe@kernel.org>
	<67f2af29-59b8-a9e2-1c31-c9a625e4c4b3@huawei.com>
	<20231018083516.60f64c1a@kernel.org>
	<fd8a3e6d-579f-666d-7674-67732e250978@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 21:22:07 +0800 Yunsheng Lin wrote:
> > Sounds good. Warning wrapped in #if CONFIG_DEBUG_NET perhaps?  
> 
> How about something like __get_free_pages() does with gfp flags?
> https://elixir.free-electrons.com/linux/v6.4-rc6/source/mm/page_alloc.c#L4818

Fine by me!

