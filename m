Return-Path: <bpf+bounces-1679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7AD71FED5
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0EC1C20A82
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2D182C4;
	Fri,  2 Jun 2023 10:19:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF2D18019
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 10:19:34 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E636F1BF;
	Fri,  2 Jun 2023 03:19:15 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1D2792B8;
	Fri,  2 Jun 2023 10:19:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1D2792B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1685701155; bh=QMXbgBQiNP/xtmRJwUXLAhiAmFdwAINgR8c7SCTJZn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a9VxAqMWcSzE5nwi8CWXTFYo4GfHQfgD0mRZOnjY++0mhwtlzOz6e2YBCw9p/Uv7z
	 Ht4uXJxQ0N9/OML/2ALt5UFOJorv4QiDc9f+n1kJiBj8PNO51gW64bCEGoex8Sw6cA
	 3eOw6iUsiRPiXH5WLTXJD5DhsA5HGHSxd42gRj0frQQu2Bb7EUzcgUEvBqVuYZBFPP
	 O2rT2osHRGjjCKhq8h2c3uGPxV5ZwKHonws4HOBHTWisi7S/o4HGLBMGoTQclVfVw+
	 T6rxxUi7hs9qS0TgV2QTNwIdrTLRf3po+oyHZp7gtFD8oLGrR70dC8RJLiaL5/oxab
	 qGhRuFdIl57pg==
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Costa Shulyupin
 <costa.shul@redhat.com>, linux-doc@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux BPF
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] Documentation: subsystem-apis: Categorize remaining
 subsystems
In-Reply-To: <ZHm_s7kQP6kilBtO@debian.me>
References: <ZHgM0qKWP3OusjUW@debian.me>
 <20230601145556.3927838-1-costa.shul@redhat.com>
 <ZHm_s7kQP6kilBtO@debian.me>
Date: Fri, 02 Jun 2023 04:19:10 -0600
Message-ID: <87ilc6yxnl.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> As you're still newbie here, I'd recommend you to try contributing to
> drivers/staging/ first in order to gain experience on kernel developement
> workflow. Also, you use your RedHat address, so I expect you have been
> given kernel development training from your company (and doesn't make
> trivial errors like these ones).

Bagas, please.  I'll ask you directly: please don't go telling
documentation contributors how to comport themselves; you have plenty
enough to learn yourself on that front.  It's hard enough to get
contributors to the documentation as it is without random people showing
up and giving orders.

I have distractions that are increasing my (already less than stellar)
latency, but I'll get to this stuff.

Thanks,

jon

