Return-Path: <bpf+bounces-15879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F87F9772
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 03:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267BF1C208BA
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB31110F;
	Mon, 27 Nov 2023 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uP0H0Rsx"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9BEED
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 18:17:26 -0800 (PST)
Message-ID: <7eabc9bb-0f77-468f-b2fb-fac214273232@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701051444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZ0xknfFw8i7tZediJaWwFLTCbn3Dw6+yOAzy7i913c=;
	b=uP0H0Rsx7dIQ3bHxzoF8YNX9RaqNOTGy5oQdLb/K6Gv0kvqqDCCO9XirAPdSj7t6XYI4r4
	gTvPgw8RAatVwZ2hlJC6L5rHzVHgcwjtzAgtvNCcAVgc+0tOdD7d0c0RV/raa4RHEnJl8x
	LB23cehFYyBWy48359U5QcVfGmRA18k=
Date: Sun, 26 Nov 2023 18:17:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv4 bpf-next 3/6] bpf: Add link_info support for uprobe
 multi link
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20231125193130.834322-1-jolsa@kernel.org>
 <20231125193130.834322-4-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231125193130.834322-4-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/25/23 2:31 PM, Jiri Olsa wrote:
> Adding support to get uprobe_link details through bpf_link_info
> interface.
>
> Adding new struct uprobe_multi to struct bpf_link_info to carry
> the uprobe_multi link details.
>
> The uprobe_multi.count is passed from user space to denote size
> of array fields (offsets/ref_ctr_offsets/cookies). The actual
> array size is stored back to uprobe_multi.count (allowing user
> to find out the actual array size) and array fields are populated
> up to the user passed size.
>
> All the non-array fields (path/count/flags/pid) are always set.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


