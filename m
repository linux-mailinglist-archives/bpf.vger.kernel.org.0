Return-Path: <bpf+bounces-55343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA305A7C198
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2828B1B60CA1
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AF820CCDB;
	Fri,  4 Apr 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXJRurK4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7601E1DE5;
	Fri,  4 Apr 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784453; cv=none; b=g9EIPGBPivAraTZVyTVgpPTF9ktaB4xMfWNQISWMMeWjkJSGwcG0Lrvvtu02koy3BHxWRMf2Cm0oBrwZ75kRTPaKzMnRkGp1HUTmouCG3kPjTSqFzbIlzGbOG2lxR4VE2pFsDVyh5C6MpfiBcqvm9vYyFXE4JUbMJ4ByLSz6PqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784453; c=relaxed/simple;
	bh=7NsrsI+l9rLHQLNr/hGGlPATfpYv1HbnbKsMZR2yAlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4ZZTINhtEZIbLEgATzWHoRRMVr2WK+fH/xmJDrh+8flNCB51gjA8XAIHv+eAEqtpDkkBUbNpeXYJQdl8PnKzcYU6LXAOYLCWlGKZfsbV7x2DbZhLe79Fxpz2NaDoh+G/AvwXOWr4QmBAbWnR01ahWxWv8NJtPZqPOfS3gwbBws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXJRurK4; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-703cd93820fso22560277b3.2;
        Fri, 04 Apr 2025 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743784450; x=1744389250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uDKWqUJ1Mh2votuVohBMKz8iyjVCjktErRfvKYZ0lQ=;
        b=bXJRurK41MOiBYICTCDPdRA+6jRd+j5rF8A1Z1wbEh5UzZFBtSJl8vo495/IbfVJNI
         JQZImvLgf44vEOJH6lbyuP6Uwjo53IJtvI57lTnBPMdxr1yihOfcr7uSXx+y+v439sXs
         cfQtnme5J1O22LcUyidkNVPi9iobjRxqsVgyXhqKQpQnRI4UhX5cdye8uDlUI0M4o/ng
         onz7r2W7SiQyvXrmgBhjyYCUIJioG5AcNYnh1rlond5tXAfc6e49n99yG5NGIW+GqUlv
         PmAvBil6uQcoRch11Vu3MP+3kbymeUDUd92oREIWg77Q0kTN8o6v5bwdHkhkPoD7EtVU
         12jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743784450; x=1744389250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uDKWqUJ1Mh2votuVohBMKz8iyjVCjktErRfvKYZ0lQ=;
        b=jsy1r0tvK1IJEmiErEZ+JruyUS6IwuBYcg6KmLJcjPn12gru85ECeZqHv1Cg5QpyJP
         AwRhSw0lEZNL0eutZPxoe3HjMxvNF6+7yiDqhRBCjYzJOg8yg5FvIPC56sTlfl54Llfo
         UqEfP4ywhUzw6Wzv/X6W0XHTRbwD6QRTXI/ORsmBZPjW30b6iTn/ufNIJ3eet+JGEWWm
         DbaPTOgsUlvuN8q8PA3pp2/UWZbqnqxeY7d9w2/uXjocMI0a1+GXQegZpwZiwJ5EePBz
         l8N5CKPjxPs9vP95O5ubE0CviYFPMq/nTZn7zKh5YQgQOSMAYLRQArzHs5rSV4ICl/o+
         2nMA==
X-Forwarded-Encrypted: i=1; AJvYcCV4qOX89ou0DL4uAAfiQqcj1kETgKSLTvMeXtvRrdiSLBujUiBpgLdRJRqUJtfmgrogLZF1V28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDVFKx6op//3Zl55/hya449RqsRukkIj2uJA+zJW9zZnSYGRgX
	ghW+pB3IzQAxXsxxIOvMzbCsJSQN3b/vViBt+9IgjKEj/X6sKiwH7bpsN+AncreiQ1VPQWEngIT
	6iDBj9BBtk5Kc0fFRfFiqXzXV4MM=
X-Gm-Gg: ASbGncu+swtXI/gAPGxjSRJkyAwSqZjKIwfIF7pyuLib4c+IjOJUxLsPy0YWGqiOl+o
	yY6qbMbC6JuhnFAnccWFlWb+9Wb6DLBoU/jDv9NzKQCfpEhCyjyljEYw7969k5P7spKfU4uroG+
	PyvuKev0I9xPS+iQoKkZXNHkQDOgSZPFiZy3ogha7IPJi3ObkCl1Pn/aQ9olY=
X-Google-Smtp-Source: AGHT+IFbpwxn+U5U/hEEWv/ztsjgATFwKY0FzTLpSFYuWGcdr3UTKhJhAbnUKcpmp9n9SoOXMGsIJttcTuxUh6lHX2I=
X-Received: by 2002:a05:690c:7207:b0:6fe:d759:b178 with SMTP id
 00721157ae682-703e1503ed8mr66647567b3.6.1743784450672; Fri, 04 Apr 2025
 09:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404142633.1955847-1-willemdebruijn.kernel@gmail.com>
 <20250404142633.1955847-2-willemdebruijn.kernel@gmail.com> <584071a3-10df-443a-ad8c-1fa7bc82d821@iogearbox.net>
In-Reply-To: <584071a3-10df-443a-ad8c-1fa7bc82d821@iogearbox.net>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 4 Apr 2025 12:33:33 -0400
X-Gm-Features: AQ5f1JrD3F-2-QTzwjzpusEu57CQQT8S1sb5ZfpbJ5Y54G7m1VYHc6lgSPEGZY0
Message-ID: <CAF=yD-+ccY58AAneA7tLokuUahrj=8cdDtPPopGH0h8mK-hMbQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	john.fastabend@gmail.com, Willem de Bruijn <willemb@google.com>, 
	Matt Moeller <moeller.matt@gmail.com>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 12:11=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Willem,
>
> On 4/4/25 4:23 PM, Willem de Bruijn wrote:
> [...]
> > v1->v2
> >    - introduce bfp_skb_load_helper_convert_offset to avoid open coding
> > ---
> >   include/linux/filter.h |  3 --
> >   kernel/bpf/core.c      | 21 -----------
> >   net/core/filter.c      | 80 +++++++++++++++++++++++------------------=
-
> >   3 files changed, 44 insertions(+), 60 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index f5cf4d35d83e..708ac7e0cd36 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const struct soc=
k_filter *ftest)
> >       }
> >   }
> >
> > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
> > -                                        int k, unsigned int size);
> > -
> >   static inline int bpf_tell_extensions(void)
> >   {
> >       return SKF_AD_MAX;
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ba6b6118cf50..0e836b5ac9a0 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -68,27 +68,6 @@
> >   struct bpf_mem_alloc bpf_global_ma;
> >   bool bpf_global_ma_set;
> >
> > -/* No hurry in this branch
> > - *
> > - * Exported for the bpf jit load helper.
> > - */
> > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, =
int k, unsigned int size)
> > -{
> > -     u8 *ptr =3D NULL;
> > -
> > -     if (k >=3D SKF_NET_OFF) {
> > -             ptr =3D skb_network_header(skb) + k - SKF_NET_OFF;
> > -     } else if (k >=3D SKF_LL_OFF) {
> > -             if (unlikely(!skb_mac_header_was_set(skb)))
> > -                     return NULL;
> > -             ptr =3D skb_mac_header(skb) + k - SKF_LL_OFF;
> > -     }
> > -     if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(skb))
> > -             return ptr;
> > -
> > -     return NULL;
> > -}
>
> Wouldn't this break sparc 32bit JIT which still calls into this?
>
> arch/sparc/net/bpf_jit_asm_32.S :
>
> #define bpf_negative_common(LEN)                        \
>          save    %sp, -SAVE_SZ, %sp;                     \
>          mov     %i0, %o0;                               \
>          mov     r_OFF, %o1;                             \
>          SIGN_EXTEND(%o1);                               \
>          call    bpf_internal_load_pointer_neg_helper;   \
>           mov    (LEN), %o2;                             \
>          mov     %o0, r_TMP;                             \
>          cmp     %o0, 0;                                 \
>          BE_PTR(bpf_error);                              \
>           restore;

Argh, good catch. Thanks Daniel.

I'll drop the removal of bpf_internal_load_pointer_neg_helper from the patc=
h.

