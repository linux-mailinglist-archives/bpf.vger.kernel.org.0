Return-Path: <bpf+bounces-39630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0438D975760
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F051F2626B
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63F1AC899;
	Wed, 11 Sep 2024 15:42:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987E15C13F;
	Wed, 11 Sep 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069341; cv=none; b=QbcJ3EWoKoHEzb3Zy3UWG6Jj8bYRmT5P8TVbUFnRVPcUrtwKrbldYOZbGLoFHzt/uKrkiIv+AkiRa1JDaSm8Pj+TlOY00glWDCSOHHDpHMt5OZj0MJtjlyU178uLOP01ztc8inLhHigbq47+uu7Otp5Rt4T6QM/pIKsqEr46LRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069341; c=relaxed/simple;
	bh=uSHlGgWquC2eZOdWS+eXuPuEqlU/ljnUGiVLCGymDk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eq/zhwDwfhy9o3iBJsmxM1dy7tNAlZsPfIwTGo9YnTB5x4gJgVXOExkM+Lvr6TluaN1IcArCEDU7eR5tHlJVwxouetX5kTGh1IjKu6GznukKwWHfVNpdnyKJlTlXKhqSO0+/FvZ/M3MHQKI5b778w4/kfscmO47SxLmWqLf3Hjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1soPTp-0004WW-FF; Wed, 11 Sep 2024 17:42:05 +0200
Date: Wed, 11 Sep 2024 17:42:05 +0200
From: Florian Westphal <fw@strlen.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: netfilter: move nf flowtable bpf initialization
 in nf_flow_table_module_init()
Message-ID: <20240911154205.GA17177@breakpoint.cc>
References: <20240911-nf-flowtable-bpf-modprob-fix-v1-1-f9fc075aafc3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-nf-flowtable-bpf-modprob-fix-v1-1-f9fc075aafc3@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> Move nf flowtable bpf initialization in nf_flow_table module load
> routine since nf_flow_table_bpf is part of nf_flow_table module and not
> nf_flow_table_inet one. This patch allows to avoid the following kernel
> warning running the reproducer below:
> 
> $modprobe nf_flow_table_inet
> $rmmod nf_flow_table_inet
> $modprobe nf_flow_table_inet
> modprobe: ERROR: could not insert 'nf_flow_table_inet': Invalid argument

LGTM, thanks Lorenzo.

Acked-by: Florian Westphal <fw@strlen.de>


