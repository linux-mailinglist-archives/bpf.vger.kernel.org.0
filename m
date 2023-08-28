Return-Path: <bpf+bounces-8842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB2378B244
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 15:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF300280E63
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF45312B79;
	Mon, 28 Aug 2023 13:51:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C7125A6
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 13:51:57 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446BC0;
	Mon, 28 Aug 2023 06:51:55 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SDplHJ020270;
	Mon, 28 Aug 2023 08:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1693230707;
	bh=uDnHa2QtC/enCIWwOMpGqx8OA0NhDZ0Z+HiVNGPINDY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QOBxWdol/CnKSz5MEa7jYuoU+0VYP039d6t57djcD8ZN0U0O77MrmoHT5lNdqoOCZ
	 K4VpSRoQZx9iMEFXdbDJ3OGLirdRCVGenhdQjhB7vuSnKJIptpND4SlKGnCGRiXRkX
	 tdCIQb9RfjOxzqOt+ecmpOSnD4lkqooNRWkEyvmc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SDpl8G069899
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Aug 2023 08:51:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 08:51:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 08:51:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SDplO8089119;
	Mon, 28 Aug 2023 08:51:47 -0500
Date: Mon, 28 Aug 2023 08:51:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Jonathan Corbet <corbet@lwn.net>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bpf@vger.kernel.org>,
        Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>,
        Mattijs Korpershoek
	<mkorpershoek@baylibre.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini
	<trini@konsulko.com>,
        Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
Message-ID: <20230828135147.sm2zdwwc7j7rfikd@quantum>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com>
 <87h6om4u6o.fsf@meer.lwn.net>
 <20230828125912.hndmzfkof23zxpxl@tidings>
 <87edjn2sj0.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87edjn2sj0.fsf@meer.lwn.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07:41-20230828, Jonathan Corbet wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Hi Jon,
> >
> > On 16:46-20230825, Jonathan Corbet wrote:
> 
> >> So it would sure be nice for the changelog to say what this actually
> >> does.
> >
> > All this does is to bring in a better rendered documentation when
> > published in html format.
> > https://youtu.be/ItjdVa59jjE shows how the "copy-paste" functionality is
> > improved.
> 
> Youtube references aren't a great way to explain the value of a patch;
> you'll find that maintainers will, in general, lack the time or
> inclination to follow them up.  The patch should explain itself.
> 
> >> This appears to add a build dependency for the docs; we can't just add
> >> that without updating the documentation, adjusting
> >> scripts/sphinx-pre-install, and so on.
> >
> > I had checked scripts/shinx-pre-install and that picks up
> > Documentation/sphinx/requirements.txt and installs the dependencies
> > from there using pip. Am I missing something?
> >
> > Same thing with Documentation/doc-guide/sphinx.rst
> >
> > Am I missing something?
> 
> That works, I guess, but doesn't change the fact that you have added
> another docs build dependency.  That will, among other things, break the
> build for anybody who is set up to do it now until they install your new
> package.  That's not something we want to do without good reason.

True, and fair enough.

> 
> >> But, beyond that, this extension goes entirely counter to the idea that
> >> the plain-text files are the primary form of documentation; it adds
> >> clutter and makes those files less readable.  We can do that when the
> >
> > Are you sure this is going against the readable text documentation? If
> > anything it reduces the clutter and allows the text doc to be
> > copy-paste-able as well.
> >
> > https://lore.kernel.org/all/20230824182107.3702766-3-nm@ti.com/
> >
> > As you see from the diffstat:
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > Nothing extra added. What kind of clutter are you suggesting we added
> > with the change?
> >
> > prompt:: bash $ is clearly readable that this is prompt documentation
> > in fact, dropping the "$" in the example logs, one can easily copy paste
> > the documentation from rst files as well.
> 
> .. prompt:: is clutter.  It also adds a bit of extra cognitive load to
> reading that part of the documentation.

It is no additional cognitive load from what is already there:

-.. code-block:: bash
+.. prompt:: bash $

> 
> Quick copy-paste of multiple lines of privileged shell commands has
> never really been a requirement for the kernel docs; why do we need that
> so badly?

Just hated people who read online documentation from having to spend
extra few seconds in copy pasting and then realizing oops "$" came along
with it.

> 
> I appreciate attempts to improve our documentation, and hope that you
> will continue to do so.  I am far from convinced, though, that this
> change clears the bar for mainline inclusion.

:) OK - I tried.. Thanks for explaining (though I disagree).
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

