Return-Path: <bpf+bounces-70159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D92BB1DE7
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941961924666
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61030DD2E;
	Wed,  1 Oct 2025 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHdaPD3L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6914175A5
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354791; cv=none; b=KqdL230j+bVyHzA4E9H87Snis5nDOyb+w0lPiAH6FqAON2RcGE2ZNDs15aGpMSUeTw7Og/vdhQ6k5uW9m1dXNqnfL178YHxdUHJ+DczJ7C9H2Z+UgCV0dGcm6wsvE/yYsZQUof9qAf5RerzviulsI42q2LtvkSoCPSGJeq+aJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354791; c=relaxed/simple;
	bh=+umo9iYlAl9HyOsL0Zu8iFAKyMfLmtwseKIu+cV7dEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ2732m63XYfrBmsRUknYkpj+tp6xmFpvUrLN6vaPSsrpgs7EkqmpofmkewwXWSEPH8cXykUUg+66FhVwZEK/VS51dbVsQs3cJBTGb0JIiW133hC6nWWB1TvH/rW50/t44x1H+Hqdcq/VbI6kw9R3BEso38OuMFki5IpkB03ohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHdaPD3L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so1827505e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759354788; x=1759959588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMzzaaIhw7Zer1fbUlD9qWrEm2MkdilmJorBO5Wtltc=;
        b=VHdaPD3Lh2chB+5+Q6tbljR6r9MRe6kkf/DIRyGwdJnfin1ttJujiiruSIuqks2pf4
         6XDEeZJjCP3kq+uRspSwdglMmx/Czguwh4XxqAyyTTtEgs0wnTSO5NfOJY9yKzXWd6CZ
         g2awLOBZDoEJAq7Fgq5bN/kP96GGCTJmK8cdTUtahRbJKNbtp10cr9PHOz6/hH2EGezi
         lOHubsseL97pE33qZOoLIaBUN/GeycP18QeUhCrWwKD++X6DfaDnTSLKqKOBRk6QvPwJ
         SdDGGiTSVHDHmW7nZsPi8oOCeusSj8tOn8MGD8+DYXpEI5S+OVrS/se/Q375mw8PFP/p
         kW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354788; x=1759959588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMzzaaIhw7Zer1fbUlD9qWrEm2MkdilmJorBO5Wtltc=;
        b=WJmdXHFWC+EfjxQ/qT8TnlcqDT5JaqJJi8Z9VHNQIA6vc4tZHf34ixmAI4KUH+E5Sg
         sc4Sh8kRwsVPmu9FtejW9hjsnKheCWE6KCMTJ8hB4YwdMFyZCoGDZfIGfEeIjvBthQzG
         tkzrxGViZ/dBSCQV/9P00Tt+WSrWeOQEevVp1MbLgVY34RdeJZiBXVMXaXXiNb+wcbeo
         z08QSz3DF8v5cbCKcY3tEnScPMIOq2UC+oq6ZlPd8y5JuZ83t7E/1O+T8TVt7VFNRIjK
         xF2ObDZdC2nS8HLo4ZZ+JIq0pMZLTP5O0/xnERcQm575l+OCCN+NgVB3/6Lowec5jpOe
         CXPQ==
X-Gm-Message-State: AOJu0YxvslRNVk+LfUK4CAQFv2cjq4+Wjqn79IRcS0BT3EPyWEfQ5jiX
	5VdvBoSoWfJpeGaCwbF99OCxyKH+O/8qewmkWGkXASzqwLVuC+FnRRaI
X-Gm-Gg: ASbGnctAkCey+ynixp06AAte4ebemmYwFQ9nFfRAUr/JENgWnxCNAlfJEw3CNg71dF/
	LLsWGZZ4SB3dyEiKGu1Mt/DjSYfslWn/DtNyHozany54j1EymxjBoj5B8fq2vIxF20lKQwysH+R
	PTKJpDyPounmD0lLLSsStEYt3XqHtVhchWaxqk47fOctvhyXpQT2o3GGUkUEhk6j9Q8NSJMUf+E
	JvFNjIqTY4wYC17JggRBFwqDhpeZWMeWJRsUw0Br8vjCnHIzU6KfhFxc0cf225zGFvxds/sOLQ3
	VwbldNDxEWqKqxzMVCoPnN9t3ZAYqvC/xN+nyZee8llOlshElDoA4dqtNR7i72ecAjJ4bGWQQws
	ovhWQV4b6jinZFEkw5uTsfKaebHgW3WpgzGWPAmj5F6oGFm7Y9LjNDr55+/xbH9HhwAmjHp8vY0
	MozL1Sv9lByvH36KyDAWt9089e0or84pP4Ws+FFt2zgWcc
X-Google-Smtp-Source: AGHT+IGbW8CvbbShF8lbVj5ojEYZ0ihuP2ib+7HdQu04gCcxJdB66SMi03Dp2wH/F3bxXO7bO98uKA==
X-Received: by 2002:a05:600c:1d1a:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46e612be155mr36385905e9.22.1759354787996;
        Wed, 01 Oct 2025 14:39:47 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006ac507786c22ef92.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6ac5:778:6c22:ef92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693bcc2csm7666845e9.12.2025.10.01.14.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:39:47 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:39:45 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <aN2foao59lLr2RUI@mail.gmail.com>
References: <cover.1758213407.git.paul.chaignon@gmail.com>
 <41b200d749ff0c1171b7f2ea60531126ba5e7a62.1758213407.git.paul.chaignon@gmail.com>
 <85545d76-1177-408e-8224-2fb98ffe8a2f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85545d76-1177-408e-8224-2fb98ffe8a2f@linux.dev>

On Thu, Sep 18, 2025 at 11:50:22AM -0700, Martin KaFai Lau wrote:
> On 9/18/25 9:47 AM, Paul Chaignon wrote:
> > This patch adds support for crafting non-linear skbs in BPF test runs
> 
> I think it is useful. Thanks for working on it.

Thanks for the review Martin!

> 
> > for tc programs, via a new flag BPF_F_TEST_SKB_NON_LINEAR. When this
> This commit message needs to be updated.
> 
> > flag is set, the size of the linear area is given by ctx->data_end, with
> > a minimum of ETH_HLEN always pulled in the linear area.
> > 
> > This is particularly useful to test support for non-linear skbs in large
> > codebases such as Cilium. We've had multiple bugs in the past few years
> > where we were missing calls to bpf_skb_pull_data(). This support in
> > BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
> > BPF tests.
> > 
> > In addition to the selftests introduced later in the series, this patch
> > was tested by setting BPF_F_TEST_SKB_NON_LINEAR for all tc selftests
> > programs and checking test failures were expected.
> > 
> > Tested-by: syzbot@syzkaller.appspotmail.com> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> >   net/bpf/test_run.c | 82 ++++++++++++++++++++++++++++++++++++----------
> >   1 file changed, 65 insertions(+), 17 deletions(-)
> > 
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 00b12d745479..222a54c24c70 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -660,21 +660,30 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
> >   BTF_KFUNCS_END(test_sk_check_kfunc_ids)
> >   static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
> > -			   u32 size, u32 headroom, u32 tailroom)
> > +			   u32 size, u32 headroom, u32 tailroom, bool nonlinear)
> 
> test_run_xdp() already has support for multi-frag/buf and doesn't need "bool
> nonlinear". It also does not have the one-page limitation. Is there a reason
> that test_run_skb() cannot follow what the test_run_xdp() does?

You're absolutely right, following the XDP approach made things a lot
simpler. I'm not sure why I was trying to keep all data copy in
bpf_test_init. I've sent a v4 for this. Sorry it took a while to get to
your review.


