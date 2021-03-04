Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783D332CA07
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 02:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCDB2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 20:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhCDB2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 20:28:16 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793E5C061760;
        Wed,  3 Mar 2021 17:27:35 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id gi9so12812083qvb.10;
        Wed, 03 Mar 2021 17:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HfRjZbi06nrAWKx+Q/NkvinoR4OMEZ/KCwCnLJgzU4M=;
        b=tae+YpUaoITVydY0A8n66fqGNoQTIQeIlRnX8AGoG5no/BHz/r9ZojTiFsDW5w1VqQ
         XCcRInSaERZ/67M7HQbpF8FTQ6dA81Ej2CAXLyW3eaXn87OGZ/hjWbbfb7TsfGYhqs8p
         4mjJbdHEfuKYUJgsg833Vg/XBGG/CtbaPmzZDZPKLMrSS+0YcGLqJvgGzj2L5bxFhlz6
         sc/KRL19QJAjaTQSpbwlCaCeUFMj5996C5/vlDgmeWh+NqHJh4nWTRBcGgCOG5bFZorT
         gCkfCC9J2Uied5e8SIub/g+UV2rjzSiMFk2yU7vfwL85UDNfpPtatOjNavhJPIBfTKmS
         iOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HfRjZbi06nrAWKx+Q/NkvinoR4OMEZ/KCwCnLJgzU4M=;
        b=R/WAMymMepycJ0rO9B8fILyYvJAKmaIU/ILbUy3jTBjoTkeriMfFDseRBHfbUZPXxW
         HQNEjX/ySguZ9bN9ZLydf/7CUB3VuBlxOzvrJ2k5mKbV37fJbZjNXZZzYDLw9qR3aQ6g
         Qcqr7n+xfwkNzRyQRgc88HXv6WqotzaLsyKthJDpPb48qeHcnK015pjKICLTK1ZR67DP
         v+FID+wpSQSSAEmUJt5yyW5a1rkXuafbmo2Jk0BNFXdHApwE7a6nUBicvQ+MtN1obuxj
         X9wB3BNbuUqlLtkNbg17se1jcYl6reGGPwX1KkIyBKbI9XblPIViqVXJNOkuBukq5q+d
         ChSA==
X-Gm-Message-State: AOAM530FjOWEXlO8E1XosECGp6R5Q3DX2gydTf5ROr5PPn9OSLeCnqaK
        LHaAksHj3psu66GE2kbNwNA=
X-Google-Smtp-Source: ABdhPJxbCc/tbvdUBlq8P5IKtyRIXG5kytGBhtizDOwRDBdMPSJBory5vU+rHnPWfSOuYaEg5PC7mQ==
X-Received: by 2002:a0c:ea29:: with SMTP id t9mr2115838qvp.52.1614821254665;
        Wed, 03 Mar 2021 17:27:34 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c73sm14758800qkg.6.2021.03.03.17.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 17:27:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id EC98A27C0060;
        Wed,  3 Mar 2021 20:27:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 Mar 2021 20:27:32 -0500
X-ME-Sender: <xms:gzdAYLSeCBAeksjffzCANwoJD5rm3lJrQO5dUJd8YID5OeKOagQm4A>
    <xme:gzdAYMxmJ0A0MXAotPoRuKuOaLLGcXx5hvp2jNsZn7q92NDcxkLDVpAq8yCHbUXUk
    grC7xCsgl5OiR_exA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeduieejrddvvddtrddvrdduvdeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:gzdAYA1lklp8RuQhkUwenCW7s5xC_aEn3zkPyHcnCwpDtzIs0JuLew>
    <xmx:gzdAYLAg_sm5K6DMHnpp2GffjTf0pGh62ncv19WsZvEO0E_UgVrnCQ>
    <xmx:gzdAYEjPFVH9qQXaVbhaq7b4beyCsHxNIP3wr4HVifCgZk3JKF94Qw>
    <xmx:hDdAYAzB_r4pxOWDSNOc404sQbx9mCTHOEVhAzDk_hF8g9_lfR78UIS1pUg>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F5B0240067;
        Wed,  3 Mar 2021 20:27:30 -0500 (EST)
Date:   Thu, 4 Mar 2021 09:26:31 +0800
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
Message-ID: <YEA3RwYixQPt6gul@boqun-archlinux>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303202246.GC1582185@rowland.harvard.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 03:22:46PM -0500, Alan Stern wrote:
> On Wed, Mar 03, 2021 at 09:40:22AM -0800, Paul E. McKenney wrote:
> > On Wed, Mar 03, 2021 at 12:12:21PM -0500, Alan Stern wrote:
> 
> > > Local variables absolutely should be treated just like CPU registers, if 
> > > possible.  In fact, the compiler has the option of keeping local 
> > > variables stored in registers.
> > > 
> > > (Of course, things may get complicated if anyone writes a litmus test 
> > > that uses a pointer to a local variable,  Especially if the pointer 
> > > could hold the address of a local variable in one execution and a 
> > > shared variable in another!  Or if the pointer is itself a shared 
> > > variable and is dereferenced in another thread!)
> > 
> > Good point!  I did miss this complication.  ;-)
> 
> I suspect it wouldn't be so bad if herd7 disallowed taking addresses of 
> local variables.
> 
> > As you say, when its address is taken, the "local" variable needs to be
> > treated as is it were shared.  There are exceptions where the pointed-to
> > local is still used only by its process.  Are any of these exceptions
> > problematic?
> 
> Easiest just to rule out the whole can of worms.
> 
> > > But even if local variables are treated as non-shared storage locations, 
> > > we should still handle this correctly.  Part of the problem seems to lie 
> > > in the definition of the to-r dependency relation; the relevant portion 
> > > is:
> > > 
> > > 	(dep ; [Marked] ; rfi)
> > > 
> > > Here dep is the control dependency from the READ_ONCE to the 
> > > local-variable store, and the rfi refers to the following load of the 
> > > local variable.  The problem is that the store to the local variable 
> > > doesn't go in the Marked class, because it is notated as a plain C 
> > > assignment.  (And likewise for the following load.)
> > > 
> > > Should we change the model to make loads from and stores to local 
> > > variables always count as Marked?
> > 
> > As long as the initial (possibly unmarked) load would be properly
> > complained about.
> 
> Sorry, I don't understand what you mean.
> 
> >  And I cannot immediately think of a situation where
> > this approach would break that would not result in a data race being
> > flagged.  Or is this yet another failure of my imagination?
> 
> By definition, an access to a local variable cannot participate in a 
> data race because all such accesses are confined to a single thread.
> 
> However, there are other aspects to consider, in particular, the 
> ordering relations on local-variable accesses.  But if, as Luc says, 
> local variables are treated just like registers then perhaps the issue 
> doesn't arise.
> 
> > > What should have happened if the local variable were instead a shared 
> > > variable which the other thread didn't access at all?  It seems like a 
> > > weak point of the memory model that it treats these two things 
> > > differently.
> > 
> > But is this really any different than the situation where a global
> > variable is only accessed by a single thread?
> 
> Indeed; it is the _same_ situation.  Which leads to some interesting 
> questions, such as: What does READ_ONCE(r) mean when r is a local 
> variable?  Should it be allowed at all?  In what way is it different 
> from a plain read of r?
> 
> One difference is that the LKMM doesn't allow dependencies to originate 
> from a plain load.  Of course, when you're dealing with a local 
> variable, what matters is not the load from that variable but rather the 
> earlier loads which determined the value that had been stored there.  
> Which brings us back to the case of the
> 
> 	dep ; rfi
> 
> dependency relation, where the accesses in the middle are plain and 
> non-racy.  Should the LKMM be changed to allow this?
> 

For this particular question, do we need to consider code as the follow?

	r1 = READ_ONCE(x);  // f
	if (r == 1) {
		local_v = &y; // g
		do_something_a();
	}
	else {
		local_v = &y;
		do_something_b();
	}

	r2 = READ_ONCE(*local_v); // e

, do we have the guarantee that the first READ_ONCE() happens before the
second one? Can compiler optimize the code as:

	r2 = READ_ONCE(y);
	r1 = READ_ONCE(x);

	if (r == 1) {
		do_something_a();
	}
	else {
		do_something_b();
	}

? Although we have:

	f ->dep g ->rfi ->addr e

Regards,
Boqun

> There are other differences to consider.  For example:
> 
> 	r = READ_ONCE(x);
> 	smp_wmb();
> 	WRITE_ONCE(y, 1);
> 
> If the write to r were treated as a marked store, the smp_wmb would 
> order it (and consequently the READ_ONCE) before the WRITE_ONCE.  
> However we don't want to do this when r is a local variable.  Indeed, a 
> plain store wouldn't be ordered this way because the compiler might 
> optimize the store away entirely, leaving the smp_wmb nothing to act on.
> 
> So overall the situation is rather puzzling.  Treating local variables 
> as registers is probably the best answer.
> 
> Alan
