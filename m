Return-Path: <bpf+bounces-73475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2601C32631
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 654FF34B572
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD533B96D;
	Tue,  4 Nov 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM2//7nN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CEA337BA7
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277872; cv=none; b=fzhqrL2WNcUMaC92OU7TwuzkLr/ivTWeem8E+OKbbpssar+HKKS/hGTsU/YIJLGBqarsGsbf+V5ZwSRraC/MUKZUrNZFeOIMqKdHPVb6yQGLRQzorFMyVvlSvlysadm0QBSyEDAx5gOTVsoJOQz7a2icNovhDuPSubQSW3U9lqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277872; c=relaxed/simple;
	bh=WkWoFlzLWrtoonOriznUpRT7GVU0aUWQDi9dY7O8y/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppIi9qNdaw+tXBHr+EUwBTlIMBo/fQCkRxAuBe8cPvR/vKlU9NG/hACs409qFvwf6qtuWBsWyRvropdyEyIRnl5xWP3XEhUm1r1AQBVPnLbCHndAZwiTrQBHH7uKnTSH49rbpndtSfsMdMfhWtDMVLl1m6YbdpykQog2wrsZXDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM2//7nN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c7e438a8so764206f8f.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 09:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277868; x=1762882668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1bvPtQqK5wJYevzmSRi7u47VtAKZQqTEATK+wkw8y8=;
        b=MM2//7nNY5c1ERSSB+IWCV7YVTCdAxjaDLu3zK6ga2zWzYpCbnezFDEEvbJNr1fhEJ
         +4bM8NOJFzNgekI+FM+OcJeIZLqSSpQrVJarrqb6AJYifhC1yBN4dIpgdzFHqUCF1qRY
         HB8GW3dfz3ohiWnVTmAbhrytRJ+EBN0/iEOcFtXoQrvm/pav0lB4zeRCspmfxud70dKw
         m5qcwti/Wv6Flm4jFm0TDrAB0lcaUGl2fp9/11lRYbi/f4x75ap/CcgTtJhQIj1Ct1tL
         Q116MUU8mljddtco8DEFU/StyiM30DxjoJo1/oNYjfDjdWiBZ2X1nJgFcAmPQcR21RzD
         qWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277868; x=1762882668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1bvPtQqK5wJYevzmSRi7u47VtAKZQqTEATK+wkw8y8=;
        b=WpFo2WqCiLnACILpg1eZ2Tl1M82tsgh4tHm42sNATcrR1u8/7OesyNDDQSR9LwNGc8
         +IfXMewxTjazJ+7eecV7MGAWUFUCVcDPsTYqADu9RL/O5dnrsz646xiXoR9GJbozV5F2
         hokoPmsELMrh97us7DRJQm6dZHzO0aXLk1VrAKLVartoOUDLUF54SOhUOrMIPIjoX4sw
         Oqdxgr6AAmhVttRxXeaqL6acyM5HeQ99r96gxx8ux21oYdkMct2A5+DA6KYfTJTAmkA1
         Dg6SNxNGFDyLsbTLbOYtbNCn17bGnbWI9xUjN7YCoo8ZZXjagzLRcfVSwVIMJhzteRO/
         7zBg==
X-Forwarded-Encrypted: i=1; AJvYcCXujz+SJTYttlF2wS3kFBLemlF4tOrkU0Vigbm6jkB027k6DgpeFKv6I87rUFE1J45b+F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxezQ5o70ue65OpHULPtBKt1S64hnWtioIg47FBk1aK70V5udBP
	LK2vbOn3f614tbXEbrQiftG9SMBtiihdhpeQUcTpkN7Ga8R6L81gmnBDCMd75mixufdfauMn7qV
	yN26vTxbDrbuNhtw2VM9Bw43NbFbciPI=
X-Gm-Gg: ASbGncsXc/acYbrj7JgLkkxT2L0iGKSpHX02ogaabQszscgMNv8d5C6V0gR69lbfKd8
	KtQ505Xg7KXixtvcrVMInwx1vORnQSkOAhdithwUUNnsNJIhe8hwSjP7yeJ80HeS4f65APPn5NH
	Re+AbZtJM8ohra3YJL/Ms5AG9Ic/tZ7Rqusny5awSiWdsJSFcK5Ri7E5RQDWiOrNBxL00p0S4Q6
	kqnCYVxLeObSeDIoNOzEBM136wqXRZ4dYyH2ORAwjMA3nuUXCpkDDa2tegA5RbyIA3apO/ZGqs8
X-Google-Smtp-Source: AGHT+IEGeBxngorLN6Ifh/aikMrr1qyEaX+vnV55U8kwz86ypB4XdSn2alRjM+h1icXtVOrxwg7AJA7lvCX8eaFdA5U=
X-Received: by 2002:a05:6000:65c:b0:429:d348:bd8a with SMTP id
 ffacd0b85a97d-429e3275ad4mr129085f8f.0.1762277868412; Tue, 04 Nov 2025
 09:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104142714.99878-3-leon.hwang@linux.dev> <6099162df8322a2198497a8a27e1b0e1e5c017aeb74b20fc1eecde1e67826900@mail.kernel.org>
In-Reply-To: <6099162df8322a2198497a8a27e1b0e1e5c017aeb74b20fc1eecde1e67826900@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 09:37:35 -0800
X-Gm-Features: AWmQ_bnMMHRZbRDeos2doqIlTljmNjWGI5oy9xwOgSRLV1ionAebzkdsoVB-s_Y
Message-ID: <CAADnVQJZbyQWaUTzB0=82mq+hSVqxGb679cW1=t=OFCRuCVdXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add test to verify freeing
 the special fields when update [lru_,]percpu_hash maps
To: bot+bpf-ci@kernel.org
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:52=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tool=
s/testing/selftests/bpf/progs/refcounted_kptr.c
> > index 893a4fdb4..87b0cc018 100644
> > --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> > +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
>
> [ ... ]
>
> > @@ -568,4 +568,64 @@ int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_=
lock,
> >       return 0;
> >  }
> >
> > +private(kptr_ref) u64 ref;
> > +
> > +static int probe_read_refcount(void)
> > +{
> > +     u32 refcount;
> > +
> > +     bpf_probe_read_kernel(&refcount, sizeof(refcount), (void *) ref);
> > +     return refcount;
> > +}
> > +
> > +static int __insert_in_list(struct bpf_list_head *head, struct bpf_spi=
n_lock *lock,
> > +                         struct node_data __kptr **node)
> > +{
> > +     struct node_data *n, *m;
> > +
> > +     n =3D bpf_obj_new(typeof(*n));
> > +     if (!n)
> > +             return -1;
> > +
> > +     m =3D bpf_refcount_acquire(n);
> > +     n =3D bpf_kptr_xchg(node, n);
> > +     if (n) {
> > +             bpf_obj_drop(n);
> > +             bpf_obj_drop(m);
> > +             return -2;
> > +     }
>
> In __insert_in_list(), after bpf_kptr_xchg() stores the new object in
> the map and returns the old value in n, can the error path drop both
> n and m? At this point, the new object (pointed to by m) is already
> referenced by the map. Dropping m here would free an object that the
> map still points to, leaving a dangling pointer.

AI is wrong, but I bet it got confused by reuse of variable 'n'.
It's hard for humans too.
Leon,
please use a different var.
n =3D bpf_kptr_xchg(node, n); is a head scratcher.

Also see Yonghong's comment on v4 which I suspect applies to v5.

pw-bot: cr

