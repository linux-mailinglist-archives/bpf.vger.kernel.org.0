Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFBB85503
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 23:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfHGVPV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 17:15:21 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57097 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730462AbfHGVPV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Aug 2019 17:15:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 85FAC21EAD;
        Wed,  7 Aug 2019 17:15:20 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Wed, 07 Aug 2019 17:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=UKnx6gqHjvr5nSb2S008lrzPk95S2Gh
        1TLsOv/12q7I=; b=NdZhs7xyaJzADdptuZd1WAsZU3uDac/4yU53GjCyaMQHb8B
        OgnXXAT31uCQU3Rhkodq5e+jrDkBR3oQZjlvOkAYELR9zyzGOdpGFo9+KWL0BVgW
        Vlf2L5v5wLzOBcyixgPqDm+5IcYoexxzaVPq3REvBQXm291y8qo+GOkh06+6QJXc
        OOxALijNxZye3CzKLxdI8nmgcNxysIv5gPIGAxe/7aIydoMG+y0OVvJ+ixoiQ02D
        lgW0iWW7fZFIdU0sRIn1/AgA8K6Gq67sd5x5IJEGUL2UnpNH8QTqaDSazNpHVrNm
        NkOSeEilTSJpU9jP2Sj6G+l1h2hjcs7JkKVH1Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UKnx6g
        qHjvr5nSb2S008lrzPk95S2Gh1TLsOv/12q7I=; b=pI9MaqwkMKokxfzVbCw1SA
        8NhkrJI7jfZfo3x3xAk6aRCBgUhZNj88I615THIhjasvJ1KqV2UYKK09WBjZysBI
        uPV6kDl6K73Q8G9LsrgQn7TmvpK+SXvbcTKL09K49ETh1REH11LcgiB6CHEx+/V9
        LEF+ajCti4rQZSJCZB2zJqUqw1lLFO6qNSYgKybTNkFJ3PyqGKc4RbEmBhaTEgKN
        rTy/xHFxQKpP1pJ1TKePQ5Gbde1yGQ2qfbjtEsePBZl1voWI8+glLm2845B07t5s
        kco+PLVVOusncVehNe3nOhzB7i4Tx0Y1TE0+SffuUCzcw0Y9DFg0fd6T+0nwvCwA
        ==
X-ME-Sender: <xms:Zz9LXUp2_obIR9Qtgle9S3jWNSnursHt-83nEg9jbSSqhaRd4r0Wuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduvddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepofgfggfkjghffffhvffutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiienucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Zz9LXR5Ap1UY4kC_65BJ3CW4R1aWn8LL8gy5FTkYsXJ6uHaNLf9NYw>
    <xmx:Zz9LXRyjBMo7j69fOn4Nc_C5YMhI6C9ZAuBjlPB6725o4VHU0hPcmw>
    <xmx:Zz9LXZQ6yLW_VD2FJvBh3kdF4FRVUt3h_05Xt6PQ_wIxN2hLrPm8kg>
    <xmx:aD9LXXfZajaO_72A07xQFe9-MppJsERsqYS-kwamibFVVqvbTTJdgw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C7FB014C0066; Wed,  7 Aug 2019 17:15:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-808-g930a1a1-fmstable-20190805v2
Mime-Version: 1.0
Message-Id: <98ba658b-e5e1-455d-8c47-36cca16ef17a@www.fastmail.com>
In-Reply-To: <8e7749b8-f537-7164-dc85-9a67fe88bba2@fb.com>
References: <20190806234131.5655-1-dxu@dxuuu.xyz>
 <8e7749b8-f537-7164-dc85-9a67fe88bba2@fb.com>
Date:   Wed, 07 Aug 2019 14:15:19 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Yonghong Song" <yhs@fb.com>, "Song Liu" <songliubraving@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Tue, Aug 6, 2019, at 11:06 PM, Yonghong Song wrote:
[...]
> > +int perf_event_query_kprobe(struct perf_event *event, void __user *info)
> > +{
> > +	struct perf_event_query_kprobe __user *uquery = info;
> > +	struct perf_event_query_kprobe query = {};
> > +	struct trace_event_call *call = event->tp_event;
> > +	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
> > +	u64 nmissed, nhit;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +	if (copy_from_user(&query, uquery, sizeof(query)))
> > +		return -EFAULT;
> > +	if (query.size != sizeof(query))
> > +		return -EINVAL;
> 
> Note that here we did not handle any backward or forward compatibility.
> 

I intended this to be reserved for future changes. Sort of like how new syscalls
will check for unknown flags. I can remove this if it's a problem.
