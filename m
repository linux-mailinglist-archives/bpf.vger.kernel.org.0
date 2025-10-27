Return-Path: <bpf+bounces-72409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C3C120F7
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185E93B6671
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F6D330336;
	Mon, 27 Oct 2025 23:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGW/0Alx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5733032B
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607527; cv=none; b=VNIt/E0B1b/2qDmrt0JKdbMb/I8vHc+X1z6u1bQHg3HkXYuD+heFlJona5V6Ygba2C2KQSSxKsNhTjpQ5/2loDIcej52Ed1XSgZlxnbwkJ+C/MhCi8CvMd+NOZjxl7hX000gevWMEgdOsDBA98ZiPSJIw5JQWAY0+E8SHHj7DoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607527; c=relaxed/simple;
	bh=Y4ZIT1f91iBGmk4xRx86A+l5fibNVm2gp3l6/wOO7k8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nFdt8w6ey4gSKuKNZBlNiNRC4+puVExDlAVQtJvt83zO6RvzkQxziO9p1QwL2w3qdn1zAV0X16z+HFzN1Q8m3UAjUQqyxU6Trsw9vPEBA8nhQ5/tZ28qVhtDox9AyJwpz2lXCl/Zyn4vgmNwPyINl56fim1Hj8hDyLGtj7Q/BYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGW/0Alx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cf257f325so4261005a12.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 16:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761607526; x=1762212326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CRBA81blJCxBwppAcPVtTVmJUk5RcmdCStnriHugR84=;
        b=YGW/0AlxRL8z4qxElB5SUAeihVwT4293NQ5XrPgAvHy7RQKaCZgNCuRdL/5NaUDNYk
         iKS4niI+vLPPegc8/ZEYvx0RgryqvvG59xS7Vu0/Z1PBANGDSIcRhMtJpK6xzWa2KJOh
         2YtWSlAOELo4aNSETWs1DEAWD4CKM5aPmwNWUhVpoXQmxq0NfvkExnJ5kTwqhkWHFOVY
         EhPcofrkZBpnrAvw9rlM1fPcaLpxSU+W493X1aF3O6WhOhl4V8wWzbil9XNutqUKnfxq
         F/K6IoXosrwOPwjdluxtQdH7Lf5ipy6HCtjSkBekvdHmk76QXTPpDcMc+Xjc/0tr6r8W
         9Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607526; x=1762212326;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRBA81blJCxBwppAcPVtTVmJUk5RcmdCStnriHugR84=;
        b=I0/ZZXLOX8Yj3XUQ2V/Y1b/RbEhPHnt+MBgDrreLfqZMhSJ5tZAhpGbN0G992cELDM
         ox1PrfzsMV1DZiEUl0sLZpuWqZqcD2WJEzdp80sPLDIOjKs1b6rgki8jTKdme6p/HENk
         eXcE8R6EXK1DP6u+eDtXzIAA4mBZyMLnopSnfzoNPTwnlcdJ7rpTksH99WsXCuH4E15c
         DmeWu+aQoWnzOsqI3WIWMQgnntxRXe7vBDQ+g7ZIHnwhmPKQsvkG/NGl3zuVM0VRJt/s
         86e3MUsn7Ee7F+ywSVOXSgD+BRG6g/b33ully4QlTJZIDuOef2zu0G6AMNzF5gRJBLAu
         KYgA==
X-Gm-Message-State: AOJu0Ywt6FQ8Q6N1LV6+kLyvaD3HZsQF/SaKTIRrY9xFc8lhXlrfsXN/
	KO7fAtxJw4ixwcBIhCiGAwLTFdlZfxHoDAlu2JXhEapUaRhPfveY3iZU
X-Gm-Gg: ASbGncutC8rBQvUzzEfJUNmI1zaK18DZFcVz7jq/oHn09ALTWUs6T63CqHkZNf9CjXu
	GTSRCaGE2epDQZpcM8ptytccYvvfr5iLn5ug0XMl3mm5aDTl3wSdwphoVoOc8SQE6PWyYbJd+Z9
	+7cDyaS6uju8uQeZuzjm6zuo92i6NS1KXQjdiVF6UyMu9hvN5hwHfbUdKNun5w1FdX6GzoDr6o6
	3iA1M4+ttyLDJEfT9/nSMvgGGkJvb6TKeZ7slscLYbAiwQMvCywWPKoxeCANt1nmvJLdKvLqyYK
	SlPAlCY7fN7QtXEUtOqB4ebgU50fIVfo1atAzpF0xZnho5SgvtO+f/O8/jYLSBH7Tsah0x0TQqR
	uaEgR6H3ArVbe6arMgFvaXCzLPyRnmxiemKrJ9r6Liy/neN1yDCF5+fs4IPdAN95HdWqoW5US++
	LsEWSfRoIo
X-Google-Smtp-Source: AGHT+IFyhdjqxFKnqBmfgaRmFiaHsDNZBChJnlGiMfaji+FGBBeDydWBN99s3XB/nYOiuh1VVCKbew==
X-Received: by 2002:a17:902:d4c7:b0:262:cd8c:bfa8 with SMTP id d9443c01a7336-294cb525612mr15801485ad.34.1761607525311;
        Mon, 27 Oct 2025 16:25:25 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d22ea8sm94590015ad.45.2025.10.27.16.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:25:25 -0700 (PDT)
Message-ID: <ee2274f3293eb82c3c4671de8cefcbf6d679c0b3.camel@gmail.com>
Subject: Re: [PATCH v7 bpf-next 12/12] selftests/bpf: add C-level selftests
 for indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Anton Protopopov
	 <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
Date: Mon, 27 Oct 2025 16:25:22 -0700
In-Reply-To: <20251026192709.1964787-13-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
	 <20251026192709.1964787-13-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-26 at 19:27 +0000, Anton Protopopov wrote:
> Add C-level selftests for indirect jumps to validate LLVM and libbpf
> functionality. The tests are intentionally disabled, to be run
> locally by developers, but will not make the CI red.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

[...]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testin=
g/selftests/bpf/progs/bpf_gotox.c
> new file mode 100644
> index 000000000000..3c8ee363bda1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
> @@ -0,0 +1,402 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_misc.h"
> +
> +/* Disable tests for now, as CI runs with LLVM-20 */
> +#if 0

Yonghong,

I think we need the following thing in LLVM:

  diff --git a/clang/lib/Basic/Targets/BPF.cpp b/clang/lib/Basic/Targets/BP=
F.cpp
  index 0411bcca5178..8de1083d758c 100644
  --- a/clang/lib/Basic/Targets/BPF.cpp
  +++ b/clang/lib/Basic/Targets/BPF.cpp
  @@ -75,6 +75,7 @@ void BPFTargetInfo::getTargetDefines(const LangOptions =
&Opts,
       Builder.defineMacro("__BPF_FEATURE_GOTOL");
       Builder.defineMacro("__BPF_FEATURE_ST");
       Builder.defineMacro("__BPF_FEATURE_LOAD_ACQ_STORE_REL");
  +    Builder.defineMacro("__BPF_FEATURE_GOTOX");
     }
   }

Then, Anton will be able to use it in order to decide if to skip the
tests, wdyt?

> +__u64 in_user;
> +__u64 ret_user;
> +
> +struct simple_ctx {
> +	__u64 x;
> +};
> +
> +__u64 some_var;
> +
> +/*
> + * This function adds code which will be replaced by a different
> + * number of instructions by the verifier. This adds additional
> + * stress on testing the insn_array maps corresponding to indirect jumps=
.
> + */
> +static __always_inline void adjust_insns(__u64 x)
> +{
> +	some_var ^=3D x + bpf_jiffies64();
> +}
> +
> +SEC("syscall")
> +int simple_test(struct simple_ctx *ctx)
> +{
> +	switch (ctx->x) {
> +	case 0:
> +		adjust_insns(ctx->x + 1);
> +		ret_user =3D 2;
> +		break;

[...]

