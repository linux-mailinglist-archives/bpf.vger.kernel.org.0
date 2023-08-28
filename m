Return-Path: <bpf+bounces-8865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731A78B752
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 20:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E37A1C20953
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46D13AFC;
	Mon, 28 Aug 2023 18:37:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D284125D5
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 18:37:55 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C896F1B7;
	Mon, 28 Aug 2023 11:37:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 62EFB7DB;
	Mon, 28 Aug 2023 18:37:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 62EFB7DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1693247866; bh=mJ+yrPifBWRjdsIqxkBqhdA1ySKTRpd70cZiDPx81MI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eiK4QevjmD3grjkEiG5wAm0JLEQwRN+TK1LLgx9RV75NWqmhHvYSV2BzitTeKhTDO
	 P9Jza9uRui3Zj6i6Vaki5LOK+hKnMrLk40RuySIBtdPNsAPNPFhbZnMLwZBuh4nZOD
	 mp/sbn9/hDB5Hf3Y4Si+FP1F34rgxFZke5NL1Po//QSWovQhI9GC8TzCr74cGfLLHJ
	 y/CqiCD284lOEkoUAF4Au/19FZ4D8IItggcDlLmKlrFNlkbLq4HWkuWxUGyZNQRUzL
	 IJ3EOnQLtYzemns7uj9mavEWKxdq3BLmGlZ69c0EucNfCEeqx3niXzEzHNzJtWNW01
	 KR+zQkaqM/mJw==
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Nishanth Menon <nm@ti.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
In-Reply-To: <20230828192508.0da12d72@sal.lan>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com> <87h6om4u6o.fsf@meer.lwn.net>
 <20230828125912.hndmzfkof23zxpxl@tidings> <87edjn2sj0.fsf@meer.lwn.net>
 <ZOyqhL32tuiMlS23@casper.infradead.org> <87wmxf19rs.fsf@meer.lwn.net>
 <20230828192508.0da12d72@sal.lan>
Date: Mon, 28 Aug 2023 12:37:45 -0600
Message-ID: <87jztf1092.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> Adding dependencies there is not the easiest thing to do, as one needs to
> test the change against all supported distros to ensure that the new package
> name will be the same everywhere. Also, if I'm not mistaken, some developers
> don't want to use pip to install packages, wanting instead to have the
> distro-provided package.

That, actually, is something we definitely need to keep in mind.  The
security record for PyPI (as with almost all of the language-specific
repos) is not great.  We need to think pretty hard before telling
developers (or, say, the build process on kernel.org) that they need to
install packages from there on their systems.

Thanks,

jon

