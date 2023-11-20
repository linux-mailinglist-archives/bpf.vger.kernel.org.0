Return-Path: <bpf+bounces-15338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EE97F0A69
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 02:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C971C208E9
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 01:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63801865;
	Mon, 20 Nov 2023 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiiPZOsh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328DE133
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 17:46:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso5239257a12.2
        for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 17:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700444785; x=1701049585; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwd4QoDU7BNWxGZzmT482k1SC4+UQHCDeMXznfG+FNg=;
        b=LiiPZOshOASBb8CN9XO+nQoLUM+ryzr3Srw+tfJ/dcjWY5fkwJVJ4oaihrMOaExSdI
         WD3C4AL8dVgtYJtOT/AqE3YnjQHP2L6Pf7l6RMv2TXn1DbfcYC6n9Q1JbucAIa8dHnLO
         3E7llNJuLDWfok854x+RiHcDVX/+PDTh5e1T2Id655rQemq0nLQVz0y2F18G9BXAQvQ0
         CjhrD9PdosvJ3UpPiiAzw4JNRW8T0WNMbhZkRHLGjDV8xktmGVyaqexOiIE/4qS46oWi
         bo0YwBxTNooJBA0ECaxEtkX7sGzaN8z8e/9VLes57Lj1rsB/a3N2WAaV186c0qw/qmwY
         D7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700444785; x=1701049585;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwd4QoDU7BNWxGZzmT482k1SC4+UQHCDeMXznfG+FNg=;
        b=J1qRJrCUrNTVXg5k01n4Yh/IE4PUSwTI7w/wwvjUEKT5dOAIQtnKbFFlJPfdvPzubb
         OeOd4O5RJGqr7ik2gLtdbEvIu7/H91i2hFsA1cqHw2WcXD1t/t0OVvAuxOxLoGIOjgn7
         z2jARxN2mvB9ybq44egNSdKbN+QCNaf1fTnCfLUBnIxAb4VmLFoecKJLivj36M4qtZGt
         pCL4Hp8w6QOoW+dIpj7ttJ8jNei7ksU2NauXcTIG5zJexZWxEYMW/r3Qg5KG9cn80/I9
         1v3BZJoLlrfqsEDhslqrvAPVlWUMgLwNsxKm2kNDAOlX+lkMj9d4CsGTQKr9bVh9f48B
         klrQ==
X-Gm-Message-State: AOJu0YySfgU0hKq9Xj4m3tdbxTyxo5n+3yXgayZN7ROzyVXiow6F05DH
	vy3oMcS4DfQiiczTTF3ev5w=
X-Google-Smtp-Source: AGHT+IFnNRn0i7aW+w5E4qxx6Anzui7qjJVrzvro9vEPm5wFFuMIOvt3RW//WjGuWbSzQcqGMVMeRw==
X-Received: by 2002:a17:906:cb87:b0:9d3:8d1e:ce8 with SMTP id mf7-20020a170906cb8700b009d38d1e0ce8mr3647213ejb.20.1700444785445;
        Sun, 19 Nov 2023 17:46:25 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gt10-20020a170906f20a00b009fd585a2155sm983472ejb.0.2023.11.19.17.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 17:46:25 -0800 (PST)
Message-ID: <3e24666ad42121325b58e05fdec0711a1a451560.camel@gmail.com>
Subject: Re: [PATCH bpf v2 06/11] bpf: verify callbacks as if they are
 called unknown number of times
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Andrew Werner <awerner32@gmail.com>
Date: Mon, 20 Nov 2023 03:46:23 +0200
In-Reply-To: <CAADnVQ+Yq6hque4krdP0fkQ1bnFx=5bamiM0ym0aa=0sa=GkHQ@mail.gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
	 <20231118013355.7943-7-eddyz87@gmail.com>
	 <CAADnVQ+Yq6hque4krdP0fkQ1bnFx=5bamiM0ym0aa=0sa=GkHQ@mail.gmail.com>
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

On Sun, 2023-11-19 at 17:41 -0800, Alexei Starovoitov wrote:
[...]
> I think you're trying to make it similar to is_iter_next_kfunc(),
> but in this context the _iter_next is confusing. Especially _next suffix.
> Maybe
> s/bool callback_iter/bool calls_callback/ ?
> s/is_callback_iter_next/calls_callback/ ?
> s/mark_callback_iter_next/mark_calls_callback/ ?
>=20
> callback_iter_depth isn't quite accurate either.
> Maybe callback_nest_level ?

Makes sense, will update naming scheme.

