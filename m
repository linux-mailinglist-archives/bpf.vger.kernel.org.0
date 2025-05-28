Return-Path: <bpf+bounces-59164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1318AC66B8
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 12:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB639E48AC
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481C0279358;
	Wed, 28 May 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7GlfN8m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34196171C9
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426986; cv=none; b=oc3YN8Xuw40BpK3j5HoKDHCoxWmgmXrNprCW00/VMaacMTFPnC/1Q1hn1fP/8n+jwRmfaB00rAqAXOCSukbBMPVsD6pcJygTcWUKV6Mjb+ta2BhE9W1o+NY4zsB2c4co2jBAJaXAIV1dAVjofBxZ+cBtfRhEWkT12CEqnxB6Bx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426986; c=relaxed/simple;
	bh=pdCwBFNlErrvIBtoXK0hVKWI0aXX10rWJJxJrf8h454=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy9UjgImvkpxtDPXOWzw+GowbcpbhJEDR1xXxL6/L8P8oL0mc8RP6JaDMcWYp39+pWbhfM1WT8h3TZX6A5lUcCPwyI1CnDk70PoaOk0HCWjnCwjc1xaKoe2yt1EKaNePeTG6aJ8c4oKmFwu0gfcObUcUcfQfBAYYE+qgCssWqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7GlfN8m; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ac34257295dso852574366b.2
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748426983; x=1749031783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=we1TfVjYKR3aYDXsoNXRE3CrGL/ZsRbsWqukqrJoOf8=;
        b=N7GlfN8mGhyUX1BSTp8/BCKPs2JbqHbMw3joj+BWJ6tooH5t+zp0U9jX34qyfCeEpX
         cB+XiVws+3Xdl6COgDrNAot1AU+BrVUXla5CYvLF2BEwPEOIjrAceiRGUP8uzyOPOS+o
         jUu6gfRZ6LPJpQNgEShqT8S0Q/RPCqZ6QiQr9fLF1yIailfWqY30jczuIl/+4xcIO9xr
         MXtJqsaF5JV6+bNrzuaBbcUQ31XCH6y5c3BZMICrORdWR9slqgk3ezl3iAZHhxpmgkyL
         vV+91ISu3XXHtZnAkIn+qmuyt6X08YG5CDrJj5Uldg5kzTvLP5wfIsj78ISnAXI72BQS
         NXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748426983; x=1749031783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=we1TfVjYKR3aYDXsoNXRE3CrGL/ZsRbsWqukqrJoOf8=;
        b=RtVGuJIdn8owf6+mh5pynlDjmhhK2b/n2VqPSHZYBuy16Jk15fFUK6mENr9U3jqC4Z
         YR9YIRvNPsOEjOdryIxFa1eTpnWlD6WQCf19SQzzvwfAjWmTGl37MtxcW/RncPS6oEk/
         h0yrJ/NZI0GqwgQKFaDsgei8YX/JJ2+DHGCUNmWrjfYI76wWc4AH2deuOGEkIWFeVW4s
         9icX/l0S5Sli4+NuS9sFOY3IIR9kRRH/0FOkfHVIxup0Spy47szODeeXul60+4vqErdx
         d0KTTAzELtbxRzJOrWFzFWAodeFPlBZK7x+aozepd2eKtGuB3Qf86q07RUR7Mj4kWi9s
         fHNQ==
X-Gm-Message-State: AOJu0YwPyxvuNFbdaeB2Va9gmT1j1DmstTRnK7/A+B2cdTSStnSZc02e
	+LFXwIaNwVkB2VoIuvI+CfzRgMvmtl+zB5u/Gzf2NPh6SKfr/JxUNajPfTAnoPVVIK/J7nFvp+Z
	u71PnxzmwMACCF5svbSHKY9vw8n5L+18=
X-Gm-Gg: ASbGnctCxk/NJEPpug3GlNgHcvLZUsx3pgzshHtRCNDDbJKJOUsZvnngCwFMxv986rR
	XRi8SrmMnPtSelXw9kqqRkbPtbYsDT25MOAXztme6ijIWWdc/bEQAZ5iSkOCeG2cIBEoHmdgb3J
	RolPqhE2QDGZxEBVGrCxxumikrKfb0vk6e50pueezG3PmRmGNsrDq8FVYUhLrgliqKL3FMFJ6EL
	Bf3pA==
X-Google-Smtp-Source: AGHT+IEpXpjxxoO7wKxghUT8fovQkpN1Ro9ocsU3qAoBLKrOg9Tyy6US1Wa/fw191ZmGeG8LLqKFw377S9vi1A2kjzg=
X-Received: by 2002:a17:907:9616:b0:ace:c518:1327 with SMTP id
 a640c23a62f3a-ad85b16cf4fmr1584108866b.14.1748426983280; Wed, 28 May 2025
 03:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-9-memxor@gmail.com>
 <m2ecw92rh4.fsf@gmail.com>
In-Reply-To: <m2ecw92rh4.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 May 2025 12:09:06 +0200
X-Gm-Features: AX0GCFtYpSt4TwAX7paonvcoHqQXMP7AQcBZMCJN5FGi-61ALQW91EEZvqD7Q8k
Message-ID: <CAP01T77_cbaHKRZwq7sQY-KMhN5KHnnWeaDDEtytdNfK92ZnBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/11] libbpf: Add bpf_stream_printk() macro
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 08:13, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > Add a convenience macro to print data to the BPF streams. BPF_STDOUT and
> > BPF_STDERR stream IDs in the vmlinux.h can be passed to the macro to
> > print to the respective streams.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> (Sorry if I'm being repetative, could you please extend
>  one of the tests so that output of the bpf_stream_printk
>  is compared with some reference values).
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

IDK whether you saw the final selftest patch, that does some output matching.
I was matching arena fault addresses until I dropped the patch.
I will add something to match on the backtrace output as well.

>
> [...]

