Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFA5AFFDD
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 11:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIGJGU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 7 Sep 2022 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiIGJGR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 05:06:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A351B7674E
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 02:06:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-ZIK-BrzPN2uPckKgxyhbbA-1; Wed, 07 Sep 2022 10:06:14 +0100
X-MC-Unique: ZIK-BrzPN2uPckKgxyhbbA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 10:06:12 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 7 Sep 2022 10:06:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] objtool,x86: Teach decode about LOOP* instructions
Thread-Topic: [PATCH] objtool,x86: Teach decode about LOOP* instructions
Thread-Index: AQHYwphvHqpJ+XEnbkqFHiF9z5Fi7a3Tq+bA
Date:   Wed, 7 Sep 2022 09:06:12 +0000
Message-ID: <7ef4b0d724894ff394f9d8921f8c4332@AcuMS.aculab.com>
References: <166251211081.632004.1842371136165709807.stgit@devnote2>
 <166251212072.632004.16078953024905883328.stgit@devnote2>
 <YxhDBAhYrs0Sfqjt@hirez.programming.kicks-ass.net>
 <Yxhd4EMKyoFoH9y4@hirez.programming.kicks-ass.net>
In-Reply-To: <Yxhd4EMKyoFoH9y4@hirez.programming.kicks-ass.net>
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
> Sent: 07 September 2022 10:01
> 
> On Wed, Sep 07, 2022 at 09:06:45AM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 07, 2022 at 09:55:21AM +0900, Masami Hiramatsu (Google) wrote:
> >
> > > +/* Return the jump target address or 0 */
> > > +static inline unsigned long insn_get_branch_addr(struct insn *insn)
> > > +{
> > > +	switch (insn->opcode.bytes[0]) {
> > > +	case 0xe0:	/* loopne */
> > > +	case 0xe1:	/* loope */
> > > +	case 0xe2:	/* loop */
> >
> > Oh cute, objtool doesn't know about those, let me go add them.

Do they ever appear in the kernel?
They are so slow on Intel cpu that finding one ought to
deemed a bug!

Have you got jcxz (0xe3) in there?
They are fast on both Intel and AMD cpus - so are usable.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

