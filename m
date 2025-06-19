Return-Path: <bpf+bounces-61026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C7ADFBD6
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 05:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF86C7A2F24
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 03:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FAC239E77;
	Thu, 19 Jun 2025 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EsbS84FS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBE1CBEB9
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750303425; cv=none; b=UiSNftWYTOBD6ojSUqHDA7A9KFGgqEqkn/McO+y/wEMo9rsiqbnYeX7RldB71DPNMDhSFKaAkMgRjpUaYGjFTsqM/YU9a+KRPCN+3K6ZaxOxElfkh7/4JlE/HNz2XKIuDiMEsQzFuPRAPxbWb4jtncmaGl9mkwjC2VpJ5vaM6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750303425; c=relaxed/simple;
	bh=nbuySolPRrKrb/6LuT5vebnUQjPFVCtq1MS/A8Kd8hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n119TFx9VMAVuct45bzrRTALL4SKUZpcwjFZEh59HfEBB/SYcWFg6NWJJkRZSdrE2r2S3l9xDfiK2C0vx+Sx+nTuuJofX92U5Hd/mZLYo+rmCyFxpi+kQI7skO84LWGQD2HE6PxYOxaGMwDOeeHQzbsBfPs2Qa2paIJo1TXqo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EsbS84FS; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-710f39f5cb9so4014257b3.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 20:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750303422; x=1750908222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iJFw3hcoXsGe4DbyON26AXsapbrXOUsJDzr8Kus6pk=;
        b=EsbS84FSKxXZnHZQXjCF+6Upv9EOpcGFcTUVOLCtnKH5Wmutvrxzybfqf1BNSbyKRm
         5s88hw90IYwGLcY01H/gkeGrLadMET9j9VwTMUVRM0F4eVYvD/h70qg+PuW4QXugdAvQ
         ABTg6Bg2fAVdWUVMQDbOsQ9lAyIy5DeJ7+fsrIahKP3cSxAbbO82X1BdcUVUwBk8M1cS
         3g7MAb52YZEhjLEhRNQcH4poe29H4oBnIoelr+iWJJZv6li/BPxAwNKnheUo69bAqGIU
         IFioyFhn8wDKVL5dMd5jAZ6xRzB28wMB9uY0MfjivMAo6qTsn4xYtYf9/OdCevxqCO5n
         Fcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750303422; x=1750908222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iJFw3hcoXsGe4DbyON26AXsapbrXOUsJDzr8Kus6pk=;
        b=K+ZF4B6NDy5VNElU5D1hKD4ZwkvwbY6OtGB693ZtD/lQDtBjxA7zV/vROiyX3P7aOx
         olVNwaSJn5zV9zwwqarNso7KFTfjsUz1mSDaAC1J9g99MzvSKZbq6zCgx4zBIg5O8ve5
         JryzskateXeRSz14JjlglXYYYZfDiHRSTenXVTYdICTosKEPDDKcChU1dzG8X06nl6nu
         HINjAcsTB5rZHxD/2tJIE2hcsRZ5M/pUvZwCjOhHfQPAJ2LHJyI3mQPR9doVrYehYQL/
         wonygDypZB95LSCSpnuSDin7iqxNjCRGk7FOywy/YldgUjjH2wYOS52PW+tANEqr7+vn
         Ct3w==
X-Forwarded-Encrypted: i=1; AJvYcCULd1QljBlbn4ouZyIJDD7BY00p7sw7V11JGXcc9McjUvhrznWBVhbrMBxIFuE6ibUI6vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofLayX2vWnbTeiyZoNZhNnbmJq9wWPYr/m5JywiYUusm6jNTV
	ZSJ0ZO3sTIGTj/IZsSacgMa4jtwxoZV1F7WnJF7T9U9zhFV5WSlewvCQSubXnIaXADhW0Iu2oF0
	VZXVos97g8EtL2fxYu3FRFk17iLZr+8IyQshBPKJS
X-Gm-Gg: ASbGncsdEw24weZWRC7n6JYCAjymkNnBiLtmAytj91mB1I9VX+UdlylBhU7E5k7CpIz
	k+0sz0ceTvk88H1IuFCm7lA0l+n7r3fycN6QFFUfIoeO6bnmwq8qaWDD4Tals5HeHHnvJQSLXZs
	I9S0NMkDKCFUV68fxqR5drUBHhttpTyTp7npX2XjyIOC8=
X-Google-Smtp-Source: AGHT+IGcN/556LS+CfAEL1VYzf1syP51qd2XAQEDn5URamBiRo8ZdesoI3xzet3HROXiTs7jECSzpEiJz/1uPLWWuek=
X-Received: by 2002:a05:690c:6886:b0:6fb:ae6b:a340 with SMTP id
 00721157ae682-71175456e3bmr301614567b3.30.1750303422334; Wed, 18 Jun 2025
 20:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1976e40bd50.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com> <20250614204044.2190213-1-kuni1840@gmail.com>
In-Reply-To: <20250614204044.2190213-1-kuni1840@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Jun 2025 23:23:31 -0400
X-Gm-Features: Ac12FXxwFQ9XrzTaZ4vv6beLeYr34oLYlm8Lv3ct4ijMlJ9Ogo8mnNb8EPo9mo0
Message-ID: <CAHC9VhRWi5QdRgU-Eko4XZ9A2W2o3uhVAagVkhu1eT18qAWdkg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] af_unix: Allow BPF LSM to filter
 SCM_RIGHTS at sendmsg().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	casey@schaufler-ca.com, daniel@iogearbox.net, eddyz87@gmail.com, 
	gnoack@google.com, haoluo@google.com, jmorris@namei.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuniyu@google.com, linux-security-module@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mic@digikod.net, 
	netdev@vger.kernel.org, omosnace@redhat.com, sdf@fomichev.me, 
	selinux@vger.kernel.org, serge@hallyn.com, song@kernel.org, 
	stephen.smalley.work@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 4:40=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Sat, 14 Jun 2025 07:43:46 -0400
> > On June 13, 2025 6:24:15 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrot=
e:
> > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > >
> > > Since commit 77cbe1a6d873 ("af_unix: Introduce SO_PASSRIGHTS."),
> > > we can disable SCM_RIGHTS per socket, but it's not flexible.
> > >
> > > This series allows us to implement more fine-grained filtering for
> > > SCM_RIGHTS with BPF LSM.
> >
> > My ability to review this over the weekend is limited due to device and
> > network access, but I'll take a look next week.
> >
> > That said, it would be good if you could clarify the "filtering" aspect=
 of
> > your comments; it may be obvious when I'm able to look at the full patc=
hset
>
> I meant to mention that just below the quoted part :)
>
> ---8<---
> Changes:
>   v2: Remove SCM_RIGHTS fd scrubbing functionality
> ---8<---

Thanks :)

While looking at your patches tonight, I was wondering if you had ever
considered adding a new LSM hook to __scm_send() that specifically
targets SCM_RIGHTS?  I was thinking of something like this:

diff --git a/net/core/scm.c b/net/core/scm.c
index 0225bd94170f..5fec8abc99f5 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -173,6 +173,9 @@ int __scm_send(struct socket *sock, struct msghdr *msg,=
 stru
ct scm_cookie *p)
               case SCM_RIGHTS:
                       if (!ops || ops->family !=3D PF_UNIX)
                               goto error;
+                       err =3D security_sock_scm_rights(sock);
+                       if (err<0)
+                               goto error;
                       err=3Dscm_fp_copy(cmsg, &p->fp);
                       if (err<0)
                               goto error;

... if I'm correct in my understanding of what you are trying to
accomplish, I believe this should allow you to meet your goals with a
much simpler and targeted approach.  Or am I thinking about this
wrong?

--=20
paul-moore.com

