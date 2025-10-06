Return-Path: <bpf+bounces-70447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F4BBF654
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 22:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F91F4EFA94
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64494256C61;
	Mon,  6 Oct 2025 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlBc2IMY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E41A83F7
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759783826; cv=none; b=AbmDnH5kH3w8aQEb7Q4ORRlJ4Srk/JVavVE8fGkter+29KGAyzTrsiSW09LaPnuIQsl/ENgxcO6GHfT32eQOll5OrULYySE0ui5GKeKIYSQmeYnAKHcN4F7Soo3w9tnwWw1wxyw3QhrmyGwHHJs1aeAPYygkE8VsYrMaQ2s/tG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759783826; c=relaxed/simple;
	bh=qcyUuTsK1Z6UYb7f/PCDfWZF+moyHjhBA5UUIZJa0Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2nG5ht6l8vnkOa3q3rPQjJWztGPWSy2DHps24VpqFxlVYnQ6hikCKBtqjsfcrWoFRCggiomO6dzE+QSDYG4FP26eqC70SpZmrT4SehSvjb9Ub8YKY2ujcKECyWB9Vwd6Fq79AVAouf/9LaM5dXjt7eqIYQYG8FTbIADWCzcttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlBc2IMY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e52279279so36436655e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 13:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759783823; x=1760388623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFoys9zrQX54U7RXOd60sve0XQMuxt0H0+dPRmdVXU4=;
        b=LlBc2IMY/NsU1PEcpTm8k35wNAWWyPJwRsSIUzvmAiUqp34L29eXzAeT7eHqCNMMmY
         8nCFeybFlZt8Hexo3xbEwCsEpwTiUDfUoXpYfnSJVRauRmEUjSpoDQPgKL7N/9FXwOu+
         SYZiYejp3+kW3b4HuHkdgpe4PFQMs8ImpxITM/7gj7M0CKbEa74RyxFUYqUGSfgGq9PY
         xV9TQbYjp0zKUcu03aI9W0wKHwa4cYbuWM8alVbRPbWk2O/qSwJCScS4X1A+T4HhjVty
         4YJ0gLNrnehnqKFdj8luO0Ukw1uDQbIn+GrLNH4CjXJrVSO/+MPN6VpdpKN0iq/W6UHc
         IZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759783823; x=1760388623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFoys9zrQX54U7RXOd60sve0XQMuxt0H0+dPRmdVXU4=;
        b=tbXrlok0OGHrpmipVY2UPHc4RIQWc+2EhVpWbrRO/kJ/2fVoEZtAH2hz4jNxvThTsQ
         kC2/dVbA0BsLOBvzxW+0DkhFJRRnohLtylga4AN7Lw17GFHI7SI50Ot1HLVBgrInMtDP
         evK3UixZN82bMCZVbRBm+tv1eYz6ezwoXgAEaTuLnZBSrE3rQAISqE0/oXlWpKyOxs2v
         iZ6cwEixq9+LpLlJZgOu09n5eX+LjG1KZVgYUVZ+L9yyyzs89pex9OLFPuj4JwHUskoi
         nr+2HYI+VNIgiITsGnDB7to7oScAd+Jsrf+ltkD4qQsvKGcW+8TueGtxVu9IjpiraFaz
         bttQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIaiyzAJvzHrmvm3DafFOSXlprHMO9SSmQKjT+I2uK7KsD7aQnpVJTBC+wl3oA6aPwcLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSS76N66StG4Fcw2WWJzWOkqpATciuTOBulRq/8pWmeKbufaK
	ZwKDvrY16u5aY7V1BRzwkPAsGxpbBznUWX7EexC/UiHFRZEQtzXP4zUX
X-Gm-Gg: ASbGncv2Lu4liRxJkSRUWx3RsFydR9YWZZ1+YPnZDekP2Npc/RC4Ev4JCK03vbvZ1ML
	Mi16CCfDtKg2F/wK0s5T1J5QvuLNc615gVuYqARcVZ1OWhdJiZN+s11jhGyNy+Ap0oKzDq+1Wlj
	DueLAGK4YswleLv14wosl2j1HG3mh287sWK0halV/bXQoIocnx0r2XbhC/KOPlxrjnJmmYBBK+/
	0D3S0whfktlIYFUeIOHNouXvO9yjbNWZ6QGFNMqJB48p0V7khz285kFYwnL5t+NjacGKzgqxSdp
	s8tn4EFoU7rf8AgCXhqyHcU4kZOW85rDw5X1+fA0HxZ8uPm/WE/Z2JaB8jjUX2+iQYKSRYCsesg
	3lgfnHEKBObwQ+rFwpEZCKtjNKuVePoQRA/NZgNDmKwAfVcOhJ+u3pjm47wlnOgj+s73SA2n/Fa
	R7p02/QwiEdRCu0QUtOxB1GVajt/hH7D2jK9xzQikOzvl06mxpG7wtvt9Z
X-Google-Smtp-Source: AGHT+IHBGMuN5KlHrr48AVkRGOAgD5a9f7DOTYc5urnVw8KSYbLtQ4bw4cbUq5b4h1YSxkI7zAX60A==
X-Received: by 2002:a05:600c:628b:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-46e71147470mr99277175e9.30.1759783823066;
        Mon, 06 Oct 2025 13:50:23 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0014cd65e068af8bf0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:14cd:65e0:68af:8bf0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723437d8sm175847065e9.3.2025.10.06.13.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:50:22 -0700 (PDT)
Date: Mon, 6 Oct 2025 22:50:21 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <aOQrjeaErvdq--wT@mail.gmail.com>
References: <cover.1759397353.git.paul.chaignon@gmail.com>
 <10502e40a894fc60abf625ec631eadc5ad78e311.1759397354.git.paul.chaignon@gmail.com>
 <943df0e0-358e-4361-81a0-ec7a4118cf29@linux.dev>
 <aOPMWoiFY78QT5Er@mail.gmail.com>
 <82c4c97e-83cc-4f42-b3a0-11f46a7495d6@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82c4c97e-83cc-4f42-b3a0-11f46a7495d6@linux.dev>

On Mon, Oct 06, 2025 at 11:58:41AM -0700, Martin KaFai Lau wrote:
> On 10/6/25 7:04 AM, Paul Chaignon wrote:
> > On Thu, Oct 02, 2025 at 11:27:52AM -0700, Martin KaFai Lau wrote:
> > > On 10/2/25 3:07 AM, Paul Chaignon wrote:
> > > > This patch adds support for crafting non-linear skbs in BPF test runs
> > > > for tc programs. The size of the linear area is given by ctx->data_end,
> > > > with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
> > > > ctx->data_end are null, a linear skb is used.
> > > > 
> > > > This is particularly useful to test support for non-linear skbs in large
> > > > codebases such as Cilium. We've had multiple bugs in the past few years
> > > > where we were missing calls to bpf_skb_pull_data(). This support in
> > > > BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
> > > > BPF tests.
> > > > 
> > > > In addition to the selftests introduced later in the series, this patch
> > > > was tested by setting enabling non-linear skbs for all tc selftests
> > > > programs and checking test failures were expected.
> > > > 
> > > > Tested-by: syzbot@syzkaller.appspotmail.com
> > > > Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> > > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > > ---
> > > >    net/bpf/test_run.c | 67 +++++++++++++++++++++++++++++++++++++++++-----
> > > >    1 file changed, 61 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > > > index 3425100b1e8c..e4f4b423646a 100644
> > > > --- a/net/bpf/test_run.c
> > > > +++ b/net/bpf/test_run.c
> > > > @@ -910,6 +910,12 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
> > > >    	/* cb is allowed */
> > > >    	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, cb),
> > > > +			   offsetof(struct __sk_buff, data_end)))
> > > > +		return -EINVAL;
> > > > +
> > > > +	/* data_end is allowed, but not copied to skb */
> > > > +
> > > > +	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, data_end),
> > > >    			   offsetof(struct __sk_buff, tstamp)))
> > > >    		return -EINVAL;
> > > > @@ -984,9 +990,12 @@ static struct proto bpf_dummy_proto = {
> > > >    int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> > > >    			  union bpf_attr __user *uattr)
> > > >    {
> > > > +	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > >    	bool is_l2 = false, is_direct_pkt_access = false;
> > > >    	struct net *net = current->nsproxy->net_ns;
> > > >    	struct net_device *dev = net->loopback_dev;
> > > > +	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
> > > > +	u32 linear_sz = kattr->test.data_size_in;
> > > >    	u32 size = kattr->test.data_size_in;
> > > >    	u32 repeat = kattr->test.repeat;
> > > >    	struct __sk_buff *ctx = NULL;
> > > > @@ -1023,9 +1032,16 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> > > >    	if (IS_ERR(ctx))
> > > >    		return PTR_ERR(ctx);
> > > > -	data = bpf_test_init(kattr, kattr->test.data_size_in,
> > > > -			     size, NET_SKB_PAD + NET_IP_ALIGN,
> > > > -			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
> > > > +	if (ctx) {
> > > > +		if (!is_l2 || ctx->data_end > kattr->test.data_size_in) {
> > > 
> > > What is the need for the "!is_l2" test?
> > 
> > There's nothing limiting us to only tc program types, but I was
> > wondering if it makes sense to open this (non-linear skbs) to all
> > program types. For example, cgroup_skb programs cannot call
> > bpf_skb_pull_data to deal with non-linear skbs.
> 
> The bpf_dynptr_* and the bpf_load_* can still be used to handle the a
> non-linear skb.
> 
> One thing is all "!is_l2" program will get an -EINVAL now after this patch
> if either ctx_in or ctx_out is specified. Am I reading it right?

Yes, that needs to be fixed either way.

> 
> > 
> > Even the LWT program types would require special care because ex. the
> > bpf_clone_redirect helper can end up calling eth_type_trans which
> > assumes we have at least ETH_HLEN in the linear area. I wasn't sure it
> > was worth opening this capability to these program types without a clear
> > use case.
> 
> I thought the linear_sz has been taken care of below such that it must be at
> least ETH_HLEN anyway. Why "!is_l2" still needs to be rejected?

In case of !is_l2, we will still call eth_type_trans() before running
the BPF program. That pulls the L2 header via eth_skb_pull_mac(). Then,
if we run an LWT program calling bpf_clone_redirect, it calls
eth_type_trans() again, trying to pull the L2 header a second time.

IIRC I hit this exact issue on an earlier version, before adding the
!is_l2 check, when I enabled non-linear on all programs in test_loader.
empty_skb.c was then triggering kernel BUGs.

I couldn't find a case where this is an actual issue in LWT because it
seems we always at least linearize the L3 header (for route lookups)
before running the LWT programs. And the L3 header is bigger than
ETH_HLEN so eth_type_trans() doesn't throw a kernel BUG.

> 
> I am not familiar with the LWT but I recalled we have fixed some cases on
> the ETH_HLEN and they are now tested by the prog_tests/empty_skb.c.
> 
> I think I am missing something on how is the non-linear skb different from
> the linear skb here for lwt if it has ensured there is ETH_HLEN in the
> linear. I am not sure how active is the lwt/bpf usage now. If it is hard to
> support, I think it is fine to exclude it.

I'm sure it can be done, but not sure it's worth the hassle. As you say,
it's unclear how used they are. Even for Cilium, which I believe was the
initial use case, we don't use them.

> 
> CGROUP_SKB will be good to be supported at the beginning though.

Ack. I'll send a v6 excluding only the LWT types.

[...]

> > > Should linear_sz be limited to "PAGE_SIZE - headroom..." like how
> > > test_run_xdp() does it ?
> > 
> > That changes a bit the current behavior. Currently, we will return
> > EINVAL if a user try to pass more than "PAGE_SIZE - headroom..." as
> > data_size_in. With the test_run_xdp approach, we'll end up silently
> > switching to non-linear mode if they do that.
> > 
> > I'm not against it given it brings consistency with the XDP counterpart,
> > but it could also be a bit surprising.
> 
> I think this is fine to accept what was previously rejected because of
> lacking non-linear skb support.
> 
> 
> I would prefer to have similar expectation as the test_run_xdp for the parts
> that make sense.

Ack.


