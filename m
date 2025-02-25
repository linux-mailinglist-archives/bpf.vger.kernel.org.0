Return-Path: <bpf+bounces-52529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FBFA4453F
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1CA7ACB3B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9097B17B502;
	Tue, 25 Feb 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjT9FiLk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A881552E3
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499286; cv=none; b=V8SQDnAb9iRxmsqim0QJabx4qLSCmOCuKNbNvR4GdQ1ZIWWxEHqwlC53gVzhgm9BZkJAjpkEAT4HXx22DoOT3vJpS4adt4iIzP2x4H4+qOBf4pEgUW7p5m7ADbmPL71J027bb9B0xjn00pF+e7K5qTSRuOjhF2GeXPkjFRSo/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499286; c=relaxed/simple;
	bh=Iz83KN+RlJs4WG3DASbDriHPo8GFf73JECdxHfhDlO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHJSZ5rg1dtQx7fRg0bEC+HKt1qY7MQ9Ej0Jpe314xS1le/S2s2/9WUhYnEIZPVkM5xps3yHwH4df96BGnZU+NgQd9yQZjKge54w+GV2DspkGAJf8JYQpkKHOmSF+SA5vI0MyepmiYJ8hs8Og1zcQnBcK+WQ/qLD8K7//zS6Zlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjT9FiLk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a823036so55351805e9.0
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740499283; x=1741104083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lboLJ7wM5DE5qFdPMQGr/IeACUq5nlwGafSISnmeAI=;
        b=kjT9FiLk1r1qcpzw78KVj4V9bW/a/A3jZpbKS/O05sx0VTah2UBaS+fRL98DepH3hI
         BlD0uDGyZEK2A1Zk6u9v6pqE6XpWT9dkpKWx1qEqVJ19iVi7QliUk14fhNRD6xFfDT/7
         5Nics2kG1ljcpxlRB3QPNtxiV0VBgE+oCOimGrmOn0eQUnpsWHHWxmp2KYrDC/ViScJw
         Q0H3RTvIATOCQMhe5roztHFUns3a2mQZ2MsoFds5Z84ORUSJjPE4NUE506xgVtffbH0A
         ztUqz+86l+B0Yjv5pPbnQ0M/k8nyJwn+iuu4uHwJ828v7lA74PrJ8oYAmd1+GkRCH3fK
         nsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499283; x=1741104083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lboLJ7wM5DE5qFdPMQGr/IeACUq5nlwGafSISnmeAI=;
        b=HUPJaIPL9D41l1HN+IeAwbyTdo4TWcItV9O0bUsSQ4YKMoO5wgXvh5pCiFck9aImgO
         dtuxDgdqXGNDsl2gFJihmQMIyuxQgJej0/y/CakHJrzibP2RWmcRxsinY8Z8fH9EsYsp
         WWMPQ1omEQpIOwyItRvNROv8YG1VUwP30YSa+xX8K31Gm1hpjkTcT6vJyk6s2Iyjk13n
         ZjcCuMBdJscTGkLGJMd2SJwIxNppNr56BV1KiKT9o6lvJ/z1Lr3yxLrFe/LMLY4cd5Kx
         lxKWnCBcjUxiqcRS3RWLxctnq7cPgMA0sbbHnsk6+HLqc0X6NVDOQ37Q+tmSp5DTFitz
         ShSA==
X-Gm-Message-State: AOJu0Ywyjk/thpJsK/+QH1j/Fsu87DeZz1oMy+gUAyX08dAFxI/WJ5l+
	UafF+z1hYncFiqssJbhQi+cpnLtIOWHcwnXpIYsX7PEcorKmIfUGk8wUaGUPP3r0+6KINAODe3X
	XFVjd+PwU+NRuWdm56xdrkNyvAzE=
X-Gm-Gg: ASbGnctzANdk7isq+v5+tgZKzDoNjlr90Ea3Bn8ZScvKYOpOeVnJfyxd2eMJ8+gHzCq
	WnVajL6182svJ6P15TxRV0Omf4bhUASuep9usejlMPH3QxTgOWujYQ7WqS43DOWHoVfXp+TSHlr
	EhLxf63124B2ddC/pJZt6cXM8=
X-Google-Smtp-Source: AGHT+IGLku05IcsE0Zt9OKFhMBQ34RzduBS79+DdicmHQhRmnQP+wVMbjvcA97dTGmamYp8ZuSkSGiz44ZA7VYSxobE=
X-Received: by 2002:a05:6000:18a2:b0:38f:50bd:ad11 with SMTP id
 ffacd0b85a97d-38f707840afmr13963129f8f.5.1740499280818; Tue, 25 Feb 2025
 08:01:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224221637.4780-1-alexei.starovoitov@gmail.com> <df335e68-2b30-7cd3-1fb4-e988c8d8ff82@huaweicloud.com>
In-Reply-To: <df335e68-2b30-7cd3-1fb4-e988c8d8ff82@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 08:01:08 -0800
X-Gm-Features: AQ5f1JqeXp_RwTwnmBtGnq3FS7BD-oofTi6EC3yD055HSjFrluVkhcVcuY3gpNw
Message-ID: <CAADnVQ+N_zW--or00rWnFvjeOto3pM9WcCSWBnFWj95z99o+iQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix deadlock between rcu_tasks_trace and event_mutex.
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:03=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/25/2025 6:16 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Fix the following deadlock:
> > CPU A
> > _free_event()
> >   perf_kprobe_destroy()
> >     mutex_lock(&event_mutex)
> >       perf_trace_event_unreg()
> >         synchronize_rcu_tasks_trace()
> >
> > There are several paths where _free_event() grabs event_mutex
> > and calls sync_rcu_tasks_trace. Above is one such case.
> >
> > CPU B
> > bpf_prog_test_run_syscall()
> >   rcu_read_lock_trace()
> >     bpf_prog_run_pin_on_cpu()
> >       bpf_prog_load()
> >         bpf_tracing_func_proto()
> >           trace_set_clr_event()
> >             mutex_lock(&event_mutex)
>
> Considering the unregistered case is not so frequency, would it better
> to use mutex_trylock firstly, then fallback to workqueue when the
> event_mutex is busy ?

No. That would be an unnecessary complication.

