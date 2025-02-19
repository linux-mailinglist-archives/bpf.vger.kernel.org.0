Return-Path: <bpf+bounces-52007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371D0A3CDB1
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5BB188AD7E
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C31F1CAA65;
	Wed, 19 Feb 2025 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL0mtecd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390111B87EB
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008050; cv=none; b=tZDUe+53oDzHQU5eA1So34x6FJ7uE8fkegHh4ogSOiIvcFFyy/vomeLEn07/jRMvTWaI2bYATYpeLR5apNfjIPp+jCi06QLEwxs4REzCo4D/2/9wFw++unt20ofe1rJP1ZnMNiYjoR1O0nW+AvJgzBt3oj8Q6u7X0+A1a1HN4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008050; c=relaxed/simple;
	bh=xd6f1qKSB5QBMp8KDvMF9PJ3260kWdGVl2ULSJg3OX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWI/HLiAv4XEebYHqxGM9/KIvlbijZDXFWLMgJarGzeNIi+lHfjZWal7c0ySh/ctSKVMHutXqzZyKilFPi+Xv2isNbXW4WTWgiWbsw+FPO7buG8Eivysia9QgRGSRMpNayQkNCtnNp0L8KD6qSmgd98uBVD8qRwOpXrjmIXrJAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL0mtecd; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d0465a8d34so2643425ab.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 15:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740008048; x=1740612848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mpkptc13Zmsm+5wusis0SYzmeBQfgNQsBZDD70bd9co=;
        b=fL0mtecdpYu5pgRygrQ8UYVmi9cXMd7qNN488bF4/poG6+ijdhpKwlbLZsC4qPwM9x
         Sk5aDSsu/8aA0vu2Me36cqY8kEnOOKGpeWuscKmKmVuSyWCnMCmWVKoUd/qBugbW6cYA
         np4Tw5wBs/rjh4rMq3jAP51/x1TfRC8AreIPxSY3zLS1V+aEpPYlHdjTVebLNcSyFrAZ
         dKyh6HZtBgIXEbPPuS1clEFTQzPCwb72xp2xrgqJctACIIg5Kz/UTBrhU47Eg1/3dRs0
         kiAUHdNzTpZbUi8QEAYZ5b9+ZWLiOqBqKsoSe971FboI8rXlskEKw1GIVRvb7P4aS4WH
         IF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740008048; x=1740612848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mpkptc13Zmsm+5wusis0SYzmeBQfgNQsBZDD70bd9co=;
        b=mzk8nX/i9n28soURTpTXZl/PXhMG/NMdAz5tJ3E6HXllaFsFWx7ZnCms3aQSa9p+Kr
         HhcKvLwo1NEBzwdUz+ssrP6FHJPD4Odf8M+ci80vpAEBUjyBw02HpM9PErI8NK51dFQO
         j2+wvzolJmRxTO+oXua1TYh5WHtvfS/42ZYFoRQ6u9+CKPaPk3v0Cm/wjkBYyrYfA1rv
         En13badr2YdRxOH51bh9oNpdQw3xjzEvCwzPok9Brj7KJfolc0WCIKan/zdDrxGljixE
         7cCpT5wnbF1e/U8iKheWSmyq24EhETa1fF4BZXlnuZs5HQOlqcJ9ukG9Iuev7XtGgXW4
         W/pw==
X-Forwarded-Encrypted: i=1; AJvYcCVg8QwGLCpMd13n//aAbWUb65cFpO1RX9JhRRL1rq/MtLT/KHZ25KWehc7lgmlvWyYfELc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTnc9cjhm02Jm8mpBigMlJXzjOg+0+jTVg7S4jYfdgHSJKwHZ3
	xCg2D2nchVCEDDF9kScCplbey2BjYpSYf8rNWjiLFUVZsbnlW+V1zZMhEPLbUOZFrV8oJu8HsnA
	h34UrqpC4YdZo96lnF5DvxlzqBUU=
X-Gm-Gg: ASbGncujoYqS3lmEWqNE4YV7vvpJFSCiLkt33I2Qq3YXh9Nu/5TuqZoBGdr2sEsn5Bn
	fa8kiJyNzc7B18LYpsvBbJsrCU/sSYUmRujNedOjVGWd+aErUdxQMAyYP5D6IzxxRG9D/wXMx
X-Google-Smtp-Source: AGHT+IHqMBuWyrVcJMElsg62GHDMu9Yhl7c5Qr3ICHXnsDJ6Dz00vCLmDbL/He/grwOyD68/Rjg3AniUHlciqqwpoRU=
X-Received: by 2002:a05:6e02:20ee:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3d2c2530138mr2866505ab.11.1740008048117; Wed, 19 Feb 2025
 15:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219081333.56378-1-kerneljasonxing@gmail.com>
 <38bb5556f4c90c7d4fbe9933ba3984136f5f3d5cf8d95e4f4bc6cbfb02e1e019@mail.kernel.org>
 <CAL+tcoDZAwZojcMQZ_bc71bxDpdfSE=q5_6eXirZLEWXFnY33w@mail.gmail.com>
 <bfc930d1-4a96-47c1-a250-e53dfe7a153f@meta.com> <44e56c1a-3445-4cae-abdb-76ada1084193@linux.dev>
In-Reply-To: <44e56c1a-3445-4cae-abdb-76ada1084193@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 07:33:31 +0800
X-Gm-Features: AWEUYZncChLYkdxI-DfS8s6fKln0sT7Q6B0_illPQT838zYmwDmn-2fWJJMI1A8
Message-ID: <CAL+tcoDMXDwmLQ-h_FKhjgn1ecOzbjZTFMJSkwCf0QoCkO0hhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] bpf: support setting max RTO for bpf_setsockopt
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Xu <dlxu@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	kernel-ci <kernel-ci@meta.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	"bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 5:12=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/19/25 8:33 AM, Daniel Xu wrote:
> > Hi Jason,
> >
> > On 2/19/25 12:44 AM, Jason Xing wrote:
> >> On Wed, Feb 19, 2025 at 4:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >>> Dear patch submitter,
> >>>
> >>> CI has tested the following submission:
> >>> Status:     FAILURE
> >>> Name:       [bpf-next,v3,0/2] bpf: support setting max RTO for bpf_se=
tsockopt
> >>> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?seri=
es=3D935463&state=3D*
> >>> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/134082=
35954
> >>>
> >>> Failed jobs:
> >>> build-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs=
/13408235954/job/37452248960
> >>> build-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/1=
3408235954/job/37452248633
> >>> build-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/=
13408235954/job/37452249287
> >>> build-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/r=
uns/13408235954/job/37452250339
> >>> build-x86_64-llvm-17-O2: https://github.com/kernel-patches/bpf/action=
s/runs/13408235954/job/37452250688
> >>> build-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/r=
uns/13408235954/job/37452251018
> >>> build-x86_64-llvm-18-O2: https://github.com/kernel-patches/bpf/action=
s/runs/13408235954/job/37452251311
> >>>
> >>>
> >>> Please note: this email is coming from an unmonitored mailbox. If you=
 have
> >>> questions or feedback, please reach out to the Meta Kernel CI team at
> >>> kernel-ci@meta.com.
> >> I think the only diff I made is that I removed the change in
> >> tools/include/uapi/linux/bpf.h from V2.
> >> diff --git a/tools/include/uapi/linux/tcp.h b/tools/include/uapi/linux=
/tcp.h
> >> index 13ceeb395eb8..7989e3f34a58 100644
> >> --- a/tools/include/uapi/linux/tcp.h
> >> +++ b/tools/include/uapi/linux/tcp.h
> >> @@ -128,6 +128,7 @@ enum {
> >>    #define TCP_CM_INQ             TCP_INQ
> >>
> >>    #define TCP_TX_DELAY           37      /* delay outgoing packets by=
 XX usec */
> >> +#define TCP_RTO_MAX_MS         44      /* max rto time in ms */
> >>
> >> Last time everything was fine. I doubt it has something to do with the
> >> failure :S
>
> kernel should not need tools/include, so no.
>
> >>
> >> But I tested it locally and could not reproduce it. Could it be caused
> >> because of applying to a wrong branch? I'm afraid not, right?
>
> Right, in v2, the patch 1 cannot be applied to bpf-next/master, so the bp=
f CI
> retried with bpf-next/net. It is the current bpf CI setup.
>
> That v2's patch 1 is removed in v3, so the v3 applied cleanly to bpf-next=
/master
> and the bpf CI moved forward to test it.
>
> I tested locally and I have applied v3 to bpf-next/net. Thanks.
>
> May be the bpf CI can retry with bpf-next/net also there is kernel compil=
ation
> error.

Oh, I got it, thanks!

