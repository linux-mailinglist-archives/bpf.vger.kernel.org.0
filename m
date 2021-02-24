Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96F9324200
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 17:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhBXQW4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 11:22:56 -0500
Received: from mail.efficios.com ([167.114.26.124]:55156 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhBXQWu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 11:22:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D16B5314DA7;
        Wed, 24 Feb 2021 11:22:07 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UaOPzPv1u88f; Wed, 24 Feb 2021 11:22:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 75E44314E2D;
        Wed, 24 Feb 2021 11:22:03 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 75E44314E2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614183723;
        bh=RWhpJBj5X6Gn6W/WULJZl80dWN++QmdR7y6Njv4ap7g=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=XCVVmaZUekk78Dy+xSiMLSrEzGNvWJwnF0xlJeh8WqxXo/pKOc5AXaTI1YOwx8g5y
         Zc61OIJriMZQhwpBgCG3rQc0GXTH4Yntj0bS8zFrRAV4w8tQvPlahFHAWjsYZV4Dm9
         uj4aAycf/3ScoLIUfos+HzeQQtgp6OcEvf4bbmCr8oaC9SFAy2SEffsp/9VqIO+49y
         EpJj8Xd0ATykElpgX2qZx28V/ewtnheDkJz80HVUCYrcPnBq+5RbNqKdhIiM5YHX9j
         SY3d8n9v87+DoKLLpRXkzbvIEvRrHUpXYEgYb8A0FVl3k1Oe1BSPaTT0YZ3pJ10ITY
         FMBM6AA5agY3Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i49bEFWWJC29; Wed, 24 Feb 2021 11:22:03 -0500 (EST)
Received: from [10.10.0.241] (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id 31B6F314D41;
        Wed, 24 Feb 2021 11:22:03 -0500 (EST)
Subject: Re: [RFC PATCH 0/6] [RFC] Faultable tracepoints (v2)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, bpf@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com>
 <20210223211639.670db85c@gandalf.local.home>
From:   Michael Jeanson <mjeanson@efficios.com>
Message-ID: <083bce0f-bd66-ab83-1211-be9838499b45@efficios.com>
Date:   Wed, 24 Feb 2021 11:22:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223211639.670db85c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ Adding Mathieu Desnoyers in CC ]

On 2021-02-23 21 h 16, Steven Rostedt wrote:
> On Thu, 18 Feb 2021 17:21:19 -0500
> Michael Jeanson <mjeanson@efficios.com> wrote:
> 
>> This series only implements the tracepoint infrastructure required to
>> allow tracers to handle page faults. Modifying each tracer to handle
>> those page faults would be a next step after we all agree on this piece
>> of instrumentation infrastructure.
> 
> I started taking a quick look at this, and came up with the question: how
> do you allow preemption when dealing with per-cpu buffers or storage to
> record the data?
> 
> That is, perf, bpf and ftrace are all using some kind of per-cpu data, and
> this is the reason for the need to disable preemption. What's the solution
> that LTTng is using for this? I know it has a per cpu buffers too, but does
> it have some kind of "per task" buffer that is being used to extract the
> data that can fault?
> 
> -- Steve
> 
