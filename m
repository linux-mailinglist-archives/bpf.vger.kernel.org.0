Return-Path: <bpf+bounces-67625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA5EB4658B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AE7B629DA
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8812F28F0;
	Fri,  5 Sep 2025 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eITR0bcc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5B2F069A
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107896; cv=none; b=N4FsqWtI7q8K06Db9SMLTIPZc6sUylmAy+eQyaoLvcTuRJfvOtns7ygt0gccggwhViy2juRgSyZr+Me02KLGExtRpCrPPdQIfHdBXeoJioD4wQajTgV6QkAxFgw2pmyGPejS/qPW9phS/ku2oD3EYEJC2BgC8vkJVP6DV5tG0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107896; c=relaxed/simple;
	bh=6Q94cZ7NSrhX6BjKaGmvaegWXVh1akMHOcRSKmZtvZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+U05Wy69nWzx3KK0/1oB01D9R6ZhtCNic1rEguGljbApgUwrbifGnIpVdeFI4xPINyeAG41AjUcfPJUHie+AWdo7V7cUp//PvbqHA3de4SXuRkCiLM1Gax5uj+vhP1DOIK9QGdqCSUWzP3XXKsmvDzQbzY1kKFfYO0jC5NJDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eITR0bcc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32b92d75eaeso1723587a91.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107895; x=1757712695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywt9RukDF8KyJU6JBKaqLIsNi79StlQwOVQw1Dbcjj0=;
        b=eITR0bcc+SpP+KSZrlhoPxsSz8xdlRYwgsWuwQAPz/j58AXYcrnV4LA6hIDYX1owjP
         apQhamqhEKJVmb0Omd8vHUtVmpynHBQxrRrpU93JG4Gh4IEwI3HcOlAwI+Z+ppmaHzza
         tqk+QHLZPAwSLAJKEJy8Cqx5r9TYwDJMgsw2ceYxDDELaUN3Cl0UQz5DPF7i87BY+Wiz
         i/xsHVFJOhAxdY3K7LJOr7L4HZqzi1MTdiJBdjpe8gznKpPX9m84dmxMpOsyNgt58yx6
         CQH9JvypXJrIRA9v6+nDGTIwCehuKHry28d352Mls363TWxq+MSsB6OVxXMLgEfhhVMR
         yWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107895; x=1757712695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywt9RukDF8KyJU6JBKaqLIsNi79StlQwOVQw1Dbcjj0=;
        b=xBHn7uXTcH1wreapP27MMdKLBzxy0Aj9wyMBTnan48C5QJW8+as2IN6qWlKrsMeFbZ
         JsonCClctNFPL2B5JU6SGAVt3lerri30j4XBosJ7qHkHjG9vX8H8zVDnf2ALMpzHD1oj
         i7YuU+MoFcWoMY9icrQBiZJzBbsk6/fRLeVYaeiwIUzBxn98TsO+IAD2NVHqdUJ9zYaf
         iKQtCQg5dLTDPTMftxKU9MqBE3qlfLCG3vnKgJQmYN6cWHJaocyKgC0OAqcKDiDDdgaV
         T7bYdFxFOhD2Z967UlzPw/5+NqMUrSL/o/bsM6pJ0J6emL/AWdGG+txY4Ti0PW15ozuX
         hvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU61pRpiutEkxUXcvPQ7lVpEMyyWxOk9rd604nuf4LvdmkhTCW1Ur5l3CaNVX9+JUBfHhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjh2tzZ0ZaJK8CKed1JLgDxXLWgdNaavdGMfk36372NeO9R9R2
	Y7D8czbOyfu57Jalpj86cQcUemJORCCQBxWyxRLgiiW2BK4jISqLs7EhQMmdIruC5JHT/rZz2gV
	9Z+X6iVP/fWCyuAt9unosgAu/HZSOWtI=
X-Gm-Gg: ASbGnctxJRjpTdkYxENMCsnq1M4yrT+QaCeQ4bfIKpbk2JEgCvwaCPIHTmAx6KGMAg0
	sf85aAmAgS9jmz2dnNv8R1VLVJACsElMJbrWSIIGybxLpCkEFLzMjJ9P1KkkPvgTEtUBeW87fYO
	MNxmHNcj/QXtTEzljPXWsiuKIfFE6is53nNpmuNPcZNRbp7vKi+pAYMD7by8PBkJW6DHb0+V7wC
	C51bsO8SZQU88k=
X-Google-Smtp-Source: AGHT+IHc4Z674kymMhbedR2tJXeyzklUVyL0XQVLF6zwBPh8e+ZWigXpaJH8usWEmNIYIV+CoV039cpAhcuQKW7UFNA=
X-Received: by 2002:a17:90b:4ccb:b0:329:e9da:35d6 with SMTP id
 98e67ed59e1d1-32bbcb945c3mr6329783a91.4.1757107894708; Fri, 05 Sep 2025
 14:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-3-mykyta.yatsenko5@gmail.com> <dd66ef2b3ba7d462b649ef87ebb2e166103bdb79.camel@gmail.com>
In-Reply-To: <dd66ef2b3ba7d462b649ef87ebb2e166103bdb79.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:31:20 -0700
X-Gm-Features: Ac12FXy5B-C0g5wo4AcTsx6iSJm5BlZcHOY39HbDhqnMUDpNpXgqn71p_Hih_-g
Message-ID: <CAEf4BzbiKHQa_q=KrPaXsJRPCQue_PPoEazvsu5G6bg5yvXO0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: extract generic helper from process_timer_func()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:28=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Refactor the verifier by pulling the common logic from
> > process_timer_func() into a dedicated helper. This allows reusing
> > process_async_func() helper for verifying bpf_task_work struct in the
> > next patch.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++---------------
> >  1 file changed, 24 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b9394f8fac0e..a5d19a01d488 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8520,43 +8520,52 @@ static int process_spin_lock(struct bpf_verifie=
r_env *env, int regno, int flags)
> >       return 0;
> >  }
> >
> > -static int process_timer_func(struct bpf_verifier_env *env, int regno,
> > -                           struct bpf_call_arg_meta *meta)
> > +static int process_async_func(struct bpf_verifier_env *env, int regno,=
 struct bpf_map **map_ptr,
> > +                           int *map_uid, u32 rec_off, enum btf_field_t=
ype field_type,
> > +                           const char *struct_name)
>
> Also, it appears that process_wq_func() needs to have the same checks
> as in process_async_func(). Maybe add it as a separate commit?

heh, we raced, I was asking the same question.

But let's do any extra refactorings and fixes to pre-existing code as
a follow up, ok?

>
> [...]

