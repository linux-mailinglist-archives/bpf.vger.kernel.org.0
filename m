Return-Path: <bpf+bounces-34566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E592EA10
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534D32817EC
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676CE1607B0;
	Thu, 11 Jul 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NPAq3MgB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E615F3E0
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706390; cv=none; b=TG/xy/2jf2LOTQv2GkhZfDIGz8zTASFyzVlLUdNzjeObGzfJ/MFZO0fyk+f65tpzaHzkmfTwvCiiVLeUetg9pApSN9awaveT45XoCfN1auOf6GWuq2DPouBZi8E8YncGpS1+QWOq/iIEVVAqbWMvRS/IUxMMqQ0XG4xsJUDLMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706390; c=relaxed/simple;
	bh=febJ7xDjZS0C45YP1S6zLfvMmURRqXEwqqNrgSRVceo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2S5nmZ3GBuxRDl1qXiVQ1MCUK8N/SDpJ1zgxSocG6ytG0mM/7HfPj+wE+jQ0aBl6kPVIrkQxBzvTpNX+dNEa2mPpokU4F5E24+LL7rZVC0+S7eyS8R8wcRseEBNB8ROCaoAEBqYMsCnZ2J1Or68n7KBHT+HX9eMDnvA7s35f5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NPAq3MgB; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-655fa53c64cso9370117b3.3
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720706387; x=1721311187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQY2b8/DRuEUTaxvuIRlplaS5SN88ksoRA5Ll0aBHr4=;
        b=NPAq3MgB70r6Qm3vgI7+RlPeGEFs2iESYk1gr0/CJMqDSX1jT71b2wlIo252YtIsBI
         MxXaH0B8L+asbsFSGRj0KLKxYh3YY+CAHI1Z8ui1fcPD6N0HewX8vwbjXQ3Heraj067T
         Qd8YDHE3QFURqJgrdRxCw0mnkWNclUL/KJte36aHNadW9V6CBJleoI0ozT4gZm6X6DVP
         31TO40Y+nxlQvStvkJZfGf/NvCn52dM3Jm9wJ6pY5i16D9H7qhWeN/1ugzM2lCXjuEfD
         ZMSQ6NYl1JcMXZFm/HaJM7OIFiRpnpA5KxWEOnrKj6ROc2o6BRcqqyB81DehRyN3NSSy
         9nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720706387; x=1721311187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQY2b8/DRuEUTaxvuIRlplaS5SN88ksoRA5Ll0aBHr4=;
        b=iaDJ6YGRkiGOfQ91NBqBVgTJ/eIRXEWCLDwN6PyE0uHc7/VXnLEymrQF3mC608SEZu
         oYBIe37qKcYmavYi5wdR2Pa/hk3kWvNuqvkFMae5tIV7sGLfdxmCJVz9HYgTXpzuU8wt
         Pb1uST1iTEDuHs0b4U+CLMdgC94fXBVytGZ6Se/2PJ7NIKrz8MIvsJWQDcza3mQSXtZa
         4sa32q/pAgUzMFM3c8sdAU24pBG9ujufcs3nblZgr6wOokXF0jY8Hyw7wU0259h/Drk1
         psOw63sxfYb+t5lowdgy+a9ZjFaValIAtJDqcF7xNTapiGw1svJBHnx7T0E6sVsKNKnd
         wm3w==
X-Forwarded-Encrypted: i=1; AJvYcCX8UhzgaB4AdjQTHcgtxZWvMEX7GLuI9vdkuj01J7HjThEiX3m4g2PfzrOmuxQX3cqoOMy+0BrDIge4irZ0zZrgPcWX
X-Gm-Message-State: AOJu0YztFPfEIj3y8FSEPQJx1ORIq6YKLtiDA8YQsIiXGN1/gVDwZwpP
	+iqD1JrM4bHrDdKQ+9/85IeRTeK577qEj1TfsJIhsD0meIl3Kt3BN89nnUZr60urORPKuUq9kar
	ojE8SDR1WRir8HXRmph0VcCbWq8RTcF7vt1gP
X-Google-Smtp-Source: AGHT+IEMt3QtUz/v7j9W8ojXGoKTHXeUWcTEdJBkUtHA2ovG9+altl5kDPZ4Nrp/gUeDTxqi3MpZrTf/e1iIP3EsFB8=
X-Received: by 2002:a81:8d14:0:b0:615:20db:4a4d with SMTP id
 00721157ae682-658f02f55e2mr88805347b3.35.1720706387552; Thu, 11 Jul 2024
 06:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710000500.208154-4-kpsingh@kernel.org> <b23e0868802853a9ab17e17fdc35c678@paul-moore.com>
 <CACYkzJ6HGdW1Vqs_KPtGLZEyX4NO8ZpreJfhoCoOwsWDdmAueQ@mail.gmail.com>
In-Reply-To: <CACYkzJ6HGdW1Vqs_KPtGLZEyX4NO8ZpreJfhoCoOwsWDdmAueQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jul 2024 09:59:36 -0400
Message-ID: <CAHC9VhSKrgzzpxZ4SemHcuSvHMegVzqQRqv1hs=EG1A47MBnyA@mail.gmail.com>
Subject: Re: [PATCH v14 3/3] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 7:15=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Wed, Jul 10, 2024 at 10:41=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Jul  9, 2024 KP Singh <kpsingh@kernel.org> wrote:

...

> > > A static key guards whether an LSM static call is enabled or not,
> > > without this static key, for LSM hooks that return an int, the presen=
ce
> > > of the hook that returns a default value can create side-effects whic=
h
> > > has resulted in bugs [1].
> >
> > I don't want to rehash our previous discussions on this topic, but I do
> > think we either need to simply delete the paragraph above or update it
> > to indicate that all known side effects involving LSM callback return
> > values have been addressed.  Removal is likely easier if for no other
> > reason than we don't have to go back and forth with edits, but I can
>
> Agreed, we can just delete this paragraph. Thanks!

Okay, I'll do that.  I'll send another note when it is merged into
lsm/dev, but as I said earlier, that is likely a few weeks out.  This
will likely end up in lsm/dev-staging before that for testing, etc.

--=20
paul-moore.com

