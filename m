Return-Path: <bpf+bounces-45699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AAC9DA5FC
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 11:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B28163F5E
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818F198850;
	Wed, 27 Nov 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGf4ZUE/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD80195FEC
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704003; cv=none; b=IHTE9Tbl87PtVEXDGE2pvpvQH10d1v5woRzH/3SAnWx219Lcph5pSHDr3/JS7LjlUVHDNTjFSrjcSd2XgL0Ku3OSGNNM4GSmZ1F+tICpUj1zVYeh5OGn28CagPNRbVz+oA2c1X9wybleBs3YOD+Gm21lsHsXix/X9QRPZoK7VQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704003; c=relaxed/simple;
	bh=YAhRCQad9Fl4phrqCGjZO+vojAEemq5NZZJCL/La2hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAS4EipNsCDQS9xUSO7RncZ0RYrLhwV7sWmmy2ViH5dK6T6xuSRSMbwrmJcoIfvKt8XCUVl01yx9AsjWU2lG45bWiTqDlMir0Xl8KH6N44JtrtmQUyuBlyr6w42zFD8YLCcdOhmiKYXGaykaNpJtUpBAJ0ENmwY2e6+zgFND7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGf4ZUE/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea9739647bso5193126a12.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 02:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732704001; x=1733308801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YAhRCQad9Fl4phrqCGjZO+vojAEemq5NZZJCL/La2hw=;
        b=UGf4ZUE/azqXHvTxRc+yubhctdHB7I2hvkktyNjktSw/VqL2rcOWCx/xxeMAgtv1ff
         /zUmJrR3SKsazMNpEYSlDHL0yeIj+FEfnKFAAgwdLwEl+OGtSqU79YvbfenajnPRlih8
         RVQ6BaMzEBegpcCyYf6yz2mYrtfwA5kIs7/1oCMJitqgYu33/yyiptVwWQKRT0h20DTh
         Z8vWZ4ejLp6cqszhMs70soLauF8kadhrMUt2/qMY7dtDFOCv10EhXZBS8Ro1ABLMANU0
         Wab0AjESvFm/KnpOxU2SC9KDkGwZrDs0jB5OY25kb/rjkXgFS1bdmk3RC6DPX9BpP1hi
         55/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732704001; x=1733308801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAhRCQad9Fl4phrqCGjZO+vojAEemq5NZZJCL/La2hw=;
        b=N6md1Ifv4rfM6U3PnahhdB1kd7wEOPxLB4HseM3PJStFP61YzDsWC2vbyyUL0BKHMq
         kkRu1ECHo2Sxwk6kEjzhEeVbSJcE4a0swahI/LZEaKvX2YcH5HbAytaRFWdvDBcZjbm4
         QYpmOACQuOjPHzLQ8TU5GLFrTGjWYWxDqS//zNAQ4eTlGPQOdcabNC719JCevbOKi2/D
         V0LoOKLB7DpJXfKjC1bmvz59dafjnUa0f7S5YiOelS910ubfhvrsCIk8zZyGIVjyWkBP
         T+yUd9oj6xxg2EFSynvjQ65fhOP0ZDKQkR4Lj8XKLGC1kegjqncFoBqGSNH1BbHAA2CI
         EcDA==
X-Forwarded-Encrypted: i=1; AJvYcCXDnfTpOnUXk5L66X4d9Fp7ILaQQF92iAMkBTxRkGwIDiEQjDOeCKhDJIQwR7PM11hsNbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVT3b3ipgXaY8gD88w1/8Wdb40pNIghghrRAJdpKsWvikxVy0
	GKH3GnV7bvVrJZJJi95FMxRAoMzhZi9mevkptI0GCTqRcye3fG7VEfPivLd1MKxizreTGx2QRUP
	FccEkr6g0kS2sloxUwEEKNPtNIvq2S2Pt95E/
X-Gm-Gg: ASbGncs6eVcOGeGbzcyHAvyzKCgKDr9drgszkq4lwA4kbeYPCR+BmskhKVQpLekFSkt
	GtFBMAeIiyILcb8n88yYfKSmLzg5Z9pH5sgTN9YFCi9A2ju96Gy5gyaA762rp
X-Google-Smtp-Source: AGHT+IHPgg7jOSb4n1FJaK9z+pT3P/39rZh85gc71gfy/mp5/MtBFS3bSZy7ijgI60+hE3Uvgxy8QvoOG7YZhKKkocg=
X-Received: by 2002:a05:6a21:99a6:b0:1dc:154c:365 with SMTP id
 adf61e73a8af0-1e0e0aa746cmr3992920637.4.1732704000763; Wed, 27 Nov 2024
 02:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126165414.1378338-1-elver@google.com> <CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 27 Nov 2024 11:39:24 +0100
Message-ID: <CANpmjNNm7szX_9D9z2iYr4xyN57th0WMOmiipTCYYkSo-Z6rLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Improve bpf_probe_write_user() warning message
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nikola Grcevski <nikola.grcevski@grafana.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 22:32, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
[...]
> should we just drop this warning altogether? After all, we can call

I'm in favour.

> crash_kexec() without any warnings, if we have the right capabilities.
> bpf_probe_write_user() is much less destructive and at worst will
> cause memory corruption within a single process (assuming
> CAP_SYS_ADMIN, of course). If yes, I think we should drop
> bpf_get_probe_write_proto() function altogether and refactor
> bpf_tracing_func_proto() to have
> bpf_token_capable(CAP_SYS_ADMIN)-guarded section, just like
> bpf_base_func_proto() has.

Let me do that too. But as a separate patch 2/2 as it simplifies
backporting the removal of the warning to older kernels.

