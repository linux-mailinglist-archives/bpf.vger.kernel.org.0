Return-Path: <bpf+bounces-74917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D89D4C67C18
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 07:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F188360DD7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC12EBDD6;
	Tue, 18 Nov 2025 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqk4b4bk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C12C235E
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448085; cv=none; b=KQBDHZgF80dKWOAjOiStWH0Zuhquqn1ke85O+K4EgK9NA6nAlCBYqvJ0zvc9t6aOfn7FKgeaMFc34Ks2WaETr+cHIkyT8E//W1RW1ituVp3L4JSgBUTV07xtj9EUI6cLejLi+cAUXmYSIdCAfi6ZoW002FSV9P5aToUcUn65pUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448085; c=relaxed/simple;
	bh=B9VV4F6WS326/3v5JidjD/layM7laUwdlNDDdunzeh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDpCjfrfCGKRcoiE0Pg1MJ57yu6zKN8zAeuAjYPk+xHrU5ZDro9X/3FcPiic2b1Gz3qZIth+CTY0PtxhtWcT8o8kk28elAA3q1aNbdxFTMo8+z2NV3I/4/aB2Q7NUO0dt8y06YuWroYaOMK8rUXh6BpCEDfZRV27qfRS4/yEh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqk4b4bk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c48e05aeso3059537f8f.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 22:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763448082; x=1764052882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9VV4F6WS326/3v5JidjD/layM7laUwdlNDDdunzeh8=;
        b=Oqk4b4bk/AOkDKHVFwkLZEOnvma205XlX0h40hJCQ/AxBOxssn3vZcrqs+Y7n8q3iG
         vP7B6QluYc0VojTpS83WajmjP8XG4+6ww54coVM2+zJZjhn5PDYyTVeDHeMdq+YzqoMv
         sPnX+fhnfjsmuzd3aIx7jS9fKLMayl261nS7LFhgSElJTs48oH2p1ehkmbDwH3LVIYu7
         qCy/pge1/w0ER9DHIUMfr+G2yexh5ldjUqYLaC69fhYgFlO48h3Lwf0yYKDOQvL3KLJY
         TMOwqGwP65p8j3V6W1/ERGDpKo9ftxZsBImhK5ptCRWUBo3zKPp0joGY074aV3miq9Ll
         /DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763448082; x=1764052882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9VV4F6WS326/3v5JidjD/layM7laUwdlNDDdunzeh8=;
        b=WuvyuRPq+vwSdEgAWD+n27TVmVh6xIELIh0kSdhl/suD0oUZfFKpXyex91HAjLESj4
         FwYopviE7i+mooTAH4cUFFYDdmh8zBTl1RVxZPnz3o2y/xHToUmjRzF0Gmxmr3By8xj9
         kiNmrvdoFBmFfhfXrke/nUwQnCaLJlzIX5+XmF7JsqbinboANiZD1HktwmU1KZYkSdO2
         hEcUQkrZaKNy14QmfV99vk1jSIgwdm2AtQKskHA0eOi8MJuNW60RF+8IKwIQzWfEr282
         6sr297cCSz6FTnThEhbC78P3KwNb16lpYXm3SnrxT08LVey+v3g9UhZqkTPRKjAM12wC
         qYSw==
X-Forwarded-Encrypted: i=1; AJvYcCX56nOWb2g1nAZoQ3OvOhw4hl4EuQyrdnqA5/njCVPMif0kB/uQF1I/UVpGfvQj6ZTJ2TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9yZA9R0xonnGyYJJ1rRnsveixAXpKeKAuzORi+jPx12FbH7s
	xPQH9qX+24pdkBYL4YqqtCO7PGGo1YRh+CAVWpzBSjqHhHq373QNbN4ifxNW8cJE1oWiX4FKfx7
	26LZQajFrxZRkSgsE9asIUtKpfXc1tvs=
X-Gm-Gg: ASbGncssX16+O9lwSLUzUEIEH2kyOco3fuh/yL+1RuY5ooCsyhXxIOQCdI/m3oeEJFJ
	8noT4I/g9v+8zEdWUU2/l+nMbmsQLo8Ad34pr+vdJLQNO+/hiUMAM3QdENVgDDK12ofL34QPd6a
	I4gReLGSLO0524EFhu5BReoLId8oiDFKIom4K18/p8oVrMFw7A8QNJap+6B1Mqf2srHpMuE3Qbr
	oBBty26xUPTvGh4bSrrfx+QUrLpncNIzxES7dPSSz1stCIoPzkGXxvBSu4F9o1A4xQJC6EnUiMR
	zIpwwyIX
X-Google-Smtp-Source: AGHT+IGYw43Saj5wt/rZ460RwZ4i1cc6lnD0Z6zx8DP/I6oYJSDdRNppLjZh5UGOeVwtyuLggmkpKe1rUIzpM5zG5fc=
X-Received: by 2002:a05:6000:608:b0:428:3d14:7378 with SMTP id
 ffacd0b85a97d-42ca8bd26b9mr1890608f8f.24.1763448082258; Mon, 17 Nov 2025
 22:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
 <CAADnVQK5U28Wv2tSkymZY6ixCoUrSDoohB5wJmpyZL7t-Czk4w@mail.gmail.com> <5027922.GXAFRqVoOG@7950hx>
In-Reply-To: <5027922.GXAFRqVoOG@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Nov 2025 22:41:10 -0800
X-Gm-Features: AWmQ_bkj1_OP2_qbb4x4IdGdanASLrhPBYZsTkYyC_OZbXKBdqM8i2nVWit9MFU
Message-ID: <CAADnVQJtm3pHFxYD=_FPJFiMNXwo-scj5CoNL5jHbUn+E0zvrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] bpf trampoline support "jmp" mode
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:34=E2=80=AFPM Menglong Dong <menglong.dong@linux=
.dev> wrote:
>
> On 2025/11/18 14:31, Alexei Starovoitov wrote:
> > On Sun, Nov 16, 2025 at 7:49=E2=80=AFPM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > For now, the bpf trampoline is called by the "call" instruction. Howe=
ver,
> > > it break the RSB and introduce extra overhead in x86_64 arch.
> >
> > Please include performance numbers in the cover letter when you respin.
>
> Hmm...I included a little performance, do you mean more performance
> data? Current description:
>
> As we can see above, the RSB is totally balanced. After the modification,
> the performance of fexit increases from 76M/s to 130M/s.

I saw that. I meant full comparison with fentry and fmodret.
I suspect fmodret improved as well, right?
And include the command line that you used to measure.
selftests/bpf/bench...
so there is a way to reproduce what patchset claims.

