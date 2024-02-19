Return-Path: <bpf+bounces-22246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FC585A1CC
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE5AB226D9
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424C2C191;
	Mon, 19 Feb 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT1EIYLs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CF2C19D
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341615; cv=none; b=gS8CM2WnXugJwKz6TUfRQNw7DSJqFRnHsOV+lLpLXgSySwMRwcs6IQBcZxlCQNqQs2a0Eq/sGnMABHcA6E+FRN3SAzRUHjSQYshGoLe3cGbu8Iv9BGeqSO+k5vA/mLCOOARk4A0sG2yQjTqJo2YPDhGPNDCZsmF+RlC5c8qFRCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341615; c=relaxed/simple;
	bh=XV6cKtLfrmYTIcB/koL/fQRZfD9SkLb5Pjv5erazBEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psDnns1a/UZtorucAQv3dtEcMUOPSx9m0rzLv+lNqfgfuB1cE8UmbvVG47BncSP4LSnYMiIqYb1DAGElifTw8516G6xekf7PlaQJWlhMb8KkD1qq/KnCyQs3kWfFz5ito3Bji1iAvPZvy3PqyvJSbY/Oy9aTvcvHxC6ngJnC5nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XT1EIYLs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708341612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx6lBGN9UuXNgSOF+4+o1lHbOJaq2/ssV352tnBE7/g=;
	b=XT1EIYLsakYrsCjqXkyh73kAEqdXZBqqVzhOlom8b7TGDsIPWsYYuswCdJ8FE/JCxbekvE
	AuXs92T5gDJusSINe38A5o2l1hyirJMHEFGZSOroeLTVk3SXCQEwxo5J9/2Q81FF2i514o
	dq4nDH743qwrMFJpCXPSpb+3G+J+LTQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-pn_NmmhJO3O5I2m45FkIDg-1; Mon, 19 Feb 2024 06:20:10 -0500
X-MC-Unique: pn_NmmhJO3O5I2m45FkIDg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a26f2da3c7bso181236766b.0
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 03:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341609; x=1708946409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx6lBGN9UuXNgSOF+4+o1lHbOJaq2/ssV352tnBE7/g=;
        b=ATcouKZB/SXR9aH0GINH3ir1LHfNGNyhIOTJxrmmoMNbsZV7J1L2LQel6YobtOVbmZ
         x7D7fWhVkIUTSCUKr2BMa27baRsf6fg7T4H1X+pEmG6/es78SpnJTnEy+Hdyr5SxkdpA
         hf9ZgMMVeb+bpwT4yBlH36ToOolypn0fMJVCqrfS1j2c7MV9nmczRkFPtehSivyBV6+j
         mV19+S95pnRH3SmzNohQeQGphPetwbtDddR9Q7WYdbkXfj6tNZBfipjHvJ7jgb2n17TX
         HxtUTrIvEPoVWb2FbLe4Qg1KMEJDiMUlITpkP0lTl3FT+IiD5wW29RY07GzD4ytJkqqx
         B93Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9SGSJJgTvvtlU4k8pdf/hN4F/4AUqboZ3ZbAqCdH/SJmJQ7m/S+oprzdyye+cc1Du1euwi36FPezIuZKSFqMM4R0c
X-Gm-Message-State: AOJu0Yx14uCA13Q3BxbbbioRPvpKT/pXFjAiRhz8vnUhmVUei1y41ibu
	Z9GTswFq3fkIjSNWNhn4ndLqCfwbGZE4ocY9rnWgoGXQ6lnoYwWGjMa0BXv2YZ3RneBzc/594sE
	Zyxd3jbyJQuRUZn+CTgIPIILl+AIumbSBZK22NQ/n/HXpMTpP
X-Received: by 2002:aa7:d9d0:0:b0:564:1cc7:eae5 with SMTP id v16-20020aa7d9d0000000b005641cc7eae5mr3712071eds.5.1708341609505;
        Mon, 19 Feb 2024 03:20:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEp7dvDcjm6dlYLzfPbiN5QfLoXx61VF3JJMlTRrxr4Dv2Iqf/rsqYC0mSRTJZrjj6YcFhyMw==
X-Received: by 2002:aa7:d9d0:0:b0:564:1cc7:eae5 with SMTP id v16-20020aa7d9d0000000b005641cc7eae5mr3712054eds.5.1708341609115;
        Mon, 19 Feb 2024 03:20:09 -0800 (PST)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id n17-20020a05640204d100b005642dfef25esm1425187edw.12.2024.02.19.03.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 03:20:08 -0800 (PST)
Message-ID: <f00c784f-527b-4389-b301-b20ded02c5b4@redhat.com>
Date: Mon, 19 Feb 2024 12:20:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <20240207153550.856536-1-jolsa@kernel.org>
 <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava>
 <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
 <ZctcEpz3fHK4RqUX@krava>
 <CAEf4BzY_UBNe4ONqKGg5VtA-nY-ozgpQ=Du1+8ipQNnZ+JKCew@mail.gmail.com>
 <ZcvadcwSA37sfDk4@krava>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <ZcvadcwSA37sfDk4@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/24 22:09, Jiri Olsa wrote:
> On Tue, Feb 13, 2024 at 10:20:46AM -0800, Andrii Nakryiko wrote:
>> On Tue, Feb 13, 2024 at 4:09 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>
>>> On Mon, Feb 12, 2024 at 08:06:06PM -0800, Andrii Nakryiko wrote:
>>>
>>> SNIP
>>>
>>>>>> But the way you implement it with extra flag and extra fd parameter
>>>>>> makes it harder to have a nice high-level support in libbpf (and
>>>>>> presumably other BPF loader libraries) for this.
>>>>>>
>>>>>> When I was thinking about doing something like this, I was considering
>>>>>> adding a new program type, actually. That way it's possible to define
>>>>>> this "let's skip return probe" protocol without backwards
>>>>>> compatibility concerns. It's easier to use it declaratively in libbpf.
>>>>>
>>>>> ok, that seems cleaner.. but we need to use current kprobe programs,
>>>>> so not sure at the moment how would that fit in.. did you mean new
>>>>> link type?
>>>>
>>>> It's kind of a less important detail, actually. New program type would
>>>> allow us to have an entirely different context type, but I think we
>>>> can make do with the existing kprobe program type. We can have a
>>>> separate attach_type and link type, just like multi-kprobe and
>>>> multi-uprobe are still kprobe programs.
>>>
>>> ok, having new attach type on top of kprobe_multi link makes sense
>>>
>>>>
>>>>>
>>>>>> You just declare SEC("kprobe.wrap/...") (or whatever the name,
>>>>>> something to designate that it's both entry and exit probe) as one
>>>>>> program and in the code there would be some way to determine whether
>>>>>> we are in entry mode or exit mode (helper or field in the custom
>>>>>> context type, the latter being faster and more usable, but it's
>>>>>> probably not critical).
>>>>>
>>>>> hum, so the single program would be for both entry and exit probe,
>>>>> I'll need to check how bad it'd be for us, but it'd probably mean
>>>>> just one extra tail call, so it's likely ok
>>>>
>>>> I guess, I don't know what you are doing there :) I'd recommend
>>>> looking at utilizing BPF global subprogs instead of tail calls, if
>>>> your kernel allows for that, as that's a saner way to scale BPF
>>>> verification.
>>>
>>> ok, we should probably do that.. given this enhancement will be
>>> available on latest kernel anyway, we could use global subprogs
>>> as well
>>>
>>> the related bpftrace might be bit more challenging.. will have to
>>> generate program calling entry or return program now, but seems
>>> doable of course
>>
>> So you want users to still have separate kprobe and kretprobe in
>> bpftrace, but combine them into this kwrapper transparently? It does
> 
> no I meant I'd need to generate the wrapper program for the new
> interface.. which is extra compared to current bpftrace changes

If you end up introducing this new kwrapper program type in libbpf, I
think that it'll make sense to have something similar in bpftrace, too.
Allowing users to write separate kprobe and kretprobe programs and
transparently combining them into kwrapper doesn't seem to bring much
value to me.

Jirka, if you need help with implementing bpftrace support for this, let
me know. I'm very interested in having this capability there.

Viktor

> 
>> seem doable, but hopefully we'll be able to write kwrapper programs in
>> bpftrace directly as well.
> 
> yes, it should be fine
> 
> SNIP
> 
>>>>
>>>> Yes, I realize special-casing zero might be a bit inconvenient, but I
>>>> think simplicity trumps a potential for zero to be a valid value (and
>>>> there are always ways to work around zero as a meaningful value).
>>>>
>>>> Now, in more complicated cases 8 bytes of temporary session state
>>>> isn't enough, just like BPF cookie being 8 byte (read-only) value
>>>> might not be enough. But the solution is the same as with the BPF
>>>> cookie. You just use those 8 bytes as a key into ARRAY/HASHMAP/whatnot
>>>> storage. It's simple and fast enough for pretty much any case.
>>>
>>> I was recently asked for a way to have function arguments available
>>> in the return kprobe as it is in fexit programs (which was not an
>>> option to use, because we don't have fast multi attach for it)
>>>
>>> using the hash map to store arguments and storing its key in the
>>> session data might be solution for this
>>
>> if you are ok using hashmap keyed by tid, you can do it today without
>> any kernel changes. With session cookie you'll be able to utilize
>> faster ARRAY map (by building a simple ID allocator to get a free slot
>> in ARRAY map).
> 
> ok
> 
> SNIP
> 
>>>> I bet there is something similar in the kretprobe case, where we can
>>>> carve out 8 bytes and pass it to both entry and exit parts of kwrapper
>>>> program.
>>>
>>> for kprobes.. both kprobe and kprobe_multi/fprobe use rethook to invoke
>>> return probes, so I guess we could use it and store that shared data
>>> in there
>>>
>>> btw Masami is in process of removing rethook from kprobe_multi/fprobe,
>>> as part of migrating fprobe on top of ftrace [0]
>>>
>>> but instead the rethook I think there'll be some sort of shadow stack/data
>>> area accessible from both entry and return probes, that we could use
>>
>> ok, cool. We also need to be careful to not share session cookie
>> between unrelated programs. E.g., if two independent kwrapper programs
>> are attached to the same function, they should each have their own
>> cookie. Otherwise it's not clear how to build anything reliable on top
>> of that, tbh. This might be a problem, though, right?
> 
> IIRC it's tracer specific data, the shadow stack data should be unique
> for tracer and its called function, but I'll double check on that
> 
> jirka
> 


