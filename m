Return-Path: <bpf+bounces-8841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6B78B228
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 15:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982CB1C20929
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 13:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDA912B75;
	Mon, 28 Aug 2023 13:42:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27D11CA0
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 13:42:13 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCD913E;
	Mon, 28 Aug 2023 06:41:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C66BE2CD;
	Mon, 28 Aug 2023 13:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C66BE2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1693230100; bh=hd5RWFpF6EBC15DMwWzaSp+wf4nhGJkFAjw07uGsTno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I770UVudoPwj36eFz0KUbsx6GDGkeBljvPiu6EUdTAOPBPycDuhTgpU5GvMFGp9wU
	 vqTfPaSnnSKXjP4N7phI4ofNDybs4yLpfHbQjZVYWkKLBlOasdcp+QiYUg5O4ZDSK0
	 7qFVHQ0kNInojoei3WkhUqUPprG9pjvbz2fnd8lYzAY/yim+jzfUbJngtZodTxipoL
	 1PJeaNw/8UZWO8vJT8HA+QE9uWtapG46nVIxb1P5MjvlXhjzA+A0FnJ07Qj9Hde4UD
	 xquEdYlZLMUKCsUd2GE7JiWQL+2OsKrx2CxtcvGCzQOqRxhs9+v1P1ULOsyGWinonp
	 mrI+Y8muXxOBg==
From: Jonathan Corbet <corbet@lwn.net>
To: Nishanth Menon <nm@ti.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
In-Reply-To: <20230828125912.hndmzfkof23zxpxl@tidings>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com> <87h6om4u6o.fsf@meer.lwn.net>
 <20230828125912.hndmzfkof23zxpxl@tidings>
Date: Mon, 28 Aug 2023 07:41:39 -0600
Message-ID: <87edjn2sj0.fsf@meer.lwn.net>
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

> Hi Jon,
>
> On 16:46-20230825, Jonathan Corbet wrote:

>> So it would sure be nice for the changelog to say what this actually
>> does.
>
> All this does is to bring in a better rendered documentation when
> published in html format.
> https://youtu.be/ItjdVa59jjE shows how the "copy-paste" functionality is
> improved.

Youtube references aren't a great way to explain the value of a patch;
you'll find that maintainers will, in general, lack the time or
inclination to follow them up.  The patch should explain itself.

>> This appears to add a build dependency for the docs; we can't just add
>> that without updating the documentation, adjusting
>> scripts/sphinx-pre-install, and so on.
>
> I had checked scripts/shinx-pre-install and that picks up
> Documentation/sphinx/requirements.txt and installs the dependencies
> from there using pip. Am I missing something?
>
> Same thing with Documentation/doc-guide/sphinx.rst
>
> Am I missing something?

That works, I guess, but doesn't change the fact that you have added
another docs build dependency.  That will, among other things, break the
build for anybody who is set up to do it now until they install your new
package.  That's not something we want to do without good reason.

>> But, beyond that, this extension goes entirely counter to the idea that
>> the plain-text files are the primary form of documentation; it adds
>> clutter and makes those files less readable.  We can do that when the
>
> Are you sure this is going against the readable text documentation? If
> anything it reduces the clutter and allows the text doc to be
> copy-paste-able as well.
>
> https://lore.kernel.org/all/20230824182107.3702766-3-nm@ti.com/
>
> As you see from the diffstat:
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> Nothing extra added. What kind of clutter are you suggesting we added
> with the change?
>
> prompt:: bash $ is clearly readable that this is prompt documentation
> in fact, dropping the "$" in the example logs, one can easily copy paste
> the documentation from rst files as well.

.. prompt:: is clutter.  It also adds a bit of extra cognitive load to
reading that part of the documentation.

Quick copy-paste of multiple lines of privileged shell commands has
never really been a requirement for the kernel docs; why do we need that
so badly?

I appreciate attempts to improve our documentation, and hope that you
will continue to do so.  I am far from convinced, though, that this
change clears the bar for mainline inclusion.

Thanks,

jon

