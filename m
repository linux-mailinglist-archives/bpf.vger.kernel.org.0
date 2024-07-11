Return-Path: <bpf+bounces-34489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CB92DD52
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 02:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59431C216EB
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683D11C14;
	Thu, 11 Jul 2024 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW7c5ZGn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B3D372
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656958; cv=none; b=JOy46DbRKYCi55qNuJ3wOdCGXFAFRUo7W8g0/fBo9MaBVpPEhF+E0sgKxDAs/lF9mu5ts0Fu2qVmzyZ+VuqR6X2xpVulvR27G+XNssRzAph94JqU9pftMg5mB7M0vAzvaq+bEbr1oc/rAP/sYa5wBoxBpMfZeBuPg2R/ESuZhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656958; c=relaxed/simple;
	bh=5VbNaXnJZEwT02dJGf+ZSPoA1c3BUPVxjBFQg+Uxuxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CLOgQTrfSfgICYtLJLAgp8ZYi4PbLdaGWFicppOR6zKngwM3VeiwWGo2sQjBDrn8rJgRfsUj8JUjTFJUOgRwgRn+2B33H7EvPeXCMCIJHn3mA/5zxITxPXzEAstFwDWphVPCQUT7Ksvow9xTXcgDVr8KYokI3nvmPizwK8xX9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW7c5ZGn; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c694d5c5adso162861eaf.3
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720656955; x=1721261755; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UbWbdDp2y+w4+ljt/W3RaU4u0Ve2mrxMTwGpSoT2/eg=;
        b=FW7c5ZGniqtAzeK/ZlzRxoI0q1uBIiAQwZ4b+vCl3s2FP7w0L9hwrdZL24W3QFHrZk
         9pyZIu3XRcBzB8rhEC3CG3yjqvBSzPLNda8GB+iE8iZXCwbKK8ES0AYhYl4khI1j0WF1
         BotKzYRPLWxcfa1NTf2OVgwwzJ3dNa93jlXgsk+wCRI7OwrPPXiYGMp/NLg/XAQwu4Nr
         YFz+hsvQOaWXB9gG9pVLVEejBaPr/bGUKtBWTKzkBENPUuFgk0NSUyLV2wOdk0vGF3Jp
         +EZoaly2+3rBv4v15UTi1aZhJeg71tbk8J2arhY2sZGUgU4sq1y8Oeqkq52qhQk7DwtD
         R1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720656955; x=1721261755;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbWbdDp2y+w4+ljt/W3RaU4u0Ve2mrxMTwGpSoT2/eg=;
        b=bj3/4GZdlsPjBgFgmTsgK7bzpWwWdvmga4J8jHEpgPLVPqHVTY4jZXukA+MDjVFnO2
         wFEv835iKKzAQMgFScjbngLKsG4UBr0TY9ln3GOFn80qaNLSMbIyzInL+gVJl29h71+J
         qzS2xBI586+NMqWRa9t163jFwWPkBJCe6X0cSyzGntP0u/d6DFwdpdV1cwjybK2IyyAY
         VET95eMRdyphWBTzxFGnJbWsdstQVYW4nOqdALGd58hUs7Bh4GlOvihx94QjLDy7SnNb
         I/dEN0h1egImanOKt4O50CvE//284mVd5yqj9LA1fYSOaWs2Lo9qv568gtooOWstsIry
         slbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS6frf1uzE7o2tPzPI6DxBcHVNHW+G5V1nCu6RlNHck8BO4vU2swTRtV62wYO8YeXeHKDccNPighgKWx5xje+6n4M+
X-Gm-Message-State: AOJu0YwkcOOGXQY4kiGFpKEQDOjUsAO71an1Gs/knF1/nwc2rhHhW8Jo
	gI2IlrSHEAHCCN5WWqeQFNM4EaPZYdur/DnGdmens/MR6zW/4wQg
X-Google-Smtp-Source: AGHT+IFufEkfvVm6QHhBoxN8mHWE7Wgr/4OxkXN07bI44zvpLDss+vJ9fQZ7H+3McufWnXOWlgGYPw==
X-Received: by 2002:a05:6870:e2c9:b0:23d:a1d0:7334 with SMTP id 586e51a60fabf-25eae7ee4a0mr5716058fac.17.1720656955452;
        Wed, 10 Jul 2024 17:15:55 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b9555sm4369419b3a.198.2024.07.10.17.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 17:15:54 -0700 (PDT)
Message-ID: <a00ad2e4df00bab1e5ea12cf22fe32d4933a7835.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	maciej.fijalkowski@intel.com, puranjay@kernel.org, jakub@cloudflare.com, 
	pulehui@huawei.com, kernel-patches-bot@fb.com
Date: Wed, 10 Jul 2024 17:15:50 -0700
In-Reply-To: <20240623161528.68946-2-hffilwlqm@gmail.com>
References: <20240623161528.68946-1-hffilwlqm@gmail.com>
	 <20240623161528.68946-2-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 00:15 +0800, Leon Hwang wrote:
> This patch fixes a tailcall issue caused by abusing the tailcall in
> bpf2bpf feature.
>=20
> As we know, tail_call_cnt propagates by rax from caller to callee when
> to call subprog in tailcall context. But, like the following example,
> MAX_TAIL_CALL_CNT won't work because of missing tail_call_cnt
> back-propagation from callee to caller.
>=20
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> \#include "bpf_legacy.h"
>=20
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
>=20
> int count =3D 0;
>=20
> static __noinline
> int subprog_tail1(struct __sk_buff *skb)
> {
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 0;
> }
>=20
> static __noinline
> int subprog_tail2(struct __sk_buff *skb)
> {
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 0;
> }
>=20
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
> 	volatile int ret =3D 1;
>=20
> 	count++;
> 	subprog_tail1(skb);
> 	subprog_tail2(skb);
>=20
> 	return ret;
> }
>=20
> char __license[] SEC("license") =3D "GPL";
>=20
> At run time, the tail_call_cnt in entry() will be propagated to
> subprog_tail1() and subprog_tail2(). But, when the tail_call_cnt in
> subprog_tail1() updates when bpf_tail_call_static(), the tail_call_cnt
> in entry() won't be updated at the same time. As a result, in entry(),
> when tail_call_cnt in entry() is less than MAX_TAIL_CALL_CNT and
> subprog_tail1() returns because of MAX_TAIL_CALL_CNT limit,
> bpf_tail_call_static() in suprog_tail2() is able to run because the
> tail_call_cnt in subprog_tail2() propagated from entry() is less than
> MAX_TAIL_CALL_CNT.
>=20
> So, how many tailcalls are there for this case if no error happens?
>=20
> From top-down view, does it look like hierarchy layer and layer?
>=20
> With this view, there will be 2+4+8+...+2^33 =3D 2^34 - 2 =3D 17,179,869,=
182
> tailcalls for this case.
>=20
> How about there are N subprog_tail() in entry()? There will be almost
> N^34 tailcalls.
>=20
> Then, in this patch, it resolves this case on x86_64.
>=20
> In stead of propagating tail_call_cnt from caller to callee, it
> propagates its pointer, tail_call_cnt_ptr, tcc_ptr for short.
>=20
> However, where does it store tail_call_cnt?
>=20
> It stores tail_call_cnt on the stack of main prog. When tail call
> happens in subprog, it increments tail_call_cnt by tcc_ptr.
>=20
> Meanwhile, it stores tail_call_cnt_ptr on the stack of main prog, too.
>=20
> And, before jump to tail callee, it has to pop tail_call_cnt and
> tail_call_cnt_ptr.
>=20
> Then, at the prologue of subprog, it must not make rax as
> tail_call_cnt_ptr again. It has to reuse tail_call_cnt_ptr from caller.
>=20
> As a result, at run time, it has to recognize rax is tail_call_cnt or
> tail_call_cnt_ptr at prologue by:
>=20
> 1. rax is tail_call_cnt if rax is <=3D MAX_TAIL_CALL_CNT.
> 2. rax is tail_call_cnt_ptr if rax is > MAX_TAIL_CALL_CNT, because a
>    pointer won't be <=3D MAX_TAIL_CALL_CNT.
>=20
> Furthermore, when trampoline is the caller of bpf prog, which is
> tail_call_reachable, it is required to propagate rax through trampoline.
>=20
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling=
 in JIT")
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64=
 JIT")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---

Hi Leon,

Sorry for delayed response.
I've looked through this patch and the changes make sense to me.
One thing that helped to understand the gist of the changes,
was dumping jited program using bpftool and annotating it with comments:
https://gist.github.com/eddyz87/0d48da052e9d174b2bb84174295c4215
Maybe consider adding something along these lines to the patch
description?
 =20
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

