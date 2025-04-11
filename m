Return-Path: <bpf+bounces-55758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09186A8646A
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A321BC7AA5
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656A233D88;
	Fri, 11 Apr 2025 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUqmUT2L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA352221FA5;
	Fri, 11 Apr 2025 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391320; cv=none; b=PiTiu+PuwZHNtNWLBO1UryMcj5tHdVQidI/yup8agLs1lo3WDRCVONcdDMySCmQ3CBdR/yTAW/q+7MOFkY4f+kV0+gCUJM1lWb/BN7+Qcyn5QIClibXBnDwnWMpsd97joJpxgTMJ3PDsEIMv2epgoG1UjEghM28e6f61HPDRrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391320; c=relaxed/simple;
	bh=D3KtKMQYdkJYf2YN9ITQ1Y9ff9xFw8ASy+2JgvutajA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoJUujYsWCMP9XykE7gUtiVNvlTdAYhAyVh1uJ87G0gKia/R5g6Lu4AZA6PH+nKINQwpJvT6d9AAxsAtY1g+0Un4k8Wu1kZFeIlV2ssKTXZiPZP7mdiIQdxCZ/UN+/9NUOLrK0xz2yBVo3cM+riQ5bn4LfOZDvAOywEufSEeK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUqmUT2L; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso449641366b.0;
        Fri, 11 Apr 2025 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744391317; x=1744996117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVl+L+m1ll7TwdhJXg0KpefIZfJmTlR1fTVGe/qAkw0=;
        b=EUqmUT2LQkBA3j9g6CLILP9ZS62loqDVtAt3U9OFniFtJPSLVjACOWHLODNHTi/8mW
         VX7EVLc228v6egc7X5uS/PDDFvJ4ow094RtDxh3x3Xop0vzOOs2NZe2IF0vj5V4/qjH0
         znBjio1o78UwIL5c1bs84j1MXfcD7eUXfx2J9c+WrLk3nDyuqBgS5h6RZCbevsDMCc6U
         6IQTVqYPifq6UW/IiIYaOMQbif3TQMpY9wk6frLh/X9f33uJ7iHUKhKuQ9ulz9RtYVup
         TfaT5wHP7lxDu4osPI/XZLbdycwKFUCvBTlK6ifOQoIvIpeNescus+XgkVavVywqWw36
         w7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391317; x=1744996117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVl+L+m1ll7TwdhJXg0KpefIZfJmTlR1fTVGe/qAkw0=;
        b=LO6yBpySbsIHzaPvatJn3zT2ciuXlrpNzvSkba2AMydYRbaMzwYONsi/KEgTnYyGNS
         3A4lfHLNDZkwLXnGUgDbV5B7Rfa4u1TMLUpnmHLPRJIPzAXCP/Q6S8ZH7+HA5+/P9ZSq
         PjcFUEVCvexlqw4b9rBPD65YgYa0Buktu14Mq3Uc3g5iuqnTB5gEn6zJY3CitZgZ9Ij/
         VcEv9AXr8lne7tQmI10ouS7/UYrYTI0SjkPv2AAiiTRdBdAc3/79gHtGM1mYkZHsZpP8
         XkKVsHc519Z3xG75LKJ63MfhwBKcYaOuiN6vrSZYeLC391opOHwTzPEJ5cj6ikCygkFO
         VQMA==
X-Forwarded-Encrypted: i=1; AJvYcCUuRQK+BZNBVMnGGHjQQR+ARAB1qcoIGynFZGQdZXTf6wzcbcTBhof5W9H0jbfPSceRBizbTh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzyOpKCELNvTSfSMFMezOq9JZvyxileE+IEFLNoG7XJjNRJ3C
	4dS/EekUkAFO9539lnRnrsV8/6+d2yNP6nWR+z3W7JUSPvf1yXNzUDggZ4NhXAzMMsuCYUurxNb
	j3hypGxXmTrzPow+TO/PSMytc4Dc=
X-Gm-Gg: ASbGnctkMGDGRaAI+hDZWekEOl44IqRkiIRR9PKEAIvGdoI9pwW7rWWlWtvhfeI5CSe
	00IcXp81QDv7Ikp0eOZ9/v8CISBT4gM1EVIswatEGDwZrbQVysyDkVrhDml2p//BVH1ESGwcskE
	WQwJNuGYli4iYPQsYLtCSs/13MA95N375Z6WyJB9Ndl0LUCnjyMm+CmimrNUIdxUAfm1Y=
X-Google-Smtp-Source: AGHT+IE1S5/pMfPq8srWnliFtQB++Im0wBa1VUhuq3j7YbNBfngu2Iana4iKCogFdkJCJeU0B4F77hTTSk+V3vr6aHI=
X-Received: by 2002:a17:906:dc94:b0:ac7:3a23:569c with SMTP id
 a640c23a62f3a-acad34468e4mr374508366b.1.1744391316810; Fri, 11 Apr 2025
 10:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409214606.2000194-1-ameryhung@gmail.com> <20250409214606.2000194-4-ameryhung@gmail.com>
 <CAP01T77ibGcEhwsyJb1WVaH-vhbZB_M2yVA8Uyv9b5fy=ErWQQ@mail.gmail.com> <CAMB2axNqfBpneVc9unn7S65Ewb1u6EpLudjtiq00-sqbfnSY7w@mail.gmail.com>
In-Reply-To: <CAMB2axNqfBpneVc9unn7S65Ewb1u6EpLudjtiq00-sqbfnSY7w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 11 Apr 2025 19:08:00 +0200
X-Gm-Features: ATxdqUEovh7GnQ8DIeoN0dqTqbyrGAL3wyyGR0LW_E-rCblthR5o6-ehz6zduiY
Message-ID: <CAP01T76oTKg5H2nqd5ppyLhk1rNjPY0DcYVELmyZU+Du8izbbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 03/10] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, martin.lau@kernel.org, 
	jiri@resnulli.us, stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Apr 2025 at 18:59, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Fri, Apr 11, 2025 at 6:32=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed, 9 Apr 2025 at 23:46, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > From: Amery Hung <amery.hung@bytedance.com>
> > >
> > > Add basic kfuncs for working on skb in qdisc.
> > >
> > > Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
> > > a reference to an skb. However, bpf_qdisc_skb_drop() can only be call=
ed
> > > in .enqueue where a to_free skb list is available from kernel to defe=
r
> > > the release. bpf_kfree_skb() should be used elsewhere. It is also use=
d
> > > in bpf_obj_free_fields() when cleaning up skb in maps and collections=
.
> > >
> > > bpf_skb_get_hash() returns the flow hash of an skb, which can be used
> > > to build flow-based queueing algorithms.
> > >
> > > Finally, allow users to create read-only dynptr via bpf_dynptr_from_s=
kb().
> > >
> > > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > ---
> >
> > How do we prevent UAF when dynptr is accessed after bpf_kfree_skb?
> >
>
> Good question...
>
> Maybe we can add a ref_obj_id field to bpf_reg_state->dynptr to track
> the ref_obj_id of the object underlying a dynptr?
>
> Then, in release_reference(), in addition to finding ref_obj_id in
> registers, verifier will also search stack slots and invalidate all
> dynptrs with the ref_obj_id.
>
> Does this sound like a feasible solution?

Yes, though I talked with Andrii and he has better ideas for doing
this generically, but for now I think we can make this fix as a
stopgap.
I will add a fixes tag, asked the question because I had the same
question when implementing a similar pattern for my patch, and was
wondering how you solved it.

I made a similar fix to what you described for now.

>
> > >  [...]

