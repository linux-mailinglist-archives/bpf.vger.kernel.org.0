Return-Path: <bpf+bounces-12361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688AB7CB7F3
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 03:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181262815BE
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 01:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068931FD5;
	Tue, 17 Oct 2023 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HogMLJfe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637B17CB;
	Tue, 17 Oct 2023 01:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9245CC433C7;
	Tue, 17 Oct 2023 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697506047;
	bh=s+jRDW+2r/hfeMcX43wig5Zoi67P+MBXYRuEZHkr50I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HogMLJfecZN17MTZr096mjcZ2IDGruz/FY7v83Gb7/ZDvPTIL+WdGM2mSjH7TIQeV
	 lkrcwJlrreWA553L9DrttaF+M7rIPrW9D9ajMAl90ghSw45tWbn0TqygnVdba71bsJ
	 BvKjL+VYXfZH4UypliqZOJuU3w2NObAhUxlv8cKc2lrEzWW7ASoP3AVNUGpU8o8sPF
	 UnRi6125QGaEN9A5JIvhzI7DWQnCDQH6LUuKqXlkSo5Jy3x640fO1wpZfyv1n/b4q+
	 D0RssdFIOutKYuMPzDFSpjElHznI23230BDvGHOLDdKzk7TVCqfAwWBq2gAt0PN03C
	 fcg5fAqQT0iKw==
Date: Mon, 16 Oct 2023 18:27:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related
 API
Message-ID: <20231016182725.6aa5544f@kernel.org>
In-Reply-To: <20231013064827.61135-1-linyunsheng@huawei.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 14:48:20 +0800 Yunsheng Lin wrote:
> v5 RFC: Add a new page_pool_cache_alloc() API, and other minor
>         change as discussed in v4. As there seems to be three
>         comsumers that might be made use of the new API, so
>         repost it as RFC and CC the relevant authors to see
>         if the new API fits their need.

I have looked thru the v4 discussion (admittedly it was pretty huge).
I can't find where the "cache" API was suggested.
And I can't figure out now what the "cache" in the name is referring to.
Looks like these are just convenience wrappers which return VA instead
of struct page..

