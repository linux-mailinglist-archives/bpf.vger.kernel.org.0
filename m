Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38D5B0297
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIGLOC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 7 Sep 2022 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIGLOB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 07:14:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3B61580C
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 04:13:59 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-197-OdM3Z-fmPGaTnTMnxUjYKQ-1; Wed, 07 Sep 2022 12:13:56 +0100
X-MC-Unique: OdM3Z-fmPGaTnTMnxUjYKQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 12:13:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 7 Sep 2022 12:13:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] objtool,x86: Teach decode about LOOP* instructions
Thread-Topic: [PATCH] objtool,x86: Teach decode about LOOP* instructions
Thread-Index: AQHYwphvHqpJ+XEnbkqFHiF9z5Fi7a3Tq+bA///5wgCAACe7EA==
Date:   Wed, 7 Sep 2022 11:13:54 +0000
Message-ID: <7889af4b7bb84823aca1732fb0d14de5@AcuMS.aculab.com>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
 <Yxhd4EMKyoFoH9y4@hirez.programming.kicks-ass.net>
 <7ef4b0d724894ff394f9d8921f8c4332@AcuMS.aculab.com>
 <Yxhm9HuSKSjznSzP@hirez.programming.kicks-ass.net>
In-Reply-To: <Yxhm9HuSKSjznSzP@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peter Zijlstra
> Sent: 07 September 2022 10:40
> 
> On Wed, Sep 07, 2022 at 09:06:12AM +0000, David Laight wrote:
> > From: Peter Zijlstra
> > > Sent: 07 September 2022 10:01
> > >
> > > On Wed, Sep 07, 2022 at 09:06:45AM +0200, Peter Zijlstra wrote:
> > > > On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:
> > > >
> > > > > +/* Return the jump target address or 0 */
> > > > > +static inline unsigned long insn_get_branch_addr(struct insn *insn)
> > > > > +{
> > > > > +	switch (insn->opcode.bytes[0]) {
> > > > > +	case 0xe0:	/* loopne */
> > > > > +	case 0xe1:	/* loope */
> > > > > +	case 0xe2:	/* loop */
> > > >
> > > > Oh cute, objtool doesn't know about those, let me go add them.
> >
> > Do they ever appear in the kernel?
> 
> No; that is, not on any of the random vmlinux.o images I checked this
> morning.
> 
> Still, best to properly decode them anyway.

It is annoying that cpu with adox/adcx have slow loop.
You really want to be able to do:
	1:	adox ...
		adcx ...
		loop	1b
That would never run with one iteration/clock.
But unrolling once would probably be enough.

What you can do (and gives the fastest IPcsum loop) is:
	1:	jcxz	2f
		....
		lea	%rcx,...
		jmp	1b
	2:
The extra instructions mean that needs unrolling 4 times.
I've got over 12 bytes/clock that way.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

