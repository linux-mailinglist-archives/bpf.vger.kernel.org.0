Return-Path: <bpf+bounces-69913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953EDBA664E
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 04:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5046417ACE5
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 02:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25051248883;
	Sun, 28 Sep 2025 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcHR1/qN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A66246BB0
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 02:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759026136; cv=none; b=IjNoDgqQ1+O7iMqGS32BD5KpI7AA4H3FV5iWeIGn86MtZZ+576M8hKWBnDh//r9wxyhOwHWHbaSCgj10p8Z2JKjejlDHKW9jm4RU6hiB/ZtouI4Q0nUjcXn/CW8y3zCj2B47SFk+VINtqUC30fJjOkJhdD1OJ3ep7kl3MVa0ImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759026136; c=relaxed/simple;
	bh=cdV8EvyE350zvXIzaafjGgo3CGqpx9sjAz8jxTAHEsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pA3jlcMq2BZlVDIgwW/QHJKu8BMt6PNx4bqLaN/3s2sLNKwS4Xv0ODZNRpo/KBlJBEWNdoXyNOoph/m1ABPzqUPyNu8pHwmaRqjKaScQK3TNMJc3IZqxPvFLLI4wiXhKjoft2P2P6PY8ceB3DTV+jewxvXxiTCw21gWkHFGp+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcHR1/qN; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8209dfef9c7so18505396d6.0
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 19:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759026134; x=1759630934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDD4e48s5XfMjI/dpKcLLXxzREK+rG19jnnaqnwWIvw=;
        b=OcHR1/qNXagZRZ7nXmq/5yrmuCssIGQjZlyxjVbWNf74NHoOs+x0Dc7j3uhsBSQ/MY
         KrGZHPaDgNvCe/YZVAI01LTrLUohy6lYWMzbfpHMBvkAw5ACa3gz81FAU3Nchr2y40Iu
         Pn6LPdGEn6QPk7q3YOpPIWbyoTrAxlOEYfKvoSxkcYwQth9fPJyXtEKwkgdCXHWDdLbm
         aKZsbRuZYjNu2ovY87RpnfR3BzkolcFreA9OsWflxx/FA46rsmI1DgZPZNLiOh8ZKq67
         IknAAQLj5um2b1izILk/iTyNwvjq/bd7/wk8/4f4IrqxJqHLxgvVkSUn02GGXiAXbdBq
         r4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759026134; x=1759630934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDD4e48s5XfMjI/dpKcLLXxzREK+rG19jnnaqnwWIvw=;
        b=pyz/v4IGKd6O/O20Il5rPb9B2a4t5xrzGeCPsohDTsVB19965zyPlPXdKy2ADTkMB5
         sfdg4p4DiNh6ecSku2QW3oPQhGLQIiUgJQ5Fmd6OHXVxENpVDr/ZNQtPvZ53Ncvu60RZ
         TQUS6hMnB8KIY6d4QqnB35/m3OYGFZnaL8gjzmKUfIMY1lqaQpMJ0FFLvQXZBnO0Y9z8
         kjgRUPVWWG7nteU1DKg6ZfM45ZJFFiSIDL/MIh+Y40/mRkF5mkYu3MANxjfXACqurB2j
         WHjMiiR2Bu2NdRSRgyjssUsXSKhBja2F4QGFkTqAFP0DeNTPiqqu1VmBF68IX3cAxN0f
         U1BA==
X-Forwarded-Encrypted: i=1; AJvYcCXoAeH/VuFt90/rNH5hOl1hS6jaTP71Qoa2j+uTcQI9BTqA8WxZ9shsoJPH73dUPb4SWe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJaZup9FNG+/MxIZLegkdsE6cz1CbAFBVjLFPEFdYMTa1fYPFs
	Kud1x1Rl9ZWb17hwl0AzHvkWYM2z8B0+5Xv8xaE63nwQQgOMVRVRJcwPbb/WN9j44O6kfqwOqEI
	8q8yxt4mJCPCaBSnlu0VJKXRl770DKJY=
X-Gm-Gg: ASbGnct5tL8Sdd7N7OcH9V4KRagYAnLMnt/zyPkQDY+oOYm1yiHuASB5UqJu0qiayx0
	XN3A5B1Su5JfHZNErqxx49UlU3ZoWXISPPd65+vUqSghEfK6shWMHIn+HqzFijVd90etWGe1nso
	/ykYAwDucqbAdEZzBbAihOLy/QMFKm3yo1fuOsJC512gGV59xbRlBQqUtzwvgcsED/oReG/gf5O
	wKCwXHHTQH/k5jycSszUibOLyGsP4TGNkVnZgjy
X-Google-Smtp-Source: AGHT+IFyNx87WkucEh4IUe144Snnrs8UIvE2HHg9WmEgjBihbVbfffswex+Qoi5vAf0JBbS7kN+nkcwu/mGzgjpLhIk=
X-Received: by 2002:a05:6214:518a:b0:78d:4452:754d with SMTP id
 6a1803df08f44-800f448ed2amr147929456d6.13.1759026133538; Sat, 27 Sep 2025
 19:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926093343.1000-1-laoar.shao@gmail.com> <20250926093343.1000-2-laoar.shao@gmail.com>
 <34a9440f-b0c4-4f76-a2ac-f88b54c2242e@gmail.com>
In-Reply-To: <34a9440f-b0c4-4f76-a2ac-f88b54c2242e@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 28 Sep 2025 10:21:37 +0800
X-Gm-Features: AS18NWCHyMM-LHN0Py29bv_E4OCzemb4p3lZQK86XhDW5EVePduz12uMvfCrD14
Message-ID: <CALOAHbD8tup+4DbQ6tMzDxk=XkhW1t6B2L8+k8nP-1wg2zoXqA@mail.gmail.com>
Subject: Re: [PATCH v8 mm-new 01/12] mm: thp: remove disabled task from khugepaged_mm_slot
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 10:11=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 26/09/2025 10:33, Yafang Shao wrote:
> > Since a task with MMF_DISABLE_THP_COMPLETELY cannot use THP, remove it =
from
> > the khugepaged_mm_slot to stop khugepaged from processing it.
> >
> > After this change, the following semantic relationship always holds:
> >
> >   MMF_VM_HUGEPAGE is set     =3D=3D task is in khugepaged mm_slot
> >   MMF_VM_HUGEPAGE is not set =3D=3D task is not in khugepaged mm_slot
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Lance Yang <lance.yang@linux.dev>
> > ---
> >  include/linux/khugepaged.h |  4 ++++
> >  kernel/sys.c               |  7 ++++--
> >  mm/khugepaged.c            | 49 ++++++++++++++++++++------------------
> >  3 files changed, 35 insertions(+), 25 deletions(-)
> >
>
>
> Hi Yafang,
>
> Thanks for the patch! Sorry wasnt able to review the previous revisions.
>
> I think it would be good to separate this patch out of the series?

right. This commit is independent of this series. I will send it seperately=
.

> It would make the review of this series shorter and this patch can be mer=
ged independently.
>
> In the commit message, we also need to write explicitly that when prctl
> PR_SET_THP_DISABLE is cleared, the mm is added back for khugepaged to con=
sider.

ack.

>
> Could you also mention in the commit message why the BUG was turned into =
WARN?
>

I believe we should replace VM_BUG_ON_MM() with VM_WARN_ON_MM() [0]. A
warning is sufficient for debugging in this context.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/deprecated.rst#n32

--=20
Regards
Yafang

