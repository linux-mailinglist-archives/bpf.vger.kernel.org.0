Return-Path: <bpf+bounces-16933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C75D807A9E
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E667B1F21EBE
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC17098D;
	Wed,  6 Dec 2023 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MY5F6mFm"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA798
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 13:39:14 -0800 (PST)
Message-ID: <e5e36140-01f5-4028-9751-85b740a62a6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701898752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/ARXkEiaV3t0hVA3ROG6MZ0MS7Ody0vgn5/uF6saAM=;
	b=MY5F6mFm2o65EiIF0YiV4DoBxAjCbGBYU1UHqfFkEq4Qy7RiK/YF0S0VJb/OhedTeH4/7P
	YgTRdyPg9QicElxpqn7YXeUYwPk/k2woG0JXmHez98FDM6oe05Zy4F2s/KET2VJTm7QNWe
	LY/2/MYqwfukXb4n2rfz1Qu6zYG30AM=
Date: Wed, 6 Dec 2023 13:39:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: rename MAX_BPF_LINK_TYPE into
 __MAX_BPF_LINK_TYPE for consistency
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20231206190920.1651226-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231206190920.1651226-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/6/23 2:09 PM, Andrii Nakryiko wrote:
> To stay consistent with the naming pattern used for similar cases in BPF
> UAPI (__MAX_BPF_ATTACH_TYPE, etc), rename MAX_BPF_LINK_TYPE into
> __MAX_BPF_LINK_TYPE.
>
> Also similar to MAX_BPF_ATTACH_TYPE and MAX_BPF_REG, add:
>
>    #define MAX_BPF_LINK_TYPE __MAX_BPF_LINK_TYPE
>
> Not all __MAX_xxx enums have such #define, so I'm not sure if we should
> add it or not, but I figured I'll start with a completely backwards
> compatible way, and we can drop that, if necessary.
>
> Also adjust a selftest that used MAX_BPF_LINK_TYPE enum.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


