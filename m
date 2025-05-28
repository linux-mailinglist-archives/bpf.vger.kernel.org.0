Return-Path: <bpf+bounces-59038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4EEAC5E2B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC747A1DC8
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF15103F;
	Wed, 28 May 2025 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmvcpgFL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD26EEB2
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391807; cv=none; b=m8Uz+Sa9Ioai2aQ7ycaegN1H7cFhC1xc0eq2KKZWokCt5cnKawmX419HnZXiaFVcYXy5rFyuyLvEixkjf2XsfPPjpT89iiTWODGVlbcRELT08/Yq5hHqj1YS6nj7HE2j0oEH748qFWhdNNsd6ASMdlA7f5BLksvBGjGDm4qq75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391807; c=relaxed/simple;
	bh=B7rkpwyPYpA/PoKDI3+Ear/NQy0RVcUQ+PAEsi89Reo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rjiRwpp1P8L30sr2FB+kbfJBG39kO/blQPVdvIU7GR4ylsK+yYouAW/t61QpPZaxy6yd3S6VzVC1T59I/XFpOSWyjw2dsyNNIUdqpgxghIx4jiRKiYF+kd6C92lH3s8xHqB5Xh7HGqTp7nSehn+xRxr8hBC6GWjYxzGmfKOb/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmvcpgFL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b1fb650bdf7so1969098a12.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748391805; x=1748996605; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDbfNYmRdBjFPlNFEjKd7XOoc5xfKt5rPyc+oZynZSU=;
        b=HmvcpgFLz6jBNEi8oq7hzoCDSjNLRULfZivuk9aH+yirzeiR38ZZMdwc9onQPeXyk/
         Ovz0dPWTbRZDqS+2TGnS+AEp1+UzO3ypE/EQw483Zzu7GX0h1zVBe4+jZDoC+TIVv9Bq
         IAB4h2AhiZbGBxYUWvZUk+ExBsXHxy4KStXgxRsQwoYj64W5mtlc9AnsldjGhQvJkem+
         rM0e7C8SwPpSciSyZ6ZDrNJVmQOpGGFB0rAgBJKc3joRVwWo174jmZ8bjMkrYm/qHzUc
         DoTNW1lIdy6DsNV/g+8/XHbZK+uvqVdYkKepcHmScMEZ2QQWuQTKFgGCjTjAJwLo9KAF
         HIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748391805; x=1748996605;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDbfNYmRdBjFPlNFEjKd7XOoc5xfKt5rPyc+oZynZSU=;
        b=RkDGVnUfk5I6yFFeYWML6Cm+0ibi9vZQ9xDXCDjdZ7YuNmkU8HCesJJOLI92RO9i7R
         b8ELJGCcEfqEYcZl86kmbCL6DrhJgvdlLxqHWy9t2v3ETq92gxw10+tn8RQYFOWBFBsG
         SqZsGgIQnrCJM/pgOh/pWKXbY9UMMLONTJ/Cv/JovqKu3wfBSLbUvbsoopnzuXaUhGT4
         c5/uUzD8Yzx42U3yJXwfINYyHjexphB0ie8k++Gt8R96JHxf08jmxttFLibpJVcFM6Y2
         L26Au+Rf9/34Vw321EA/ZEhjVaU/oq+Pt0enWH95T5mU41DFo4wPIE/eCS9vE4mwIBZh
         nvAg==
X-Gm-Message-State: AOJu0Yw1MHiqacd5c8P11U+iEf4TW7erQNpn7wii7Gn6MdfWBIGj8Jzo
	dN9I+ZNpApeMU9RMDPHW16g9DHfrZ7OvKstTPJL0Gnre+OkeDQqBDB8x
X-Gm-Gg: ASbGncthENDI+2e569ytAhwmrqLNl/p92rzRLakgLXdjhncgYU3zz4qlmhJEoSPVXYI
	8S6RyLKYmtHQ5PR/E64Kw6+DBs3j0fbsR87/lnt9TIq0qj3mB/g9VJTNh604iKTOFdgWEaiT3yA
	LfuMWCBK9a8mTVampbjiNw4g4pk+7ro+Rqna/ai0HqSnVnZ7NWTQSyA8gGa4Y5IHl4vs7WY0o+F
	1TruWrBMjCw1W/C9bkGCmIxkL75V3pFvz9oNytl5L6LEKW9vEafrK57+LvsnPDEhycWnMUiZ6zI
	xkWe5xgyE+hwDZECtNH641EHisO9wF7ASL/TBE9Hz9zCMpO3upGOw/s=
X-Google-Smtp-Source: AGHT+IHh2mYIaVfZ+NMixvr05SkGzcAfsjaDV0xw5XNun/ecp8CVFqAYunXM7FqDuD84grtoE5mIfQ==
X-Received: by 2002:a17:90a:c2c3:b0:2fe:9581:fbea with SMTP id 98e67ed59e1d1-31110d92962mr21308025a91.29.1748391805446;
        Tue, 27 May 2025 17:23:25 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::7:461c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e9b636a4sm19982a91.19.2025.05.27.17.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:23:25 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 01/11] bpf: Introduce BPF standard streams
In-Reply-To: <CAP01T77zkuR1MGOmBXCnsjjQPezLHfz0RRayfqDYZ0_h0Z4X9g@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 28 May 2025 01:55:20
	+0200")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-2-memxor@gmail.com> <m2cybt62gp.fsf@gmail.com>
	<CAP01T77zkuR1MGOmBXCnsjjQPezLHfz0RRayfqDYZ0_h0Z4X9g@mail.gmail.com>
Date: Tue, 27 May 2025 17:23:23 -0700
Message-ID: <m2bjrd4m84.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

>> > diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
>> > new file mode 100644
>> > index 000000000000..b9e6f7a43b1b
>> > --- /dev/null
>> > +++ b/kernel/bpf/stream.c
>>
>> [...]
>>
>> > +int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
>> > +                         enum bpf_stream_id stream_id)
>> > +{
>> > +     struct llist_node *list, *head, *tail;
>> > +     struct bpf_stream *stream;
>> > +     int ret;
>> > +
>> > +     stream = bpf_stream_get(stream_id, prog->aux);
>> > +     if (!stream)
>> > +             return -EINVAL;
>> > +
>> > +     ret = bpf_stream_consume_capacity(stream, ss->len);
>> > +     if (ret)
>> > +             return ret;
>> > +
>> > +     list = llist_del_all(&ss->log);
>> > +     head = list;
>> > +
>> > +     if (!list)
>> > +             return 0;
>> > +     while (llist_next(list)) {
>> > +             tail = llist_next(list);
>> > +             list = tail;
>> > +     }
>> > +     llist_add_batch(head, tail, &stream->log);
>>
>> If `llist_next(list) == NULL` at entry `tail` is never assigned?
>
> The assumption is llist_del_all being non-NULL means llist_next is
> going to return a non-NULL value at least once.
> Does that address your concern?

Sorry, maybe I don't understand something.
Suppose that at entry ss->log is a list with a single element:

 ss->log -> 0xAA: { .next = NULL; ... payload ... }

then:
- list == 0xAA;
- llist_next(list) == 0x0;
- loop body never executes.

What do I miss?


>> > +     return 0;
>> > +}

[...]

