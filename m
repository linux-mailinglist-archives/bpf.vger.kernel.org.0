Return-Path: <bpf+bounces-44437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6A99C2FA1
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 22:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BEF282488
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 21:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE1146A71;
	Sat,  9 Nov 2024 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3hwlUEn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E19233D62
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731187852; cv=none; b=Rc2HXK8gCQntq/iwggBu6RF1g4PzT7/jo0gBkoEkT8w+Xw9DRAef6wgxMhgwN5Buqr3kfeNVNb9H6aam0Otw+lNbd5OGDvswKQ/HqxjL7e39+O16D1Wiwdu+TFu4NRKDMWHDbMID/qaY31Cc+4/MREQ9sU3MXcVIDTwhknTehRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731187852; c=relaxed/simple;
	bh=GZ67Iq1aCZX25+rFXF0HmVXYkVPiCD1XXpuGfSUdWMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I215rwWhDY2C7aNH6d1C56+4oi5gzIHSSJyVtL0Syo7BIUYHlCNrmQo9EH+DmSCAiwFI4HfeadaG0h6ArC6tBrNrrpBuVuJTDHguEy6mPyNThs0iYYTMzdrZASXE2cjFmskTaw5OuEyTax+WPUkUSwaBFEzzutUMauLCBsJ+C/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3hwlUEn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2237367f8f.3
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 13:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731187849; x=1731792649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvFmn6pbCit9ZwWHx/4WoK2z5qrheejb4o9qfUMLm8w=;
        b=h3hwlUEnWfxtEcNAiG56CAC4fpq++U6awVzfasH6gc+0FC0vT0I7H923h4XIrpJrSY
         qHIpKjjpE298R0PDw5uJSqQP66dMltFtyeLSvVKvpJSniiwuuk4wBGx78kSzAGd8JGNi
         YDG8b7hc/DDthe9+rfqp1dKJ5pnEhV1c+ctCPunyFBJtLG4N9PyKftFwlEn2mJNJzhcv
         lQ4Y/lmgojLWgQvUNBmTFXLCSY+sLNxQjW2Zx2IcbIw6jOzpCGs9wJmwONJYqx22JWUa
         5GZXKSPXzxY3Pz8VpUsIU4SFZT/jL7Xw/ZxeYIOJxAou8NyxQxevMp5psH7Xw9H22Gmw
         DiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731187849; x=1731792649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvFmn6pbCit9ZwWHx/4WoK2z5qrheejb4o9qfUMLm8w=;
        b=q5h2PYAfEytmRUmFDxpfFY7rzC0VzG1andI83joRtITusR6N7AO6PkJl6cFs68rvKV
         Z7guLc3itp2DdkqWcjRrb1qnu2co7ZicazehzclGOt8M9VqIre5X2kkL7M9qnb+q8lRq
         DrkziHRZOxA2013rEHBcYgSNVxu0QuT+zM4kVaN7fgDwQklpawN4D29ZR8sYSrulyN5M
         1m/gpbjxS1IT7eSY9uME9BiYGW5Fhr5SSbv/69qD7TWnYDSA+8R6SY90rGwQQ6xKOX6S
         yQdD3ry3TFOQzeCII/Fu8b+WTWp6ZaABFC2FEGS1q08OnCrsjeQ2Rd0nIIZeGMM0lzxX
         eTIg==
X-Gm-Message-State: AOJu0YxY6hiP+2+ZE2mD7Rg1jbe0hrlxj6DXrZUndk9VFPDHJY7dCY/3
	KKjXXMtDIw3D+9QxaXLIkwcuOk1xyJF3fijeLi3nPvrXiauOnzcxVPmZ4/kMsKTrYw+ibd1IgiS
	p2Fg6UdiqFFTezrcwOuXKeCts8ho=
X-Google-Smtp-Source: AGHT+IFLibdRGzcC5V/nKOhdzEF66TCHWlFawCD4Qwm5Vg3ZpPkl81q07KkJL2uSvLcz/gKBZlBOMFWJ5e2Jk6vytok=
X-Received: by 2002:a5d:6dab:0:b0:37c:d537:9dc0 with SMTP id
 ffacd0b85a97d-381f182712dmr6701494f8f.12.1731187848962; Sat, 09 Nov 2024
 13:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109074347.1434011-1-memxor@gmail.com>
In-Reply-To: <20241109074347.1434011-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Nov 2024 13:30:37 -0800
Message-ID: <CAADnVQKnYwooCPe5uku5yE1_VXxFiKrH=UW45SRUzRUb5TwmXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Refactor active lock management
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:43=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>  struct bpf_retval_range {
> @@ -434,7 +431,7 @@ struct bpf_verifier_state {
>         u32 insn_idx;
>         u32 curframe;
>
> -       struct bpf_active_lock active_lock;
> +       int active_lock;

What about this comment from v3:
> +       bool active_lock;

In the next patch it becomes 'int',
so let's make it 'int' right away and move it to bpf_func_state
next to:
        int acquired_refs;
        struct bpf_reference_state *refs;

?

wouldn't it be cleaner to keep the count of locks in bpf_func_state
next to refs ?

acquire_lock_state() would increment it and release will dec it.

check_resource_leak() will
instead of:
env->cur_state->active_lock
do:
cur_func(env)->active_lock

so behavior is the same, but counting of locks is clean.

Since in this patch it's kinda counting locks across all frames
which is a bit odd.

