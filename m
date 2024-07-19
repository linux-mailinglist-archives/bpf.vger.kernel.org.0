Return-Path: <bpf+bounces-35090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E09379CD
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06911F2214A
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F17144D15;
	Fri, 19 Jul 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Zt7cRgcu"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53172F34;
	Fri, 19 Jul 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402563; cv=none; b=A9YBqgnXE8vbg0oXWgF4VpXcxN6+xV7q47DGtDNPjJ27gZsZjwRiEHFspayc+p9fBzWuqm4XFCB2DUVb1yjIJMz0apa0QcOIyAg3C+K+SSuZtOn9n6ONSkY/uFp7zR3WXItQFieAWHIn3HxSXdLgRIEq4JZhg+nZ7iTDOdXspt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402563; c=relaxed/simple;
	bh=aE8vQfoeDTWNER3Iwp9gsnOvK509Kw3DcDy/kEteyeI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pVjY66FK8djlhk3IPPHTgrUJTw3gsQL7mPoqbHvkhrwrFNLWdSy08GSOHbbYC3KAFrKzeFAgu25fcAC0YirlWHY+xdg1XlRfVVohUmpJmDmdaw2Zl9ARC8UMhm5EHhAsmAx2Et/3gj0gkyhDplisiUuxLbKTeh9qq/Ml4F1lW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Zt7cRgcu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=URif7gMI3nh1wp6qAidFW/PjuNYhvXq8kqWlzFmWeVE=; b=Zt7cRgcuF+unoKjq/wqH3WE+Nn
	uzCwjee1Q6ymhCPG2cP33/eVWdY3tCDsN4t3SCx+xrDHac0x3hamngihfHI+6DTp5fixf1gpHGSHN
	nRwOICLsY/QK1DYWjldWi+SPNasDmm3E8FP7F76dCyWpPm2EbTF8LtigIREBUXxwkKQcQUUjV7IFu
	X7fYrAI5WehDxC/7Vl85DEmXklmyJgQKEF4OmTtwiZ4NrdqfhFhPuurTlDpYS+9JwibCIuQ4m23TX
	pT9LWjc3cmZPlZje59zXKM8gfGKeCXCeB7IOVtgiWl5gSXb2QdmbF9Jtlj+KvGejjy7+zy6DQ6iO+
	OYVnBEhQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUpRN-0007JX-BI; Fri, 19 Jul 2024 17:22:37 +0200
Received: from [178.197.248.43] (helo=linux-2.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUpRM-000LdL-01;
	Fri, 19 Jul 2024 17:22:36 +0200
Subject: Re: [PATCH bpf 0/3] xsk: require XDP_UMEM_TX_METADATA_LEN to actuate
 tx_metadata_len
To: Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, Julian Schindel
 <mail@arctic-alpaca.de>, Magnus Karlsson <magnus.karlsson@gmail.com>,
 maciej.fijalkowski@intel.com
References: <20240713015253.121248-1-sdf@fomichev.me>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <284c6aba-8872-f971-7adb-60ed5ab3c29c@iogearbox.net>
Date: Fri, 19 Jul 2024 17:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240713015253.121248-1-sdf@fomichev.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27341/Fri Jul 19 10:28:50 2024)

On 7/13/24 3:52 AM, Stanislav Fomichev wrote:
> Julian reports that commit 341ac980eab9 ("xsk: Support tx_metadata_len")
> can break existing use cases which don't zero-initialize xdp_umem_reg
> padding. Fix it (while still breaking a minority of new users of tx
> metadata), update the docs, update the selftest and sprinkle some
> BUILD_BUG_ONs to hopefully catch similar issues in the future.
> 
> Thank you Julian for the report and for helping to chase it down!
> 
> Reported-by: Julian Schindel <mail@arctic-alpaca.de>
> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> 
> Stanislav Fomichev (3):
>    xsk: require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len
>    selftests/bpf: Add XDP_UMEM_TX_METADATA_LEN to XSK TX metadata test
>    xsk: Try to make xdp_umem_reg extension a bit more future-proof
> 
>   Documentation/networking/xsk-tx-metadata.rst  | 16 ++++++++-----
>   include/uapi/linux/if_xdp.h                   |  4 ++++
>   net/xdp/xdp_umem.c                            |  9 +++++---
>   net/xdp/xsk.c                                 | 23 ++++++++++---------
>   tools/include/uapi/linux/if_xdp.h             |  4 ++++
>   .../selftests/bpf/prog_tests/xdp_metadata.c   |  3 ++-
>   6 files changed, 38 insertions(+), 21 deletions(-)
> 

Magnus or Maciej, ptal when you get a chance.

Thanks,
Daniel

