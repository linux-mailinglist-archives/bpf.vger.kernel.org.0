Return-Path: <bpf+bounces-62984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F7B00DFE
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 23:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4711C853F8
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 21:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3CA28FFDF;
	Thu, 10 Jul 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VSUdY6rQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8469285050
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183635; cv=none; b=qmIbkfoyWDHJ78oreNpULPDQDkyAIEaaM+flMv88y5FUQv2FO+gkSgkgFkMAtZ61XvczWkzNRYYAd4suZSfE0BNU9+goH0s0jSyV0VMII5f9AoppKI+V82iqGX1UjLJRH2BTtpVhpwCSFxM7OZFggCcQ+ucR9dvrDKGBU6qrr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183635; c=relaxed/simple;
	bh=6wG3MiVJh0RcPO7dGyjbbquYVHNZCnHmFZCdF5hrjIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8FrAOJLB0RN27V42Ip2JdU9MC7ip8FYtJDToZuics/XRkupIqeL6bizSQScXwSFFbPdFKN2ExLYp2f7rzeCZd2FPEF9KGi7FIR5XofxdIMN4AOENegOEAlOJw2dSgqj62PwXdnp8/OcTAqJi1cMWbJ/WbPDCCD2zvAT58lansQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VSUdY6rQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70a57a8ffc3so15735727b3.0
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752183633; x=1752788433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wG3MiVJh0RcPO7dGyjbbquYVHNZCnHmFZCdF5hrjIg=;
        b=VSUdY6rQrvB5SnmTJeTDDxuv1MqFK95JFGnvSKjfpNAQrAu9SV3ve1+dbTaNn2+/Im
         xMDQugq4NaD2p1uRKuYNYDjEGj4Sp/Sk3PAujTvvQv8dNjst/5BjrocZMQ0rf7/cXW2P
         P9yGYdNlEI7jv9027boah+y0CwtsmSnn5Be7mEPTA583IY2VCTnsjehv4VruZOMD56i6
         FK5vj/ehnLxd+aSfsPsLdC01WNHW2UVwUhXX74t8EdMug+Y8pN6c/mRgXo1X0z8BcpU9
         OTwuqBYZ32Sm9xwD8LXghM1RbJ3Yvq3Iqt3lQvV4tr8KjCK3tDB3M6Oy/tD68YZp/ikX
         +s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183633; x=1752788433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wG3MiVJh0RcPO7dGyjbbquYVHNZCnHmFZCdF5hrjIg=;
        b=BtqjiMTCw2K3s5b7jG2CYmHh6wjQt0zsBmiPi0CNedrhMnUsZLYp1zV0VyuCF9jC6A
         mRe+LfIwlPdEyiOu0kB39cieQTBibzO9DF/NP+Sxd6mmWcr6BHLQ+znhuO2BAjAxLi87
         +TTGc3J98CKpOT3ZwaQV2W7hY6INBSZ5OXa29paHgGOVOs6W1Tvf1KPCDjaq/y3/Ax5F
         S1L7vHtewOLjzHda7F3Z153pjK11hW8tZRFmEx9sCOeraxi/A1+PPbkJjiKQfk8MrQ/3
         BerXnKAyUWFV5pp1HuCuu43k6NlIj6ZGUEtOJB1BN11xMvcefMEx0WJDrx0jGC0Sv+e7
         7zug==
X-Forwarded-Encrypted: i=1; AJvYcCXkOayNhGLsQ/6iDTi31duIHsnjXpB8qEt8sgGgkNzeWKABQe2HoPPohFy7eHMQtz6Qy6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+I99Rwkpg28vk8mS3roMdw53JpmyyWqag+Fr82z7HNQ3Dlmq
	/iprLQYhytxyB52yWWZT65XY1cDQqPu43rtZJSzL6oO3V9kjI1iCaD4lszHSqC0YYyYv3JZ/Tm1
	fvnKnlDgt/J3CGTLgnt8w9yc+7yJOscPgfnVzi1YP
X-Gm-Gg: ASbGncvJcc9/a5Zg5RF8XU8bC1FAExSahGB0fdWs99KBVP6A2tYTgNna5+ZeXzxeJ0y
	zWSakKw9PoCBuEf/n9vu+qO85ibP2EeF429wtJG5FBuX2g8cLfM8gd4n49mGskMTk4jtrNnPLxj
	oVDb6T85p/Y1SxJnltM4eJkONsCwRBnEKy+eK1Up3WBysu2QsSpqMdQ6Dfgo1EfBrjJue6DLsiR
	wQGIVRGSNK3oD8IIw==
X-Google-Smtp-Source: AGHT+IEUNp7yAcXsQe/JR+irOSVx8v6wD/QnrcWD8zPh1FLoq9LoOpgHSEVTC/K3sabkCRfbQXhsH559rzftY5+dmIM=
X-Received: by 2002:a05:690c:63c6:b0:712:e516:2a30 with SMTP id
 00721157ae682-717d5e134b4mr20477787b3.28.1752183632871; Thu, 10 Jul 2025
 14:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230504.3994335-1-song@kernel.org> <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com> <20250710-roden-hosen-ba7f215706bb@brauner>
In-Reply-To: <20250710-roden-hosen-ba7f215706bb@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Jul 2025 17:40:19 -0400
X-Gm-Features: Ac12FXygeQp3no1_lmAy5tCkImjlkaS0qLNeFNCTV52hKWMKCGltsNt3Gzdmr0Q
Message-ID: <CAHC9VhTinnzXSw1757_yeFdyayXkpTr6jQk8kzETtB5r=WNaxw@mail.gmail.com>
Subject: Re: [RFC] vfs: security: Parse dev_name before calling security_sb_mount
To: Song Liu <songliubraving@meta.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"tomoyo-users_en@lists.sourceforge.net" <tomoyo-users_en@lists.sourceforge.net>, 
	"tomoyo-users_ja@lists.sourceforge.net" <tomoyo-users_ja@lists.sourceforge.net>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"repnop@google.com" <repnop@google.com>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>, "m@maowtm.org" <m@maowtm.org>, 
	"john.johansen@canonical.com" <john.johansen@canonical.com>, "john@apparmor.net" <john@apparmor.net>, 
	"stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>, 
	"omosnace@redhat.com" <omosnace@redhat.com>, "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>, 
	"penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>, 
	"enlightened@chromium.org" <enlightened@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 7:46=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Jul 09, 2025 at 05:06:36PM +0000, Song Liu wrote:

...

> I'll happily review proposals. Fwiw, I'm pretty sure that this is
> something that Mickael is interested in as well.

As a gentle reminder, please be sure to include the LSM list on these
efforts, at the absolute least I want to review the patches, and I'm
sure the other individual LSM subsystem maintainers will surely want
to take a look too.

--=20
paul-moore.com

