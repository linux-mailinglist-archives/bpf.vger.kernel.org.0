Return-Path: <bpf+bounces-18833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2DE8225C7
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83131F23245
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DCF1363;
	Wed,  3 Jan 2024 00:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdNGS+1+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D117984
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d88724fb9so23821055e9.3
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 16:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704240179; x=1704844979; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ8XttuFREKFWk51avKU2gziNDc7LkBBnoOUZ3Tv6JE=;
        b=AdNGS+1+v2u+9L4Nr30z+L7CO//JgcJGEoM/WWp6hgrckt+FnGk3x4o9rcDbKInrq8
         yH3ov5EGowa7JVqPhf/IdfSvP4LZCpuGdcdFcxweonPQc8Yfq5/zf59M69rf4K2IQ3VC
         Vv1v4KFQQoVYIp4j2eOTX97Q3Bpuh6RRfwgzSwx6ua+NVlHmPqG4oWvyTWHKdiM32yRo
         dru20UR2p4BdAP0tZZvxrjWuQBinSVM67PQnl5BMqafgXaoxvp8nBnMBrYhbxoZ3Ig1L
         Ydmd0fRHOpPs8UBVl9rCmSkxMP88OQJ7XpG8ow2v3+1ffeyEicHZ7tqaCar6+R2jTW/w
         Aijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704240179; x=1704844979;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZ8XttuFREKFWk51avKU2gziNDc7LkBBnoOUZ3Tv6JE=;
        b=Y8Xz6XvXYhx6tphf1JXGpVR81kENPc7pi/Yw3TGjWkZlxT3TJYxrkzf5MUn72+ZSK3
         kKrWjMg8Pv3VcvZd0G9rhMY1gu0+dOnYSygJjkPs+e9JdOEd7yVWDCJeDxn3/F09hM/i
         oLf+sxffAYhTOlGRvNJfdIuGHMFIFsQPDZzs1KCZmm3Hxrply21gB9eN8/zSsE9I54Y9
         gkjRWVypWBXzJEFpPN5+LFuYWNHvfZCxyeDHPdGg92QXGhlW7by1pBU9lgAUr3OwZg34
         PJZg++B4L/BkMmMia/32fNL6eSZ0SOY/zb0VzMzo5ypiseaXUxIaias2vsvZKibLjawj
         3O7g==
X-Gm-Message-State: AOJu0YymrZ/JG8xc3XDguQFCzfdrc7nXYX472E/HdfcMOpkfY4FuoK6q
	Voz7bRkK58/Vj3re74GJd5w=
X-Google-Smtp-Source: AGHT+IH1W2SAZ/mIJN4hDjTaTLzUTgSYRLB9WRTNxH0PIY8F40PBrj7HV6QdQlheHKsADegG7gxX4Q==
X-Received: by 2002:a05:600c:2a8e:b0:40a:44c0:fd43 with SMTP id x14-20020a05600c2a8e00b0040a44c0fd43mr10146560wmd.17.1704240178790;
        Tue, 02 Jan 2024 16:02:58 -0800 (PST)
Received: from smtpclient.apple ([2a00:6020:a787:f900:a150:4afb:59ae:7c9])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b0040c3dcc36e6sm489993wmq.47.2024.01.02.16.02.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2024 16:02:58 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: test_kmod.sh fails with constant blinding
From: Jan-Gerd Tenberge <janten@gmail.com>
In-Reply-To: <d3ea8754ed4c5f8a33b3fd2cc69eeff7f362ce35.camel@gmail.com>
Date: Wed, 3 Jan 2024 01:02:47 +0100
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Bram Schuur <bschuur@stackstate.com>,
 "ykaliuta@redhat.com" <ykaliuta@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "johan.almbladh@anyfinetworks.com" <johan.almbladh@anyfinetworks.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED829AA7-2F5D-41FC-8C2E-96A1DC19D5B8@gmail.com>
References: <AM0PR0202MB3412F6D0F59E5EBA0CA74747C461A@AM0PR0202MB3412.eurprd02.prod.outlook.com>
 <08287f7c-d0aa-4ded-a26d-34023051dd14@linux.dev>
 <28bcf5ae2df9ed0bd1603ed161e1d4488694c0d9.camel@gmail.com>
 <1b45ec38-3a7f-4745-a063-8b16b040004c@linux.dev>
 <d3ea8754ed4c5f8a33b3fd2cc69eeff7f362ce35.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

> Am 02.01.2024 um 23:39 schrieb Eduard Zingerman <eddyz87@gmail.com>:
>=20
> On Tue, 2024-01-02 at 11:41 -0800, Yonghong Song wrote:
>> On 1/2/24 9:47 AM, Eduard Zingerman wrote:
>>> On Tue, 2024-01-02 at 08:56 -0800, Yonghong Song wrote:
>>>> On 1/2/24 7:11 AM, Bram Schuur wrote:
>>>>> Me and my colleague Jan-Gerd Tenberge encountered this issue in =
production on the 5.15, 6.1 and 6.2 kernel versions. We make a small =
reproducible case that might help find the root cause:
>>>>>=20
>>>>> simple_repo.c:
>>>>>=20
>>>>> #include <linux/bpf.h>
>>>>> #include <bpf/bpf_helpers.h>
>>>>>=20
>>>>> SEC("socket")
>>>>> int socket__http_filter(struct __sk_buff* skb) {
>>>>>    volatile __u32 r =3D bpf_get_prandom_u32();
>>>>>    if (r =3D=3D 0) {
>>>>>      goto done;
>>>>>    }
>>>>>=20
>>>>>=20
>>>>> #pragma clang loop unroll(full)
>>>>>    for (int i =3D 0; i < 12000; i++) {
>>>>>      r +=3D 1;
>>>>>    }
>>>>>=20
>>>>> #pragma clang loop unroll(full)
>>>>>    for (int i =3D 0; i < 12000; i++) {
>>>>>      r +=3D 1;
>>>>>    }
>>>>> done:
>>>>>    return r;
>>>>> }
>>>>>=20
>>>>> Looking at kernel/bpf/core.c it seems that during constant =
blinding every instruction which has an constant operand gets 2 =
additional instructions. This increases the amount of instructions =
between the JMP and target of the JMP cause rewrite of the JMP to fail =
because the offset becomes bigger than S16_MAX.
>>>> This is indeed possible as verifier might increase insn account in =
various cases.
>>>> -mcpu=3Dv4 is designed to solve this problem but it is only =
available at 6.6 and above.
>>> There might be situations when -mcpu=3Dv4 won't help, as currently =
llvm
>>> would generate long jumps only when it knows at compile time that =
jump
>>> is indeed long. However here constant blinding would probably triple
>>> the size of the loop body, so for llvm this jump won't be long.
>>>=20
>>> If we consider this corner case an issue, it might be possible to =
fix
>>=20
>> This definitely a corner case. But full unroll is not what we =
recommended although
>> we do try to accommodate it with cpuv4.
>>=20
>>> it by teaching bpf_jit_blind_constants() to insert 'BPF_JMP32 | =
BPF_JA'
>>> when jump targets cross the 2**16 thresholds.
>>> Wdyt?
>>=20
>> If we indeed hit an issue with cpuv4, I prefer to fix in llvm side.
>> Currently, gotol is generated if offset is >=3D S16_MAX/2 or <=3D =
S16_MIN/2.
>> We could make range further smaller or all gotol since there are =
quite
>> some architectures supporting gotol now (x86, arm, riscv, ppc, etc.).
>>=20
>=20
> I tried building this program as v3 and as v4 using the following
> command line:
>=20
>  clang -O2 --target=3Dbpf -c t.c -mcpu=3D<v3 or v4> -o t.o
>=20
> (I copied definitions of SEC and bpf_get_prandom_u32 from =
bpf_helper_defs.h).
>=20
> With the following results:
> - when built as v4 program can be compiled, gotol is generated and
>  program can be loaded even when bpf_jit_harded is set:
>  "echo 2 > /proc/sys/net/core/bpf_jit_harden"
>  (as far as I understand this is sufficient to request constant =
blinding);


If your kernel is compiled without CONFIG_BPF_JIT_ALWAYS_ON, the loading =
of the program will succeed, but it will be interpreted instead of jit =
compiled. You can check whether the compilation succeeded by looking for =
the "(not) jited=E2=80=9C line in bpftool prog show.=

