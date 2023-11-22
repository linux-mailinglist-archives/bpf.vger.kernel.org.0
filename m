Return-Path: <bpf+bounces-15667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658F77F4A01
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F741C20C6D
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B634E62A;
	Wed, 22 Nov 2023 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGtCAZx8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1D11B1
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:13:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507962561adso10115819e87.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700666025; x=1701270825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X47BxnlH9U1cUTyyF5O7zOyI4Tp9HYPQGsN3JvtF6uw=;
        b=UGtCAZx8UqnPI/H7NhpXAeF93Etvga/PwwLnlW6FNEpZ2c+ernwrBMpLW1R2KOKyad
         UaEiQWKa8Puvo1UHawl+J0ueETdbLsvV5GWIev1yg0Oys/uDx+IaWk8N3bJG8P86Y+HN
         NuQfZByYNY4rSs9yHMoUq1BPbxNLixqZozMpf8TJQPjD6HSS0OH/LkzBKd1GjOwJOIIv
         t3hXWsUUyQy16b3y0ub4Ni3JSL5DOaVMUAqpOfmHC+lJ4kkwT+Whq2Jnw13NtfaMxidH
         Yd/3eQRKXpmsqNwrSfCZhGxESpz/zv2P7uuvGrl/2EhAlk1ZFT1dFZwG7NrRPujFQIh0
         0dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666025; x=1701270825;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X47BxnlH9U1cUTyyF5O7zOyI4Tp9HYPQGsN3JvtF6uw=;
        b=I6/EmieG2v32TGB/qVQW9A6sM+FLebJe5vSK8hu0+vXTfk/4m0jB1prQTXg90+TLWt
         TQ1ozZ1cPGWTmB/RmHVuHqoceAe7dZ2cEWd5wdBPOESrfrMhE04gZm2Jd+PTgFJbKe0l
         KP+a6/l/fzIiXuurpd2z0tZgX0G+iJN5ePvUhVw4YYFb5QH0tSqbicsJlv7hmAXhc44M
         HdEabBhghurqqOpO+7Mz4tmEzwgXKt7NRvijLFT6h5AnGmZSqtyy/TLPo8OPwvMrLNvD
         j81bDvhX8oDN+nzu7BqwFIlrtYtFSZ8CgBY3v81rz5uBOHt4mZVrcORJBzM69YZBHG/w
         F3Ww==
X-Gm-Message-State: AOJu0YzqdqgN86LIcD/2wF1Pqci9eGvfhePr4+woEYDIJivbtJ/UnSeL
	FD0hPU6h+ktZTxOJfRtfWBI=
X-Google-Smtp-Source: AGHT+IGLaWRcXl0mEBcfmt3P1W4rqUYohgEpGktIwurotamaTwgPHNibLdjQB66h9bdCAT6vzKz/Pg==
X-Received: by 2002:a05:6512:224c:b0:50a:a9e1:6c77 with SMTP id i12-20020a056512224c00b0050aa9e16c77mr655593lfu.30.1700666025443;
        Wed, 22 Nov 2023 07:13:45 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e8-20020ac24e08000000b00507977e9a38sm1866469lfr.35.2023.11.22.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:13:45 -0800 (PST)
Message-ID: <3a4a364c521d89db09dc66d2531e848a7fe96b9c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 10/10] selftests/bpf: adjust global_func15 test
 to validate prog exit precision
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 22 Nov 2023 17:13:44 +0200
In-Reply-To: <20231122011656.1105943-11-andrii@kernel.org>
References: <20231122011656.1105943-1-andrii@kernel.org>
	 <20231122011656.1105943-11-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 17:16 -0800, Andrii Nakryiko wrote:
> > Add one more subtest to  global_func15 selftest to validate that
> > verifier properly marks r0 as precise and avoids erroneous state prunin=
g
> > of the branch that has return value outside of expected [0, 1] value.
> >=20
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


