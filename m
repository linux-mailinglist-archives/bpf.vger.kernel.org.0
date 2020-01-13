Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5335013955B
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2020 16:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgAMP6I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 10:58:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50527 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgAMP6I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 10:58:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so10294854wmb.0
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=xuRv0bRrZmLh6/KELpV2UKLTZadCivbQ3Y3zds4jbws=;
        b=AN4P9S1MEvCGhshm0bKq0thZhjv2gvMxMBZrDoEgsisEZ2flIj6aZzLv302CT04ph+
         jEvx0tzMPNyWl6DEI/M6laHazcY0ewVcjRNMmwDMEa6f5St2+Ma0SuNAss+nq+X3Of1v
         BpBGjszCtDAEZw+4tqBZEfJXedXJdokeSaAbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=xuRv0bRrZmLh6/KELpV2UKLTZadCivbQ3Y3zds4jbws=;
        b=rrd2xkioUUCNt/2jc/yWHiAXwwevtNe+KK7QsUBOeGdZG+XdqQEOdM26EdxRQLhbxS
         qxV/Y7fAQMdZDR7v1LaDeMKMtZ42dgtlzv9FwfVSE5YScZ6dbxrYle7Z8gN3qDeop7vX
         Xip+wNy9asGKGbDEFDDD5shh8q0Tozf8Z2RywMWNv0YfvkuQh8BSjxFjzDvrDEGbqMOo
         FPewhpaKILS1fQN8W4cBNUrC1qTdhT3n5ol4VDq4T557I/mC+hQqsNukKHhlmo0svNSH
         wiiE51RFwegN3hdBwj5OFa0+us2mXyB6OLnOYG9Ad44JryvVxUqcyk8/W4HJc0Vmunfp
         uJEA==
X-Gm-Message-State: APjAAAXdRnOkeOdQ1WZWBPx6bbyjwOK5lv0qHAoTuOAHRQSAotMjB3Vt
        SzIaxuiyJoilXJQkipm2sKuX0Q==
X-Google-Smtp-Source: APXvYqzwCReOQ51CvyOqs+7XHhS1CAjcUa5dNI+iCe5BDXxMdXmpmssCSh1KzNa9RULQ5OI0izxFhg==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr21980385wmg.34.1578931086453;
        Mon, 13 Jan 2020 07:58:06 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id b21sm14822473wmd.37.2020.01.13.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:58:05 -0800 (PST)
References: <20200110105027.257877-1-jakub@cloudflare.com> <20200110105027.257877-12-jakub@cloudflare.com> <5e1a712c16d1_76782ace374ba5c02b@john-XPS-13-9370.notmuch>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next v2 11/11] selftests/bpf: Tests for SOCKMAP holding listening sockets
In-reply-to: <5e1a712c16d1_76782ace374ba5c02b@john-XPS-13-9370.notmuch>
Date:   Mon, 13 Jan 2020 16:58:05 +0100
Message-ID: <87k15vs60i.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 12, 2020 at 02:06 AM CET, John Fastabend wrote:
> Jakub Sitnicki wrote:
>> Now that SOCKMAP can store listening sockets, user-space and BPF API is
>> open to a new set of potential pitfalls. Exercise the map operations (with
>> extra attention to code paths susceptible to races between map ops and
>> socket cloning), and BPF helpers that work with SOCKMAP to gain confidence
>> that all works as expected.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>
> [...]
>
>> +static void test_sockmap_insert_listening(int family, int sotype, int mapfd)
>> +{
>> +	u64 value;
>> +	u32 key;
>> +	int s;
>> +
>> +	s = listen_loopback(family, sotype);
>> +	if (s < 0)
>> +		return;
>
> Will the test be marked OK if listen fails here? Should we mark it skipped or
> maybe even failed? Just concerned it may be passing even if the update doesn't
> actually happen.

Yes, it will be marked as failed if we don't succeed in creating a
listening socket. The listen_loopback helper uses x{socket,bind,listen}
wrappers, which in turn use the CHECK_FAIL macro to fail the test.

Thanks for going through this series till the end :-)

-jkbs
