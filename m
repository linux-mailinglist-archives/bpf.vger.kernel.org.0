Return-Path: <bpf+bounces-18996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D18823AA2
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5224B2109E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF71D1FA1;
	Thu,  4 Jan 2024 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl8NF7MC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3721FB4
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-556eadd5904so73453a12.2
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 18:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704335198; x=1704939998; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Srw/7jJy+bj1rkK0E/VjmYMpEvEhxGhV1SpAoGe7Ppk=;
        b=jl8NF7MCgPkdpila43zpVrWqEwGC7N5J8TydPtcTkUA9xzkpwwaNhPX7CusY1Ar9dy
         FmImthu/a364Wzuf9sb1t0GabKKUQNinSDBUxUDBQwqhMovGaVkqPocUIcH9CwXpHxDU
         woUsb2ikYiAFLrx54tAo2UuH6V7HGjPtYf/nzeu6b0ezp7FyO/Yxc2PgGAYkUKc8Qv1G
         +8KsSxpwblLuGMR3BT9UiCuSO5RxhbGK8UNKxrL8iT6ygi16QNCs3PlhvJq0tXuV4beI
         j13Fxt+2pIZqLa/1O8nFk/EUzhUnJxVoGEblGmP0u7CnyNhzv126d8iMaeUl0QexiK24
         6atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335198; x=1704939998;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Srw/7jJy+bj1rkK0E/VjmYMpEvEhxGhV1SpAoGe7Ppk=;
        b=RKqOKmObvsezAvPxbfhkdnXDhNiVGO4Zjo8IBeh2Wx477n9dfyHM0g551dhfNSI9mO
         CzbgpZEqWBvfHY6gD36up2Pql65K/uKsUX9aM16tADaUftZXmPjVVHF8kfibJE3L613N
         79j+urzhiUQzaY5+E4eyXJKuOXNiZnSEgg8PeQHi1FvIXaad3Qg5Qq1LsZZQgAPHN2aE
         KGoVjLam6Y4ycvkcDkkOFmn5fbkts4/ciMxgglOas4ZUs6EI0CcMTJie+sjBr3/lzpyd
         Qo1v1oywoFUzOIIhCw7kiqQx+++zajPnWB9AlmfTrnkC0AZkB1+Tau6Ey8SjpE2LFI+d
         UjGA==
X-Gm-Message-State: AOJu0YxZFm8fwsrdhI29pDJX3ZQ0LV4SrV67m1PUSBR/kGClM8e7I3Jn
	3brQp0i8WcbZuOTxqiz5uGs=
X-Google-Smtp-Source: AGHT+IG5lzTeZvaZkY3SHMn05xQpluy2CY7jCJnWFZMmeNm0p9v0K1JN2v+CdSc774g2LlM1UuMMQw==
X-Received: by 2002:a05:6402:3583:b0:554:c8ec:6a9f with SMTP id y3-20020a056402358300b00554c8ec6a9fmr6474937edc.120.1704335198123;
        Wed, 03 Jan 2024 18:26:38 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7dbcd000000b00554d57621eesm13358887edt.90.2024.01.03.18.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 18:26:37 -0800 (PST)
Message-ID: <6e363e41b6780a7515840df26eeca95f0f3ea388.camel@gmail.com>
Subject: Re: [PATCH bpf-next 10/15] bpf: Track spilled unbounded scalars
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 04 Jan 2024 04:26:37 +0200
In-Reply-To: <20231220214013.3327288-11-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
	 <20231220214013.3327288-11-maxtram95@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 23:40 +0200, Maxim Mikityanskiy wrote:
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> >=20
> > Support the pattern where an unbounded scalar is spilled to the stack,
> > then boundary checks are performed on the src register, after which the
> > stack frame slot is refilled into a register.
> >=20
> > Before this commit, the verifier didn't treat the src register and the
> > stack slot as related if the src register was an unbounded scalar. The
> > register state wasn't copied, the id wasn't preserved, and the stack
> > slot was marked as STACK_MISC. Subsequent boundary checks on the src
> > register wouldn't result in updating the boundaries of the spilled
> > variable on the stack.
> >=20
> > After this commit, the verifier will preserve the bond between src and
> > dst even if src is unbounded, which permits to do boundary checks on sr=
c
> > and refill dst later, still remembering its boundaries. Such a pattern
> > is sometimes generated by clang when compiling complex long functions.
> >=20
> > One test is adjusted to reflect the fact that an untracked register is
> > marked as precise at an earlier stage, and one more test is adjusted to
> > reflect that now unbounded scalars are tracked.
> >=20
> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


