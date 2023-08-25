Return-Path: <bpf+bounces-8716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA67891E7
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 00:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7282C281989
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0580918AEB;
	Fri, 25 Aug 2023 22:46:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CEE1C02
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:46:13 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B42026B0;
	Fri, 25 Aug 2023 15:46:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 93DB76E3;
	Fri, 25 Aug 2023 22:46:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 93DB76E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1693003568; bh=L2tfz4qEYX8iRgs5nKkp8n2pKDrpHgsTjVgLjX3svnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g6chkHoupJ+SoqhLePiLjOTIWlnHJVDGB6Va8B+Zd1U4R1S5eiJxmrFlnxACKXcIy
	 1bo7JWiscD1o9gffnuEJ2GQ0VfOr2AEiK4m8s35zZX1ux5SYEvX+4riJJ4vK5bCF0v
	 oBKIfCEVRouOsq+2ApuXAfOyFeWFB09AAK1xALCOoqxSPopNb2FG9j1A5lUOixcj/1
	 WvFu5bdaOPWZvzqvMl0a/i/FDc/IW3WFqSO4zrqctY7tCaPjfrHhzmaQAAN6eQqvKp
	 EP3gNvsyuMb/SsZBT8P9HXw9zIomrq57yWQbZD4UJ6OiU2cDsLqNJj+iSeY6rGrVIb
	 wlEGMmOvW4EGQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Nishanth Menon <nm@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Neha Francis <n-francis@ti.com>, Nishanth Menon
 <nm@ti.com>
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
In-Reply-To: <20230824182107.3702766-2-nm@ti.com>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com>
Date: Fri, 25 Aug 2023 16:46:07 -0600
Message-ID: <87h6om4u6o.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Nishanth Menon <nm@ti.com> writes:

> Sphinx-prompt[1] helps bring-in '.. prompt::' option that allows a
> better rendered documentation, yet be able to copy paste without
> picking up the prompt from the rendered documentation.
>
> [1] https://pypi.org/project/sphinx-prompt/
> Link: https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> I would have added Reported-by for Simon, since he reported the issue in
> the first place.. but it was for the u-boot documentation, so skipping
> here.
>
>  Documentation/conf.py                 | 2 +-
>  Documentation/sphinx/requirements.txt | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

So it would sure be nice for the changelog to say what this actually
does.

This appears to add a build dependency for the docs; we can't just add
that without updating the documentation, adjusting
scripts/sphinx-pre-install, and so on.

But, beyond that, this extension goes entirely counter to the idea that
the plain-text files are the primary form of documentation; it adds
clutter and makes those files less readable.  We can do that when the
benefit is sufficient, but I'm pretty far from convinced that this is
the case here.  Certainly the case hasn't been made in the changelog.
What *is* the benefit of making this change?

Thanks,

jon


