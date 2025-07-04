Return-Path: <bpf+bounces-62424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C72AF9A58
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E4B1BC735F
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937F20F085;
	Fri,  4 Jul 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/0/3n/4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A61386B4
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652631; cv=none; b=aqX2jrWvr8CGvpZCkEy1L4pSLGDUKFAdCh39blNSKG0/IHECVvg73vOZ9BGDZdXAiWJ0CJ3rA7LDUEc5NGPBdiEgxW0Uq04aVqeDWC/DPpAqajHA6201DoQEL840LoiwDqKD3i0Oh7EqImiLLOwEV+LITAop9TNZ0pm6vFtBVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652631; c=relaxed/simple;
	bh=RMLIWsVOsiI9RQ9jXIukA8OgJjWZt+1jywRZp2eRJfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAHAIESc3BHGz8Dvy0kFnODk2SHthMp2VKMQN/c91x8LesS8Xy8Hvmt7V444CGoVS+HBG6ALNAslvNe5yqialzdbzCcpBn/Adi+LFsu3EXHScFHYRp8F+djR5kzoVc44FgGVfcHhug3mCDjSogV5jh1d5ewGB6CoHjglktujLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/0/3n/4; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae0b6532345so408354766b.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751652628; x=1752257428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NoQjdJdjJ25BMLWOEcOfBTumoH4DZjnzsPhJf+jA4Kg=;
        b=Y/0/3n/4b9McR9cg3qhGckpEIYyNoJC3O/Z0TW96In/Q3fVBlU+eeVoqO+mN/uQeO2
         Gzk+mOu1pMMyaQpILkDf83g/p+KuGl+wSeEveZWmJxVDY/8aDG1QGbAYHNHiMmQp0Q1x
         OTpy8nTpKqs0OosV2703pjAu0D4fsOYj3tcZL8nXC6rEXkt5YUM4RtcxGWC3pTorAupt
         PO9+/2GIxdgooW+2c6Muk06EdtFTNMrGjUzFW6ypDBEf0a3RdgLXFUxZEa2s6HJ8Hazs
         UxkQsMFHwSVR4Ef7z4PWT2OJuWZIWZEbPmjtgIoR8x/HO0wDZxMCMl1vmyRaQ+BLTW9J
         +OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751652628; x=1752257428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoQjdJdjJ25BMLWOEcOfBTumoH4DZjnzsPhJf+jA4Kg=;
        b=j5QDMGBd32QusWQPgiyigGgjJEBwzxVg5DOA4REjwRFPHycbTVneIAdsVgbkoukN9Z
         BuO+ZMdUQ0iO4q5ooQNPi4zZqRGkA84r6dsOLy4bOTCHnrLYq+kRSnY071eFdGxc15Vx
         anKntevmJdLnE5ts/eGcFZ4VerAi+ZGR2eAHcnZ1nvslo7wXxJy6jUexyOYUYdeAtldj
         67QZopghxa5kWb4dna7ydBDYIeCrecuGoQVcxnooH79b5oNOeD5ITQopzslAJIagVNc/
         BdmfPUZ52uY05y1O+zKkh02xf+PecGcuT9V88hRQaxGdk9PYQ0oMxwRTJaTONB6Hi3uw
         kmqA==
X-Gm-Message-State: AOJu0YzlTHJ3uDho1pU6+WYEQT1twLNx+3thigGRuTQhXWr+dq+p+p0z
	fXMmIUQoObEZIwzugRMP3wDx04HQoaQgorKJk03R2AAIQzV8mYlsDI6sO8yEcn3EhKmBz8lc43/
	JbgRbFwBv8clEgVZNFBn0f54JZUTWLP0=
X-Gm-Gg: ASbGncvxMYI2YB2KOjPknHCsB+3FuYwVFqj774f7IkXkF+ANiKRXh3sT6R64+o/AjAh
	YOE9kEhSqJkw4QxWjI94Jb6ooOjqZrcOeqP57/WRe73vp7BQw9fF6PsRhFsPZYjdtQZnzMQeFPV
	Q4P/okV/bprn+9aOP+Gq7WdUCg1B28VlaikJZ4FDaxXqCihKeqawgICgGpBgz7WYL4lJLervH81
	b4=
X-Google-Smtp-Source: AGHT+IFbw+GQA6poEzEIh/jWBb54J9EXjL/WX4wm0Urx1miZxu6Fri8HbCNhdDihCKlwGXsiNelgw9an8HVfbuPenpA=
X-Received: by 2002:a17:907:e2c5:b0:ade:9249:25dd with SMTP id
 a640c23a62f3a-ae3f806bc6cmr431248366b.8.1751652627577; Fri, 04 Jul 2025
 11:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-8-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-8-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 20:09:50 +0200
X-Gm-Features: Ac12FXyU3qZlC8Ee_LLhQT_B3EgPWgIqo0BhredYC-jFhf0wU1dBUolG-ZEu7uk
Message-ID: <CAP01T75cO-sXt+N51R0eORxEt_RCZ0gmbc3q6pfOQYX12+3A_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] bpf: support for void/primitive
 __arg_untrusted global func params
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 00:43, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Allow specifying __arg_untrusted for void */char */int */long *
> parameters. Treat such parameters as
> PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED of size zero.
> Intended usage is as follows:
>
>   int memcmp(char *a __arg_untrusted, char *b __arg_untrusted, size_t n) {
>     bpf_for(i, 0, n) {
>       if (a[i] - b[i])      // load at any offset is allowed
>         return a[i] - b[i];
>     }
>     return 0;
>   }
>
> Allocate register id for ARG_PTR_TO_MEM parameters only when
> PTR_MAYBE_NULL is set. Register id for PTR_TO_MEM is used only to
> propagate non-null status after conditionals.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]

