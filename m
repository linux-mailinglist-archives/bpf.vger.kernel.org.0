Return-Path: <bpf+bounces-6576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC876B87A
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F8F281A38
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299BF4DC9C;
	Tue,  1 Aug 2023 15:20:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D724DC90;
	Tue,  1 Aug 2023 15:20:18 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EDB10F5;
	Tue,  1 Aug 2023 08:20:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E7CC75C01DE;
	Tue,  1 Aug 2023 11:20:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 01 Aug 2023 11:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1690903215; x=1690989615; bh=gJ
	mKl0XnfNOfeViEaAye1ljmUyCgjpGGF5LwtdmY9m8=; b=kAI8OP+w7hRnTsNISf
	Uz+0k1ByOl3+BgqmhHW9gkvOaahlgmnyQYuQXD0XvuiC9wbgMXM+fUWkkxp0+vZ2
	HqA6h2rJh0ciY1zXNCldFw8QkHIcXqBNbAqm9ygVKkUkMFc1ohf4++NLc+6uUgXr
	9WhZ/xhp1GqOI9MDlYiO7QkatBosPBRWgoCTCqEPVlZvjua1IweDyTJP77cMOZBn
	dc86f1YG6SOXdeazIGGb/lBpPWrMObPdqseYvBMPzexLCojwScx7TusVPKSIiqNw
	9oRic0LKT/n5BXIIAYJ/6zwEBYeTgKvmopa3VM/LGOT/SZX10vLcB8aPADrHMLvv
	E1aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690903215; x=1690989615; bh=gJmKl0XnfNOfe
	ViEaAye1ljmUyCgjpGGF5LwtdmY9m8=; b=U3O8+Gro+DkZxLXCtbWwh6i9IVZXB
	hNHMFHthh6/il7yvHM4u1C6NOh/jSLpAXZA83VYSmVOmH0VLK+0Ydg2RUpg5Mlza
	25wh7vqZVROnVgoCa8/9hXlYUCoNu7ZYbeaH5IFalx9vBv3a0kjP+5mx8IoSs4SW
	xKGENUCVy1ZlWdxgXopgv+5KoPPexXR6Rz3CHmBzxLyAHM/Z+IPG6zdMTxSS1NxM
	WWZ1jHC3yY0xfF6hV0/ycGiy+ozB5CVKmyBnoS6jDcPoW275+TOFxLYwVCYeyTSC
	A2TNvuqCGz0ts8Frf0dbZjpMqSrMYEka4l4h5hHkGEeWbaGXavGsbFLDg==
X-ME-Sender: <xms:riLJZLBKShiHEt2Jt0XrZxQlvbCqcP8vETNLGad1i2726e2Kq6t8og>
    <xme:riLJZBgJ8thDWvPCaILDz5Q-jFTPISTjfStM7Kz6vFX8rQiSn_7sbTy_tOwm6tm1w
    _S7RD1sLf6DEKh7Qg>
X-ME-Received: <xmr:riLJZGnHufzWUOKIv0dzHj-Q4YwEoPHbYLQCgWYwXbhUu7pYs5Hvoi77dySZyueS9H3ugM3VYXbBzwN0qmefzMdBqy2Ocmc5exQzRes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:riLJZNyp8avT4hqkWtTi6P7QFYLejjQX1DmMAko_e6a1u1Y1cSuQnA>
    <xmx:riLJZAS_lO_aF1M4T4pQrfMD4BAr65r2RhU0HQpogBNz8g4CQAtu9Q>
    <xmx:riLJZAaJibbHNJLxn4HWL59zmo30xOjafDy0_v5LUPIbHJUB4m0gTA>
    <xmx:ryLJZCBKkD_yXavyx1-3FGHLfr9nSP4AUF0aamOKeyb6FaHa2n4t1Q>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 11:20:13 -0400 (EDT)
Date: Tue, 1 Aug 2023 09:20:12 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Arnd Bergmann <arnd@arndb.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] netfilter: bpf_link: avoid unused-function warning
Message-ID: <z3gp6rcrlotwjwux7chza4vmbgv747v5jlr4xhuaad3y2yofsf@jjiju6zltbmh>
References: <20230801150304.1980987-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801150304.1980987-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arnd,

On Tue, Aug 01, 2023 at 05:02:41PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added function is unused in some random configurations:
> 
> net/netfilter/nf_bpf_link.c:32:1: error: 'get_proto_defrag_hook' defined but not used [-Werror=unused-function]
>    32 | get_proto_defrag_hook(struct bpf_nf_link *link,
>       | ^~~~~~~~~~~~~~~~~~~~~
> 

This was fixed in 81584c23f249 ("netfilter: bpf: Only define get_proto_defrag_hook() if necessary").

Thanks,
Daniel

