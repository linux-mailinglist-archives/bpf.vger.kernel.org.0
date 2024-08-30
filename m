Return-Path: <bpf+bounces-38532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D539965913
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 09:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE9C1C20D40
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 07:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B0C160887;
	Fri, 30 Aug 2024 07:50:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BDB14C5BA;
	Fri, 30 Aug 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004241; cv=none; b=dusxR8nev1QYgqf5MF2b8HE2c3Ru00zvU98vdEBsL2ajWh2YtHwHZY+0LNSlT0r4NumS4qdINCTmPKqaQpFM3WKLg46GHk+iOv3SMg5mvKMK5fFxg04I8Fo9O9Tct8auyTwM6o79gk9GngSaseWTVpMME+cmXD5F5CsIw20HPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004241; c=relaxed/simple;
	bh=uKg4qJIpfYrSIE8D0HeA0yQsXzxv/5KdvZXOAvsvcMg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Hz9KuKhd2/wt6LNQpnvpzXfHGxCefXKSXQ6AwLM2cHRb8lm3BQVdIxAecQ3bwCjDNn4t//j+b7nB11BRoIBakOXMfegojQXvzk6WWSmiimAaI50pcXj+f94MeS+4irImLlvFuiy3vhIveUCOch7H0itB1FopnNwVXYcAqs7+slE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 881409ea66a411efa216b1d71e6e1362-20240830
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:3781fd2f-9329-4c04-86a0-13838f35b2c1,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:40
X-CID-INFO: VERSION:1.1.38,REQID:3781fd2f-9329-4c04-86a0-13838f35b2c1,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:82c5f88,CLOUDID:f2942b352dddbb701cf49298b2942fd7,BulkI
	D:240830155032V78ETUYF,BulkQuantity:0,Recheck:0,SF:17|19|43|74|66|23|102,T
	C:nil,Content:0|-5,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 881409ea66a411efa216b1d71e6e1362-20240830
X-User: zhaomengmeng@kylinos.cn
Received: from [192.168.109.86] [(123.53.36.118)] by mailgw.kylinos.cn
	(envelope-from <zhaomengmeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1999602693; Fri, 30 Aug 2024 15:50:31 +0800
Message-ID: <d44e3c03-3322-4eae-b023-71b8bdc18b23@kylinos.cn>
Date: Fri, 30 Aug 2024 15:49:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 houtao@huaweicloud.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <0000000000009df8df061faea836@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in htab_map_alloc (2)
From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
In-Reply-To: <0000000000009df8df061faea836@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc error path

