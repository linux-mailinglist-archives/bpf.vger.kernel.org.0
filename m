Return-Path: <bpf+bounces-28317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FFA8B8536
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 07:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EE01F2367F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 05:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0DE45034;
	Wed,  1 May 2024 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="qNM2WUAc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00A446A1
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 05:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714539859; cv=none; b=UxoAsMLGTyj5AcBv6WPzM5QfZmL5qOMInStTL4LUfiSOpWpBsGvVmBQnO8scZx1OUlyOg0JF5r4h8hnbtmYR1gff+cnwC4xkyaLQ8xVcBvthN3le5sxXSugRP+yUsHG+VTeV2cvyY3clT6+dxEmqaNrXvVnjgunCgh6IDGfs6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714539859; c=relaxed/simple;
	bh=bwiq97hl0ulqMWBNQjmyB2B12PjF7UwQ9e34FplS5vI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNfE4nAqYTSZPyChGx/3PrlEjY2W8Mpw8oeLqL3ixZse7d0tgVEJBLCJk6XfwsYu2uYfYt/BJBSHe2aWQo5rmSsjbqGwgLjtqqOxD4b3YnU9YWWB20x+8gMgZUI2+mrBHNLsOZha58HNDwRTvfRBJeCT7avbj5chdy5/hyxxto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz; spf=pass smtp.mailfrom=fe-bounces.faucet.nz; dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b=qNM2WUAc; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-Id: Date: Subject: Cc: To: From; q=dns/txt; s=fe-4ed8c67516;
 t=1714539842; bh=RsrIq7/ZvC8loumi0io1jOngwJSiw32p9ZnpvFMQJ4o=;
 b=qNM2WUAc04iwfGRh77R6k6MWdN/xaaYZUpHqLLMLm7vfH6dzrzrL63SG/IMRRyVrs+Ky5xAAy
 9zVBsRixF7DV4Xwza+O64bAM5mQYOzwZzsyZ03jQdPorEmSZREaVlRFmnvMwRkQAGAoraEk3z9G
 FJHrSUOs45rvYeH4l7atJWw=
From: Brad Cowie <brad@faucet.nz>
To: martin.lau@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brad@faucet.nz,
 coreteam@netfilter.org, daniel@iogearbox.net, davem@davemloft.net,
 john.fastabend@gmail.com, jolsa@kernel.org, kuba@kernel.org,
 lorenzo@kernel.org, memxor@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org,
 sdf@google.com, song@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Update tests for new ct zone opts for nf_conntrack kfuncs
Date: Wed,  1 May 2024 17:03:21 +1200
Message-Id: <20240501050321.157531-1-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <288b0d96-d5a8-4d81-9302-32b0d414a983@linux.dev>
References: <288b0d96-d5a8-4d81-9302-32b0d414a983@linux.dev>
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
X-ForwardEmail-ID: 6631cd401fff278fe661f725

On Fri, 26 Apr 2024 at 11:34, Martin KaFai Lau <martin.lau@linux.dev> wrote:
> On 4/23/24 8:00 PM, Brad Cowie wrote:
> >   } __attribute__((preserve_access_index));
> >   
> >   struct nf_conn *bpf_xdp_ct_alloc(struct xdp_md *, struct bpf_sock_tuple *, u32,
> > @@ -84,16 +90,6 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> >   	else
> >   		test_einval_bpf_tuple = opts_def.error;
> >   
> > -	opts_def.reserved[0] = 1;
> > -	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
> > -		       sizeof(opts_def));
> > -	opts_def.reserved[0] = 0;
> > -	opts_def.l4proto = IPPROTO_TCP;
> > -	if (ct)
> > -		bpf_ct_release(ct);
> > -	else
> > -		test_einval_reserved = opts_def.error;
> > -
> >   	opts_def.netns_id = -2;
> >   	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
> >   		       sizeof(opts_def));
> > @@ -220,10 +216,77 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> >   	}
> >   }
> >   
> > +static __always_inline void
> > +nf_ct_zone_id_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> > +						struct bpf_ct_opts___local *, u32),
> > +		   struct nf_conn *(*alloc_fn)(void *, struct bpf_sock_tuple *, u32,
> > +					       struct bpf_ct_opts___local *, u32),
> > +		   void *ctx)
> > +{
> > +	struct bpf_ct_opts___local opts_def = { .l4proto = IPPROTO_TCP, .netns_id = -1 };
> > +	struct bpf_sock_tuple bpf_tuple;
> > +	struct nf_conn *ct;
> > +
> > +	__builtin_memset(&bpf_tuple, 0, sizeof(bpf_tuple.ipv4));
> > +
> > +	bpf_tuple.ipv4.saddr = bpf_get_prandom_u32(); /* src IP */
> > +	bpf_tuple.ipv4.daddr = bpf_get_prandom_u32(); /* dst IP */
> > +	bpf_tuple.ipv4.sport = bpf_get_prandom_u32(); /* src port */
> > +	bpf_tuple.ipv4.dport = bpf_get_prandom_u32(); /* dst port */
> > +
> > +	/* use non-default ct zone */
> > +	opts_def.ct_zone_id = 10;
>
> Can the ct_zone_flags and ct_zone_dir be tested also?

I have added an additional test for ct_zone_dir, this will be included
in my v3 patchset.

While writing a test for ct_zone_flags, I realised this option is not
used for the conntrack functions that the bpf ct helper functions call,
nf_conntrack_alloc() and nf_conntrack_find_get(), it is only used by
nf_conntrack_in(), so I will remove ct_zone_flags from my v3 patchset.

