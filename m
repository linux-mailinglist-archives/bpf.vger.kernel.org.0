Return-Path: <bpf+bounces-65314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F5DB1FDCE
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 04:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C7C167745
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7934526A0A7;
	Mon, 11 Aug 2025 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="enoreMwP"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9F2566F5;
	Mon, 11 Aug 2025 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754879052; cv=none; b=Z6dDsybBkKpzqqcRd16+CGe+TpffNaEPl99EJu5feyY+6wSe3p+Jx7Nm2yVTz23m5OrF3/u2G14dkX0nsoO5mRvwRz9f76e0e4CJAldIY6UeuwoOeNM0tL4idH416NnOkVMetTwlypxmZP+QowVdPazTF8q5qRX131miAYtO7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754879052; c=relaxed/simple;
	bh=6f7gunaAh2qXfLR1zo/tUJfePbUVQ4EotimizCbqe8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ2rgYqDGvWMRTFYintw5xxV1Qfiap/vQaGZ0N3PzET1hYy6aiA7rSapbpAcR6HqyLeL+mmYSaHLa4UmbwNMkJV90hqMczQvbQFg+YtfmQq9jx9snH/OcywzP6BCLoFoTExfp5gMY8TYbEUam1R+FGrlrKxV+oVY2rV9cpnCuQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=enoreMwP; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754879041; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=flv6HoYUj4fVfUcdbMTlVrhp0weweJL7h9Kd0CdybQ4=;
	b=enoreMwPtuGGmF/gLXuYF1odnta9YGs5DAo8d3vlV8pcucYC+xfLjRQbiKQ6NuFdwTxz8HSWdkyOzHEGLoWnNQKz49f4M1H3x54jFLnWOYNk7YWsTtIR/xzLMil7UR6x22W2sxSgAgD833zAYRSEx3PRpKY9L1/+qK3u6zwuIW8=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WlNXy4-_1754879039 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 10:24:00 +0800
Date: Mon, 11 Aug 2025 10:23:59 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	Mahanta.Jambigi@ibm.com, Sidraya.Jayagond@ibm.com,
	wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	netdev@vger.kernel.org, jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next 1/5] bpf: export necessary sympols for modules
 with struct_ops
Message-ID: <20250811022359.GA65101@j66a10360.sqa.eu95>
References: <20250731084240.86550-1-alibuda@linux.alibaba.com>
 <20250731084240.86550-2-alibuda@linux.alibaba.com>
 <62dbceb4-caaa-4f49-a251-0e2143cd90ac@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62dbceb4-caaa-4f49-a251-0e2143cd90ac@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Jul 31, 2025 at 02:53:08PM +0200, Alexandra Winter wrote:
> typo in commit message title? s/sympols/symbols/g

What a mistake...  I will fix it in the next series.

Thanks,
D. Wythe

> 
> 
> 

