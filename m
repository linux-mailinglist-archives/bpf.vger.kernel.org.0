Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8379D30EA50
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 03:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhBDCjX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 21:39:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234619AbhBDCjK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Feb 2021 21:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612406264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qhb2kXItW2mHNSz2e91apSBwbAib3godlZyK9gF1DQM=;
        b=X+QIwRKM2xPCOeqnBAvHb7D0HYCw6hPOoZh0nAnds5vPTXyooXGBRUi2hZTv7nDkmvpG+W
        lUE1I0ZfBFD+38TKE/f5Xw+vy80I8+u8zU5bZBg1r8cpEL2Quoy2QUCDNCmy88CWOXGGhB
        JYjh5+MyqP1BUtThARddFIu5RBUw1VY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-OH7evkT8PvyBFzDkzbNQCA-1; Wed, 03 Feb 2021 21:37:40 -0500
X-MC-Unique: OH7evkT8PvyBFzDkzbNQCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF32D801961;
        Thu,  4 Feb 2021 02:37:35 +0000 (UTC)
Received: from treble (ovpn-113-81.rdu2.redhat.com [10.10.113.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 383D85B695;
        Thu,  4 Feb 2021 02:37:21 +0000 (UTC)
Date:   Wed, 3 Feb 2021 20:37:19 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Hailong liu <liu.hailong6@zte.com.cn>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Robert Richter <rric@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: BUG: KASAN: stack-out-of-bounds in
 unwind_next_frame+0x1df5/0x2650
Message-ID: <20210204023719.sbwh7o7un7j2zgkd@treble>
References: <CABWYdi3HjduhY-nQXzy2ezGbiMB1Vk9cnhW2pMypUa+P1OjtzQ@mail.gmail.com>
 <CABWYdi27baYc3ShHcZExmmXVmxOQXo9sGO+iFhfZLq78k8iaAg@mail.gmail.com>
 <YBrTaVVfWu2R0Hgw@hirez.programming.kicks-ass.net>
 <CABWYdi2ephz57BA8bns3reMGjvs5m0hYp82+jBLZ6KD3Ba6zdQ@mail.gmail.com>
 <20210203190518.nlwghesq75enas6n@treble>
 <CABWYdi1ya41Ju9SsHMtRQaFQ=s8N23D3ADn6OV6iBwWM6H8=Zw@mail.gmail.com>
 <20210203232735.nw73kugja56jp4ls@treble>
 <CABWYdi1zd51Jb35taWeGC-dR9SChq-4ixvyKms3KOKgV0idfPg@mail.gmail.com>
 <20210204001700.ry6dpqvavcswyvy7@treble>
 <CABWYdi0p91Y+TDUu38eey-p2GtxL6f=VHicTxS629VCMmrNLpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABWYdi0p91Y+TDUu38eey-p2GtxL6f=VHicTxS629VCMmrNLpQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 03, 2021 at 04:52:42PM -0800, Ivan Babrou wrote:
> We also have the following stack that doesn't touch any crypto:
> 
> * https://gist.github.com/bobrik/40e2559add2f0b26ae39da30dc451f1e

Can you also run this through decode_stacktrace.sh?

Both are useful (until I submit a fix for decode_stacktrace.sh).

> I cannot reproduce this one, and it took 2 days of uptime for it to
> happen. Is there anything I can do to help diagnose it?

Can you run with the same unwind_debug patch+cmdline when you try to
recreate this one?  In the meantime I'll look at the available data.

-- 
Josh

