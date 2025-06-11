Return-Path: <bpf+bounces-60355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519A6AD5D28
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972C01666A3
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C1220F20;
	Wed, 11 Jun 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTJtKseq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B75213224;
	Wed, 11 Jun 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662437; cv=none; b=ivYIM0kG0aaQaxN3RuqeEB8cByHc+JJdpZesvFxZY+IFyHedx9FCNdzbkX0fHKiM4HC7r88q6PasxmkWZbR8gsrMSgdMH+rueVRt4rxuZ6KJI3m2gxaNHfQIm6Sg5kIvissn5PGrA+I8OSpXzGyJiWzFbfFwbDj9C+7UUjKzi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662437; c=relaxed/simple;
	bh=YZICx0KSzKcX7gcnTUFRwPR+ezOylYj6NCOpKgZqwYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8cAAbFkrtQQHVzReLV/Ez2aJMOoZAoRfZutqxDZxo0bs3LhZI3KNT4TAzry+jvhrPhOt6xCTjUZ8B0WoU9LD1D8q+kdDi6bcvMjzbFJIuAGXDTzIENVa7UCBsq8/55S/yDrHSSvCt6sV/gkt/Cv6TZkZQaoymAWrY1U1zIXZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTJtKseq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4E9C4CEF3;
	Wed, 11 Jun 2025 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749662437;
	bh=YZICx0KSzKcX7gcnTUFRwPR+ezOylYj6NCOpKgZqwYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WTJtKseqTuGizuHNR1aDk34b2x6xW25Zll2rcr9hzyo20E59IPzkyTBSFLQK0gLTe
	 Ufj+U9TyE1vchEn51LB3OkhewC5lJngK0YdpIrdpXYXMXZG3kGrEdGZyrilggLSvvP
	 x/8Rbzw1JF5VebVXUbQS5VZuS5UxtZh/BjC4khMtI3TI5mi6FR9sWEF2DevgwsqJYy
	 LdllSNuSS8lpjL7MtCof+oVzWqD1DQsVo5MKfKqHOD/JMu2dqF01G6Gc0Wfsq26oS4
	 Texp4oLexLhXTmu+GcU7SmnEHpv8n/37Jg/9g9lsZI9UNi/q4leDOQcr4Gaqp79sZL
	 1DqLUIhU5FIdA==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fb0a05b56cso2262456d6.3;
        Wed, 11 Jun 2025 10:20:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUA6QV0MUIdFMf+lZdhSJnH6xwJ5ZcR3BhTGiQHmUWrZDMr88MmhZxQN2OLua+XpUWty8k=@vger.kernel.org, AJvYcCVg8TYGz7SE3gQDUFnOFbXVitGa+vWoRX+rIHBIlCXMEv0yZstWM1LlEwAIT+og0z8Udx+7ls2xebTfy7Ew@vger.kernel.org, AJvYcCWJVSKvy5Fg0pK5hOx1Wlu+X/I8K9bxckS8U1r15TN2Z2aFENqTxPEfYW1eeT+berwifsC3TmMwyGzcAmGWL6Hfw7rH@vger.kernel.org
X-Gm-Message-State: AOJu0YwIiA7IDkdxzSkQ+Tc9xiSL/jvFmwpLfzPZj6Ine2xeDGCH+/ch
	1Th67ZpVoCV48Oy6dTOhhdggOaFSxDOJmsQZJrtlOECboZfw75PEFCiL+GQX68DCZEKIv3r9s5F
	En61scsW1Q0hMnqOQCHsS6jPt/SLlGBk=
X-Google-Smtp-Source: AGHT+IEVXtL8oSFPZ4IKwlc45sx39EmMBPKX56xW/hjXfI79LlsTkEJ5SAx6+Cq/ZtYXcRFK7raxPOXw269Fy3iNVHE=
X-Received: by 2002:ad4:5ba6:0:b0:6fa:bb44:fde5 with SMTP id
 6a1803df08f44-6fb346190bfmr5884426d6.17.1749662436376; Wed, 11 Jun 2025
 10:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611154859.259682-1-chen.dylane@linux.dev>
In-Reply-To: <20250611154859.259682-1-chen.dylane@linux.dev>
From: Song Liu <song@kernel.org>
Date: Wed, 11 Jun 2025 10:20:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6ibk-9J21sUWkEbbQEhnFHpD4kT4m=KDQNYhk=9hZdWQ@mail.gmail.com>
X-Gm-Features: AX0GCFuJ8rNu57C9FJ-Wz3R5VfjRW0Vsyy5lGcpdRHFGBSp7SWZZftUouh-S_XE
Message-ID: <CAPhsuW6ibk-9J21sUWkEbbQEhnFHpD4kT4m=KDQNYhk=9hZdWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
To: Tao Chen <chen.dylane@linux.dev>
Cc: kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:49=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> The bpf_d_path() function may fail. If it does,
> clear the user buf, like bpf_probe_read etc.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Song Liu <song@kernel.org>

[...]

