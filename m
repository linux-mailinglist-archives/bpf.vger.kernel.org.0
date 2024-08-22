Return-Path: <bpf+bounces-37809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED75695AA98
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959101F22819
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350639AFD;
	Thu, 22 Aug 2024 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3nuqNDO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988D822612
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290373; cv=none; b=KhGR4CHwz3UaCHsvRSDW/iW624rM/7mLJxpFpDv46IVXLV25RYY5OB9nE23vL4FbsW/k3Cusae5YH7lRLE4/UgeFAhF4BZ/7NdC1JFp3/ShavsZbUJ0Sp2Cb3GHSFb2jcsO41Y0Gl1MKYiUvgfG5tkrkxKfjBlUI02gFq+xN5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290373; c=relaxed/simple;
	bh=64jHa/615jinT9A5NDxM6ItSQ8H2CUOqKuNw6ZCrUvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afwHryjYjtCy4O9djqsj3vrzehxiZkzeZR1qAYWV7ksAfIcSz4OxTsWk9iZWnKs2SfOD6d9dW+pzND9L5CpFGD+VtIBzqK7VqC4pumi05tZdqiPPX0tlmFsmxh4PYLWKFP79OjNfz0/E9nAkCgfKGAeLu7Z1Dt1iFNOfN1BNIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3nuqNDO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371b098e699so122119f8f.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 18:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724290370; x=1724895170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXxAJgRK2YJCbGuqbRUestc0V76cKjn5ZMogFUBqzW4=;
        b=j3nuqNDOX+04rtsdpyL+nX8ej0RcU38CgpLugyxRswZmEEoXu8vB9MC5XX7xh69Tlv
         xlCKoy2l55vospaHSzBmDOxp2b0OhX29sUxTwD2bil6B01i/vMmpSX3NGs0wQzXNtj8X
         vK/bn65glwHwh89g7ZdbwylLfo8sk/zdxwS7xtQ9Hywi9bS8Utir6HL2N5mqTJOdg7mY
         AKhu6OC0cu32W4qlQcHK7hK5FcEEbzekp9eJDSCyDni4yoCeObx3Kqp33ngC/5Yz7QvV
         TVmZabBnXavYaMRxFfn9ujzkYi4xFAWFpRuIaCUmWfBHAGMN23M827WdDBwEceagpUL2
         U0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724290370; x=1724895170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXxAJgRK2YJCbGuqbRUestc0V76cKjn5ZMogFUBqzW4=;
        b=a2XOWRcK8/xDSLMGfyqNXf304OpK18FNwfvxCRw90GIVvGmmR9Vc2y9XlGxJgGUmab
         AvFq4VWWiOO1keowxLz9x8IWxl25bOW8wLlnGpmV0qYR5hvHbEyAmS3mL4uTp95vbLsG
         jPGSd6uy+yQrfppUeKbhggk0TkxMinXLKg8769KLfFjpnWA/qYnkJPAi8zl4ugTcuSEk
         c3jt0acWvJMEk4yJbY7k5h5SN0Hj4mj8p914ZNwMAgwOJ2o3XRr6PTY3TIHamFQXw6wz
         Gs8PRuT8+GnGpCLDr8EEcaGpdF/ecnVMhkStuBH40up3o5B+8OLijSW2qpkTT0rxMw1L
         LpzQ==
X-Gm-Message-State: AOJu0YyWpWuQ9K7l+9IunZVbvIRxA4iwBQRr01smSRrHwNAHicdQTlS3
	LFXfvR0lbM3AfOdYKWX3tFaBezfCCk9Z2dc/NqceNzOWvt5qpVYFirXNj3a1CfbFye2L1UoXIFM
	k3Vs7QbrMQDcRE5KW3oJQT7xBlwE=
X-Google-Smtp-Source: AGHT+IGFmDwC/eK1ZvpEbV6CEeAs4aoOBRcn39jIcAwAlo00wll/o3uNBWItzML+ST7ImNIFA4AOmvCGLlwuYRGwJkU=
X-Received: by 2002:adf:ef0c:0:b0:368:3f5b:2ae7 with SMTP id
 ffacd0b85a97d-37308c18e5dmr167160f8f.24.1724290369633; Wed, 21 Aug 2024
 18:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821233440.1855263-1-martin.lau@linux.dev> <20240821233440.1855263-8-martin.lau@linux.dev>
In-Reply-To: <20240821233440.1855263-8-martin.lau@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 18:32:38 -0700
Message-ID: <CAADnVQK4LUVsKQYHdaw0x9-CryA0wQX6stkvhFnNoDh1tt0jhg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: Allow pro/epilogue to call kfunc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 4:35=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> The existing prologue has been able to call bpf helper but not a kfunc.
> This patch allows the prologue/epilogue to call the kfunc.
>
> The subsystem that implements the .gen_prologue and .gen_epilogue
> can add the BPF_PSEUDO_KFUNC_CALL instruction with insn->imm
> set to the btf func_id of the kfunc call. This part is the same
> as the bpf prog loaded from the sys_bpf.

I don't understand the value of this feature, since it seems
pretty hard to use.
The module (qdisc-bpf or else) would need to do something
like patch 8/8:
+BTF_ID_LIST(st_ops_epilogue_kfunc_list)
+BTF_ID(func, bpf_kfunc_st_ops_inc10)
+BTF_ID(func, bpf_kfunc_st_ops_inc100)

just to be able to:
  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
               st_ops_epilogue_kfunc_list[0]);

So a bunch of extra work on the module side and
a bunch of work in this patch to enable such a pattern,
but what is the value?

gen_epilogue() can call arbitrary kernel function.
It doesn't have to be a helper.
kfunc-s provide calling convention conversion from bpf to native,
but the same thing is achieved by BPF_CALL_N macro.
The module can use that macro without adding an actual bpf helper
to uapi bpf.h.
Then in gen_epilogue() the extra bpf insn can use:
BPF_EMIT_CALL(module_provided_helper_that_is_not_helper)
which will use
BPF_CALL_IMM(x) ((void *)(x) - (void *)__bpf_call_base)
to populate imm.
And JITs will emit jump to that wrapper code provided by
BPF_CALL_N.

And no need for this extra complexity in the verifier and
its consumers that have to figure out (module_fd, btf_id) for
kfunc just to fit into kfunc pattern with btf_distill_func_proto().

I guess one can argue that if such kfunc is already available
to bpf prog then extra BPF_CALL_N wrapper for the same thing
is a waste of kernel text, but this patch also adds quite a bit of
kernel text. So the cost of BPF_CALL_N (which is a zero on x86)
is acceptable.

