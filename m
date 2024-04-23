Return-Path: <bpf+bounces-27568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8198AF3AC
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8FD1F25D9E
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA113CFBE;
	Tue, 23 Apr 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9hM3XRA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010A13BC29
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888896; cv=none; b=bMQCPH+ZWafS1/Va0LhexoLphTsKyVBRpZD3THlHt/H8CDPsc1tIP8wBGoUJoDll3uu8CdMuRXYfHjCG/IyyPOEPrh6UgpMjqPUrqLTxv4dkRUvmeJiP8d8a2JGdAJivBW+PfiyFMqJg9/gpcj3Aiv68I1mdDXZcbLYcJ7x1kjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888896; c=relaxed/simple;
	bh=Cl3WWMEgIxKzkg55mm8Wes6HuVyfocMYUURRT3TX0kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTDw8K+c/gkngsDbWQNQPngWMiEi1RhTuwDTSDRce6diy7I6hyf4kb0UvMUdeG4ogkO9XAtX73awQpNs0sbdim+oAK0Zsle30uULWtGnFhl7oPRwLOl+Bx5AgIgJUtUcAcYu120nhv09JklRd4QQSFolvT/cNO8Y5Wh05R69RK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9hM3XRA; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so71075291fa.3
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713888893; x=1714493693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q43CspyUkXPC4eWL2WlkGC7A/wmtpZj8ggI0XfAwLxc=;
        b=j9hM3XRAT8KGm/zzajhm3D3m1hXhpGY7yvuf6NvGLOrjw6ulEIiL2DmB9KlI0uCKzu
         D1iMcVW4oBK5G9Vx37GhO/wKEhDcnas1OY0Z5bE5uEImwH452jjVqd6I17ood/zNWmze
         XXLmNxHRZJiULr7e9MMQDUS56dPrEyCjNrAatgCigfbcwroTUK4zk7+7yvmEiW8dHcCY
         gX8dxui7erfXqQH9KcTjJUPKhPPoAuD1TRnxAduOVHY/kcH78s2Pmv5ihXRSu9Ng8Zs8
         njAhJkChRMUBbA6iEcAe7YscIp590/QOAzFU0ar6YaXDqj23Cct0TOSBA4p/n5Z71sDz
         s8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713888893; x=1714493693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q43CspyUkXPC4eWL2WlkGC7A/wmtpZj8ggI0XfAwLxc=;
        b=IswEPk5ZbK2sJMDg1yAkvQjs3CpQBK/kgxIq8iujW43rna+NDpZoK/ybGuIOFM4jl8
         XirbudFoCpdNVsOVDt+QGC/YZyuEJJRRTl+6syMQtmcC5AkqdUnZNRgC4/z8dj2JBgPs
         VDBFP0omL6GCnRYXinnYtxhR9fkTe2aPcX/Jy31HGUQ+InDGFK08yg5sH61I4R/mSqF3
         0gIW/nuwq7SEVUgs7S+Z0snwMoYOMfyWdXKLBXiMIlDMLvM/s17p6sBWOrH/j76jPY/+
         AF+YTOgWv5V/VBphofAQIZDow3JK0gFzDZlKCtyX2n5XLZBABqMms8ovseWqHziyZcMG
         nXDQ==
X-Gm-Message-State: AOJu0YwIWO+KHpe0hfbnrIDMq9LFCsHB5bJ+xGGcBA+TuXeLjvIM6lMS
	Kdpzf88YiJZHFWGOJCQPC3H2T1DDI01FfKvK/f5NVKIPrsD66p1X3lB+hniBLNKPvP6HAmCVj+Z
	b1VFLOfdYYDKqnYr7tI/XMwrs8+M=
X-Google-Smtp-Source: AGHT+IFBY6mZlPpRRAR7XP2j7dk9nH3mff3LaUvCJXyWVKrG3YDi43FVnrLBLsJJrczikvjXlEDoSqs859oPeZcojf8=
X-Received: by 2002:a2e:a26a:0:b0:2db:1f2:39d8 with SMTP id
 k10-20020a2ea26a000000b002db01f239d8mr7816885ljm.6.1713888892886; Tue, 23 Apr
 2024 09:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423061922.2295517-1-memxor@gmail.com> <20240423061922.2295517-2-memxor@gmail.com>
 <CAADnVQLh1edkqBwenLNRkY8sLOS=QeXwhxDtD0TQQ+d-O31Z2g@mail.gmail.com>
In-Reply-To: <CAADnVQLh1edkqBwenLNRkY8sLOS=QeXwhxDtD0TQQ+d-O31Z2g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Apr 2024 18:14:16 +0200
Message-ID: <CAP01T74LnsQ_1XpLPXX-W9mm20ts53VeSyARzGSq2ozTi7=RLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Introduce bpf_preempt_[disable,enable]
 kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Barret Rhoden <brho@google.com>, David Vernet <void@manifault.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 at 16:59, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 22, 2024 at 11:19=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > @@ -10987,6 +11006,8 @@ enum special_kfunc_type {
> >         KF_bpf_percpu_obj_drop_impl,
> >         KF_bpf_throw,
> >         KF_bpf_iter_css_task_new,
> > +       KF_bpf_preempt_disable,
> > +       KF_bpf_preempt_enable,
> >  };
> >
> >  BTF_SET_START(special_kfunc_set)
> > @@ -11043,6 +11064,8 @@ BTF_ID(func, bpf_iter_css_task_new)
> >  #else
> >  BTF_ID_UNUSED
> >  #endif
> > +BTF_ID(func, bpf_preempt_disable)
> > +BTF_ID(func, bpf_preempt_enable)
>
> I suspect this is broken on !CONFIG_CGROUPS,
> since KF_bpf_preempt_disable number won't match the ID in the list.
> The simplest fix is to move these two up before bpf_iter_css_task_new.

Will fix, thanks for noticing.

