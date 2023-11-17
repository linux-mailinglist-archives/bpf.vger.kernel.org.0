Return-Path: <bpf+bounces-15261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D67EF797
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 19:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F9228122B
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53054316C;
	Fri, 17 Nov 2023 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J726+DNS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1542290
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so6719837a12.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700247207; x=1700852007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SFtj9uupRPxh6zAL0I+56gai3PraC05KcaYARhA48hE=;
        b=J726+DNSavglpN1aIGqNN0IZuzkxSD6Y2IpOKUatK4HEPOGtVTKP9YLe0t6GFLGcmn
         8ciw51sTbmgJ8dVMLSX4rSnspjVCo1l6yh4UdDKkZV0dVtDOyLB27h+j6n7hkQvradvk
         C8uWNNGrKdwRY2JiBu121H3IQFZaJlLeV2X8d6oSy0kzbZLnBVPUHe9mwwXQcm/58MzT
         DWk+XUEMIf7B7of3VwWK2jnHMrmkRifHG4svbNF+3Q3NFmM9i1rM/5GKV2mAC/tsHhg1
         6SSZkioNTYz6BwmGI+P5iHZ83L90s+DiVerWOVWLTqfPRSK57atkR9S10kK/f93bx+AM
         noZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247207; x=1700852007;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFtj9uupRPxh6zAL0I+56gai3PraC05KcaYARhA48hE=;
        b=FSsFubbORoxl6YtIDhawLcFc3W061QH7+6XCX3lxDMoLt0eSc+NXD3/7qrJR255+AZ
         fIX6CXxHUCHffkmTNFMFDi5NkjDO28kwPTrL+28GE38CC6XVPwBA05kzoevAzSUq6vk8
         SWqgicwKXme0feNjFUElJqdDOuSuygMBrgziP/tyJTt0U6fVMU2PYvoKTvR2F2VWF3ql
         UU5UR1NJVSBOxeEDruNTEeCx+vCn3WELOq6mWpLdyBHj1rYb2AtOqaJ2YSlWHS9YARml
         mZqHcSofeo0x9yyjo0SHC3sB+egyy2xMlL4x6rn0GM3o5xW9EhHc6vfGpCT6yPIePsIC
         ahIQ==
X-Gm-Message-State: AOJu0Yy9Mtr7ZBvJH+kdZWiENamQVDxBKGrRRgQ6wKfCO7QbiWCgNEih
	nr6Kr0FN0uyNyJFrksOidbkMc3ELRJ4=
X-Google-Smtp-Source: AGHT+IEPfJa+XHNaDf9HxJLqjBrmcIGiXOBWrr3pU+iVs0pZMf9mv7OzJuZKxe+F0Mg+PT3UjeMW3A==
X-Received: by 2002:a17:907:c903:b0:9a9:fa4a:5a4e with SMTP id ui3-20020a170907c90300b009a9fa4a5a4emr5069725ejc.13.1700247207579;
        Fri, 17 Nov 2023 10:53:27 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906398600b009f92d851cc7sm491318eje.113.2023.11.17.10.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 10:53:27 -0800 (PST)
Message-ID: <d6e728aa421b08544b982a0ce60148ef45af7b53.camel@gmail.com>
Subject: Re: [PATCH bpf 11/12] selftests/bpf: add __not_msg annotation for
 test_loader based tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Fri, 17 Nov 2023 20:53:26 +0200
In-Reply-To: <CAEf4BzZhEU-h0yfY2WCBfPDjmwOzxxw1a70J4c78Bix34W70QQ@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-12-eddyz87@gmail.com>
	 <CAEf4BzZhEU-h0yfY2WCBfPDjmwOzxxw1a70J4c78Bix34W70QQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-17 at 11:45 -0500, Andrii Nakryiko wrote:
[...]
> I think this implementation has an undesired surprising behavior.
> Imagine you have a log like this:
>=20
> A
> C
> D
> B
>=20
>=20
> And you specify
>=20
> __msg("A")
> __nomsg("B")
> __msg("C")
> __msg("D")
> __msg("B")
>=20
> Log matches the spec, right? But your implementation will eagerly reject =
it.
>=20
> I think you can implement more coherent behavior if you only strstr()
> __msg() specs, skipping __nomsg() first. But on each __msg one, if
> successful, you go back and validate that there are no matches for all
> __nomsg() specs that you skipped, taking into account matched
> positions for current __msg() and last __msg() (or the start of the
> log, of course).
>=20
> Not sure if I explained clearly, but the idea is to postpone __nomsg()
> until we anchor ourselves between two __msg()s. And beginning/end of
> verifier log are two other anchoring positions.

Yes, makes total sense, thank you for spotting it. I can fix this and
submit this patch as an unrelated change or just drop it, what would
you prefer?



