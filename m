Return-Path: <bpf+bounces-38221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC3961A7C
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 01:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1735B22A7E
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 23:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9F71D45F2;
	Tue, 27 Aug 2024 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JcmGxJsE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686061D4603
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800873; cv=none; b=WudgaaxZuOa2ABdEQKVIHVvLwkjsPpxds00xlG+7TABQdHsTh5Cs5B9NnS63ouj+XqB9D5J1rlHTdN8lNZrM6nAIaswaKsFtQIuzI+MI4LuZfMUi6TFFQLYq/F/KdV9TRnVOlZXeUzz5va8jmfoF7JH43S7vlL6qJlqYcI7B+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800873; c=relaxed/simple;
	bh=FuDNkY+uSpuYPew/32LGWl2xNMxMVFyiWNz4YKSjOlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+SXa71hLhsMU3ml9CZOPvBbZXU6a2VC7JoclUoXpC8BEyjvPLYcxEr1DMkdGFmHm0QMkBOsxKFw5GcUrskwk2+yQuadsojL8Q640Upph0GxshmhJIKQnglXo1TUOzqwiAAXHnD3lY091YQnqFrKIvr3UxK67a2aU6ITJCo6x+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JcmGxJsE; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-690e9001e01so57353957b3.3
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724800869; x=1725405669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyfSsM1kWmLy0fivMTkjdvz46hfeP5aLbodjn1Oq3DY=;
        b=JcmGxJsEKVm6iLeqDBRr9Gs8M+EfELFgEk+Pi+x1EZAkZp4yFsuAFdz0/bY5Ga5VVf
         YevmuiTjx/KvIp07ZIRyxydQgTQX88arxZCQSCmPSYax+UrLWaIxWqZnKc2knxslyNSj
         nMO+gHDMZaw40lMAF27/0Q9kxm9YRbwtOnBTkOZ8SDb7/AAPopyGY2d6mmK8iyUj2Xix
         yoO1PEAowzbg2pEYEstpNFA+9Rajh6Z83kCnoDe9TjqFrI+ogrcUGX7OLgA4gr1+b2uS
         BPvykPbNTDLY3Afy+4pCkCWHkz+D8ih+6cQ0+YTnQYxrVZXl46vHCUjJFQDTtn1nuwoA
         jYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800869; x=1725405669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyfSsM1kWmLy0fivMTkjdvz46hfeP5aLbodjn1Oq3DY=;
        b=iaIOnzjOMn4zwYW9eCxdVeWl8Y+UIHs+dcQtpQPrDaKfEWXTGdhrXZghvfPZp2ai2n
         WFdaPI2YXtiO7XFIceunrYLS2urW7ih1K8Hs+pkZ+rtM7e6kiFMnADLChw+dFydPcPuU
         Df/f05ThVdewfKGz6vCMrLHHfhoUxdN/FuVWE/E/wyurZudXK/+m0SsY72DMPdF7ReK8
         qaqlH8gjplXp4U594oBMqP+YIjgcbCGLsUeUaVC2OlK0mHjA3iYfV4jGLG8i8y3EBt+A
         ycM+UXm4FZgcpE3EsvdcA8j85yZ0w6f3J7EWXhV5isx5Zp6vwdfNQROnbKP3na4E2uiU
         5fkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX24GaJzalPhN76vfMaBUzz9A48HHFIp4v0m+bPIHkVn+xEfPfQmg7vjTm3suiV0ABR7Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuU0si4Z9lwyasZO8XrQgKN8PE/ySAIWQZ3K0jFb57EqJnhjw
	z3esoFV7Lfar1Mwppmi37uitpwfbl4c0PmWfoNITjhzu42U30LKwTFteRcGmgMEP1BqSMdUwnex
	7eptACn+wBn4dw2iinYLF/agEXd3MShWzoANE
X-Google-Smtp-Source: AGHT+IGtjzAhyrZwchJ5S91zBSvF0K/mC+GuXMXbe0LAFX6ZoLlxNnafUGdCPkBDqzGdma6ROv4c2MUeRTI4Zy5itVM=
X-Received: by 2002:a05:690c:ec8:b0:631:78a1:baf with SMTP id
 00721157ae682-6c624fb6b9emr171684047b3.6.1724800869371; Tue, 27 Aug 2024
 16:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813230300.915127-1-andrii@kernel.org> <20240813230300.915127-8-andrii@kernel.org>
 <CAEf4BzaiAWzAU8w11w3C+ws7rdSONZ5S3_7OOXy2_AW1Rwf3zQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaiAWzAU8w11w3C+ws7rdSONZ5S3_7OOXy2_AW1Rwf3zQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Aug 2024 19:20:58 -0400
Message-ID: <CAHC9VhSetig0H1B+zAm_Rk8g-spn+WW8OL+g238Zn5pKEZZiww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] security,bpf: constify struct path in
 bpf_token_create() LSM hook
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, viro@kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, 
	Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:02=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Aug 13, 2024 at 4:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > There is no reason why struct path pointer shouldn't be const-qualified
> > when being passed into bpf_token_create() LSM hook. Add that const.
> >
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/lsm_hook_defs.h | 2 +-
> >  include/linux/security.h      | 4 ++--
> >  security/security.c           | 2 +-
> >  security/selinux/hooks.c      | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >
>
> Paul,
>
> I just realized that I originally forgot to cc you and
> linux-security-modules@ on this entire patch set and I apologize for
> that. You can find the entire series at [0], if you'd like to see a
> bit wider context.
>
> But if you can, please check this patch specifically and give your
> ack, if it's fine with you.

Hi Andrii,

Thanks for sending an email about this, many maintainers don't
remember to CC the LSM list when making changes like this and I really
appreciate it when people do, so thank you for that (even if it is a
teeny bit late <g>).  To be honest, I saw this patch back on the 14th
as I've got some tools which watch for LSM/security related commits
hitting linux-next or Linus' tree that don't originate from one of the
LSM trees and I thought it looked okay, my ACK is below.

> Ideally we land this patch together with the rest of Al's and mine
> refactorings, as it allows us to avoid that ugly path_get/path_put
> workaround that was added by Al initially (see [1]). LSM-specific
> changes are pretty trivial and hopefully are not controversial.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM/SELinux)

--=20
paul-moore.com

