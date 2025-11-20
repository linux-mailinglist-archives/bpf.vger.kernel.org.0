Return-Path: <bpf+bounces-75122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE7CC71B9F
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1437350B64
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 01:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456B23A98D;
	Thu, 20 Nov 2025 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fgyp6XzE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s4h6KpwI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A051A0BD6
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763603499; cv=none; b=ZXrTZ+fc4XbjhDQCgvMnQPNxadxRSgax6mntnHDIcQw0MeakIS3LzZGYIvriqQsML+oBoOCCR4NmLzMhEpFrMzH5zQh7LJ7Uaz7DuiQRPdJ/LB9J4Gmwc8QkB7bytvEi2bWoUTXj6nX/hflC5V6yy6bd3QFAXyLt76z9RoQiXQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763603499; c=relaxed/simple;
	bh=IzPJoad719/5qJDev1vzr1zoqezBRTRtv4dRctcZ+7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTWfadkrSQgrPIafIQ/n6q0PP0KKPYdsgU/o6iCr9MJUkZVpMrj8BmfYCF5SgUpupChg7bi6k6F4+io1/HdRF6ohp0SfhGRcv2uZnQgn6Uvvh7OUrwuSrMRuQbUpVIAEiGnW4JAVSwvILSZsiJr+X9EjTI9SvNJpQ0khTPLE6k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fgyp6XzE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s4h6KpwI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763603496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FviHimsytcciadszbcSsJW/Z97xTnwLdF5ls/H7GOk=;
	b=Fgyp6XzEjizQxIJomuHbLdTpmEdwlv4BIu9lQ6csORlMxYR4OXQSiv3QjkBBat1qKQAYru
	5qoClA0zCFx47hPNuSa4qs2ZFaYuAAU+EBPayXSIcDL/8IAe3ukOdPmxNnX1FBSG5EvYm5
	Yy55ApfwQWuMbOX1cDWQUM00225V2lg=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-fwtKSE6KNe2impfoM8sBxQ-1; Wed, 19 Nov 2025 20:51:34 -0500
X-MC-Unique: fwtKSE6KNe2impfoM8sBxQ-1
X-Mimecast-MFC-AGG-ID: fwtKSE6KNe2impfoM8sBxQ_1763603494
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-55b305e5aedso320358e0c.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 17:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763603494; x=1764208294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FviHimsytcciadszbcSsJW/Z97xTnwLdF5ls/H7GOk=;
        b=s4h6KpwI6EUJLc7qNIN3jrDTqS8ahAf36dAkWceib6NcJ+493u727Kqwth0WCywfdk
         NBN3+mCZm3ed8Fnnbp+6/i26ajTzd1M/+x7ck1exlomoOhKzzlnLv380JQz8gi9xON4y
         NIIf/0ecCJ6ZLbGg4yrcoqKiMRNSJS37KBxt79Dk837fnuZjUXMn5e7XSrrcrWsAuFFp
         OfdMKMNaXWxw1fPImk/2zuSi49SDpuYtgUcXWquc1Eq+a+knVuCwiEq/jAGRdnU5OFtR
         jHPy5JBkioNE5AZGyMKhhdJ7Eme3WOpfPPipFzwe2u1jy3k2+CtCo1bzisTeIJDs3C7I
         ctuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763603494; x=1764208294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FviHimsytcciadszbcSsJW/Z97xTnwLdF5ls/H7GOk=;
        b=Bwa+wlezIeHiQmOuNy16lIZiRydsnHJRIC35vmD7EOnsovFjixAa8WBvcRrhgdHOMl
         qdKvXIG7zwobynXy+fUk7T5o9+3G04TH5VyWdHFE9HIbXN696MlxwQ0WtpHp/TebL/3c
         YOtjqCbvfOoa5VT4cevioHJ9YBm4jfOjF8jY69W7OYbV9G+rx/Y9XzUNjAgrI59ztuUF
         Z0H24OklWGinqWBuxfxEUDP8DScrynnoeNKqskHApQkl1wPM83T+ZF7R4AUyRmqBCXng
         KR6CMnSsxnfG7LZ2YsDqrnb5BrK5m4s1r+mFGLPIvygPPowcR86Pbq7rT3K1HDEew9Up
         TG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqtdYVVtySqqGvKJzj6/aUNIN7CMBXJHga4I8lcYaUs/Wwfqbm1PMqnnaYmWF4zFP9VMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7Y1QR1z3pZsX/u7h/gc1KacrV3Q6jozT+YCjYLGjoO39nC8A
	97bNjPAl/E5NZ3r15rA4jrRyeUHbUXqcHUmnfrSKxbJtAdNNrYJCnLUnvXcjPq95PN9CbtREmHc
	C1jABQPskj4HHZUZ/qLpvPLs+uqhIO28dOvZEZD1GuaHT60p2F2wFIbC3717fTuX7XuIbF7sv8+
	yv8mEUhiIVABeumuthVxzauchfb/Lo
X-Gm-Gg: ASbGncu1S4F4DajhQhHTAMxvROb1SNNXS/sHyCG8ZzZdfBwoVr8+0cCrB6+twweAt7z
	3q13FIBN0+rLtqBS19iogP2N0FxgZRz0MK1nqyw1o+dIhyspAk+/WkuCekWC+9+TiAX5fTeqa52
	qltRy85pwoCqKQ9JK65FxPCa4ruSKeyIorHswqAVlPo5XZzPnk2HMfwXKO75R2Bg29n58=
X-Received: by 2002:a05:6122:2090:b0:556:92b0:510a with SMTP id 71dfb90a1353d-55b834a98cfmr36142e0c.14.1763603493911;
        Wed, 19 Nov 2025 17:51:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE2k5CaBlCaOUDyFAZL59khcKOSke7MmanpokA3dJd0nOQPh9lnMYPOnSQ4XTsf7JkGbSpx8Urw+Sa3WXusGc=
X-Received: by 2002:a05:6122:2090:b0:556:92b0:510a with SMTP id
 71dfb90a1353d-55b834a98cfmr36134e0c.14.1763603493558; Wed, 19 Nov 2025
 17:51:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104162123.1086035-1-ming.lei@redhat.com> <20251104162123.1086035-4-ming.lei@redhat.com>
 <87346a2ijz.fsf@trenco.lwn.net> <aR5y3pFTgDDNptdx@fedora>
In-Reply-To: <aR5y3pFTgDDNptdx@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 20 Nov 2025 09:51:22 +0800
X-Gm-Features: AWmQ_bmBoqDRBcHD4m4x0NJV-o73KA2BYbG3mwP-S1h8owflFyDJZWCqNqjEZ7A
Message-ID: <CAFj5m9KiPcKKjYTY3Jov_T=tWrknivoPiaao_wW25=ZjJ6XGrQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] io_uring: bpf: extend io_uring with bpf struct_ops
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Caleb Sander Mateos <csander@purestorage.com>, Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 9:46=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Nov 19, 2025 at 07:39:12AM -0700, Jonathan Corbet wrote:
> > Ming Lei <ming.lei@redhat.com> writes:
> >
> > > io_uring can be extended with bpf struct_ops in the following ways:
> >
> > So I have a probably dumb question I ran into as I tried to figure this
> > stuff out.  You define this maximum here...
> >
> > > +#define MAX_BPF_OPS_COUNT  (1 << IORING_BPF_OP_BITS)
> >
> > ...which sizes the bpf_ops array:
> >
> > > +static struct uring_bpf_ops bpf_ops[MAX_BPF_OPS_COUNT];
> >
> > Later, you do registration here:
> >
> > > +static int io_bpf_reg_unreg(struct uring_bpf_ops *ops, bool reg)
> > > +{
> > > +   struct io_ring_ctx *ctx;
> > > +   int ret =3D 0;
> > > +
> > > +   guard(mutex)(&uring_bpf_ctx_lock);
> > > +   list_for_each_entry(ctx, &uring_bpf_ctx_list, bpf_node)
> > > +           mutex_lock(&ctx->uring_lock);
> > > +
> > > +   if (reg) {
> > > +           if (bpf_ops[ops->id].issue_fn)
> > > +                   ret =3D -EBUSY;
> > > +           else
> > > +                   bpf_ops[ops->id] =3D *ops;
> > > +   } else {
> > > +           bpf_ops[ops->id] =3D (struct uring_bpf_ops) {0};
> > > +   }
> > > +
> > > +   synchronize_srcu(&uring_bpf_srcu);
> > > +
> > > +   list_for_each_entry(ctx, &uring_bpf_ctx_list, bpf_node)
> > > +           mutex_unlock(&ctx->uring_lock);
> > > +
> > > +   return ret;
> > > +}
> >
> > Nowhere do I find a test ensuring that ops->id is within range;
> > MAX_BPF_OPS_COUNT never appears in a test.  What am I missing?
>
> bits of `ops->id` is limited by IORING_BPF_OP_BITS and it is stored in to=
p
> 8bits of ->bpf_flags, so ops->id is within the range naturally.

oops, misunderstand your point.

Yes, ios->id needs to be checked in io_bpf_reg_unreg(), sorry for the noise=
.

Thanks,


