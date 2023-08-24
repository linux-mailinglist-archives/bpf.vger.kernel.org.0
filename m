Return-Path: <bpf+bounces-8438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370BD7864F2
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 03:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEA71C20B1F
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 01:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D417EF;
	Thu, 24 Aug 2023 01:54:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF957F;
	Thu, 24 Aug 2023 01:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255F3C433C7;
	Thu, 24 Aug 2023 01:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692842038;
	bh=dUjRC96Y34euUDSaNA/h1pSNeZPTmkLzu7c2FEi2qA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pbk12ZrmqI8Ci5eZuW+fGynBf6JIzCY4Q3k6ZB/HU78f2Jdkaz9ZN5xraaI3HGsMP
	 pDJIYewooAbY+9jxcNTA5wpiyUPFF/es9Izng350BdxnNrYf2zxn3v3icKa38RRTsP
	 mSCLqHG/EfmUURRhWnoRta6McKOGaIsEOJsNmyj3cexzyIboKmoUvWkOziY5RK71OQ
	 o+OrQZ8qJ0qS55rkPQtoefygY5aMAy/qx60L99qjRrBo8USvU1VP8FmETEBrXUY1yu
	 DWMXlp9qcUZ7bnJ3unE+cN18tQsrJn2O56YMlyvIEHql0MYoWbDeqIjwtMGoRi+/cH
	 tfOw2YjmXN9WA==
Date: Wed, 23 Aug 2023 18:53:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJu?=
 =?UTF-8?B?IFTDtnBlbA==?= <bjorn@kernel.org>, Yonghong Song <yhs@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Xu Kuohai
 <xukuohai@huawei.com>, Puranjay Mohan <puranjay12@gmail.com>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v2 0/7] Add support cpu v4 insns for RV64
Message-ID: <20230823185356.0db6cc1d@kernel.org>
In-Reply-To: <20230824095001.3408573-1-pulehui@huaweicloud.com>
References: <20230824095001.3408573-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 09:49:54 +0000 Pu Lehui wrote:
> Add support cpu v4 instructions for RV64.

Please make sure you fix the timezone on your system before sending 
out the next version.

