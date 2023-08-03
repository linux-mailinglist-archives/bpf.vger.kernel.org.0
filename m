Return-Path: <bpf+bounces-6870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE9E76EC6F
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39A4281A21
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA23F23BCA;
	Thu,  3 Aug 2023 14:24:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD83D8E;
	Thu,  3 Aug 2023 14:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0FCC433CA;
	Thu,  3 Aug 2023 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691072672;
	bh=fZnCQHD+JnX8Uw0i/9Xy90bfMJI/UtsG/4uWhs4aEPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n0ogD1d1EEVA2bneQwO5xBlcoSGAhL5fG6B1mrXqBQ5A6bkCzfEeiMZnd4+ZmZgtx
	 yLkhNx7Y/Tq2fqe5byrhtzjtUI4khWwKM0k+tvm77eAFq0clfUneZM8yJOrfUM9pd9
	 lTUYedmgfD4QcU1wDoD9IjTBCOJHXUHvD9EpdPq6ZgMJt0CnvdKy93fLvdWlorgIQm
	 nBmW6Q787wiP3FGxvNo5hDw+Wn7iUTnSzXWE4QXsYCD+fxSTTEuN0fliOOsCbWqXIU
	 fzobQJKu0zgbdLxd/9gO7YwX4jZ4aMQOmv/V7N1THPtx5yPymW4/2m6reGkarJfRuF
	 6/JU9ShBceVCA==
Message-ID: <bd6c0dee-3f2c-3613-a5ff-42cc11268e49@kernel.org>
Date: Thu, 3 Aug 2023 16:24:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 2/3] net: move struct netdev_rx_queue out of
 netdevice.h
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, amritha.nambiar@intel.com,
 aleksander.lobakin@intel.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, gregkh@linuxfoundation.org, wangyufen@huawei.com,
 virtualization@lists.linux-foundation.org
References: <20230803010230.1755386-1-kuba@kernel.org>
 <20230803010230.1755386-3-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230803010230.1755386-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/08/2023 03.02, Jakub Kicinski wrote:
> struct netdev_rx_queue is touched in only a few places
> and having it defined in netdevice.h brings in the dependency
> on xdp.h, because struct xdp_rxq_info gets embedded in
> struct netdev_rx_queue.
> 
> In prep for removal of xdp.h from netdevice.h move all
> the netdev_rx_queue stuff to a new header.
> 
> We could technically break the new header up to avoid
> the sysfs.h include but it's so rarely included it
> doesn't seem to be worth it at this point.
> 
> Reviewed-by: Amritha Nambiar<amritha.nambiar@intel.com>
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

