Return-Path: <bpf+bounces-77562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B47DCEB079
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 03:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C08C301B4AD
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 02:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4C51A0BF1;
	Wed, 31 Dec 2025 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTVJS14L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB247AD5A
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147420; cv=none; b=E+J/OV8bBC8rC8PgtVCufUk/4rdDGjDMu1Y/2H4E1nFg112BERTqfBC+CJ8heFRScAEFceKC05KNP5s++GW91tykVxfKsDnqa/SHepZnMi2B2kbMxo5lXptVVLW7K0wvTkFtR/cOBOU1+FbU05zKeN7rzPqaWnA2uTW2ltnguJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147420; c=relaxed/simple;
	bh=Vc5Po2GzfvAQ8XALGD/qbVhUgHjkSs6FnmUNFr5ksXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9F2IewYgotnncQehKrOK0FOq5F/BIarqodE+b0dt23z3oeTZ8nJkXxNEt3xoFEtlJebrnuNOVyxx2qTx8WQL7rSSb3ZbDp3fafpSAoz+Mf85hs7qXuQpv7NbaeNc8FzOoZ4gg3fCPDvlcRGSXa+FESgOBpfSddQwQJwpf6ZFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTVJS14L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so5221551f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 18:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147417; x=1767752217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YIh3kRt415CIMvGyHxePpkpP3PZt2RKJtwaxo1lsQQ=;
        b=RTVJS14L1ZNsB+t3xYaYCI5g9suI4pqF/jKM0pHezznVLrRzILJT+nv/RSM5ARfKUI
         J+5e8YEQ4v1DHtUpiyFaqrV2ujUMAeXl1kz65Mq4Lu+KQ63J/idd1poqPKKRsCUQtPgO
         hqkq+/aemY5XJhBbEoxMQaLLRvmt8dEeCntYfb3mKqNP7+VA345yghzRxBTAduRqvb/R
         rwsTu96MEpxZ1lmp7xArQWEMIPDGpYMWvK0pt9TTIuEXF0BOeWJ8hEE74DSbphevWYN2
         3CTsgVCvWRahuv10W9R0sL14M1fciFxrXU/JfZ1fe5vUEqpDwtyjTtTlsAdp55t6lnLo
         9A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147417; x=1767752217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1YIh3kRt415CIMvGyHxePpkpP3PZt2RKJtwaxo1lsQQ=;
        b=DCZ/isoPNIEozSyQ+vKDir79AZJ13k1nJ2rEbFifKAgV1YzjjhcltQrSld7vEMlyzz
         Uy1QDz1BV6Btfo/G15ZlOyJF5TrPGnVhRQtKyk4LjyvRgFbFkPhSpyZ2oDhgZAXmLtwO
         CSRy5sdB1F4t8XaUMTtBl4nVp+nLYD8BF2sDk0BMUIC0LjSFWJ9DaNBK+5iM+lephs3y
         0dZiHgemAc0mcoLAYWtUX/62CJJ5IQWmw79ra7RbCSWIf/zGdyKBGRnZw4sU3OxbWFa9
         4RPQ74Q6pW8I9nWc8qXn1ERJfxH8wzRbJRlcAIW12yGZ1l8h8N4WhvQz/qMEGqsCpJri
         7Wqw==
X-Gm-Message-State: AOJu0YxysXwVSaY3UnntVco1v7520q5wAldJGE7UYcwxVBFRvnn1Hbxh
	c62ihlhqVI3jac7EcXEtU38TRMKI5owDPq0ojeTFevjVFjk3KZnvTlke1pD2aBHbi/ZGDvk/AoX
	u+6kIcmysVL7wRWX6iSae+QnySiVes1A=
X-Gm-Gg: AY/fxX6THpiuWoAA++ijJseu8XBzafiiqno1umEAiY5wDHh2DMK0jOrxBlApSAZzYVc
	2/iPd59/B9nEJkGXoNWYpGohfBH/puWSg2pvjzB9wU7DuV8bdezz1y5JCFOjSWRN69p6ZpbLX5o
	EExOHs5POOpBm0Nxl2cb0oMoxzJtz26ekQXRG+tQmfzEISrG9UJGm93p1/icndUOhImxyhRhl2/
	R+Ub3OaoSHDHFhSEmkZUmwIcCmTxtWchFYb/Rx1rZAscd6PYuZ2seEyUMWAEYaWKidcORF4/gXn
	vXOsmbEeZQqGgdqJWmYkz21rPF4T
X-Google-Smtp-Source: AGHT+IHmHDYd7Vpk15n1n47/H5IivHzOkYyJY6QZ2eym01VU82AcY1Ey7t63f7p63Uz11mUvEq6NwNPrAQ3S86d75x0=
X-Received: by 2002:a05:6000:2f85:b0:432:8504:a383 with SMTP id
 ffacd0b85a97d-4328504a387mr19160237f8f.45.1767147417200; Tue, 30 Dec 2025
 18:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227081033.240336-1-xukuohai@huaweicloud.com>
 <CAADnVQKJk7pGW50JHj6tZAeHLxCbgmHBdhwZCY4NT-6MTg7=sQ@mail.gmail.com> <0c441710-5250-4706-ba81-b6b4b1277313@huaweicloud.com>
In-Reply-To: <0c441710-5250-4706-ba81-b6b4b1277313@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Dec 2025 18:16:46 -0800
X-Gm-Features: AQt7F2ps9nE6mL2YWb03Fp2EL4bFXlY2ndGinOJUCtFTIJmKActYWCpUaE7pFJE
Message-ID: <CAADnVQL6PTN2PN9ngV2PSXb=csX1KX+D-BZGzDDNtvQvtGkSkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:05=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 12/31/2025 2:20 AM, Alexei Starovoitov wrote:
> > On Fri, Dec 26, 2025 at 11:49=E2=80=AFPM Xu Kuohai <xukuohai@huaweiclou=
d.com> wrote:
> >>
> >> From: Xu Kuohai <xukuohai@huawei.com>
> >>
> >> When BTI is enabled, the indirect jump selftest triggers BTI exception=
:
> >>
> >> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> >> ...
> >> Call trace:
> >>   bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
> >>   bpf_prog_run_pin_on_cpu+0x140/0x464
> >>   bpf_prog_test_run_syscall+0x274/0x3ac
> >>   bpf_prog_test_run+0x224/0x2b0
> >>   __sys_bpf+0x4cc/0x5c8
> >>   __arm64_sys_bpf+0x7c/0x94
> >>   invoke_syscall+0x78/0x20c
> >>   el0_svc_common+0x11c/0x1c0
> >>   do_el0_svc+0x48/0x58
> >>   el0_svc+0x54/0x19c
> >>   el0t_64_sync_handler+0x84/0x12c
> >>   el0t_64_sync+0x198/0x19c
> >>
> >> This happens because no BTI instruction is generated by the JIT for
> >> indirect jump targets.
> >>
> >> Fix it by emitting BTI instruction for every possible indirect jump
> >> targets when BTI is enabled. The targets are identified by traversing
> >> all instruction arrays of jump table type used by the BPF program,
> >> since indirect jump targets can only be read from instruction arrays
> >> of jump table type.
> >
> > earlier you said:
> >
> >> As Anton noted, even though jump tables are currently the only type
> >> of instruction array, users may still create insn_arrays that are not
> >> used as jump tables. In such cases, there is no need to emit BTIs.
> >
> > yes, but it's not worth it to make this micro optimization in JIT.
> > If it's in insn_array just emit BTI unconditionally.
> > No need to do this filtering.
> >
>
> Hmm, that is what the v1 version does. Please take a look. If it=E2=80=99=
s okay,
> I=E2=80=99ll resend a rebased version.
>
> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweic=
loud.com/

I don't think you need bitmap and bpf_prog_collect_indirect_targets().
Just look up each insn in the insn_array one at a time.
It's slower, but array is sorted, so binary search should work.

