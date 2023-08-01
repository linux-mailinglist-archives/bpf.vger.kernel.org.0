Return-Path: <bpf+bounces-6606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88776BDBF
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088A52819CF
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C532253A9;
	Tue,  1 Aug 2023 19:29:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CA1F95B;
	Tue,  1 Aug 2023 19:29:08 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B698D103;
	Tue,  1 Aug 2023 12:29:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 891CB5C00D1;
	Tue,  1 Aug 2023 15:29:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 01 Aug 2023 15:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1690918144; x=1691004544; bh=50
	K0rjAZpMOLnZsQS3es5SZ7R2JGHZMJS2+QIhOnXEc=; b=T9GkXm5gSU3tOXrp9E
	36ZU/UZXuBRob2tmtMybh09WX2gr52fiBEgj86/KpJvPMt7JaiHDWo36mUPT6P2v
	mNUtYOgMCsOeA8LCZMR9MfZexBqvuwl0MHyP3QYaU47l40L3o6vIkexRf9wW94HN
	mUWUfczWXu+ls645LESj+SPKBOXKEp19EGb5GnX1YmWMwrO/wjl3s7Z4vA+YhF2A
	fv+2SSmdPrVG4ixz31HsCVwgqRrZFGBgzBgqLB2Quoilr3mmLmx8XmF/m7TcO8Nu
	mYUIZGfHAhYHWKQ2ok2EJBHYI4mi65kvEqhFaz9xbSEGQmOph1pvOdPzXmrYk0eW
	Aj6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690918144; x=1691004544; bh=50K0rjAZpMOLn
	ZsQS3es5SZ7R2JGHZMJS2+QIhOnXEc=; b=ysrqy/DPDf0EDgyHSuuTQzcKD6IEe
	5Nsi0NaQcyAXZCHiWQOBtDspe1Ckg5vHX/sBUi8GbhHobW/XqZr+HGbHg3E/B1Wd
	t4Ex+90CAKfXIJ61NGvdpDQkg0oaP+L9ycpf0MvqRmo6W65x4D2zIu3vvmgfkD/T
	li4xwcjbfTP266cmlZZ0hkTHnC0wH1Dqlxe5hnSQDpK4NjIY05OqCTm5cA1zQtXx
	PVtDdgYBshNCIqWFrXkaS9Q0ZEsBsE/EnKRBlX1XWIrVq1Ir9AGGKNJTVIusofx6
	Ae4q3x/ObPB/VzNmp/+uZO9dzV+0T5JubSCz9jC+KlpwUfllOG+kdr0Fg==
X-ME-Sender: <xms:AF3JZI6fiaI-pjU2nZvB6MIVZtW8ZcoxupuDdlAMacWqgeeCBnQxPA>
    <xme:AF3JZJ6f0FxRdpyqu6juKKBhOYP9GE6a6RcH_IJCUOnelPycwe0Eg6gg-a6rIXoqU
    qtxeZv4p0YUEGbnDA>
X-ME-Received: <xmr:AF3JZHdCRBWRDfDjX-ktcCZFzKEztQ_sKbTg1HQURmKzbPIFrFzGOkcwQx_twWL87qAWAvVhZOD-Fe0Z9_8SxBrvjbcfyACQsdALoSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:AF3JZNKiXh6XPsasb7_LWp1ls-nxuZtwkCqhldtR7rafO1d64ob4Zg>
    <xmx:AF3JZMLDb2Zq3odcK6LbthBi2C3Y0_0NzQPyMuOvuAGkuikbxFUmwQ>
    <xmx:AF3JZOxBNTvdS-eIePhnA-f47JroGxCypBhyZeYaBVm5LKixfXYE6A>
    <xmx:AF3JZPZdCUZISi1hQuNEJMuTbjBQWjP_VPOUaK5Ir2b9zHRXyZtrwg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 15:29:03 -0400 (EDT)
Date: Tue, 1 Aug 2023 13:29:01 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, Netdev <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] netfilter: bpf_link: avoid unused-function warning
Message-ID: <ewu46co43ldtnsedbaqvs4ihpebr7wxjbpum32iq4i766egpyu@bzocmghr636q>
References: <20230801150304.1980987-1-arnd@kernel.org>
 <z3gp6rcrlotwjwux7chza4vmbgv747v5jlr4xhuaad3y2yofsf@jjiju6zltbmh>
 <b795ccdf-ad53-407e-ba01-a703e353b3fb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b795ccdf-ad53-407e-ba01-a703e353b3fb@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 07:27:33PM +0200, Arnd Bergmann wrote:
> On Tue, Aug 1, 2023, at 17:20, Daniel Xu wrote:
> > Hi Arnd,
> >
> > On Tue, Aug 01, 2023 at 05:02:41PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The newly added function is unused in some random configurations:
> >> 
> >> net/netfilter/nf_bpf_link.c:32:1: error: 'get_proto_defrag_hook' defined but not used [-Werror=unused-function]
> >>    32 | get_proto_defrag_hook(struct bpf_nf_link *link,
> >>       | ^~~~~~~~~~~~~~~~~~~~~
> >> 
> >
> > This was fixed in 81584c23f249 ("netfilter: bpf: Only define 
> > get_proto_defrag_hook() if necessary").
> 
> Ok, I guess this will be in tomorrow's linux-next then, right?
> 
>     Arnd

I'm not too familiar with the linux-next process, but chatgpt is telling
me it should be.

Thanks,
Daniel

