Return-Path: <bpf+bounces-46739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E59C9EFCE3
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEA828BBC0
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B271A83E3;
	Thu, 12 Dec 2024 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxQ/JoSD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798118A6A3
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033585; cv=none; b=KfOHlT9Z9fxIi5qivtcZjkCuwW7vaIuKAyZ2HTxBrxr4xqY6Li3MjpGV1B2T1Bqvmtc6CwK36bYEkSbH/l60CqUynLOAuol/DmPEUoxkUO9Td/z66VbE5696sQ76hjNH9kHsdgVhiLWTxMK9FbrSVuD+M5KfA2o7/r97Qwz1QTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033585; c=relaxed/simple;
	bh=Npi1Hbw0CtNyzxuYWoGuq+jKmr4WOBj6OkcDmc/1EeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9b/a43aovkbyl5AZjQoqHsE9rx7zOXd3u9i9dEV/crmR874nWHiqNDf2sEAF68E+3VgdFx1RwDuz+zHKX4FRHTgZucuuO2fY4xui+sYeZdUoGUtj4Aju3MvXgTExNOzaw0L4SxViROMKR3nRzaGwIErDYS3uqcZqRN3Y49t9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxQ/JoSD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so634422f8f.1
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 11:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734033582; x=1734638382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59jmxjmmzbMhb46hk8UI9KqfQCYFwroIJNuQaYWTsAg=;
        b=CxQ/JoSDuF3Io9BYfSRJaYjw+cFnNqwB0o+zl/pmEmhNleHUApx8VbQz70ExY+IN/h
         kAs8EwhMf358gcHg0qFf+REtUG0cSrAPYtG7eGkt8GVXVi+0vSAuJRQxPz2fq6YXyVSy
         WN94CFD3vnU73Oy/QrS+9PoJ73pfCyfenI5iftTl6xgHUPo7XzjdqdwLms68GHdHbrrG
         pIKNnvtPWef2EQjdQE78IfUm46rinviv4OUxg86tbxkK9uWTsIn/TpO+rLZYGNNe8aoC
         S2AYC4OYttFp5OoLb3wTaUV6jqAFDSJgyqbFIbEOB3d6jQzDZrLbVs3PLs5kY8/MrMoR
         6gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734033582; x=1734638382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59jmxjmmzbMhb46hk8UI9KqfQCYFwroIJNuQaYWTsAg=;
        b=SGNnNmpcgROlAgbu2oNNi2+e8AReuYKJaLpdgSgkWrqlCntVmJn4GoX9nB19qv8KiF
         pr2pc6tOXMUnyMvn0ObDe7dV2caTdjNjbsmozo0S3NFDcJI62W0SzsD6vNV7zVvIpsFz
         LGuIgdVbffCQZLHCyzNHP4NRcPNyvkPtZ0R3LL9tPm20heQVxYIIX0bXyQSaExDRqWj5
         VYfdI/4fOAINHTbzVO6Z3D4qs6r4lduotfio42Ww/3+uoppKwF9JyZBANOFSoJWNJaJ4
         kHx6p6mkMyoNXJT+PK+sFGLjmmsKk4k9bQziFirHqaeTVi7uzA2uXlHblH3uOs5UeAB3
         +K5Q==
X-Gm-Message-State: AOJu0Yy29zM+2ZKMbDoz4jlYPX6UyadsJamdHpDJ7SmljXxp5LWVJ/K8
	TA1hpfsuGKC/GAgT9yCXqrjzvOn2nUxpv2G488KvVR7cQMsDxymK3evZvxRFLYWPCYU3vqraoFx
	F7HgmebSBVMJSpGhD3S7qYCB9dcQ=
X-Gm-Gg: ASbGncvP+QKedvnLIhgBiYZLxTyl4CeBzSC2Q2ruiL/j9K3tE5qSuzaer44V2gQ/JGl
	2aeK+Z9LSdB2e63QJxDgluiF2FrmO/MoJNa4k4zuI/aO6I17eeN85GnCg08oqecALmGEYrg==
X-Google-Smtp-Source: AGHT+IGwNuD6Ftp89eeMa5Cgwi3JSQH8HV7RA75uk5OAIGYfHDJ+0xlO19k/FBDSAaZ+UebluzVUoxQq+6snULBY8a0=
X-Received: by 2002:a5d:5f56:0:b0:385:f60b:f5c4 with SMTP id
 ffacd0b85a97d-387876971fbmr3942557f8f.29.1734033582286; Thu, 12 Dec 2024
 11:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-4-alexei.starovoitov@gmail.com> <20241212151529.oPNxM6JC@linutronix.de>
In-Reply-To: <20241212151529.oPNxM6JC@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Dec 2024 11:59:31 -0800
Message-ID: <CAADnVQL4F-SMUyAJUMNSvsq2NNpXDvZoAgdcgt+3OrhGbA2BCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] locking/local_lock: Introduce local_trylock_irqsave()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:15=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> > diff --git a/include/linux/local_lock_internal.h b/include/linux/local_=
lock_internal.h
> > index 8dd71fbbb6d2..2c0f8a49c2d0 100644
> > --- a/include/linux/local_lock_internal.h
> > +++ b/include/linux/local_lock_internal.h
> > @@ -148,6 +163,14 @@ typedef spinlock_t local_lock_t;
> >               __local_lock(lock);                             \
> >       } while (0)
> >
> > +#define __local_trylock_irqsave(lock, flags)                 \
> > +     ({                                                      \
> > +             typecheck(unsigned long, flags);                \
> > +             flags =3D 0;                                      \
> > +             migrate_disable();                              \
> > +             spin_trylock(this_cpu_ptr((__lock)));           \
>
> You should probably do a migrate_enable() here if the trylock fails.

Great catch. Thanks!

