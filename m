Return-Path: <bpf+bounces-76385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A71CB1E0F
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 05:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C94A3005F0D
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 04:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1B30FF28;
	Wed, 10 Dec 2025 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVVtBe/+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF080275844
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765339859; cv=none; b=IHj0Iiw6HibihTsCkHiT6Tc+jXZPB8XwWRgz+VpD7JvkCPtya5t6/n9YBtaSJgoUKBrp/8LVQGBjZ98mKgP0FEILDT1W5KqazjbVDsON598JE9oOygHxVLVFtwCHYodqIgkkzTdrCAf6OlWeLLrE4KuncOcfw3cdK7+ATYyqtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765339859; c=relaxed/simple;
	bh=6izA038pvJwAGbYN7aai9+uLFOQlBe5zqjx8SpzOhos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvveJ4eYOIpZVoakKj1L8cNuo07Edx3By5YMBgh+T2AxfjWmC4uUMohALB03jWeMP72aMF2akyr3xObHRV/Spd2FVyybKoLeSD6QAFh7xQ2lyHDXrKtO/xSrFmLcLnDSmVWIFGYVkoHlAZpxQHYHNLBtSx1CRGPPlKQqSp2siPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVVtBe/+; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3f5ba2fc0d1so236315fac.3
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 20:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765339857; x=1765944657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05Ohqymv64sYflY2wosqKmDxhcq182Tz+w0uCWFRgjg=;
        b=TVVtBe/+JDF/Yc5a+sOWHpjfs0euJnl24/ygeNgcLJjp/iERBCNEINGu7h7MzwjrER
         NokVKscZ8I6Re0uXDv2gJuq3m2OC3C9hyBnTJclpKfxg2M4HJXgAEXwD3ZstuZbWIas6
         YWGko3ruBFa0L98iqdTqTDyZQDRQ1a6/+5vxfgIeLmIrpmTFhzjQO2ndaz9cbRF6D+UZ
         iQwX+BqljBgFqP7/e65TxXeYxmsKXB+dANaJYXuseczVDYGysbcKAziuQufe4bEbTV/V
         IrOpjbgtOgoNxqAAvYD38NqYXQBiZWSGgMVX4rB/2g6ETTM7NWhKZObbABhHVszQ/rZm
         jLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765339857; x=1765944657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05Ohqymv64sYflY2wosqKmDxhcq182Tz+w0uCWFRgjg=;
        b=sqjxQXxSGpZ0r83uRTUWrnVBshPafQ1gSXO2EjGgfsi/py4oB/AW+ATRIjowZkvJOn
         e9DMdFJN9VlCoiOReLUWcxm2K5yOYFu16HmxOtzwgPaq3aKAaiCIKqSkRdUNDxvX0TpE
         p/dIhlO23bh9EtaSAFZRDLbsPnFPaNRzsNhOYBcpRUjTBGvzndNsXUx2m8WojCxj7th9
         Q7rbe4FJkl4h9yab2QfgMPzhpUqB4KY37mmZzJKr+iVnhVppPFvvTQ93XHMp03U+v5Td
         vhxPLPR9/NKReu9wb3nZhZLe7GVXQ0hmw9QJbl3GwTCkj4XfTC57EQOHlwAa7S+FJid3
         Kc9w==
X-Forwarded-Encrypted: i=1; AJvYcCWv44L5HD+8o3EH9zLU2ujQSzAZ1zeVUNrkMhp/8ef9cVcwWGSlfyIZgUSaDPd1c2Aqhfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0lPNgMu4WSv7QZN/9CoAJkQGol4Qx+LHZ+4nQCxVu/+5j3UA
	1D6haysYxjR2/jwkejIoT0w7HoTfe3VTc/Iw9fFdpxztNmVTQKRTt9AJ7LmBhzvAa67/WVssOOf
	Q50Mc2yEnT+Nt5oQfP6swDBaRI1TqvEU=
X-Gm-Gg: AY/fxX4v8T62GwC1/a32cYqPMjB1PWrAQzhYNqgy2UTG61WIDnOnHSwF/O/VwoMjxYX
	imIfUIHr1T5tvDqPJ93XtS+HN3nXB6zfwxWuRwQEFMhH5krJFKq09kDZxmnlRIGVZm3lHz1dona
	hBtAdDB/vKnrN9ZJhmN1PSro1RFLjJthVomoNlAMxM8D+cU0RgtpNlzJigrNK+6oVmAV3m0v5qH
	L8sMHdU12baujUDt0uC4PFj8C/XIVROWhsEi04f7tzaJmSjpEL43sW3EBkHs+YSXlQcZEQ=
X-Google-Smtp-Source: AGHT+IGvOLDqAi48Ic3hLyhgd6qi1EOL/WncW14U+ZY1gmlw5gMPVtA35JKcJhsvPKHOF5Aj4Aldqg/Qvbp9osvrMbI=
X-Received: by 2002:a05:6870:4119:b0:3f5:c07b:d966 with SMTP id
 586e51a60fabf-3f5c07be927mr399166fac.53.1765339856939; Tue, 09 Dec 2025
 20:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209093405.1309253-1-duanchenghao@kylinos.cn>
In-Reply-To: <20251209093405.1309253-1-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 10 Dec 2025 12:10:46 +0800
X-Gm-Features: AQt7F2qjEPNMQoDRmcyfVJ5v3fPjMhCIxLEuMdBBnWdI885YUD2fmrUaJr90nW8
Message-ID: <CAEyhmHSPQLd2ivmzcNxDcKJW8143HLi_=syo_8iBPSxWE35pog@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Fix the failure issue of the module_attach test case
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: yangtiezhu@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name, 
	zhangtianyang@loongson.cn, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, guodongtai@kylinos.cn, 
	youling.tang@linux.dev, jianghaoran@kylinos.cn, vincent.mc.li@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One minor question, I wonder how you debug these issues ?

On Tue, Dec 9, 2025 at 5:34=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
>
> The following test cases under the tools/testing/selftests/bpf/
> directory have passed the test=EF=BC=9A
>
> ./test_progs -t module_attach
> ./test_progs -t module_fentry_shadow
> ./test_progs -t subprogs
> ./test_progs -t subprogs_extable
> ./test_progs -t tailcalls
> ./test_progs -t struct_ops -d struct_ops_multi_pages
> ./test_progs -t fexit_bpf2bpf
> ./test_progs -t fexit_stress
> ./test_progs -t module_fentry_shadow
> ./test_progs -t fentry_test/fentry
> ./test_progs -t fexit_test/fexit
> ./test_progs -t fentry_fexit
> ./test_progs -t modify_return
> ./test_progs -t fexit_sleep
> ./test_progs -t test_overhead
> ./test_progs -t trampoline_count
>
> Chenghao Duan (2):
>   LoongArch: Modify the jump logic of the trampoline
>   LoongArch: BPF: Enable BPF exception fixup for specific ADE subcode
>
>  arch/loongarch/kernel/mcount_dyn.S          | 14 +++++---
>  arch/loongarch/kernel/traps.c               |  7 +++-
>  arch/loongarch/net/bpf_jit.c                | 37 +++++++++++++++------
>  samples/ftrace/ftrace-direct-modify.c       |  8 ++---
>  samples/ftrace/ftrace-direct-multi-modify.c |  8 ++---
>  samples/ftrace/ftrace-direct-multi.c        |  4 +--
>  samples/ftrace/ftrace-direct-too.c          |  4 +--
>  samples/ftrace/ftrace-direct.c              |  4 +--
>  8 files changed, 56 insertions(+), 30 deletions(-)
>
> --
> 2.25.1
>

