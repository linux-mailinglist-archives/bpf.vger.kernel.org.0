Return-Path: <bpf+bounces-27452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308D8AD3CC
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733561C20C15
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC24D154442;
	Mon, 22 Apr 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tjLyfdoY"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D5750271
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810089; cv=none; b=UjTuuaJ40+6GEnmD4rzwa+INaN0W9YZ4xuegc4zxUBoyK/zD9Kn4dK6mM1Xw0+xBEqLPf6k2Cjx+YXgpdJeSiqFxiOjb569uHoeb+pzUaTi5cLyuClL66mXulEMHxYoDnvD4ltPhBi6KGmVSA6qv4/d5GkDaXicf+y+IfmjrYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810089; c=relaxed/simple;
	bh=pxvs25+vP3QcPTv2/oPlNPm/ewBkHajTSWRX4YnZGDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb49cQMvl8g8mx9GJYvxlCN5yOGB/9SKumV7Nn8lunbpDo3/0YO+v9gR7N7iRC3Ne2UWc4kc20eFsTgGvm4ckEkU0jj4EBCzoRSRaZACinz+IGnPYUUtr/QMw5TrdCPZKkyDItSdq1Za0/tW6ksF+sGQbsTIUV5AblsLKKQ7Mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tjLyfdoY; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce9252ef-21e2-4b09-9797-590f5eaa2869@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713810085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVWarZ3dFiQoDizzXByr5aA5jsGVjVJadznYtDZd72E=;
	b=tjLyfdoYYh2vRSDrvdWtjyx8VrZihMFcFgZleOzJ2dJYOLDIOced4oW+Prgns0g/rsJBmW
	kgYC4hfl1s6inC6mcM+T/mZmfLEziqjBGOiDvheqbIOKRK8uFCF1cI0ZUWndWeKUTJzAE9
	TlC+dPVoscaghVhoJ1SUvx0/AtbBem4=
Date: Mon, 22 Apr 2024 11:21:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] xdp: use flags field to disambiguate broadcast
 redirect
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240418071840.156411-1-toke@redhat.com>
 <d7938afa-fb2f-4872-b449-6ecaf5e29360@linux.dev> <878r18tjr2.fsf@toke.dk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <878r18tjr2.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/20/24 3:24 AM, Toke Høiland-Jørgensen wrote:
>>   From reading the "waits for...NAPI being the relevant context here..." comment
>> in dev_map_free(), I wonder if moving synchronize_rcu() before
>> bpf_clear_redirect_map() would also work? Actually, does it need to call
>> bpf_clear_redirect_map(). The on-going xdp_do_redirect() should be the last one
>> using the map in ri->map anyway and no xdp prog can set it again to
>>   ri->map.
> I think we do need to retain the current behaviour, because of the
> decoupling between the helper and the return code. Otherwise, you could

Forgot there could be a disconnect here.

Applied. Thanks.

> have a program that calls the bpf_redirect_map() helper, but returns a
> different value (say, XDP_DROP). In this case, the map pointer will
> stick around in struct bpf_redirect_info, and if a subsequent XDP
> program then returns XDP_REDIRECT (*without*  calling
> bpf_redirect_map()), it will use the stale pointer value and cause a


