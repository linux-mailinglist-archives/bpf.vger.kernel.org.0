Return-Path: <bpf+bounces-14217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09E7E12DE
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 10:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4582813B4
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6928F75;
	Sun,  5 Nov 2023 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlRI7HfJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FA8813
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 09:51:34 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3853FCC
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 01:51:32 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso4985365e87.2
        for <bpf@vger.kernel.org>; Sun, 05 Nov 2023 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699177890; x=1699782690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjcPMO12JeMo6oFMzCF57vbfHf1P824sz09Cbt1FOto=;
        b=KlRI7HfJryRfnIFYt7m6UNQQkRLZ6S7VowVyBuenwo/dmBtZZ+c81IPVb25JdSqYB3
         srJFrOKXKDvs+FUBJYlGAwd87LKwvTdzEq6crSWTGjxSEKpLNWklE3MsIfCgw5vQ/x/W
         nsN/LPs7WhLkMSQt3kIuvBdPnNGGI0LYQzveI6yDmU9J69iMDG42aQKYAI7/Ge21d4fF
         x88ggnxPietFUUDsFbt7RqIyNTsy6yBNtk3Xelyr8c+ilpn8m/SXJmsfahj+6RYsIw8P
         54+MNXRw2NRFmviATzIgH++WuFAUzdLGVwxIwt7PFdl1cA9cCAATpGgfdkT5dVjfiBll
         Q98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699177890; x=1699782690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjcPMO12JeMo6oFMzCF57vbfHf1P824sz09Cbt1FOto=;
        b=CSNGk+ba8518TuyG/pt1nzxa2pfR1b9uMvZOLgkiF4ZxQsrjQ7pmun9EIdw519f1XP
         TpwdvkGaGZiWDPIZ+8CQCXJTfFdxXfcmM2qifPvK7cAQLxaSeEnENYJfQEAUaPWc2O+R
         9atYUtNYNX0KzCgX8p1YBlO+xFmtqtgAUpaAhY7/wyczwfCQlhDckhVFra2w+YgBwN1q
         1xRCcQ1uPWdklVPI116ZVXmHCg9XSLhQfZ/IheAVRuOBkngBFOaefCPfVPc6yBFYWsLa
         NGzs/X67Wx7ariW0TQsJes1CL3zoZx56nPNJ0Nr9pMAssqiGmzOubnw08hM4LxjVzM+K
         fXCA==
X-Gm-Message-State: AOJu0YzJQYTgJPevZNP2ZisrdAGrFWCXfn2fZoe8eYTdUx8W0JFZolo7
	1kuBrHpjCGOLsVoT8rBff8qm/g2EhCJxIIzY4O0=
X-Google-Smtp-Source: AGHT+IGpl1CwABFAzqyNjqyZnM6BzUHoQVwaK8IkqP5Hg0cnl5XNneYWJdUw8iTRil1i+U8Iu1SD7aGZIeI8tzqqRW4=
X-Received: by 2002:ac2:5442:0:b0:500:af69:5556 with SMTP id
 d2-20020ac25442000000b00500af695556mr18170733lfn.29.1699177890207; Sun, 05
 Nov 2023 01:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr>
In-Reply-To: <20231103212024.327833-1-hawkinsw@obs.cr>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Nov 2023 01:51:19 -0800
Message-ID: <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrote=
:
> +
> +The ABI is specified in two parts: a generic part and a processor-specif=
ic part.
> +A pairing of generic ABI with the processor-specific ABI for a certain
> +instantiation of a BPF machine represents a complete binary interface fo=
r BPF
> +programs executing on that machine.
> +
> +This document is the generic ABI and specifies the parameters and behavi=
or
> +common to all instantiations of BPF machines. In addition, it defines th=
e
> +details that must be specified by each processor-specific ABI.
> +
> +These psABIs are the second part of the ABI. Each instantiation of a BPF
> +machine must describe the mechanism through which binary interface
> +compatibility is maintained with respect to the issues highlighted by th=
is
> +document. However, the details that must be defined by a psABI are a min=
imum --
> +a psABI may specify additional requirements for binary interface compati=
bility
> +on a platform.

I don't understand what you are trying to say in the above.
In my mind there is only one BPF psABI and it doesn't have
generic and processor parts. There is only one "processor".
BPF is such a processor.

