Return-Path: <bpf+bounces-59529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0D4ACCC8F
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 19:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436797A6473
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7721EF0BE;
	Tue,  3 Jun 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjkV/1HZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09951E8353
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973332; cv=none; b=Vz3V2wI1bwqYgeImFZCLCiyIorjuoTil8h61vjQ7GIil9/c8fmqmyT01waA1yFoFLw2FVzX8I4F39/llqmHSkU+FHHTPXstPrlvLASgXn6H2Ujy8FIKFl9v1aF6EbasvlP9J0sgmvWsVeck5wy+ap5mU5EKYLFcbfz9FCnTNoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973332; c=relaxed/simple;
	bh=c45GtF2NgyQzejp5bMuW+j3uJNUfGruUk0n0QKANtRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avyof9kFAyq5Brb39m6ojJ+JqWSkHoG8F+47KaCBI/hs3PdJY+cm+fOCaB9Q/f4DCsnh+TbJ3gfbc5nfknhHCjErctKc4oJzas+P1bfnojmVLIxyhol4N9CBQ2sG5EBJQNrgZEQu4a1izd/CBr57dJHTDCuuOLRCnaPxUI8EPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjkV/1HZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso7005e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748973327; x=1749578127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojV48z9aXEdGn2OT2DKHUp0OlbWYdZap6cRg6lS1OBc=;
        b=BjkV/1HZAo2oT1JGkXxZBce8uxOv95DeNkjDV0I7zMUK0qPs52mUeS86fEvDkSkvHU
         pS1+VbnG6TPtIy3nOBfjYmch46u39kv8O4/9S015gYq72h4hXTyTG1uokcW3BHovLvxT
         Pg817zZcGs3HGBowvlgWBFj/cUVJXHx0QjSu1t7H69vVrcm+p+3IkC7TfXH7olyxVhLF
         r1NN0bhoEaLncaKB52jCeI4Y1uZ3tIljddrtDpFF87ZEDCSiXpGqKCjvlje4P2pTbKQZ
         UX8zvLufsMvFsOsXtaogmruKlC+f5KRmUMkQLRaGTsRaFHR4NhLN24Gtn9bJvTIY+3Hl
         BzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748973327; x=1749578127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojV48z9aXEdGn2OT2DKHUp0OlbWYdZap6cRg6lS1OBc=;
        b=sfWiyhLEZ2HVpVqK7HJScmtef1paLWcE5Mosz1I+kkbtDoSg/+G+CV26VwG+X3PPpH
         E4Gcj22+Sp+eHfG90M38M6GA5sEIT34NRAsq/WXxODEWxyllkzLGzVTy+ZZrlF0EfnsY
         36/TGwLCpS7z5tJbwqZsOElOBeGmocPKKoWLTSaK8m66XsKuNfJMC4ScDHvaoWsUe2MH
         +pyKBXf9qDmbbi2H90QiL0lEVg8wH2dHzh5gP8Tqc3t/RKv+7UNJRthHZMeoFmAG3KXA
         FgnXM9E90ORXZXE+jVdd/tcAMwpgEQ639dzqj/UTI0a6RYvsd/QrP0UUQPixnXEGUjQG
         LpEA==
X-Forwarded-Encrypted: i=1; AJvYcCU95BUy+N95FYXlEM6qNDLGOytP1XRgF39hAEun7/C13REB8UzVeWqY99TM5tO40R7KoNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuvMpFlophmjzeqqICh4Rtzg/2EJoP8NLaAQ4rp0h8vXvbjvK1
	nlvngf1C9xRdhpsjUBAUldIgPQw4FpujHCQxli5i3hUvCnsIRk9JQm73L0fy6GPC/X2U36vazr0
	+3V/GUNQPe4Jsgp/G+L1Q0hwLCdTnasMI4AMpAd90
X-Gm-Gg: ASbGncuJ4WfCAI+Mx3kkTRjayAeXc6/9ZHWeQH7ISAXAzlezynR0Mixf6dY78ReYUIB
	jYKneqgvMwHUFA4Mv4cEjH9ndbzC/HZ2GnW0Snlpb+amHGj9BbglFXPnS9DXqwCzxqmNnpdTKDL
	QjPeTBeIm1wsSuACCyQCRxLCeRGeJDjUn6bRVeunf7yU8MPM0e8loYdR5zTSVtR5+6Zc+7xeLsS
	CyOQg==
X-Google-Smtp-Source: AGHT+IFn+MXcQMSx5ZelVSBHPMB42FF4a5qIDNqQvvUWSmhllHrAaiDMiLd4+ulqAvDPp91tPekjTDAKq0N4QZWV80M=
X-Received: by 2002:a05:600c:4510:b0:450:ceac:62cf with SMTP id
 5b1f17b1804b1-451e5fe840fmr2009315e9.5.1748973326911; Tue, 03 Jun 2025
 10:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512091108.2015615-1-skb99@linux.ibm.com> <CABdmKX1nhR3BXKyuLaAoo50KNyBwaexmH+af_s8WxULJUZ9+pA@mail.gmail.com>
 <CAPhsuW7pyQuLgq6S7+KQ3K-MdavmCzBb-tNhg9J_56X_yYug3g@mail.gmail.com>
In-Reply-To: <CAPhsuW7pyQuLgq6S7+KQ3K-MdavmCzBb-tNhg9J_56X_yYug3g@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 3 Jun 2025 10:55:14 -0700
X-Gm-Features: AX0GCFv_Lt9ScU6hcdIgKqcgflEyVE0GtXfNhaXJacaRBEaJF17vb8aAJZOjoU0
Message-ID: <CABdmKX0thb23TPqyuFvDeTXh56e6r6bT-QGabQu_FL2S=ScOPw@mail.gmail.com>
Subject: Re: [RESEND PATCH] selftests/bpf: Fix bpf selftest build error
To: Song Liu <song@kernel.org>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, gregkh@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, hbathini@linux.ibm.com, maddy@linux.ibm.com, 
	venkat88@linux.ibm.com, sfr@canb.auug.org.au, alexei.starovoitov@gmail.com, 
	daniel@iogearbox.net, mykolal@fb.com, yoong.siang.song@intel.com, 
	martin.lau@linux.dev, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 10:50=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Tue, Jun 3, 2025 at 10:33=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Mon, May 12, 2025 at 2:12=E2=80=AFAM Saket Kumar Bhaskar <skb99@linu=
x.ibm.com> wrote:
> > >
> > > On linux-next, build for bpf selftest displays an error due to
> > > mismatch in the expected function signature of bpf_testmod_test_read
> > > and bpf_testmod_test_write.
> > >
> > > Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_a=
ttribute::read/write()")
> > > changed the required type for struct bin_attribute to const struct bi=
n_attribute.
> > >
> > > To resolve the error, update corresponding signature for the callback=
.
> > >
> > > Fixes: 97d06802d10a ("sysfs: constify bin_attribute argument of bin_a=
ttribute::read/write()")
> > > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > > Closes: https://lore.kernel.org/all/e915da49-2b9a-4c4c-a34f-877f37812=
9f6@linux.ibm.com/
> > > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > ---
> > >
> > > [RESEND]:
> > >  - Added Fixes and Tested-by tag.
> > >  - Added Greg as receipent for driver-core tree.
> > >
> > > Original patch: https://lore.kernel.org/all/20250509122348.649064-1-s=
kb99@linux.ibm.com/
> > >
> > >  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/t=
ools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > index 2e54b95ad898..194c442580ee 100644
> > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > @@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
> > >
> > >  noinline ssize_t
> > >  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> > > -                     struct bin_attribute *bin_attr,
> > > +                     const struct bin_attribute *bin_attr,
> > >                       char *buf, loff_t off, size_t len)
> > >  {
> > >         struct bpf_testmod_test_read_ctx ctx =3D {
> > > @@ -465,7 +465,7 @@ ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRN=
O);
> > >
> > >  noinline ssize_t
> > >  bpf_testmod_test_write(struct file *file, struct kobject *kobj,
> > > -                     struct bin_attribute *bin_attr,
> > > +                     const struct bin_attribute *bin_attr,
> > >                       char *buf, loff_t off, size_t len)
> > >  {
> > >         struct bpf_testmod_test_write_ctx ctx =3D {
> > > --
> > > 2.43.5
> > >
> > >
> >
> > The build is broken in Linus's tree right now. We also now need:
> >
> > @@ -567,7 +567,7 @@ static void testmod_unregister_uprobe(void)
> >
> >  static ssize_t
> >  bpf_testmod_uprobe_write(struct file *file, struct kobject *kobj,
> > -                        struct bin_attribute *bin_attr,
> > +                        const struct bin_attribute *bin_attr,
> >                          char *buf, loff_t off, size_t len)
> >  {
> >
> > Should I send a separate patch, or can we update this and get it to Lin=
us?
>
> A fix is already in the bpf tree, with this fix as well:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3D=
4b65d5ae971430287855a89635a184c489bd02a5
>
> Thanks,
> Song

Thanks, I was looking for it in driver-core.

