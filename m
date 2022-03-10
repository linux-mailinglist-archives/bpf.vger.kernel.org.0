Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96464D4366
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 10:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiCJJYH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 10 Mar 2022 04:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbiCJJYH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 04:24:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02AF22BB39
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 01:23:03 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-189-Cn9pbkHFPAe5BCPpwhZIzg-1; Thu, 10 Mar 2022 09:23:00 +0000
X-MC-Unique: Cn9pbkHFPAe5BCPpwhZIzg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Mar 2022 09:22:59 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Mar 2022 09:22:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH v4 00/45] x86: Kernel IBT
Thread-Topic: [PATCH v4 00/45] x86: Kernel IBT
Thread-Index: AQHYNF3uCfkzaUw3o020v7uo0T//Qqy4V9+w
Date:   Thu, 10 Mar 2022 09:22:59 +0000
Message-ID: <184d593713ca4e289ddbd7590819eddc@AcuMS.aculab.com>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <CAKwvOdk0ROSOSDKHcyH0kP+5MFH5QnasD6kbAu8gG8CCXO7OmQ@mail.gmail.com>
 <Yim/QJhNBCDfuxsc@hirez.programming.kicks-ass.net>
In-Reply-To: <Yim/QJhNBCDfuxsc@hirez.programming.kicks-ass.net>
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
> Sent: 10 March 2022 09:05
> 
> On Wed, Mar 09, 2022 at 04:30:28PM -0800, Nick Desaulniers wrote:
> 
> > I observed the following error when building with
> > CONFIG_LTO_CLANG_FULL=y enabled:
> >
> > ld.lld: error: ld-temp.o <inline asm>:7:2: symbol 'ibt_selftest_ip' is
> > already defined
> >         ibt_selftest_ip:
> >         ^
> >
> > Seems to come from
> > commit a802350ba65a ("x86/ibt: Add IBT feature, MSR and #CP handling")
> >
> > Commenting out the label in the inline asm, I then observed:
> > vmlinux.o: warning: objtool: identify_cpu()+0x6d0: sibling call from
> > callable instruction with modified stack frame
> > vmlinux.o: warning: objtool: identify_cpu()+0x6e0: stack state
> > mismatch: cfa1=4+64 cfa2=4+8
> > These seemed to disappear when I kept CONFIG_LTO_CLANG_FULL=y but then
> > disabled CONFIG_X86_KERNEL_IBT. (perhaps due to the way I hacked out
> > the ibt_selftest_ip label).
> 
> Urgh.. I'm thikning this is a clang bug :/
> 
> The code in question is:
> 
> 
> void ibt_selftest_ip(void); /* code label defined in asm below */
> 
> DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> {
> 	/* ... */
> 
> 	if (unlikely(regs->ip == (unsigned long)ibt_selftest_ip)) {
> 		regs->ax = 0;
> 		return;
> 	}
> 
> 	/* ... */
> }
> 
> bool ibt_selftest(void)
> {
> 	unsigned long ret;
> 
> 	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
> 	     ANNOTATE_RETPOLINE_SAFE
> 	     "	jmp *%%rax\n\t"
> 	     "ibt_selftest_ip:\n\t"
> 	     UNWIND_HINT_FUNC
> 	     ANNOTATE_NOENDBR
> 	     "	nop\n\t"
> 
> 	     : "=a" (ret) : : "memory");
> 
> 	return !ret;
> }
> 
> There is only a single definition of that symbol, the one in the asm.
> The other is a declaration, which is used in the exception handler to
> compare against regs->ip.

LTO has probably inlined it twice.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

