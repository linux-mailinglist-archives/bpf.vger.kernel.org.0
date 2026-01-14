Return-Path: <bpf+bounces-78816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED322D1C227
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B9B530039C2
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DE2FE577;
	Wed, 14 Jan 2026 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxhjmmXL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41811850A4
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357721; cv=none; b=F/0gszpBDwUoSlCPuD2C/eucHsnRmWgZ9hwWxaDKW+dHRempGvUy43uiecnurwrUOLM9qO2XcEkHXlevuA0nlLD/KeSFSeKMLWpMHhbF83dE2Y9V46Pzb67jjqdrE7oD1ln88QWDQJpXTg5bVpdki0BOE7iFIW/3Q3KCQp+0Kc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357721; c=relaxed/simple;
	bh=We8ksS5J9F+fwW62K7yMl7MOkJY7HqN+JcpNG1VVuBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGguveKyj2HGxrWUPJWc7+SOtzkUAfFWJLK/uOGCzTwLSR9O7JuZ1lViei0oC/py6Q3dyGBOy7UWdCkLjBM6Kyxk31+n7yEEY+v5dL0a+6ZQMXduS+L9zQdpTiExZnn75AK9J0C6P6M4iUOPVVeOPhFTegcxdD6SwCJAbyPOdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxhjmmXL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc544b09so6526876f8f.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768357718; x=1768962518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz2i6YPOO/6xi7igT30rHEGAb7MGWdjsESuKyerDuWk=;
        b=CxhjmmXL4an+7h2Ej2gAuMYrfb7D/45jDvlvKoNfNzdldwJ2qZONkHWKELJz5M/Yh/
         pFLKAOb0PZk06LPp5XmwF4rmq2yNYT5+emNJwt9ZxvZKLCcd6XOEkZWSntJ711Tp5Fto
         q9PM7crJ+ER+anl+Hhif3J8DkNLos3TNvG75RfHw88dZDF1KpMhPzHFAQVvCGORrSlZA
         W/VGba0YZ2zgbTFGBIE43jxbPgKH63WzAeDAMm9CkqxbY5KfE7ylXg+gvzxBVEBWxgh4
         l9FeZ36c9yS2JfkTV79zJMqvuWucrTT9F6a7pGCDgL1Zyhsm4nYlrXnWGeWok5apkRtu
         DZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768357718; x=1768962518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xz2i6YPOO/6xi7igT30rHEGAb7MGWdjsESuKyerDuWk=;
        b=tjpzGu8HzFtSnelKQtpaQqRgTN8D9jDJgQQ00OPS2dblhCqZeG2OzCuqWvDDs9Cb5R
         9tyRMv8BYm31g8aP2N8C8l1uoYnN4Xp3jemsKAcPwuukNb0OEaodNIaUyJXAuiZeIe7W
         CXsB4CKzg8iVVMGbuRc/r/fknKp1511G54Nhy++ga8Ad0kjZafwGp2g9ZVus49eEh7vG
         3XNhX0z3atRtY7S4lB+WGG2UhdROSRHigfwR8SQEHoFr9pe9iCyE3/fvmfVmzH1NN/P/
         p/Ng9bT0cs5hUb5NUVFrIAUj1adz8VIqtYnxEzzSWXh3MA9EDr0RUV3KGlJHe8CPA/jI
         7osQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo/vlHA01KyyyDWy6gLRa6r+VFL/jB6GrHusSih701ZbrPfluPZ+Q8mIMTshK/C4rI1OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiL1zDOzE3ipQhWyyDllE/9H/z7DEk1XgsXTecmRMi0BmRCsD0
	yLii3CapPUTEwVn3WbAUqwbqnNus6KVQUpmR4cxtwVOf+Q93PiZ2XOjuSavf2ThxMjTq24v8DP3
	+Xt/K0BxZwOKww4r/hWePeqJKGDXim+I=
X-Gm-Gg: AY/fxX45V73qsFV5WiccyKIQ6EKNAZ8f+3Wq4gvXGSnZsmajxVKWdHu10rr+OGcIS3p
	hkWNUkPV+Abaz+a+L6S2JsteNtUQYWxJ9jbfPMlqV/se55Km/X1hHH2kFAZK2pqd4Hj1p5QGaEe
	9n2mNuhwrfcBzcwL+6s5llTuyvxJsgFhT2mbPJlCPZZSpaiHLvFp7oD0wSfdlGVwmi8oKtLfiGD
	9fyf6bq018QLlW11K7fBMzDczuaUAcg7si9/9T3Ovqyng+j5WP5FJMkSMTA2h3rJNhpgcnsGR7O
	xCPsIAzsaLOzbt3yM2Cag6haFVl3
X-Received: by 2002:a5d:5f55:0:b0:429:c851:69ab with SMTP id
 ffacd0b85a97d-4342c570c23mr829306f8f.55.1768357718101; Tue, 13 Jan 2026
 18:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 18:28:27 -0800
X-Gm-Features: AZwV_QgcPb0t4gTbhKnWfWd-cjU6WwacBGBgmdh2yTCRVFbx1Uq28J6usLIsSEU
Message-ID: <CAADnVQJw6HZHqBs6JRWkHESk=tFQpki9X6TnXBLKgeAhb6FK5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 00/11] bpf: fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
q>
> Changes since v8:
> * remove the definition of bpf_fsession_cookie and bpf_fsession_is_return
>   in the 4th and 5th patch
> * rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch
>
> Changes since v7:
> * use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd patc=
h
>
> Changes since v6:
> * change the prototype of bpf_session_cookie() and bpf_session_is_return(=
),
>   and reuse them instead of introduce new kfunc for fsession.
>
> Changes since v5:
> * No changes in this version, just a rebase to deal with conflicts.

When you respin please add lore links to all previous revisions,
so it's easy to navigate to previous discussions.
Like:

Changes v3->v4:
...
v3: https://...

Changes v2->v3:
...
v2: https://...

