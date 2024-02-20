Return-Path: <bpf+bounces-22326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC3C85C226
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39696B216E6
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938676C61;
	Tue, 20 Feb 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVMV9Zu/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858B76C60
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449190; cv=none; b=ZAS4EthrP8dzBcsnsoLetlzwDmcdYHj96chG423K/WOXcwkLIP/zJ7Tu33Ol89MycOFfcLouyKTyy3P9C9BUAHFjpxI6a3Lq15NP11YOgm2EsBye+3B3mfRSwIVth5rLwcQKKyGyC0zOS7FM39c8vdcL+VjPBNTN7nVWtsm2iSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449190; c=relaxed/simple;
	bh=QyFYjFJzgtcet9LSgs+jYg9ym7r2VYbpOOAqT6ZvYL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOlL2r/kKEQNnaxTPP2YSRtqVdS4DK7HplsmzNLupa1s8TmY9bcf4c5pvxQwhS8AK0ASIWXA5rCMB46aMJcs1yNJIlueppXA+kaDv0ukZnNwHCQL5cu/B53MHOn7nTRuyGfnEAdQ+vvy4efxC1gqJdAVJ/sRv2S8zBaQ0KnA1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVMV9Zu/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512cca90f38so529954e87.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708449186; x=1709053986; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4k3iHBAGn0bZkooXGxLnRnep+EYS7gZ6teN+oVAJjCg=;
        b=ZVMV9Zu/1ETihpXhyJ0lyVSMY/moqMDR5FDfzpmV1NyBW965ZIOmVd5DUehyOjhUhp
         vuK7KtWyeuaFjtAQnEo+9yUYHHDGvMQ1shAk2bd07BqvQPdKK4p39GxFGfFkmlI3JU9W
         K1G4aeFdRqvJEEvQ95vIJ6kvI/QfyU6JL6E6BwD42cYri8byBkIZjI9rDGueqyU2cuMm
         avZbpPIpe+JAAjTOXV40fM4Nd17eGy32ODpMpjVqHsN/Ad9bKs2SR0w8EhakSDy9OmoE
         JyG4vuQahYl+vIDlLray+kBNxUWhzoLFMOvrriLY7JgHTHPc0ge2A7lONa09RpeizXmG
         97KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708449186; x=1709053986;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4k3iHBAGn0bZkooXGxLnRnep+EYS7gZ6teN+oVAJjCg=;
        b=AiQmC1buIhMOPEfoYYs6biy8LB9DcekxE54nGSt3HU5mZ0S3+OANBljMWIrkvWJ31t
         k0RtojffhFUWsXXVmJXDLNxdvbLUAZqtJpQf53xlK0WKLF/O0WEvWRpu4HByMOMeaw1j
         ntsNk2oR9Vp2ASerqZVgscpRy2dx5wNtUCUT+0N5uO/VvUwA/v5GurJYRW7DeJ0fusB2
         mecXdtY3O5yQVcXvfiET+m79gLZgtt/UZDg/yVk6EAW4l5YP5vo/7ZLvAzSS4bYvpWXm
         ZMlHWQDgVlxakakr89f9Aj7tfwnjiOpSHXootufTuv4vaFxQ9CzhQQBl1G69BI40ROK7
         caMg==
X-Forwarded-Encrypted: i=1; AJvYcCWeskR4sQcYFvZZStTbrFjrugip4S1eJ6uUd2+QemRfVCpUQ4nVVsSX2g6apufSfbFNVO+WGMAF0YVR2bAwY0z373Q0
X-Gm-Message-State: AOJu0Yys8xujYOrSYtWvvg+gXFhLfHWg/tL0Lt6wtbYxzm8yxU/+PT3X
	kDLA3Wqwe++8hNP2kuEgpCDaPz0FepEYa7nlwRs1G+5E+z+PX+BM
X-Google-Smtp-Source: AGHT+IEJ2kRPXXFskHmKZsGSM11jFGHvstFICHjnf9zGmrTTGN9ExKw+b/pKud180sGg9cD32wQ+OQ==
X-Received: by 2002:ac2:5e62:0:b0:512:a93a:f5a5 with SMTP id a2-20020ac25e62000000b00512a93af5a5mr4945690lfr.19.1708449186257;
        Tue, 20 Feb 2024 09:13:06 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033d39626c27sm9628728wru.76.2024.02.20.09.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:13:05 -0800 (PST)
Message-ID: <68ee71a1a4f86b05882e1065027150152f3c2f2d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: check bpf_func_state->callback_depth
 when pruning states
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, kuniyu@amazon.com
Date: Tue, 20 Feb 2024 19:13:04 +0200
In-Reply-To: <f21c1a87-a657-407b-a074-496503edd20e@linux.dev>
References: <20240212143832.28838-1-eddyz87@gmail.com>
	 <20240212143832.28838-3-eddyz87@gmail.com>
	 <fdf38873-a1e2-4a16-974b-ea2f265e08e1@linux.dev>
	 <925915504557d991bf9b576a362e0ef4a8953795.camel@gmail.com>
	 <0e5b990eeaa63590e067c8ac10642b6bc6d0e9a8.camel@gmail.com>
	 <1fbcd9f1-6c83-4430-b797-a92285d1d151@linux.dev>
	 <9e19786565a3fbfea58dcd25bba644fe8e0ed6b0.camel@gmail.com>
	 <f21c1a87-a657-407b-a074-496503edd20e@linux.dev>
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

On Mon, 2024-02-19 at 16:25 -0800, Yonghong Song wrote:
> On 2/16/24 6:27 AM, Eduard Zingerman wrote:
> > On Wed, 2024-02-14 at 09:42 -0800, Yonghong Song wrote:
> >=20
> > > >    .------------------------------------- Checkpoint / State name
> > > >    |    .-------------------------------- Code point number
> > > >    |    |   .---------------------------- Stack state {ctx.a,ctx.b,=
ctx.c}
> > > >    |    |   |        .------------------- Callback depth in frame #=
0
> > > >    v    v   v        v
> > > > 1  - (0) {7P,7P,7},depth=3D0
> > > > 2    - (3) {7P,7P,7},depth=3D1
> > > > 3      - (0) {7P,7P,42},depth=3D1
> > > > (a)      - (3) {7P,7,42},depth=3D2
> > > > 4          - (0) {7P,7,42},depth=3D2      loop terminates because o=
f depth limit
> > > > 5            - (4) {7P,7,42},depth=3D0    predicted false, ctx.a ma=
rked precise
> > > > 6            - (6) exit
> > > > 7        - (2) {7P,7,42},depth=3D2
> > > > 8          - (0) {7P,42,42},depth=3D2     loop terminates because o=
f depth limit
> > > > 9            - (4) {7P,42,42},depth=3D0   predicted false, ctx.a ma=
rked precise
> > > > 10           - (6) exit
> > > > (b)      - (1) {7P,7P,42},depth=3D2
> > > > 11         - (0) {42P,7P,42},depth=3D2    loop terminates because o=
f depth limit
> > > > 12           - (4) {42P,7P,42},depth=3D0  predicted false, ctx.{a,b=
} marked precise
> > > > 13           - (6) exit
> > > > 14   - (2) {7P,7,7},depth=3D1
> > > > 15     - (0) {7P,42,7},depth=3D1          considered safe, pruned u=
sing checkpoint (a)
> > > > (c)  - (1) {7P,7P,7},depth=3D1            considered safe, pruned u=
sing checkpoint (b)
> > > For the above line
> > >      (c)  - (1) {7P,7P,7},depth=3D1            considered safe, prune=
d using checkpoint (b)
> > > I would change to
> > >      (c)  - (1) {7P,7P,7},depth=3D1
> > >             - (0) {42P, 7P, 7},depth =3D 1     considered safe, prune=
d using checkpoint (11)
> > At that point:
> > - there is a checkpoint at (1) with state {7P,7P,42}
> > - verifier is at (1) in state {7,7,7}
> > Thus, verifier won't proceed to (0) because {7,7,7} is states_equal to =
{7P,7P,42}.
>=20
> Okay, I think the above example has BPF_F_TEST_STATE_FREQ set as in Patch=
 3. It will
> be great if you can explicitly mention this (BPF_F_TEST_STATE_FREQ) in th=
e commit message.

Will do.

[...]

> But then for
>    14   - (2) {7P,7,7},depth=3D1
>    15     - (0) {7P,42,7},depth=3D1          considered safe, pruned usin=
g checkpoint (a)
> The state
>    14   - (2) {7P,7,7},depth=3D1
> will have state equal to
>     7        - (2) {7P,7,42},depth=3D2
> right?

I think you are correct.

