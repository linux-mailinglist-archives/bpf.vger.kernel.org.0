Return-Path: <bpf+bounces-74605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDEC5FCB9
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 107264E3DEF
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21A1991B6;
	Sat, 15 Nov 2025 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvQngk4j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35E1BC2A
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763168679; cv=none; b=pGcTo5awq9rf99z0QQFXeSrxev91Qh4PdFFaJTM0QWlgaAPFKVgdK4bM4uqPpZA5X91tPRAuVo/z1kHUDvUdwCPd5fNZTDMu5u+uE+ypl9io3gZV4PvJzz9NVmnb3EmkzZeOJbsdcsSIgVyz0CwRMG2sYzPDgqKGSm/WErswPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763168679; c=relaxed/simple;
	bh=KSE67dHasUGTyUVVvqSxWdAaKSIwi8+u0olD/2FXjuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufsWZu+l1wwImaSmbgo1Fu8PGJhCn4We8ZLzdocfqeyukB93dEzlylRtLDz1pAwzBbDAknx8WhxjdNVOMBdMbLMymmoRrOPLDqJiMFQScbR8H7YARJh1l2t6hglQdIWZByZo979Q6yG3q6Nr4GbMMJstGL8CWNl3Rv9tuJjbC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvQngk4j; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ba92341f83so1719209b3a.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763168677; x=1763773477; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JtF5BY7k9V9hax871fi4kvLS6ldlGEQ/4Yh7ECdUeh4=;
        b=IvQngk4jWLqHAPFFe2ILWhLHoOIwNQIWaEQzTc5VF27Dz3ey8KV45vlF9kIROOAxU8
         kTPZ1RBU5VK96ubOyo+4x1ozIL4Ms5yekzJy/f5ONo+IXpic46WA4Jjc88AhLkYbsOGm
         zTqAAOfJxgW8MSnRLtw5WKdWlWbPEzVjC4TLgLbIMiWvbiUacE8P88juHQ7Ss70co8jQ
         NJFHpOZlTurQypazm5Uom5WDzdIzL6k+Mtak5fn/8+s55f+bxtY3YYhFr8ySFxmnBABz
         OPV9cySvnGPJPihG0DbySs9nZ7pQoLvk4RuuLZ+YipIb+Iv6cdRoGtIlnAd6+H6cyisA
         V62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763168677; x=1763773477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtF5BY7k9V9hax871fi4kvLS6ldlGEQ/4Yh7ECdUeh4=;
        b=PzL/hY9WFbRMOirEHz8xAofWIxIKCjm8SSdV7xJu1/37H3dc04/rDKUmGOAVpnDUsE
         423FepMhA1I7xCfhF+a1juYuH7ZQAZRt2oDxWkJNex1ygmD4jyhyzCcxcr/6yAOeam+U
         +rjw/QUWwNH9rza6qkPXGhZR5ZyhG+ep4joIZe50aYYxSZN5eT9Csb1/o2xDyiRjwLkY
         f6BDiUGMLgP/nO9K807qqs+2Y+HntcBOGV3yqsBN7YT8H09PkzmEsGZuLHe6hz4S4mwm
         +JhdMznu6d/ODSJyFMDRpHfOgdsaHwdn41mdUHquwvWH0PVjZw44ocxKV+q9FYQ7lLLr
         JpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSlfOFbBhALK+jWcL08hBE6ETH/saQMjtMX5RdV/j5KtOgvLy9skG8ZZHuxokTPSuLeeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNXxdWTV/ya9oSUZ7nv/cmOMAmDjRGUnhLozxvskx4JToFTLa
	1ga4xUuNLsAmGvHnm/xBqEFErIV9xuIIzKVmubVFzPex6G4JA5hquLwd
X-Gm-Gg: ASbGncthO1qdItyG3c/SIWpP/u4jz2ksDM/CE1kVYffFKMg/8A5GlLOWRNgCQRSeUdj
	qh0WMab2wtgnu3yAnYGaF4RVELimWEnxoJqf3BX41vAqIvHBpaWgtOhOC/ChO7XBPxra8aYevTa
	GXQRCqJTKfGS2qDLlFY9y+xrmivQzizPsAyAFrFlqy1CJhctRlWAooWA2UdaZTBTNmxNEIAtOeI
	FFsBaBug1Yb36mgbN593QDlAufeSG/o0qUl9lY8DBse4LZ5B4EsnenP3XECPJsqDgHFs/xZpl3L
	dhXTKJAvKX305+98socvAuu7D7FhG4KMg6N1mT68TS2bOaf4pnY7LWPx7HcV+rj96EEFWfgTEeF
	K9q7idBhIExXEk13yWaHqmkjIM3Aqis3a5OSpEITUG3ig+AOvtz4Lm0k5lNUrD7HlFgSS2jAkVw
	==
X-Google-Smtp-Source: AGHT+IH+cQn7nxX+/i7Rci90JbL3g2fCiWELBouTra+E9oopOh+XY6xZ9CXVT6p+vvtifh0xkhhumg==
X-Received: by 2002:a05:6a20:12c9:b0:350:cfd3:e991 with SMTP id adf61e73a8af0-35ba2794a05mr6404323637.52.1763168677321;
        Fri, 14 Nov 2025 17:04:37 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db21e76sm5953397a12.7.2025.11.14.17.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 17:04:37 -0800 (PST)
Message-ID: <55fb1a1f8d976e30dbaceff6f07b9e661cdc77f1.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for s>>=31 and
 s>>=63
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sunhao.th@gmail.com, kernel-team@fb.com
Date: Fri, 14 Nov 2025 17:04:34 -0800
In-Reply-To: <20251114031039.63852-2-alexei.starovoitov@gmail.com>
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
	 <20251114031039.63852-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 19:10 -0800, Alexei Starovoitov wrote:

[...]

> +SEC("socket")
> +__description("s>>=3D31")
> +__success __success_unpriv __retval(0)
> +__naked void arsh_31(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	w2 =3D w0;					\
> +	w2 s>>=3D 31;					\
> +	w2 &=3D -134;					\
> +	if w2 s> -1 goto +2;				\
> +	if w2 !=3D 0xffffff78 goto +1;			\
> +	w0 /=3D 0;					\
> +	w0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

Tbh, I find this test case a bit more convoluted then necessary.
I'd use smaller constants, removed the 'if ... s> ...' and added some
commentary, e.g. as below:

SEC("socket")
__success
__naked void arsh_31(void)
{
        asm volatile ("                                 \
        call %[bpf_get_prandom_u32];                    \
        w2 =3D w0;                                        \
        w2 s>>=3D 31;     /* w2 is in range [-1,0] here */\
        w2 &=3D -2;       /* w2 is either -2 or 0 here  */\
        if w2 !=3D -4 goto +1;                            \
        w0 /=3D 0;                                        \
        exit;                                           \
"       :
        : __imm(bpf_get_prandom_u32)
        : __clobber_all);
}

As with original test case, the test above fails on master but passes
with this patch-set.

[...]

