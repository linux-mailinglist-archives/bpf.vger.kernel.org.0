Return-Path: <bpf+bounces-2624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BD77317E9
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 13:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200272817A3
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D7813AE7;
	Thu, 15 Jun 2023 11:54:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAB12B69
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 11:54:10 +0000 (UTC)
X-Greylist: delayed 30055 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 04:53:40 PDT
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FA44AD;
	Thu, 15 Jun 2023 04:53:40 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 13B33C01B; Thu, 15 Jun 2023 13:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1686829950; bh=Ygsqj9MEfuFdkw/AFoPE5PZdn8YrnScjzyhGoq4eJ18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y7khILg/b/enYQLLHeQg8SPG/xnLQik7XxgoYrDwvKVu5eP4v0nwN62wXM1kw3cgk
	 Y9a1d3HSHqPlhbYDyD2/5hqqMz8uI58EVs7gVjxqEvj+Atmd83qZa03hhQmPquxuJU
	 C9OrqCcbCQ7da+KVypEsZaKKWx5GXglhoPW+0GxRngL5iJ0NPeN6DV5Cu5AQh3MaXc
	 LUQhsHNiuRWGb2AVWHJ8BAOOOx+ViRihKAgK3yqx5jY2bXkGPAHI/tKbp95UT9t4OC
	 +tIbqyXRzwppxlKtQ1dXIzRBY86wmMPqpDMUCnWWWa1wNUQzTTjbeGDDF1H+Ssugre
	 EJIDxoeG8dSig==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 5EB54C009;
	Thu, 15 Jun 2023 13:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1686829948; bh=Ygsqj9MEfuFdkw/AFoPE5PZdn8YrnScjzyhGoq4eJ18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gg6xLe7a98MNe3IuaLQuZwSdehS1VaB84y/m01aAvWOp4akZGT5Rxj+3k+wOgSRrS
	 4/xQruEchEwFhurzk4lP2hLukTOypJNKM8ps5St/LxfE0VZgmXXfNkYsJm5WYOGGq5
	 9PWNBVI+TrHJmQ7TLuncyS1KmyRhJ/NN8h/bQvInX6sgvsoB5I4sFX/eBlx94ErDyu
	 NwhSxnassKRgQONpacEFerZZsI7aIiUwM4755I7jAOuBvdnIAChKj4x2yO0SlUG63v
	 Qi/gf4IqV/dxZbYO510T6y90wWnIWezttK1GwX8uuC8b5DE/cIY4DT/RMrYaJgCura
	 cgSzw4MFIU4Ng==
Received: from localhost (odin.codewreck.org [local])
	by odin.codewreck.org (OpenSMTPD) with ESMTPA id be358d16;
	Thu, 15 Jun 2023 11:52:24 +0000 (UTC)
Date: Thu, 15 Jun 2023 20:52:09 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: ppc64le vmlinuz is huge when building with BTF
Message-ID: <ZIr7aaVpOaP8HjbZ@codewreck.org>
References: <ZIqGSJDaZObKjLnN@codewreck.org>
 <ZIrONqGJeATpbg3Y@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIrONqGJeATpbg3Y@krava>

Jiri Olsa wrote on Thu, Jun 15, 2023 at 10:39:18AM +0200:
> > coming from alpine: https://gitlab.alpinelinux.org/alpine/aports/-/issues/12563
> 
> it's probably burried somewhere in that discussion, but do you have
> kernel version (or commit) where that increase happened?

Unfortunately not -- we've just tried on the 6.1.33 that's the current
alpine lts kernel, but I cannot say since when this started because
we've just enabled BTF recently.

Alpine also doesn't seem to keep old versions of apk files on its
mirrors so while it probably has been happening since it got enabled I
don't know how to check, and the commit enabling BTF has been done
without a MR so there's no test log that'd allow seeing the package size
either :/

> also link for used config would be great

alpine has two configs which both exhibit the issue (raw file link on
commit before removing BTF):
https://gitlab.alpinelinux.org/alpine/aports/-/raw/749ee7117e1437b7ab3ef2590f7f2e3558fda3ef/main/linux-lts/virt.ppc64le.config
Size difference for linux-virt: 219 MiB -> 47 MiB
https://gitlab.alpinelinux.org/alpine/aports/-/raw/749ee7117e1437b7ab3ef2590f7f2e3558fda3ef/main/linux-lts/lts.ppc64le.config
Size difference for linux-lts: 306 MiB -> 74 MiB


We just disabled BTF for this arch for now, I honestly won't have time
to dig further short term as I'm not that involved in this issue and
day job is busy right now.

Thanks,
-- 
Dominique

