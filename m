Return-Path: <bpf+bounces-14147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 957067E0B02
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1D4B210D0
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5F24216;
	Fri,  3 Nov 2023 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9chUkhu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066A249E0
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:17:04 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8CD53
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:17:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-540fb78363bso4290930a12.0
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699049821; x=1699654621; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1XWddTdr3xouEtdG2hnx8f6t6yPPulw/IIlx8oeHMeQ=;
        b=L9chUkhub+/dKTk9CjrD0rCqJY73eeJVQTo0NezgY56IA1WbFhm27Hg4TNSiwykwd0
         l0YtdLpMscBjD0qU2PIDo5PImYkMuxEGmT5k475C849fU0IDwwhSlyPn1bKd0PnfEtu4
         Mf/WOuJeVRfp7mES1zwpIlSYBrEeMzovfIamZGMe4x03C4l6kiNPaF4/OJLXNegA7gqz
         LsAiUSrZDvnds3ZLVgzGcwl6ZvxeKCeWvPVl6Nvl1WIXNpoNnlbQggvttB4xlg2SMywn
         IYxEzrKrekcQg4RUNVzX2rJ3dt6tfDZ4t8G8ZZ3hci01dl1roHtU+ZB5a89Ox4mstSHH
         wlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049821; x=1699654621;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XWddTdr3xouEtdG2hnx8f6t6yPPulw/IIlx8oeHMeQ=;
        b=LZFI9AwSBKf043TTsDkvC5FmnbrPnPE+MSrjPSSzcof4bJG/bp1Qql1s/raELxLmqC
         yU9+ZRPfNrfdYOlqpNka4VhmwVqgj6uiZs7EA/lxp7pMjhiyZ6ywPq1gQFDMCrz/Fh2F
         QYH8Z3QwpeOs5L73zHyZpXSSniSLJpWhUE4isjhGYJflAiRqrZXjz+myhGGOVjlxXmwc
         RCyzm9QjzZIiDvxVfOaI5KqK0MCjYBbyDrtn3po38q4HTqEgYWNTkTkeqVnZ3EAtCAed
         wg3bU244I7uCYolYY06SnSQ4Qgknau8W3w+8KaM5vDCwnWuDM25p5XxkNOz6+MWzEv9j
         7E/A==
X-Gm-Message-State: AOJu0YyTI06Jsfz3I+15ymElb93hIxVlong2VjkLcdxB/Z2RmedOTT55
	UDdmLhHzK99NMcRHRiODwVM=
X-Google-Smtp-Source: AGHT+IEDRgknNXFlgdeC5NgDTGg8r+Qot8kM89EYFvtZhJelkQnRJM9/DQ2aL5iVl5tkH5h2TsNXMQ==
X-Received: by 2002:a17:906:7955:b0:9dc:ee58:6604 with SMTP id l21-20020a170906795500b009dcee586604mr2835333ejo.21.1699049821423;
        Fri, 03 Nov 2023 15:17:01 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ss7-20020a170907c00700b009de3641d538sm47308ejc.134.2023.11.03.15.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 15:17:00 -0700 (PDT)
Message-ID: <c06fb5b86ee4ea724d674e23d99b084e9d9385a3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/13] bpf: remove redundant s{32,64} ->
 u{32,64} deduction logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Sat, 04 Nov 2023 00:16:59 +0200
In-Reply-To: <20231103000822.2509815-6-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
	 <20231103000822.2509815-6-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> Equivalent checks were recently added in more succinct and, arguably,
> safer form in:
>   - f188765f23a5 ("bpf: derive smin32/smax32 from umin32/umax32 bounds");
>   - 2e74aef782d3 ("bpf: derive smin/smax from umin/max bounds").
>=20
> The checks we are removing in this patch set do similar checks to detect
> if entire u32/u64 range has signed bit set or not set, but does it with
> two separate checks.
>=20
> Further, we forcefully overwrite either smin or smax (and 32-bit equvalen=
ts)
> without applying normal min/max intersection logic. It's not clear why
> that would be correct in all cases and seems to work by accident. This
> logic is also "gated" by previous signed -> unsigned derivation, which
> returns early.
>=20
> All this is quite confusing and seems error-prone, while we already have
> at least equivalent checks happening earlier. So remove this duplicate
> and error-prone logic to simplify things a bit.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

