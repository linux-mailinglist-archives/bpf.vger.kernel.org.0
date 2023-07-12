Return-Path: <bpf+bounces-4865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA7750ED4
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 18:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679C31C211A5
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B3814F95;
	Wed, 12 Jul 2023 16:42:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40A1FCF
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 16:42:12 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7331BEF
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 09:42:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 0772F3200645;
	Wed, 12 Jul 2023 12:42:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Jul 2023 12:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1689180127; x=1689266527; bh=+UgfY7JqUNSMHN0uyBZPjclXzHQ/Uw8KQwi
	yywYvxso=; b=d2Ckx9CmBE7AMH9GNCAJMBzI4qsPnKzcwiir6laa/3iSWcVjMR3
	xlcMTyLK3G+DYjcumA4VSZ0OxTzCs5Tt/J2rnLE1TencDhmhFjVqd4Z9W6dZm/MU
	qhBitf5IBzqyU6sovRSwbWFuoRUNLa/X+nGcgia7yP0ezOf+xcLe0s8lOPEP/pax
	t8vLFEHE6iKIwi2CW8Iv/CjUh7gMV8e1NsWExzHWALRlKyTU1LsMAHwkOKncVhax
	URzDs4rjw48KxIug9jew/MlYMBG0rQicvFF8RkhXsm8pFIKbmJb1sGfMYkKG6Ynp
	586ZYp4WZoRhgDPiCiak9fpl3fAa8Ofigbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1689180127; x=1689266527; bh=+UgfY7JqUNSMHN0uyBZPjclXzHQ/Uw8KQwi
	yywYvxso=; b=Gl482N7CThmH8hzT0HgWBvxJyonPjmA3au4MvAt3ZmAVLpdHWhI
	nfXU80A+2ThNKbcEXybvYKhYQXJYJIw4a0fYwxOrnBuYJrJ5RlQNh81sDQrKMXzu
	sI1x1AUC22DASjWY0Mo62aoRMS2y7L0dJhR3OcdYmcqgkgEIsANxbQ4UrfaZuPC+
	sTnnnajOQ1y9buUpDcOFbRHz5xTS7su5AhSzyjgA0NoBbTUFXW2Yhm5u29D4Qr3E
	3A+YbLB2MI1cjbDpkQOnLtIVwuZYnfPWDjouS4wiZ916ONciCYvGlzK+XQL8Z7lO
	U+YKAuIt2TBu8ExN4l09IalJChUcESAxzrw==
X-ME-Sender: <xms:3teuZAT9_pb5_6EVWpMySoepPcWnldBkMAQeG_T2p7shBxo5yEbtXA>
    <xme:3teuZNxuiWE_kU_np3KZs6asPAUHYLg5x2oNI574SWPBYQPziocic6wV5xUXN2wxV
    FUzmNPW9x0uLQM4CQ>
X-ME-Received: <xmr:3teuZN0zTvPVuhenr0lyF0ONfABIG6ZCwUvZy0Q3DXk_40R0HSEsYiWMn_ZxWhEo3eQv5CN18YBunv5VNUQKRIoqwNTwq_QHJ4SU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:3teuZEAPhJWc5krth_xHrqP6JjwbXB3Cxh12eoj1qXi8csyy4jgn0g>
    <xmx:3teuZJjCMRoL3Ztukosu5C7lNxKg9EHtjGGB7SoSyMGSMC0D-7iA_A>
    <xmx:3teuZAoHC5EZcFPvX4PeVodvORSwYxG6OARCV67Mt6JMuy5cddDOXQ>
    <xmx:39euZMuKCY2OBYigaEbQP08tywabYlT-VjU1Ic0QQ2yuZ2M3EfvHhA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 12:42:06 -0400 (EDT)
Date: Wed, 12 Jul 2023 10:42:05 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, vmtest: Build test_progs and friends as
 statically linked
Message-ID: <m4f3vzvkgt2iov3yvqhdamkkjnoqgqqhhuf3xvrh5cgb4ifohj@g6pybaplatks>
References: <05b5dd79465be41ff8cf8b56b694118a0aa7ae12.1685140942.git.daniel@iogearbox.net>
 <CAEf4BzYZBC_518wLTEXVo4+QyJ=Lsx0BYuVsL38xYdPfGOKHEg@mail.gmail.com>
 <8005de2d-5e10-9eef-2a0d-6f15aa681c05@iogearbox.net>
 <dm7i55664qqp64gogp2gbfljivgiexckw5pnvljoldtxbk7or2@n6kjeviz23wn>
 <0456d565-a0d9-8c37-b36a-2d9b2098733d@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0456d565-a0d9-8c37-b36a-2d9b2098733d@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Daniel,

On Wed, Jul 12, 2023 at 02:38:50PM +0200, Daniel Borkmann wrote:
> On 7/11/23 10:15 PM, Daniel Xu wrote:
> > On Wed, May 31, 2023 at 09:53:57PM +0200, Daniel Borkmann wrote:
> > > On 5/31/23 9:02 PM, Andrii Nakryiko wrote:
> > > > On Fri, May 26, 2023 at 3:47 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > > > > 
> > > > > Small fix for vmtest.sh that I've been carrying locally for quite a while
> > > > > now in order to work around the following linker issue:
> > > > > 
> > > > >     # ./vmtest.sh -- ./test_progs -t lsm
> > > > >     [...]
> > > > >     + ip link set lo up
> > > > >     + [ -x /etc/rcS.d/S50-startup ]
> > > > >     + /etc/rcS.d/S50-startup
> > > > >     ./test_progs -t lsm
> > > > >     ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
> > > > >     ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found (required by ./test_progs)
> > > > >     [    1.356497] ACPI: PM: Preparing to enter system sleep state S5
> > > > >     [    1.358950] reboot: Power down
> > > > >     [...]
> > > > > 
> > > > > With the specified TRUNNER_LDFLAGS out of vmtest to force static linking
> > > > > runners like test_progs/test_maps/etc work just fine.
> > > > 
> > > > Should we make this a command line option to the vmtest.sh script
> > > > instead? I, for one, can't even successfully build on my machine with
> > > > this, probably due to missing some -static library package (though I
> > > > did install libzstd-static). I'm getting:
> > > 
> > > Interesting, in my case it's the other way round, but yeah that could work
> > > as well.
> > 
> > I had the same zstd linker error. This hacky change fixes it:
> > 
> > ```
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 9706e7e5e698..c0d8809fd002 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -31,7 +31,7 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)    \
> >            -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> >            -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> >   LDFLAGS += $(SAN_LDFLAGS)
> > -LDLIBS += -lelf -lz -lrt -lpthread
> > +LDLIBS += -lelf -lz -lrt -lpthread -lzstd
> > 
> >   # Silence some warnings when compiled with clang
> >   ifneq ($(LLVM),)
> > ```
> > 
> > Would be good to get some variant of this patch in.
> 
> The above doesn't work for my env, getting same error with adding the -lzstd.
> Btw, did the patch from above work for you?

Your original patch did not work for me (libelf missing zstd symbols).
But with the patch I sent applied, it builds correctly.

What is the error you're getting with `-lzstd`? My guess is that your
distro's libelf.a has zstd symbols statically linked in already. Perhaps
check what pkg-config says about your libelf? Mine is:

```
$ pkg-config --static --libs libelf
-lelf -lz -lzstd
```

Also, perhaps the build should be using pkg-config instead of hardcoding
deps in LDLIBS. That might make the static build more reliable across
different systems.

Thanks,
Daniel

