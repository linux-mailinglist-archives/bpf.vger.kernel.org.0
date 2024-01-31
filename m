Return-Path: <bpf+bounces-20833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F56B844381
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1E8289773
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068E12A14E;
	Wed, 31 Jan 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7L0qB7K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18371433CB
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716685; cv=none; b=AsH48KtjAwqzdt4vI9o33F/1LTjO3IFQycXUh9uNLkMh8ursIduIl5l9p6toe+wViBThSZ/av9ddTGmcXGj4P8Qg2fHlWqa8dWa5KvUrsoxjZqdILlpqw9OaR4P35SuCANVD5HyI6YiRGcKy+kzLi0wMILaZUfAQWUdvYElylpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716685; c=relaxed/simple;
	bh=dZUYv9CwUF2Y23Dl+w825N/W0jKDHXxX57k+9u1udog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fv1jesFQTZpfLZjgEQ9Q0nXeGqbuXrkESfsYWw60PjtqzhUbwOH8wa9SSeyWINL6w9ylh0po2sN8mBVAzdPn84PUwZB/PQdAB6MALaAmjyGPpV/6S7Vwf5BDGAqj8stBgUDPugKHU+dYridrPhpBUffCWH+Adc45xs+4H1Rg3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7L0qB7K; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3394bec856fso706057f8f.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716682; x=1707321482; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WDUMygppoTCFPTf/XtzN/8RqUKr3a8LuhIpz1ll5JH8=;
        b=L7L0qB7K2ngb1t3LTHu6Huh16sORwFCBy2Xt/PNlVGPjk1NrDpCUsE10apiRkMBPl4
         +7+A1lnqjQQYBL7UIosc7G+DxYexvc8eId1A3gRWVVIUl/Ek3KD//j50zlw3l6iQJo4T
         ptTk2w/jeoBybrfJCwCFTI05XNViatq3NWe0pvLEn9qxtanggus0QTU9xnpYGVeMOX6W
         tJPpjuoVgFF/mYdr+yu2KtZcse9PtJ4nDZcTAMwgQE9OmVlRwzZhtE+RbUiKtbnm+F3j
         Ntea+wZlOTB3qdvIuNR0ookLEwdfJxHy+jeGWS3CJHKwLJSSZd/fkHaKaVVDboh/vIof
         faXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716682; x=1707321482;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDUMygppoTCFPTf/XtzN/8RqUKr3a8LuhIpz1ll5JH8=;
        b=r2RYC5UyQwbXLMW0TKvVJjoIdbfc15VO8iorFunG1Y8ffXmQI+YLkbyZ2cv890OeQ9
         uXVUhhVYDARQ2mvaTw5zqM9+GI0T/uVuC+QuqhLD58uRvvW+yo7DDgM9plGuTfEi5xuC
         8swjrD0piE9oQfgS4q+v0xSz6isgWmIJQYpFN2s9DmhyyDRpbuaRox5GOqJC0xwA1Zex
         Vidrd5nKDngmp7ytLIxq/anZJeXXCXs/mxvipXGiT1wOPsjPy6QBPWJ17OmkHbWxm4YL
         FTnxTk+5CFT80lf0gsxldpPR7GK3YLb5LAnpxT/Gz6rOzjLPIwHtCT9wJacDPxL5NMJZ
         2VFg==
X-Gm-Message-State: AOJu0Yy5rfofPgairSmI2IZfPB8y7+fBsTv0fG2OP4/T5e16/LjmJVUV
	My4nAkNS+pT9DfgFbNBP6jHcdZDlETyoh2D8LQiaAg/qhw2aimr4
X-Google-Smtp-Source: AGHT+IGZ+j8oqrZWjuIHNoyGh/T4EEwFAPLH+p0kiUzVdpu5GMcoTpwT08BKDCBCbT2ATIVmU55UAw==
X-Received: by 2002:a5d:5984:0:b0:33b:f20:c976 with SMTP id n4-20020a5d5984000000b0033b0f20c976mr383321wri.17.1706716682025;
        Wed, 31 Jan 2024 07:58:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXvWDGke1aDYR+gWjtbCZZUEqq8ZzlIyaCu7/aPO4t1j0fOe9ukdfHWfaIDgwWj3OTilNGeWcGlbJebzZJtz68VddSqbsrN9h6Nfr+S6hPgICxC3SJlhXy4sDkuKXpdocZRXqu3Lp2m5y/2xitHNl4+o+ywim3XvmoDwrwo+R+4D5ILwlqEuWI=
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bs13-20020a056000070d00b0033b05cf6dedsm1755499wrb.7.2024.01.31.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:58:01 -0800 (PST)
Message-ID: <f4fa95f7993dc4c8d2a161d7ac223dde0665b441.camel@gmail.com>
Subject: Re: [PATCH bpf-next V2] bpf: use -Wno-address-of-packed-member when
 building with GCC
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song
 <yhs@meta.com>,  David Faust <david.faust@oracle.com>, Cupertino Miranda
 <cupertino.miranda@oracle.com>
Date: Wed, 31 Jan 2024 17:57:55 +0200
In-Reply-To: <20240131094459.24818-1-jose.marchesi@oracle.com>
References: <20240131094459.24818-1-jose.marchesi@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 10:44 +0100, Jose E. Marchesi wrote:
> [Differences from V1:
> - Now pragmas are used in testfiles instead of flags
>   in Makefile.]
>=20
> GCC implements the -Wno-address-of-packed-member warning, which is
> enabled by -Wall, that warns about taking the address of a packed
> struct field when it can lead to an "unaligned" address.  Clang
> doesn't support this warning.
>=20
> This triggers the following errors (-Werror) when building three
> particular BPF selftests with GCC:
>=20
>   progs/test_cls_redirect.c
>   986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
>   progs/test_cls_redirect_dynptr.c
>   410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>   progs/test_cls_redirect.c
>   521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>   progs/test_tc_tunnel.c
>    232 |         set_ipv4_csum((void *)&h_outer.ip);
>=20
> These warnings do not signal any real problem in the tests as far as I
> can see.
>=20
> This patch adds pragmas to these test files that inhibit the
> -Waddress-of-packed-member if the compiler is not Clang.
>=20
> Tested in bpf-next master.
> No regressions.
>=20
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

