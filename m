Return-Path: <bpf+bounces-12372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3517CB97F
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 06:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5742128188F
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCF3BE5A;
	Tue, 17 Oct 2023 04:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="iifNoFaM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F221FD5
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 04:05:20 +0000 (UTC)
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0577F83
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 21:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1697515512;
	bh=d+gjj/JtCObXSF2BZmuvUynTWYooh4DTnusDDUHlLgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iifNoFaM3yBnicXRU9azAFAMGRCz/G3L3IKDHCoXvVtAX+VkLov1ZiKvLbI7e8l24
	 jjkOB4XlKdrBdjnKWTNEJUnL2EcGILBCsNFl+y05rOmxSHrX39617pUHRVV52Nt7Dk
	 r3LLKGBnBDeqLgWLdcWYfbbkW/fIH9TdyKeEY8bA=
Received: from lb-dt.. ([117.32.216.61])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id 10310E86; Tue, 17 Oct 2023 12:04:03 +0800
X-QQ-mid: xmsmtpt1697515443t22xfk8f0
Message-ID: <tencent_E339382F4BA4C7B1890CE59F61787D532D09@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3No5Aw4jUiTM/+FHoUPXLCA9Mh1VSQHNDlChKu31dLH0lBxbKmw
	 0FbtsL4sh0Oec7KhYXhSM4hZVmdut8VFQlvYmsstgMXJlzGf7No+7YIWVcCQMRKA0YYPnswL8xS6
	 jU3p1X5u/ld9/7YWJR+QUMhtqRmlokeF2Lvojrq8SDCmHofdCBh3JGmzsoCcv/eJjAAuOMtcf69I
	 fdEAiTdnF+V89+GUD5Mv25yVM8m2u/SwMcAhIVIGhRMMSQg/+/aZvGy4nIwMQ8Tgbln7pWLGRCwp
	 QiCbgGPjMgLMVEXcq1SBRYrQf/YJbE7lZAsLcVffyMFRO+FkgwJaMSXd4363hsGDUFglhnqM6eUP
	 Q3EdmoHbRh+pLwobyn30tYkaXEonb9s1U69KKgdpLOl+KibtcQrxIkq+9nH1uYcZrjoGJaa+IyZA
	 OiwwdWBNta2HuNbeYXWRBCpTm/Ay0o+2dBQyth6PVept+xJClfUxiEoD4+eIDaERogfNh9o3jAtZ
	 Ro//v/3L+qCdUEZygXckwumztow+2skKNmC4h1Q7Sgu68KucQQLyN8ToaK1hejfWN3s390HJXort
	 mvl0oAXM2bu4bJSv6JrzmMZnS8TVUkRyBb2bI8m44Ni7zE9Qv/prim8cYADykWAPRTumHX1o1R16
	 xWK++XvGW1f81gz40cVjVdJ5F0kFoVfnAocZ6tDnW4y4Cuu9dobvYwpRpbNfICcnrKwqUb43Bn/l
	 64/0ZchVrH4DFySwx3LKGH6XurHlvuWEs4BkdxdoppxVKcf3zRsGG50LOY29tKz2C7hhduFK302s
	 g/5/s2HIHIUbrlPipqyZbAanCWjVr9N8XC9bFH3mOna4WxTPHKd+t8pbPLofo0d6VUoIlXCwyVyH
	 z1gJzYiGSdkSL5QBQU/dh8TrEKV5+lxBLfBvYQXonFH/2IWDDrzMnZq1cX3rid/SdtG0UbEQPvcK
	 6i7Y5GOFC3RY5/zU77AoTl6ToN6FKOYz8SW+AUUVT+YxxpByAHnQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: LiuLingze <luiyanbing@foxmail.com>
To: andrii.nakryiko@gmail.com
Cc: bpf@vger.kernel.org,
	luiyanbing@foxmail.com
Subject: Re: [PATCH] Fix 'libbpf: failed to find BTF info for global/extern symbol' since uninitialized global variables
Date: Tue, 17 Oct 2023 04:04:01 +0000
X-OQ-MSGID: <20231017040401.320281-1-luiyanbing@foxmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAEf4BzYYdLX9+=juNHwMmXeOO_EbGF7qXf_FJjLjLFPjpzKkfg@mail.gmail.com>
References: <CAEf4BzYYdLX9+=juNHwMmXeOO_EbGF7qXf_FJjLjLFPjpzKkfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 8:16 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Sat, Oct 14, 2023 at 4:27 AM LiuLingze <luiyanbing@foxmail.com> wrote:
> > 
> > Hi Andrii Nakryiko,
> >
> > > On Fri, Oct 13, 2023 at 6:45 AM LiuLingze <luiyanbing@foxmail.com> wrote:
> > > >
> > > > ---
> > > >  examples/c/usdt.bpf.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/examples/c/usdt.bpf.c b/examples/c/usdt.bpf.c
> > > > index 49ba506..2612ec1 100644
> > > > --- a/examples/c/usdt.bpf.c
> > > > +++ b/examples/c/usdt.bpf.c
> > > > @@ -5,7 +5,7 @@
> > > >  #include <bpf/bpf_tracing.h>
> > > >  #include <bpf/usdt.bpf.h>
> > > >
> > > > -pid_t my_pid;
> > > > +pid_t my_pid =3D 0;
> > >
> > > This is effectively the same, my_pid will be initialized to zero
> > > anyways. The difference might be due to you using too old Clang
> > > version that might still be putting my_pid into a special COM section.
> > >
> > > Also "failed to find BTF info for global/extern symbol" is usually due
> > > to too old Clang that doesn't emit BTF information for global
> > > variables.
> > >
> > > So either way, can you try upgrading your Clang and see if the problem pers=
> > > ists?
> > >
> > > >
> > > >  SEC("usdt/libc.so.6:libc:setjmp")
> > > >  int BPF_USDT(usdt_auto_attach, void *arg1, int arg2, void *arg3)
> > > > --
> > > > 2.37.2
> > > >
> > > >
> > >
> >
> > Thank you for your reply.
> >
> > Yes, I was able to compile on a newer ubuntu with a higher version of clang.
> >
> > However, on a development module (nVidia Orin AGX) running an older version of ubuntu, it is not possible to use apt to update clang to a new version. Downloading the source code of a higher version of clang for compilation is cumbersome and affects compatibility. So I hope that with the above changes, the project code can be easily compiled and used in earlier versions.
> 
> Did you verify that specifically adding explicit `= 0` makes it more
> compatible with old compiler or it's just a theory?

Yes, I have compiled usdt successfully on Ubuntu 20.04.6 LTS with clang version 10.0.0-4ubuntu1 by specifically adding explicit `= 0`.


