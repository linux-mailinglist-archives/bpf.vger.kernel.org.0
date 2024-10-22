Return-Path: <bpf+bounces-42842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7859AB9AC
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF8C28478E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970E61CEAB9;
	Tue, 22 Oct 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIa6lGNu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9E1CEAC9
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637430; cv=none; b=uveL07aeXGHP7J2BcrK9vyyXbuVlH07NYigV/z3NdeyokTkkx/pI2TemrIbUmaaC3DwJVHlKKiOmz9JAbrFygBUNIoT7XB2VZQTC30kETHJ23lK/ZMQTjrQ472tQB3gScfVKL4yKu2WWh1Aye5sAmha26Br7rtQaiwIuRHP9pN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637430; c=relaxed/simple;
	bh=cyatEPGCDJ31+cKRmXmFR2L696gELvtTkx1wdGSCYgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/HTJLpkuaEVa1Wt3kaECDSnK4NKqPaiPUScpeI4C2OM9AxQy96v5Wvc9GeSNdSNa+FKr+w815zrmVVd8bSkEoxHqFkuYyAv5xTvXRY1ddZHlhlCR8GBL6fhFzEU2e6ItAmUZUJNxf7d7jkf38h+hYRgLJg7MEo6v+aptI7t+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIa6lGNu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d3ecad390so183147f8f.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637426; x=1730242226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyatEPGCDJ31+cKRmXmFR2L696gELvtTkx1wdGSCYgI=;
        b=bIa6lGNuFVske+FofHsYIK3JTFPqVFbohRC466G8+pvrOMVhnGBA//+VHcYZXHNKNs
         Oz+5p8KBJkRw2m0Zg03Vga4o/FyK0CX86n88w2qRsELuzlIusAn1vqjejk22ws5sD+ia
         m8kGTMoZ76Zv1+b+Zx4BeZwb4v+Dg/uFKJtCAb83WOjktqsOvx16w3DQH9DRHbK7phEH
         zJKPZIzvnEIgt6BmuMVzhxoi9ChcIXH6qlwxo7GAHHRYEsGmk4OxL2MOjF0KqmqhIDPc
         OQwMkSgRifXK7Kka/5dkDrWAbvkId15WndXzlBM3DmpTCfAeIdlbMr/V+NHFuAQHW2S5
         mbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637426; x=1730242226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyatEPGCDJ31+cKRmXmFR2L696gELvtTkx1wdGSCYgI=;
        b=THG0SGQYuDtBOpe3QiOOqfNRha/5wBLnZS81lPmCxt3EuPckoCKMOBGGEYyFoyqqTZ
         82mlcCxp8freJu7wKVS78CUI64uvN+w4o3BDPqkcZ0icrdlQCEGO/nBUEElwsheQruj+
         wqtqiRcO5TL5Z4f8Ym+zsoR9Y1EDyaSjT4HIdsVeHLibuUCvbcMV3L61XYQz5woeGppF
         9/0vvr1SzCcAAJKMelmDyOk2SW2vQkagH+XoY6M4bgEIWwd2ME5SbXAAm57w1+S8emwx
         6+JL3h9OgWFG88FiBQpIF+HkqQUz8Iss3CL2Q0HL9Cd2v+TadgQ8K+8AHWEcuoZOkQv2
         7/IQ==
X-Gm-Message-State: AOJu0YzAGLRYK3Z3BxHdL4QeSb7G4h2y8nBKwXN6doepP7PAy63EDXAE
	KAe+v9sD/LuYOC4T7kNfNn0dqU9Ahdqei5Tm7tYLWYUD9vtJQQS2ENrqNnvD80HIov0RZYnMr6m
	o0P2stwbhjTorgym6jswgYNDZk3s=
X-Google-Smtp-Source: AGHT+IFZrXb4OZ2jfTtDIyyoiwZyT//XdDozHA+u56Pz3+w+LFw2KU2+bZCUx0FI/iYkTmtGUHxGPuPbHVcT3P5PEFc=
X-Received: by 2002:a5d:528e:0:b0:37e:d942:f4bf with SMTP id
 ffacd0b85a97d-37efc5de906mr347571f8f.12.1729637425660; Tue, 22 Oct 2024
 15:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019092709.128359-1-xukuohai@huaweicloud.com>
In-Reply-To: <20241019092709.128359-1-xukuohai@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Oct 2024 15:50:14 -0700
Message-ID: <CAADnVQLOY-eHby6CMNXr3FvwPm85W-tWDxiWnRaR_U_=71ADuA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, arm64: Fix stack frame construction for
 struct_ops trampoline
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 2:15=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> The callsite layout for arm64 fentry is:
>
> mov x9, lr
> nop
>
> When a bpf prog is attached, the nop instruction is patched to a call
> to bpf trampoline:
>
> mov x9, lr
> bl <bpf trampoline>
>
> This passes two return addresses to bpf trampoline: the return address
> for the traced function/prog, stored in x9, and the return address for
> the bpf trampoline, stored in lr. To ensure stacktrace works properly,
> the bpf trampoline constructs two fake function stack frames using x9
> and lr.
>
> However, struct_ops progs are used as function callbacks and are invoked
> directly, without x9 being set as the fentry callsite does. Therefore,
> only one stack frame should be constructed using lr for struct_ops.

Are you saying that currently stack unwinder on arm64 is
completely broken for struct_ops progs ?
or it shows an extra frame that doesn't have to be shown ?

If former then it's certainly a bpf tree material.
If latter then bpf-next will do.
Pls clarify.

