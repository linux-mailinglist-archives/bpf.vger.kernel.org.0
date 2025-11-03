Return-Path: <bpf+bounces-73299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC990C2A213
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 07:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD0C3A3A79
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 06:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4055D22370D;
	Mon,  3 Nov 2025 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYnJbs4v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6182AE70
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149641; cv=none; b=kFmkLZ+9/lfyJUcPT844GS1/zwi2TibUv5WmTUMItzeBUz5yWHOLnjhiVJfYke/8ZBYU4XO+CFRu2BuuP/4pcKX5nMMhFxb8HxfZMgI45onUrx5fjUO5ekXsc4udc3jJ+tcR0rDHlwn/1W8I7jPDXcmDJKy2RCkgDDiRAUsVamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149641; c=relaxed/simple;
	bh=dVwCHJXTZsWhOYA1AO/9rpvP07SF8u8wi2kPt8EuWAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nzn66cWjhzAzVc7O3Yz51YoSntHSlUOgv7b4glrY//BWKafuoB5SWa0h3Bwaz+GINWzQOUI2IGSMeMqHNJU9BfdHBKS1xRW9KSxZifQ5m9P0I0dM86Fy24c9YjmHmxLvl2Fo1r3veiAEUI7DA2vwoLYpZR/vpw2TmC31lC6/mwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYnJbs4v; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290aaff555eso36088855ad.2
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 22:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762149640; x=1762754440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVwCHJXTZsWhOYA1AO/9rpvP07SF8u8wi2kPt8EuWAc=;
        b=UYnJbs4vIjMLsbtCjskCs16VmNkF6uhydvwRR4mlD1zmXzolRcPnfe/KxgderLfBNt
         9cckavzkfNCaZop7/2tDqJjRpUedOH7L1x9HSb41HAHx0LnLQGWHihxmRYxpw++k1zbw
         Vc0X0MRA5zyxLVuuEBfKrW5WFFh+OERDayKUUbkmHHhAy2j7lgVQP1Jy5kQn180eqo2y
         aFn5NfJt1rTsjuZ6XFRt8AOOPBaFTKHLL+Q27U7akRaENTpKRzLRbZWwpdk4EUNGOknE
         KfertAPTHErrafxPKC4AArb2Y0Lr61P+XMjkiOe2+r3k7K0UHZ+KIzsZfwx51K7cPhzA
         9yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762149640; x=1762754440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVwCHJXTZsWhOYA1AO/9rpvP07SF8u8wi2kPt8EuWAc=;
        b=C/3k/kkrQhZh21EngQGQ/KSv3fqQZF++eCvMKACH2rSuvy8csldDjobWJDpCtDu15L
         eMD1+l1PAFem++c8/rx42LCFSQYSG/nvAaBiWMvbZZck7xdGToXoJ+WbjNZIzanm8t8K
         BzXoBtTcqe0pHbEoLmRJGIFtLmkfndtEf7fabw6Es/k4+SjhdAf4ZdEAaOLtCVELJQBS
         IpVeO+g3A5oFrylSoIQFiEztUDQBQIo0PfoW7LO5IePSuLr5OCibBcTOdVp/HABTC4B2
         ImybA9xgdhEQX5MJ/iDAuzgqWVRX8NmxlysLQRgbWvsGr0mSxe7SAQfGY3Qjv+Dns8nB
         6tcg==
X-Forwarded-Encrypted: i=1; AJvYcCWSdMeBBQ47B4uDn9yexX0Lvde88J19Py2fHm1ym59A4YhAdBeY76xRd1fToV5V8h2nzXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fLN+a0xeDuqpSFpgWiX2yJN6Jh0Q9vQHnFRaqHgkS+w3+ALX
	V+FzyRFHonryB9B9RL5kvlsSLpRXjoCRPVPFK5dQeDvz07lpWTLzpVMF
X-Gm-Gg: ASbGncvuYia+BrdTc50FucvcynB+i6OWZ1bG2o17TRwVluXp/YcY2/qJkv2od/wQMSJ
	bR5d1QQJO0K/WfDrjooQwohW5yhZBbQ5WV5Ucze7yD6/IFSumAO6fngkIPXHF1Uza6oms6bxFcH
	fVuP4P8nIiCbvQdJUmlaSKq62yK3AsOsKUL7jw2h5z6Q9k7DQ+uiMpE+zSIMuIaHp5PTAP3/2Q6
	HCaNHJjmZ7trEgR5p465NOb9D2SVnmuWSQa+QkzWB0H6gUP1YRHMaMT+mvu1Rwoh3bt/GpQZgiB
	FWvlmtrPBCgkuK/R5ELC1ZczwJsWr4McNzebhV3UbcdcQahUWoYyrIhTPQswiMQjOzGUW2B3hmh
	G94jFuZYifyBkvE2erDx02CSYsn2JqfUC9fEpjXYBjgzN9PquGWveUm+ED6TC1Kj6mettaa4eEZ
	DqsyoRM2xhavV72YYtA/7MfA==
X-Google-Smtp-Source: AGHT+IGRzFc83vH+4aej1ZtXWsWRwhc5e/vhPzGXxyYQr93eNqozzEOLe2v+EaAyyyHN0ypSfD81jg==
X-Received: by 2002:a17:902:daca:b0:27d:6f37:7b66 with SMTP id d9443c01a7336-2951a486898mr157814315ad.47.1762149639568;
        Sun, 02 Nov 2025 22:00:39 -0800 (PST)
Received: from [10.22.64.59] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29531a1965esm99055775ad.6.2025.11.02.22.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 22:00:38 -0800 (PST)
Message-ID: <bac1bb8a-b9fb-46e5-ae96-cf963d0a337c@gmail.com>
Date: Mon, 3 Nov 2025 14:00:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>,
 jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <20251026030143.23807-5-dongml2@chinatelecom.cn>
 <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
 <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
 <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/11/25 01:57, Alexei Starovoitov wrote:
> On Thu, Oct 30, 2025 at 8:36 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>
>> On Fri, Oct 31, 2025 at 9:42 AM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Sat, Oct 25, 2025 at 8:02 PM Menglong Dong <menglong8.dong@gmail.com> wrote:

[...]

>>
>> Without the session cookie, it will be much easier to implement
>> in another arch. And with the hepler of AI(such as cursor), it can
>> be done easily ;)
>
> The reality is the opposite. We see plenty of AI generated garbage.
> Please stay human.
>
>>
>>> At this point I'm not sure that "symmetry with kprobe_multi_session"
>>> is justified as a reason to add all that.
>>> We don't have a kprobe_session for individual kprobes after all.
>>
>> As for my case, the tracing session can make my code much
>> simpler, as I always use the fentry+fexit to hook a function. And
>> the fexit skipping according to the return value of fentry can also
>> achieve better performance.
>
> I don't buy the argument that 'if (cond) goto skip_fexit_prog'
> in the generated trampoline is measurably faster than
> 'if (cond) return' inside the fexit program.
>
>> AFAIT, the mast usage of session cookie in kprobe is passing the
>> function arguments to the exit. For tracing, we can get the args
>> in the fexit. So the session cookie in tracing is not as important as
>> in kprobe.
>
> Since kprobe_multi was introduced, retsnoop and tetragon adopted
> it to do mass attach, and both use bpf_get_attach_cookie().
> While both don't use bpf_session_cookie().
> Searching things around I also didn't find a single real user
> of bpf_session_cookie() other than selftests/bpf and Jiri's slides :)
>
> So, doing all this work in trampoline for bpf_session_cookie()
> doesn't seem warranted, but with that doing session in trampoline
> also doesn't look useful, since the only benefit vs a pair
> of fentry/fexit is skip of fexit, which can be done already.
> Plus complexity in all JITs... so, I say, let's shelve the whole thing for now.
>

As for bpfsnoop[1], the new attach type is indeed helpful.

For example, when tracing hundreds of kernel functions with both fentry
and fexit programs on a 48-core bare-metal server, the following results
were observed:

bpfsnoop -k 'tcp_connect' --output-fgraph --limit-events 1 -D
2025/11/03 13:32:11 Tracing 586 tracees costs 10.190874525s
2025/11/03 13:32:14 bpfsnoop is exiting..
2025/11/03 13:32:45 Untracing 586 tracees costs 30.667462289s

With the new attach type, about half of the time can be saved.

For bpfsnoop, the return-value control could help avoid redundant
filtering in fexit programs, though it's not strictly necessary.

For instance, when tracing udp_rcv with both packet and argument filters:

bpfsnoop -k '(b)udp_rcv' --filter-pkt 'host 1.1.1.1 and udp src port 53'
--filter-arg 'skb->dev->ifindex == 6' -v
2025/11/03 13:52:55 Tracing(fentry) kernel function udp_rcv
2025/11/03 13:52:55 Tracing(fexit) kernel function udp_rcv

With return-value control, the filtering in fexit could be skipped.

Links:
[1] https://github.com/bpfsnoop/bpfsnoop

Thanks,
Leon

