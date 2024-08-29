Return-Path: <bpf+bounces-38341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972BD96382D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 04:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF881C21B2C
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915482C18C;
	Thu, 29 Aug 2024 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDTgd+r4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C72BAEB
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898384; cv=none; b=la17xJ3g5sPfJIEh8pan0ZvHvqDdOT8Lv6gXmtLhi3V65NzuqtXeutwB5whZH/3dvxUZ5ASrvNf8YqKGU+VkjxN+56XWlsxEQD3A9wyYffYWr7GfjVFKkdGduJnykewOF07BZ6Zy+DJf1bue71M7VJ7hbdHgioyNyztX6ZNVKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898384; c=relaxed/simple;
	bh=PANC9sdD+EsiXNhGOa/RMdacnN/JZ2LkbFqGvxKkMsE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZfTaROwgC2jtAXkqErgiPoAjKvg0mGA7OXjGyMsy9YwZSrZv7NtG8i6Oy/KceARYJB6TCdLmrlTFoyoh/4eOtqr+IiziKge0f5QCjPhluJ04Oa4/fiGZzPkOhpIhsW2afGp5kaJmaHgoP5xSRDv+WO5kFLY9Kodq9RZgj2OihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDTgd+r4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6e7b121be30so66876a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 19:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724898382; x=1725503182; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5V/fVRRun1ZFxlqmIudZ7Gb/3wiOZjt2NLZeGDgUmk=;
        b=GDTgd+r4h/A9+jEEL3hKFkMp4srzVjv4vlp5SaNR11JCngXtMwRFlouH75Pz6UhgNF
         X6QOAxlmU68uHYh7CdWe0q23HwiG1sQDLfJXezKJrBOoglRNg1EKUFK0cc/hR1iKyqXc
         grX43sp5Zkqr6Bv/CXB34jQH45+tmkAcR3X1H1DCz4tthT4V3EK+pCet7Mi2FSE+4PHU
         /eJXTpxOFQR50Cp9mKsd+BysTxNNr8tfiPZR5GZaBXY7hEeotT/XfJCm5L19h1y9QVnG
         phN2Apj/axorsBtLPmaMwOjN553J1j9TzSP8XQQEcxtOPRgHDmeSS7W15nMeKSZeMQvl
         fJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724898382; x=1725503182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5V/fVRRun1ZFxlqmIudZ7Gb/3wiOZjt2NLZeGDgUmk=;
        b=rtTIGAusx0pWzqhgBkLbxEqOAbzP0iHtTUJsKIXq4YMLTdBLJ91NJGKy6YsXpZ7oQe
         0NUTRWmBXW3rFoIvF/m+eG+7mh4V12jopYCs5jfB27H0bxsbdF+L4KpelRfusXq4R+OR
         4ybcv4D5VeCPn24AnOxKWCA01UVExEUTgIUqWsA4xUAnu3+c5DK2D01KpYcDRXZ7vOBE
         KJvT1rp1d1hTjX8z0WUsO0nNzlVJ4NDj4cGCHBpON/nzgpVRvfO2TF0yqBzh3lbQtfRs
         XLhvd/yXKNBVNlhhaYhlhzlrGUr2peIcDn5NZ7imo6No0sM8zvbcFz4zB8em4pK5lsBl
         ki8A==
X-Forwarded-Encrypted: i=1; AJvYcCV5DZFJmF1+KI84t9gJKKJk26k1NVKjSxHIukWfVGy2kpEPbIyVoj9ClWnGqDQeQfe+6UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwukjbDzd7B/0nOrkVOCRU4Six0ZNLoLlaVYZ6Hchq977h/GV5/
	6bttUKeS9O5SIAvQp/j9ic//HAcxwZDasFRgOAshxIodqSu0doYw
X-Google-Smtp-Source: AGHT+IHSQafmRGBIOttA5JOOypzLcKP/Q3R8itKwUmkCeC5QQ79N2UkzzEWQYu8DCuWyYk9LhBMWlg==
X-Received: by 2002:a05:6a21:58d:b0:1cc:dd01:ba54 with SMTP id adf61e73a8af0-1cce101a85amr1206546637.26.1724898381795;
        Wed, 28 Aug 2024 19:26:21 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d844617379sm2682923a91.29.2024.08.28.19.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 19:26:21 -0700 (PDT)
Message-ID: <306399911fc4b6241ac6fac7a36eb564210eee15.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/9] bpf: Add gen_epilogue to
 bpf_verifier_ops
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 28 Aug 2024 19:26:16 -0700
In-Reply-To: <20240827194834.1423815-4-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
	 <20240827194834.1423815-4-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> This patch adds a .gen_epilogue to the bpf_verifier_ops. It is similar
> to the existing .gen_prologue. Instead of allowing a subsystem
> to run code at the beginning of a bpf prog, it allows the subsystem
> to run code just before the bpf prog exit.
>=20
> One of the use case is to allow the upcoming bpf qdisc to ensure that
> the skb->dev is the same as the qdisc->dev_queue->dev. The bpf qdisc
> struct_ops implementation could either fix it up or drop the skb.
> Another use case could be in bpf_tcp_ca.c to enforce snd_cwnd
> has sane value (e.g. non zero).
>=20
> The epilogue can do the useful thing (like checking skb->dev) if it
> can access the bpf prog's ctx. Unlike prologue, r1 may not hold the
> ctx pointer. This patch saves the r1 in the stack if the .gen_epilogue
> has returned some instructions in the "epilogue_buf".
>=20
> The existing .gen_prologue is done in convert_ctx_accesses().
> The new .gen_epilogue is done in the convert_ctx_accesses() also.
> When it sees the (BPF_JMP | BPF_EXIT) instruction, it will be patched
> with the earlier generated "epilogue_buf". The epilogue patching is
> only done for the main prog.
>=20
> Only one epilogue will be patched to the main program. When the
> bpf prog has multiple BPF_EXIT instructions, a BPF_JA is used
> to goto the earlier patched epilogue. Majority of the archs
> support (BPF_JMP32 | BPF_JA): x86, arm, s390, risv64, loongarch,
> powerpc and arc. This patch keeps it simple and always
> use (BPF_JMP32 | BPF_JA).
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -19740,6 +19764,26 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
>  			insn->code =3D BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
>  			env->prog->aux->num_exentries++;
>  			continue;
> +		} else if (insn->code =3D=3D (BPF_JMP | BPF_EXIT) &&
> +			   epilogue_cnt &&
> +			   i + delta < subprogs[1].start) {
> +			/* Generate epilogue for the main prog */
> +			if (epilogue_idx) {
> +				/* jump back to the earlier generated epilogue */
> +				insn_buf[0] =3D BPF_JMP32_IMM(BPF_JA, 0,
> +							    epilogue_idx - i - delta - 1, 0);

Nit: maybe add BPF_GOTOL macro or mention that this is a 'gotol' instructio=
n in the comment?
     (this is how it is called in llvm).

> +				cnt =3D 1;
> +			} else {
> +				memcpy(insn_buf, epilogue_buf,
> +				       epilogue_cnt * sizeof(*epilogue_buf));
> +				cnt =3D epilogue_cnt;
> +				/* epilogue_idx cannot be 0. It must have at
> +				 * least one ctx ptr saving insn before the
> +				 * epilogue.
> +				 */
> +				 epilogue_idx =3D i + delta;
> +			}
> +			goto patch_insn_buf;
>  		} else {
>  			continue;
>  		}

[...]


