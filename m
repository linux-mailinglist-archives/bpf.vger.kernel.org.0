Return-Path: <bpf+bounces-21702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4A850393
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A871F23929
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1FD2E3E5;
	Sat, 10 Feb 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd4Lo9ZW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0A364B6
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707555151; cv=none; b=ceKgdttDkFd4l+3ZAy9EjJGuYU3O1sS7+dAiuf2q8Sss5XtJehoom4xgYKA6l8JSXiWqZEXpYIB6tIn5xSVCr5iZuudM33Ow0WXUFLq3Q4Ui73fr4Xwa7ZUaD/afUdF5D/Cmld+CiFQ25RJYXe97ll7885RcMX7IXFf3PxvfbuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707555151; c=relaxed/simple;
	bh=3MnDAfyaS10G4nicoY9KCBJU6/xt89nkow5rhQqShR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqDfmVNFMr9K93JNw2RQlg56NPdm9zTSHoLkXQ936CxgDimsHrCtKxl0n21fASbWa/AZLfDs6WGcQ9GSZatlCGULF7qjJj+QqiWDKp0hCP5LKaMlmMjR123pUeAQ03A6sNdpqq9fWxi4ZVs5zbKsLeP4AsK5ubjHrWfA0GZNwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd4Lo9ZW; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so2319360a12.1
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707555148; x=1708159948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3MnDAfyaS10G4nicoY9KCBJU6/xt89nkow5rhQqShR0=;
        b=Zd4Lo9ZWOWplnfRCEYqNKO+vy4mSay2VFh/rECnt7OhDWDTjQbp7vzEShe7T1gIKX3
         AxyiNxHSv0m5qP9DecN1aiS5loAWEY9Jnhqib58PXjYQBWdNxejQmljUQK070kwI3k3J
         0AHOGaVEpwSJS15RpmY2GVcvwWG9dUP0bjHF3Gekg2/stIjl0sd2reuOJSB1pXTw89IJ
         McBgVgJulOBeozJqpSg+guXC8Sk7QnW+K5CtS6SghPwYXOiBdIYFzJ+eIhwzb6nrbH7m
         08PvDYG7zCzm9Nnkl3E8TOGMyTf10JYSHTKEdIY97VWbLj98yoxgEHTAo1RNY5exKS1S
         hpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707555148; x=1708159948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MnDAfyaS10G4nicoY9KCBJU6/xt89nkow5rhQqShR0=;
        b=bIPZgmNM7pPMo5NhSav9MylFPMtm09RVoXVEI0ENni+dtR/lYSLNn1sr54Qr4Phr0/
         /KUX7GgzS+edDvFJGLMyw270M52sNZCseWyWjgTFiykErbm/UPe8Ep+yfUW3+d8/rFm9
         QJuRvmm9we2cfTDspZsyF7LNAPiNPr+PLdL+Vu23sERWxmVESjHyo4/j5z98PR+xoRoH
         MaeigWCPXgpJp0B53gow9ZMMWZjOOZatak4YBGZ+rwuJyRJAPpRU5dIp0Lz87wx4PDbG
         MzBcTjDXZL2GxhPsGeBVQkpGnt1k89W26+YogdJVrX8XiVre1VHRBkzf3fv5W7OEgUeU
         KtGg==
X-Gm-Message-State: AOJu0YxafHzygLFBrXty3DYDH60XcMETuNg61EHtBOdxjNv33qtvF7SD
	mG1IhlHycOS8nWStZb2cdQapXbaNGLz8lCUowKwhjnq3H75qqaYFkmIXRLvUBzUkpc1OKx5t19q
	0aGiGFGUHzB89tk65K1kKDWzBXu0=
X-Google-Smtp-Source: AGHT+IGt0k+ZriPxl21u4zQwujaeR9dVXxmINcx7HYwZ6U9dhj8j/UuJ3hljfIbi+a1WBD977gnPIZ7fZQSDiN1gRrM=
X-Received: by 2002:a17:906:68cc:b0:a3c:3c00:7a29 with SMTP id
 y12-20020a17090668cc00b00a3c3c007a29mr424483ejr.1.1707555148056; Sat, 10 Feb
 2024 00:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-12-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-12-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 09:51:51 +0100
Message-ID: <CAP01T76cG4wFnj543CuDhYqrSV79AuypwhgqGUCVs1bG5RG9qg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 11/20] libbpf: Add __arg_arena to bpf_helpers.h
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add __arg_arena to bpf_helpers.h
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

