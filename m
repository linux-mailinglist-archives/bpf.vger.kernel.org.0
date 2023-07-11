Return-Path: <bpf+bounces-4802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C274F8DE
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 22:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835FF1C20F37
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB31EA90;
	Tue, 11 Jul 2023 20:15:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50F1EA7E
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 20:15:42 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C96212F
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 13:15:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 27CA25C013A;
	Tue, 11 Jul 2023 16:15:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 11 Jul 2023 16:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1689106537; x=1689192937; bh=4LrhlDXHj8aYOeV+b8X57to8+rDOSenPZGA
	Uczp8uv4=; b=HbVhw6WYECenrLXQbmtCr67vkd6+50mbXWIxuf8OBq2nJ+VJjP6
	CZrB6RMzL/uxrMJ2Erk8G8PHTD+vTUskcAYxcbgI/EKAWFtdDm4oDne2PNx5xZZB
	sI2lytT+7QrQhxjzwjudFG5iFP6BsVO5neCVfm4EpPWdEz0aUuakGdSO0IGJwBwD
	oPy817txgOIpb+SVCC1fEKS2z8ttM3Q9/X2HZW92EEIz9Q7ourkVUp+FBEpffqDM
	lCTcBejDOpNwFjTpAB7u6vNRoT+9WoH/rLee+//diKWOjruymJhJHFo1nyFlcbiu
	xigBTuiEe1IMRn6+IIRyyZV5P42khd7mIrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1689106537; x=1689192937; bh=4LrhlDXHj8aYOeV+b8X57to8+rDOSenPZGA
	Uczp8uv4=; b=K550uV4o9fBPg0MZpkqX77yP7TX5dX47uatMNNxUiiBemB6F1qG
	aOwavWYC3nQihtPWMX4zfkEPQHNgesGxAkdBGs9CMB+CsGiDzitB6lgkpFLdZE6I
	Wx1JZ97NJGa7iUn9KIHsbihXm+H/mvdZWeNea83O0v1uKNxxRsaIvs+CXMiQMupe
	x2idQNe/usyqgBAPWfbPBwW9hghNJDwGzgYYFWk+ROlh2MYezfOFx/kwbVhwQ3Zh
	Sdy0ld+AfHsjbcBrL9nyptUTiz2d9IpaIo0ibPlyZ2oapLe5PXEm51TNb2+Ag6fN
	KJyb8VauSAlMbxeHXn39hWlzKcRnsNi7jzg==
X-ME-Sender: <xms:aLitZPsiIDQmGsdOYjv96m3tfbkHf6l9Z80MjO8-C75DGEWd34iwOA>
    <xme:aLitZAeDdkIsFqpElRcA3FAY5SgboXi0R6VXIDJLhPN8TmfXXJzwqravaCwnx625y
    4_ZNVaEfXh6nOlfWA>
X-ME-Received: <xmr:aLitZCxsApqIUgHMXWbYr8b4JUFnaXH3JA3B61Jz1awaEsPZuGMkzA5oyEfpVyBNjIGdeasCrsXyg1iCz7jgGYGCU0KGeH7oN_Ft>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:abitZOMCq-UcHM7BrSfnt2_Fo7ccdH75-PYMDR6I-5nNUefBLn71uQ>
    <xmx:abitZP_w7y0XZ6Nwf2pNqRwap5aThmMGOo74Yz1vJfm3ZnFEMXuTSQ>
    <xmx:abitZOVSqe8j7eLKTvHPrL5kimOdQUzsgsR-ptC7N2rI2NezOb2fnw>
    <xmx:abitZBJ_QuVehRxDp-HESnkM9JOt5ZFpP5aIIkorzEtNq8Ksw2MVXQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jul 2023 16:15:36 -0400 (EDT)
Date: Tue, 11 Jul 2023 14:15:35 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, vmtest: Build test_progs and friends as
 statically linked
Message-ID: <dm7i55664qqp64gogp2gbfljivgiexckw5pnvljoldtxbk7or2@n6kjeviz23wn>
References: <05b5dd79465be41ff8cf8b56b694118a0aa7ae12.1685140942.git.daniel@iogearbox.net>
 <CAEf4BzYZBC_518wLTEXVo4+QyJ=Lsx0BYuVsL38xYdPfGOKHEg@mail.gmail.com>
 <8005de2d-5e10-9eef-2a0d-6f15aa681c05@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8005de2d-5e10-9eef-2a0d-6f15aa681c05@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Wed, May 31, 2023 at 09:53:57PM +0200, Daniel Borkmann wrote:
> On 5/31/23 9:02 PM, Andrii Nakryiko wrote:
> > On Fri, May 26, 2023 at 3:47 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > > 
> > > Small fix for vmtest.sh that I've been carrying locally for quite a while
> > > now in order to work around the following linker issue:
> > > 
> > >    # ./vmtest.sh -- ./test_progs -t lsm
> > >    [...]
> > >    + ip link set lo up
> > >    + [ -x /etc/rcS.d/S50-startup ]
> > >    + /etc/rcS.d/S50-startup
> > >    ./test_progs -t lsm
> > >    ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
> > >    ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found (required by ./test_progs)
> > >    [    1.356497] ACPI: PM: Preparing to enter system sleep state S5
> > >    [    1.358950] reboot: Power down
> > >    [...]
> > > 
> > > With the specified TRUNNER_LDFLAGS out of vmtest to force static linking
> > > runners like test_progs/test_maps/etc work just fine.
> > 
> > Should we make this a command line option to the vmtest.sh script
> > instead? I, for one, can't even successfully build on my machine with
> > this, probably due to missing some -static library package (though I
> > did install libzstd-static). I'm getting:
> 
> Interesting, in my case it's the other way round, but yeah that could work
> as well.
> 
> Thanks,
> Daniel
> 

I had the same zstd linker error. This hacky change fixes it:

```
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9706e7e5e698..c0d8809fd002 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -31,7 +31,7 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)    \
          -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
          -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += -lelf -lz -lrt -lpthread
+LDLIBS += -lelf -lz -lrt -lpthread -lzstd

 # Silence some warnings when compiled with clang
 ifneq ($(LLVM),)
```

Would be good to get some variant of this patch in.

Thanks,
Daniel

