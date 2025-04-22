Return-Path: <bpf+bounces-56358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888BA95A4C
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F85D3B58A8
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250EE1632D7;
	Tue, 22 Apr 2025 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq++VrVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117D125DF;
	Tue, 22 Apr 2025 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745283961; cv=none; b=l03gSAdT89Bx2H43H4W+o0S33kSNBVKxCtzet/Ltz4njIlErwm2AX8hIyT9n400HMU6tltivycMOfJyKHhZZJuMun/uDVMxfXlmPGvlRFLOfbNvcJ6vpmvW1rcy1A2qwFLGpmaVv2U/E6Fe2YdQfG4MPvCCAEE6SlTiR0gQMlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745283961; c=relaxed/simple;
	bh=pzlIxYXw3dVCJk2xnhZd2Z19X3NxTLuQqOl6007Ve48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2cKSvjz335jt4jfo9fsSYlkQZVjbIyq6bp/89OmczymgDmiYxZ1X8YmR9+ISiIwHPegcuvu7BHfq/vQB8Zmk1q1ujFnaMgG0Zi0G126feR44dbnS2d7sTe98wjMyegtXDrv9l0VAyVRqLu8ZlfW25U0LtGyky9+qaX9o1sT3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq++VrVN; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ac345bd8e13so660002766b.0;
        Mon, 21 Apr 2025 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745283958; x=1745888758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3M7sAfGBAOV8eDt/hvtRBXRPqMNgvzCNV7GeaqWBh1I=;
        b=kq++VrVNNS5bRRBXDEA8QD8+i6F46QHSdnosBlZh0Llidh4xIvSHFLd+CLZqAGJPA7
         oUKwnJKhjS4C5Efb/d+vVCYUv8JHfobN3cdaaLJ7Rm6h4pfM8XXszNgVhqWs/Lt5Dwqk
         L6hlB5OyBReEVrTCZqlWc0d4OmNsvqzMIQ04A+JpDut5OSQkMoWhqNKkP8GjT9hiybUj
         WJCSLlQzIHnOe0XntEVhFcssp7TQLr9ya2xWtOgPvoKhI3avQx0+cJd4pReOezBkCZiY
         VYJ0fw/0GutReJ6G0JF0BFfZW0lpv4voI4gMXGuIoteCE50tjeIPXNANEUiW1lE2UlcF
         OdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745283958; x=1745888758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3M7sAfGBAOV8eDt/hvtRBXRPqMNgvzCNV7GeaqWBh1I=;
        b=BNhyh6/wUF3B9k+nc0GMAn4yVnGNvwNilHWzyKXof/C8W/THOvg0EGo59MS0BiPaMA
         obI020GjJRY0RsFBZRkdHyqgc1qYC2BP+QVs4EQPdx/RbPKmtNsC9xo2/TPVmmzWqxYo
         TsTBh1fva/raQ0IYeuGeVQLOVyYDovX28fPiQ2Qg8yM4vMYcmO1jTeISlaSkMTwqopvD
         5/RQ2YGF0v8pPzo60PfwDsINmgxFZ0GRfCGPOUAgzxy/QbygHZWuBMcBtJhT47JW1x6i
         +fs0VI9wmxDWULEaksi9rcN/y/GQp3nA8ibNZoBoHI/4Yk+jOWk8j9j+ykaXJXweNJK5
         hY4A==
X-Forwarded-Encrypted: i=1; AJvYcCVu7AfSOooVkGpJDkPTkXZixPf6Q2nxhgcBJrN6XorGsk5W/lR0D1WU7kYUFklpiKn1J4MqPDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0R0/taIk0Ze8njvvuCZw4h3VeVuuOEqZo8a+n8NYPojm3KCH2
	D8a1bbDnynZkMnd9kGFGEmv2MTWZB2MsvoDckHhzzmo8EZWypDcKb36qk2pM+1y6KnTC96pwhi2
	0pEl/ny0iaZIzQV16tNvKf7zTnEUSa+iC
X-Gm-Gg: ASbGncsd9T6/i3/SsU/UcekkiO0blSWnX6AZ70G+wFL67dkSpZN4wRsNkSymt43k/+l
	SkF8fnY5FVq141tNuohtIDIoaSXp5/ZtxwBouS8oVaSB2HnBH1SeF6/7PFHNQLBILk2W5sCQhCP
	9jdzPVlhoJff7urVJZjbb4Fulfu7zc9jvTgVUHPpbec84=
X-Google-Smtp-Source: AGHT+IGxaM3GFKXNBbM8RVCjc5GUyWZsUBZaKDac2ZBrwiBJJBsb3lOQ++a3MlBFdKzgnAEnJKSLfTOkTUK1jrwwM1I=
X-Received: by 2002:a17:907:96ac:b0:ac3:8897:eb75 with SMTP id
 a640c23a62f3a-acb74ad94b2mr1314756266b.10.1745283958296; Mon, 21 Apr 2025
 18:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-2-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-2-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 03:05:21 +0200
X-Gm-Features: ATxdqUEyHSXbk6qPzmLm_Cw_KAHOUiJvtM5G1fe8_42R66jhKILMxEvFGwb3QrI
Message-ID: <CAP01T776eigY_RD8CFTiqLNcRMvy+jdNtsAmQgTDL0YfLbhzvw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 01/12] bpf: Check KF_bpf_rbtree_add_impl for
 the "case KF_ARG_PTR_TO_RB_NODE"
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:47, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> In a later patch, two new kfuncs will take the bpf_rb_node pointer arg.
>
> struct bpf_rb_node *bpf_rbtree_left(struct bpf_rb_root *root,
>                                     struct bpf_rb_node *node);
> struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root,
>                                      struct bpf_rb_node *node);
>
> In the check_kfunc_call, there is a "case KF_ARG_PTR_TO_RB_NODE"
> to check if the reg->type should be an allocated pointer or should be
> a non_owning_ref.
>
> The later patch will need to ensure that the bpf_rb_node pointer passing
> to the new bpf_rbtree_{left,right} must be a non_owning_ref. This
> should be the same requirement as the existing bpf_rbtree_remove.
>
> This patch swaps the current "if else" statement. Instead of checking
> the bpf_rbtree_remove, it checks the bpf_rbtree_add. Then the new
> bpf_rbtree_{left,right} will fall into the "else" case to make
> the later patch simpler. bpf_rbtree_add should be the only
> one that needs an allocated pointer.
>
> This should be a no-op change considering there are only two kfunc(s)
> taking bpf_rb_node pointer arg, rbtree_add and rbtree_remove.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

