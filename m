Return-Path: <bpf+bounces-32203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B990931E
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 22:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AC2283AD8
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 20:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5E319D07B;
	Fri, 14 Jun 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdyIP5eP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44B13213E
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395210; cv=none; b=k86UXQANND0glVaNSG9KRve88gEDAxqd+indiE3EHpKmdjO6AXu7L+PCVisKLdH4IZm7CnQlhyD/z7aIJT3vLWbmp5K6Kv3PubD/x5PvFY2vtHkKe+Q5MWn01R2KDGD/cTAkub0pcVZ+jC9n/m3yVdIhiMsDpyZfpNOQD4Ztp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395210; c=relaxed/simple;
	bh=EIqy6ek9+yjzmGl4rrtjb8mcxCqDrRrtsijrfhtIqMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKKZop7nt/j4R/kp+xQWPTrdcKrLYwMt0n43sbQSXb2OMLRi0KhrL/QTu07CBNeR9a5e6derA0EcwBQyjcOz8SFGrN2Am7BunjcxNkW1Lspc34mjsy/WhlghUnt3osHgGktmkEbzt3K+5OeCTLUKS4iSLclEvdTwO0hLW9xhvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdyIP5eP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f1c490c13so2854340f8f.3
        for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718395207; x=1719000007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIqy6ek9+yjzmGl4rrtjb8mcxCqDrRrtsijrfhtIqMg=;
        b=YdyIP5eP3+xyyi5oZsu0OXqqjhDWEVwI/uD18X7hOeVDML6dPjinJzCH46NoSZhczG
         maAFRqKdasduF1V79mZPWjRVPfCnQoLxIz7HbRZgXD7jfA/RyVDhy5231pCeIZ4571kK
         PtTKeclL+yKEdnIs9LhfCE9GWm2NxTDA+2ct6dmJqu87/s4hQFe4Mi5VlFdgfNSQ6Isv
         e8fj09M9TzKwusrIrM0iOa3aYyQUMLFoS8Oh76peK8eC3IW7T2DAqoMpWkqe4OEuNln4
         elniwN71GEWbQ74szHstBd9punECCtrF5CoeLSkhn/FtN953g3m+L3fFNz5pv/hzodEx
         Ui5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718395207; x=1719000007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIqy6ek9+yjzmGl4rrtjb8mcxCqDrRrtsijrfhtIqMg=;
        b=bIiFV+nAo7Wp8xqIvc7DCGCkTfKsDVnjQYzk1rJ2G3oxO9RnuTDCQh8TLp/xyrcUjq
         lZ9DrwxI1IWbOwZSl5JhiluRSYCtUnPbeobJyNu7Lwct23MnDFhAWGbxEK5Eqk26aZH0
         I6AULdioaviRXosuWyude9g24bvCYSqEZIR1v8dQzV3H+6NDtJr+UjpQb2Le7g+t7ysr
         r5b3s0tSHQp5nQEbfUuJIBIgCGcPIZBzBKliQ5GtCdP7AsvPT5gwxPXfJT3chLdBSSeX
         xNF2ui+mLC0a+7iC+QQVGLMtilwLgRbFFiZSqoWwn1qrKyAaPZ5qlZP84pxMk/j8EOx4
         UZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFH7jLJ0y6K0cwxU8dUbbBXbaFI3i0ZXOvrAdUQWRnvu8MkIMEAz1wlVJ6lTRkjIHKihAcZ7z/dzbwc7pDSxb8Zs20
X-Gm-Message-State: AOJu0YzDIZdwq+4reRSgVkR0uZ589icesIXNc7VZIewBjsxlikD++WZ5
	NOHjGzSYUlwR3A+ZbKVlUTyOjKh2L7r62mU+E5aksHWOM7UPjE5yh2FPucqvn2Q+g6Pi11qrWn/
	HblmSIcdduvlo/MccX83SM3Zm07g=
X-Google-Smtp-Source: AGHT+IEb3eA0TZGhW4O6V/P2PxaGigki2vZnJYe9tRRt47ttrW0/+6y43JXZ87BJfOaKapTMxAztrrjWM3rqqh6A3sY=
X-Received: by 2002:a05:6000:1a86:b0:35f:3189:ddd2 with SMTP id
 ffacd0b85a97d-3607a7687f8mr4384171f8f.35.1718395206525; Fri, 14 Jun 2024
 13:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOzX8ix3TVUOgNAWkXbK6RAqBCmazgeL=PE-fCV+KZ_HyfLW3Q@mail.gmail.com>
In-Reply-To: <CAOzX8ix3TVUOgNAWkXbK6RAqBCmazgeL=PE-fCV+KZ_HyfLW3Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Jun 2024 12:59:55 -0700
Message-ID: <CAADnVQJ31p+LCYrHYZd0RisUC_MvU1a8-F+QRiKAJkPw52Edtg@mail.gmail.com>
Subject: Re: Why is recursion protection needed in bpf syscalls?
To: Usama Saqib <usama.saqib@datadoghq.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:38=E2=80=AFAM Usama Saqib <usama.saqib@datadoghq.=
com> wrote:
>
> Hello,
>
> Some map operations via syscalls on hash maps (and some others)
> disable bpf programs from running on the same CPU with
> bpf_disable_instrumentation. The provided reason for this is to
> prevent deadlocks when a nested bpf program tries to access an already
> held bucket lock. From my understanding, this can happen due to a
> kprobe on a function called after the lock is acquired. However,
> htab_lock_bucket already handles this case by returning EBUSY if such
> a scenario were to happen. Is there any other reason for disabling bpf
> programs on the CPU?

Correct. bpf_disable_instrumentation() is a mechanism to prevent
bpf-kprobe progs being invoked from the inner places of bpf maps.
htab has a separate protection via htab_lock_bucket.
array map doesn't need such thing, but there are other map types.
disable_instrumentation() is mainly for those.

> The effect of this is that 1) bpf programs attached to a kprobe or
> tracepoint in an irq context get skipped while inside
> bpf_[enable,disable]_instrumentation block but before the
> preempt_disable via htab_lock_bucket, 2) when CONFIG_PREEMPTION=3Dy and
> preempt=3Dfull then a bpf program running from user context may also get
> skipped while inside the bpf_[enable,disable]_instrumentation block.

Yes. It is unfortunate. Folks are working on adding htab-like
protection to other map types and there is an orthogonal effort
to introduce bpf specific spinlock with run-time deadlock protection
that bpf maps and progs will use.
Once it's available this disable_instrumention logic can be lifted.

