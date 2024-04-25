Return-Path: <bpf+bounces-27807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE928B21D5
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6399428AA26
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EF71494C0;
	Thu, 25 Apr 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuU1L+5k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E1D1494BB
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049160; cv=none; b=rv0Sx3zxzkvTVro44+skVvLb89pJumHiBSS7JOUa82D9cP7wK8l/Jj6IQ/siuKJ+g9RhUQDXXgP1DmLGYmpCyRIe98iY7xNTui01BnQMjCWAveUlespqhYrp0f0Cp+yOuUbwGCXW38Xie1o6JcydmGAdJMAZ+fn+3SIKzcoEOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049160; c=relaxed/simple;
	bh=Mzej7q0VUeK0rakjplkYrwn19VaLPM6W6kO4QgF20p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlRJ3FFB3bQX7lubtRmqwXZ6v8N7k8xrZ+/PB27+8CBmhybfzcxxwLdYCwyLlZNjyBKNhISPrwG9dqM2cVHZOgnZIu3qLp0MxKsfoJyODdZlvD+X8dmONmOPOdxcP7CBzq1JcFI06PTg7HleDUH+ssH1a0xkgxjacsPCI0y4Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuU1L+5k; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a587fac79e5so126473866b.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714049157; x=1714653957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzej7q0VUeK0rakjplkYrwn19VaLPM6W6kO4QgF20p8=;
        b=iuU1L+5kXfsin8lk/9jmLVsnImj2OrtB+simjcx2nVOI4HgMimMc63yp2ZVACauhzc
         o0o1LqWgLrGejGPT+2BYwpuN/k4Y2tu0HLR0Yf0CJR2EMIpS95dhZqcRMRCFhagRBpwl
         Aa2Xz1VbR4iU86Gh5Y5/CtZwW+vTZr0AfzCb2Idn7uLgXYHdoAQ3Von0uC4HgeyH3VAV
         y+wglkHn04XpZb7OYV8U6KMeqqM4qGL2WakpTH33iRMpIFpSjEUn8Ef0JYT0pzbW7c34
         t4vKShSV4lrSTnwNdN5moX933XwZ8ZEuHh4L3SCZaA9YLWjSGiHPXScUiWS6wbFxbPE6
         yCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714049157; x=1714653957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mzej7q0VUeK0rakjplkYrwn19VaLPM6W6kO4QgF20p8=;
        b=NVyoGMwPU1jF/fS5BGb0cm+cT5QwLNnUkYMWJLSozrkj7Q/i2deSoSpysyDASSCs8q
         egXJCQXferOSfcRlPy1WTcgRl6vlELf5n/yTdwujHkzvpUYiTqsz1OGU5zpqTPEH4p5M
         Fc1A4zmYVoeYMSMEZX6tKZsUpgWu3TqU4wjtAyAGE2lEkVpsOlmySo67gFs+dRZ1ygaz
         P8BE6kRj/iMVfENpD960DTHU6Tlphq1xjXvnnxE02ojPC4LEHNQZafFAEZr0CFJjJkTY
         Q/1xyFIGBnA3jj624LUM3KPqv4Cx49zl0gsHCSW83vyecWUoQZ51u2a+qM9OjECtZ0bn
         9TgQ==
X-Gm-Message-State: AOJu0Yz0u/kB8RHs+BjBfsSwW/6010aXGELsrtm+0H2XSgjluUoCloHl
	jD2Ta2XxF0LLvexEc8A2uEmwVHBAvGaENv462KyokzY8h/Dqp8tBVl00LrUBnbTitq4TSkqmG9j
	G4QahF5O9YdVLUVwTppxI+RMgQ74=
X-Google-Smtp-Source: AGHT+IEMMVm3X4trHIHu6zKYhpmpZ5lxLnNujGVd0WL6Q2tK/cY9cCvnWP4mRKdrD2g+Sf0z/Y2R1aaq7DANdl6UIqw=
X-Received: by 2002:a17:907:2d08:b0:a52:58a7:11d1 with SMTP id
 gs8-20020a1709072d0800b00a5258a711d1mr4982229ejc.38.1714049157386; Thu, 25
 Apr 2024 05:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424225529.16782-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240424225529.16782-1-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 25 Apr 2024 14:45:20 +0200
Message-ID: <CAP01T74c-Tk0=2jMSGNA1FbxSh1bUStTQD3b1i2PcSL3FW663g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_guard_preempt() convenience macro
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 00:55, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add bpf_guard_preempt() macro that uses newly introduced
> bpf_preempt_disable/enable() kfuncs to guard a critical section.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

