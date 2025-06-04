Return-Path: <bpf+bounces-59676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA96ACE50F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 21:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA6E188F7F7
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38422FE0E;
	Wed,  4 Jun 2025 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTpNkRry"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653F22D790
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065882; cv=none; b=G28dSB8RBdC+KOUSVdVaHQ5kuP08UDfW2pawFupwvdsBKXQ4oI9emqOcCR22lYPwxMLLTQPPv6RG1UAz4ye0D9BxeRnGtcmgoBVDcDPyz5Ne7oDW8YNHtcyd/w1s+EgDX0r9jzYmICA/ynF817ucJUlrTQi4Od/84xvRhrj70Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065882; c=relaxed/simple;
	bh=LN1YqPMrWVV8WlmNg/uFiE9VQxHQOaXMeleH2uNMwvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8ralQrRATs8jfRd58aQGInT65eoqqghYTASo22BbYjEHX0pBYwxnjsi3kXH0gT86Cn3euUwJyzI3lC1RHiQUDXe8Z1hyStDD3ELhRWpqFAf62U8K6DfaBYpFzxKWnbbdrQKjXB9pkTjQwNV5IC2pTSjvK8RW/fSvKP4SgRh2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTpNkRry; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so1315065e9.0
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749065879; x=1749670679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN1YqPMrWVV8WlmNg/uFiE9VQxHQOaXMeleH2uNMwvI=;
        b=aTpNkRryGiPQU9nF/MWVS9Mf9kARNxfrQ7WqcOBcX13ZpILymQIRDN6e/JUqWQXmYZ
         ER2vNkI8vOPm6f/fo2b2zK98yufBBx0ZXPKEQi6lWfk++sJOeAP8tQS4DxXdUYcawxat
         /zygO2kDjeBR3ou2fti4/ohlSBrJI0LLV627kxaM9VbtCulmdnmEUMr3gysZBbaEKdVB
         DYCT5D2lTuODP/eZh9WO3vSeW7UQRyxDrmHf8S+aeoJQBJYJsSqBI2r2uOKCeji/8AKm
         TGT+LypP72xprQ7F8F/Y6OJIjZANIYxqOxKTGHrSDnWvLBD0c1fMXgV3TAPSbWCt+9v/
         eYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065879; x=1749670679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LN1YqPMrWVV8WlmNg/uFiE9VQxHQOaXMeleH2uNMwvI=;
        b=UlPXQVMRPWg88gnRFU+1b/Z+tXIfefg8U3Vea/UBSgJycbjyOibEAdvFdszR6e8+Gz
         cD4HgSrSIweyRx3QcOS505wuRbUAOuCe2Rmj5YEgwi3zk2/xSH1Jo9AHLARP6mly9C+f
         wCoiqvWcfxXYhPwwp5uFNAnAcYZBUYvwWqmisDMrgLhTvqJFqrLaIyzoDM5vEKRhCWZ9
         GoTBaknMrH5ibrhO2qDaGNROPoy0YZhWuY4nADVvFVXNvClzjbeeTYgM1AgikCR2gRB8
         kEDlRpD7vq3EjV4r4/nv/PGhuU0KbPodpw7sx/LXPDWpjx+19+hMM6A02UgsYY3cc2vJ
         DQuw==
X-Forwarded-Encrypted: i=1; AJvYcCUxTDlTnAMUaxYfAcRjOXy1IhnQWuoLFO8J0GVq8hvx4/2D/20ffYQDwT4eCIvdtv5KQZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpyD66Zn/EqcO0upBUWsfmy3G3a1vus7LHZhyjRQqne3SDpFwB
	QhpBioA0Mgy72U9RkQGv2OVW9sd04urElfLPzp06FRYGZymRH1DYTW/311EKavFncesTaaMaDdc
	hI/LNF24IrVnTqmkAwIy6dUvqNbUEkzs=
X-Gm-Gg: ASbGncuL/+s5taAX4fviVsACS6Lx1Yt7rX22mrkegNXnUxKK1z12JctN3XYTMW3Luue
	M4CZ/F715rpCFuZnB/RgUbs61uz5+Hbx+xzDwx+zutYRlSHAeJ+IfmovzHTnc5Wc3GR2bzWPXSE
	SbGsVRPHIDi0DwfUvP3ba9rh/xXvVmnD5IIOk9O1h/oNbz0F/z
X-Google-Smtp-Source: AGHT+IHvdmgTjViwsAZohB4BIXT1AK52FYN8txJc6qmCqhsMJca+IPpNb2QO0VdElYB6SPRjGIep5G7ejoInCNOTGWs=
X-Received: by 2002:a05:600c:1e8b:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-451f0b45248mr36440485e9.32.1749065878414; Wed, 04 Jun 2025
 12:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6947880c-a749-438f-bfcb-91afe7238d7e@crowdstrike.com>
 <aD9vDX0boYLzvibc@krava> <7831ec6d-8d5c-4fc1-9bd9-1b0dfc93eb16@crowdstrike.com>
In-Reply-To: <7831ec6d-8d5c-4fc1-9bd9-1b0dfc93eb16@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Jun 2025 12:37:45 -0700
X-Gm-Features: AX0GCFugJhj9pQMsr6pe936qAZjoL8POFYH1eTmcXHmQ-S6ndzZLgH4U0gSd4LU
Message-ID: <CAADnVQKONAkX8G2qXYS8gBVKq52gn4Pb39x_3fRi0EetVPT3jw@mail.gmail.com>
Subject: Re: [External] Re: Bad vmalloc address during BPF hooks unload
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, joe.kimpel@crowdstrike.com, 
	Mark Fontana <mark.fontana@crowdstrike.com>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 7:49=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On 6/3/25 17:54, Jiri Olsa wrote:
> > On Tue, Jun 03, 2025 at 04:13:18PM -0400, Andrey Grodzovsky wrote:
> >> Hi, we observe bellow random warning occasionally during BPF hooks unl=
oad,
> >> we only see it on rhel8 kernels ranging from 8.6-8.10 so it might be
> >> something RHEL specific and not upstream issues, i still was hoping to=
 get
> >> some advise or clues from BPF experts here.
> > hi,
> > unless you reproduce on upstream or some stable kernel I'm afraid there=
's not
> > much that can be done in here
> >
> > jirka
>
>
> Thanks Jiri, yes, i understand the limitations since this might be a
> result of some
> RHEL kernel tree specific bad patches cherry-piking/merge from upstream
> into their own trees. I was
> just hopping that this rings any bells to anyone in the E-BPF community
> as it turns
> to be really hard to repro and hence also to bisect.

I don't remember seeing splat like this.

Also mm/vmalloc.c:330 tells us nothing.
It's not clear what vmalloc_to_page() is complaining about.
I'm guessing that it's not a vmalloc address ?
Which would mean that im->ip_after_call points somewhere wrong.
And why would that be sporadic is anybody's guess.

