Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC43B308AEB
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 18:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhA2RFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 12:05:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231940AbhA2RFG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Jan 2021 12:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611939820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SiOzMG034p5QbWP2fTdwm65PlfCrN2m47go7Lg3jSjc=;
        b=SvtZ9U8hKH/JFJq7/8ma9wI9nRmTq+z+0+dQs/KPZMjscRFO9HtkNDydU628fspWS5wZVI
        Axzc5L2nt467G/hdo10J8c7ZxrowYLXxKOLqpiOlF/UbtSb5p6TWZNfNzRiqR8hXe6d3nj
        yiJQwU8O/I5r6jfTQrZPcROatSwHXCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-N8wsyx1vNXWv0dfKR8MHXw-1; Fri, 29 Jan 2021 12:03:36 -0500
X-MC-Unique: N8wsyx1vNXWv0dfKR8MHXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6178D192CC42;
        Fri, 29 Jan 2021 17:03:34 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FB3860CD0;
        Fri, 29 Jan 2021 17:03:33 +0000 (UTC)
Date:   Fri, 29 Jan 2021 11:03:31 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86: Disable CET instrumentation in the kernel
Message-ID: <20210129170331.akmpnaqlwtfy4y6o@treble>
References: <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <20210128165014.xc77qtun6fl2qfun@treble>
 <20210128215219.6kct3h2eiustncws@treble>
 <20210129102105.GA27841@zn.tnic>
 <20210129151034.iba4eaa2fuxsipqa@treble>
 <20210129163048.GD27841@zn.tnic>
 <20210129164932.qt7hhmb7x4ehomfr@treble>
 <fd874f37-5842-93ab-6b6b-872f028f2583@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd874f37-5842-93ab-6b6b-872f028f2583@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 06:54:08PM +0200, Nikolay Borisov wrote:
> 
> 
> On 29.01.21 г. 18:49 ч., Josh Poimboeuf wrote:
> > Agreed, stable is a good idea.   I think Nikolay saw it with GCC 9.
> 
> 
> Yes I did, with the default Ubuntu compiler as well as the default gcc-10 compiler: 
> 
> # gcc -v -Q -O2 --help=target | grep protection
> 
> gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04) 
> COLLECT_GCC_OPTIONS='-v' '-Q' '-O2' '--help=target' '-mtune=generic' '-march=x86-64'
>  /usr/lib/gcc/x86_64-linux-gnu/9/cc1 -v -imultiarch x86_64-linux-gnu help-dummy -dumpbase help-dummy -mtune=generic -march=x86-64 -auxbase help-dummy -O2 -version --help=target -fasynchronous-unwind-tables -fstack-protector-strong -Wformat -Wformat-security -fstack-clash-protection -fcf-protection -o /tmp/ccSecttk.s
> GNU C17 (Ubuntu 9.3.0-17ubuntu1~20.04) version 9.3.0 (x86_64-linux-gnu)
> 	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.22.1-GMP
> 
> 
> It has -fcf-protection turned on by default it seems. 

Yup, explains why I didn't see it:

gcc version 10.2.1 20201125 (Red Hat 10.2.1-9) (GCC)
COLLECT_GCC_OPTIONS='-v' '-Q' '-O2' '--help=target' '-mtune=generic' '-march=x86-64'
 /usr/libexec/gcc/x86_64-redhat-linux/10/cc1 -v help-dummy -dumpbase help-dummy -mtune=generic -march=x86-64 -auxbase help-dummy -O2 -version --help=target -o /tmp/cclBz55H.s


-- 
Josh

