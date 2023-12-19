Return-Path: <bpf+bounces-18322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4D818E20
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634681C209D7
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96248249FE;
	Tue, 19 Dec 2023 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="APPs7gdz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rYTcB+6H"
X-Original-To: bpf@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86435296
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 610ED32009F7;
	Tue, 19 Dec 2023 12:29:20 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute4.internal (MEProxy); Tue, 19 Dec 2023 12:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1703006959; x=1703093359; bh=x7R0qj/KN51A2XGxKOAligc9qbyWNzeD
	ou9KD8RBisM=; b=APPs7gdzf06f79DMVt0sZS17FlYxiRcKfsd/UypTABCjo14p
	Lqfoj0vvHFPr+KUX0qkEZ/tvwtKpe7HbV2Jq/Vk0+jNNybv8c5dWmlFY7tHHnxOB
	8eULyh8N+ENa1wPFjSkSm0wheROweeCiuREFMzBgGeXcfbxvaaWVjTkbRTdITPn2
	fE59PZF7pohrF5jp3AewX0Vg1zzlJUdIfzb4ByCxt94RN7KFL/Of3y0/ry+TEaDR
	wqaU2y66Oa01DSautVBzTeBkND+QG+gEvj+LuamIHdPPLnBE72Evl8bLxZPKmAI1
	udTF1Q8H5o3lQVKz68RMOm3jUIm0oqK4a+yKDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1703006959; x=1703093359; bh=x7R0qj/KN51A2XGxKOAligc9qbyWNzeDou9
	KD8RBisM=; b=rYTcB+6HaclHMYbCR7CdEC118DIsUlJGd1pZIUNc+9XHrrJdAiP
	9SeK25moQwN/HPlNkOF9HAdTgSw4K0a67yJDv3yl4Dt+BWv6TR2wqRGNgrwyGQaO
	reDKQMz6GFuzS+LykoO8kYIIwLrsTa5OKl9v84owtsAy22XoqlA82BAnDVb3ko+2
	vNnT+FozKJYeXDuUO4ymX40PF8aGTk9FW6uIxHdp9ZyGrtIlUJeMTQXjFVGWXwJ+
	tNh7q1JSzvXHgvbEVg6IQPJOUQWq/7t0vrRh13B50m6RsZVVz3nSju7Y56Ryc6JL
	+yPlBB1OYEfmRoaSYwH1lF+L96ca9Yh5X8A==
X-ME-Sender: <xms:79KBZUabEHn4SbxVujnNyvTKK9LxOwgdBzHYG5Msi_1v4ZcMQAhNaA>
    <xme:79KBZfYcEZhkU5-imI1xaIij8odisVbX1z-07HcIl2X2OFJpjTKGMeFJATsogF-s8
    VbYF05tMIVFwolzxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhepof
    gfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedfffgrnhhivghlucgiuhdf
    uceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepjefguddtueekle
    dukeegueffgeeivedtffegkedtveekveehveehudfhjeeuhfetnecuffhomhgrihhnpehg
    ihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:79KBZe-wdh1fFbWT0TI-ks4bfd-tf_3OwXExGVo0AKnfvypQS_hWmA>
    <xmx:79KBZep7t9HEl-TyucKIGCN3Q5rhL9k7bowuko_s-W5xLmNPQflpYQ>
    <xmx:79KBZfrCb4h6EaUxuqHOVxz1DZwDLHtCJG4xaor25Aas0jjWUeS0OQ>
    <xmx:79KBZZG4g6RsQhRsFuFT8GZrnGyrRWIhKKuj2dczFX5kia7R3iq8SQ>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9F4F3BC007D; Tue, 19 Dec 2023 12:29:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1350-g1d0a93a8fb-fm-20231218.001-g1d0a93a8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <67b0a25f-b75b-453c-9dde-17adf527a14a@app.fastmail.com>
Date: Tue, 19 Dec 2023 10:29:00 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: quentin@isovalent.com
Subject: Dynamic kfunc discovery
Content-Type: text/plain

Hi,

I was chatting w/ Quentin [0] about how bpftool could:

1. Support a "feature dump" of all supported kfuncs on running kernel
2. Generate vmlinux.h with kfunc prototypes

I had another idea this morning so I thought I'd bounce it around
on the list in case others had better ones. 3 vague ideas:

1. Add a BTF type tag annotation in __bpf_kfunc macro. This would
   let bpftool parse BTF to do discovery. It would be fairly clean and
   straightforward, except that I don't think GCC supports these type
   tags. So only clang-built-linux would work.

2. Do the same thing as above, except rather than tagging src code,
   teach pahole about the .BTF_ids section in vmlinux. pahole could then
   construct BTF with the appropriate type tags.

3. Have the kernel export function prototypes (with no forward decls)
   in a pseudo fs file. bpftool could then append the contents of this file
   to the end of the generated vmlinux.h. Unfortunately this would rule
   out minimized type dumps (IOW only dump dependent types for kfuncs
   or something). Unless bpftool wants to embed clang-front-end or
   something like that to parse C.

Would appreciate any thoughts.

Thanks,
Daniel


[0]: https://github.com/libbpf/bpftool/issues/98

