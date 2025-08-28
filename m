Return-Path: <bpf+bounces-66755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F472B38FB4
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAD81B21B40
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4A1519B4;
	Thu, 28 Aug 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUcs+Ns2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1FCA6B
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340398; cv=none; b=aGcMVqhIT/lUfYYZBuw7ZNnM7qV8tUeFFOYEebtxLtaJuyv7mtdx0hRVvjfiGHKS2pHJNL4GUd2H1KkR+/jLsfjs+dWjB7nRhfx5thrDN8ZZYVuI4dAnpaLlbSr9D/7tc4nVmDfC9n44a5IIeq1t/xDN0dVtBLRGX8KM2Tjcpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340398; c=relaxed/simple;
	bh=GKjiiXjy33te+ZxssV3/CettlETZIJuVxkEqaRwtdMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgcOkwRZLbY2dfqq8Q2iw0pLJqJru+lXw1PUBou7gcVlGTPVh9CcdCCPtfVTwCrHqulKfFOooXh32/AsEF0Qir5ggieTeGTfc/atNfuiXwbCJo4q9Ry8IIkqsu0CQy1IKLUqT8K/y4C0eov+ZoSeaIGrhtJCAVJe8XQkEKqCCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUcs+Ns2; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-afcb7ace3baso61526866b.3
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756340395; x=1756945195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GKjiiXjy33te+ZxssV3/CettlETZIJuVxkEqaRwtdMs=;
        b=dUcs+Ns2doaqODAFJxivmzEMFmPUC3WqsZ5Ro2j/cK6JLb1T68m+rGsDnZ/HSLojvV
         KdLxWsuj8sZtYGWE2hbgH/at3sen3t+rxTGE4HytBx7DVL5SlWe5nw5fNd2mh8NUPMmh
         JJ548AbRYafcHtmLZ7oD2WBbttZxHiqvhxbtfBn1BIVr1TwNwegpEePcW+e8+8RWnbH4
         bQZNhp7hP9kM3EPpMW0u6N8YnVq+qvVKwBI1PR13yd+v3vF9WowOV5v2Dzcy6JbhDsrX
         SOPVMHhdmA0nedKPuMtg8Y9Fq1B/4sYv0IyO5O24ioNN89BQ2zZ2gaZb3ax+iz/7vPE/
         +hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340395; x=1756945195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKjiiXjy33te+ZxssV3/CettlETZIJuVxkEqaRwtdMs=;
        b=AIdUMcjDPw+hZrpQYZdo6944lYpVC0G+HdgtpCyFDP9wMt9iGS+KRIFXu+zCxal1tr
         OxqFnFMpahSo1qzCkDe65IvOtQb6F2YHDDDVu49uv2WB41tYq9+Jv18x3qfPNqOp5rBC
         PIixwdV705QRuKhlI85KNJXubz7djSxHBZv6bdFZf5Nm3rvifPyZy5lCqltzluq1RIpk
         YtwyKveDf2ljIAtIZWJMMVi6MOjlTbwhy3YPEGuTlx0LG8nkbIYbIPNWNqNYi1Hk39Ln
         B9OjLauLyFGdg3N6SjXnWdZ88axMDsLzeA8uDnbE2oqmAOOkKZc6AN3K77iqW5IVuCyC
         WuOw==
X-Forwarded-Encrypted: i=1; AJvYcCWd7LrFnvUg+7aQ2HuFK5bI++1ct9TLlOzusegYTTeCLLfhYunhGLGbKErNnC5GmN37m34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTWgG7OM6rl9GK9O1RLse8XDhlUsjaCibYe3+/vU/899TNlTT
	IUuMhaNm5cf3mZ6HcT0tUZ7JyAngSrYygC8o80xcBwYuEzPx7e0hqMIoA+hrY0fA9Cv6nIM61rn
	jBw3iqCSgueERwoRzw+gdlKRvOyiTOxY=
X-Gm-Gg: ASbGncsJGnw47W1xseHJ4GIMBYT37TWvP38D3g66ekSC/p6qRyRlC5jZscaUPviN/Px
	QQMbDcon997fAUZtaFDQyeJzLYbeifJF9kP7vyp7y3T1YXUvAUQAzYY5xLvrP3I44Cjnn2HWkKU
	+SQxX487+mgF485XVMsOturYUeyxlA/xL0nfbG2zZLlQIxMbYI6C6Bq7AnZVfZ799paAZzG3UoH
	yQdYsJRy5RHwBoaku17IeNn4q3Mz1cm4ghIcqigvrY1hNv3/Z8=
X-Google-Smtp-Source: AGHT+IFKx4T/v/atlWS0GEOP5pauYJzMNBMEBfDjbTm4i8KRTTbYbQSHiUGb19cVtjpdfcgxCXMjwtvnSq86iG3xT4A=
X-Received: by 2002:a17:907:3f9a:b0:afe:d21f:7af0 with SMTP id
 a640c23a62f3a-afed21f7e3cmr238641466b.14.1756340394705; Wed, 27 Aug 2025
 17:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827153728.28115-1-puranjay@kernel.org> <20250827153728.28115-2-puranjay@kernel.org>
In-Reply-To: <20250827153728.28115-2-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Aug 2025 02:19:18 +0200
X-Gm-Features: Ac12FXzbIsORarAzgHg8aq4Jg4dpR1eKdQZK0U5l_2HO2sptfamIJ6HT7xI8yd0
Message-ID: <CAP01T76+uk1F1m-EaXVgPM3irxFFM6Y4Jx-0DtCt9pk8brdE-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: arm64: simplify exception table handling
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org, Xu Kuohai <xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 17:37, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> BPF loads with BPF_PROBE_MEM(SX) can load from unsafe pointers and the
> JIT adds an exception table entry for the JITed instruction which allows
> the exeption handler to set the destination register of the load to zero
> and continue execution from the next instruction.
>
> As all arm64 instructions are AARCH64_INSN_SIZE size, the exception
> handler can just increment the pc by AARCH64_INSN_SIZE without needing
> the exact address of the instruction following the the faulting
> instruction.
>
> Simplify the exception table usage in arm64 JIT by only saving the
> destination register in ex->fixup and drop everything related to
> the fixup_offset. The fault handler is modified to add AARCH64_INSN_SIZE
> to the pc.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

