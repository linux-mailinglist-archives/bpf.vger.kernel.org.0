Return-Path: <bpf+bounces-31266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6462E8FA55D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 00:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2136A2860D8
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 22:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17D313C698;
	Mon,  3 Jun 2024 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NiqfGCuA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0F13C805
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452411; cv=none; b=QP2Zy9ha3Lld91zvp5LAaQA6hpEwGp93bCU6DEYpMdzHMsMJjieSDitwn744eOvPlbjDFvubwDhKoKBZRLr2bbJ1gCreU48/V1/qiDYsOuEEPcHM+XSVgd6688sJ8S+xOvlgiTvO7FmeCIPsYiieiiLyfMm9rKjQ5ba4BUfe/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452411; c=relaxed/simple;
	bh=VmmtVwxasoTOHFXd7uw7knGwecHF+qPHtfjb8cGfUDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGVFAxOMWDXEORkOWMEtpLK+4mCxmDNNOQOyM91Z5vRN6X/FSjCAVONrdbX2cqHyolkTDxh8ILXkbgMjOQcKaHNCVJnAKTaYJ8m+OyobvINlnG4EbLg2AZ/t378hjeH1o9sQbXq23//b3j5+f8/8/00WiUCWmuM3SdsAHMrb/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NiqfGCuA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62c6317d15cso46840607b3.2
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717452408; x=1718057208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX8PVfQ5qnzftwtpw106lfiQ8TgkbA0h4I3z6i3Eidw=;
        b=NiqfGCuAI1K9brleigY26fMpTB1gm2A2FWJwARfHvWhWo+Pub71Qg6Ye+LiYNERiOu
         CMpl1MNwb3AJlP/bxR/++d5xV4izMwem9575sGOf9vcOrxjQsiDJ1GgAm5e3DwQwJSpH
         u24wNc3dZbt/77pEn6td9HBEmfYnc0WlGZxGY3ZzTvCU+GHJmg6OoHn9WPo4AUEyS6Ko
         Ga4k+1bgP4SyKtKtsOPD5uQBmT0g37rIX099dLfZTOZqr3DXcCqvh3IdPPpKhOKzKu5+
         WaABleaD6zGHx+kVKqxV4imM6NqKUvAty0LW+9+l7xzi5i3CweMCNNEN486Lmqr2b2WS
         twrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717452408; x=1718057208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX8PVfQ5qnzftwtpw106lfiQ8TgkbA0h4I3z6i3Eidw=;
        b=F/YmoBkijfv4DafQ1vBi57XrsXjl+2QCpt44OnJo8fSTzVyKLxdDQJbYLvMTR+X8+C
         pkAGqmL3eFb+WbNuHh8YH6+PRuDdr2W5gExvNaFY1iDfkCi39ZcAvIJFduv55k27CLOf
         s4qpKu3WagBiMsSX80zpM6PAlcF6VcnBozGudP1HNCbkSsrvQ7UyxKsdqybDOIPY7t45
         A35IcqpvO60zDYYCok4OeQZ6NsifEyw68gSVjOXD7Uk2CHXnHfGhPH6jeuEVUIwx4zl6
         osdCEjlnJphLIDHeyAR95zHG+nchZKb860Zeh/lfa/n8ebqCU2TSCHVTvesjcD6VMKv5
         N/BA==
X-Forwarded-Encrypted: i=1; AJvYcCX0zHaSNgtXjgt1CLDVtcDL0/Yz4XTwA6U9UeHIIAePbNrWWMV8oF5bEwSBcGMANkyPDKYrmTOEnGHhm8rzFZ6PlnNt
X-Gm-Message-State: AOJu0Yx94X9cDKB9tIVln2lqY7k6tj7YrMFth+RR/9GLcKc5v99v+YaD
	Dnkhk9L2Iaz7BckC53CmSKDWpeod5laB8lPSsRh4+w7yqgd0oDp2Lb/dSNgT5FFSHeNsnzmi+Cp
	JpYmdHy6RjWBUrwG5vAS4X+g1lxxonXqO6vYqbtWzXaYmBBlYfQ==
X-Google-Smtp-Source: AGHT+IFlZXhnnbTx1bR3IL0MEuJpb6BYtD7X1NVqh0jIq3mMhTGkqNSjbPG9eHDX2tOy0Ga8K2kdNA8x6bcAW9bCfZ4=
X-Received: by 2002:a81:92c2:0:b0:61b:33ae:e065 with SMTP id
 00721157ae682-62c7947ecbdmr103514047b3.0.1717452406285; Mon, 03 Jun 2024
 15:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-5-laoar.shao@gmail.com>
In-Reply-To: <20240602023754.25443-5-laoar.shao@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Jun 2024 18:06:35 -0400
Message-ID: <CAHC9VhTd+tx5vk+z_6e2hF4Ovoc76AMLchMPerpzsAiB=8E_2w@mail.gmail.com>
Subject: Re: [PATCH 4/6] security: Replace memcpy() with __get_task_comm()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 10:38=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Quoted from Linus [0]:
>
>   selinux never wanted a lock, and never wanted any kind of *consistent*
>   result, it just wanted a *stable* result.
>
> Using __get_task_comm() to read the task comm ensures that the name is
> always NUL-terminated, regardless of the source string. This approach als=
o
> facilitates future extensions to the task comm.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> LINK: https://lore.kernel.org/all/CAHk-=3DwivfrF0_zvf+oj6=3D=3DSh=3D-npJo=
oP8chLPEfaFV0oNYTTBA@mail.gmail.com/ [0]
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/lsm_audit.c         | 4 ++--
>  security/selinux/selinuxfs.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Similar to the audit change, as long as you sort out the
__get_task_comm() issues such that it can operate without task_lock()
this should be fine.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 849e832719e2..a922e4339dd5 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -207,7 +207,7 @@ static void dump_common_audit_data(struct audit_buffe=
r *ab,
>         BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
>
>         audit_log_format(ab, " pid=3D%d comm=3D", task_tgid_nr(current));
> -       audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(=
comm)));
> +       audit_log_untrustedstring(ab, __get_task_comm(comm, sizeof(comm),=
 current));
>
>         switch (a->type) {
>         case LSM_AUDIT_DATA_NONE:
> @@ -302,7 +302,7 @@ static void dump_common_audit_data(struct audit_buffe=
r *ab,
>                                 char comm[sizeof(tsk->comm)];
>                                 audit_log_format(ab, " opid=3D%d ocomm=3D=
", pid);
>                                 audit_log_untrustedstring(ab,
> -                                   memcpy(comm, tsk->comm, sizeof(comm))=
);
> +                                   __get_task_comm(comm, sizeof(comm), t=
sk));
>                         }
>                 }
>                 break;
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index e172f182b65c..a8a2ec742576 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -708,7 +708,7 @@ static ssize_t sel_write_checkreqprot(struct file *fi=
le, const char __user *buf,
>         if (new_value) {
>                 char comm[sizeof(current->comm)];
>
> -               memcpy(comm, current->comm, sizeof(comm));
> +               __get_task_comm(comm, sizeof(comm), current);
>                 pr_err("SELinux: %s (%d) set checkreqprot to 1. This is n=
o longer supported.\n",
>                        comm, current->pid);
>         }
> --
> 2.39.1

--=20
paul-moore.com

