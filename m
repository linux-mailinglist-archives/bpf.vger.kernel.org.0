Return-Path: <bpf+bounces-67609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C6B46497
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7481C86F13
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841C284886;
	Fri,  5 Sep 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPYi3Z6B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBC270557
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104326; cv=none; b=ce52OsipXEfzEA4zR8cu+N1ESxWbaLUSIZPU2UQKkHPIP50uYqUSRrzGc3KlX+NI3qbZ9D3+3tp9vkFcxtu6TxAZ5T6Z2kYOsWUnDHKsK+bBqieNj4ynz/YsSbI8rpdEKPbucj3/fYx25la21zZosBAxyiKZiYtlem5uX5n9KyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104326; c=relaxed/simple;
	bh=WcjVN8F99FmOCTkpUFa4H/DBeJdnnPMDEIG3SsgxYHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzO0ORYNTefw72aCtU5yoPfsQiaVgZp7fIRm8zUV1RYmq8vVjYlyaZnGC8yZLjRvNGzryKvz8TSPyZBBfxef7HqKu3wkrNEH+qwkVBtmssqh1heo95rTQazhN3TXH+Ag0db0e8MSKBiavCRk003WD9nxRBybZj+I5oU57B+DZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPYi3Z6B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b2d018f92so16195ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757104325; x=1757709125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3rE2X3Vn9vpM3bBx0U9aQSQRZhcHyw78s70MoLQoZ7Q=;
        b=iPYi3Z6BiS3gUI0tlavBMlIalDRwrHCri/7J6StWJFZnsaZIaUDIf9eElcqZlFTc+q
         jBr6oVpeeTfa/eomZI/I/Igb1uRk4/VOMOmI3VPSn68fKlpWu7ODad8HRslKdlvYPq3x
         c9IWuGiFlrgC2T9f5kAxe1dFBOtaV8sahZIX7v6dRxk3a/HoLfkP2W/XlbaNUxHsDIzK
         oTI9t+HW8spdnP2CoKAMuuna5r/Nk/aW17r9b7TUPASqE9xv1Fijiit1XGVyoRJdMSmu
         btcBTrFG0jLkh3t7xItruKRvr0IdbQ1OfkZqSw6ec0JbE8NXZ/0ClchXGFvS6+M37fgh
         FH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757104325; x=1757709125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rE2X3Vn9vpM3bBx0U9aQSQRZhcHyw78s70MoLQoZ7Q=;
        b=iD2X/7x3w8VXnqNQfbmpJWrNhy0w/ieZXt+vW+za03jferAJKim1QXHFbjG+vjyCNZ
         pmZtqLV83m8rHiprm0bmdjJTr+PWUm8UkSpGuiIMUrDIEriylfuWkhdDmX8EyvqHM1LP
         6IcpzxgFGwtpvD5io0Sglxa2EAqGnzRbLWAvb7zBFbu08EnTbpeQFBan1Xk5fr71Mg9R
         2Gqnd+RlCrcph1cNZWX+5mj0xkzcTreXi84DCRl/+fgOkt0qrFxpQY1q+WCtXflgGgGL
         vyzbadcd9rN4CtBUns51ue7z++VkI6eEyYKcsSEy9+XvxkelZ0X0j3qGXeawWxUUb9KX
         0aEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbaBmtLZGd+PNtIJkpFLsMO5Z8H8NaUMQXNOYjK2G99WtztnzBItpesW6P7cY0IDupBuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKQbdzn12A1ZkfUHSUq4NuTp9RGRon3o4XR8Ckb7U085IYTh8
	JXPv+fSHXQwNMdpWrfE0OKUcGrIRKzFZa2PdSJlQfEtDtDUpM7rl/dzIx2GZkrVJbw==
X-Gm-Gg: ASbGncsLH3gj44D4jIOoWAIRVJoGhdx7swTlSWEPi1fKC5cU++0L8HEkwPPnrCjqAID
	uXD0iiHlS6b/MdNMcJbbw9uIZzuQPEdNLEPujK0MO025417mM8/q+u0AODcqByX2q3h5NgKvXlL
	S8QoXX+JKwMEOkki6bwZ4yn2Bn2aNlE9d0RjyBqkluh8l8shGLAHOjHYTU9sXSVDoa96uXTUURN
	AMJRevBSnckdoRMBdCJTegyPY5pAOZkKq4T4DoG8Mfib69D0H372DB4kebj2F5n2hvdTrb5OLfZ
	a15DiJkMXgOETH1dQUbHJ/OvsGfiGg0jOCH51pIVB2hnGrhlFupPif0DTnqw714aO5pzADQZUYF
	FIb6XyLKke5ArgaPgTyEJoeJMn+9KcI3w4bFJUqCtc8QeKsc7jlSYXiyD9yBpyTlirTg=
X-Google-Smtp-Source: AGHT+IFFrWt6dAX9iTLze8nqy7migWMdscannmAjNvF822+axMi7X73z5ZFWeLHyKsVHaoS51AhcZQ==
X-Received: by 2002:a17:903:186:b0:24c:863a:4ccc with SMTP id d9443c01a7336-25114efbaaamr727865ad.4.1757104324449;
        Fri, 05 Sep 2025 13:32:04 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b2570d0easm102354145ad.82.2025.09.05.13.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:32:04 -0700 (PDT)
Date: Fri, 5 Sep 2025 20:31:58 +0000
From: Peilin Ye <yepeilin@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH bpf] bpf/helpers: Skip memcg accounting in
 __bpf_async_init()
Message-ID: <aLtIvvxmjTkZC55H@google.com>
References: <20250905061919.439648-1-yepeilin@google.com>
 <CAADnVQKAd-jubdQ9ja=xhTqahs+2bk2a+8VUTj1bnLpueow0Lg@mail.gmail.com>
 <qwrl5ivlaou2qqbrj4wh2vi4uqmeny2zyfidkjizkyyzta3uo3@z6bjemb7om6y>
 <yl3kolod3l5ejeuqhfzv6o5lrpgx3jpthodpkihkbkp2nntit7@qnnd2p7i4j7u>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yl3kolod3l5ejeuqhfzv6o5lrpgx3jpthodpkihkbkp2nntit7@qnnd2p7i4j7u>

On Fri, Sep 05, 2025 at 12:48:11PM -0700, Shakeel Butt wrote:
> On Fri, Sep 05, 2025 at 10:31:07AM -0700, Shakeel Butt wrote:
> > On Fri, Sep 05, 2025 at 08:18:25AM -0700, Alexei Starovoitov wrote:
> > > On Thu, Sep 4, 2025 at 11:20 PM Peilin Ye <yepeilin@google.com> wrote:
> > > > As pointed out by Kumar, we can use bpf_mem_alloc() and friends for
> > > > bpf_hrtimer and bpf_work, to skip memcg accounting.
> > > 
> > > This is a short term workaround that we shouldn't take.
> > > Long term bpf_mem_alloc() will use kmalloc_nolock() and
> > > memcg accounting that was already made to work from any context
> > > except that the path of memcg_memory_event() wasn't converted.
> > > 
> > > Shakeel,
> > > 
> > > Any suggestions how memcg_memory_event()->cgroup_file_notify()
> > > can be fixed?
> > > Can we just trylock and skip the event?
> > 
> > Will !gfpflags_allow_spinning(gfp_mask) be able to detect such call
> > chains? If yes, then we can change memcg_memory_event() to skip calls to
> > cgroup_file_notify() if spinning is not allowed.
> 
> Along with using __GFP_HIGH instead of GFP_ATOMIC in __bpf_async_init()

Ah, I see, thanks for the suggestion - I'll send a separate patch to do
this.

Peilin Ye


