Return-Path: <bpf+bounces-74128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA7C4B3B7
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7441891E87
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6087A348889;
	Tue, 11 Nov 2025 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfjB0TpC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7533B973
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828881; cv=none; b=RSP+nwrN2N4vMVKVNmlENhBX8fNdfJzs6oIp6dX6YZfl9/5RifI4k6z7+FEPUTPe1mB4M6aQdt/1a/b+NrCpdABhmB/3dugBQ0Q3eYg0zVVgZnF+9Uj8LzTba/7IeA1E/dZqNJ0Jgj6PCGzCNFXBGMLyliBZHqf+3TRCFNY3oRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828881; c=relaxed/simple;
	bh=j8POPbpxSpPL02DZDm+FAXFDTPUlIreAK08ihYfV5Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MstJhlrkFy0I4BO54lRMY59M/8WrNrsTd6ZvEjC1C6P6b9qUOrHbIiokwzMjr3L4uuYhve9hhHirFdYDslmfUQCQ2jWciLIyuxf7e1UwjaqBn0k0QSxXVI4nnW/TcADIGCOqgtZr4bpG7T/YmU+GDNhF71uy3ZzyIa32fjvkquk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfjB0TpC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so876996f8f.3
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 18:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762828878; x=1763433678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8POPbpxSpPL02DZDm+FAXFDTPUlIreAK08ihYfV5Ow=;
        b=hfjB0TpCEo3kYg32fFZRXiDrqBOPHYThtITRucPce04EEJWoONjsFKUNUzBq95diT7
         CfKhJtMwnQUpPZXpTtfyZc/32etUp2hn7fQve40uCOcuWqIZXHGFXzLKqrlT6qxZVvCL
         IL7hGx5ndeRMW6F9XkNPTsFoO3mvfuZaNdAYAR9e3ecb1mvaj/Mdst5I52cRHOpOq2uD
         JdCKWXCYtRcS3nukn0tP3kIvhEwONNpo0EJ8V2+d5Dpl0YBaCajptpp+pZiTZ8eFFg1t
         8puP+SUzVlM8Y6hzRVtnwMGnuusohkOSkR/Vt5lQLg7KlM4hD2HVazQ3jBiq24BYuOM5
         nXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762828878; x=1763433678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8POPbpxSpPL02DZDm+FAXFDTPUlIreAK08ihYfV5Ow=;
        b=qZAWZ4MTY7nF3DMDRc/G5Ys5Xsn2jEflwc9Kwjqsg8Pgfy0/1/XcHjtQE/WKl5Gw3C
         Ppl27PCQEwgGedVG5oivRHH8nuPkpcvTIdigycKSd+/2QThsQIdqun8AxoHYNvjwPxSc
         dW6qJ0GaU8srVdzlMbJLUroGVg1f0sV+9LERJ77GQYpiUMG4cVjzvw3fcf96z9n1ojbt
         g6ANGnxOwJ+cVo0dH/DT7AystGixMdfsMC/P1VO3yEXfwQaoxj15iZBjsvZSHQx7veuT
         +BL1xy1BWiKs460atLb9X8hJ4fqNnv8ryMGE5ZQbQFrWf4tjdVSZ8ZmGklkInFmztlfK
         bmow==
X-Forwarded-Encrypted: i=1; AJvYcCUHCsC3oPHdGGT5NHs3sZRQ8Wi4yZ0Ss4jFYERsU139wsFxLyKll8bkJPJaxOrQ8ZKRqq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAt8UoWAKULfuMu2w+C1ZMIcdb42NfdMZJ6nEnGvowlwv1oLB
	+2k/OSMWfAoClDo+DE32wMqD/CaSijobxbCGAdyfWGttcI01HXI2x3GcekVez4YUb3bh/xya8Ei
	ZvyzU1yclfrCU9dI853wpXVPJabhPOBA=
X-Gm-Gg: ASbGnctPl5b4hrj8QiuYw2KHiYvAZbTTGIDeUk7p5UcRcKlTO/8KxiOWDI3uVTUqQaO
	xg7FJ1ts2zZYxW1Ty7tV858TQ4N2Eh/TkjZHMmcBMRWBJzFStHEp62898WfbPMXgUDj4tXUMPnM
	8xn9ZBT7wRRkGaVpMnVXuovMuA9tHLCymMmLR7kwyKrouqKI6C5jdw584PgngaFwo/W1HYqbaan
	pcCvyw7nfwHgN3If+fkiLaNgwKoX2G5rHRbECojXAR92kVs3uNDQvUi48d23gsmB8H4+CSXGRDu
	LB1mvmdhKX7EQ1+DgA==
X-Google-Smtp-Source: AGHT+IH25QaUjzLpQ0O3CRwITusfe6pCAMVCPN6AMnU+eDbCy0CGb6riE7azc0Q1GIAoescCF4JMVu/lrJ4ie5xkUk4=
X-Received: by 2002:adf:9d83:0:b0:42b:3083:55a2 with SMTP id
 ffacd0b85a97d-42b308356e2mr6235388f8f.63.1762828878146; Mon, 10 Nov 2025
 18:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <13884259.uLZWGnKmhe@7950hx> <CAADnVQKQ2Pqhb9wNjRuEP5AoGc6-MfLhQLD++gQPf3VB_rV+fQ@mail.gmail.com>
 <5025905.GXAFRqVoOG@7950hx>
In-Reply-To: <5025905.GXAFRqVoOG@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Nov 2025 18:41:07 -0800
X-Gm-Features: AWmQ_blf7ZxJz9aQNYoTKPbgJ8K03XqCzzaO2O8UCyW_1T8GZg-hL2D_ArTOHB4
Message-ID: <CAADnVQKxV7cvwvCMD29sqs8yt0-xQ2XVb-e6bxkTFZ2EzS4DMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: sjenning@redhat.com, Peter Zijlstra <peterz@infradead.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 5:28=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>
> Some kind. According to my testing, the performance of bpf
> trampoline is much better than ftrace trampoline, so if we
> can implement it with bpf trampoline, the performance can be
> improved. Of course, the bpf trampoline need to offer a API
> to the livepatch for this propose.

Sure, then improve ftrace trampoline by doing the same tricks
as bpf trampoline.

> Any way, let me finish the work in this patch first. After that,
> I can send a RFC of the proposal.

Don't. livepathcing is not a job of bpf trampoline.
Song recently fixed interaction between livepatch and
fexit. We will not be adding another dimension
of complexity here where bpf trampoline is used for
livepatching and for bpf progs.

