Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454DA58C7C0
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 13:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiHHLnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 07:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiHHLm5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 07:42:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68913D47;
        Mon,  8 Aug 2022 04:42:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659958974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxz5dJVKmW1JnSAUI9gZLzzxb4GJLXHvw8kFzNX5wd8=;
        b=P78VbJbhlFpuaRdoY0rRdSHkrmwFXjGAEcXUPHpzToAtrbtJ6quuzWFygkHUaZ/YKn23iH
        m3hOn3lyMu4XvNbNIm9x3rjaezSOFFoCQryOSpvkCmBS5sPR0foKFa4ImSNp13avNWIMU1
        NapzLVC2AF45f6exFgL5eDAE/ElbAjlIlHQZ6ZnvDw2s125p9Q5/iSnf9WaDQ4Z2wswrDZ
        i1+u07p8TefWOpGDTxKLVKSk8cV1nbwFtPw/jW6vlogwWf4JNNj6F5755wcIPgACCA5M+s
        5eytNX+JviKrGszvF3B3CaReaRI5fqiwy/YRzW/zQen+EOXXnlykC1XYrAiyqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659958974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxz5dJVKmW1JnSAUI9gZLzzxb4GJLXHvw8kFzNX5wd8=;
        b=m4hEevSGgE4U5+5naPIR6UURVhQTYZGLM8RMnmVGdjavu7mQqxWW7wFigJsRGGYEB+XDxD
        phOWpBmu6yN2RMBg==
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ben Segall <bsegall@google.com>,
        Christoph Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Mel Gorman <mgorman@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yonghong Song <yhs@fb.com>,
        Yury Norov <yury.norov@gmail.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 11/16] time: optimize tick_check_preferred()
In-Reply-To: <87fsi9rcxu.ffs@tglx>
References: <20220718192844.1805158-1-yury.norov@gmail.com>
 <20220718192844.1805158-12-yury.norov@gmail.com> <87fsi9rcxu.ffs@tglx>
Date:   Mon, 08 Aug 2022 13:42:54 +0200
Message-ID: <87czdbq7up.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 06 2022 at 10:30, Thomas Gleixner wrote:
> On Mon, Jul 18 2022 at 12:28, Yury Norov wrote:
>
>> tick_check_preferred() calls cpumask_equal() even if
>> curdev->cpumask == newdev->cpumask. Fix it.
>
> What's to fix here? It's a pointless operation in a slow path and all
> your "fix' is doing is to make the code larger.

In fact cpumask_equal() should have the ptr1 == ptr2 check, so you don't
have to add it all over the place.

Thanks,

        tglx
