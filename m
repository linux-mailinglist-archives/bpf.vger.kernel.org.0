Return-Path: <bpf+bounces-15880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5467F9773
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 03:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B51C280D73
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 02:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8B9111A;
	Mon, 27 Nov 2023 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ArIxcVqy"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F0DED
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 18:19:48 -0800 (PST)
Message-ID: <76694ae8-0f7b-4b1d-bfe0-9e62638463db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701051586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHE1bqCXF8xZe6zz2YTA1LgJQfPMAs6xJO7yRYfK2/Y=;
	b=ArIxcVqy0x9GWfrM4Ren7uVnhEz73VH22/Q0IOsX1MFzmfMXMJHGRnw86Go2rhD+HzXBrn
	vDMv9+0Uvvhs6Li/oSAQDEKATGIR/mO3HljhjLAFHif68Ylns85zNaVz5j9siuUlrdToVd
	S8XKBG8wendyBPYVEDxZIyOEMx/xbvg=
Date: Sun, 26 Nov 2023 18:19:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv4 bpf-next 5/6] selftests/bpf: Add link_info test for
 uprobe_multi link
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
References: <20231125193130.834322-1-jolsa@kernel.org>
 <20231125193130.834322-6-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231125193130.834322-6-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/25/23 2:31 PM, Jiri Olsa wrote:
> Adding fill_link_info test for uprobe_multi link.
>
> Setting up uprobes with bogus ref_ctr_offsets and cookie values
> to test all the bpf_link_info::uprobe_multi fields.
>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


