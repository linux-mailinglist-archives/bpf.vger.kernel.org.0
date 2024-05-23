Return-Path: <bpf+bounces-30347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C00B8CCA06
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 02:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13412830EF
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 00:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802BA3FF1;
	Thu, 23 May 2024 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkas2pRh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD313EDC
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716422530; cv=none; b=ILZKhbjCho74i2UFQ/jiFFaUaWMkWbANah5HTdJ39iLje43rpMnmn5GTerb9dCTDqzzWHTg36cEnMFvLj5pzReLWU1kbkCRLfh0I3sl+95oImPzCcUYfn1rUsrzc3GIpLeILR02sz8GVOzKGOINPvCz5TsE/DNZWF32bNPiCncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716422530; c=relaxed/simple;
	bh=VvV72Qo8L+MaJ/UUtmMHj4LT6QWxcMMxL/3eJ7G+bVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lk4JWCtHz3Gph5vp+7OW/a0FShqQZclqnGnXG2K4Vxa6rcmTCKXlxGQpkkjM969aif12r4/Y1O3qNp6QpMTaccI9bG8JeLemYhyUhO9b55cd3UWjyJC/2ZFISV0Yv0pwh3gqz9TRGdDcVVfMsEjeyWGL0cJD5sy/rrDSoGjNLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkas2pRh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-66629f45359so1559895a12.3
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 17:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716422528; x=1717027328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DyLAMJMJHmqCyBK68oaKqqSZlSdPpGprbH1xBzQr2Ss=;
        b=nkas2pRhIBzY54lfRicmHnqq+cEVWUE+4Eav+q+4hZA515EtNgNMgWUD2U+wXU1PyA
         1CZfyutiQz0p9E03CyqZ6EYa4gkA/TVCSb1rmbOfp6PnpvsXO4ROdhCHMZ/EAs70oV+s
         bltJLKNbtEU8ZgkXlr9sfJ6Uqrt8vuTWCZdFQ+yY8Dq/idi5cTGo5xa3rK6wRDBOnYN8
         qyPccS5hyDy5SzG6z8uLOf/mAG31UrMOZxqe2v7mnW6tHtUfbWs9gSPC/msorg08QeFb
         egstyqa8730KLnLbQVxLvcHcpkypEVL4ldHziVqmsw9PYmlVNAUCgyxzspWJoUtfua1f
         iwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716422528; x=1717027328;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyLAMJMJHmqCyBK68oaKqqSZlSdPpGprbH1xBzQr2Ss=;
        b=ko7BTYGd5hDKGcB0LM35V7Ke1KtIty0ve2Pv52EvjQOGART+k4BX4DYYxKHDDb+qIZ
         SAgiNGay9t+mk4sAG1GzTD5U7e60qRhzLfy91hSbuJhnkvVkKZ+3o3XPWBhJ21i/KiyB
         ygi1XwW0ghjr2FGbdXZ/Yq50leIWCMd4wdeG6hR5GnLIoQPb4p9hB5MeD7fAH1VCPrDC
         Ld1vWe+7DqLRZgPOPucicUJudSup4+X/aser/Q3nI/y+9Wy4442XfDwWlrDmblizZfov
         wQeWaMhhS/VXLP5rL8wEPoI0zsyZ80/LYlcDHyzpkMoxjs6LB8eEqJlGO8pqmVy2J5T9
         NrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSba19Ld7M45ZJVAjJr7/lp6+ZV2ycznabWAkcAP3v5fGJMAIRaJX8CbEHhuS7HlO/gip7BwVfUi3qA2fQN3gKo8b0
X-Gm-Message-State: AOJu0YxQV6rg8bwdtVsTkLLOxvlyBxWMVzG2DUjzTHdKXy/KZdVJKSO4
	pamp3oBGJe7cUinbyaNxgyBQXkwAZPZqg2qSvB/U/HC/Atgjjqg+XYlYQ45o
X-Google-Smtp-Source: AGHT+IHqSdjs75WqdYb9swmISTAHHmcoT951kw9oMhn6hezWfN+FBv0I1vIO1VvKS14u+ySAb53MOQ==
X-Received: by 2002:a17:90a:ca16:b0:2bd:6891:7e38 with SMTP id 98e67ed59e1d1-2bd9f5b8a9cmr3631521a91.36.1716422527845;
        Wed, 22 May 2024 17:02:07 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f0d656sm353320a91.31.2024.05.22.17.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 17:02:07 -0700 (PDT)
Message-ID: <15a3deb272983d2d165dd1ac0d1a7750b200a922.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Relax precision marking in open coded
 iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Wed, 22 May 2024 17:02:06 -0700
In-Reply-To: <20240522024713.59136-1-alexei.starovoitov@gmail.com>
References: <20240522024713.59136-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 19:47 -0700, Alexei Starovoitov wrote:

[...]

> Skipping precision mark at if (i > 1000) keeps 'i' imprecise,
> but arr[i] will mark 'i' as precise anyway, because 'arr' is a map.
> On the next iteration of the loop the patch does copy_precision()
> that copies precision markings for top of the loop into next state
> of the loop. So on the next iteration 'i' will be seen as precise.

Could you please elaborate a bit on why copy_precision() is necessary?
In general, the main idea of the patch is to skip precision marks in
certain cases, meaning that strictly more branches would be explored,
and it does not seem that copy_precision() is needed for safety reasons.

I tried turning copy_precision() off and see a single test failing:

    $ ./test_progs -vvv -a iters/task_vma
    ...
    ; bpf_for_each(task_vma, vma, task, 0) { @ iters_task_vma.c:30
    35: (55) if r0 !=3D 0x0 goto pc-15 21: R0_w=3Dptr_vm_area_struct(id=3D1=
002) R6=3D1000 R10=3Dfp0 fp-8=3Diter_task_vma(ref_id=3D1,state=3Dactive,dep=
th=3D1001) refs=3D1
    ; if (bpf_cmp_unlikely(seen, >=3D, 1000)) @ iters_task_vma.c:31
    21: (35) if r6 >=3D 0x3e8 goto pc+14    ; R6=3D1000 refs=3D1
    ; vm_ranges[seen].vm_start =3D vma->vm_start; @ iters_task_vma.c:34
    22: (bf) r1 =3D r6
    REG INVARIANTS VIOLATION (alu): range bounds violation u64=3D[0x3e8, 0x=
3e7] s64=3D[0x3e8, 0x3e7] u32=3D[0x3e8, 0x3e7] s32=3D[0x3e8, 0x3e8] var_off=
=3D(0x3e8, 0x0)
    23: R1_w=3D1000 R6=3D1000 refs=3D1
    23: (67) r1 <<=3D 4                     ; R1_w=3D16000 refs=3D1
    24: (18) r2 =3D 0xffffc90000342008      ; R2_w=3Dmap_value(map=3Diters_=
ta.bss,ks=3D4,vs=3D16008,off=3D8) refs=3D1
    26: (0f) r2 +=3D r1                     ; R1_w=3D16000 R2_w=3Dmap_value=
(map=3Diters_ta.bss,ks=3D4,vs=3D16008,off=3D16008) refs=3D1
    27: (79) r1 =3D *(u64 *)(r0 +0)         ; R0_w=3Dptr_vm_area_struct(id=
=3D1002) R1_w=3Dscalar() refs=3D1
    28: (7b) *(u64 *)(r2 +0) =3D r1
    invalid access to map value, value_size=3D16008 off=3D16008 size=3D8
    R2 min value is outside of the allowed memory range
    processed 27035 insns (limit 1000000) max_states_per_insn 65 total_stat=
es 2003 peak_states 1008 mark_read 2

I wonder, what if we forgo the 'ignore_bad_range' flag and instead
consider branches with invalid range as impossible?
E.g. when pred =3D=3D -2. Or when prediction says that branch would be
taken and another branch leads to invalid range.

I'll give it a try later this evening, but still curious about the
reasoning behind copy_precision().

[...]

