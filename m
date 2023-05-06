Return-Path: <bpf+bounces-179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB56F8FD1
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 09:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6239B1C21A1B
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 07:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90281FA5;
	Sat,  6 May 2023 07:19:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D21380
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 07:19:17 +0000 (UTC)
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C490111577;
	Sat,  6 May 2023 00:19:12 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.SZmu-5V_1683357546;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.SZmu-5V_1683357546)
          by smtp.aliyun-inc.com;
          Sat, 06 May 2023 15:19:06 +0800
Date: Sat, 06 May 2023 15:19:06 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc:  <linux-kernel@vger.kernel.org>,
  "Thomas Garnier" <thgarnie@chromium.org>,
  "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
  "Kees Cook" <keescook@chromium.org>,
  "Nathan Chancellor" <nathan@kernel.org>,
  "Nick Desaulniers" <ndesaulniers@google.com>,
  "Tom Rix" <trix@redhat.com>,
   <bpf@vger.kernel.org>,
   <llvm@lists.linux.dev>
Subject: Re: [PATCH RFC 00/43] x86/pie: Make kernel image's virtual address
 flexible
Message-ID: <20230506071906.GA99736@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <20230428152206.GA1464060@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428152206.GA1464060@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Apr 28, 2023 at 11:22:06PM +0800, Peter Zijlstra wrote:
> 
> For some raison I didn't get 0/n but did get all of the others. Please
> keep your Cc list consistent.
>
Sorry, I'll pay attention next time.
 
> On Fri, Apr 28, 2023 at 05:50:40PM +0800, Hou Wenlong wrote:
> 
> >   - It is not allowed to reference global variables in an alternative
> >     section since RIP-relative addressing is not fixed in
> >     apply_alternatives(). Fortunately, all disallowed relocations in the
> >     alternative section can be captured by objtool. I believe that this
> >     issue can also be fixed by using objtool.
> 
> https://lkml.kernel.org/r/Y9py2a5Xw0xbB8ou@hirez.programming.kicks-ass.net

Thank you for your patch. However, it's more complicated for call depth
tracking case. Although, the per-cpu variable in the alternative section
is relocated, but the content of the "skl_call_thunk_template" is copied
into another place, so the offset is still incorrect. I'm not sure if
this case is common or not. Since the destination is clear, I could do
relocation here as well, but it would make the code more complicated.

Thanks!

