Return-Path: <bpf+bounces-29183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CDD8C1138
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB3A1F23273
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE751C686;
	Thu,  9 May 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G14Ebi3F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740831A2C3A
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265159; cv=none; b=kArJnv6wWKPfOGgEiNKYT7EJVTHufB95a75hvztJCpT4b4ddkHR8fzRXMhK0Mqrhm5mLMRFGANIsY/7ZfKEeozI8HqnO9cf+RMX5XBVdw+ptWrD1VeE3xQ8Tgox6e6sHJE3rAShFPJ1HZlpWdNHlnx+Z1wLNgalRC71HWzkVvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265159; c=relaxed/simple;
	bh=I0jIVuC6mj0CY7NbExNtkv1ECRmJa2h27GPwVcntkCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8tZsvx2KTQlyX/79Agac7B3/ehIQ7K6eLkHoTx/6ffCyOOrScsjYxGLRYGgfK0kKz1Y2dal+ndcOwKAHhC/xI12p5Yr/fGPhE0+vMWNxFOp8+XCrXDDsot4YF+fG3VoQQQ3QWAfJaSsdoEmJvlCrcYINeVdt+YQ7vkUFQGumH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G14Ebi3F; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34db6a29998so582867f8f.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715265156; x=1715869956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0jIVuC6mj0CY7NbExNtkv1ECRmJa2h27GPwVcntkCs=;
        b=G14Ebi3FHb8PUJ0vj3cajgM4QT3tEoFS3zcRse/G9966NN6bUTQS7P1gulkJl9vqW8
         qEXpHFSFge0EEG4SuIzTuLDf7qozBJ+PC/eeTGwfx9BvbuOlZDGsGbn4b+YdkDDSXcT9
         xHEmLA+U2fvs2VZ/krpm82kZrynwPdbPkLrUBQDx/cqSkt4IAiVCVjZRIga9xSzExlq8
         IwVgAiX2ho3d4qe+tk+fy0z2Zka845XJFqrVdDUQpnvi0f+U9gEQi+8SkFkEy4CwLjDX
         XmFiNiy41y0++7nvzCNsNI4200xJI0B4fWU3/WKTREMvig5a8sIVWzMahDKJCuoIEXFz
         BBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265156; x=1715869956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0jIVuC6mj0CY7NbExNtkv1ECRmJa2h27GPwVcntkCs=;
        b=D1I+KFVKZQzxKCEHwn1nEvQHfVnxuBAMBuYWCGqGRGuk01sXBI7bn48IobFaGUhbAR
         OU3gyjLaV6ja0Svrw5mg2X0GLqrEszYYKiAtoFG81lL/zAuGpBitPyPiXfjtDnqHyXa+
         sCNSPJMyoDQTCyiloK6s/X3JzPpUIOGXlCOZrYxygO8Hw0ajl79CblHlKy5uNk/4Q4N4
         MyJV2Yw7xMpWX5JYWuIW0u29UnvusIwmnTxp8vf2GzirfyD0A22eZe3ogUgi0HmaB25g
         DuijErPE9WfO2mLoigrfatrOtx+BwjZeWvBdRwKIMfGb90i+vgmzhxoAnEPzP69Xk3mY
         7RdA==
X-Gm-Message-State: AOJu0YxOtjr45KgMxJjZQ2S7EkzkD31/Au4fJUJ6Aemm5DN7GdhOlnak
	maVO37NH+0aTp+HFzaJwXiOMs/kMk0QnrEcg+e6BeRvZCjAjulawBZqvHA/2MGC1mPxMyY67+Sv
	6ruc3VmkfMjqpU7UHGySd7eRtUtt1Gg==
X-Google-Smtp-Source: AGHT+IHUd/+93RP/OqSDORzvz/1HJdF50uG5q+4N+NgRCpgLmhkPhHTAGtLouVtfnU0vw5aycLgZqiYzVuu75JMtgd8=
X-Received: by 2002:a05:6000:124d:b0:343:e02f:1a46 with SMTP id
 ffacd0b85a97d-34fca149d44mr4388571f8f.2.1715265155500; Thu, 09 May 2024
 07:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2147ee76.10bf3.18f5dadf442.Coremail.sekiro_meng@mail.nwpu.edu.cn>
In-Reply-To: <2147ee76.10bf3.18f5dadf442.Coremail.sekiro_meng@mail.nwpu.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 May 2024 07:32:24 -0700
Message-ID: <CAADnVQKroXpteX+TvWja=BOC-hLbKgaGMt-5GJ2ZfxEQqK5Q2Q@mail.gmail.com>
Subject: Re: [BPF Security] what security properties does verifier guarantee?
To: =?UTF-8?B?5a2f56Wl5a6H?= <sekiro_meng@mail.nwpu.edu.cn>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 7:09=E2=80=AFAM =E5=AD=9F=E7=A5=A5=E5=AE=87 <sekiro_=
meng@mail.nwpu.edu.cn> wrote:
>
> Since eBPF verifier often changes, is there a conclusion that list all th=
e security properties verifier guarantees? With the conclusion, developers =
won=E2=80=99t make the same mistakes due to missing some security property =
checks.

safety !=3D security.
The verifier is focusing on safety for 99% of the use cases.
The security static and run-time checks are for unpriv bpf only,
which was disabled years ago and strongly not advised to be enabled,
since CPUs are still full of speculation bugs.

> Since we didn=E2=80=99t find any public document to describe the security=
 principles of the verifier, we have read most of the checks in it, especia=
lly for the full-path analysis (`do_check()`) and related function, and we =
summarized the security properties (for the strictest case) as follows:
>
> 1. Memory Safety:
> 1.1 Programs can only access BPF memory and specific kernel objects such =
as context.

No. Certain progs can read arbitrary kernel memory (depending on type and C=
APs).

> 2. Information Leakage Prevention:
> 2.1 Programs cannot write pointers into maps, and calculation among point=
ers is not allowed.
> 2.2 Programs cannot read uninitialized memory.
> 2.3 Programs cannot speculatively access areas outside the BPF program=E2=
=80=99s memory.

Not true for all 3.

> 3. DoS Prevention:
> 3.1 Programs cannot crash while executing.
> 3.2 Programs cannot execute for too long.

yes. that's the goal.

> Is my summary right and comprehensive? I hope we can negotiate a manual t=
o conclude the security properties, so that developers can have a reference=
.

No. Since security !=3D safety and sounds like you're after 0.01% use case.

