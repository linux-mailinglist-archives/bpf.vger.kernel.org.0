Return-Path: <bpf+bounces-11554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B057BBE39
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8F51C20AC0
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8234CE5;
	Fri,  6 Oct 2023 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="iDPMpCpw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D4KZyUE4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30A34198;
	Fri,  6 Oct 2023 17:59:50 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D7BE;
	Fri,  6 Oct 2023 10:59:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3C72F5C02DF;
	Fri,  6 Oct 2023 13:59:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 06 Oct 2023 13:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1696615189; x=1696701589; bh=LU
	R07i/CoESe7pjWusXonCUaiL+SxGLf47l6Wv1tu/w=; b=iDPMpCpws5+opJ0cJR
	mVm7Oaitor5ON6fRkKhILbj1ctyrxTQTRSsyU5K/bpHZ8/6N1h++vEaGiWvODID9
	H319RMNd314Nns3TdL7+JJa5cgP6wy8drzlqdLezU0ROSvZkLPYVYRs3Uggn059c
	S8OwLEYoTnu7T/LGaumHLrNEKWxU1jcnYhJSxMYxYF3XCu/yzOcnbXfWpBNpfz+a
	gJ0imzuso0yUNLZGd9eJ9Vfx77awoR+d2IRr8GDmb5TxTkdNpEq0dFaTYisTbFLb
	ARZRVYwm36zJnaeTNq61GIvYZP07WOkGVF6bsRpB30ptGkSeGcvhanrD0jJmSNGZ
	EV/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696615189; x=1696701589; bh=LUR07i/CoESe7
	pjWusXonCUaiL+SxGLf47l6Wv1tu/w=; b=D4KZyUE4v1vOMLpbZpBek+IGDl1Q2
	loqhf1k0j6U26VFd6c+UNikD1CQJ1GMrIzHlRt1Vul5rlWZJVOp6CZPMUmmtPelf
	ZPLY0J9GLD3v61sGplSCUDCwqwULfqbYPiZ0EF1VSCgERm6ip50jylXDglbKZG65
	6rhnWlJjfKg1fEGBcQVesY5Kp3ovJzPF5hUGzBpMbQlw3uI4wjRvZb6vFoi5zNDW
	USV9BZ/uAhVAFSt53pyGiC1Kj5Au4PDtfw5gfer9CpQXfvLYaqgwZLjXVgie0ZH+
	ONSFknMrt6H9NLkN3Cq/z0tLVn5Ow+Wj6oKWIVYV/5OxD7w39P0iIYkQQ==
X-ME-Sender: <xms:FEsgZV-SH8thipwzI3rvLubXy2r9TxZnuz3pR98Y2wIj1HkDfD8dKA>
    <xme:FEsgZZvIfHPGUR_XsBSOlJrnGYpxufXSXEORHrCV5iBziWOYJX40flDCl-k782f-R
    k7-sJHPlMcIHQHXGg>
X-ME-Received: <xmr:FEsgZTAEoZiJb4HWtcLZ3-FQCuKfyf7CMCNjqzYq_vujy5I28D_OeNw5fK0X4CDACT0xfizBwMSEOjWV6K0C34P-YgHZbng-FAYdA3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:FEsgZZdUdWefjYIAp6yI_pworw8nfNPycqX05xoix3vma4Bm2sja6w>
    <xmx:FEsgZaNybKAv-qBUShHn8OJJ9E-myR4ki3GGoY_2rwiaklXoSfPCbg>
    <xmx:FEsgZbndVUZbNoOvnRET1QNARggLCxZbTjb71Pb97SYPIc-KwPq5ww>
    <xmx:FUsgZWmYPynFNQQyCgrFIOxHkjbjDCsyRHbln5nliph2kucPePA1zw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Oct 2023 13:59:47 -0400 (EDT)
Date: Fri, 6 Oct 2023 11:59:46 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	paulb@nvidia.com, netdev@vger.kernel.org, kernel@mojatatu.com, 
	martin.lau@linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return
 code
Message-ID: <ncblypbr7vshhgeuuxxvs6k7lapu4ooxyiecqn3yitlhnmw5bl@tdjlc4s4tgvj>
References: <1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net>
 <CAM0EoM=SH8i_-veiyUtT6Wd4V7DxNm-tF9sP2BURqN5B2yRRVQ@mail.gmail.com>
 <cb4db95b-89ff-02ef-f36f-7a8b0edc5863@iogearbox.net>
 <CAM0EoMkYCaxHT22-b8N6u7A=2SUydNp9vDcio29rPrHibTVH5Q@mail.gmail.com>
 <96532f62-6927-326c-8470-daa1c4ab9699@iogearbox.net>
 <CAM0EoMkUFcw7k0vX3oH8SHDoXW=DD-h2MkUE-3_MssXvP_uJbA@mail.gmail.com>
 <2ce3a5a1-375d-43a6-052d-d44d7b4a4bf8@iogearbox.net>
 <20231006063233.74345d36@kernel.org>
 <686dd999-bee4-ecf8-8dc4-c85a098c4a92@iogearbox.net>
 <20231006071215.4a28b348@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006071215.4a28b348@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 07:12:15AM -0700, Jakub Kicinski wrote:
> On Fri, 6 Oct 2023 15:49:18 +0200 Daniel Borkmann wrote:
> > > Which will no longer work with the "pack multiple values into
> > > the reason" scheme of subsys-specific values :(  
> > 
> > Too bad, do you happen to know why it won't work? 
> 
> I'm just guessing but the reason is enum skb_drop_reason
> and the values of subsystem specific reasons won't be part
> of that enum.

Yeah, looks like the subsystem reasons are different enums right?
There's probably a way to still support it in bpftrace but it might take
some minor changes and/or ugly conditionals in scripts.

But I also wonder: why are the subsystem error codes not included into
`enum skb_drop_reason`? It looks like the enum space is partitioned
already. And the modules have already registered themselves into core
kernel (in `enum skb_drop_reason_subsys`). So even if modules are
compiled out there are still hints of it laying around vmlinux.

Thanks,
Daniel

[..]

