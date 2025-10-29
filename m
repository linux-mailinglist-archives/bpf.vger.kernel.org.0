Return-Path: <bpf+bounces-72672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC2C17FF7
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 03:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34EA9506CED
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6092E8DF0;
	Wed, 29 Oct 2025 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5KMMGIh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768CA2DECA3
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703420; cv=none; b=kAK+bmOjwsJAma3P5ZzO2eqmhurdriVbiw3x+3jjute5aJaqsAJflWdteqh+TCDFHOHXNFt3aHMlWv2+gsk5oOisvufxZ/grxEgZjZtb8cmxk/+lLem3wblqd3q7c964ceNccKYsnjjJbVi7lRxfcinkRrggz35t4tVTQmYO0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703420; c=relaxed/simple;
	bh=JFOCaSvR9HzklXLPUtzvfEm1Y+lbkrlwxkaLN+QNHOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iooVLp7UTs+rgwrGsbyi9ccnNX60lL7wiRoK3T/4dj+ilr1ZQeldjit6xn8E78cpgTSYFCo7vxpxduiptNuhBkJntWws/qGI/fd7TPuQxR7a9zKBvBojt9+V8hXus3F2+d4mtrB049qFu2U1G2S5enTNcMEdArWxXDnkdAfeBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5KMMGIh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso14871350a12.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 19:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761703417; x=1762308217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awmgrMSZ0vViyGclR/UImdV+loGp8m8sh9JoAmi4oAo=;
        b=i5KMMGIhzPgOmvcLTOFkKG4QxkrCPDYRP7GlM0aoyK43pRU0MjgJ5HxGzBO8VTOEq6
         ZuIHx577Ksdad6/T4hivGlKP6XKkp6Ybdvt7uKZnip7sqZ2EGugZux9/2s54GE5271yP
         P5zA0Wnwh2Ap40VVn5jPkDgZcn/jfNvIM+Qb9KpHCdwafW4p4VP4MIodLHzPUTkdRkRi
         rqsOz6QulNwLT+TINgThyA/zOEmJ9/zPiekJNhwVY9MOTlGnHtvX4bgJj5+Ezcw0a4+t
         JyU/FZ5FLCFhoDDMSrOQmG7hWeiLgJnDcEYtvbTNjwUS9VbfuSIHgk5Pz271IOV7qM5r
         AJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703417; x=1762308217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awmgrMSZ0vViyGclR/UImdV+loGp8m8sh9JoAmi4oAo=;
        b=q8BiI0TGJ/u2z8CCHWnJnnIdj+C5K/pO/Q+tdRl7UZVdn4iOx7A9dNOurvmlEB4xfH
         VLgL0SFYAJfZY7NaEeAOlSOwz8T4luCEBYClQLEYIE2Vi111Br604iwegiCZH519H1U8
         aimCmMlR7fy/Tx3XfL6lzqYCyTcifp/cr049ROPieH5N/T27oyswN24r33QAgEoDXzbF
         jZZnRhTl5D5X0dtc3moRAFIHpZQxgWBCclgvdxaFiMtFYRLlhq8tY9LaccsJuivhryGa
         WXZPQOA/IP1/bwgnHL+i6xvM5x7w25nUQo+SOjacNeXP+SVJTHbKH2VeNlNi/jD66hxL
         He/w==
X-Forwarded-Encrypted: i=1; AJvYcCVNaeg9nw1LmU1Peo1DslGbczdvaTUxzOd4DQOZL8tGaRPK2Q/CARJOL/vortC+2atZH4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUbKPy8vPAK8epnapjccATwNDMNCELYsCdB2fyvZiRwDPyA+QN
	xxZTl52xr2Y5nA95r+paCZF63/irLMiWQWeBvZMPUvY5F/K56Z1hqvQYawSpjCbkFThA8vJOk+f
	82LUGElcfYzbfVSdCbFguJX/bfxBFQ8VGvzbT
X-Gm-Gg: ASbGncvvcJhAOtwkD5lTldJX9dJrZHWDklsZPXco7WLwNx9kIxaisl9uIRWWq7sCruF
	7oTq685GxYGBDsR/SL+PhXmRsP73li0DgAZtyKCqwRHpVZoyn+V88N2yAYyOJdfBGCKrpjAY/JL
	agAfc5FCeQ4Z/Fw4oTclfb+A83IrrnA8KmjwBOcuoqmuGCrS0VRBchFjYcezho25Y+AGYWb2i8k
	378vreN9zNXidYqhBrC8GQFdmxCT0NQYx0ABIgJE8KJNOPb63jbkNaoOiL0TA==
X-Google-Smtp-Source: AGHT+IGMS6zqF6H66s7KZSVmBsiUMKOOrcvuSGjOFHawQAv1CeRDU0yVsTSKeSmBTJm021t3hQm9EyWHD5qsCyDVX94=
X-Received: by 2002:a05:6402:1d52:b0:63c:25fb:19ea with SMTP id
 4fb4d7f45d1cf-6404425e7b2mr908786a12.18.1761703416465; Tue, 28 Oct 2025
 19:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
 <20251027135423.3098490-4-dolinux.peng@gmail.com> <CAEf4BzZ+tpT2ViD_zc8mwz260spriYDiPymw3MFsEibRcuqbqg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ+tpT2ViD_zc8mwz260spriYDiPymw3MFsEibRcuqbqg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 29 Oct 2025 10:03:24 +0800
X-Gm-Features: AWmQ_blQc9lLP9vviKdBhFkt4OLa0RP_uBRK-fZh8MjADvNSmr-b3VVUIG7Z0GM
Message-ID: <CAErzpmvahZJRFktDydp5tcpYnhCAw9P9UmPeC5XpRxPuo0mZ8w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting
 verification and binary search
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > The previous commit implemented BTF sorting verification and binary
> > search algorithm in libbpf. This patch enables this functionality in
> > the kernel.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> > v2->v3:
> > - Include btf_sort.c directly in btf.c to reduce function call overhead
> > ---
> >  kernel/bpf/btf.c | 34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 0de8fc8a0e0b..df258815a6ca 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -33,6 +33,7 @@
> >  #include <net/sock.h>
> >  #include <net/xdp.h>
> >  #include "../tools/lib/bpf/relo_core.h"
> > +#include "../tools/lib/bpf/btf_sort.h"
>
> I don't believe in code reuse for the sake of code reuse. This code
> sharing just makes everything more entangled and complicated.
> Reimplementing binary search is totally fine, IMO.

Thanks. Would you be open to the approach from v2, where we place
the common code in btf_sort.c and compile it separately rather than
including it directly?

>
> [...]

