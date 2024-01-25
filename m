Return-Path: <bpf+bounces-20312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EC183BC14
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 09:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF528519A
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4BB18E2E;
	Thu, 25 Jan 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BySedhPL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DA17731;
	Thu, 25 Jan 2024 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171698; cv=none; b=I8PrZNhH55TV1uQx4zQ1xWpEF2mB3ZfxKLYcWWJ2UO/2U3zl8M3QrGZwb7OgLf2X610IN660RwsbU7WbgLdsLo+5EmSMPZHvgJbknrWXHTNgROil843LutsK27DvcA591VaDW3StEmDXA7do3iWREIV4SO4nbe8C8QxVVhlv710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171698; c=relaxed/simple;
	bh=xQ3ELqXF3nkIUmMUdjf/42MCdn5UjLE2cnrQvuBnX2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siLiNR98ubOPx2jcL5dvBBlWh/3qSsDlBof7Lb6TZvWXJMwJmM7LvxOs4tAv0XpibuqkM8OfyKEYgZQFnJB5vjq2Mk5rjxtXmsMZMYzoqAn5ogyBH0AILbxLyDawVxnAXrPfKry7peFoqa4f+nWfItWrIP9Tp8Qk69H6GwAUd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BySedhPL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc372245aefso2677961276.2;
        Thu, 25 Jan 2024 00:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706171696; x=1706776496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7U7VKdIWyrhj7s7eAQrsWiZ5oaoSX60SyzCWbwjlQO0=;
        b=BySedhPLJF5ZWQpu+QrPP35CqU3k006s1dUWWy1zf7VAhKaVIf+x0GA6oe1WxKrb/m
         eJxXWPwptcf1jZCOcPKkDdwatfEe093dH7+ZxgrZwVD28hQYCexk1wl0KHbmtCgA16wc
         85eZiZ77fXS8N+RqlsJvuDeOwK271jKRZW3WmZf996F0jYhsQ2QNzEMbeDrJ2zmuBh2/
         0nXta/piOQR4q0A0z55fAZ1qivSgL1/NO6DF66e34WOB2M4cDJpTOth4Si6aDOOL7uaQ
         q4uKX5wucIYAUGT9Q8ij8CR21rKc9lEn8gCED+oSB3RSfEuEzLWF+o+kmSsOVbZqPyMs
         6aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171696; x=1706776496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7U7VKdIWyrhj7s7eAQrsWiZ5oaoSX60SyzCWbwjlQO0=;
        b=YpqLa0dIO3rv2ru8BIezSzaWld++7evnnFHzOfL5lwZppxNhGcqkXUzT+ultEWtKS4
         k2ic4wQgtFmpZVzPKDF1SR5F5JUVz60VC/aRQaSAVl8oQwLZfitbuE9WGTbNbcirI9D5
         5rRlptZu39pGyG9xsFMgteszAAqDNDPGN9sJ3Py0N2tpkiwCYOexrvy2TpGXSpTiihEG
         QyWCUjNdc5iWi9fLE1KEnMfScTlXhscGxv7IJqU9DiglxBB07yYVmvBK+Epm+HiooQa3
         u2mAduCu9imSpuyUrP3uDX+wz+d2wXasaQpQggN4r8y9R9plQ0qAOAzCYxeNli47eQwC
         tICg==
X-Gm-Message-State: AOJu0Yw6EwF65TWD11NCMjUdQg6mowHAVop8OSGnG5QqNLGn3AaqZNWr
	VR9liHb/2+x3+Lhv7A9Dd19jjXnu1hSEGjcBORmFlVyRnWNGN3WAKAK4Klwd/D19Jh1E2dgLbFI
	xteEvwhcm9+X0FaKgybLmn+8CPKz8UygzSw==
X-Google-Smtp-Source: AGHT+IE/4ow0NdqbVoY+ay5s1tDiOWK1PsDj9qa5dZ+9geKzcPOli/gpF6TyXHCqnfgNB5DZXhk5dxAJ3zEjIEKykFM=
X-Received: by 2002:a05:6902:2808:b0:dc2:5674:b408 with SMTP id
 ed8-20020a056902280800b00dc25674b408mr489570ybb.57.1706171695943; Thu, 25 Jan
 2024 00:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124103010.51408-1-sunhao.th@gmail.com> <5d33819c5f752755614882e30d971488731d97e0.camel@gmail.com>
In-Reply-To: <5d33819c5f752755614882e30d971488731d97e0.camel@gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 25 Jan 2024 09:34:44 +0100
Message-ID: <CACkBjsZjYewSh4ZHFbj-D_Z7kGOeaVLfROcEDE1beNEDn-aU-A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject pointer spill with var offset
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, andreimatei1@gmail.com, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> I tried this example as a part of selftest
> (If put to tools/testing/selftests/bpf/progs/verifier_map_ptr.c
>  could be executed using command:
>  ./test_progs -vvv -a 'verifier_map_ptr/ctx_addr_leak @unpriv'):
>
> SEC("socket")
> __failure_unpriv
> __msg_unpriv("spilling pointer with var-offset is disallowed")
> __naked void ctx_addr_leak(void)
> {
>         asm volatile (
>                 "r0 = 0;"
>                 "*(u64 *)(r10 -8) = r0;"
>                 "*(u64 *)(r10 -16) = r0;"
>                 "*(u64 *)(r10 -24) = r0;"
>                 "r6 = r1;"
>                 "r1 = 8;"
>                 "r1 /= 1;"
>                 "r1 &= 8;"
>                 "r2 = r10;"
>                 "r2 += -16;"
>                 "r2 += r1;"
>                 "*(u64 *)(r2 +0) = r6;"
>                 "r1 = %[map_hash_16b] ll;"
>                 "r2 = r10;"
>                 "r2 += -16;"
>                 "r3 = r10;"
>                 "r3 += -8;"
>                 "r4 = 0;"
>                 "call %[bpf_map_update_elem];"
>                 "r0 = *(u64 *)(r10 -8);"
>                 "exit;"
>         :
>         : __imm(bpf_map_update_elem),
>           __imm_addr(map_hash_16b)
>         : __clobber_all);
> }
>
> And see the following error message:
>
> ...
> r1 &= 8                       ; R1_w=Pscalar(smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0; 0x8))
> r2 = r10                      ; R2_w=fp0 R10=fp0
> r2 += -16                     ; R2_w=fp-16
> r2 += r1
> R2 variable stack access prohibited for !root, var_off=(0x0; 0x8) off=-16
>
> Could you please craft a selftest that checks for expected message?
> Overall the change makes sense to me.

Testing this case with test_progs/test_verifier is hard because it happens
when cpu_mitigations_off() is true, but we do not have this setup yet.
So the mentioned prog is rejected by sanitize_check_bounds() due to ptr
alu with var_off when adding it to test_progs, and loading as unpriv.

My local test was conducted: (1) booting the kernel with "mitigations=off"
so that bypass_spec_v1 is true and sanitize_check_bounds() is skipped;
(2) running the prog without the patch leaks the pointer; (3) loading the
prog with the patch applied resulting in the expected message.

