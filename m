Return-Path: <bpf+bounces-57257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DD6AA78E5
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 19:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F2F1C02976
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74915261589;
	Fri,  2 May 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q16HuOAp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052C42A87;
	Fri,  2 May 2025 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208556; cv=none; b=O2uPm5nk3aE0I9OigU8mr1YJzfPlYqdDyiPCv9YBPmaJlq6cgQ9qUvtOccTs8e8H/AHnMTYqV6HU5myFRcxJLrYcd3y3lNxGI+/2/ZH41GYA/brRsTX6Z9UKOlQosCYHp0Cz+Pz2HciCv3ORShobpMToOf3WkMLbQxcefmKMywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208556; c=relaxed/simple;
	bh=Lyw78FzLF5l9cEh9Dgtvhw7XnisV/EdGEAE4Tbtjpco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3/YVbxpCl0XKxg/LqQqoJcm9N5d0s1fLxWsJxae65ImWrfLmkgiOpLnklIC1nEtaBPhDzb0n7Psyg5mr3hshNSsYUB2dHLAedVRhE3hiDFpiiQI0SF13M/lMJBBEwQ1fqremdCy3e9Mt3dPgtDTYPzRxvbMsD3cN2OdJbz6H2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q16HuOAp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso1292334f8f.0;
        Fri, 02 May 2025 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746208551; x=1746813351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJuPjJpIf6+ibnlHaAEOHWVIs1EFJfC5yfPtDzkxsfQ=;
        b=Q16HuOApJAOHQhCvYWyMAyKMWWhwa4Ppi7F6HWariUKfKXVPgoInGd6T6sfca2LOuL
         7hVM3MqWog+hVW5Ew6UvUDJB5yz/yiOSAiA3HMDXqGLqbxhROcf+avYCpmL9gzhg8jhF
         n2vD3ihwAqx0RP5QH6Iu6x9qlYa58VEGqwy2NJVD3kKXijDGkalWY7w4NP03vucrPBAl
         EzSarCV+M0W0bLpV6Xdcf3+W0w04NJvlJlWS6SBK5/G5wqqHeeyPskPsVtdqKRxY4QOS
         0mCkxOj/P6NztB2A+Qc4PeyUp7SCxtL+xjx2PWSMcUPkRfv4LjxG6MkDPkq3hP4h6fIf
         49Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746208551; x=1746813351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJuPjJpIf6+ibnlHaAEOHWVIs1EFJfC5yfPtDzkxsfQ=;
        b=MVLtX/p2Alx8jTRarhDXw/j8xlvHqvoJQJWNPX08QMbbZXcm3/j8QGFb2zvlPSfGTe
         OekFke/g5TdKdPXTue24OGSwR0mN6xq+jk/AKseL2lcIgQ/pX7BBKV3772jtWMgkFuk/
         8HtEiURnVEW2sTtJ87OJ8z5SfGgjoWN58TDw+moFhfMuEgh40vVrCSYwvleU7OeyvCgq
         b1PpjEO2lM24T7m0WXlenrHFQyZEOMgqzkGRdW53zAeAs0cuypOaJ0+NXHXXeL21mUTO
         A4mOxsLoH5+GqkVyaP9KG7h8Xi9TBkmm/3lXW6tuVIXPdh8daGOEobk4H6qnfKq8xfFA
         8gCA==
X-Forwarded-Encrypted: i=1; AJvYcCWviZ2q6Ao3y7+DiXHMGMVj9XyctLUEA0laZPyMVfMiwaQdBpGSaBCl6Yjuy5Ujn5yMzMI=@vger.kernel.org, AJvYcCX44Z8Yg3jeVRMQ6LbKS1Rd3ZeyU8r3Jeiexa2JiNtJmy6JXRQrdYda4xiQMhOp8j+nSA4RdLAW@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNLMEQjHsQzeQFKC/y0n7B97GkUNTxZ1dt0g/UDb1UZv+Rv8I
	uQrzo6Y63Yuqk9zCtiwEBREagw87a7FyfzEmIjRNh8yF2CwHLaLbXyFMskd1Rj3gRI/Cvar9mPY
	ED+M6G+ILSFDBnQZHlsW5AX0vekZaZA==
X-Gm-Gg: ASbGncuYrdfB01l+hjjZtjlbmaWCwcTFP9JPsuAQjeuOhOYleHTZkXwNkaMHjDhNosz
	H24g5ljPoeIy5iyZz9LSdGxHIJlNGCnRi9+Z8+lF2oauDTPw/GBPN+eAbr8z//rzG4CU5+JpC6y
	JzZbVr5AAb64QNaID8Z3NO750uATyIE6eO1khDjA==
X-Google-Smtp-Source: AGHT+IH5V8PPEU6zhjakxr4Xawb2hEbsxq1Z5YXvZgsgkqc/W7ihRkh5IG8IjekFk2ZXqhZE3CXbqzB1L2xcddMOxA8=
X-Received: by 2002:a05:6000:3113:b0:38d:de45:bf98 with SMTP id
 ffacd0b85a97d-3a099ad28bdmr2847869f8f.8.1746208551512; Fri, 02 May 2025
 10:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com> <CAEf4BzYUNckc9pXcE7BawxWFVfY--p12c3ax8ySP1P+BEww91w@mail.gmail.com>
 <CAADnVQL92e=-Nzr0O5Geev4y7cWG2m1UR_D7izF+Rd2ccPMNKQ@mail.gmail.com> <CAEf4BzY3oYWkUshYD7ybiB5bcGoLnQxukYObmgRtRZoEi=ZMTw@mail.gmail.com>
In-Reply-To: <CAEf4BzY3oYWkUshYD7ybiB5bcGoLnQxukYObmgRtRZoEi=ZMTw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 10:55:40 -0700
X-Gm-Features: ATxdqUEjFdDyn8-TRi76naztcBPR2U_uvQEO-qMff_V_2nOUiKnChv3TEixoinE
Message-ID: <CAADnVQ+N5u8KTtcsKOWcDmQ4X=OmvTf+LfLhY=VLQJ7q-=Li7Q@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] Task local data API
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 7:22=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> I wasn't trying to optimize those few bytes taken by szs, tbh.
> Allocating from the end of the page bakes in the assumption that we
> won't ever need more than one page. I don't know if I'd do that. But
> we can just track "next available offset" instead, so it doesn't
> really matter much.

Right. That works too.


> >
> > I'm not quite sure how different processes can do it locklessly.
>
> There are no different processes, it's all one process, many
> threads... Or is that what you meant? tld_metadata is *per process*,
> tld_data is *per thread*. Processes don't need to coordinate anything
> between themselves, only threads within the process.

Yeah. I confused myself thinking that we need to support this
through fork/exec. Since they will be different processes
they will have their own task local storage map elements,
so any kind of signaling into a child needs to be done in user space.
Using bpf tls map won't work.

So using one "tld" library in multiple threads within a single
process works. No need to complicate things by asking kernel tls map.
"tld" library can keep whatever state it needs,
centralized locking, etc.

> As for how I'd do offset allocation and key addition locklessly. You
> are right that it can't be done completely locklessly, but just
> looping and yielding probably would be fine.
> =3D
>
> Then the sequence of adding the key would be something like below.
> I've modified tld_metadata a bit to make this simpler and more
> economical (and I fixed definition of keys array of array of chars,
> oops):
>
> struct tld_metadata {
>     int cnt;
>     int next_off;
>     char keys[MAX_KEY_CNT][MAX_KEY_LEN];
>     __u16 offs[MAX_KEY_CNT];
> };
>
> struct tld_metadata *m =3D ...;
> const char *new_key =3D ...;
> int i =3D 0;
>
> /* all m->offs[i] are set to -1 on creation */
> again:
>
>     int key_cnt =3D m->cnt;
>     for (; i < key_cnt; i++) {
>        while (m->offs[i] < 0) /* update in progress */
>             sched_yield();
>
>        if (strcmp(m->keys[i], new_key) =3D=3D 0)
>             return m->offs[i];
>
>        if (!cmpxchg(*m->cnt, key_cnt, key_cnt + 1)) {
>             goto again; /* we raced, key might have been added
> already, recheck, but keep i */
>
>        /* slot key_cnt is ours, we need to calculate and assign offset */
>        int new_off =3D m->next_off;
>        m->next_off =3D new_off + key_sz;
>
>        m->keys[key_cnt][0] =3D '\0';
>        strncat(m->keys[key_cnt], new_key, MAX_KEY_LEN);
>
>        /* MEMORY BARRIERS SHOULD BE CAREFULLY CONSIDERED */
>
>        m->offs[key_cnt] =3D new_off; /* this is finalizing key -> offset
> assignment */
>
>        /* MEMORY BARRIERS SHOULD BE CAREFULLY CONSIDERED */
>
>        return new_off; /* we are done */
>     }
>
> Something like that. There is that looping and yield to not miss
> someone else winning the race and adding a key, so that's the locking
> part. But given that adding a key definition is supposed to be one
> time operation (per key), I don't think we should be fancy with
> locking.

something like that should work.
I wish there was some trivial futex wrapper in .h
that can be used instead of pthread_mutex baggage.

