Return-Path: <bpf+bounces-42713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811BE9A951F
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2791E1F23ABC
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816913C661;
	Tue, 22 Oct 2024 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak44w6eR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165F2AD18
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558043; cv=none; b=DDc9pnY4bCJMRrJBf7h4eHBEy08BHG84tG84HlnJH3gpWjMUZALWgKq4vh0FQnvbxaYTwoVHQFiOKOj9WcII9HhrC3S/PHybP6cdqKGxqAqCe21t6LWztNqMWidC4gZYIS0bx6xaTTnnN55vCrqPxRzl/49agPrPCfwzud0dCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558043; c=relaxed/simple;
	bh=jUVQK0IEAZcVwGyRPlL0V82SjHG3gjpshyDdyyX8Imk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gltatIVRpkA7auEJGBZOQQvHkyqJ3btGjkezBt5ftTTf3o7cnzpDyervGL0CSLo2Ft1MYZcV0woPjatZS3m1gwoaxP55NdqjsopYtdvz2JmVon4zps4nFpFuSt7q4cVrNxWgVKlZ+QlghvO+X+LsT5SZZdGVG3wIWJbZrl0TbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak44w6eR; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso78375101fa.3
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 17:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729558036; x=1730162836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aTkDHpOp+V/adzWdPPXlvV8areovFERvVCGzfsIfSPs=;
        b=ak44w6eRe6aaiTRbmKbRsZOZC960Qu9TdeUCbKa1XkLCr9IkNATgobl0MR5kU/nARj
         AZU6fZqJRA7k56KiiBaRF3xYGdzgeR7v43pZdvLf8VrgjScPvYxNPSqRyspf13vDi3uy
         jwLklswkGl8BDqAp+ToQafpuUiRXSagxzn1ridVPh4gv4D7dzIYcECEN2VRtnBf9mS4q
         XJKodB14QFJiIjCvIwlKl/FVvNVXo0hL3BRaiJGxnZYaxre0seR7DTmlo4S0KxTWdG+x
         suK0hrZA2ELEOI9xPqgCu8XvYySXz64YkCPDrIId3eMS9pTaHa84erCFRyv+eQpt9Iaf
         jksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729558036; x=1730162836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTkDHpOp+V/adzWdPPXlvV8areovFERvVCGzfsIfSPs=;
        b=QyeJ+CL3CTTwuFP/JTfoeK/dsTNBTyEQXWWR4JnDaKI+7iMk99fKfQ2ST8vH69JsAo
         KhOW6uhYtrWjwEun3s9vqTC0i4x2pZFN40j6y3dafCSGEq6ehOk1kJtCcy1oX06pIpbE
         ymt4OO1gOiTQfU+HoV8PqJ4pn7elbuGuPuDiNq9ryZSfuXv9pgD6BDjORLDy2bNCf/Bp
         vKXz2ADxDO1ssAt1jh8N95As9A0P3tY4E10l9gfQ5xL8fXZpdecV3SsQOMhwzcH+/el8
         TIJBPdezii0mCiSXMbFr9GceJDyFkIzAXx2ZClz7deiYGx1UdsEFATXxyuI6Yd0c9X7v
         HBYw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ptSrFrFL5P/YRMpH6gQ1yapWA/czYmrWzGSRV2M5iOfmlTvZ4o0RSohr39mZNZIKYX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0H/P44YG4hku84uhDe/iToHYV+Ann0B/F78Zmveml2VuzCftT
	qrpiqsRqfP1x3T77mKJ7EkwGs878+FKi0NbO2ZUaHoJ4CwqBG8dSugWBGbuc9Vrxpmi08hTW6zh
	LOEbXhRW+VKw9dKvWMIDoZyXn71U=
X-Google-Smtp-Source: AGHT+IHXeBFnKqmfus83lrVDRu4gAQRXtEO5rOL47gBfhtKwhJBvU5auhGpePRSEXmYT4kzB7z7I2l+XPX2rOQ/yVWU=
X-Received: by 2002:a05:6512:b11:b0:539:8a50:6ee8 with SMTP id
 2adb3069b0e04-53a154da8c4mr10385686e87.57.1729558035906; Mon, 21 Oct 2024
 17:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021152809.33343-1-daniel@iogearbox.net> <20241021152809.33343-2-daniel@iogearbox.net>
In-Reply-To: <20241021152809.33343-2-daniel@iogearbox.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Oct 2024 02:46:39 +0200
Message-ID: <CAP01T744bhRfWuOrBOcicNaNUDL=eFtVusHiMdL21+j5ggMU5w@mail.gmail.com>
Subject: Re: [PATCH bpf 2/5] bpf: Fix overloading of MEM_UNINIT's meaning
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, kongln9170@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 17:28, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Lonial reported an issue in the BPF verifier where check_mem_size_reg()
> has the following code:
>
>     if (!tnum_is_const(reg->var_off))
>         /* For unprivileged variable accesses, disable raw
>          * mode so that the program is required to
>          * initialize all the memory that the helper could
>          * just partially fill up.
>          */
>          meta = NULL;
>
> This means that writes are not checked when the register containing the
> size of the passed buffer has not a fixed size. Through this bug, a BPF
> program can write to a map which is marked as read-only, for example,
> .rodata global maps.
>
> The problem is that MEM_UNINIT's initial meaning that "the passed buffer
> to the BPF helper does not need to be initialized" which was added back
> in commit 435faee1aae9 ("bpf, verifier: add ARG_PTR_TO_RAW_STACK type")
> got overloaded over time with "the passed buffer is being written to".
>
> The problem however is that checks such as the above which were added later
> via 06c1c049721a ("bpf: allow helpers access to variable memory") set meta
> to NULL in order force the user to always initialize the passed buffer to
> the helper. Due to the current double meaning of MEM_UNINIT, this bypasses
> verifier write checks to the memory (not boundary checks though) and only
> assumes the latter memory is read instead.
>
> Fix this by reverting MEM_UNINIT back to its original meaning, and having
> MEM_WRITE as an annotation to BPF helpers in order to then trigger the
> BPF verifier checks for writing to memory.
>
> Some notes: check_arg_pair_ok() ensures that for ARG_CONST_SIZE{,_OR_ZERO}
> we can access fn->arg_type[arg - 1] since it must contain a preceding
> ARG_PTR_TO_MEM. For check_mem_reg() the meta argument can be removed
> altogether since we do check both BPF_READ and BPF_WRITE. Same for the
> equivalent check_kfunc_mem_size_reg().
>
> Fixes: 7b3552d3f9f6 ("bpf: Reject writes for PTR_TO_MAP_KEY in check_helper_mem_access")
> Fixes: 97e6d7dab1ca ("bpf: Check PTR_TO_MEM | MEM_RDONLY in check_helper_mem_access")
> Fixes: 15baa55ff5b0 ("bpf/verifier: allow all functions to read user provided context")
> Reported-by: Lonial Con <kongln9170@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

