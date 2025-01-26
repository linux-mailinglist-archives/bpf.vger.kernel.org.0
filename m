Return-Path: <bpf+bounces-49817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE56A1C63C
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 04:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123543A7F07
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 03:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80431199252;
	Sun, 26 Jan 2025 03:38:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41E25A632;
	Sun, 26 Jan 2025 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737862723; cv=none; b=Rpmgpjw4rubkJZ8Og1V52a+tEYV1jmxF1BfMAjvrt9Gjt1RJ7PJ+GK81xyI7BPNjo3FJ0R+Jd0vZG9pgVCam1NBUotYG44Mzz9BWzYxnMS8IgMdJbeOv4O5ZgfVBuPFh9c6AQExVLePXHwHpG9igFbYDDivH9hzeWjQLs3v9ou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737862723; c=relaxed/simple;
	bh=MMv76EhGiRjD7R/m1qHAJ7lrz0L1QFkHBC2Twqs4elE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJGP54ZoJUvoORUAgAhjYG6zsN7LXrBg+IXs17izZQ9h6acfQspL7PR8zPP7140NmgZ5XK+WEw25qBTXaZbvvif4NqD/YwLQjl1JHP275vLNwv+b20ZQMWIqcAGkQUvvLqvm35uNojpJ3LUPUPYr26XZl2lfU3KeeFu2jMXy1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YgcjF4KhNz20pXV;
	Sun, 26 Jan 2025 11:38:57 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 811551402C1;
	Sun, 26 Jan 2025 11:38:31 +0800 (CST)
Received: from kwepemn200003.china.huawei.com (7.202.194.126) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 Jan 2025 11:38:31 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemn200003.china.huawei.com (7.202.194.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 26 Jan 2025 11:38:29 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <daniel@iogearbox.net>
CC: <ast@kernel.org>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yhs@fb.com>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yanan@huawei.com>, <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
	<liuxin350@huawei.com>, <liwei883@huawei.com>, <tianmuyang@huawei.com>,
	<zhangmingyi5@huawei.com>
Subject: Re: [PATCH] ipv4, bpf: Introduced to support the ULP to modify sockets during setopt
Date: Sun, 26 Jan 2025 11:36:19 +0800
Message-ID: <20250126033619.3167023-1-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <66f2d886-e3d4-4f8f-a735-b0ce1c412ee2@iogearbox.net>
References: <66f2d886-e3d4-4f8f-a735-b0ce1c412ee2@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn200003.china.huawei.com (7.202.194.126)

We want to call `bpf_setsockopt` to replace the kernel module in the TCP_ULP case. The purpose is to customize the behavior in `connect` and `sendmsg`. We have an open-source community project kmesh (kmesh.net). Based on this, we refer to some processes of TCP Fast Open to implement delayed connect and perform HTTP DNAT when `sendmsg`.

I'll send a patch with a full description and test cases later.

> > Signed-off-by: zhangmingyi <zhangmingyi5@huawei.com>
> > ---
> >   net/core/filter.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 713d6f454df3..f23d3f87e690 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5383,6 +5383,10 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
> >             if (*optlen < 1)
> >                     return -EINVAL;
> >             break;
> > +   case TCP_ULP:
> > +           if (getopt)
> > +                   return -EINVAL;
> > +           break;
> >     case TCP_BPF_SOCK_OPS_CB_FLAGS:
> >             if (*optlen != sizeof(int))
> >                     return -EINVAL;
> 

