Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480044DD2C5
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 03:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiCRCI7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 17 Mar 2022 22:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiCRCI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 22:08:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68E201770A1
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 19:07:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-138-muips4pANZGvgD4JdOOjog-1; Fri, 18 Mar 2022 02:07:38 +0000
X-MC-Unique: muips4pANZGvgD4JdOOjog-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 02:07:37 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 18 Mar 2022 02:07:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        X86 ML <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: RE: [PATCH v4 00/45] x86: Kernel IBT
Thread-Topic: [PATCH v4 00/45] x86: Kernel IBT
Thread-Index: AQHYOjfxkjA80HyQbUOAw96zl/91g6zEYw+g
Date:   Fri, 18 Mar 2022 02:07:37 +0000
Message-ID: <260c9402b6d647a39b4a5cf51024963d@AcuMS.aculab.com>
References: <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220313085214.GK28057@worktop.programming.kicks-ass.net>
 <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net>
 <20220315081522.GA8939@worktop.programming.kicks-ass.net>
 <CAK7LNAReAKXT97NHEnC-1UXozdcPdYNHR55knNRDatJr_GqrrA@mail.gmail.com>
 <YjOPrwZSEYR96/5D@hirez.programming.kicks-ass.net>
In-Reply-To: <YjOPrwZSEYR96/5D@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peter Zijlstra
> Sent: 17 March 2022 19:45
> 
> On Wed, Mar 16, 2022 at 01:28:08AM +0900, Masahiro Yamada wrote:
> > On Tue, Mar 15, 2022 at 5:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Index: linux-2.6/scripts/Makefile.build
> > > ===================================================================
> > > --- linux-2.6.orig/scripts/Makefile.build
> > > +++ linux-2.6/scripts/Makefile.build
> > > @@ -86,12 +86,18 @@ ifdef need-builtin
> > >  targets-for-builtin += $(obj)/built-in.a
> > >  endif
> > >
> > > -targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> > > +targets-for-modules :=
> >
> >
> > Why do you need to change this line?
> >
> >
> >
> > >
> > >  ifdef CONFIG_LTO_CLANG
> > >  targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
> > >  endif
> > >
> > > +ifdef CONFIG_X86_KERNEL_IBT
> > > +targets-for-modules += $(patsubst %.o, %.objtool, $(filter %.o, $(obj-m)))
> > > +endif
> > > +
> > > +targets-for-modules += $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> > > +
> > >  ifdef need-modorder
> > >  targets-for-modules += $(obj)/modules.order
> > >  endif
> 
> The thinking was that by having the .objtool rule before the .mod rule,
> objtool runs first. If mod runs before objtool, objtool will change the
> timestamp and then mod will get remade, even if nothing's changed.

I don't think it should make any difference.
A quick peruse didn't show where targets-for-modules actually
ends up being used (after being added to targets).
But in a makefile, if you have:

x: a b

nothing requires make to generate 'a' before or after 'b'.
gmake might have something similar to nmake's .ORDER directive
but I don't remember seeing it defined anywhere.
You can add 'b: a' to force the order (which is how .ORDER
ends up being implemented).
But I didn't spot anything of that nature.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

