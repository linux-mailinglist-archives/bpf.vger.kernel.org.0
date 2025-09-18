Return-Path: <bpf+bounces-68730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81877B8296F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 03:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C8C1C23F1B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590E23B616;
	Thu, 18 Sep 2025 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIfgfys9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE2176ADE
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160457; cv=none; b=lI5KiX2/b9OJPTMmEtcXphPMGrM6YdF6myUb4a1PLjzaMdM5hUXrJ7zfI7JS4lkG4CLxDA5mW9t6EiSZHuvHkzHpsdZEvcD05F8yMrL58WiziGguhrh8JpUHzqFjBgDWDaX1rJBOEOIeD7yWkA+OUMKNni2MCs80XezAcMG1sNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160457; c=relaxed/simple;
	bh=+Fne7BlGa4gJtS1dOOuOqcLqMjC9p60oc0GhjbeGbHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apxFx+3Y5pmD2CWfMAN8y71Ub2eZANoPPTmtVejHMD90U6Z6pZY4za4+FAoh2Psltrzly1rEWEIBuCyqRRvhdyeaSXCIrQn1aCXQW44L2Lma0p+OWOjCthTnPprbWqp1cLV9xR4s4E4cB3MBc67ZTU4BVbZH3dmIyVtYtV5FrBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIfgfys9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3dae49b1293so152013f8f.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758160444; x=1758765244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzMJYE+Tlmoxg2NaRRru0/IqwnSRyw2/5qrMUMFIWmo=;
        b=dIfgfys9ipqHCnzkGCQ3eySRbLiOzsGzW2mSayhYDAMMFm9qX11os+ados7Pw1/9Ri
         n0ZOQ58xTX9rNi6GkgUTN9FKrGCaNqDxKKWBweu0p124QAu1+hmlnXjpaOfcRkOc8g/S
         JOgASH4ZISMUd4by/uWv5TSdgUxw1+kdurtDvIb85o3tSDXx3bpfVTZ6z8nd9MufT6KP
         EUfWXcKXxtWYMPi6uHFG1TL4CPuXlifhzYmKIanqQwdOSJVH3ydGMOOci+TYKL3e7CU5
         lnAy/C3lCJYveF1CNXbehyUIf2xNSTAlGvrG+bLkhwObDZXg9+XytNRLTVzVLo/ZXcGo
         cSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160444; x=1758765244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzMJYE+Tlmoxg2NaRRru0/IqwnSRyw2/5qrMUMFIWmo=;
        b=oxtzHQNsVGgPruWFC+oRnalsYNlw170lJcAOzoepNzWSX6FVDHklJBODiIsnH0L3c2
         DdnTO+XLN8pI+5/VrWzag8Nmh9XI/DDTngOZk8TBn3MFFpj3MKOySb0gLy84AVaZfOG6
         mNkG+ecWvkix5qbaazlRQ6wefvUii0IcviZQgzdc5khA2ndg87tCablU6IVSIFX9QUux
         GdY1jnTOEZETQNs5wD6/XNAZahmycPrTzq0Bf3hOh8J2nA5UAhfKEhrtWTH8vYA1Ogn9
         g1xDt6sD0cagFLNGsQefLN76RkJu4+gs4NsoL6CHgMevFHhl0XQSY9wO6YW2Fr12C3Ug
         nUAA==
X-Gm-Message-State: AOJu0YzUZsd+mCq3v1UQd6o5XJG2MQ/Hg8LA6CGA3ntHWKWC8+qQNUjI
	/nBZSpedfcLZ3EcVkTDa5Zo5H//kN0j5C8J6Fx9i0j878Wnqr9LYeSZLOQP6OHiZwgDsAvOrccE
	0E2DgfsKM+yg6DQh9Xi1Hg3giKkMPCBg=
X-Gm-Gg: ASbGncuHcp9/z4usHvAPVwNACl7HFWE2HRseaDPTb5yEKygjfoEAYFiQWeGTQjVUVwg
	hm0CAPgHLo+cK964jKAH3wst0Z8jp2yQ0dWnQ2bysH+e/I0WW4Jqhj4d+HlWq08UJ0wh/R1+3C8
	ALboTnr1oAEETLjlpWeb+SJFdQzSLNo8trvxsM67S7jIHq6M5aJs0a1ey70FMd32XiqhGIpTZt1
	YDHbPvEdM7CG4ggmho7wZhnUOfLMvRZF/gDiGUc1gULmucvqLAPMyC2GjKldTqbrA==
X-Google-Smtp-Source: AGHT+IEbcGJq79MJhBjyvoeH8HVIW+0IWUScUZWmHhvlJwdy0PqGjK40A1ZSUrKXqeZS3I29SMRvO/OQjCKptfYeOwE=
X-Received: by 2002:a5d:5d06:0:b0:3e5:31d3:e330 with SMTP id
 ffacd0b85a97d-3ecdf9ce69amr3758461f8f.25.1758160444332; Wed, 17 Sep 2025
 18:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com> <20250916233651.258458-8-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250916233651.258458-8-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Sep 2025 18:53:52 -0700
X-Gm-Features: AS18NWA667s-vDOUyosIkwLVLmqwDh-mv0PpHYn0yC8f0BnNmcIOpn8kVzuCKog
Message-ID: <CAADnVQLFZrpBzhYaufdbxCo-QJqNqAH88YcZqvnFpNU44MA3ZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 7/8] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:37=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>

I haven't groked the state transitions yet, so commenting on
only one part...

> +
> +static void bpf_task_work_ctx_free_rcu_gp(struct rcu_head *rcu)
> +{
> +       struct bpf_task_work_ctx *ctx =3D container_of(rcu, struct bpf_ta=
sk_work_ctx, rcu);
> +
> +       /* bpf_mem_free expects migration to be disabled */
> +       migrate_disable();
> +       bpf_mem_free(&bpf_global_ma, ctx);
> +       migrate_enable();
> +}
> +
> +static void bpf_task_work_ctx_free_mult_rcu_gp(struct rcu_head *rcu)
> +{
> +       if (rcu_trace_implies_rcu_gp())
> +               bpf_task_work_ctx_free_rcu_gp(rcu);
> +       else
> +               call_rcu(rcu, bpf_task_work_ctx_free_rcu_gp);
> +}
> +

...

> +static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
> +{
> +       if (!refcount_dec_and_test(&ctx->refcnt))
> +               return;
> +
> +       bpf_task_work_ctx_reset(ctx);
> +       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_ctx_free_mult_rcu_g=
p);
> +}

This is overkill.
bpf_mem_free() always waits for rcu_tasks_trace before
freeing into the global slab.
Also there is bpf_mem_free_rcu() that waits for both RCUs.
Just use it and delete these 3 funcs.

