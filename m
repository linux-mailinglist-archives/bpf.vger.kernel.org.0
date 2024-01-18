Return-Path: <bpf+bounces-19830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA5831FE0
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205661F21EBE
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155EC2E630;
	Thu, 18 Jan 2024 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWQeNGtP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEEE2E41F
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607415; cv=none; b=btcR7dKPjYogOLlDVtPQOKepgR17RQ48fQmDHvzrN30OlXpL/AJlFr+5RpyU/j1my6Lgtt6pkci0hjd8o/lWbxH2bfkZefg9BHR/9PpESl4ymcadKp6BrSu1ywfKChaPi0tUXSo7wHFqp/IfPLnnggNaWL4AWyl5b3Y8NjWYpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607415; c=relaxed/simple;
	bh=b23Hz4+WJmjKNiTQWPgx6fPNkOq84LzmkKTDyJI17nA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VRwT0IXkq7mEN9Ob4zrkEKXWwl8MFhAYz42pew1CNU+jUr0Oez2KydIuOsLBEHB/jBfqqk503X/xCjdXTyrBke5z+qsKNLC6+iPrz3xif+9XyAVSV0BKYQ8oEhOe6WXnH73Pnmaaniy18z+QoqJaGvfNXRCsV3vjiUnISBu5lvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWQeNGtP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e7065b692so53722775e9.3
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 11:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705607412; x=1706212212; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2a6qbL7QgntcA3P/VW3RDUN8qfEJOnxgMqbBwGbUjeE=;
        b=OWQeNGtPSDEbdXPs9Pb9KyJJ6WF8TnqU1uuT1rVaoHnNrbh6G6hgCko7jT5N8MU+nA
         B8CIt8g0UM51cPIjbi3/xyfC64Lh8zLz6NgS5kTah3CTNT8cD5dikdi7OentOu3DW9s6
         bsJtMgMfrcI4gwEFZazbl/qL7Nx9Xlp2jwJwRrmSpppE5kGo3Q0O9AWjU0fVOW1iYyih
         F8ZVc307Co83IBkVURs6D7wXEjoqeK7BO9OrDAG/l31dLbxYoU70BFOjS3s3mb7O3Wtp
         iQSnwtReA49Pv/0N+VMJ5AlqjSca2tNX5v645wVN8oxFO5BDxC83ZbAdLvG3OhYSy4bL
         XwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607412; x=1706212212;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2a6qbL7QgntcA3P/VW3RDUN8qfEJOnxgMqbBwGbUjeE=;
        b=XVzqdGIQ4Z2K89smkrCJsB1PYiAOsPlEWaEGvTUzzNhr1ZPpKgIwVvCfFgYz2FT98J
         NjvwNCQye965TSX9o91IiEa5u2OtaPzprNitwFjV9mKBfdfnuCDrT+xab8JKUkDpnzHi
         J+CZ1usL/UItFoO/0C8rde0o/WWYBVyCl/TMoYjfDcneI5whQDAIpj9c+5xoIwhSO7UI
         bn8vE7HgXXUXYwnmeh0IeL3SSO2s5zpStFFR5RRT1+TkgfGHuToaanbPxaF+zU3il+Nb
         tTXovc4BNmpb+wH5+jdRcWJcoan5riSZKQbflDc4HJ9NKFjm2EJz048jniK97IrjZGVS
         9ilg==
X-Gm-Message-State: AOJu0YyYYOXzbIVVcBYx1NMVX5dSOpfsuswWWmq1s8BWZbuDDWv7tlCt
	DUzH5jKSXXB9qRJlfVleeEa2+gX4vt1rxtdXR+gSljNmCSHuIQvc
X-Google-Smtp-Source: AGHT+IHRYggNC8xPJoUsiYcuVhgOT5Ybiwzt9w9AbNa7m2DjN+7M5oZ3SIikvFi1lIDOIQOVMlszQA==
X-Received: by 2002:a05:600c:4191:b0:40d:3b88:4516 with SMTP id p17-20020a05600c419100b0040d3b884516mr953358wmh.95.1705607411969;
        Thu, 18 Jan 2024 11:50:11 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bv12-20020a0560001f0c00b00337c4100069sm4494358wrb.24.2024.01.18.11.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:50:10 -0800 (PST)
Message-ID: <3cb503acbd2d65dc08172d620fe5dfff5f51be0d.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 1/5] libbpf: feature-detect arg:ctx tag support
 in kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 18 Jan 2024 21:50:04 +0200
In-Reply-To: <20240117223340.1733595-2-andrii@kernel.org>
References: <20240117223340.1733595-1-andrii@kernel.org>
	 <20240117223340.1733595-2-andrii@kernel.org>
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

On Wed, 2024-01-17 at 14:33 -0800, Andrii Nakryiko wrote:
[...]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c5a42ac309fd..61db92189517 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6757,6 +6757,69 @@ static int clone_func_btf_info(struct btf *btf, in=
t orig_fn_id, struct bpf_progr
>  	return fn_id;
>  }
> =20
> +static int probe_kern_arg_ctx_tag(void)

[...]

> +	btf_fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), strs, siz=
eof(strs));
> +	if (btf_fd < 0)
> +		return 0;

Question:
  suppose this is an old kernel and decl tags are not supported,
  should negative result be cached as 0 in such case?

[...]



