Return-Path: <bpf+bounces-13586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9E17DB0E2
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 00:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618ACB20CC5
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 23:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC214F90;
	Sun, 29 Oct 2023 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="K0cNF8xx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXfRGArM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB0EEA2
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 23:22:07 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB91B690;
	Sun, 29 Oct 2023 16:22:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 955CA5C00EF;
	Sun, 29 Oct 2023 19:22:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 29 Oct 2023 19:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698621725; x=1698708125; bh=jAiuAMSOIMa8Cg5aa4qggKms7FgUgfk0/cV
	Ya27X7G4=; b=K0cNF8xxyKoL7GjLQgX5JcM8YDseoua1sFJjn2T0+BQbhNScNjb
	y+MvftAgcAqm3vaWRq+qDz6k+EjraAW+HUkHuKsZ7gUahWeSAD/0Hww1TT0VtEP2
	VXLqrG3WW3Up/mz0fBlWmv5QM64T8mBOVKLGCW1TVbvc0AQxQivdE5v8vVvHPGZi
	/VdN4x8XQd19iMrj0ex25hOs38lvKdYMj6vq1H68c12Ds0ox70OepMCZkGZzveg6
	FcRQuj8igpENN41hsM2V7IOQCgswtU7Tc25HOdYl37IpJfx4ur1fPi/SvLim9Mzr
	3gkw+3HPdqCTWoJoNiFSvtnSqXPPjgLjNow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698621725; x=1698708125; bh=jAiuAMSOIMa8Cg5aa4qggKms7FgUgfk0/cV
	Ya27X7G4=; b=cXfRGArMSrk+/hlXVi5EBhMBZZFct7Dw3Y/WfIxULB9O28Feshs
	cwI4kJYscJg/E9cZu0NKbp/CPq5bsTrbo/C2clsozebQI4F8VWBVjtunLvve0Rw8
	O25zEOkAI2i4ZAhFwJs7IztIy/rNLxqMVPz2KSUEH7j6dz6a6PCnxp0oiW3pXAjF
	3KkBZZS9CUcC9AtM3pKXJjVVslHOMCJlJ/mSxZJQ149pEG7ixQj/c2G803MOJqbj
	HAKQ42jHhBQ4EGdFL7nV3gHt0MQRgj3CkKWMFL/Uquyk8QyRJBN58RrdwLcL7lZA
	5SSDAnC/XHvqIft/ZmRQUsxrA6NqhqcaLgA==
X-ME-Sender: <xms:Hek-ZaCpBbLg5t0htzkPGX6koBSnpmJ2mdQczDeIQy3b-OGoT3K8NQ>
    <xme:Hek-ZUgVRUr6d79FdVr0_dZMAZPt3J14uq1S6DTZp_TadlYg3rpgBMCbK80zX0SJh
    whr5Gz9_QvjsclY-w>
X-ME-Received: <xmr:Hek-ZdkXSbaONFMTrJIEZ10YrXcv59pAFY2m2GUULPrCMuBe19kC5AtaAaIwynx8abrWI5l6Aa5xVjjmDsGQx6lLJKvintR05A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleelgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffevtddv
    jeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Hek-ZYyJe7dNVXmUwDhzPPsR70ZJGRqSgLSkXkacA6f72wm490f3Ag>
    <xmx:Hek-ZfQcgY4EL9_HIR_OTitiYyam4uXAgH2U-r7CFCQUSmXowtHVrQ>
    <xmx:Hek-ZTYo03aFpUarKSTLoTFDbHGn7Sxnaizmqous4sxd5ytty2Cd-g>
    <xmx:Hek-ZQJMN_ej-_IhBpIgZFAORobHNb04GZ5QR29RLau8VHyh4Tc9QQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 19:22:04 -0400 (EDT)
Date: Sun, 29 Oct 2023 17:22:02 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, shuah@kernel.org, 
	daniel@iogearbox.net, steffen.klassert@secunet.com, antony.antony@secunet.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devel@linux-ipsec.org
Subject: Re: [RFC bpf-next 5/6] bpf: selftests: test_tunnel: Disable CO-RE
 relocations
Message-ID: <73xnkgitatvymw2bqwo6elqmdpsvj2atmh6ugrityvqyegguq7@cjos2bsw2ico>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
 <111a64c3e6ccda6b8a2826491715d4e8a645e384.1698431765.git.dxu@dxuuu.xyz>
 <CAEf4BzbwHZmCJHe8WiV0WeUV1XC+cDB4d4v8YLJh+ZL_k7yB1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbwHZmCJHe8WiV0WeUV1XC+cDB4d4v8YLJh+ZL_k7yB1g@mail.gmail.com>

On Fri, Oct 27, 2023 at 01:33:09PM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 27, 2023 at 11:46 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Switching to vmlinux.h definitions seems to make the verifier very
> > unhappy with bitfield accesses. The error is:
> >
> >     ; md.u.md2.dir = direction;
> >     33: (69) r1 = *(u16 *)(r2 +11)
> >     misaligned stack access off (0x0; 0x0)+-64+11 size 2
> >
> > It looks like disabling CO-RE relocations seem to make the error go
> > away.
> >
> 
> for accessing bitfields libbpf provides
> BPF_CORE_READ_BITFIELD_PROBED() and BPF_CORE_READ_BITFIELD() macros

In this case the code in question is:

        __u8 direction = 0;
        md.u.md2.dir = direction;

IOW the problem is assigning to bitfields, not reading from them.

Is that something that libbpf needs to support as well?

Thanks,
Daniel

