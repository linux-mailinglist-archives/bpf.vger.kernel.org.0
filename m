Return-Path: <bpf+bounces-34695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009493017A
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920641C2116B
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46049633;
	Fri, 12 Jul 2024 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHhR0SBA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB8482C1;
	Fri, 12 Jul 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818648; cv=none; b=K6ESFYq5ZcsdVU6MmNyX0Cr9PO7jW0DOHG0CmzGxGTjq5G9H2EZ46Al8heJ0h8sB48CWo+swRYO5qe0KWoz4nJd5MG8ZlufJqkTy02MPbl8D98/oM0LdRBlaiOd71eruNJ5VY8quTazYlgfqUaQeWyM8Anejg+IxHFgXC4ZK3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818648; c=relaxed/simple;
	bh=zDbO6xLtTCNacqRRdoOMN2oMJchbaFfBsFGhw3kW614=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSViGn3uZj+PwmPs0NNjnK4ukJIzc7wkAAdM16w2ccOlq4/+yS3dyUL9kUGaUAjhhlBB5+JseN7+EMoyRjQAMQnuEiN4gfZY2aeJGYj8FhgcYuii7PvyU3DcUPGT83r0KLgedltEKct3cBXqveovxdRGtMu62jpfAd0RFA5spiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHhR0SBA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so1863291a91.3;
        Fri, 12 Jul 2024 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720818646; x=1721423446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osL5RsL4I3MAxv4yWEcC/Fmi6h/xumUZNQhXdy/KXFA=;
        b=GHhR0SBAoRQASiHi6NfeUZ1iUxuSgF2fXHBjWWEbag1ggGhIPKZcCGXVRqX0VLFvhd
         fEIuN9zC0Cik4s/NGU4tb62nN8GBz/eWp1ZdPEiblHnxgDBNz9NUhQZMFXDkbTqLPAXE
         DapuillauAmDIwagbzbWCEfg3an/un81S1ZfCoAh+u/kla9fQfrFyXqjZMeUxuztdgUD
         ZoixJKCUicxZJ80Qk815dJMGXwIq+5gtUt6e/mGySXuLKJQk8ZuU3x8dk2sgXEYF+B8/
         M+WkMLXia/csVcIYFSNR0V4OOeYHU4cwG7NamcJYbuvFEcmwWD9ytaRQhZCMP5u+r30T
         xw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720818646; x=1721423446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osL5RsL4I3MAxv4yWEcC/Fmi6h/xumUZNQhXdy/KXFA=;
        b=Vk1S1B08uxxhPPPVoyUPR46xSlaXyWuCDYz/7CXgmcD+vLKtnkB5hkJs1+r+VixLv2
         alYtx4lmyTkQFH/9iLEG42AMUbuzUSrPV3eneGFp4g2fxTCN4VP3sQWJ41a9hZEnnW97
         NyvpHe/mN6vM73Z28ZY+ntX3MqLqe9V0kmheEVoj0VL5+10gmvuqOWGBoFHvSz2fMCLB
         BJ7yG8HztjaBeUk4UsRb5m9qS/fVosdOmVFzDmB3OVoXrIIhSUTzr/bS9EYOk6V7rRsC
         DsLOA74u888CLn+/zc9CzioqQ7eAoD2WmSyZ2GXX7Ts85301M9R+jtSIisHyKXdG10xO
         8ZDw==
X-Forwarded-Encrypted: i=1; AJvYcCVV/1dJScR5sp1ymvY1PM4meS8Z3wPr3gFZM4nfrpdNNq/Ghhw1poDmEVPRXPl7pYD84mTXMzgliwyQbPTo726D6JBuQregSK+oKF3sKWY1bfv6V/8NuPE+wa0rcmYMLzlT/QHQpj8brnskLbANCkdz5zwWkCYQxqEJB+88dSTLZ86+ZLwG
X-Gm-Message-State: AOJu0Yxrh032wrhdIy9j8ujsk3edWnl2yy2ibJ1ZMHhRGgbCIS7GHVve
	BNOvzFHo1F1CUUZzKqHrv240Qqvmg02d23U8EOjpkwF3PvHAF2qx1E2Ew8j4xvVOOKl8bLGdjRF
	n76lUl+Ys7pE91nKB0HnrA8B8edg=
X-Google-Smtp-Source: AGHT+IGM0u+l2fsOK58q8QdceUrjA/fazPrDrNculkxFujOeTWuuA9Aq1OI2D3bxML3LPnYa2OiF1763SMFX683DtRI=
X-Received: by 2002:a17:90a:708f:b0:2c8:64a:5f77 with SMTP id
 98e67ed59e1d1-2ca35d48c4bmr9917114a91.37.1720818646051; Fri, 12 Jul 2024
 14:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <20240711110400.987380024@infradead.org>
In-Reply-To: <20240711110400.987380024@infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 14:10:33 -0700
Message-ID: <CAEf4Bzbi55bzBPDhDa2mLqbKyo5V27AHOgdVyrBX7swJ2Ln7tg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] perf/uprobe: Split uprobe_unregister()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ bpf

On Thu, Jul 11, 2024 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> With uprobe_unregister() having grown a synchronize_srcu(), it becomes
> fairly slow to call. Esp. since both users of this API call it in a
> loop.
>
> Peel off the sync_srcu() and do it once, after the loop.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/uprobes.h     |    8 ++++++--
>  kernel/events/uprobes.c     |    8 ++++++--
>  kernel/trace/bpf_trace.c    |    6 ++++--
>  kernel/trace/trace_uprobe.c |    6 +++++-
>  4 files changed, 21 insertions(+), 7 deletions(-)
>

BPF side of things looks good:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -113,7 +113,8 @@ extern int uprobe_write_opcode(struct ar
>  extern int uprobe_register(struct inode *inode, loff_t offset, struct up=
robe_consumer *uc);
>  extern int uprobe_register_refctr(struct inode *inode, loff_t offset, lo=
ff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprob=
e_consumer *uc, bool);
> -extern void uprobe_unregister(struct inode *inode, loff_t offset, struct=
 uprobe_consumer *uc);
> +extern void uprobe_unregister_nosync(struct inode *inode, loff_t offset,=
 struct uprobe_consumer *uc);
> +extern void uprobe_unregister_sync(void);
>  extern int uprobe_mmap(struct vm_area_struct *vma);
>  extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long star=
t, unsigned long end);
>  extern void uprobe_start_dup_mmap(void);
> @@ -163,7 +164,10 @@ uprobe_apply(struct inode *inode, loff_t
>         return -ENOSYS;
>  }
>  static inline void
> -uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_cons=
umer *uc)
> +uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct upro=
be_consumer *uc)
> +{
> +}
> +static inline void uprobes_unregister_sync(void)
>  {
>  }
>  static inline int uprobe_mmap(struct vm_area_struct *vma)
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1138,7 +1138,7 @@ __uprobe_unregister(struct uprobe *uprob
>   * @offset: offset from the start of the file.
>   * @uc: identify which probe if multiple probes are colocated.
>   */
> -void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe=
_consumer *uc)
> +void uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct=
 uprobe_consumer *uc)
>  {
>         struct uprobe *uprobe;
>
> @@ -1152,10 +1152,14 @@ void uprobe_unregister(struct inode *ino
>         raw_write_seqcount_end(&uprobe->register_seq);
>         up_write(&uprobe->register_rwsem);
>         put_uprobe(uprobe);
> +}
> +EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
>
> +void uprobe_unregister_sync(void)
> +{
>         synchronize_srcu(&uprobes_srcu);
>  }
> -EXPORT_SYMBOL_GPL(uprobe_unregister);
> +EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
>
>  /*
>   * __uprobe_register - register a probe
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3181,9 +3181,11 @@ static void bpf_uprobe_unregister(struct
>         u32 i;
>
>         for (i =3D 0; i < cnt; i++) {
> -               uprobe_unregister(d_real_inode(path->dentry), uprobes[i].=
offset,
> -                                 &uprobes[i].consumer);
> +               uprobe_unregister_nosync(d_real_inode(path->dentry), upro=
bes[i].offset,
> +                                        &uprobes[i].consumer);
>         }
> +       if (cnt)
> +               uprobe_unregister_sync();
>  }
>
>  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1104,6 +1104,7 @@ static int trace_uprobe_enable(struct tr
>  static void __probe_event_disable(struct trace_probe *tp)
>  {
>         struct trace_uprobe *tu;
> +       bool sync =3D false;
>
>         tu =3D container_of(tp, struct trace_uprobe, tp);
>         WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
> @@ -1112,9 +1113,12 @@ static void __probe_event_disable(struct
>                 if (!tu->inode)
>                         continue;
>
> -               uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
> +               uprobe_unregister_nosync(tu->inode, tu->offset, &tu->cons=
umer);
> +               sync =3D true;
>                 tu->inode =3D NULL;
>         }
> +       if (sync)
> +               uprobe_unregister_sync();
>  }
>
>  static int probe_event_enable(struct trace_event_call *call,
>
>

