Return-Path: <bpf+bounces-37754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09DE95A461
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686E92836E9
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED971B2EEF;
	Wed, 21 Aug 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du2Thvnu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD3142631
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263642; cv=none; b=Iz7O3fnT7LEh568kGAmrSLK2I4XvOuh7B2PvOCuc1pjpx/PdM7EtvENE6WoA30b7yIlg8GVg92VrN+K5i3njA+NcmWz2bz7nRE4q2RsYDRK1YcF94RxKSsn0Nn6ZzEfVsj6VW8OGRU6mXbh3uWJjjaqd8Zcdtu+eSK3FgV/lCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263642; c=relaxed/simple;
	bh=sEIdO832eaqUJptn3j6gJGZGtmC24tPmqWbUj+w2qTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPL/jGbj7MwKr/YZ8rCtiEn8lZ784tqx3YJ6ma7te0Vln3YAFTwTkBZ9ToM/izpC1gj6JdWtWrjYK6iaZm2rrojFZObmei42N2yL6eYsVQTzdStsdOPDr7+AxKYdkdyFmJzur/qz+4Av5KJRKL38PznbUt/DeBdz7zKd7NHIp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du2Thvnu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42ab97465c8so17941855e9.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724263639; x=1724868439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ2ZwDIpwI5bCvVQPQETUFOwOlK1w1eb1+zLkjfKsMA=;
        b=du2ThvnuSDDgEIlEeMz+qo/B7QCDZ6En0nSg9KUlXF+/YNNlvbO/Ws1OSOu5bz1jR2
         4dUy8MVT/kfKAleP/4yvGM4hur8ygOqR/7NCf0HofzRDcfJWYmfbmOS25Et5Wbk1ZCZG
         443oLKhL0Y7JlXwl6e4+DvKkblIXCPgEnlwiSTLNfnvz87snFhI9xcjqIToKd+fqjoLU
         +J3EyCG+2FAVVa8xihCOkF2LfCzMQvVFiGzmjG1X/KqfzA+6eP+lbTCxCd7bVX9Ev5Sl
         LHvGbdfNG2NuoBXet0h2QT3m/LJNqt7jlwBFsrBf1e/mXTQ5FwxnWsF2w8Ar3yYiexB3
         tUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724263639; x=1724868439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZ2ZwDIpwI5bCvVQPQETUFOwOlK1w1eb1+zLkjfKsMA=;
        b=g5ORP+2j9NgaAR6JVuql56Vtlw9c9hkhbt5ScyYnRyavNpLtK0bwopWk1bECUdsVY0
         nnWonbEIoEsdqODkYFut+m818zY2oHbyWB51X8wZtIdwZOJ9k7aQ1l96ZB56HTJjNlVf
         ewNMuJZ0CORZCiRxs12vAVmk+ddK/w507iR1EZH3TA1KULvN/D129jenD0oz/lN240W1
         WVcgW/+YMQQb4I2EBqOGsTE7v0HXqnLPYvMQss1c5i3ubFYczprof5tiyhrI8PpuF5d0
         i2WiGPqpnvackEQkjQBnVjkrrufff/NxhmsGmNrrr6iSTuR8kluL13ChnioEEvV9Kqx6
         Xf3g==
X-Gm-Message-State: AOJu0Yx//LgKG4xTg1k1BOuQ1Xm09tQv7FjoUmcSiU++n8Z40Hs0gt2k
	liDgD0WgiymRLp/fGlqnCs3SY95s1o1bI4r8aNChuJf981nJQ0JdOfOidw8s0sr/FqkdCyfXdUO
	6KxMY8OIH+VuQ8AsH5l7nbbOZwlQ=
X-Google-Smtp-Source: AGHT+IGxKTBnGabP6Qt7k59pSwMror/NS7XAtG5zNo+vX8QtB6jYo+b8wJT2AcY1URBVoBu4fv3/v6rkfSrM7Eni2xk=
X-Received: by 2002:a05:600c:3d8f:b0:426:6ed2:6130 with SMTP id
 5b1f17b1804b1-42abf050ffemr19670675e9.14.1724263638452; Wed, 21 Aug 2024
 11:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820102357.3372779-1-eddyz87@gmail.com> <20240820102357.3372779-6-eddyz87@gmail.com>
In-Reply-To: <20240820102357.3372779-6-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 11:07:07 -0700
Message-ID: <CAADnVQLJNDB9XKVAiMMTdB+YPrb8FO-CbHp4cx_Pd_Nk9ri0JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/8] selftests/bpf: utility function to get
 program disassembly after jit
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> +
> +struct local_labels {
> +       bool print_phase;
> +       __u32 prog_len;
> +       __u32 cnt;
> +       __u32 pcs[MAX_LOCAL_LABELS];
> +       char names[MAX_LOCAL_LABELS][4];
> +};
> +
> +static const char *lookup_symbol(void *data, uint64_t ref_value, uint64_=
t *ref_type,
> +                                uint64_t ref_pc, const char **ref_name)
> +{
> +       struct local_labels *labels =3D data;
> +       uint64_t type =3D *ref_type;
> +       int i;
> +
> +       *ref_type =3D LLVMDisassembler_ReferenceType_InOut_None;
> +       *ref_name =3D NULL;
> +       if (type !=3D LLVMDisassembler_ReferenceType_In_Branch)
> +               return NULL;
> +       /* Depending on labels->print_phase either discover local labels =
or
> +        * return a name assigned with local jump target:
> +        * - if print_phase is true and ref_value is in labels->pcs,
> +        *   return corresponding labels->name.
> +        * - if print_phase is false, save program-local jump targets
> +        *   in labels->pcs;
> +        */
> +       if (labels->print_phase) {
> +               for (i =3D 0; i < labels->cnt; ++i)
> +                       if (labels->pcs[i] =3D=3D ref_value)
> +                               return labels->names[i];
> +       } else {
> +               if (labels->cnt < MAX_LOCAL_LABELS && ref_value < labels-=
>prog_len)
> +                       labels->pcs[labels->cnt++] =3D ref_value;
> +       }
> +       return NULL;
> +}

bpftool should probably adopt similar logic
just to be consistent?


> +
> +static int disasm_insn(LLVMDisasmContextRef ctx, uint8_t *image, __u32 l=
en, __u32 pc,
> +                      char *buf, __u32 buf_sz)
> +{
> +       int i, cnt;
> +
> +       cnt =3D LLVMDisasmInstruction(ctx, image + pc, len - pc, pc,
> +                                   buf, buf_sz);
> +       if (cnt > 0)
> +               return cnt;
> +       PRINT_FAIL("Can't disasm instruction at offset %d:", pc);
> +       for (i =3D 0; i < 16 && pc + i < len; ++i)
> +               printf(" %02x", image[pc + i]);
> +       printf("\n");
> +       return -EINVAL;
> +}
> +
> +static int cmp_u32(const void *_a, const void *_b)
> +{
> +       __u32 a =3D *(__u32 *)_a;
> +       __u32 b =3D *(__u32 *)_b;
> +
> +       if (a < b)
> +               return -1;
> +       if (a > b)
> +               return 1;
> +       return 0;
> +}
> +
> +static int disasm_one_func(FILE *text_out, uint8_t *image, __u32 len)
> +{
> +       char *label, *colon, *triple =3D NULL;
> +       LLVMDisasmContextRef ctx =3D NULL;
> +       struct local_labels labels =3D {};
> +       __u32 *label_pc, pc;
> +       int i, cnt, err =3D 0;
> +       char buf[64];
> +
> +       triple =3D LLVMGetDefaultTargetTriple();
> +       ctx =3D LLVMCreateDisasm(triple, &labels, 0, NULL, lookup_symbol)=
;
> +       if (!ASSERT_OK_PTR(ctx, "LLVMCreateDisasm")) {
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       cnt =3D LLVMSetDisasmOptions(ctx, LLVMDisassembler_Option_PrintIm=
mHex);
> +       if (!ASSERT_EQ(cnt, 1, "LLVMSetDisasmOptions")) {
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* discover labels */
> +       labels.prog_len =3D len;
> +       pc =3D 0;
> +       while (pc < len) {
> +               cnt =3D disasm_insn(ctx, image, len, pc, buf, 1);
> +               if (cnt < 0) {
> +                       err =3D cnt;
> +                       goto out;
> +               }
> +               pc +=3D cnt;
> +       }
> +       qsort(labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);
> +       for (i =3D 0; i < labels.cnt; ++i)
> +               /* use (i % 100) to avoid format truncation warning */
> +               snprintf(labels.names[i], sizeof(labels.names[i]), "L%d",=
 i % 100);

100 here and names[..][4] are a bit of magic.
Pls add some #define and comments to clarify in the follow up.

Overall it looks to be a great improvement to selftests.
Applied.

Pls add necessary packages to bpf CI.

