Return-Path: <bpf+bounces-47995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D43EA0300C
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC687A1DD7
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16941DF995;
	Mon,  6 Jan 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ0F/mzh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31ED1DF980
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736189980; cv=none; b=mTxcR7Q6VFPxwsCg4ACLbDVrqkuQFvbmh/IWTnUzHBk05hjwc3iLumsoZCxSYHT4rV7HYMqgCv90rakNmQ7ro+WMb6Sdk2IvmmoLgf0BUEMf/nT5wqYB6dqm6Kxi99cXUlGBVCW0AcmFblAyr10pdww1odfnNPtoH82WfuBTR74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736189980; c=relaxed/simple;
	bh=mbfGYMECHmwrMxOisdH3Y/asmEaLjlfqbYVwM6YDo+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuQlJ3LjG0rTyCxQD8Mr1HMqzCw6RbP8ROEfLwfOJcZhUN2AeitYOrZyU9CtlZ+tSBOZqognljm5f37PKRskImKTV4/uREpIErzzDHRIJjaOiiQ2Os1MUgub5RSvNcTq05y42tu4CFOrEtTIVnOWB8jzbU+0Uuh6bXmfZuoeRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ0F/mzh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862a921123so9909486f8f.3
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736189977; x=1736794777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbfGYMECHmwrMxOisdH3Y/asmEaLjlfqbYVwM6YDo+Y=;
        b=KZ0F/mzhKdS3ufkDSfqrbq/C4TsCOIuc7pk+7/OinFDgHHyg3wM55Tfs8j3OmRvOZh
         eiiA2eU14EyPoNItXRu4fE2WQLKOFsrXnGbIZ3MbghTDYOqap76XQTtzZoU/Cwwl91LR
         hXbm+iKA6zyvxgdPY/m9ErQ5YR7dg5eZhvLdsA+X4UHgvcZwccriK9tMcxmarMe8OyNU
         lfSSwojOL0oixGAg4ZGg+xZBxJwXBlPUsblVljL8i5WxodDeC+9YP5nJ9EtpYsGyaRhm
         qN3whrme1qiSvNV9HHVlhdK3XtbQF2bSUJcB3WgxZc3v0fPaiWZWyISZEuG8Ft3mNOjR
         dnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736189977; x=1736794777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbfGYMECHmwrMxOisdH3Y/asmEaLjlfqbYVwM6YDo+Y=;
        b=jAjm/+jVKD5s0JVNt6J1HrqCh2DT+6dpfMmizN/7mspzTe6FYumpNs3MKeKv4kwXOf
         375uZzA8hxZmp4Uo51G1J4qfpv98fBx7zSGImb6skwDI4TYWF+gmKtGY2VW0zlCEQ3BV
         MgbjBU3F2KdRwTggLLYW65eo+lZpTe8btR1UESokUNg3PRXTt28bOE8fpgu4v6yPlhfF
         aOLl4UKIVydMGLGi3KLOhktMqWg1nVbHFONZq9ytKH0QAlRQe8+iIT/N8O5+6EpZeXDO
         dgMM/24sIRmNxt8IqNDDkF8v8UdUPlqZ1QJHAOMYB+s+arjTcoeQak8OHhkDAwNe2dU4
         wXDg==
X-Forwarded-Encrypted: i=1; AJvYcCWBmguyK51fYZlfM8HR2aD90XpWC3Lm+QMurJuO4o6oG4dxYNHl1e/fR34ZBH5qzMRO3eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyifS0f07MLWJ8TqYthI1qN/gG9S0q5o2Tl6+tSiNtSFEL9vTP4
	HD6LO+iHoLeyb1tow7lwax1PNYqwOcgcMlRowRC2SPyz4zCmIIC3coQAjPJosnxq0TWzGTOjsUA
	JI95XFj65a6rvuAXqHljKE2EEfSlF/A==
X-Gm-Gg: ASbGnctExdgLksdSWfiQaRNmhDEbj5MVlxRrsB2J5hg98LxYJEHQrjU8hwFGK+OqhEo
	4LcED4lOtD48wCPFZvkJOI3C1U0snICNoGDdMWJYF
X-Google-Smtp-Source: AGHT+IE/GXYyCqTk/aza69/gahjdgBoDLDwGkQMuD582t5wR+jZiKAtVUggMcQdM83m+n/9zO3WMUiNQ/mOzGOIxTo0=
X-Received: by 2002:a05:6000:1542:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-38a221e1f67mr46095835f8f.7.1736189976837; Mon, 06 Jan 2025
 10:59:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250101203731.1651981-1-emil@etsalapatis.com>
 <20250101203731.1651981-2-emil@etsalapatis.com> <ac3eda5992a9fbee296abcbc917d5521da0be83c.camel@gmail.com>
 <CABFh=a66Fk70ipHbrq+Jh-hA33vHq0fOJd+R9=1tRA1t212CzQ@mail.gmail.com>
 <fbc6c684c4d374a3b7b08198bf4778c05963a313.camel@gmail.com> <CABFh=a6a3OoFnVgKM1Vo_ierEH0RcUHtZQjvrr4570iRwMqgQg@mail.gmail.com>
In-Reply-To: <CABFh=a6a3OoFnVgKM1Vo_ierEH0RcUHtZQjvrr4570iRwMqgQg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Jan 2025 10:59:25 -0800
X-Gm-Features: AbW1kva2oVeVksqYmHNQeG5qwCN4DyxsJ5qvjhwTmQG1Mka3oU3EN_VkAQwSNac
Message-ID: <CAADnVQKE50-5gXEe9whudJuVT_wz26XXnvqKuvNSS0VALUqe3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Allow bpf_for/bpf_repeat calls while holding a spinlock
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 7:04=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> I see, thank you for the feedback. in that case I will send another
> version that handles bpf_loop.

I think that can be a separate follow up.
I'll apply the v2 as-is.

Also pls don't top post. This mailing list preferes inline replies.

