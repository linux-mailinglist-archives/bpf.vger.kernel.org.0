Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10944311548
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhBEW1u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:27:50 -0500
Received: from mail.efficios.com ([167.114.26.124]:35742 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhBEOUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 09:20:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 741BA2F5596;
        Fri,  5 Feb 2021 10:47:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3ZcViJeHTbM7; Fri,  5 Feb 2021 10:47:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2F9D82F525A;
        Fri,  5 Feb 2021 10:47:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2F9D82F525A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1612540044;
        bh=ZXtGfhUUpSW4u0bX1WooGA5Q3gzcpG1PUwkvcXyaLTU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=p+4bYaWCdwfak1HNYVCsqSpeNWi5ovhrvVkrlQteUQRPMq/26Q77BnCjX2vOcLX7r
         tg35CZviuorDXS+TgFx54FbO1+81gltqXsoEx9sRLGKX1xbxdXBU+cixGHtu1/ZGGk
         YyKuANv10Eye4N4yHttkG0eMvF9zBOk+abfMwMQNoXUB4Oi03+A1+vuSt/Ki+e72JF
         zNd0KAxwHStPXfP1FEfE2b1OVnL//uE9wjOERQOHVM4dyHqDzBgJ2LeFHBQ473hpeI
         SBRRAslWj1gF/0TpKnv1uPTKoHWQp7J3W92SW279rzxUHu84HicwEV8b1sf/XfQDsJ
         rPu0YtPdhaS7A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kfv6S17tFsoc; Fri,  5 Feb 2021 10:47:24 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1B1DD2F5252;
        Fri,  5 Feb 2021 10:47:24 -0500 (EST)
Date:   Fri, 5 Feb 2021 10:47:23 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kees Cook <keescook@chromium.org>, thgarnie@chromium.org,
        kpsingh@google.com,
        paul renauld epfl <paul.renauld.epfl@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        rostedt <rostedt@goodmis.org>
Message-ID: <47845502.8614.1612540043986.JavaMail.zimbra@efficios.com>
In-Reply-To: <YB1m2i6bUM0LO5wS@hirez.programming.kicks-ass.net>
References: <20200820164753.3256899-1-jackmanb@chromium.org> <20210205150926.GA12608@localhost> <YB1m2i6bUM0LO5wS@hirez.programming.kicks-ass.net>
Subject: Re: [RFC] security: replace indirect calls with static calls
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3996)
Thread-Topic: security: replace indirect calls with static calls
Thread-Index: RuVbmUup0iOFmIVlAbpninCycfmfRw==
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

----- On Feb 5, 2021, at 10:40 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Fri, Feb 05, 2021 at 10:09:26AM -0500, Mathieu Desnoyers wrote:
>> Then we should be able to generate the following using static keys as a
>> jump table and N static calls:
>> 
>>   jump <static key label target>
>> label_N:
>>   stack setup
>>   call
>> label_N-1:
>>   stack setup
>>   call
>> label_N-2:
>>   stack setup
>>   call
>>   ...
>> label_0:
>>   jump end
>> label_fallback:
>>   <iteration and indirect calls>
>> end:
>> 
>> So the static keys would be used to jump to the appropriate label (using
>> a static branch, which has pretty much 0 overhead). Static calls would
>> be used to implement each of the calls.
>> 
>> Thoughts ?
> 
> At some point I tried to extend the static_branch infra to do multiple
> targets and while the low level plumbing is trivial, I ran into trouble
> trying to get a sane C level API for it.

Did you try doing an API for a variable number of targets, or was it for
a specific number of targets ? It might be easier to just duplicate some
of the API code for number of targets between 2 and 12, and let the
users code choose the maximum number of targets they want to accelerate.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
