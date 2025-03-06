Return-Path: <bpf+bounces-53516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61075A559D1
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 23:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E6C1896778
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0D2780E3;
	Thu,  6 Mar 2025 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KmPZuyvF"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D91311AC
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300382; cv=none; b=GbFZIvuI8Js1BKTFin/hRmqQ6lY1CDKkjLS577Dw/p0Fen4k9wCjHFbimNPZmd9VApXvV+wU43QhI5yBDr4J6IilR4eG1qjDDsHXuOL9lIl+AFPdSvsHtf2jd9JYDIBra7jTjj0ITrQ15p47gJbifb2iuPRcLPxQ4P20bsKoHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300382; c=relaxed/simple;
	bh=WoE/ExMYkaH0wgUaPI7gKK9MlzU15elpkPjgeHxPstw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPH0lGPO3ou+TG1eKnBFYvW7nx1wJn+Uq6XqrVfg9tGr+FtH49k3/RQUykBmOosifhtNN8/rwLqoolILKw2mJkuhA47xylPJO9EiTR2EBPoaRkSxiars5LJkTOAX9Gw2+JEwGy8XqHfsZukaoXmyYloVQay1azMJvZ0l28K3dIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KmPZuyvF; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d961af60-8e7f-4d72-9f22-a0ee8d2fac7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741300377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgr2lm5EtMWj/o+U9w65HzFCQeYJpsoaGBIN19NfQbc=;
	b=KmPZuyvFD+skPb7R6UwBBnY2vGGyGWNui4pxzxPVj2bE/1pvtZAfye0pofYBi8uWTdB30z
	+65YmmVL6Js9dYnJCb+OpTEzAzvst9LNbmuIHhawdvfbVlYkrcQeIqd+VlxoQdiKmVu8ba
	NqYCweiKe00Om4CQuYinAJAUOPz0wBg=
Date: Thu, 6 Mar 2025 14:32:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Move test_lwt_ip_encap to test_progs
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250304-lwt_ip-v1-1-8fdeb9e79a56@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250304-lwt_ip-v1-1-8fdeb9e79a56@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/4/25 1:24 AM, Bastien Curutchet (eBPF Foundation) wrote:
> +int remove_routes_to_gredev(const char *ns1, const char *ns2, const char *vrf)
> +{
> +	SYS(fail, "ip -n %s route del %s dev veth5 %s", ns1, IP4_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s route del %s dev veth7 %s", ns2, IP4_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s -6 route del %s/128 dev veth5 %s", ns1, IP6_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s -6 route del %s/128 dev veth7 %s", ns2, IP6_ADDR_GRE, vrf);
> +
> +	return 0;
> +fail:
> +	return -1;
> +}
> +
> +int add_unreachable_routes_to_gredev(const char *ns1, const char *ns2, const char *vrf)
> +{
> +	SYS(fail, "ip -n %s route add unreachable %s/32 %s", ns1, IP4_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s route add unreachable %s/32 %s", ns2, IP4_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s -6 route add unreachable %s/128 %s", ns1, IP6_ADDR_GRE, vrf);
> +	SYS(fail, "ip -n %s -6 route add unreachable %s/128 %s", ns2, IP6_ADDR_GRE, vrf);
> +
> +	return 0;
> +fail:
> +	return -1;
> +}

Added static to these two functions and applied. Thanks.

