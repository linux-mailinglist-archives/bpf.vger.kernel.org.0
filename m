Return-Path: <bpf+bounces-4509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3FB74BFBF
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 00:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB8C1C208B8
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7BCC2C2;
	Sat,  8 Jul 2023 22:02:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA97C121;
	Sat,  8 Jul 2023 22:02:53 +0000 (UTC)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0DE4A;
	Sat,  8 Jul 2023 15:02:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id E322A580114;
	Sat,  8 Jul 2023 18:02:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 08 Jul 2023 18:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1688853770; x=1688860970; bh=us
	dNVu3zHxYIxjv6CIUqKF4RVb+FJwD+QutAZ+SONzU=; b=Na9HAOrBe8T77a5nS8
	52BWoRWX8ndJggaCp8w2hNy4K/Hx05IOEQ4yQObUd9fMIYSzLmsi2a/O6epJ5qvc
	W1eTLx5OU8Jpuw71pSiX/7bL+A0gmS5EnPpo/ZvAQxOl34rA2JhaTspyfWvR9mew
	LjdBY1z3zRDNj8gDVFEsrg9hI9I1rE8aXIgux5JIzDTevLhwYasC8HlujidS2Rg3
	oeJkgsDN6rPckNAf5xIuvB3MIfc0wa1XzXyA6XJCvKOhB1PfUmFuV1F+DA/txx2C
	TFbBrfHD+x1kG8ttvq4wr/4p9E7RxfKkXhuqHUKMqWFPPPaxDCC9Ys4dGOFy+4cQ
	awtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688853770; x=1688860970; bh=usdNVu3zHxYIx
	jv6CIUqKF4RVb+FJwD+QutAZ+SONzU=; b=gLSbU0FM8ylBPR+gKikOZL72bXg4z
	IHWrM01pn4v4sFGSuTAMa0jUmx/6nKepFuAczDtUIN4J3C94mnWcSypEkGGgS2J1
	mGy8lR05n3puher+YyQNfmzSlL2GU9mMD1DhIJTcKumAT+QtdDJ0A/u4JJJYSvZv
	eyDq7SxbHIFPFOBMY/8d1jvV7iUaGKioK5hI2U4ZQ+D+s19Q3lbUD4T0bRHPbtp0
	uzaetPHGfbgo4RgY/uG0DkOAY7dr+2bPrjfsd1QcQj26CDDuX3yjsA6QAA85mPbQ
	90OruCSXhseKCEN1UWdnOGtaxese77/MFKkNpfXIkFMWubac2wkQXSo2w==
X-ME-Sender: <xms:Ct2pZLPezmiPRfS7RQ2AziRWnbkCO-SBrt5gNWhdYahWQMDPOMj2Zw>
    <xme:Ct2pZF_AI0vEveQXmGwcA0MiwcyMIj4X0TipjSPsUVzm2AKQHhZ4dgzRKK2VDlc-L
    sBe8rn9UBn9wfCQ8Q>
X-ME-Received: <xmr:Ct2pZKSaAs7H_RFpxRqD1o_ZfUCT2GYy7viKmzvZToivBmOJS_EyAFWUB--qh24exof53BrYpJc-AAI4BahUt5NntHTmLaFStPAy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepfffhvf
    evuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvfeekteduudefieegtd
    ehfeffkeeuudekheduffduffffgfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Ct2pZPubHhrrL27ZUQdUyldzaPvREVafRm0CCrMDuMBiyn7ohLsKuw>
    <xmx:Ct2pZDew01A9HDNME-YLrgkhq_nkzqZ4-_qgVFPdOukg9DWnuiwx1g>
    <xmx:Ct2pZL0NDkARbTAJPhbHqRoye-XF5eV8FUGKPEvLrjsdz-fDaYAczw>
    <xmx:Ct2pZJ_wOCWsbTL566CZ0YC75D2q-lxQjhcAUTELBBPebJBTzY23bA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jul 2023 18:02:48 -0400 (EDT)
Date: Sat, 8 Jul 2023 16:02:47 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hawk@kernel.org, tangyeechou@gmail.com, kernel-patches-bot@fb.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Introduce user log
Message-ID: <v76ytdfdf2sqhdufkqxzsuznandia3x4l4iyghpirxkzytngxq@uttzaebbmdjb>
References: <20230708040750.72570-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708040750.72570-1-hffilwlqm@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Leon,

On Sat, Jul 08, 2023 at 12:07:48PM +0800, Leon Hwang wrote:
> This series introduces bpf user log to transfer error message from
> kernel space to user space when users provide buffer to receive the
> error message.
> 
> Especially, when to attach XDP to device, it can transfer the error
> message along with errno from dev_xdp_attach() to user space, if error
> happens in dev_xdp_attach().

Have you considered adding a tracepoint instead? With some TP_printk()
stuff I think you can achieve a similar result without having to do
go through changing uapi.

> 
> Leon Hwang (2):
>   bpf: Introduce bpf generic log
>   bpf: Introduce bpf user log
> 
>  include/linux/bpf.h            |  3 ++
>  include/uapi/linux/bpf.h       |  8 ++++++
>  kernel/bpf/log.c               | 52 ++++++++++++++++++++++++++++++++++
>  net/core/dev.c                 |  4 ++-
>  tools/include/uapi/linux/bpf.h |  8 ++++++
>  5 files changed, 74 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 622f876ab3ced325fe3c2363c6e9c128b7e6c73a
> -- 
> 2.41.0
> 
> 

Thanks,
Daniel

