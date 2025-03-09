Return-Path: <bpf+bounces-53663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C12A582C8
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 10:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154313AA889
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4621AA1F4;
	Sun,  9 Mar 2025 09:43:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692961A2399;
	Sun,  9 Mar 2025 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513388; cv=none; b=eO+MhBUldylHMSlV6reQyYLpP6N72mD0/PCEwL0tlG5vPg02tf2UsS6JbZugdF3YqnxHt3TZj+X1uHPRiXhWCyRZIt70skTWSHDc3N45CyJYwVsV5D/8PG+DnW7dyJhATDgeFfCuwh0su/dtKrIw+zVD8oWLMTXbJNdbtoxtDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513388; c=relaxed/simple;
	bh=4jvXtCiBGGzihH3212h9WgJUU9eBgKW9QxvkQL2DjS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8nm64TqN1eEklsOMxQX8Hhb7GeDpKYAsw9hAvmcicCMaXXcSts43V7z1KXqhIv2vOQIJQllGWiC/uEHtEujj9ldK+IgRjzcU+tiDAeITPQ826FmyHlKbWsHDRiVzRdHYNubo8XY9EiL7YkFoVRunfu3RkiUAwNG+cw4WO0Uq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1trDBP-00020x-AW; Sun, 09 Mar 2025 10:42:55 +0100
Date: Sun, 9 Mar 2025 10:42:55 +0100
From: Florian Westphal <fw@strlen.de>
To: Kohei Enju <enjuk@amazon.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	syzbot+83fed965338b573115f7@syzkaller.appspotmail.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Yi-Hung Wei <yihung.wei@gmail.com>, Florian Westphal <fw@strlen.de>,
	kohei.enju@gmail.com
Subject: Re: [PATCH net v1] netfilter: nf_conncount: Fully initialize struct
 nf_conncount_tuple in insert_tree()
Message-ID: <20250309094255.GA7435@breakpoint.cc>
References: <20250309080816.87224-2-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309080816.87224-2-enjuk@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kohei Enju <enjuk@amazon.com> wrote:
> Since commit b36e4523d4d5 ("netfilter: nf_conncount: fix garbage
> collection confirm race"), `cpu` and `jiffies32` were introduced to
> the struct nf_conncount_tuple.

Reviewed-by: Florian Westphal <fw@strlen.de>

