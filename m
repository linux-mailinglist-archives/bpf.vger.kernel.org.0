Return-Path: <bpf+bounces-6612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E176BE25
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 21:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FE71C21017
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF66253D2;
	Tue,  1 Aug 2023 19:51:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C025170;
	Tue,  1 Aug 2023 19:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7009C433C8;
	Tue,  1 Aug 2023 19:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690919497;
	bh=Vsh2EggMUIyZ6IFbT29YXmtzY2olDYuT+fH6QmapKVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LFF8Sp3Q4nScO4/C7Qz9kS8hTLttTL31YXFSdz5DUiZss3RPczW8uKfiKLw6+jg7+
	 JlbdtNgSn8qFbmnW1t1i0a4h9kQl4/xtvAkzBCyUZl95dPpRBrtg27N4/wOwO7jQU4
	 UQGphkldSKKi8jt34/xvVydUueUDMOrfNKcPF75ZwnCxlyHzMRZIFuZ+SxzZ1TE4G1
	 k0ktFUrUzyVWZEKiumffOhZKI8Vidf8vu+DjZ4oVoJO5Qf7LO8YzurSETspAKFsL/8
	 T2oj0GxdzAaUG1c3oV2/dwu3ykZt9LeEi0EgvJqjOpelqTTVa+cuXnpQN+UtqBSLH7
	 mIPB1EHbpeqlA==
Date: Tue, 1 Aug 2023 12:51:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Wei Fang <wei.fang@nxp.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <shenwei.wang@nxp.com>,
 <xiaoning.wang@nxp.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
 <linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230801125136.5d57e3ad@kernel.org>
In-Reply-To: <ZMkl6HUYMGWXj87P@lincoln>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
	<ZMkl6HUYMGWXj87P@lincoln>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 17:34:00 +0200 Larysa Zaremba wrote:
> But I thought XDP-related code should go to bpf-next :/
> Could somebody clarify this?

AFAIU pure driver XDP implementations end up flowing directly into
net-next most of the time. If there are core changes or new API
additions in the series - that's when bpf-next becomes important.

