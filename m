Return-Path: <bpf+bounces-14611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368EA7E70FC
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8090281337
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2E332C70;
	Thu,  9 Nov 2023 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axJnsi6Z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA3328D8
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:58:56 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625DC3AA4
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:58:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4079ed65471so8310985e9.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699552734; x=1700157534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7HnjWmBJv9GkjJuLgsF4IbtaLOmPDCAU/n5FmYWsD8=;
        b=axJnsi6Z3pjGN8ER5aDnSs89QUAbXRG1aXCBUF2d+DJlMlo1MOZcmkAAFDe8CgzlNJ
         5KYL8f6NsgoSXC8d1CWC+nac/KGcNKXPKCzgAPL/a5mgzpWrOTarQKwvxKZJy4V2ucLR
         r5ojO2vfkD1IhIWOmp1hvwdHaTpD6HeauNfAl32NFQf1PuzbpMgC6CfKVVeTSXpUL40U
         l8C2xFqKc0ATbEWsYWu12xh2KxQmCXs/FACMGBm2AHF3pBd3a0PsMZD2t6iYAFTLjOu2
         VxWMVj6UcWOxE5Euy7j8s6QtejPzXC5Rn9pOB7+4HNENvC5+QyssaWh+JLHBzFR9Bsxj
         CeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552734; x=1700157534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7HnjWmBJv9GkjJuLgsF4IbtaLOmPDCAU/n5FmYWsD8=;
        b=jABQtVMfZAmDXwfYcboDAlRVVeYWK4y1lyaCIEUCGwiLwN8ph5NEpG4IauzO7MtMIV
         hEgjhuNZV7sSQyEbFlSA8q4BX5+1rBjECLomew0jMIwW7h5tcteQQnoQVJxk69plbZve
         DgDOpA3TQyc1dgEgW7CuihDLcSlmC0pMjqNmKV2cLzi+30CQoDSwtmzmA+teoCgtOPKv
         c0GWQTvR+fhG2FLNZ3yoTMPdND4wUnggn/qDpTeo30QZqaj3ujxe8iXyIzaigekynnyu
         g2kG1miIvUiPM6VQUXoLZBo4GvcU+K6lssZfRqbdjpEPjxCR9a9nR6sf7oBooPNqYC1f
         m6hA==
X-Gm-Message-State: AOJu0YxVX2ZJYym1kYYo3L/weBX9UneHM+RuM9QR7kzN5SoFzsfl5yJY
	dp9+8+UmTpSujkYeGnOKGxOmz15eEqpJ4melGaA=
X-Google-Smtp-Source: AGHT+IH4niJdgmw7ZpufpMOIlQt2D/3ZA1p4VMXbKma64Apf3PoN7YdDX+CCh+MP2+AOBrDwLOJkSb/YT749GSNdhvQ=
X-Received: by 2002:adf:ed06:0:b0:31a:ed75:75df with SMTP id
 a6-20020adfed06000000b0031aed7575dfmr4288292wro.15.1699552733406; Thu, 09 Nov
 2023 09:58:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-4-andrii@kernel.org>
 <71cc364752f383559c7d7a570001fd353f0ca8aa.camel@gmail.com>
 <CAEf4BzY1-mcN5Wjf4-FOKQvnom+0EV=a=cGxvBO9=rbCS0kzwA@mail.gmail.com>
 <b335aa904dca981058e1db92b6270960f2a28948.camel@gmail.com> <CAEf4BzYHOMgxE1NitS_8YosrYWFzZ-BT8qL=Fnyna9tDA2M+2A@mail.gmail.com>
In-Reply-To: <CAEf4BzYHOMgxE1NitS_8YosrYWFzZ-BT8qL=Fnyna9tDA2M+2A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 09:58:41 -0800
Message-ID: <CAADnVQ+wMq36--Wp1COwbfUsCNo7q1JyHh+QzRvFNNmkvdsmEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: enforce precision for r0 on callback return
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 9:50=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> >
> > The r0 returned from bpf_loop's callback says bpf_loop to stop iteratio=
n,
> > bpf_loop returns the number of completed iterations. However, the retur=
n
> > value of bpf_loop modeled by verifier is unbounded scalar.
> > Same for map's for each.
>
> return value of bpf_loop() is a different thing from return value of
> bpf_loop's callback. Right now bpf_loop implementation in kernel does
>
> ret =3D callback(...);
> /* return value: 0 - continue, 1 - stop and return */
> if (ret)
>    return i + 1;
>
> So yes, it doesn't rely explicitly on return value to be 1 just due to
> the above implementation. But verifier is meant to enforce that and
> the protocol is that bpf_loop and other callback calling helpers
> should rely on this value.
>
> I think we have the same problem in check_return_code() for entry BPF
> programs. So let me taking this one out of this patch set and post a
> new one concentrating on this particular issue. I've been meaning to
> use umin/umax for return value checking anyways, so might be a good
> idea to do this anyways.

Just like Ed I was also initially confused by this.
As you said check_return_code() has the same problem.
I think the issue this patch and similar in check_return_code()
should be fixing is the case where one state went through
ret code checking, but another state with potentially out-of-range
r0 got state pruned since r0 wasn't marked precise.
Not sure how hard it would be to come up with a selftest for such a scenari=
o.

