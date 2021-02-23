Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2343225FD
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 07:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhBWGiB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 01:38:01 -0500
Received: from smtp217t.alice.it ([82.57.200.120]:24960 "EHLO
        smtp217t-alice.alice.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230486AbhBWGhs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 01:37:48 -0500
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrkeeggdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfvgffngfevqffokffvtefnkfetpdfqfgfvnecuuegrihhlohhuthemuceftddunecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenogfpohfkffculddutddmnecujfgurheprhfhvffuffggtgfgrfgioffqsehtjedttddutdgrnecuhfhrohhmpedflfhoshgvucftihgvrhgrucfuihhquhhivghrfdeolhhofigvrhhpuhhlshgrrhesrghlihgtvgdrihhtqeenucggtffrrghtthgvrhhnpefgleduueefgeeuteduheeilefggffhgfejjeekfeduvdffteehjeehgeegteegjeenucffohhmrghinhepghhoohhglhgvrdgtohhmnecukfhppedujeekrddvheefrddvtdegrdeinecuufhprghmtehlphhhrgfuuhgsjhgvtghtpeihohhuhhgrvhgvfihonhenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhephhgvlhhopehhvghllhhopdhinhgvthepudejkedrvdehfedrvddtgedriedpmhgrihhlfhhrohhmpeeolhhofigvrhhpuhhlshgrrhesrghlihgtvgdrihhtqedprhgtphhtthhopeeosgdqphgvthhtvghrsehmtggrrdhorhhgrdhukheqpdhrtghpthhtohepoegsphgtohesrghtlhgrnhhtihgtrdhnvghtqedprhgtphhtthhopeeosghptghomhhinhhtvghrnhgrthhiohhnrghlsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghptghothhtrghgvgho
        fihnvghrshesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphgurdhiihhsrhesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphgurghmrghssehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpughordhkphhksehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpughovhgvrhhsihhghhhtsegtihhthihofhgsohhishgvrdhorhhgqedprhgtphhtthhopeeosghpvggrrhhsvgihsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpvggrrhhsohhntddvudelheeisehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpvggtqdiffiifsehmihhtrdgvughuqedprhgtphhtthhopeeosghpvghjohhvihgthhesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphgvlhgvghesmhgrthhnrghsihhmrdhorhhgrdhilheqpdhrtghpthhtohepoegsphgvnhgvughosehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpvghnghgurghhlhesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphgvnhhnvghrudefsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpvghrihhsshgvsehnuhhmvghrihgtrggslhgvrdhfrheqpdhrtghpthhtohepoegsphgvrhhlmhgrnhdvjeesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphgvrhhrihhnfeestghoghgvtghordgtrgeqpdhrtghpthhtohepoegsphgvrhhsvghllhestghinhgvmhgrrhhkrdgtohhmqedprhgtphhtt
        hhopeeosghpvghtvghrshhfrghulhhksehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpvghtihhtsegtvghmfhhirdgvughurdgvsheqpdhrtghpthhtohepoegsphgvthhrohhsihhushesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphgvthiivghnsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoegsphhfohhgfigvlhhlsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpfhhorhguudesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphhgohhffhhitggvseifjhhgnhgvthdrtghomheqpdhrtghpthhtohepoegsphhgrhgrphhhihgtsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghphhesihhsvghrvhdrnhgvtheqpdhrtghpthhtohepoegsphhhrgesshifsggvlhhlrdhnvghtqedprhgtphhtthhopeeosghphhgrhihnsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghphhgvlhhlmhgrnhesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphhhihhltddvtdesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphhhihhllhhiphhssegsrhgrnhguvghishdrvgguuheqpdhrtghpthhtohepoegsphhhihhmvghlshhtvghinhesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphhhlhgrnhhgsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpihgvthhrrghskeeise
        hgmhgrihhlrdgtohhmqedprhgtphhtthhopeeosghpihhlihhtohifshhkihesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsphhinhhhrghsseiirghhrghvrdhnvghtrdhilheq
X-RazorGate-Vade-Verdict: clean 59
X-RazorGate-Vade-Classification: clean
Received: from hello (178.253.204.6) by smtp217t-alice.alice.it (5.8.604.04) (authenticated as lowerpulsar@alice.it)
        id 602B98DA03D6449D; Tue, 23 Feb 2021 07:36:10 +0100
Message-ID: <602B98DA03D6449D@smtp217t-alice.alice.it> (added by
            postmaster@alice.it)
Reply-To: <info.atmsort@cheapnet.it>
From:   "Jose Riera Siquier" <lowerpulsar@alice.it>
To:     alice.it@vger.kernel.org
Subject: You have won
Date:   Mon, 22 Feb 2021 22:36:06 -0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Final Notificaton about your win in the 

USA Mega lottery win

Download for more information or reply with your name and address to contact your claimagent.

Go to the google drive for more information
https://drive.google.com/file/d/1LPe2QWMQEzNov1quKNio8IpNdQJdHpYr/view
