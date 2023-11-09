Return-Path: <bpf+bounces-14542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3897E61C8
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 02:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FAB2811DD
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D6ED3;
	Thu,  9 Nov 2023 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAkc5E25"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D4A57
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 01:20:08 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141522590
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 17:20:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-543923af573so440866a12.0
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 17:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699492806; x=1700097606; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jeKdDOECpyMe5zeBrboRWIuu1UdG3NrreeTNInzPris=;
        b=lAkc5E25/Tp0LFq9GyGCSIvfY5MvaM1xNRMGwKZHgL6nB8OqVq8ECCREoIR7+tAJay
         uSGNlCV5K7FxM1ONlIBe3UISJa9cnXfRQhFr95eB+ES3P2GXKAzZwGQ6HJ6J7JIytu3t
         61SqlNzLK7zpyBp7k3uK6d4yMj0Ypswm3pp1J2M+2qiXB0Ld2W9SWuTNxnlvUj0m5JOS
         SHMVQobsilRf0yRuK3/RwqA5qXQ6xHRlRaZ0MfAfdIP7gvVACtblLYPm6xjGrAushLvf
         hBFP9hNnyFzg56/9SueC9jQpLh2w6FvsMiqBsaOgR10QYO9/9ibyrnoBSdLrTjRlnUdy
         nrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699492806; x=1700097606;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeKdDOECpyMe5zeBrboRWIuu1UdG3NrreeTNInzPris=;
        b=c+Jrcn1+SPLk+jOssRuE7z1xCNIfPmXGV9OSIAgXBdZ8G0qjYdSbII6HFqnHZuaZMh
         CuC7nyyUYEiWHy2fr04kWcsvJIxV7uM4MekYraDLFMUguamQO4h8l69wqXHjbKiSmdZG
         cExIGSp88cqQMCRBynoLoEjHNrewNUhQ1DotSLPs6097u8mzVerRxu6+mDcnNBQUOKNM
         NhYp7ErRhF/J7NJoUYVdTtRRDcfhQnVsfJ1ABN5OhnpF5n/EBxTHTHfFtwJnV3pK11+x
         MCyBCNMVS+UKa+CFTHK7lbuOJoqXDyipLsQKV1VYyepFz8CrdWKXO5JciousSqdXIQfq
         VjRA==
X-Gm-Message-State: AOJu0YzoXMp7sZwx/FujiJuvLmRph+ypXWmVHaRgTRBJDvTQH/UA9hWU
	+CnpF1/7f06dHk0tQAOvSgo=
X-Google-Smtp-Source: AGHT+IHaDDawinsPhZgLhiSdNBYISBvUZm3sf1XsMBq7v0KDYTgRdfITpwe7TlReET8C6CcnO0T6PQ==
X-Received: by 2002:a17:907:7f94:b0:9df:867f:f74c with SMTP id qk20-20020a1709077f9400b009df867ff74cmr3312797ejc.65.1699492806325;
        Wed, 08 Nov 2023 17:20:06 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jz6-20020a170906bb0600b009df5d874ca7sm1818679ejb.23.2023.11.08.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 17:20:05 -0800 (PST)
Message-ID: <98d0330ecb6b3b1a366de5395dbef7ab7758288a.camel@gmail.com>
Subject: Re: bpf selftest pyperf180.c compilation failure with latest last
 llvm18 (in development)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, bpf
 <bpf@vger.kernel.org>
Date: Thu, 09 Nov 2023 03:20:04 +0200
In-Reply-To: <CAADnVQKvKbLi0rfhEr5jWwaR=wQJZFfassuWa2=w4H56CToeUg@mail.gmail.com>
References: <3e3a8a30-dde0-43a1-981e-2274962780ef@linux.dev>
	 <ba9076bfb983ef96ca78d584ca751b1fef3a06b9.camel@gmail.com>
	 <CAADnVQKvKbLi0rfhEr5jWwaR=wQJZFfassuWa2=w4H56CToeUg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-08 at 12:05 -0800, Alexei Starovoitov wrote:
[...]
> The algorithm doesn't look simple.
> Even if we change llvm to do this, it's not clear whether
> the verifier will be able to consume such code.

Actually, I don't think that trampoline jumps could cause any trouble.

> imo it's too much effort to address a non-issue.
> I'd just adjust the pyperf180.c test.

Ok, I'll drop this. Thank you for taking a look.

