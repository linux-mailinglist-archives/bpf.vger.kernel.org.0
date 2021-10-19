Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB959433A36
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhJSPZg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhJSPZf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 11:25:35 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C06C06161C
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 08:23:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j190so12935787pgd.0
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q5JwjkIR452iYLXWJPJ7p89fAFV83Ftpgw1P7HU1Sgo=;
        b=TaizLMnwTZ5wMOH+uktsP4iwCQNQ87sfFvEDNyWq+KmonCek4q4mnyOP9otu9GiORK
         UdXfz3gtg/nMp3Y1JE0hAPhdzIx1y5NOdIBMQha0QG5oDz2JQ0u+GMLwPwU4SOyFdUDu
         N0LNKeLEbOO7LcOGZhg1Rb1QzmWEuNPKfWOyn7VoCewFNwkCAAsI3aaFQWieRJ7ZN+NR
         k3Ft4hzmGOm6b2kN+RyeBIDBThrbzLmPh7iz6iI90hkmqRbCDBhXEt/7NudO1rjhjzTI
         cNdlQ5vNtBpz5v5lCUicw32tZBTo5hY1NJlU3oKkl5U57TlbS86a0zzfvGpHXdLFAI71
         Q2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q5JwjkIR452iYLXWJPJ7p89fAFV83Ftpgw1P7HU1Sgo=;
        b=GKYp3MYfT9tBe4JhZKcQSpb8qdNtJvGZ1NulvhhMKWpsPp6SuT/I/RJZ2fB63oJyAv
         idASDkF+SxTWg21RIS+u8y4x/vXWoQMqi8X/dQV3SjCEskZ2t0iA9jag7K+uS8ejMadL
         4CGvp0/sIt6t30nrgB7+ZalX4ShjwuUaMNd8t6JcE/khwak2OwEzXm9k5sun9CaOPNOv
         4ZwXWANA1vn9DrG908WWeI5jLshhlBkuyEG+81AKXSMg3ZVS2cK+nh90i6A/o2mK6fkO
         gFFW495UnQM8HmvMbB5M0DAjoW20j35PorA1w+V7H1VyPNCdKI80L5KRkA0NGH6PIC2W
         In9Q==
X-Gm-Message-State: AOAM531RkwpyFjn/Guu0CoTwC3GC4MV3qqjTXqbwHmReEMF6lAKppFrN
        6nS7x/SLD2GIeFnia8ZRqt8=
X-Google-Smtp-Source: ABdhPJzr/8IaAYdCbdkQAkU6kTFGGyYVF7InpMq8HfCYrJkFCpaQpKRXPRECzBO1JqXUWWkI1qsOMw==
X-Received: by 2002:aa7:94a8:0:b0:44c:f3e0:81fb with SMTP id a8-20020aa794a8000000b0044cf3e081fbmr532385pfl.6.1634657002146;
        Tue, 19 Oct 2021 08:23:22 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id u2sm16273052pfi.120.2021.10.19.08.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 08:23:21 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2 v2] selftests/bpf: Test
 bpf_skc_to_unix_sock() helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
References: <20211007141331.723149-1-hengqi.chen@gmail.com>
 <20211007141331.723149-3-hengqi.chen@gmail.com>
 <CAADnVQLGfg=iMUi4oQtMzY9Y+j_pZtAAHQ_b8zO6wPaL6C0ooA@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <10abc62b-a263-b157-912f-363ae1f80a4c@gmail.com>
Date:   Tue, 19 Oct 2021 23:23:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQLGfg=iMUi4oQtMzY9Y+j_pZtAAHQ_b8zO6wPaL6C0ooA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for the review.

On 10/19/21 9:46 AM, Alexei Starovoitov wrote:
> On Thu, Oct 7, 2021 at 7:14 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>> +
>> +       sockaddr.sun_family = AF_UNIX;
>> +       strcpy(sockaddr.sun_path, sock_path);
> 
> please use strncpy.

Will do.

> 
>> +       len = sizeof(sockaddr);
>> +       unlink(sock_path);
> 
> please use abstract socket to avoid unlink and potential race.
> 

Will switch to abstract socket and update the BPF program.
