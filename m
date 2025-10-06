Return-Path: <bpf+bounces-70421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E2BBE465
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C443B5B93
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E32D0634;
	Mon,  6 Oct 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llABVwdP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07B3770B
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759457; cv=none; b=PTRLwQvnyEr0Ky9I+SJecD7UARpdu9XpvbjjKFeD9nd8U0in/zhtVcOkSPJBLP67PGrR65DKG2ja21PHk8mJfXZI4+AHBbz6WPIR39Z2H54PFaKenOHW5ldKmZTRVJRkaEkvRY2pcfRDJqcMVyGU/7KGrLiUGKRQrJV0EAnfS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759457; c=relaxed/simple;
	bh=FXpA0GzTDlirVgxLbKXCuND5BDcVshb9VBMgly8yATM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEYejR07GI9rxfMCH33+JpbCs/PyyiyWy8+Ryh3oaLa0bjC590by5vWfrS1CYrR5xSLtyaUEcihxFgr1wB8XOr15QVb1VmlMLQcaAh0dxeITJa/kyMOs+95VoIbkPYOmfkBSg1y7UWQSfF7766NpQM7OCBbZebxzVnUR/Po5SZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llABVwdP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46f53f88e0bso9395935e9.1
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759759454; x=1760364254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdKOlA9c2Pdc069xxJqmJShetX8EovtgTeTPusLf6o0=;
        b=llABVwdP496zi+YhW9WdpXT2+mnDqAzox0F3I3SOoyu+bAGgxJEUqdG0sALreqvbBd
         6Ze2MYy4d29Ox4kH4+phhhyv9Y/hZJrYno2CZNdCFJjCEdx5VnPrL5yQhwcH6vzroTFT
         a628OEZoGxQb7RjDymtOHmpPNWMDaeuBwxurPsgdp58wEq5dgS3K2HsOgXc4PLbGSVLb
         gqe1MLQwxs93J4RxtaZwENAZ89Wnyxk+RQceILfzwYNMghs+zkyIVdmMHHC5jtD9TDvd
         7QGvmrlV++OWczHmxkKFYkzNuxPdro2xzVzddWV1b0ujcC2GQFEy8qb2hEXmJY2twAsB
         GGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759454; x=1760364254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdKOlA9c2Pdc069xxJqmJShetX8EovtgTeTPusLf6o0=;
        b=GAEoBby+qWoiTA3yRH7EQgygB2SglUFcPw5XrV/X4ilVOvWibTz1Lbes5+Z8JMMOh0
         xJFjThtdXP6itcK5KPVUDxa9LludwVMX5hyr9K6VCTiIQLaOt0p2zyGhXh+uSS1Ovr/8
         eKs4pP9jIOGbIvQYWIR2D7lv+FXEUPi8LUU5C4HIVt8OQ8VWmlpu4XbBSgHl0GpHlEPD
         V84SegVUZV7P765/vYeywm08UbOIOH7VsuYJo73/nPhU+ttc4a04JWFi2YZtGAbXjqis
         7UFX21YopgdBj8O218ecGtrYY97wxt2bzggqqvCI7T4o5zzkPWPbsoTz+O2nH1l3Tkx+
         coow==
X-Forwarded-Encrypted: i=1; AJvYcCU5lX3Y09mGrd5tX482Z9ys7dh5+sj12WEy4pAkKWsN2dZCey0EaobeUpP/ZVUWr7ZOhVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyoI+NgSaWjr44D3HwdqP+M0xP9cbKJ1uxphi4nqrTKGbABExE
	8xhhJlh1lkAtBKS4RzbWXzjppDI1Bm+hNKsmhhAsN7MEP/Sp9zZDUIUL
X-Gm-Gg: ASbGncsp4U+AI3NAwB4j/fZ1A/69ei0x9N4Weycwg4CQZ7DwghaqKsa3PxmtkrpnRre
	r1FAwnKQp9DTKKMC9MdORV8cWyLykTGcg97po5xT/EPbjNW8fT6TRW9bivdKKvpJNQlTuy4t+Dl
	Lhyo/OvEFBRaCjOUYnOnm5NcJKM+o7qi8y5yXi0VF9tdEyEpqTp21gIxUynVHRP7vTltxMDqqNt
	IWb8WS/1ufwA3sEhcEDqetDdkE5KcjsdEo944zeqY6oi7WZ0UtMF7JXXXxx3e+vvOoCQ6+1NX3S
	RKag16YKEDOXckjQFTZKzXLrYMqphwWUZEadlrvD1bm7IxBkk0QXkZ2rdEMkEg6w39wn/bhYYvD
	aui83Xg9yoPeTCv/KYHACD2sJ0W6ejqxhw1GJRHTD5IQrAlTByTGPHEPh0It2fGKSwgQSIauc15
	MQZnGhCShP/MOGRe9dnYa2gkhcwJx58NViDnf7AA3t78T8MHZSFilGD10w
X-Google-Smtp-Source: AGHT+IFVw2Nkni+2zRHCuNEHTr+I0UGux8DlY0HajKnt0upI99rd76c0LF9DnH0Pi2MFzYrdy+8Cuw==
X-Received: by 2002:a05:600c:1d1c:b0:46e:32f5:2d4b with SMTP id 5b1f17b1804b1-46e7116119bmr93128915e9.37.1759759453919;
        Mon, 06 Oct 2025 07:04:13 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0014cd65e068af8bf0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:14cd:65e0:68af:8bf0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a029a0sm255759145e9.13.2025.10.06.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:04:12 -0700 (PDT)
Date: Mon, 6 Oct 2025 16:04:10 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <aOPMWoiFY78QT5Er@mail.gmail.com>
References: <cover.1759397353.git.paul.chaignon@gmail.com>
 <10502e40a894fc60abf625ec631eadc5ad78e311.1759397354.git.paul.chaignon@gmail.com>
 <943df0e0-358e-4361-81a0-ec7a4118cf29@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943df0e0-358e-4361-81a0-ec7a4118cf29@linux.dev>

On Thu, Oct 02, 2025 at 11:27:52AM -0700, Martin KaFai Lau wrote:
> On 10/2/25 3:07 AM, Paul Chaignon wrote:
> > This patch adds support for crafting non-linear skbs in BPF test runs
> > for tc programs. The size of the linear area is given by ctx->data_end,
> > with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
> > ctx->data_end are null, a linear skb is used.
> > 
> > This is particularly useful to test support for non-linear skbs in large
> > codebases such as Cilium. We've had multiple bugs in the past few years
> > where we were missing calls to bpf_skb_pull_data(). This support in
> > BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
> > BPF tests.
> > 
> > In addition to the selftests introduced later in the series, this patch
> > was tested by setting enabling non-linear skbs for all tc selftests
> > programs and checking test failures were expected.
> > 
> > Tested-by: syzbot@syzkaller.appspotmail.com
> > Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> >   net/bpf/test_run.c | 67 +++++++++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 61 insertions(+), 6 deletions(-)
> > 
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 3425100b1e8c..e4f4b423646a 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -910,6 +910,12 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
> >   	/* cb is allowed */
> >   	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, cb),
> > +			   offsetof(struct __sk_buff, data_end)))
> > +		return -EINVAL;
> > +
> > +	/* data_end is allowed, but not copied to skb */
> > +
> > +	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, data_end),
> >   			   offsetof(struct __sk_buff, tstamp)))
> >   		return -EINVAL;
> > @@ -984,9 +990,12 @@ static struct proto bpf_dummy_proto = {
> >   int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >   			  union bpf_attr __user *uattr)
> >   {
> > +	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >   	bool is_l2 = false, is_direct_pkt_access = false;
> >   	struct net *net = current->nsproxy->net_ns;
> >   	struct net_device *dev = net->loopback_dev;
> > +	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
> > +	u32 linear_sz = kattr->test.data_size_in;
> >   	u32 size = kattr->test.data_size_in;
> >   	u32 repeat = kattr->test.repeat;
> >   	struct __sk_buff *ctx = NULL;
> > @@ -1023,9 +1032,16 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >   	if (IS_ERR(ctx))
> >   		return PTR_ERR(ctx);
> > -	data = bpf_test_init(kattr, kattr->test.data_size_in,
> > -			     size, NET_SKB_PAD + NET_IP_ALIGN,
> > -			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
> > +	if (ctx) {
> > +		if (!is_l2 || ctx->data_end > kattr->test.data_size_in) {
> 
> What is the need for the "!is_l2" test?

There's nothing limiting us to only tc program types, but I was
wondering if it makes sense to open this (non-linear skbs) to all
program types. For example, cgroup_skb programs cannot call
bpf_skb_pull_data to deal with non-linear skbs.

Even the LWT program types would require special care because ex. the
bpf_clone_redirect helper can end up calling eth_type_trans which
assumes we have at least ETH_HLEN in the linear area. I wasn't sure it
was worth opening this capability to these program types without a clear
use case.

> 
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +		if (ctx->data_end)
> > +			linear_sz = max(ETH_HLEN, ctx->data_end);
> > +	}
> > +
> > +	data = bpf_test_init(kattr, linear_sz, size, headroom, tailroom);
> 
> Instead of passing "size", should linear_sz be passed instead? Unlike xdp,
> allocating exactly linear_sz should be enough considering bpf_skb_pull_data
> can allocate new data if needed.

Indeed. Thanks!

> 
> Should linear_sz be limited to "PAGE_SIZE - headroom..." like how
> test_run_xdp() does it ?

That changes a bit the current behavior. Currently, we will return
EINVAL if a user try to pass more than "PAGE_SIZE - headroom..." as
data_size_in. With the test_run_xdp approach, we'll end up silently
switching to non-linear mode if they do that.

I'm not against it given it brings consistency with the XDP counterpart,
but it could also be a bit surprising.

[...]


