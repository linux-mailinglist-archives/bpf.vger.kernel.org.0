Return-Path: <bpf+bounces-21849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 413F78532ED
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5552DB219E0
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826157868;
	Tue, 13 Feb 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB/170gw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25BE58105
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834109; cv=none; b=HbMR76G9wyzQp3aMf3wnJLsmOqE5f/96vT+RyZSpPhgQ10wp/BIfX6hztyjsTihbns0bQ2R8PqezCwM5DV50OpLaN3UXsErJTsK95L8PsJ5wyAi/1zw+hl92ti/S6SCoocpadDjU7iEE2UhA3Tgw7H4G6q8b/uKj4kBsaTKW2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834109; c=relaxed/simple;
	bh=JzMkutfl7oTzBvv9x1fmJ05kglU/COGNDqlOjWb3CGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MwXl5ZT01+PkwVJDTytFjh7KoXc+xIvskc5I2ECqj/BoysD0TU+uTxuyeHXdGZElkF6SoDnA29LiwxZOPKggU8Rw6551PQISG2cYxYnUOFr3ZuDms/V5DKwud8BGjqnalqalAJ+JzHKt46TlaYXK1mkOb8HIzb0EtKyJIfL3K1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB/170gw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so5489410a12.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 06:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707834106; x=1708438906; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZ0mG5JsJwuGoJTo0oxXsut5g7kgIj9gkyrUWgPoOxU=;
        b=ZB/170gwkMIXCMcLvqMXQ9geNfCD2DiRT/Qv4fBjd2IkH2MDFXSE9eGXD3kwdVheb/
         HRYVx+Vb891iyBqK7E139bDfZe/bgfFCjiNN5PZtgYw266uXqQx/9muuvscrA/yTLZDM
         Rxb4oPlMT52xJ4OOabxGAzJrAGBF1FYeK8go4RIp7nP9aCxd8hdwlr1v+zWaHycwrKFz
         QwwRbL3txhh5i/4VtrP/vqaIY4rkjq8HO/7l/NEgwHhC71sLM4HanAm2IlXyrjf0F2V7
         StUASsUMFktB6EULXwaxjNXhYjyUwHaxkgXHUd4RfzGf8iOIE89HS8057EtT8YAFruCi
         eEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834106; x=1708438906;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZ0mG5JsJwuGoJTo0oxXsut5g7kgIj9gkyrUWgPoOxU=;
        b=XEG3srB+MO08e9gpx7Mf/7FG5lfibuCOxcbv5PUmGKwmj3V+eJY4U+iJFjxIbfJegl
         JdkWoILe6kUZLJONBLjUEl14Z+PTZ6YIxV0yeBSovIjWdNxZwThm9jU4zrbW7NmoCdCu
         HExF0uTbml1WnL/wKZHWLE7ZG27WA9dD5XukmaawrCJbUPIHvJpjq01fYjK0ub5qHzkj
         8+f6/66zQwme9Cmnf5WGcjsKVCLhYOP13dBWbUCxakrZnAC8mDbfm+7CSoyzPjLC+L83
         UUV6Z3bzwHrE5WXEnBYg1fBoWvE8CYqgYrs4m6H2mrZFEPa4VeMfLIPE5ZpFkMstcQoO
         1xoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuhHwR7xAK3LFuJ1ofRScQKXw5Xt+H18fRp76g9pTgxWnhrZ2/g5Ns+RvlJtL/0Tnv5JgIWpIhUSDkj5DF9vVML+KK
X-Gm-Message-State: AOJu0Yx1RnRKbzniU6/Ldqou1CyJIymNwZ8fPwUCMtT0ifZsHV8QNVyP
	wsZuMEAHuYHY8k9BZ1P0cBAco6p6rs344YzAQHOuw5jtlH+jKm+a
X-Google-Smtp-Source: AGHT+IGORlpQjyvuGeaP5l6JCqSzY2PVpiF/doB8PwwK/02cJedrTEsXfNArjNmaWhB8hgYZ6sjDZw==
X-Received: by 2002:a17:906:46d2:b0:a3c:bf99:123c with SMTP id k18-20020a17090646d200b00a3cbf99123cmr3772285ejs.23.1707834105651;
        Tue, 13 Feb 2024 06:21:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoYZ2TDYybvbzIbULOaE2PxeBlIOy1M0tOFHX7KEzf1dqjxTp3CkPa6ewFzFS4oljefIfpkgs+JfR9ZbTpkuMZHoGm/UwLBf1pGDUyF9AN76VLozmwOy5W7QCkXlOk1cj0+Ltv0G5a9SplDG8d3nCOxYv8QzHJZHGedmZMMVE5VK0A/yMUnxcpiuAPhWqpmVl+7GM4AkOG7VUWu2quIktQgof948JS
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id vg14-20020a170907d30e00b00a3ceecd6cfbsm948090ejc.56.2024.02.13.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:21:45 -0800 (PST)
Message-ID: <925915504557d991bf9b576a362e0ef4a8953795.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: check bpf_func_state->callback_depth
 when pruning states
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, kuniyu@amazon.com
Date: Tue, 13 Feb 2024 16:21:44 +0200
In-Reply-To: <fdf38873-a1e2-4a16-974b-ea2f265e08e1@linux.dev>
References: <20240212143832.28838-1-eddyz87@gmail.com>
	 <20240212143832.28838-3-eddyz87@gmail.com>
	 <fdf38873-a1e2-4a16-974b-ea2f265e08e1@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 17:20 -0800, Yonghong Song wrote:
[...]

Hi Yonghong,

Thank you for the feedback, I put updated description at the end of
the email, below are the answers to your questions.

> > - (0) {7P,7,7}
>=20
> Why we have '7P' here?

Precision is propagated because of the check in the "-> to end" branch,
made it more clear in the updated description.

> >    - (3) {7P,7,7}
>=20
> So here when (3) is hit, we have callback_depth=C2=A0 =3D 1, right?

Yes, made callback depth explicit.

> >      - (0) {7P,7,42} (checkpoint #1):
>=20
> So for below (3)/(2)/(1) we have callback_depth =3D 2, right?

Yes.
=20
> >        - (3) {7P,7,42}
> >          - (0) {7P,7,42}   -> to end
> >        - (2) {7P,7,42}
> >          - (0) {7P,42,42}  -> to end
> >        - (1) {7P,7,42} (checkpoint #2)
> >          - (0) {42P,7P,42} -> to end
> >    - (2) {7P,7,7}
>=20
> So now we back to callback_depth =3D 1.

Yes.

[...]

> > While the last branch of the tree has callback_depth of 0, and thus
> > could yet explore the state {42,42,7} if not pruned prematurely.
>=20
> which 'last branch'?

Gave it a name.

> It would be good if the commit message mentions what will change
> for the above digram if this commit is applied, so people can understand
> why this commit helps.

Added.

--- 8< ---------------------------------

    struct ctx {
    	__u64 a;
    	__u64 b;
    	__u64 c;
    };

    static void loop_cb(int i, struct ctx *ctx)
    {
    	/* assume that generated code is "fallthrough-first":
    	 * if ... =3D=3D 1 goto
    	 * if ... =3D=3D 2 goto
    	 * <default>
    	 */
    	switch (bpf_get_prandom_u32()) {
    	case 1:  /* 1 */ ctx->a =3D 42; return 0; break;
    	case 2:  /* 2 */ ctx->b =3D 42; return 0; break;
    	default: /* 3 */ ctx->c =3D 42; return 0; break;
    	}
    }

    SEC("tc")
    __failure
    __flag(BPF_F_TEST_STATE_FREQ)
    int test(struct __sk_buff *skb)
    {
    	struct ctx ctx =3D { 7, 7, 7 };

    	/* 0 */ bpf_loop(2, loop_cb, &ctx, 0);
    	if (/* 4 */ ctx.a =3D=3D 42 && ctx.b =3D=3D 42 && ctx.c =3D=3D 7)
    		/* 5 */ asm volatile("r0 /=3D 0;":::"r0");
    	/* 6 */ return 0;
    }

Prior to this commit verifier built the following checkpoint tree for
this example:

 .------------------------------------- checkpoint / state name
 |    .-------------------------------- code point number
 |    |   .---------------------------- stack state {ctx.a,ctx.b,ctx.c}
 |    |   |        .------------------- callback depth in frame #0
 v    v   v        v
   - (0) {7P,7P,7},depth=3D0
     - (3) {7P,7,7},depth=3D1
(a)    - (0) {7P,7,42},depth=3D1
         - (3) {7P,7,42},depth=3D2
           - (0) {7P,7,42},depth=3D2      loop terminates because of depth =
limit
             - (4) {7P,7,42},depth=3D0    predicted false, ctx.a marked pre=
cise
             - (6) exit
         - (2) {7P,7,42},depth=3D2
           - (0) {7P,42,42},depth=3D2     loop terminates because of depth =
limit
             - (4) {7P,42,42},depth=3D0   predicted false, ctx.a marked pre=
cise
             - (6) exit
(b)      - (1) {7P,7P,42},depth=3D2
           - (0) {42P,7P,42},depth=3D2    loop terminates because of depth =
limit
             - (4) {42P,7P,42},depth=3D0  predicted false, ctx.{a,b} marked=
 precise
             - (6) exit
     - (2) {7P,7,7},depth=3D1
       - (0) {7P,42,7},depth=3D1          considered safe, pruned using che=
ckpoint (a)
(c)  - (1) {7,7,7},depth=3D1              considered safe, pruned using che=
ckpoint (b)

Here checkpoint (b) has callback_depth of 2, meaning that it would
never reach state {42,42,7}.
While checkpoint (c) has callback_depth of 1, and thus
could yet explore the state {42,42,7} if not pruned prematurely.
This commit makes forbids such premature pruning,
allowing verifier to explore states sub-tree starting at (c):

(c)  - (1) {7,7,7P},depth=3D1
       - (0) {42P,7,7P},depth=3D1
         ...
         - (2) {42,7,7},depth=3D2
           - (0) {42,42,7},depth=3D2      loop terminates because of depth =
limit
             - (4) {42,42,7},depth=3D0    predicted true, ctx.{a,b,c} marke=
d precise
               - (5) division by zero

--------------------------------- >8 ---

Wdyt?

