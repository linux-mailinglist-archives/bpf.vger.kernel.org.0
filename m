Return-Path: <bpf+bounces-12695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B127A7CFA05
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30011C20EA4
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629AD225B6;
	Thu, 19 Oct 2023 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3Vouayy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F31208DF
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 12:56:52 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE784198A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 05:56:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad8a822508so1296991566b.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697720167; x=1698324967; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kAJ5xQ9RbelcbecpJL8m+2QACL44txfbzQbKe16GFU=;
        b=g3VouayyWzPWrp6xJiMb8PFTkvvGcltD/y5UiOkErMrkPHwmX3dXtZl6nHoxmncOm+
         TiTbiEAAnV0wmv3VpJuG3Sj+pwxywwkNAYkmaWyQfyb7e1KRhh3RyIRx6hkt/Ri1zKc6
         DPrFTlAOptSNgk+NcKq8OER1bM5eitHVgSgvy/2aD38eBT7Q0vEI+E0utZ89P6vDm5eT
         ZOzH1xAEJh3wn3qhmM/s9gUZDXxh2aGlzR5RTdkPOVPKTUwKhhNixoyzDVJ3keLBo77A
         7m3AGY/Ms+nEhS7sLxMrYY7Dopae43Uqt1ee0Dk/2XtvXQNEsJUwrlfYbGPjMyupooaw
         NwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697720167; x=1698324967;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kAJ5xQ9RbelcbecpJL8m+2QACL44txfbzQbKe16GFU=;
        b=wm+T6AsBpkxrbEulLtcueD/CwVZt1VDvgVa9nWa3DqG7ITkhPQ/k311/mPX0uxyk4a
         3U8br8Y2E6ix12giUyQJKykObmhsusqZcC3unyVLvoadzMUEBisZlt9EYpbOcnKxy7t+
         KEhyff6QTLhu7V0RBmBr2G2KM8MYJmytqbSH/mtLE15f3f0DYH/tCVCX4t2IGxKQ+Zph
         DWhdts/L/tF2yfTb2ePGBlhgzelZ0IgDBGDLtWn9fyimxLfpg/7ThXMXQC9AfJN+4nk3
         iakbmqYb24OPE+7Fuj/gEPsYsMMPP6+XrLTClR3gsW1L+O+vMIah6czMAQhkpYMpQ7E6
         4LKw==
X-Gm-Message-State: AOJu0Yz13ms1xnfkC6371ekI+ha71x32B+cX/NGZBIcS0aaiN7jaMOUh
	rBImWZ99zUBh8ow05XiwLf0=
X-Google-Smtp-Source: AGHT+IGfPX2H0/6LmCYYjLKsvRyQfgDxFQtE5Yfd3j2q9Y2456VMLvG9OOFG6d1AiF1du3ca2u+2Ew==
X-Received: by 2002:a17:907:3603:b0:9b2:89eb:79b5 with SMTP id bk3-20020a170907360300b009b289eb79b5mr1417051ejc.35.1697720166353;
        Thu, 19 Oct 2023 05:56:06 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906688600b0099cb349d570sm3507384ejr.185.2023.10.19.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:56:05 -0700 (PDT)
Message-ID: <a8e684361c0a006971aa55afddda347e59a2ef79.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpftool: Fix some json formatting for
 struct_ops
From: Eduard Zingerman <eddyz87@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org, 
 quentin@isovalent.com, andrii@kernel.org, daniel@iogearbox.net,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Date: Thu, 19 Oct 2023 15:56:04 +0300
In-Reply-To: <20231018230133.1593152-1-chantr4@gmail.com>
References: <20231018230133.1593152-1-chantr4@gmail.com>
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

On Wed, 2023-10-18 at 16:01 -0700, Manu Bretelle wrote:
> When dumping struct_ops with bpftool, the json produced was invalid.
> 1) pointer values where not printed with surrounding quotes, causing an
> invalid json integer to be emitted
> 2) when bpftool struct_ops dump id <id>, the 2 dictionaries were not
> wrapped in a array, here also causing an invalid json payload to be
> emitted.=20

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Hi Manu,

I've tested this patch-set and everything seems to work as expected.

Thanks,
Eduard

> Manu Bretelle (2):
>   bpftool: fix printing of pointer value
>   bpftool: wrap struct_ops dump in an array
>=20
>  tools/bpf/bpftool/btf_dumper.c | 2 +-
>  tools/bpf/bpftool/struct_ops.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20


