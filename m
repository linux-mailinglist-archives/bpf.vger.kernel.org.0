Return-Path: <bpf+bounces-38004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA695DA11
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 02:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE3D1C239CC
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 00:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9B1C9EB0;
	Fri, 23 Aug 2024 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SINN/dY4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C061FFC
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457578; cv=none; b=jj3QDBxW1g9NYKWGlLlfYY939M05khhAkQmOqqAqqkVMtJfml+u3zUbfG4YoxtuBMchRyOWoFSfyNJBAo24ayunf12vj5Jb+pv2PhLWxJAf8rekx9722ed8g35DLm/hSxB19H05CBxvXZUQkGSYNYa8K2zu9nJpAacRnBALFkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457578; c=relaxed/simple;
	bh=XSb0EnVjubNht4RayriIyV06WQmtolOFi4/BZ+SUhZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpWEUJ7Ao0SuVbRzBZPIAIoprSMrFASC0sXk2rVrc2EueN9ASEV4vDMjGsFGvpYCx81TAVDMaQcuZwgkDR85EfrGEN9+ipdr/K0MHEkay8LE5sX/f3dRRjlwyjyg2V5yq4wTar36fNFXDIvO2D4geRenWEm8IFVyOFGEnSeOHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SINN/dY4; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e162df8bab4so2392888276.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724457576; x=1725062376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL8BmtUF4esBCitvVw45YqMhfbkpLe5BtPI9u9di+1k=;
        b=SINN/dY4xG9lp5OdM/NRviAkS+01CYaJ+srulIqK4s8pfXdaSUJ4Sw5Lgc9fl/ZHXW
         6v4UzCR4y4uGpKhqpQdx7PG97LH4JQbH09hB8BbqY5r4LYDridbHSfxH232Pf1FFZE/D
         4slZK1LU9VmsH2OAp+gwjKGAiUF4vlMkaEtv3oKkQe/9Nh3XwBrOV6snaAEOeGwKNtlW
         KmbbUY9U7/BQgnGrQZwqd9ARcQeEATG22JXGK1CyLAuNsOLQ0YuI6z3EMFSkbbNqzlBR
         qjsOn7SUW2Iyf2bvwNTw8lUct9YJPMS9aaaMq7qQexG4mSrScoKrjq+5RGxhqXaUIYmt
         E7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457576; x=1725062376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oL8BmtUF4esBCitvVw45YqMhfbkpLe5BtPI9u9di+1k=;
        b=tilWAC6UNCk/5dJxLwYR06S7WI+IR512Ziz+r8M/bqUfyFPyDTpJ7K3Y2/iNeBFMZh
         CG6yfzQta3fDk+mOv4G1sY8bMl1RBkAP0QAPT6QwlLQiT/Ns1DSS5d96csMfRC2ZNto7
         MhQjP1Gjz+rkHs+nsh+VrXFjH7uzntqHFDssyDzFFzUNyM+douL9Txg/i8NHXkt9IaQX
         Z86YAyffBV78XY5181DLNA7RO0ej9STuojKI6WNg4w2fIJGQwA3yWXGTPXynynn3BQ8n
         ydVX7nv3Tio4UcA+ul8Nf53VHuxB+VAeXVYCe8ePwFyN8hPs4CaCwHXEY8MK3UxOGtKD
         sB/A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9iZ8QWWO7cC/ZtPKLzgTzicpEFVxPFWf+6ztYQrakj02je5RoGZcDJ9oHFqbI8MKEqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZSQr5BMDABG6Dedij13YtTK4wuLYrunQ8hJmT17T+ZNP00Ep
	JSrb5iKcIzxi/daf+sssfkamSx5wIjMCOBCCSVHAIFnQsKWq41ShUOHzFHHX26BhUWEHbLc0Vo2
	N3CIOJ3oamaLRSZtdQe7gFAp29XU=
X-Google-Smtp-Source: AGHT+IHQ1QxCj4shoiFive2+gUGBbzED1hsW9NpUBk5KP3Xr7N+CHJ6n89//TUQBYIidcyGMXnt4+K6EAqHtRclgIQQ=
X-Received: by 2002:a05:6902:2589:b0:e16:6afb:475a with SMTP id
 3f1490d57ef6-e17a85d0e65mr4491770276.28.1724457575996; Fri, 23 Aug 2024
 16:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813212424.2871455-1-amery.hung@bytedance.com>
 <20240813212424.2871455-6-amery.hung@bytedance.com> <CAADnVQ+JhZMzbioRGQB454i3w+M9P854du=o25-0=47PG2Jbng@mail.gmail.com>
In-Reply-To: <CAADnVQ+JhZMzbioRGQB454i3w+M9P854du=o25-0=47PG2Jbng@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 23 Aug 2024 16:59:25 -0700
Message-ID: <CAMB2axPhDkAv_aeBy3q5xsSh-g7_vM_=TwLCLSQDwkUwKyc2_w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 5/5] selftests/bpf: Test bpf_kptr_xchg
 stashing into local kptr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Hou Tao <houtao@huaweicloud.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 13, 2024 at 2:24=E2=80=AFPM Amery Hung <amery.hung@bytedance.=
com> wrote:
> >
> > From: Dave Marchevsky <davemarchevsky@fb.com>
> >
> > Test stashing both referenced kptr and local kptr into local kptrs. The=
n,
> > test unstashing them.
> >
> > Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Acked-by: Hou Tao <houtao1@huawei.com>
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >  .../selftests/bpf/progs/local_kptr_stash.c    | 30 +++++++++++++++++--
> >  .../selftests/bpf/progs/task_kfunc_success.c  | 26 +++++++++++++++-
> >  2 files changed, 53 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/too=
ls/testing/selftests/bpf/progs/local_kptr_stash.c
> > index 75043ffc5dad..b092a72b2c9d 100644
> > --- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> > +++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> > @@ -8,9 +8,12 @@
> >  #include "../bpf_experimental.h"
> >  #include "../bpf_testmod/bpf_testmod_kfunc.h"
> >
> > +struct plain_local;
> > +
> >  struct node_data {
> >         long key;
> >         long data;
> > +       struct plain_local __kptr * stashed_in_local_kptr;
> >         struct bpf_rb_node node;
> >  };
>
> Everything looks correct and I applied the set.
> The selftest sort-of covers the case where stashed_in_local_kptr
> is being freed by rb_root recursive freeing,
> but it doesn't really check for memory leaks.
> It only checks that nothing will crash.
>
> Please follow up with an improvement to selftest that
> actually makes sure that recursive freeing of stashed kptr
> correctly calls bpf_obj_free_fields->__bpf_obj_drop_impl.
>

Will do. Thanks for reviewing the patchset!

> The patches seem to do the right thing in terms of storing
> correct btf/records in the right places,
> but this is tricky, so extra tests are warranted.

