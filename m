Return-Path: <bpf+bounces-14633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35217E7309
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 21:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840DF28120B
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47EE30334;
	Thu,  9 Nov 2023 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCCVkfrX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F4225DC
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 20:45:42 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161D449E
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 12:45:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso2131283a12.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 12:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699562740; x=1700167540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iSFi6EgNOcXNjR2O3zR9sdThlKufSi5trMCjjZ5RtYM=;
        b=lCCVkfrXaJ+pJeF3vW0PDugj2fyJBr+DWLVp8wZktffwMcje0+3c+PAlh2AoKbYYXq
         4SaAXP6vmH4djJUkwhTwd4i1RwSGjTbvl2Rar7x0+WzMcUQjvIFB6YPy7cHh/L+IwRBf
         DRvn+AnjGpPWhVBH3jpSimcmF3+xnk1Rj8Xii+QatQ5b9PkpMWAVEGimtQPCaS66hm3w
         ScP7DVq3NgMNBehf6N6djhvkHxQlaBdstgJ7qsruwNBdok9FJuViKqyLN4mPXX8IxskH
         +EDvf3erGgEv6VLcA7AYeiSu9ms+3V8WmN4aYnw4IkT6QCR2NxUhugRF+chv5eiaDKPd
         ymqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699562740; x=1700167540;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSFi6EgNOcXNjR2O3zR9sdThlKufSi5trMCjjZ5RtYM=;
        b=VHovVnF7qDy0OsYt3n4UaQMfSnOt3AXOcl7tVuY/fHyd33tjXJBs1IA4L3Zt8vUXxg
         7Ol5r8jkyyA8JDssXHpguQe7+WYWvvHZWv7/FF0MIwFHHCKFvEdi/dB/MyFmI79F/rs0
         JpTPwj+M3rTHxMKRdOgDUUqdG6OeMqc5KuK7/TTRWev7eymjfjVo6+GAximVb9vEyqUQ
         7aDaKeN/IeWq9EZKkuqZTJZxmA3Hpo0Ycr6p7aF2RYIpuMsb7xd8+ywaqvnlxjxbfdQO
         QwKhoIOoMWsMIb2rwfh6OF8Kf4IouzPQkZ+QgLIvSxdlZ+nAh7mNN2OX3+mG853bkBmz
         2ilg==
X-Gm-Message-State: AOJu0YyufsyCRkvVwoKgrcXER/5dKQWdcrpmlAMo9EMQD+nMIig6WhE9
	kVJrBfOQqYw8FDG+EF7lj8w=
X-Google-Smtp-Source: AGHT+IEKHnesEe3P/i1rvOcEPMKSFLUOZIiMwqJ1h7g6KNf/Sf9MCLjZR162pfBo+xV/ZsEWqSnmpw==
X-Received: by 2002:a17:907:7f1e:b0:9d5:ecf9:e6a0 with SMTP id qf30-20020a1709077f1e00b009d5ecf9e6a0mr3946569ejc.0.1699562740314;
        Thu, 09 Nov 2023 12:45:40 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709064f0f00b0099bcf9c2ec6sm3012655eju.75.2023.11.09.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 12:45:39 -0800 (PST)
Message-ID: <2a414a6fbe64e0c8a1b5838b3fd1969a0b1c253a.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix pyperf180 compilation
 failure with llvm18
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 09 Nov 2023 22:45:38 +0200
In-Reply-To: <8576d3dd-28af-45c2-b72c-30105a451da9@linux.dev>
References: <20231109053029.1403552-1-yonghong.song@linux.dev>
	 <6bf022a8cfd8c821ec0a8370fa85bcfd806c8be7.camel@gmail.com>
	 <8576d3dd-28af-45c2-b72c-30105a451da9@linux.dev>
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

On Thu, 2023-11-09 at 11:54 -0800, Yonghong Song wrote:
> On 11/9/23 3:47 AM, Eduard Zingerman wrote:
> > On Wed, 2023-11-08 at 21:30 -0800, Yonghong Song wrote:
> > > With latest llvm18 (main branch of llvm-project repo), when building =
bpf selftests,
> > >      [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf =
LLVM=3D1 -j
> > >=20
> > > The following compilation error happens:
> > >      fatal error: error in backend: Branch target out of insn range
> > >      ...
> > >      Stack dump:
> > >      0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARC=
H_x86 -mlittle-endian
> > >        -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/in=
clude
> > >        -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/=
yhs/work/bpf-next/tools/include/uapi
> > >        -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include =
-idirafter
> > >        /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18=
/include -idirafter /usr/local/include
> > >        -idirafter /usr/include -Wno-compare-distinct-pointer-types -D=
ENABLE_ATOMICS_TESTS -O2 --target=3Dbpf
> > >        -c progs/pyperf180.c -mcpu=3Dv3 -o /home/yhs/work/bpf-next/too=
ls/testing/selftests/bpf/pyperf180.bpf.o
> > >      1.      <eof> parser at end of file
> > >      2.      Code generation
> > >      ...
> > >=20
> > > The compilation failure only happens to cpu=3Dv2 and cpu=3Dv3. cpu=3D=
v4 is okay
> > > since cpu=3Dv4 supports 32-bit branch target offset.
> > >=20
> > > The above failure is due to upstream llvm patch [1] where some inlini=
ng behavior
> > > are changed in llvm18.
> > >=20
> > > To workaround the issue, previously all 180 loop iterations are fully=
 unrolled.
> > > Now, the fully unrolling count is changed to 90 for llvm18 and later.=
 This reduced
> > > some otherwise long branch target distance, and fixed the compilation=
 failure.
> > >=20
> > >    [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b=
5720c607313a566eebb16e
> > >=20
> > > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > Can confirm, the issue is present on clang main w/o this patch and
> > disappears after this patch.
> >=20
> > Yonghong, is there a way to keep original UNROLL_COUNT if cpuv4 is used=
?
>=20
> I thought about this but a little bit lazy so not giving it enough throug=
ht.
> But since you mentioned this, I think adding a macro to indicate cpu vers=
ion
> by llvm is a good idea. This will give bpf developers some flexibility to
> add new features (new cpu variant) or workaround bugs (for a particular c=
pu variant
> but not impacting others if they are fine), etc.
>=20
> So here is the llvm patch: https://github.com/llvm/llvm-project/pull/7185=
6

Thank you, tried it locally, works as expected.

