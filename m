Return-Path: <bpf+bounces-17238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEA080ADEF
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 21:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F921F21237
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1914EB27;
	Fri,  8 Dec 2023 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGPxUwt6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ECB10F8
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 12:35:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-334b2ffaa3eso2379475f8f.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 12:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702067715; x=1702672515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OYYae8DXniaRIprPWza7LS/hFmwBtNWP/caM8io3n30=;
        b=hGPxUwt65eYG5bJzAbN27F7ZNF2zHvEYSqiFWwkQnNQOREXJnVU9fAh4wNC87hJ1QL
         3pnUrGBqGdMsegMQ92CAPjSq5A7EZ3ZidlNygd2evxNmMhebtLKKpu6ZpGoJK7sRcAAH
         qRBrYTQsrRWF/2jiXLkdvI1pTT3jljUfza/X2BP2KzMTwRZOASa1JCHPH9wVhlcmvw+D
         +OxvkhuuNRCRc2J7nn3j5EELKFdggt/dal32tcTXNwbr1jOrDJvYJELDt4jPADq1Wu2C
         xwhCnc4JDSNley9M7ZeYFqtm/KXZ/5w7J/MZ9tIKfnrCAk8IzntZWGUL7ea7jz0DXuvS
         gg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067715; x=1702672515;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYYae8DXniaRIprPWza7LS/hFmwBtNWP/caM8io3n30=;
        b=mPeSbUCU5+ovO6Aqrf0WQwDJtAXUkLbvG7JeZ+Qk7uWzVWixQNQCbF7lcTnYLC5eUR
         hDM19acdSynwhO43U7sUaJN7cJoWnkyI52LPQ3HXQHC+sQq9W3x0Gp22lm/Duw5OvtAN
         +BpjauY5ZEmQk1FlEGZkSH3iRDwZJSdGmvYa3LTILlqIbTCYLuS4bD9JME8odkTHHBns
         04sJ+1haCkOW6BtUYYIhAmhHJHVFhUMI0vNaksaP/me6RDankcWJRHgfrz+h0xUOlYnq
         jqn8TfnUYcN5mQqsnK+vM59u2IUhqKscRmCzOZmZQfth8qF0MUJCAGyAJ6hqLMkkiWqG
         Powg==
X-Gm-Message-State: AOJu0YxLnW48h7ElAB1nEvX6kEU3jd1BanBnWJnWnf2b5W2yCE3ovk08
	kO2MFv/gZ4b1kyGENwnXwXo=
X-Google-Smtp-Source: AGHT+IGbYfJzpQ9pLgegBPpP8AC5N6BhaQiXRLpypMhVDQpgi/qVoUOU9os/s8OMMCnTd5kok/TvRg==
X-Received: by 2002:adf:e302:0:b0:32f:6fc3:7963 with SMTP id b2-20020adfe302000000b0032f6fc37963mr264288wrj.15.1702067714503;
        Fri, 08 Dec 2023 12:35:14 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a11-20020adfeecb000000b00333b17432c0sm2743450wrp.28.2023.12.08.12.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:35:13 -0800 (PST)
Message-ID: <7cd973c016a422f9a27f58f85799dcdf4bcfe71c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi
 headers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>
Date: Fri, 08 Dec 2023 22:35:12 +0200
In-Reply-To: <CAADnVQK-RP-rOq2cGOSRt614td536Kp+9c=moNH_pen0EY2FUA@mail.gmail.com>
References: <20231208000531.19179-1-eddyz87@gmail.com>
	 <012efc61-e067-4c21-8cab-47dec9bbaf0c@linux.dev>
	 <0275c6985bcb299890da7ea7fb96642802cdcdbe.camel@gmail.com>
	 <85a5312a-ba79-4e1d-b1be-434a7fe64cf0@linux.dev>
	 <CAADnVQK-RP-rOq2cGOSRt614td536Kp+9c=moNH_pen0EY2FUA@mail.gmail.com>
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

On Fri, 2023-12-08 at 09:46 -0800, Alexei Starovoitov wrote:
[...]
> > I just want to propose to have less work :-) since we are only dealing
> > with a few structs in bpf domain. Note that eventually generated
> > vmlinux.h will be the same whether we use 'hard code' approach or the
> > decl_tag approach. The difference is just how to do it: - dwarf/btf wit=
h
> > decl tag -> bpftool vmlinux.h gen, or - dwarf/btf without decl tag +
> > hardcoded bpf ctx info -> bpftool vmlinux.h gen If we intends to cover
> > all uapi data structures (to prevent unnecessary CORE relocation, esp.
> > for troublesome bitfield operations), hardcoded approach won't work and
> > we may have to go to decl tag approach.
>=20
> +1 for simplicity of "hard code" approach.
> We've stopped adding new uapi "mirror" structs like __sk_buff long ago.
> The number of structs that need ctx rewrite will not increase.

Ok, I'll submit V2 with changes in libbpf/bpftool to emit
preserve_static_offset for predefined set of types.

