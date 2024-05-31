Return-Path: <bpf+bounces-31055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2388D677C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450D62853FE
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358015CD7F;
	Fri, 31 May 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFQpyJUg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F85158869
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174544; cv=none; b=m31BnLKg4CEg5sEeR8DH1wvhwMOSJtnwP63ULLNxONEda6bBAcHdierq5g/Ac5ebrgwc5IbXJDAB/tZa6RDeb/pwIFd9B2P0tNw6AGBSEXWbrpb/vJplllycl7U1mbvX7eXMBTHlum6TpmEAKhP1w8/2a3SNM4zO3jNxkPfGTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174544; c=relaxed/simple;
	bh=1lxgFlb777rziaLZ+lY+B+VzP8Kp3io1m3gGNeDjLvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbobUd683ucmsIqG/kW+10D6kjmHonsJgAwEwrCM7UBomOpe19xdI64WS7G1edLEvXR0NbTyApfN0N0dfmJnlpoeg0nEhVrLmx5EAgxVGPqWvLUQ7bjh1wKSa6JK3a6PXTmpA/ZxD4paaUjxzvWTC9UAUUgHMmv3nPKYPoDNEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFQpyJUg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35dbdd76417so1572214f8f.3
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717174541; x=1717779341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQY6KeUNSzMzvNfb6qKOB5uCpAIDGiAhWyjSBF9LF9U=;
        b=QFQpyJUgbsiA7wNw11e54zn806e2Ijk5Qrh+ZkU3wkngoBa/RqrC50Msg2eIIp+Y3S
         t+GfpgVQeGzN9XB5GUNYUIehD8BiOBfxpUJfv+dR4HfdR3Tu2yUs6A+qdNRQZp7dVERE
         0Pik9nymlGCRpczRy7kVspZ5MqddcmAF+AHKOYyNG3gAcJfH4/1D67fAZjx0lqfC25p8
         BNmBpGa57IxRaDpZQavznvMr/Y2R8RpS+Cf81DoZQxPUnkD+bsx8kt9rLPs8EleBGR7b
         ARp5rCNvyQHsLBWRA217UMWzmakNQhYErq6zmX3OoApltLIssEtRVMMcdkuduN+xB3Nk
         LV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717174541; x=1717779341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQY6KeUNSzMzvNfb6qKOB5uCpAIDGiAhWyjSBF9LF9U=;
        b=o+DxxNrTrdabiWnPS1g4DOH1+QuIXJD4L0Hmfqu1dfwlj3ufiUdD3beUXJZuupoamF
         VgKTiOb8NuQfb2dVtZ12hyy6W489jfMxvXBeeRen5yMVMAxWrDwbYJ1KbuenJkI6J7tt
         DS6AZ6IsWmnITEMDpZDCku1ZfrDcttHXGxY1P/g2uhhGIrg7OSm8jRWCDVOQwqn3oro5
         7GwuRAFrwxGvcPELNxIgLZM/fuY0mhrZU/QjxlckzyQ8QUxzYhNHivAjBj2S9f20norw
         XsJ9qeMiI2pOnoJi2sZiUxKoMm19ODZfWi7kmP6aNk7PE95s281+zi/cWP+szqvikwGY
         LAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBst0UKK/EMxIfjg74+tDXf9pxybUS45gc8JQDb3kK6SaEVPxYuZyiZ0n9zeZnwNOC9pz65rSJ0ls+ivqmzMN/pOih
X-Gm-Message-State: AOJu0YxOnpc5EOldxYPuHiJEBpK5nKPdTR/O+EX/8O6LcxW/aKqPvHl3
	rqvVd+4kmW03SnfYgJTQ8tZ/y+qze6DVRqvZBXs/dJdond9/KDfJXFN2iWodkSf5Z5QEfXI5LiW
	uyg7J4NBncCgijmlBAYdNG4aRiQ4=
X-Google-Smtp-Source: AGHT+IGjIBLcPtv+zDnPs4Zkbu+kAlHMkSriR+fFYf4UIgUZd8fWWbuZzGpNcn2pKUgu4fD5haHKWTLOyzK7zW87lRQ=
X-Received: by 2002:a5d:438e:0:b0:354:c43d:d5a with SMTP id
 ffacd0b85a97d-35e0f26984cmr2240607f8f.24.1717174540500; Fri, 31 May 2024
 09:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531101550.2768801-1-jolsa@kernel.org> <20240531103931.p4f3YsBZ@linutronix.de>
 <ZlmpoWed0NmeZblH@krava> <20240531104922.ZgOadg-G@linutronix.de>
 <ZlmzmstEQSMp-6_i@krava> <20240531140422.w6TjGRAt@linutronix.de>
In-Reply-To: <20240531140422.w6TjGRAt@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 May 2024 09:55:29 -0700
Message-ID: <CAADnVQKvQuHBa2TavmuYJzQzi8ZHf+euJ8rHEr_VJkDD7+w3xg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Make session kfuncs global
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 7:04=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-05-31 13:25:14 [+0200], Jiri Olsa wrote:
> > ah there's also CONFIG_KPROBE=3Dn
> >
> > kernel/trace/bpf_trace.c is enabled with CONFIG_BPF_EVENTS,
> > which has:
> >
> >         depends on BPF_SYSCALL
> >         depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
> >
> > so I think we chould combine both like below
>
> Yes, this would work.

Makes sense to me as well. Pls respin.

