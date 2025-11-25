Return-Path: <bpf+bounces-75497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC3C86FF1
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 21:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17D6F4E39B6
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754433BBD2;
	Tue, 25 Nov 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzE44jCt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346E33B96E
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101849; cv=none; b=I4vqxkWyFizhzLuqhML9ZV3A4T/1uL3El45cN2eg4WkxBAa+PwNgjOJSJYtrF83p/gDhjAfdPzmGTG1Cr3KSnden5FDS4KMzvQzuaM1uN3u3TJW7L7sZC4lXupN9+PR92DAzsEgCAmaiVQITctMn3iFxtINrx2uIW2m3q8BNOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101849; c=relaxed/simple;
	bh=1PzS2N+z71XNXdUPEBhTGgqytzUXhsvPwz6YdnjW6wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejcLfPfMMrPaF/gwppxsT8+MCoqdlAPlSZgPV/0Dajiu64FCxhWmOmBodPKiIj+3loBoTyZprmLhTQcf83x//R8ydgMSmKpLhhbZFPSEzjk1KvLGL3VYKmpI6xf/zuCL8NtawkxCbotMBZ32uvjjQAGu15/+pu0H3JqcN2Tx/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzE44jCt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29852dafa7dso32205ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764101847; x=1764706647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKPb/Q8XRwdHjj4wOc0hfpXR1h+irCkwiFy/57BQFpw=;
        b=nzE44jCtgkbOMfUfyRqOiahP+sBeomlItsYXFGOzJlQQnLPu9Rg4/SJvXLgFtautnc
         EocDOQxh5uFGetDSDM/fZFxu10ADsCIfkBnS/hDZ+qXihamNbeuAecp8hwYtmGN49BeR
         HBhUpoYSll8B08OcnLCKEDdMyWISwEthZrFOLivRDpjsucblbkxwLIeKL4+N7Tfp2/n1
         UYPUihG7fTZS/HcUD4qKLPgmQbgsRUXNhNRiOmWd69KDrUVjcrhVQPsOGrnMNpmBOJRi
         6BZ7VgHtXaaCpZyPJka4KJLFnYySyV4+MiFYFkc0kWlEX2FHyBUgwHe+oGx4p7eEF9ai
         QrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764101847; x=1764706647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKPb/Q8XRwdHjj4wOc0hfpXR1h+irCkwiFy/57BQFpw=;
        b=pCX1rTv02pbTjURW4n+x7rjz7b8dunyYF4Lh2uAy17DOVyps7uhE9JfVt0Jgk6qCxW
         n2Eb5ManrnUhgrA+lFCdWfHi1R9t8onZRMqoV8f7t97ihzJqZ34oPZDaR4vCdwCM94HN
         hA1sHqJGhhESCBCeW4uxYyZx/WzSZKbTLskLX4NxVzlLwaUGkdcj4hZ2JTwPIMWTIVZ6
         4fPuMRCJz2YRBg572vgZqHAouYtecyfFyMJWEtpTMlr8a05Sd2HP/bnmuKAqcQ3QdSD/
         KJD+2tOgdL+uzrKv/qjQ+LoM4M6phqJ/45xlU2ibkl4gJnKJKgGdpSsIBur+Pd9ENmn5
         hizw==
X-Gm-Message-State: AOJu0Yww+LVO+KK9URnkWCycK7575r3faGOwbPiKs3AFU+44RhlCcUg2
	27WgdNEbyV+nXJXqrNKkkMmicJnKSxrFEvPijJsvLXCO+z/TwZwyFQGUOD3k60Eq+N7iGnoKW4j
	vol8Ped11Rz3yUzwHOctWEr1MLQ5rnJEV14ErLL5D
X-Gm-Gg: ASbGnctPh8/hkKROPpj30G5S79D156ucJ5dhj4c9daw7SfFKdZ6QjSig829KK6dFaOJ
	BCVwfpF8etAXdlbwvIL3gTfRTExrlEUNgEuoSljuoV7nBuGLkyEWD/uqqks/syG4hbjL5QGiwm6
	RtrzE/J/SLGjrUQayk7fT3lKUhUIIXH9PcFjC9wBOl8sAhEwKYblqjxPLGZiNQjTYyUWhejMhAP
	VOhBJ3Cl4l2tUESmkS0XvaFGm07GAOd0EMtiXw8xmIBBUNjR71Jy8lw8i9d4ScalvcU
X-Google-Smtp-Source: AGHT+IHvmsdQ1i3sD44wFN96KNygmmjaSKAmQ7+dJALul4ekMXziswltg2TxCwyuISJIXUpB3n1Fat9tThTJe8VkxCI=
X-Received: by 2002:a05:7022:6288:b0:119:e55a:808e with SMTP id
 a92af1059eb24-11dc32ab12bmr24513c88.11.1764101846546; Tue, 25 Nov 2025
 12:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728202656.559071-6-samitolvanen@google.com>
 <20250728202656.559071-7-samitolvanen@google.com> <2bcc2005-e124-455e-b4db-b15093463782@redhat.com>
In-Reply-To: <2bcc2005-e124-455e-b4db-b15093463782@redhat.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 25 Nov 2025 12:16:49 -0800
X-Gm-Features: AWmQ_bmVA2aVwPCG9RhBv6ys5ciK8JJKLwfzgItOrbXov_WtENqGlXcwruSRAdo
Message-ID: <CABCJKudpUh7i9PTWV_k5ZWehkyRvHcRTwSOWQu_1yjCE9h_bTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor
 kfunc type
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viktor,

On Fri, Nov 21, 2025 at 8:06=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 7/28/25 22:26, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
> > indirect function calls use a function pointer type that matches the
> > target function. I ran into the following type mismatch when running
> > BPF self-tests:
> >
> >   CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
> >     bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
> >   Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
> >   ...
> >
> > As bpf_crypto_ctx_release() is also used in BPF programs and using
> > a void pointer as the argument would make the verifier unhappy, add
> > a simple stub function with the correct type and register it as the
> > destructor kfunc instead.
>
> Hi,
>
> this patchset got somehow forgotten and I'd like to revive it.
>
> We're hitting kernel oops when running the crypto cases from test_progs
> (`./test_progs -t crypto`) on CPUs with IBT (Indirect Branch Tracking)
> support. I managed to reproduce this on the latest bpf-next, see the
> relevant part of dmesg at the end of this email.
>
> After applying this patch, the oops no longer happens.
>
> It looks like the series is stuck on a sparse warning reported by kernel
> test robot, which seems like a false positive. Could we somehow resolve
> it and proceed with reviewing and merging this?

I agree, it does look like a false positive.

> Since this resolves our issue, adding my tested-by:
>
> Tested-by: Viktor Malik <vmalik@redhat.com>

Thanks for testing! I can resend this series when I have a chance to
put it back in the review queue. The CFI config option also changed
from CONFIG_CFI_CLANG to just CONFIG_CFI since this was sent, so the
commit message could use an update too.

Sami

