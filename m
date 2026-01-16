Return-Path: <bpf+bounces-79297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DFBD3326B
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64A2930066D0
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162426F2B0;
	Fri, 16 Jan 2026 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpkQvjX5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDA1E991B
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576978; cv=none; b=RtTn7xKeK7JTNr0LhR/ZKGr1bAkhUDzY1Khb8dLj6mFWqIbMUJCG2EQzrWHYU0z/JJJBFgLqWhaJ1WveuXJEsL3bdAtQnGdjW67EHAWlEJxAyJ4NNjt4S2Hh7gL861K4zuLIKRS8ymyXWL2YvwkxtjSmocEOg9/E5Di2bxutzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576978; c=relaxed/simple;
	bh=USp5yAkQvp+kXKsl+upsAEBRXQmIb486TZhc9JQk+gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBT18rDsP5Z850BriNfNtx53TZ6gfvd/xFvR1iF8xwzKARjD+y4dJtD4RP0VEEZfQtXy45EX4OxylO/gxCtkrgeWnSsunaK6hhqiLapKojEri1RkpMrmZWUutV/cdN4cOdHLwreGYLed9hqqpmk+tEb7DnRKvfFoofq3ZnM+F7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpkQvjX5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801bbbdb4aso10198815e9.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768576975; x=1769181775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os8mqSNmACgKIu6oNUBP8kQVYzhABL51yoNNIuWGPhI=;
        b=PpkQvjX5AK1lenWod9haTPXSh79dCohw9X6rl5vwKrkofL4hk9K3DtIae9VyoF7m4d
         rj7EhDTbpSSd2A3T+yTA2pmyO5v/7iKjRWszo0BCCU9/yPO44X8MIvBdpinI0LoMFS2I
         iidZvbtRoyDJ/+oyfctLq1js+qdmTM78TXbzz4raztz66/ChvalN1cdWZyPdhArJDwsO
         kam1xRqe7rtsMjbSJ1TdU8HQ5BQuZBgXpwIGBPzGljq32ShNUjgM+QMqbpBWy+jlr1J/
         v1nl2Zap+exhxJB4UkGgzVnelDorfq7PEDyc+Ilv/oov0vXCfNrhyTyumynFgSR8gcO5
         S5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768576975; x=1769181775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=os8mqSNmACgKIu6oNUBP8kQVYzhABL51yoNNIuWGPhI=;
        b=d3u+e4fwH/ctInnm3f6gYFwd1owKkAHuqiozgiatLQ/f1sY+XCfftlgEVC892PdxfC
         0lIhnrGbFCfteuwCRahtRrvzc7brZnLar9zk54uQItkAF8XkcZxtWaJrWaPjdm80M3NV
         dcMG74GoLQGE+ZGPpxFYdIgFtvwzM9iILF7dVYdV9Lvz2mj4wxyRhgNvoMTGIASSLusI
         ddxzQuKOkW6qLKqPmSuRHtmWdRU5kcZMMNKghfHyFbFJqeQFfOP8jCKrcPx5c1JDMIaX
         EkDaHisFoRJsXskzBNwWx+TPkUZJOiLCiYpMXMM6dXwAEITMEb04viNceM69RuI/e4iQ
         pAWg==
X-Forwarded-Encrypted: i=1; AJvYcCVKKH0CnwfQo+8Fh5XiSPcJ/RDxFsF2VzOBkyAnMOjATn8z/uvwfLACPHx9kimq1x8kjI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKfGtkBkKeocpwkNPXZtYQs+WA2gu1J2D+6ZsQR0F8mmWNkCx
	RfqkqJSWGbeQB2/lQmNYB9yMqJXpZnr4z/sdTBxfvSAipugbxdRSCKXL+j1kuWdiqfGXVW1o4HY
	3q28E1vfZdNsgHJ1awgOlKUfyjleEftI=
X-Gm-Gg: AY/fxX5sfe3wykpO4zxAz6uu5vbXYjRDROTRvShYMDr/U+5l/qlg6N9vdcrGAui6+V1
	IUPoZ09+npYhUXqgXo3t+6ZhstNMsKqUNvOsI3KjX4+SqgDMcZUfScd9gv1kuKQIF4Kv2xLE1PS
	BhP28NPDoA9ysOWOGWPzJxZ3YNghI/GpWB9s59lqtNRmpyOQDd08EhhImdgfxMngUzT0ef99pZ+
	Kg9JWYsN1xExJld62fBM29G/uBgSQTdtX3lORq0V636EV8q2kRsHhTciqoOAs5NxkwhfSjHGAlH
	CxhoOCBVXVP7AxZOYI6woZ9e/L0TdelhiiO5nPdqPaogrBOKaYzLit1ddRzKbb0Zk2Oip9sdnBZ
	8akQIJRT0ApgCbA==
X-Received: by 2002:a05:6000:420a:b0:432:59d4:f54a with SMTP id
 ffacd0b85a97d-434df116a6emr9850206f8f.30.1768576974631; Fri, 16 Jan 2026
 07:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113083949.2502978-2-mattbobrowski@google.com>
 <87y0lyxilp.fsf@linux.dev> <aWnu-b0dlm0xZFDS@google.com>
In-Reply-To: <aWnu-b0dlm0xZFDS@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 Jan 2026 07:22:43 -0800
X-Gm-Features: AZwV_Qi6LVWu3mKu77v-ISA0xs_CeLADq3VZFsWKhiT8kUHFybSrm9F0BreWtEU
Message-ID: <CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:55=E2=80=AFPM Matt Bobrowski
<mattbobrowski@google.com> wrote:
>
> On Thu, Jan 15, 2026 at 08:54:42PM -0800, Roman Gushchin wrote:
> >
> > > With the BPF verifier now treating pointers to struct types returned
> > > from BPF kfuncs as implicitly trusted by default, there is no need fo=
r
> > > bpf_get_root_mem_cgroup() to be annotated with the KF_ACQUIRE flag.
> >
> > > bpf_get_root_mem_cgroup() does not acquire any references, but rather
> > > simply returns a NULL pointer or a pointer to a struct mem_cgroup
> > > object that is valid for the entire lifetime of the kernel.
> >
> > > This simplifies BPF programs using this kfunc by removing the
> > > requirement to pair the call with bpf_put_mem_cgroup().
> >
> > It's actually the opposite: having the get semantics (which is also
> > suggested by the name) allows to treat the root memory cgroup exactly
> > as any other. And it makes the code much simpler, otherwise you
> > need to have these ugly checks across the codebase:
> >       if (memcg !=3D root_mem_cgroup)
> >               css_put(&memcg->css);
>
> I mean, you're certainly not forced to do this. But, I do also see
> what you mean.
>
> > This is why __all__ memcg && cgroup code follows this principle and the
> > hides the special handling of the root memory cgroup within
> > css_get()/css_put().
> >
> > I wasn't cc'ed on this series, otherwise I'd nack this patch.
> > If the overhead of an extra kfunc call is a concern here (which I
> > doubt), we can introduce a non-acquire bpf_root_mem_cgroup()
> > version.
> >
> > And I strongly suggest to revert this change.
>
> Apologies, I honestly thought I did CC you on this series. Don't know
> what happened with that. Anyway, I'm totally OK with reverting this
> patch and keeping bpf_get_root_mem_cgroup() with KF_ACQUIRE
> semantics. bpf_get_root_mem_cgroup() was selected as it was the very
> first BPF kfunc that came to mind where implicit trusted pointer
> semantics should be applied by the BPF verifier.
>
> Notably, the follow up selftest patch [0] will also need to be
> reverted if so as it relies on bpf_get_root_mem_cgroup() without
> KF_ACQUIRE. We can probably
>
> [0] https://lore.kernel.org/bpf/20260113083949.2502978-2-mattbobrowski@go=
ogle.com/T/#mfa14fb83b3350c25f961fd43dc4df9b25d00c5f5

Instead of revert of two patches, let's revert one and replace
with test kfunc that 2nd patch can use.

tbh I don't think it's a big deal in practice.
Kernel code working with cgroups might be different than bpf.
I'm not sure what was the use case for bpf_get_root_mem_cgroup().

Roman,
please share your protype bpf code for oom, so it's easier to see
why non-acquire semantics for bpf_get_root_mem_cgroup() are problematic.

