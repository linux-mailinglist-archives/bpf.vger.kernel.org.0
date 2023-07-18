Return-Path: <bpf+bounces-5170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BD7580D9
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1621C20D5A
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41EC10780;
	Tue, 18 Jul 2023 15:26:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A5D518
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 15:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D625C433C7;
	Tue, 18 Jul 2023 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689693979;
	bh=+TJ92Gupq0pfZnkJvIFO8Zsm9FylALOLZj8QN/yUCyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PxXZhcH7MKY+vV3z5wfPbRR/veeKx6Ls5TW4S882XnV9tbZTqlD8d64+yDPZQ7qEk
	 KEOypCkz7mEya1nKgOp6t82p8ZnW4S29X4otsZHFo4TSllqoTQE5kzcfU3FBVzq5nz
	 qVglZcZcJHhr+BveM4TDuGRvmlPcTFUQ5Z+iRRj3IydKhaSGR17Yoydnm8tI8lqj6m
	 DtLQy+uq/Oqq9m1Ur3FEHWSSFe27pONGg8YwwCg3ltQl0kgKoCpWqaSpe2IChtPMZ0
	 f9MY8RQbsr4K6/x2J1n4KdVBosBsa4MMeDbku9P7ykOHMnSttZCs1fALRBzh1iIjMp
	 HiNjZ0mmJgoIQ==
Date: Tue, 18 Jul 2023 08:26:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Rosenberg <drosen@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
Message-ID: <20230718082615.08448806@kernel.org>
In-Reply-To: <20230502005218.3627530-1-drosen@google.com>
References: <20230502005218.3627530-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 May 2023 17:52:16 -0700 Daniel Rosenberg wrote:
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4033,7 +4033,7 @@ __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
>  	if (likely(hlen - offset >= len))
>  		return (void *)data + offset;
>  
> -	if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
> +	if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
>  		return NULL;

First off - please make sure you CC netdev on changes to networking!

Please do not add stupid error checks to core code for BPF safety.
Wrap the call if you can't guarantee that value is sane, this is
a very bad precedent.

