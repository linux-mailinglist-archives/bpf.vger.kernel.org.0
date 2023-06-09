Return-Path: <bpf+bounces-2211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443BB729234
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 10:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C50B1C210D8
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E048A947;
	Fri,  9 Jun 2023 08:06:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D175415C8
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 08:06:08 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352DB3C00;
	Fri,  9 Jun 2023 01:06:04 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CA860218;
	Fri,  9 Jun 2023 08:06:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CA860218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1686297963; bh=vCCZoyVJv/dG21uOzB2PPXR7mnqwnSl+JgF4RTz00ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HYWVs0E+uZvrD2KTOWcZc9exCT37zc1JzeOP9bPEBmIRQnULCdL3gTvh9VwPaRUkQ
	 ywuIjrg2tNNaLKOVs8ykB+Gqx2utABkMLDx4YbDqy3QFg4fSbDCSG7K8oSOnsjc57o
	 Hq/8cYLZ6M441DCYyEeL+Jf7oCZsnkQFRm9ioqXBoa+8r0qfY6q7f0wsJIdvaqaH2X
	 Z2Js1dmjmchCAXAb0+wjf+Y8/mf/2IPTLq3QpMHp9vJwyM5ExNBjbBaxXfOit2OgxX
	 zvyIg9O8WvxcyjcwyLKk66llzhRKwkHQgfnPy58Fb7Beu1XVnfxPirMo1eam4RXQV7
	 JNf0RCN5qqclw==
From: Jonathan Corbet <corbet@lwn.net>
To: Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:BPF [MISC]"
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] Documentation: subsystem-apis: Categorize remaining
 subsystems
In-Reply-To: <20230601145556.3927838-1-costa.shul@redhat.com>
References: <ZHgM0qKWP3OusjUW@debian.me>
 <20230601145556.3927838-1-costa.shul@redhat.com>
Date: Fri, 09 Jun 2023 02:05:59 -0600
Message-ID: <87h6rhoyag.fsf@meer.lwn.net>
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

Costa Shulyupin <costa.shul@redhat.com> writes:

> From: Bagas Sanjaya <bagasdotme@gmail.com>
>
> Add classes:
> * Core subsystems
> * Storage
> * Networking
> * Peripherals and devices
> * Embedded systems
> * Integrity
> * Virtualization
> * Miscellaneous
>
> There is a FIXME that says to organize subsystems listed in
> subsystem-apis.rst. Fulfill it by categorize remaining subsytems
> by purpose/themes, while sorting entries in each category.
>
> HID devices are already categorized in 3c591cc954d56e ("docs:
> consolidate human interface subsystems").
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

So now that I've found a moment to look at stuff, I'm a bit confused
here.  Up top, you have a From: line identifying Bagas as the author of
this patch - but it lacks his signoff so I can't apply it.

If this is *really* such a complex change that it needs a
co-developed-by tag, please arrange that and the correct signoffs.
Otherwise, please send a patch that's your work (which can certainly
reflect suggestions from others) that is properly tagged.

Thanks,

jon

