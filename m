Return-Path: <bpf+bounces-11217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687EB7B5A7A
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 15C50281AC8
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053F21F176;
	Mon,  2 Oct 2023 18:50:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2B1D54F
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 18:50:41 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC974B0
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 11:50:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7740c8509c8so7751785a.3
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696272638; x=1696877438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWhlgKqTrjbQF0dckh+X6aNFF9b4rYOB+cG0XKPis4I=;
        b=zlArfdiUOOxnp1vq1Hx3NKuLZfLXCQdi/Ozh5tIFy1ae8ry0jd0EMxSMkpfw5uO5m9
         C4qUxCDdYoMPd6kWJHQ70J5PySuJBmph66CZZ+O+H0qZgwYmmyhb47EuXAS9vg8NLzON
         bH5K6jfLGhf0+pIzTFerUDX0c06eaJnNGuM7T+uGfQolcekk+NzaesbsPFNA1cs5kCuF
         BWjrEM6kcsFRQ84wX8M7GpJHTVtljMjv18KCbVfYPpee1nQH4Fs6qWWvALrnTXrFIuic
         2WBSpUnG32h7KJkBx6bI/LBGyB7W6Oe3mNXawZSbIeZojEyS1+m/XyKWTz3lkz6RTG7l
         nW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696272638; x=1696877438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWhlgKqTrjbQF0dckh+X6aNFF9b4rYOB+cG0XKPis4I=;
        b=Sl46pGxgUdTO3v76MOd3wC8yt7E3IBNzpYP2m6UDPRALRxu41aBBoTAabDYCHHo5Ao
         KGxD/6imQI+FfL9bStZqZsjt0VZVJdAs1GkjyfCm883mHVl1Gg/PhU3jQK2njit4Epab
         brbPy+h/EPeD1P359WkJtdcSLS8TCZTsHHHzO5tGd2FT8VfIx6K7UHJG5p/ZqxIOY+ZV
         rngNXxxlDkfXJCvp4v4skJvuxCK77r4UgbAqtn3vQ2vig1/tWonb37dEgb7oy05U1XLY
         f9yed1QPI5JyDErJQy4NxuIg2Pps+9AxvhXC2IXLBJtAGilp3TT4JzsHoJlZafOYUXF1
         wZiA==
X-Gm-Message-State: AOJu0YyUwzTMECxz7wcAraoSUraK8wmMQh7BLLcWc/N3hpRhXoS9y+V0
	C8unyAbVtNfV2tGM3KB22U4g0Q==
X-Google-Smtp-Source: AGHT+IE8dGMTkW1zzanpZHGg8oyg+mTfR48kvxmCI7TXQHg7zAjDrWq6zBxZfRbqzs4TqU6JV8F+iA==
X-Received: by 2002:a05:620a:2905:b0:773:ca55:e836 with SMTP id m5-20020a05620a290500b00773ca55e836mr12333975qkp.8.1696272637762;
        Mon, 02 Oct 2023 11:50:37 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id v15-20020ae9e30f000000b0077263636a95sm4611503qkf.93.2023.10.02.11.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 11:50:37 -0700 (PDT)
Message-ID: <235e7365-2fe3-4bfa-ab11-1dc955d70042@google.com>
Date: Mon, 2 Oct 2023 14:50:34 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpf indirect calls
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Marek Majkowski <marek@cloudflare.com>,
 Lorenz Bauer <lmb@cloudflare.com>, Alan Maguire <alan.maguire@oracle.com>,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 David Miller <davem@davemloft.net>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <157046883614.2092443.9861796174814370924.stgit@alrua-x1>
 <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com>
 <87sgo3lkx9.fsf@toke.dk>
 <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com>
 <87o8yqjqg0.fsf@toke.dk>
 <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com>
 <87v9srijxa.fsf@toke.dk> <20191016022849.weomgfdtep4aojpm@ast-mbp>
 <8736fshk7b.fsf@toke.dk> <20191019200939.kiwuaj7c4bg25vqs@ast-mbp>
 <ZRQtsyYM810Oh4px@google.com>
 <CAADnVQJpCe9e2Qrnsaj4+ab47z00-bEYyHhN_mmpCh4+9i17vQ@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAADnVQJpCe9e2Qrnsaj4+ab47z00-bEYyHhN_mmpCh4+9i17vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/29/23 17:06, Alexei Starovoitov wrote:
> For certain cases like your example above it's relatively easy to add 
> such support, but before we do that please describe the full use case 
> that you wanted to implement with indirect calls.

I'll likely want some sort of indirect call for nesting schedulers in 
sched_ext / ghost.  Specifically, when we're running pick_next_task or 
any thread event handler (e.g. wakeup), we're picturing having a 
dispatch layer that picks which bpf agent to pass that off to, *and* get 
a response from the call.  Based on that response, we could possibly 
call someone else.

In this scenario, there'd be a 'base layer' BPF prog that handles 
pick_next_task from the kernel.  That base layer would choose which 
subprogram to query for its pick_next_task.  Depending on whether or not 
that subprogram has a task to run, the base layer may or may not want to 
run some other BPF program.

I'm not sure if an indirect call is what I'm looking for here, but it 
sounds somewhat related.  The difference might be that I'd like to call 
a function from a different BPF program, if that's possible.

Thanks,
Barret


