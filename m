Return-Path: <bpf+bounces-6487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A776A464
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379952814CA
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 22:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD201EA6E;
	Mon, 31 Jul 2023 22:57:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221F1DDF7
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 22:57:40 +0000 (UTC)
Received: from out-107.mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A811BD7
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 15:57:38 -0700 (PDT)
Message-ID: <086a7a88-0d33-deef-93e9-08867f899251@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690844256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRay+2K0SWqVNk+SsUIIi5wljw1q32oGNQI5MWmM/bo=;
	b=oAkO1e/bS1NgCmsGKSnD01vD7P/5WO6jOwbwjOdhAUhBYzrrd9fcM5dXJ1J3wSFIqZMgfG
	m7h85iDb7ctJv2gG3JQB14DKSa2sGVX6Wes6bjL1W2YNIja2IyIzWSYEmxgUA6CP6uySAJ
	7VTRzjfWCkBJR8MiPAjnx2b45F5JbjQ=
Date: Mon, 31 Jul 2023 15:57:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 0/2] Two fixes for cpu-map
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, houtao1@huawei.com
References: <20230729095107.1722450-1-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230729095107.1722450-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/29/23 2:51 AM, Hou Tao wrote:
> The patchset fixes two reported warning in cpu-map when running
> xdp_redirect_cpu and some RT threads concurrently. Patch #1 fixes
> the warning in __cpu_map_ring_cleanup() when kthread is stopped
> prematurely. Patch #2 fixes the warning in __xdp_return() when
> there are pending skbs in ptr_ring.

Applied to the bpf tree. Thanks.


