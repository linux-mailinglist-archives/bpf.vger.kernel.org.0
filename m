Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6F32DEF4
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 02:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCEBNj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 20:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEBNj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 20:13:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEA5C061574;
        Thu,  4 Mar 2021 17:13:38 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id l132so446087qke.7;
        Thu, 04 Mar 2021 17:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qe00CZ1GKlh2KWnLB4/ycE/nbE2qQyfqvmqcLnIU/C8=;
        b=iit6gMzb0ia0QJiRoPIL2hh/VID83QVZYRBZkoXQQKAs3fDmOlPmACvQntO2Iki6+V
         YBxLBfj4Ciceu/Iz4Nn9pQqRpYzZdB7iLI5HHgW33y8FMQx+MBE0p34TajcD3NXoV08s
         xXJhlyvLkjSW5MKD7a96OaVdOW91pqgOHeUpwcFDpnSv9RoAFpa1bWzWEbOgnR2ld03q
         HPNDeWiY7+iJ/Nzrv6wrK4R6C+shiw/1ZEcV3xrNiKUfWlAQ7AI+G1aXRashq8RU/FUM
         wo4zG6F5xDF4GvrJkJelTb0dKa3b7d7n/NCtbFAKNvoo5RjmnpCsemCjE6oVPJ+TTFJa
         OJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qe00CZ1GKlh2KWnLB4/ycE/nbE2qQyfqvmqcLnIU/C8=;
        b=Bw9EZgHVDunS5njFmc2W1sGvl5vYcTpQ5OYGvOoM9LCzOb4nYKH1MxFXJ50+9UwcGa
         3MIIK92iupTD8Rjbp+ad6I3RBN+JRuZ48UxeD6rMqH8Vd8wuVXRKvXaCeobtSfPicSDd
         8q32A9M1aZT5Bfg5qV7kKs0qY/lVfxetsrLLDns8IrLGQYeQWBxUJU6LEUauVJDBGFNI
         eMMIzYkQLi646cQeWCdD+H/SWP3yPyfrPxiUxL4BBZeorWFXhcPDtqcVlF9vLf6mieR+
         kYJJMUij7rc6Khgx6l4QUKfNugV4MrVlN3Fdg4dbblgrfXzE3ykjrZovAzJBNVi7t4aY
         1vwQ==
X-Gm-Message-State: AOAM532gW5KBlcOBnbThWQ+GOmYVV4iBsdPtfa4Nv23sRDYQqEmrnNKv
        /eAZ8xhVlisaZo3/sX0gqcU=
X-Google-Smtp-Source: ABdhPJzTaRLswC805bT1z9l0u65gc26l6BhZ8dkYl6j+D8wBJeOZrvp5cc/I93gUrDeppIJ0hut2OQ==
X-Received: by 2002:ae9:e70d:: with SMTP id m13mr4848989qka.374.1614906817484;
        Thu, 04 Mar 2021 17:13:37 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h12sm744773qko.29.2021.03.04.17.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 17:13:36 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id CAB8627C0054;
        Thu,  4 Mar 2021 20:13:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 04 Mar 2021 20:13:35 -0500
X-ME-Sender: <xms:vYVBYK-3hZdQOUzyo_8PEy1ktJOlsCDD1ldCHdVwpMeHi0X3RfT5OA>
    <xme:vYVBYKuLQAb0QLm6WY0aCJinBDtIwsLnePSyUnlTW-xfY5wBuZn0FWWabVW-Q5f9A
    ZUPwdnZfJDQduwa9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddthedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtfefgfeeuleevvedtheejgeetueejkeeujeethfeiteekffehvdevveff
    jefgteenucfkphepudeijedrvddvtddrvddruddvieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:vYVBYABy-6lnWEEYneHTWhheIlVwx_3HEWwEeo3Nlkh1_yrjicW12w>
    <xmx:vYVBYCf2XqU3mP--IWI5hgVtI6usiKUwecfNPtntglDh2fXcHZ1eKQ>
    <xmx:vYVBYPOczbSytbKhjqF_VQ6kyncotUkaNQwdmOfHcOEmQKk6uw-Y1Q>
    <xmx:v4VBYIvwPfzCuIOBs-rjpWSxYqMY_p3Xh02TF8DYuvN9U9l1KsmAWW2iLig>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 77A0824005A;
        Thu,  4 Mar 2021 20:13:33 -0500 (EST)
Date:   Fri, 5 Mar 2021 09:12:30 +0800
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
Message-ID: <YEGFfjmOYfbuir9o@boqun-archlinux>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <YEA3RwYixQPt6gul@boqun-archlinux>
 <20210304031322.GA1594980@rowland.harvard.edu>
 <YEB/PGHs94W2l6hA@boqun-archlinux>
 <20210304161142.GB1612307@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210304161142.GB1612307@rowland.harvard.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 04, 2021 at 11:11:42AM -0500, Alan Stern wrote:
> On Thu, Mar 04, 2021 at 02:33:32PM +0800, Boqun Feng wrote:
> 
> > Right, I was thinking about something unrelated.. but how about the
> > following case:
> > 
> > 	local_v = &y;
> > 	r1 = READ_ONCE(*x); // f
> > 
> > 	if (r1 == 1) {
> > 		local_v = &y; // e
> > 	} else {
> > 		local_v = &z; // d
> > 	}
> > 
> > 	p = READ_ONCE(local_v); // g
> > 
> > 	r2 = READ_ONCE(*p);   // h
> > 
> > if r1 == 1, we definitely think we have:
> > 
> > 	f ->ctrl e ->rfi g ->addr h
> > 
> > , and if we treat ctrl;rfi as "to-r", then we have "f" happens before
> > "h". However compile can optimze the above as:
> > 
> > 	local_v = &y;
> > 
> > 	r1 = READ_ONCE(*x); // f
> > 
> > 	if (r1 != 1) {
> > 		local_v = &z; // d
> > 	}
> > 
> > 	p = READ_ONCE(local_v); // g
> > 
> > 	r2 = READ_ONCE(*p);   // h
> > 
> > , and when this gets executed, I don't think we have the guarantee we
> > have "f" happens before "h", because CPU can do optimistic read for "g"
> > and "h".
> 
> In your example, which accesses are supposed to be to actual memory and 
> which to registers?  Also, remember that the memory model assumes the 

Given that we use READ_ONCE() on local_v, local_v should be a memory
location but only accessed by this thread.

> hardware does not reorder loads if there is an address dependency 
> between them.
> 

Right, so "g" won't be reordered after "h".

> > Part of this is because when we take plain access into consideration, we
> > won't guarantee a read-from or other relations exists if compiler
> > optimization happens.
> > 
> > Maybe I'm missing something subtle, but just try to think through the
> > effect of making dep; rfi as "to-r".
> 
> Forget about local variables for the time being and just consider
> 
> 	dep ; [Plain] ; rfi
> 
> For example:
> 
> 	A: r1 = READ_ONCE(x);
> 	   y = r1;
> 	B: r2 = READ_ONCE(y);
> 
> Should B be ordered after A?  I don't see how any CPU could hope to 
> excute B before A, but maybe I'm missing something.
> 

Agreed.

> There's another twist, connected with the fact that herd7 can't detect 
> control dependencies caused by unexecuted code.  If we have:
> 
> 	A: r1 = READ_ONCE(x);
> 	if (r1)
> 		WRITE_ONCE(y, 5);
> 	r2 = READ_ONCE(y);
> 	B: WRITE_ONCE(z, r2);
> 
> then in executions where x == 0, herd7 doesn't see any control 
> dependency.  But CPUs do see control dependencies whenever there is a 
> conditional branch, whether the branch is taken or not, and so they will 
> never reorder B before A.
> 

Right, because B in this example is a write, what if B is a read that
depends on r2, like in my example? Let y be a pointer to a memory
location, and initialized as a valid value (pointing to a valid memory
location) you example changed to:

	A: r1 = READ_ONCE(x);
	if (r1)
		WRITE_ONCE(y, 5);
	C: r2 = READ_ONCE(y);
	B: r3 = READ_ONCE(*r2);

, then A don't have the control dependency to B, because A and B is
read+read. So B can be ordered before A, right?

> One last thing to think about: My original assessment or Björn's problem 
> wasn't right, because the dep in (dep ; rfi) doesn't include control 
> dependencies.  Only data and address.  So I believe that the LKMM 

Ah, right. I was mising that part (ctrl is not in dep). So I guess my
example is pointless for the question we are discussing here ;-(

> wouldn't consider A to be ordered before B in this example even if x 
> was nonzero.

Yes, and similar to my example (changing B to a read).

I did try to run my example with herd, and got confused no matter I make
dep; [Plain]; rfi as to-r (I got the same result telling me a reorder
can happen). Now the reason is clear, because this is a ctrl; rfi not a
dep; rfi.

Thanks so much for walking with me on this ;-)

Regards,
Boqun

> 
> Alan
