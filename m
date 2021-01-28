Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8881307DED
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhA1S1Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 13:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhA1SZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 13:25:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6FC061794;
        Thu, 28 Jan 2021 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I6mEsWyfZsiB3rlFhTgBIwxES1Rflykh4OLIPIv0rCk=; b=gcabAO7Xy6JOPzF0fg+TkJRqB1
        4UDrYOTK7lJwX/yOkgXneIlZ14o+PmnfN+JT2iof2MefPJ5ByrdSflxuyRlE0+MkTmbrWDXdlICG7
        xu6hXnWrAo2W3iAmYGOP1NUuKTOD4KxU2eKVetYN4VfecjiZ0AWv9GNh1f0foR3raJ7d5MbQBUfeN
        oDeIru8fUyX8ss/ryJNy5K/FdfliHweexWvrzU7CdKfotUlmFJ7/CF/W35f0Y7C3Axonsx5ELf0Fs
        2A1196jNd2SGhPhrby9+Tl09WYiuqQd/Mrtj1fYXKb/WSf4fVx5rfkVi62yi70MXhDj10OQ7UpthJ
        q0N7UJuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l5Bxn-008oak-7C; Thu, 28 Jan 2021 18:24:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F66C300B22;
        Thu, 28 Jan 2021 19:24:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EA7E200D4EF2; Thu, 28 Jan 2021 19:24:14 +0100 (CET)
Date:   Thu, 28 Jan 2021 19:24:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
References: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
 <20210128001353.66e7171b395473ef992d6991@kernel.org>
 <20210128002452.a79714c236b69ab9acfa986c@kernel.org>
 <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
 <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
 <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 06:45:56PM +0200, Nikolay Borisov wrote:
> it would be placed on the __fentry__ (and not endbr64) hence it works.
> So perhaps a workaround outside of bpf could essentially detect this
> scenario and adjust the probe to be on the __fentry__ and not preceding
> instruction if it's detected to be endbr64 ?

Arguably the fentry handler should also set the nmi context, it can,
after all, interrupt pretty much any other context by construction.
