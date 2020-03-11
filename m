Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77351822C8
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 20:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgCKTtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 15:49:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45166 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731030AbgCKTtw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 15:49:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id b13so2758352lfb.12
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=EJjUllg03TCbnok+5yckoIxfQXx9OCqL6Xgqfh8Cl6c=;
        b=uWa5oGKRGdS78Tf3lU3w7q8Y1QiHBj2DvqMlqkC9NpS4sYt45e72ECJ/Rwr4VHVYIB
         78YqBqiUjMUk9vQXmiUcK5+O/kKcmJzWTq731QbXxWOstY0quc9jf5ulrbACoCiDItX1
         OeiWL1y89qwEbTq3AwZ+loVketloG9kc4auoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=EJjUllg03TCbnok+5yckoIxfQXx9OCqL6Xgqfh8Cl6c=;
        b=JGqjL9EOzuAYU2pTWDay131tfZK+kYWOBF+1hJoPCqUXbA/jU3MfF3FJPxAZvP4TpO
         4I9VghAdY8xfP9RVorspwRLzfWqYnzkOSwg3E9flxMAHB/Zxn/loq5wd2bCP3CltyiC1
         6+/+PeLdXPLFxoWL/McL1izzH37u3DVm0kU0kJGgnxMd0uTRoZrN2uy9iMxJqwJ5dJ2f
         mlfEdT64e5cD4BQKvuplDyXA6DIS3lHew0QQTxnWvneYz9dTDivevokCN8vr9QFI83+q
         HBAEAl7gnmZt8LE9qyVf6KbS1sieANW4rJlCrf8YnkrxCt7EFqV7TkGz6cOCgWYh2MBa
         EDOg==
X-Gm-Message-State: ANhLgQ3L9t+uqSabdsDJa63QGNYLWXNRIPTa2Tr6o7NTjyeMqOg+YxEm
        ScubawpTaoFS7n7byTVfPN+Lpw==
X-Google-Smtp-Source: ADFU+vuBUUcd/C/+f1CehTC37vsFUo1aovHavNT3X9tKTdnVh95cusY0UmuO5Odyy3qPK/yO2Lge/Q==
X-Received: by 2002:ac2:41d3:: with SMTP id d19mr3132693lfi.57.1583956189491;
        Wed, 11 Mar 2020 12:49:49 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id z23sm8369505ljh.2.2020.03.11.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:49:48 -0700 (PDT)
References: <20200127125534.137492-1-jakub@cloudflare.com> <20200127125534.137492-13-jakub@cloudflare.com> <CAEf4Bzadh2T43bYbLO0EuKceUKr3SkfXK8Tj_fXFNj8BWtot1Q@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v5 12/12] selftests/bpf: Tests for SOCKMAP holding listening sockets
In-reply-to: <CAEf4Bzadh2T43bYbLO0EuKceUKr3SkfXK8Tj_fXFNj8BWtot1Q@mail.gmail.com>
Date:   Wed, 11 Mar 2020 20:49:47 +0100
Message-ID: <87sgiey8mc.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 11, 2020 at 07:48 PM CET, Andrii Nakryiko wrote:
> On Mon, Jan 27, 2020 at 4:58 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> Now that SOCKMAP can store listening sockets, user-space and BPF API is
>> open to a new set of potential pitfalls. Exercise the map operations (with
>> extra attention to code paths susceptible to races between map ops and
>> socket cloning), and BPF helpers that work with SOCKMAP to gain confidence
>> that all works as expected.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  .../selftests/bpf/prog_tests/sockmap_listen.c | 1455 +++++++++++++++++
>>  .../selftests/bpf/progs/test_sockmap_listen.c |   77 +
>>  2 files changed, 1532 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_listen.c
>>
>
> Hey Jakub!
>
> I'm frequently getting spurious failures for sockmap_listen selftest.
> We also see that in libbpf's Github CI testing as well. Do you mind
> taking a look? Usually it's the following kinds of error:
>
> ./test_progs:connect_accept_thread:733: accept: Resource temporarily unavailable
> connect_accept_thread:FAIL:733

Hey Andrii,

Sorry about that. Will investigate why this is happening.

Can't say I've seen those. Any additional details about the test
enviroment would be helpful. Like the kernel build config and qemu
params (e.g. 1 vCPU vs more).

I've taken a quick look at Github CI [0] to see if I can find a sample
failure report and fish out the kernel config & VM setup from the test
job spec, but didn't succeed. Will dig more later, unless you have a
link handy?

Thanks,
-jkbs

[0] https://travis-ci.org/github/libbpf/libbpf
