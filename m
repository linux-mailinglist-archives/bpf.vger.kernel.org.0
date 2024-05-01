Return-Path: <bpf+bounces-28318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D468B853A
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 07:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65F01F23967
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 05:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835893FB3B;
	Wed,  1 May 2024 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="w86L0Mfe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189A3E47B
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 05:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714540306; cv=none; b=k1tg+V91n7U3LEo+m/TmUR5sXFfZr9BOmZKcNo1mGAS8fOjbZb4L6OID5cFaXJQhBto2wDCug+t2ctw4/MeIlyYV2qu6EYm3bIMN9i4A6aNwA+S1tudoyfgbQJ/I2P2RfTxChXdTfvlDhut/bp5pPRUcZMcPyXTQa8BE2iKau+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714540306; c=relaxed/simple;
	bh=pEAY0QWRsLB9JluX8XvvnxaNOrBWmNrSqSwEC+UUzo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulXtNW/jhRoTe6B0pyRSHUwxWtRPDCdgrOUm2Z3KY0eJ0nTPLaEIWvc93zWr6BCd74o0NJ7Oka6zZ3uShmUDGcYawNyaPJqxYQVE5TICe8hWcfeMX78lzaUzhsoVxrawnbMPclhtxCgxgLNKtxoCM0MhAVqajRgA60VvBCT7n2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz; spf=pass smtp.mailfrom=fe-bounces.faucet.nz; dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b=w86L0Mfe; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-Id: Date: Subject: Cc: To: From; q=dns/txt; s=fe-4ed8c67516;
 t=1714540290; bh=enGl1EWAiYGXFruQwU3JI5/BpgRyOA/UsoNJoaKWqB4=;
 b=w86L0Mfe+WJFVWiWNrrNu0ODPXsyWWzvqRW+Uzcgxusf/o77gdOlU1ZCiVVU2w+pkx/h1ZToi
 5jy2mcyQmMfXDMTTc6zDaG9UpqgwIx/2JMw8AJlHnT6avQC8uKwBo0ProRmuCaBiWQC76dW2z2Q
 ZflksCjEN0XinwYMcSjenq0=
From: Brad Cowie <brad@faucet.nz>
To: martin.lau@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brad@faucet.nz,
 coreteam@netfilter.org, daniel@iogearbox.net, davem@davemloft.net,
 john.fastabend@gmail.com, jolsa@kernel.org, kuba@kernel.org,
 lorenzo@kernel.org, memxor@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org,
 sdf@google.com, song@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] net: netfilter: Make ct zone opts configurable for bpf ct helpers
Date: Wed,  1 May 2024 16:59:31 +1200
Message-Id: <20240501045931.157041-1-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <463c8ea7-08cf-412e-bb31-6fbb15b4df8b@linux.dev>
References: <463c8ea7-08cf-412e-bb31-6fbb15b4df8b@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; brad@faucet.nz, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6631cc4e257562284fbdc957

On Fri, 26 Apr 2024 at 11:27, Martin KaFai Lau <martin.lau@linux.dev> wrote:
> On 4/23/24 8:00 PM, Brad Cowie wrote:
> >   };
> >
> >   static int bpf_nf_ct_tuple_parse(struct bpf_sock_tuple *bpf_tuple,
> > @@ -104,11 +107,13 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
> >   			u32 timeout)
> >   {
> >   	struct nf_conntrack_tuple otuple, rtuple;
> > +	struct nf_conntrack_zone ct_zone;
> >   	struct nf_conn *ct;
> >   	int err;
> >
> > -	if (!opts || !bpf_tuple || opts->reserved[0] || opts->reserved[1] ||
> > -	    opts_len != NF_BPF_CT_OPTS_SZ)
> > +	if (!opts || !bpf_tuple)
> > +		return ERR_PTR(-EINVAL);
> > +	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == NF_BPF_CT_OPTS_OLD_SZ))
> >   		return ERR_PTR(-EINVAL);
> >
> >   	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
> > @@ -130,7 +135,16 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
> >   			return ERR_PTR(-ENONET);
> >   	}
> >
> > -	ct = nf_conntrack_alloc(net, &nf_ct_zone_dflt, &otuple, &rtuple,
> > +	if (opts_len == NF_BPF_CT_OPTS_SZ) {
> > +		if (opts->ct_zone_dir == 0)
>
> I don't know the details about the dir in ct_zone, so a question: a 0 
> ct_zone_dir is invalid and can be reused to mean NF_CT_DEFAULT_ZONE_DIR?

ct_zone_dir is a bitmask that can have two different bits set,
NF_CT_ZONE_DIR_ORIG (1) and NF_CT_ZONE_DIR_REPL (2).

The comparison function nf_ct_zone_matches_dir() in nf_conntrack_zones.h
checks if ct_zone_dir & (1 << ip_conntrack_dir dir). ip_conntrack_dir
has two possible values IP_CT_DIR_ORIGINAL (0) and IP_CT_DIR_REPLY (1).

If ct_zone_dir has a value of 0, this makes nf_ct_zone_matches_dir()
always return false which makes nf_ct_zone_id() always return
NF_CT_DEFAULT_ZONE_ID instead of the specified ct zone id.

I chose to override ct_zone_dir here and set NF_CT_DEFAULT_ZONE_DIR (3),
to make the behaviour more obvious when a user calls the bpf ct helper
kfuncs while only setting ct_zone_id but not ct_zone_dir.

> > +			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
> > +		nf_ct_zone_init(&ct_zone,
> > +				opts->ct_zone_id, opts->ct_zone_dir, opts->ct_zone_flags);
> > +	} else {
>
> Better enforce "ct_zone_id == 0" also instead of ignoring it.

Could I ask for clarification here, do you mean changing this
else statement to:

+	} else if (opts->ct_zone_id == 0) {

Or should I be setting opts->ct_zone_id = 0 inside the else block?

