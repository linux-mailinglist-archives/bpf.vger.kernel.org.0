Return-Path: <bpf+bounces-21639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5635284FAEC
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 18:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8EB2881CD
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DF17F46B;
	Fri,  9 Feb 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrAH3P9A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6767BB02
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499220; cv=none; b=qPYIelEKIQmsZ/VYiYQoExrQZ+cekaYfNa6NtgAmG0y4I8lMNkrd0VWYq1GKcLl3r5QasWLYxvcnacarlOTrIGUNKVv8JsCtD54Tjw3stIB0NZf1IDvwGaPx3X2UQmkxVZIe7ycZP0WZV4m/SG7lPbFxWb3bWN5kpp7ZRWkXcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499220; c=relaxed/simple;
	bh=dTUCCJ6GZhbWY+AcKoCDx6Kei+Xpf22KV9TfmXy4imc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jrDm6yRBmuOSC7yWWUr2AV1b/BS9cAlDJ/KEMrnJraGSVDePaWKe2NrZBruefrdfMcfzEe0TUlQaIqqKZv7mhK925tKWumvkNI66fgtsbODdIgNqOA+2Md8YC7HxlmopEIa1OwHFhAfHVjFscW/tKqS/ULlA5SzA284FJ9+/c+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrAH3P9A; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so1558977a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 09:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707499217; x=1708104017; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yb3+u+NQguLS/li+kaMHx2OU0Nns40V2ZAiikmaHqLo=;
        b=nrAH3P9Ax3PTxOEdmtJgF7LzlmpcyoQOsJpDdOdem88n5bfkOuR09IiqrhpuLLln4O
         kNr6lVA0iWCUNexLR7Ub4D+Ry+9xkD46Whn4kM1E5Vqtn6liZMUOD1EPiFfbm5E1CmpE
         JnBs1qsuuNsbIg9RM08vlEU9utsXbVrN5d9WRY0VC+jgZ2A4SbbTr8WSq6cgtdnndN4S
         90boRkvvgdcrhH6mEz++j+MVFI5g+7/ddDmWbOP7pJcA3/nN+PVjVMVWnbx6egoka/j1
         HPlnxfBJ8JlzMH1MWtCcrzHhUrb8vYSK3zKKWkkKl6cetuIi2+8edl5QG2/Jc2kpTip1
         hbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707499217; x=1708104017;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb3+u+NQguLS/li+kaMHx2OU0Nns40V2ZAiikmaHqLo=;
        b=lXj/zwMr0UCejLzepSyinag30NIUh1VqdAXdTGJaAqrFK5jhRbwgVKPH73eSzPGoBH
         xX96cbNzgMqNgvdUMScAgwBdes3/eLF7MLD38uyji5iwEJESnsWSJYlvpWtjLfW6YRbN
         tc7xEdzZl9a3g8wlIOm41NGGOFFDQMdq0MOcaZZj+W39HCMAE3t+gKhg7ZowmTrbgSHL
         dpoRoKQriaQcuwLvIffmQi2R1GXRZuvahFWpMM0kR/quRkQAzqQhklG48ygZuaQNJ3Cv
         +6d29laX69yyUBZWmnTGJkycUQapDr/ILAHz2mZYK2d9jYuOXMMS2rrBTX5H3ZDn18+H
         Pxdg==
X-Gm-Message-State: AOJu0Yyd+N+8F2N8D12C1mnsn3ogP2LVV4PsqLEMJk0GxhxRFw4sLqUu
	qhH2Nsf132IT6MiEw8dYdcQ4hje0aWEe7D6Wr70CFnvp8RuH3YPw
X-Google-Smtp-Source: AGHT+IGKqE8Ypo7bQgt1GIII1E+JLIobh/hSE56P169utGfYWsKNJjFvSKKYWEsJVe36HZOQVL/OUw==
X-Received: by 2002:aa7:d40e:0:b0:55f:cca3:e89e with SMTP id z14-20020aa7d40e000000b0055fcca3e89emr1707673edq.21.1707499217179;
        Fri, 09 Feb 2024 09:20:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW26FksTgcNEfWk0e8oyMu8bAXpZ5/A+42+N7NDm0kAyh+3c8FEs62LiUAFzXs0EWRgO3QICwzGjAqlfNl2zaMALmeyLrPG66e9keFVoOPdBVql8A/J6l7xNwEpBsfqP5DpP8H775kiJWLZVpgMd8I+tOH3hzA7km2+mh6uE903fkjgxW/WZlyeZaK1dOaBFqBAt7znD9ArPWhMRjfSxZn21aOnX0aeh+F3hy37SvGvaisHgVIuuNrzrsZjyjDjMjnisJPWkSVDQ7K5XQsZNdMRVPnewTAEkZp51OA8vuOEkuzy0L+vwV5SVQ49yTq+JQucnP0tSuWoPbFqseShIuR6H5V5CfBazy3Gqi92Na2kyP76C0E6YV+4
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a17-20020aa7cf11000000b005612ac47d85sm951380edy.82.2024.02.09.09.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:20:16 -0800 (PST)
Message-ID: <b8e3b8382dbb58418a89a74995732e5aade6d4df.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/20] bpf: Add x86-64 JIT support for
 PROBE_MEM32 pseudo instructions.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 tj@kernel.org,  brho@google.com, hannes@cmpxchg.org, lstoakes@gmail.com,
 akpm@linux-foundation.org,  urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com
Date: Fri, 09 Feb 2024 19:20:15 +0200
In-Reply-To: <20240209040608.98927-8-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-8-alexei.starovoitov@gmail.com>
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

On Thu, 2024-02-08 at 20:05 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW] instructi=
ons.
> They are similar to PROBE_MEM instructions with the following differences=
:
> - PROBE_MEM has to check that the address is in the kernel range with
>   src_reg + insn->off >=3D TASK_SIZE_MAX + PAGE_SIZE check
> - PROBE_MEM doesn't support store
> - PROBE_MEM32 relies on the verifier to clear upper 32-bit in the registe=
r
> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in %r12 =
in the prologue)
>   Due to bpf_arena constructions such %r12 + %reg + off16 access is guara=
nteed
>   to be within arena virtual range, so no address check at run-time.
> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop.
>   When LDX faults the destination register is zeroed.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

It would be great to add support for these new probe instructions in disasm=
,
otherwise commands like "bpftool prog dump xlated" can't print them.

I sort-of brute-force verified jit code generated for new instructions
and disassembly seem to be as expected.

[...]

> @@ -1564,6 +1697,52 @@ st:			if (is_imm8(insn->off))
>  			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>  			break;
> =20
> +		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
> +		case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
> +		case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
> +		case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
> +			start_of_ldx =3D prog;
> +			emit_st_r12(&prog, BPF_SIZE(insn->code), dst_reg, insn->off, insn->im=
m);
> +			goto populate_extable;
> +
> +			/* LDX: dst_reg =3D *(u8*)(src_reg + r12 + off) */
> +		case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
> +		case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
> +		case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
> +		case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> +		case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
> +		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
> +		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
> +		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
> +			start_of_ldx =3D prog;
> +			if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)
> +				emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->of=
f);
> +			else
> +				emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->of=
f);
> +populate_extable:
> +			{
> +				struct exception_table_entry *ex;
> +				u8 *_insn =3D image + proglen + (start_of_ldx - temp);
> +				s64 delta;
> +
> +				if (!bpf_prog->aux->extable)
> +					break;
> +
> +				ex =3D &bpf_prog->aux->extable[excnt++];

Nit: this seem to mostly repeat exception logic for
     "BPF_LDX | BPF_MEM | BPF_B" & co,
     is there a way to abstract it a bit?
     Also note that there excnt is checked for overflow.

