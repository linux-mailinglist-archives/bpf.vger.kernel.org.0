Return-Path: <bpf+bounces-79193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93021D2CC0A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924633065AA0
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785A34EF01;
	Fri, 16 Jan 2026 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcfRsLID"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE1346ACF
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546285; cv=none; b=FmAGFT8XkIjAYhc3knL0Qno8UXKwK2QUWBR7mzfUnhPLUOLExCwKxAQBSk+kSUtqNT0fNxVe6npAfmoa4w9VdLvMD3TYfaVGIHlsTkEAkNOyZmUY/tD9gRaZsRP7lXdrKI3CrHK+JLW1OqF+ZJFCZS2gEFCnJWN8VzS7bt80UFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546285; c=relaxed/simple;
	bh=V+N9nQ78Ws8zuM+Nr2Hg49PmJYuv2i2LP11ETMyfxt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRq4bYzrBNg1RGfvJCwaxf/K4l516VkotstZUzdSUNPH3WqgxRQKdMWhT2/2BzYCAUfzyzf35GbfOsXB1UnjaD6KI9Bdzs0/Xk8f4iYXBhMGDiygG+YEtrbpAuypN3ouffofymsOg0Cotv0/6gIibte/0eJHLeziFKCYRTWzLb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcfRsLID; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so12392935ad.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 22:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768546283; x=1769151083; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8kSkqWutcRMBUnUXtvt0aSg1ad6YfbQPtUSAzw3ITPM=;
        b=fcfRsLIDlX3z/PKv3mzH5ugfijjuQRS7rKZIKZCCd0eevZ/UzYaqbbBDbO07ao+x4i
         apV70vRkaQEWGXoQWgZyvHraFCJ8Wwb5t4fKmxPIKujheHs7/dD+HXmYUJ3esTxU8Osr
         rboqvCQii4Q1WfmOjjaebNCLyHGBcCuetARgxEAiFYssmnqrHC68Tyy8qZyg6+ifINS1
         bLyR+KNYCKz0jW9c/Hui5qJlm2FVBKb/fLIEE+uqsr5E8TmXpenoIwLYsTPUs2+qJ/pv
         epYMMJAnirhTPX47yNFv9mcafHAkiwwDRwEcop68larXoYSgc6sCH+F67XU01QqKDgEn
         CwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768546283; x=1769151083;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kSkqWutcRMBUnUXtvt0aSg1ad6YfbQPtUSAzw3ITPM=;
        b=cC+Asm/0Hr9UbaudK5AYz9ovg8Wp4hwAkod6zkUg6CnEIsHFFkW9/1CJpUQy/FOI+h
         xM7OvCsX9DvQ8cWCjIjXEWpsqpFVX9PWSLGkRT6SAhmnZMjD7K4SyseLdSeNsNYsAKsy
         QIv+2qjloONrOKjKfhMEjn/YC42kFTV423btU0JANNVLL/JuxQuSolIDr0+lErRa2hMk
         7bWMbBDT8SOU87YnM8yTQ2KjkoyUymnd2Ku5fbj0qHEuc3o9+wfkobEH4OnUNqxn01gH
         vxHEpOtIudir6OhQMVTDEB2NbHuKWIcbihOrJ9oQJm/3glUe70MGle+jPJGV6RW367+c
         ZU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbSGfXyPO5UaJOXDJ5qIzShCaLlRtWOMl5SNKgnG+SE7KzkBCVLqagAfs7zb0v03u07Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5GsDL0wmhn0r4oWlIiXhsamep+zwBA0LRge699w998JVIzJQ
	K+xEGIvvJLpjS7OdZA28+zX/pPsjnr7T+22SZLUVPaJOi8vuoJ6+z6P+IgzypA==
X-Gm-Gg: AY/fxX68Qb/qXQpPlFFIAC5f5hb9c3+mCOV44Wji3mKanA7b4iiv5790QvDT6LzlrNw
	lSadFe1gNus+e/gJX+Xu8jD5sNfyVTxACgl/3BjFxe2nK6f9w4/qafmoJU91c5PSLcB3D2H2FP/
	n2Nf6XzCvQVlSTE6iy5qgXTySP54F28W2p5szH1lKnRiGwuu6vAgKZZWLfVYdtg0ZZRGbiVgf8/
	MtSm21+E192Jeo58XBi38rYf+5uZrMqVwfYiPoDJz3Q4WCCSNuvkdZIfIGbtn+w3v5CQvJ+5YTH
	jV+LNFye5EDHYWD3hvvXWhMGtlakeumC4OEss18npG7cweeamouXXeeIHxIjRdxoPF6dS4hTyUO
	eUivoz4T+NLb8P7eYMAHNXdhlKBWxTYA4lwjaODAg5nqrKxZOfFZP0GU1E8MmwP9XAxHix/1Z+D
	9rpxUKQ1vPLcWphc7UCcQEKqR3TIHLmCJ3rsqgga8=
X-Received: by 2002:a17:903:2ecd:b0:2a5:99e9:569d with SMTP id d9443c01a7336-2a71887c84emr21725865ad.18.1768546283160;
        Thu, 15 Jan 2026 22:51:23 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dcd00sm11627485ad.65.2026.01.15.22.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 22:51:22 -0800 (PST)
Message-ID: <75807149f7de7a106db0ccda88e5d4439b94a1e7.camel@gmail.com>
Subject: Re: [PATCH] bpf/verifier: compress bpf_reg_state by using bitfields
From: Eduard Zingerman <eddyz87@gmail.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, jolsa@kernel.org,
 kpsingh@kernel.org, 	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, 	song@kernel.org, yonghong.song@linux.dev,
 yuanql9@chinatelecom.cn
Date: Thu, 15 Jan 2026 22:51:19 -0800
In-Reply-To: <20260116060735.35686-1-realwujing@gmail.com>
References: <7ffce4afdb0e859df7f0f87d170eda31b66a5b2b.camel@gmail.com>
	 <20260116060735.35686-1-realwujing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 14:07 +0800, Qiliang Yuan wrote:
> Hi Eduard,
>=20
> On Thu, Jan 15, 2026, Eduard Zingerman wrote:
> > varistat collects verifier memory usage statistics.
> > Does this change has an impact on programs generated for
> > e.g. selftests and sched_ext?
> >=20
> > In general, you posted 4 patches claiming performance improvements,
> > but non of them are supported by any measurements.
> >=20
> > P.S.
> > Is this LLM-generated?
>=20
> Thank you for the feedback. I would like to clarify that these optimizati=
ons
> are the result of a deliberate engineering effort to address specific
> performance bottlenecks in the BPF verifier. These improvements were iden=
tified
> through my personal code analysis over the past two months, though I have=
 only
> recently started submitting them to the community.
>=20
> Regarding the impact on selftests and sched_ext: I have verified these ch=
anges
> using 'veristat' against the BPF selftests. Since these optimizations tar=
get
> the core verifier engine and structural layout, they benefit any complex =
BPF
> program, including those in sched_ext. The results show a clear reduction=
 in
> verification duration (up to 56%) and peak memory usage (due to the reduc=
tion of
> struct bpf_reg_state from 112 to 104 bytes), with zero changes in the tot=
al
> instruction or state counts. This confirms that the verification logic re=
mains
> identical while resource efficiency is significantly improved.
>=20
> The specific order and context of the four patches are as follows:
>=20
> 1. bpf/verifier: implement slab cache for verifier state list
> =C2=A0=C2=A0 (https://lore.kernel.org/all/tencent_0074C23A28B59EA264C502F=
A3C9EF6622A0A@qq.com/)
> =C2=A0=C2=A0 Focuses on reducing allocation overhead. Detailed benchmark =
results added in:
> =C2=A0=C2=A0 (https://lore.kernel.org/all/tencent_9C541313B9B3C381AB950BC=
531F6C627ED05@qq.com/)

From that report:

>  arena_strsearch                 121 us               64 us              =
 -47.11%
>  bpf_loop:stack_check            747 us               469 us             =
 -37.22%
>  bpf_loop:test_prog              519 us               386 us             =
 -25.63%
>  bpf_loop:prog_null_ctx          202 us               162 us             =
 -19.80%

Instructions processed from verifier from the report:
- arena_strsearch:        20
- bpf_loop:stack_check:   64
- bpf_loop:test_prog:     325
- bpf_loop:prog_null_ctx: 22

With such sa mall number of instructions processed the results are
nothing more than a random fluke. To get more or less reasonable
impact measurements, please use 'perf' tool and use programs where
verifier needs to process tens or hundreds of thousands instructions.

> 2. bpf/verifier: compress bpf_reg_state by using bitfields
> =C2=A0=C2=A0 (https://lore.kernel.org/all/20260115144946.439069-1-realwuj=
ing@gmail.com/)
> =C2=A0=C2=A0 This is a structural memory optimization. By packing 'framen=
o', 'subreg_def',
> =C2=A0=C2=A0 and 'precise' into bitfields, we eliminated 7 bytes of paddi=
ng, reducing
> =C2=A0=C2=A0 the struct size from 112 to 104 bytes. This is a determinist=
ic memory
> =C2=A0=C2=A0 saving based on object layout, which is particularly effecti=
ve for
> =C2=A0=C2=A0 large-scale verification states.

For this optimization veristat is a reasonable tool to use, it can
track a 'mem_peak' value.

> 3. bpf/verifier: optimize ID mapping reset in states_equal
> =C2=A0=C2=A0 (https://lore.kernel.org/all/20260115150405.443581-1-realwuj=
ing@gmail.com/)
> =C2=A0=C2=A0 This is an algorithmic optimization similar to memoization. =
By tracking the
> =C2=A0=C2=A0 high-water mark of used IDs, it avoids a full 4.7KB memset i=
n every
> =C2=A0=C2=A0 states_equal() call. This reduces the complexity of resettin=
g the ID map
> =C2=A0=C2=A0 from O(MAX_SIZE) to O(ACTUAL_USED), which significantly spee=
ds up state
> =C2=A0=C2=A0 pruning during complex verification.

As I said before, this is a useful change.

> 4. bpf/verifier: optimize precision backtracking by skipping precise bits
> =C2=A0=C2=A0 (https://lore.kernel.org/all/20260115152037.449362-1-realwuj=
ing@gmail.com/)
> =C2=A0=C2=A0 Following your suggestion to refactor the logic into the cor=
e engine for
> =C2=A0=C2=A0 better coverage and clarity, I have provided a v2 version of=
 this patch here:
> =C2=A0=C2=A0 (https://lore.kernel.org/all/20260116045839.23743-1-realwuji=
ng@gmail.com/)
> =C2=A0=C2=A0 This v2 version specifically addresses your feedback by cent=
ralizing the
> =C2=A0=C2=A0 logic and includes a comprehensive performance comparison (v=
eristat results)
> =C2=A0=C2=A0 in the commit log. It reduces the complexity of redundant ba=
cktracking
> =C2=A0=C2=A0 requests from O(D) (where D is history depth) to O(1) by uti=
lizing the
> =C2=A0=C2=A0 'precise' flag to skip already-processed states.

Same as with #1: using veristat duration metric, especially for such
small programs, is not a reasonable performance analysis.

> Best regards,
>=20
> Qiliang Yuan

