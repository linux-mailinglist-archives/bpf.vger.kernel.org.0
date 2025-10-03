Return-Path: <bpf+bounces-70351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1834BB8424
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 00:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 266273487F1
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2026B742;
	Fri,  3 Oct 2025 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5I4LePG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C9253B66
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529032; cv=none; b=YLZh2DsrswfGzLgRn4Q449BYGPyINLob2AIkI8a3uj91V28cXDC29Y6j+FydA2tt66PN8yiNlN28UtWr3rhaYyChgt+OhAVYNZca5ybiMbKHRlg6bVRa1KYitkYiVzqKgzWSFmeR5NTe/e+SDYbuHrDjO6N7nVonxfXax+zDXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529032; c=relaxed/simple;
	bh=FETUPxZjo1EqzMJ3Fc1ECCRLkysnMqFm5vV9+mBJboE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6NB8l5wI+N/J+3uKuyVohZDGs/S24c2+nzTXeJQYmzLfzH0kd85mVZb711b/jPPkkEtL+GI5/uO4V+FS+vVnO9DYeApAsaG5xjmnJM9al4+smngG9IG55vYW4OK1ItPN7EHvacVA6jLcZMzd09TLjWRVW08gKZsC/Shgxz0i/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5I4LePG; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d6051afbfso31185157b3.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759529030; x=1760133830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7l8G4klFL2hUMCpoFN73V2guBbCIpccmSkTTddipZo=;
        b=L5I4LePGUc/ChOY3iLTYrH8+/OkbX0hgLKyKrdEJSNs515JmZKZ6TW0CLe3TsaaKb7
         GcXOQOgEHp37lREmp4B5WoR78yVYwQb0lPHiLDsYdcec8WiLH/3etxaC8noclQJbFgyd
         PJ7VksHzvORJJoiEYcJzPBGD3lcKptM+kkVbjNLJkM1b96Fr/hATVhcuLFqSOL/vjR64
         5m+GnMASRaqUtEHDieCQyOtGtqskeQZMez0xBs6XeWJ3bH88NOswMzTkUUQoJzHENcER
         uuznaDE0leVp6FcGrCrvpKXSKfpGKuAsjSXy0sx9JKa8hWq1EsQOJCvXouLxv7mjhbXk
         kfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759529030; x=1760133830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7l8G4klFL2hUMCpoFN73V2guBbCIpccmSkTTddipZo=;
        b=VZuzncmlKaucVnwJnqtSLr0Y2mWUy3GRc/q3y1yZ9RCANVOV8JacR4zRl4vwJyC0SA
         Wt4HReXVT7xOt2Pw+rw8SdaILFAY3FIWdF2gx11zmXut1pLD+SpE2lJz1NEXFXyeFB0V
         8A67KXndx+2OrY49HL0Hx7Woi9fSbAEU6ucfZBK1y5EXkI/UIuSW7nEIpgmVgvAMRvKg
         BlfutIM/bpIyRO5OXrkRJ4YS0Y7w4JtseDRlocWezAeNTkRIu9SfvIR3Lonc8rVUlMqb
         8FtiCxHQtqM3XcIBVLFUBT6LJD4buPH193s3uTJuYhIDDuhSozS6LxOaBuR6lpmKAy6P
         /IrA==
X-Gm-Message-State: AOJu0Yy8R2+J396NkoRqvh1xIfFTJStvOD+t37JVlHxa3nrtMJ8E7SeD
	gDdK9hQWK3gcYuBwY8geKbw55J5tXb/RAnktBJrb+PdasSQEm4u/unHNTMKdlEkj12nia8cvv/s
	2S4CyTiKrVMZQXNyPLiSmySNxunuj1NY=
X-Gm-Gg: ASbGncsibMuPiorc8s85khybo59OojCLrYT+jBKYWHJy/kbVRi3zUVJjT45SWvmI486
	8XhrBDpkhQl6u25lcHuvnEbN0N2ZWJRsrMWfckHu2Vd73hh/xOOhiMWxomR8PJdQA0lWOOjspvq
	Xq3l7AOK6OZ3Yr4Fy3uTjcSFTDiNWstvkE/KxphpP2Bxb0qp8GHfrsDeURG85LeS5sTz9kKeL9N
	FKJZNSBIpKYAjjik4R3Lk9AokhuZRo=
X-Google-Smtp-Source: AGHT+IHrxe3JDL54sXXcJKwC7ywZpRFoUViH0+78HqD6QpkD3BwPdJAF43Fm7wkWuj71g1PeEj2AVny0rbeecr7Sdag=
X-Received: by 2002:a53:c055:0:10b0:636:875:62ff with SMTP id
 956f58d0204a3-63b9a105f94mr3987180d50.35.1759529029810; Fri, 03 Oct 2025
 15:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002225356.1505480-1-ameryhung@gmail.com> <20251002225356.1505480-7-ameryhung@gmail.com>
 <CAADnVQ+X1Otu+hrBeCq6Zr9vAaH5vGU42s6jLdBiDiLQcwpj4Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+X1Otu+hrBeCq6Zr9vAaH5vGU42s6jLdBiDiLQcwpj4Q@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 3 Oct 2025 15:03:37 -0700
X-Gm-Features: AS18NWBZrlJsJAwdWIoBMdWhMwHsZPpbGaHwyGFKc5eQ6vKg5otabttiwb-w9PA
Message-ID: <CAMB2axOUU5J4Ec=tuBDYePzucw1QQLciFWC01=eVQdPOhT1BGQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 06/12] bpf: Change local_storage->lock and
 b->lock to rqspinlock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 4:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 2, 2025 at 3:54=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> >         bpf_selem_free_list(&old_selem_free_list, false);
> >         if (alloc_selem) {
> >                 mem_uncharge(smap, owner, smap->elem_size);
> > @@ -791,7 +812,7 @@ void bpf_local_storage_destroy(struct bpf_local_sto=
rage *local_storage)
> >          * when unlinking elem from the local_storage->list and
> >          * the map's bucket->list.
> >          */
> > -       raw_spin_lock_irqsave(&local_storage->lock, flags);
> > +       while (raw_res_spin_lock_irqsave(&local_storage->lock, flags));
>
> This pattern and other while(foo) doesn't make sense to me.
> res_spin_lock will fail only on deadlock or timeout.
> We should not spin, since retry will likely produce the same
> result. So the above pattern just enters into infinite spin.

I only spin in destroy() and map_free(), which cannot deadlock with
itself or each other. However, IIUC, a head waiter that detects
deadlock will cause other queued waiters to also return -DEADLOCK. I
think they should be able to make progress with a retry. Or better if
rqspinlock does not force queued waiters to exit the queue if it is
deadlock not timeout.

>
> If it should never fail in practice then pr_warn_once and goto out
> leaking memory. Better yet defer to irq_work and cleanup there.

Hmm, both functions are already called in some deferred callbacks.
Even if we defer the cleanup again, they still need to grab locks and
still might fail, no?

