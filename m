Return-Path: <bpf+bounces-16538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7330802295
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 11:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD5D1F2100F
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2939473;
	Sun,  3 Dec 2023 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXBbKzfi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3862FB3;
	Sun,  3 Dec 2023 10:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB55CC433C9;
	Sun,  3 Dec 2023 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701601157;
	bh=56CHr7439x2ncOqaZNQXMZy1ejsAwVMya/gSUcXsZ1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXBbKzfilgcXS3sJsoSOtDgFNS0mq/wKvZJ26AzaS/uIh0hSUn+n4TovzXFyEX/Ka
	 YYVDrOykUHd+5/SwySAJCcjZ/7rTBXDT0qrvJX0qbAi2v2mdpjpteqKvzRhS1aquwI
	 9G2xv9pYgV5+UXrfLxqQAbJMrPu3TMGpazKblkht/4EOLATC6RIbz7JY0tJ9g2yOiF
	 MR6F7h71ggALimJxjs56is0sMbPjAkAlRjctE0ksyfgsmaK57vLn/dd7J4cvhE5jKh
	 +dkbBiPKwE3HiAYayawwVRAoMcgY4G1cYKL8r59srhEREz1SMxjDiC0ODkYaZ7N/NS
	 lkK6kPjDKQAuA==
Date: Sun, 3 Dec 2023 10:59:12 +0000
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 3/3] selftests: bpf: crypto skcipher algo
 selftests
Message-ID: <20231203105912.GE50400@kernel.org>
References: <20231202010604.1877561-1-vadfed@meta.com>
 <20231202010604.1877561-3-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202010604.1877561-3-vadfed@meta.com>

On Fri, Dec 01, 2023 at 05:06:04PM -0800, Vadim Fedorenko wrote:
> Add simple tc hook selftests to show the way to work with new crypto
> BPF API. Some weird structre and map are added to setup program to make

Hi Vadim,

as it looks like there will be a new revision of this series,
please consider updating the spelling of structure.

> verifier happy about dynptr initialization from memory. Simple AES-ECB
> algo is used to demonstrate encryption and decryption of fixed size
> buffers.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

...

