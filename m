Return-Path: <bpf+bounces-22865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDB86AF3D
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 13:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3321C21E6B
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC214534F;
	Wed, 28 Feb 2024 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atuWVp/h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DD73515
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123783; cv=none; b=tAGj+VezEJ8lnkkXV16AFvfTtQjGttxEJVjccM0CkBAv1/v42bpU2G7AdImvXjqphTzKXsRiH2j+MQWhc0bqDZFDKPLHre0zZi9BLRQHWzo/eWFiX/uDw9bCgBt5Z8l7HE5uxOJk86yiOclhBcpVRS3XnUL766DPzXol370cIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123783; c=relaxed/simple;
	bh=i1weNxxneX7hh87MdKXjvVSCTbiszLAB0cGBJnZYaJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h4RsjTqat+cstZblUTIGVMs/Bk9D6zakMe90UTZS8l4D/Pgo3Fw7rYdRTfjXbd/1x8nDa1sObxu5udOX2Oy3JkAs0R7xVHEm5TfNgZn/slD8q0aMO6LEiFlP6RPMoU/iPKV00JeN5B+GYB7yY2SAa1Apjahe43Jbs04gKvtJDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atuWVp/h; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a43488745bcso485177766b.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 04:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709123780; x=1709728580; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i1weNxxneX7hh87MdKXjvVSCTbiszLAB0cGBJnZYaJE=;
        b=atuWVp/hIn1nBdtr3YypxQxsS3Mr69GQvCOU3aK2LZULByBwgbWizfFbRXI9S28/6m
         sa8mniMwQPyyVl1bxRNnt656uaWGVg6LOomhVbnzaDy3MsQBh6K34qU+Exj8ETzxIIBx
         DB3NPFCVD7yYT69NlKMkulJbkXUs3bOIcklMRVyzO+ADUOP0QGvC0dehMNiBpp8nM7FA
         PNFRfw9LlVRMbHmlewNhasd4m8J9Cb2Uh1JoRrKqands1K2OXGQRaR11KFouA69vSYJc
         SoSWcDx5NWyDqq0QnFCZcsacw9wPg/iFroXwax921/7cmNIjqalwwWqwS1gvyieNtnT7
         D26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123780; x=1709728580;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1weNxxneX7hh87MdKXjvVSCTbiszLAB0cGBJnZYaJE=;
        b=QmIRD/H6cIiyTRKKyRAZcClNsspgd98KtUV/K6U9PvbQB1kZFz7W6g7pM/bhajTfRc
         ubG4vWAf1tIyobe/+ONl37LQG8/pIwDtWWhqotEBCr20eDTpvtPSv0S+1v9o0Hps+Wgh
         htVeUcVTX1DzllGoklBXklts7YKRQHVI5/vsowXrclyD+iJCk992pFs63UuLj16Qa5gF
         nNp+rXEaJmmsrDJuO+a9MwZDAkwgKBvo1vPh/jBP7UURSCvR+muOddfCOK+8/pBSwTNU
         qr92zJ/FYmZAISTdj6l6Sf1o0aqrQjffPqiLZ7qZ7MnZDVun0CuxE/oWCpzKoelz+/AJ
         Z+3A==
X-Forwarded-Encrypted: i=1; AJvYcCVKBus2SvsMqYHmylLoTYbNxDJSmwXBip5I26nzX5vMgo0w5xaD6agwqY/W2+WjAL1/4YPXxktvjshsRJqQZri3fe23
X-Gm-Message-State: AOJu0YziRkdO917voOyPVxXLT1VunemG/51Dl/OqVTyCiYh54Ftu47dE
	mIkHcolmRxo3gMk4zZFl2tZq4zy0N/dX0Stb9H/nTIVSI6t742hM
X-Google-Smtp-Source: AGHT+IFNgygv4DVYfRwb+BGaThMNU4IN4Gdx0JZoPIneBi7Lwnc8eHbjxbv1xaKsfkxcMe3nH2Y2Mg==
X-Received: by 2002:a17:906:150b:b0:a3c:f0ec:cff9 with SMTP id b11-20020a170906150b00b00a3cf0eccff9mr9509593ejd.7.1709123779823;
        Wed, 28 Feb 2024 04:36:19 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h6-20020a17090634c600b00a3e0b7e7217sm1815004ejb.48.2024.02.28.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:36:19 -0800 (PST)
Message-ID: <f0073ab1efab9d52754e78f54760abcd13f173c9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
 yonghong.song@linux.dev, void@manifault.com, bpf@vger.kernel.org,
 ast@kernel.org
Date: Wed, 28 Feb 2024 14:36:18 +0200
In-Reply-To: <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-8-eddyz87@gmail.com>
	 <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev>
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

On Tue, 2024-02-27 at 18:10 -0800, Martin KaFai Lau wrote:
[...]

> Instead of adding struct_ops_refs and autoload_user_set,
>=20
> for BPF_PROG_TYPE_STRUCT_OPS, how about deciding to load it or not by che=
cking=20
> prog->attach_btf_id (non zero) alone. The prog->attach_btf_id is now deci=
ded at=20
> load time and is only set if it is used by at least one autocreate map, i=
f I=20
> read patch 2 & 3 correctly.
>=20
> Meaning ignore prog->autoload*. Load the struct_ops prog as long as it is=
 used=20
> by one struct_ops map with autocreate =3D=3D true.
>=20
> If the struct_ops prog is not used in any struct_ops map, the bpf prog ca=
nnot be=20
> loaded even the autoload is set. If bpf prog is used in a struct_ops map =
and its=20
> autoload is set to false, the struct_ops map will be in broken state. Thu=
s,=20
> prog->autoload does not fit very well with struct_ops prog and may as wel=
l=20
> depend on whether the struct_ops prog is used by a struct_ops map alone?

This makes sense.
The drawback is that introspection capability to query which programs
would be loaded is lost, maybe that is not a big deal.
It could be put back by adding an ugly loop iterating over all maps in
bpf_program__autoload() for struct_ops programs.

I think I'll post v2 with changes you suggest and see what others have to s=
ay.

