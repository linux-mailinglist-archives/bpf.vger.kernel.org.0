Return-Path: <bpf+bounces-55109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B319A78452
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 00:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40ECB3AD692
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAD31EF38D;
	Tue,  1 Apr 2025 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL+sm37i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5691CAA90
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743544929; cv=none; b=O00Yik6WgqFcU2ag69Qqogq9BDtwcfSWCAIY6pjgwVp2gU997I6lQkhmrzTz+K69nwYsvXCeTxdR7apRkiHCj3BGtGNrjNkVMJNwBsqWgk0QIe102tBs548PLD4POXNyXwiMxb+3CPRasW5zRo6F2D3P2SSQEmtC7hP+nmwWW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743544929; c=relaxed/simple;
	bh=IItBcwQCVFUUd66j4ZbmDbojPhhyOU+faxvHhhWQDQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ft0FNRQAK3vF0RD7prj7pQn3A2ILgb0ak09GNudGy+gm/T/+WylTwicF74O5+xOEN32K1hdINxRlmtoZbVoUfNdcUcc/ZJu5ysiNvEYO037P87ldhFEn25JsryKD9jNtKshTsUvTAhmpytUqcKijp2oHFVyXyQEk2cGTezrV6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL+sm37i; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22548a28d0cso163749075ad.3
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743544927; x=1744149727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD14p5kGw+i/jZ0MzV5Jj/xa+PJRZcsmqanDkI9orgk=;
        b=HL+sm37iroPTUBRtn9S1Ncp48MGu0Glm2hgrU2Kk0jiteGrK5rxaBk2JmtAlA4V0um
         jSrNTb4PYKLgsFBajsSEdokJItOt3QuThgX0I+1ccVdQxLDFQRkbtanzIYxF5pVETiyj
         JWSMwRBmgjN3oYDR1oHgDxkLKlnzCI0HGmdJ9/2pmzrEZL5PPUCgurpjoLm5jRK1FW20
         f5N8FewgGPFwlkM+bS1clDrJV+MtUSAjt8g8ctfVe+2w+i/ozHBfsfxe3Wb2nAs4NIUq
         k9tpH5Xai0/wB/u6d4YY7xZJ2+j+l6wG8d5JwkC+yEPIFUCA3CWYZKdfgj+cp6O3+bC1
         dVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743544927; x=1744149727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD14p5kGw+i/jZ0MzV5Jj/xa+PJRZcsmqanDkI9orgk=;
        b=BLeRMMebaqRIAoy0D5u59hfxE6g52sg+PpEITVq8ZFMSbZrramKJh16RIuapMFeVAw
         hrw6IJskKcKLlySYrEzhkgd1Rf9kcssluI7TEzxt3WNR128qAGdLUhGO14Iz2S3zxr9I
         UgOCX+LPyCFyfbFP/ogAT4T9u5SSOSGdM4W0Kn3dWAJ2g3X/kiE2cCT5c6gUuqcfoQjD
         nVk02Bg4t6GsIYjDiHb/cC30cw0oNmovMzB9M3yeqOY9tQraPZ8av6O4tAQ2aWv68rR4
         ZgtwE+EfLUBWcohbEyLrHa9PXlGkejIoU9aM83Jc9oSjGspS8Pfv4M2vjUryClatFmP5
         fEAg==
X-Forwarded-Encrypted: i=1; AJvYcCXbyHSw4YVS2QshdOl7mcp2oP7Ll28ZkjRRkQfbi8Zt69xsXIO5ZbRXmrSrq1Fb8PHYgvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkYiosghZkaGrC8wKy9tGOEltsDUa23Ou/NqZUfiaEYuCB/ZU
	ghIRY5cw0PcBdq1OihJLFt5ohEnVx3PQSsZjoaTJzjdQxavhPhGi4A7yh4iBX+YzUBdShWYLG+d
	e7SrVlAyrZynXCvUirpRmU26Lt1k=
X-Gm-Gg: ASbGnctdtu5p9VWx9GZ6svNMx6luu2nqQN11HoCr65PvIlCZPsleNlorhtJoMKar6YD
	+3BseJFOKM9N1bHiFsOM0MTesVgxfIGCRQwTarmrKeZjh3XgsQQQPGy1CQ0WaC1KDcDXDorIPUJ
	KH9YnT5j2CmT4mMEiDbKSkraLDzVBooq60xJrAADwlQw==
X-Google-Smtp-Source: AGHT+IEDHhidt21tGe71co0+P3sk3Aeo7VfpyKnijq92uKuj5x7Byr1JFmIBwDukgZp72PtVJLhx31pDrs1xqqdMV/Q=
X-Received: by 2002:a17:902:cf0c:b0:227:ac2a:2472 with SMTP id
 d9443c01a7336-2292f9bc6e4mr240041225ad.28.1743544927461; Tue, 01 Apr 2025
 15:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home>
In-Reply-To: <20250401172225.06b01b22@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Apr 2025 15:01:55 -0700
X-Gm-Features: AQ5f1JpWV1RyufOiQITHJ02KEn_GjWUogxOM6nBkvwubyz2rp4-4m13EKmxA5-A
Message-ID: <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
Subject: Re: uprobe splat in PREEMP_RT
To: Steven Rostedt <rostedt@goodmis.org>, Peter Ziljstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 2:21=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 1 Apr 2025 14:04:22 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Looks like write_seqcount_begin(&utask->ri_seqcount);
> > use in ri_timer() needs a fix ?
>

So, write_seqcount_begin()'s documentation states:

/**
 * write_seqcount_begin() - start a seqcount_t write side critical section
 * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
 *
 * Context: sequence counter write side sections must be serialized and
 * non-preemptible. Preemption will be automatically disabled if and
 * only if the seqcount write serialization lock is associated, and
 * preemptible.  If readers can be invoked from hardirq or softirq
 * context, interrupts or bottom halves must be respectively disabled.
 */


In our case we cannot have readers invoked from hardirq/softirq. It's
the writer that can be invoked from hardirq (timer).

So what did I do incorrectly here? Should I still disable hardirqs
just to satisfy that seqprop_assert()?

Peter, any opinion?

> Hmm,
>
>         write_seqcount_begin(&utask->ri_seqcount);
>
>         for_each_ret_instance_rcu(ri, utask->return_instances)
>                 hprobe_expire(&ri->hprobe, false);
>
>         write_seqcount_end(&utask->ri_seqcount);
>
> How big can that loop be?
>
> Of course, we could just say not to use uprobes on PREEMPT_RT kernels?
> Otherwise, they could cause an unspecified latency.

There can't be more than 64 nested uretprobes, so it will be (in a
very-very unlikely event) at most 64 items. And that hprobe_expire()
operation is very fast. So I don't think latency is a big concert
here.

>
> -- Steve

