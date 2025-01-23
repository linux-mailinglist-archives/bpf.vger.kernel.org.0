Return-Path: <bpf+bounces-49548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D75A19BAF
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 01:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F7A188D231
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 00:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545738F5A;
	Thu, 23 Jan 2025 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsARIl3c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D746B8;
	Thu, 23 Jan 2025 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591361; cv=none; b=mE3Yq2kcDaYBWPg2fbkUU76Y1AOhajKxCC+tL76bE87y49dCtG22mCnXtxxuISh8OGdyyEu9BFjAMW6ScayaZmJiAivXjgp1ILfvAksVsc6aukWyuWF2lm3Z6bZTwh1QhLNlgz7tM7A/mC3RtocvwUa6aylPkUV+UeLTqKTttKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591361; c=relaxed/simple;
	bh=ifcid8NBflYobvOzHJuhZewxSQoHwv3COGvXAU1gBJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UNvBwwUAc/OweM0vM48TFbyu5P7Iwa5viZoxzN8qEDAPKcsbticNTn9YsVnlQiq+WRWj6i5tilJ/ZfcIkUZXsW5eiqTGoUE5YH08zoIa7QAm4FbR37nSy7W/1Psli8lzZjcWVj5jYlL6zQ9RTdR+aBS0wtSdrOEaxK/5snAwlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsARIl3c; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21670dce0a7so5261875ad.1;
        Wed, 22 Jan 2025 16:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737591360; x=1738196160; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/vfXVBV/gTpKCmHJMJkdH//XgWfLaAwF+RESmuXuw8=;
        b=bsARIl3cjmg2DC8Lw6PJwGFfgmGSS8aZ8LGFIwsGgTr+AsOdYD+ItXJbKJnroUuNt3
         Tpo9Q5Gy3WfeGjU7XCVwEtGAzXA+WIUW4c2Iv0McYDTMQLIfzCpvUHzsUHJtvc2Wc3xx
         5Ammt2+13NrnkX4ibhjPkCFekU0DM/dcPeeWXfhFYdQrLka0odyBPJe++g4SgD/Z2RSr
         me99MwsQl2XwoBrEsGUGvQGFO4ug0pjLvQTscL0ltjaqz0hcO2rOjCV5zB/xGYorIhSQ
         CHB97sW8CPqGGpb0oCSVFLoi5851yX+pNf5iQELh+qTXXrimaGUvPZNtV3HAsKByo0lD
         5Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737591360; x=1738196160;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/vfXVBV/gTpKCmHJMJkdH//XgWfLaAwF+RESmuXuw8=;
        b=nL4+X/ktSS9KPa0BEmBsEUG1mrsUTPXKXCmHdWUqawcyor9qTk9bzyQbOfgDxROWDk
         t0IhSTg/b1/J1ZD9Pvl2ZfEZKapfLXvkf4goB4BIN8sAdQQ+JTD3yFV93vQ0tN7p87Zm
         CRt2hiiVTfbsOAnQt4/poG4hcs+EOxOeHIaMIE5jjH5p1/O+Z4Ey/kO/uiqQo1u/prKe
         hlxZ8S+Ugro7HC2+gtZLpaCm3cDc+dNgLfHHNM4LLGiGo6VnoiJ8ioFjFObhKOwgBoSP
         bPMl7n+uqiWWp3DPiE6k6eqAwde6Za+YPxcrCWSr7cUteL3wFl+oa56vDN6ijc4JmYvg
         UbdA==
X-Forwarded-Encrypted: i=1; AJvYcCV8sSI1FIt5d5iqkSgSUx5zih16MHE9cwLppj10iU3cdZkT7w9vE89O2YCoLVP1BDSIJhJbZZ/JISonaIvR@vger.kernel.org, AJvYcCVxbJJw5zDxe+DbhlKkun6pxRcxTJEvBxKgm7JUuYdOSwIl59duj7P/xIyAVLugts+kIxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgV2sSsmmHiDDW+yvQ+0TsSA0EsnE9uj9A0eLzzhH/jJkWTF4X
	lw3RS2Cv9qhwFZofgeYM6K3EtzqxuXrzsfJmVupzgcjy1rRbotrI
X-Gm-Gg: ASbGncui8xGXI6aXZITKd+YhzjKBhqa3jLquUOsN4rxeY0Vmaz2NAI1OMb4NpwaXkgA
	mKNIKj3hKjuZfILYXg/EsFbPt/mItw8OQgfUdSltK1vrANk0B3BOJvPnxqpSF5Lbm0mlKt+2zQM
	2ruqKjQ5alzGYdLHR2coEnI8BtpnsIpIsoTj61Tu4jApfga4WlJOezJzrE/Et/zftUC9ZV21K+y
	nPMieutMSM0m1AEYjsan9exiWKb1n5bi6JMWiq2iDk7qWz5bzyluLMnX5uTb+KsfQY=
X-Google-Smtp-Source: AGHT+IFSibg/kaRKfwUwJ3MHaKXijVprvRWoLA7Je/muZd3O+XDkJutBidtt4NENz2HGK2GLza3GBw==
X-Received: by 2002:a17:902:c941:b0:211:ce91:63ea with SMTP id d9443c01a7336-21c3540814bmr359539155ad.15.1737591359489;
        Wed, 22 Jan 2025 16:15:59 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba9a4sm100731795ad.69.2025.01.22.16.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 16:15:58 -0800 (PST)
Message-ID: <da5e61f8bd7e3e8a7c9317c023cec93219069e59.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: arraymap: Skip boundscheck during
 inlining when possible
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 22 Jan 2025 16:15:53 -0800
In-Reply-To: <7bfb3b6b1d3400d03fd9b7a7e15586c826449c71.1737433945.git.dxu@dxuuu.xyz>
References: <cover.1737433945.git.dxu@dxuuu.xyz>
	 <7bfb3b6b1d3400d03fd9b7a7e15586c826449c71.1737433945.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-20 at 21:35 -0700, Daniel Xu wrote:

[...]

Hi Daniel,

> @@ -221,11 +221,13 @@ static int array_map_gen_lookup(struct bpf_map *map=
,
> =20
>  	*insn++ =3D BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, =
value));
>  	*insn++ =3D BPF_LDX_MEM(BPF_W, ret, index, 0);
> -	if (!map->bypass_spec_v1) {
> -		*insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4);
> -		*insn++ =3D BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
> -	} else {
> -		*insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 3);
> +	if (!inbounds) {
> +		if (!map->bypass_spec_v1) {
> +			*insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4);
> +			*insn++ =3D BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
> +		} else {
> +			*insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 3);
> +		}
>  	}
> =20
>  	if (is_power_of_2(elem_size)) {

Note that below this hunk there is the following code:

	*insn++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
	*insn++ =3D BPF_MOV64_IMM(ret, 0);
	return insn - insn_buf;

This part becomes redundant after your change. E.g. here is jit
listing for an_array_with_a_32bit_constant_0_no_nullness selftest:

JITED:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
func #0:
0:	f3 0f 1e fa                         	endbr64
4:	0f 1f 44 00 00                      	nopl	(%rax,%rax)
9:	0f 1f 00                            	nopl	(%rax)
c:	55                                  	pushq	%rbp
d:	48 89 e5                            	movq	%rsp, %rbp
10:	f3 0f 1e fa                         	endbr64
14:	48 81 ec 08 00 00 00                	subq	$0x8, %rsp
1b:	31 ff                               	xorl	%edi, %edi
1d:	89 7d fc                            	movl	%edi, -0x4(%rbp)
20:	48 89 ee                            	movq	%rbp, %rsi
23:	48 83 c6 fc                         	addq	$-0x4, %rsi
27:	48 bf 00 70 58 06 81 88 ff ff       	movabsq	$-0x777ef9a79000, %rdi
31:	48 81 c7 d8 01 00 00                	addq	$0x1d8, %rdi
38:	8b 46 00                            	movl	(%rsi), %eax
3b:	48 6b c0 30                         	imulq	$0x30, %rax, %rax
3f:	48 01 f8                            	addq	%rdi, %rax
42:	eb 02                               	jmp	L0             //
44:	31 c0                               	xorl	%eax, %eax     // never execu=
ted
46:	bf 04 00 00 00                      L0:	movl	$0x4, %edi     //
4b:	89 78 00                            	movl	%edi, (%rax)
4e:	b8 04 00 00 00                      	movl	$0x4, %eax
53:	c9                                  	leave
54:	e9 22 38 50 c3                      	jmp	0xffffffffc350387b

Also note that there are __arch_x86_64 and __jited tags for selftests.
These allow to match against disassembly of the generated binary code.
(See verifier_tailcall_jit.c for an example).
I think it would be good to add a test matching jited code for this feature=
.

[...]


