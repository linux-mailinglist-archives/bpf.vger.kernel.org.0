Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0267032CCE2
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 07:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhCDGfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 01:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhCDGfS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 01:35:18 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CABC061574;
        Wed,  3 Mar 2021 22:34:38 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id l132so25547157qke.7;
        Wed, 03 Mar 2021 22:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Al7o8H/PAUlo6YV2XX1l+4Gn+Ta0Brzf54ZgHZB+/8Q=;
        b=auDJDFWi4cCagSrTZvgDHiFzJdPnB++kGrDl13LMnxglmCm2+omDaboFCC1ZYl8kt+
         zV738q+pzyQZPvfk+tD/oh9DIUZPs7HCBrgRZa56QEM2ZQbe6V6H+ZliPCmrgVantdTa
         kuLxNdhd2ZOWlf42zh8YtOpZyJ/bSA2GvceW3YSqCnay3pQoXDCZ8GziCkltrsjVdznd
         DlDLbrRXCtJUqFh6chwnNWI0vXJHFO2yWZbbkOgLyQNIclm8S8gZczmc9+2c/5QqgLyq
         CB5XckqpfA/0B+d7gOjRjSntcRzSVrasx3AVUxKUoFrVsnTzv/DL70+i1SyeGkIwOU/h
         WTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Al7o8H/PAUlo6YV2XX1l+4Gn+Ta0Brzf54ZgHZB+/8Q=;
        b=ncgBHFqFo7WtkM3SeHtcr7qGhiAT5fOrHW3dwkZ0/sWdiO3y/QGm6Z8fJTQoieq4M7
         hMEMx6W7MjYPS2K/ygM5KtH2kOvDT3Y+dyHhILZ1ltvMwLP76KFdgNH0k8ZqvKP3YvY+
         Q2jSAm50/h7pohcEBOQ6F4uPO74VnlEf5tbpDRbVscfks/1l4VV7nrECgq0bPTEQiSAT
         t4a1AQ/zGxKJR9jKunyp0i3/jUzrAb9dlanas7wNhc7pKkNqQNz1Fp3OxgSzj7KhYO9u
         m1dtf4tfFlM4/9RR8yAb1SwOb+JZ99VXK1G173HIgs6mgUTvU074xbAdHV927C9JuCSY
         Ql7g==
X-Gm-Message-State: AOAM530yz7mHfU1au6sdMt19/V1sN2WWveqSf7bMYcF5SPueJ6JZ5GO1
        gXrnDVK+VazwdgCEWLuAxbM=
X-Google-Smtp-Source: ABdhPJxHC0+79l6R/rbhvn0GHkKlmnJvq95zstP/lKKmyBwfF5kKurBl57eZ3cTV0wDZMhz9nmNyuQ==
X-Received: by 2002:a05:620a:444a:: with SMTP id w10mr2695885qkp.294.1614839677550;
        Wed, 03 Mar 2021 22:34:37 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id z188sm15602997qke.85.2021.03.03.22.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 22:34:36 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id AD06427C0054;
        Thu,  4 Mar 2021 01:34:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Mar 2021 01:34:35 -0500
X-ME-Sender: <xms:eX9AYLiKZOhluH1nLPYGJ980OfIwfU1v-1CiCw_-g0-dHiWFSoCreg>
    <xme:eX9AYIB8BgEWGwN6yWcGk7d9_jmLDYP-s71s98r0pxCZb6bdxXzkqE7xHmQObSvBL
    e0yXW-3wahyNpD-HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtfedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:eX9AYLFa_gD9DE_ptsryZGodoUeg2TW12z6QwvxKOohQYP3pHhERFg>
    <xmx:eX9AYIQP108cewylZfN_iYSU3nI_l1tcQCW_kXBe9oOaBg2g5wLWaA>
    <xmx:eX9AYIz3dTiQG-u67W6RvAUgjxAahIjUG6rR_t59HkxDaemy8aRQfQ>
    <xmx:en9AYEDOJaL89faftXGENOw5HviHmSVrk3qMwdCiHRDZnraVfvz8A3-uKm4>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46930108005F;
        Thu,  4 Mar 2021 01:34:33 -0500 (EST)
Date:   Thu, 4 Mar 2021 14:33:32 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <YEB/PGHs94W2l6hA@boqun-archlinux>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <YEA3RwYixQPt6gul@boqun-archlinux>
 <20210304031322.GA1594980@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304031322.GA1594980@rowland.harvard.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 10:13:22PM -0500, Alan Stern wrote:
> On Thu, Mar 04, 2021 at 09:26:31AM +0800, Boqun Feng wrote:
> > On Wed, Mar 03, 2021 at 03:22:46PM -0500, Alan Stern wrote:
> 
> > > Which brings us back to the case of the
> > > 
> > > 	dep ; rfi
> > > 
> > > dependency relation, where the accesses in the middle are plain and 
> > > non-racy.  Should the LKMM be changed to allow this?
> > > 
> > 
> > For this particular question, do we need to consider code as the follow?
> > 
> > 	r1 = READ_ONCE(x);  // f
> > 	if (r == 1) {
> > 		local_v = &y; // g
> > 		do_something_a();
> > 	}
> > 	else {
> > 		local_v = &y;
> > 		do_something_b();
> > 	}
> > 
> > 	r2 = READ_ONCE(*local_v); // e
> > 
> > , do we have the guarantee that the first READ_ONCE() happens before the
> > second one? Can compiler optimize the code as:
> > 
> > 	r2 = READ_ONCE(y);
> > 	r1 = READ_ONCE(x);
> 
> Well, it can't do that because the compiler isn't allowed to reorder
> volatile accesses (which includes READ_ONCE).  But the compiler could
> do:
> 
> 	r1 = READ_ONCE(x);
> 	r2 = READ_ONCE(y);
> 
> > 	if (r == 1) {
> > 		do_something_a();
> > 	}
> > 	else {
> > 		do_something_b();
> > 	}
> > 
> > ? Although we have:
> > 
> > 	f ->dep g ->rfi ->addr e
> 
> This would be an example of a problem Paul has described on several
> occasions, where both arms of an "if" statement store the same value
> (in this case to local_v).  This problem arises even when local
> variables are not involved.  For example:
> 
> 	if (READ_ONCE(x) == 0) {
> 		WRITE_ONCE(y, 1);
> 		do_a();
> 	} else {
> 		WRITE_ONCE(y, 1);
> 		do_b();
> 	}
> 
> The compiler can change this to:
> 
> 	r = READ_ONCE(x);
> 	WRITE_ONCE(y, 1);
> 	if (r == 0)
> 		do_a();
> 	else
> 		do_b();
> 
> thus allowing the marked accesses to be reordered by the CPU and
> breaking the apparent control dependency.
> 
> So the answer to your question is: No, we don't have this guarantee,
> but the reason is because of doing the same store in both arms, not
> because of the use of local variables.
> 

Right, I was thinking about something unrelated.. but how about the
following case:

	local_v = &y;
	r1 = READ_ONCE(*x); // f

	if (r1 == 1) {
		local_v = &y; // e
	} else {
		local_v = &z; // d
	}

	p = READ_ONCE(local_v); // g

	r2 = READ_ONCE(*p);   // h

if r1 == 1, we definitely think we have:

	f ->ctrl e ->rfi g ->addr h

, and if we treat ctrl;rfi as "to-r", then we have "f" happens before
"h". However compile can optimze the above as:

	local_v = &y;

	r1 = READ_ONCE(*x); // f

	if (r1 != 1) {
		local_v = &z; // d
	}

	p = READ_ONCE(local_v); // g

	r2 = READ_ONCE(*p);   // h

, and when this gets executed, I don't think we have the guarantee we
have "f" happens before "h", because CPU can do optimistic read for "g"
and "h".

Part of this is because when we take plain access into consideration, we
won't guarantee a read-from or other relations exists if compiler
optimization happens.

Maybe I'm missing something subtle, but just try to think through the
effect of making dep; rfi as "to-r".

Regards,
Boqun

> Alan
