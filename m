Return-Path: <bpf+bounces-19264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9A38289DF
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 17:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F154C1C24576
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889993A1CD;
	Tue,  9 Jan 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR7qmHAg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1683A1BB;
	Tue,  9 Jan 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d4a2526a7eso15507285ad.3;
        Tue, 09 Jan 2024 08:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704817271; x=1705422071; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rLGCUYOtvZFqPUeEdn5IWQkZdmyJ+I3280MJ8sH9Pf4=;
        b=PR7qmHAgts5FGTeKP5DQemuwFmdCqzDYV+3AQ58TXwSIp+neAIb20Jn2EUcoFu/FFh
         i8N/CeXUmO0JbpyH4gZEVfh+3ZVeN7EXcHB2LVLDV7T1NVC4QC4udMvU13yH3tsforM9
         lwHFOwuVX10F1bGJNfILAKQfjvnlmju5gMKdxgVNSQXPhR8VhUcorAHFjz+f9SvkRLVO
         ckzmBZLEGz7Gwq4cHONWoytK3o7p18tKZCvtNujE5TBdAKEAkk5fkJ6hUiuK5LQdIqWz
         vNiTxvhym7VMBo0Brt9ei6zuxaSd/NoDKDBg8fE0+tKzDIr4hBo//y9VVnFA6yWqVICY
         c5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704817271; x=1705422071;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLGCUYOtvZFqPUeEdn5IWQkZdmyJ+I3280MJ8sH9Pf4=;
        b=MplkMxvH6TPZZcsPmpqzPS2fkKfqAYqHbXgdL47o9SxqK7+yEYr3770IBNnVDi6M1v
         8WvzVw4nqsC9MQlAYi8yOpWe42NbpEcwMNdC/IkVJlly07SJd0eTyC0zswWlRBSKW+KL
         38ZswLJjY/hM4vg8mKRBu93yMp62b4JzA+0Qr83o7g64XEzU7dPDLXOb3B0z2bGKJ3nP
         pIY6zjvh3Td3sHjB/knxmhIrHrOCTcO6Iswn8xEWmMbsroeLrT5Q3o/offEID7bETv4y
         HImSqZcmHTYl1O30vCpg9frREp30LxXw6kuXoeaop7I5iMnEYl0V6oywRLJQxagmHTns
         ETpw==
X-Gm-Message-State: AOJu0YwplWFG2lZvm98iyHYx/ct+9HobszySyht0/uRqXEvKl5aNktUY
	BiWII9+L84BRYKFhSrEfh3ye2KIijLc=
X-Google-Smtp-Source: AGHT+IFaIM4V41PiGQ5xkpArRCIWYAoCym44oilji47jQQmepKHHdzOnbUh24TshOMZQffC2NjCKjw==
X-Received: by 2002:a17:902:d506:b0:1d4:44cf:abf4 with SMTP id b6-20020a170902d50600b001d444cfabf4mr3676812plg.122.1704817270964;
        Tue, 09 Jan 2024 08:21:10 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902d4c700b001d362b6b0eesm1993108plg.168.2024.01.09.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 08:21:10 -0800 (PST)
Message-ID: <f84ffb6623d2901624337e88daf73ac639b37a2c.camel@gmail.com>
Subject: Re: [PATCH] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc: ppenkov@google.com, willemb@google.com, ast@kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 09 Jan 2024 18:21:01 +0200
In-Reply-To: <20240109153609.10185-1-sunhao.th@gmail.com>
References: <20240109153609.10185-1-sunhao.th@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 16:36 +0100, Hao Sun wrote:
> For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off
> for validation. However, variable offset ptr alu is not prohibited
> for this ptr kind. So the variable offset is not checked.
>=20
[...]
>=20
> Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook"=
)
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---
>  kernel/bpf/verifier.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index adbf330d364b..65f598694d55 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12826,6 +12826,10 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  	}
> =20
>  	switch (base_type(ptr_reg->type)) {
> +	case PTR_TO_FLOW_KEYS:
> +		if (known)
> +			break;
> +		fallthrough;
>  	case CONST_PTR_TO_MAP:
>  		/* smin_val represents the known value */
>  		if (known && smin_val =3D=3D 0 && opcode =3D=3D BPF_ADD)

This change makes sense, could you please add a testcase?

Also, this switch is written to explicitly disallow and implicitly allow
pointer arithmetics, which might be a bit unsafe when new ptr types are add=
ed.
Would it make more sense to instead rewrite it to explicitly allow?
E.g. here is what it currently allows / disallows:

| Pointer type        | Arithmetics allowed |
|---------------------+---------------------|
| PTR_TO_CTX          | yes                 |
| CONST_PTR_TO_MAP    | conditionally       |
| PTR_TO_MAP_VALUE    | yes                 |
| PTR_TO_MAP_KEY      | yes                 |
| PTR_TO_STACK        | yes                 |
| PTR_TO_PACKET_META  | yes                 |
| PTR_TO_PACKET       | yes                 |
| PTR_TO_PACKET_END   | no                  |
| PTR_TO_FLOW_KEYS    | yes                 |
| PTR_TO_SOCKET       | no                  |
| PTR_TO_SOCK_COMMON  | no                  |
| PTR_TO_TCP_SOCK     | no                  |
| PTR_TO_TP_BUFFER    | yes                 |
| PTR_TO_XDP_SOCK     | no                  |
| PTR_TO_BTF_ID       | yes                 |
| PTR_TO_MEM          | yes                 |
| PTR_TO_BUF          | yes                 |
| PTR_TO_FUNC         | yes                 |
| CONST_PTR_TO_DYNPTR | yes                 |

Of these PTR_TO_FUNC and CONST_PTR_TO_DYNPTR (?) should not be allowed
as well, probably (not sure if that could be exploited).

