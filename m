Return-Path: <bpf+bounces-75969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37771C9F7F1
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 16:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D85A6306455E
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0895303C91;
	Wed,  3 Dec 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="JYfIwzKY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509A308F39
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775814; cv=none; b=GDK4HJkaRm0DzRPKruD1gq0SGTgnhWcZPNcPwehN4GZ57E0wq/StawfX7IxwNSzOaUHBOmN4NXIydtBFyfdE+nqqt+QjXC83AVUD0tz0ILu/1K4e8gawG0TZWo6OwbAhdZdSi1oJpPiwiC6IHgk6LDu33feQzIgA+yyhAyEaGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775814; c=relaxed/simple;
	bh=95nguRQBPeNUvonLaX1JO4HDSwBdlh08J3sE8cLlj/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuGKdRqW0iFKIIOs7mhLWxVs+y3S95KORy93vjG8ZK1F6AaP76ubWkWNAWRMhLQVDA6/U+trQPMhg3utGJHRz2I5R/SeviKPVVotGl4n5odejHOrdCxnJcEhpIxoGPKXu9STtTucYhDuR7Mlh67yd8jG7UnPHGPYII/WO6yRVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=JYfIwzKY; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 38B943FE3A
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764775802;
	bh=ShZqq51cUVNpY9sboF6S2kGBKGQe1jEFK1krnzeDdLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=JYfIwzKYLfMkYZntzpIbGAp5NE4QlEnJuOz/GfC96u+zl5Yy4mQIVW8olK9qRJDh7
	 SzcUz7lguxOiVZjErdM6WsR87LGwuY9tzc/3yu7UVIwBRHePOMQKKwDl60KJvBMlNK
	 HpMxrcNgrxwA2Hs/mUlcBpSY2uD/r+VqviW4zDX158EEhhWMtVoy5ZGFwPquVC25I8
	 34isJB7Ff0bI1UER32UkM0UzyROLHHn2V25SHgeMRjkvyoG4jVBQx9guJ/Lu7fPOGC
	 T+2oQ2FLgZ7nGV2IDm9SZ/mQoOOJZOPdr5uohzicZflAgtq8I7EvQRQgY3lCIwTnSz
	 v0pvqO1fVxjhBLV6vHwiIyZ3N8jzXt0t9cgUzQuiR7okfKgec/o7BmfOAKz7orrDAd
	 yqDy352bLyvYupiusAVQk4gT5HKS+v9baQGZFFZABv/E3csTH7C2vvLfc0HSCp7jyR
	 P6966EccVFwQXN//lJyIg0GR6XVDUF8KSSNynyPHfEWvDLWGhNDESWUP0mSVqdxuE7
	 E9q4GER3numJj4ltyxZbsTvSOG3drqI+N/KxN8X7sFTQzgN0tS37xb9/ryrLLJIxDx
	 RVfChBLlwA+XET/OMLNlmn050b2SKODzmTzXtZ57hvngrtrlQOX21KyZu/8bfzaK52
	 NIqjIkBhcaIy16s+7Gj/K8jI=
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5dfb2af7e68so1853598137.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 07:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764775801; x=1765380601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ShZqq51cUVNpY9sboF6S2kGBKGQe1jEFK1krnzeDdLk=;
        b=MY4nJz+OY1ZJdn6SUthMwmyhDSnnEQM3QP35i723HzOlvAg2cHGuciwy/aaavgTZaD
         jerQKRwqkL7LFN74XlXvr6ULu9a/qOGnr8sGvMgxqwotSd0/KfeTgoqeBjqHXqbel5he
         6xF1rPPr30BT7YjBnefy1iXr6O5KOjn4EpNY8k+ntgRhS0+M6jI6L1XZqQMavy4c3rR5
         kBBVCogVK7gJ7neNEkaqmP37LTztjT1tZA9GWFOfM7t4kxq+B3TY2//Hu2xtPTfLLepB
         0Y4B+0FeVlHVzgNjllE1uZT4cPufBCB6yCXVAvUPTFZ84nOTB4tdn7ksm0keel+tccgN
         BHHA==
X-Forwarded-Encrypted: i=1; AJvYcCW1O04sBejvlWRboK2RirZqKHiV8Ra7GUmy4LuUcPkNAFjtgBi/3n24aFIlG2333lQ90RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv0z012o0wjJZOMog7bs/damzzqDqCoNJQnjWNSO5Ozp9ODOH6
	16Pl38NBpMtnI3MtZqJtTsmG0kQ2Gs1g2nwsUmBZNR+E/VIcOTW7Cu4ccRayDjMNfk3Akv/WoJI
	VcdxhTdEEpc+5pz1a7GzCjfIsLkz+4+NYS4OtT5IFvbAA4MuLdqmNYvNQoIaYedeZCpE9dZYA/3
	DkuB/4i2mHKBoHwqJcSO8VNU5AoItM3eL4VT3EcWUFDRyB
X-Gm-Gg: ASbGncuNi9JbQ3EvxuoYdb3JEy6xIoRDJNnedy49ovefVlnEQq7+6wntKRF2EB1i2Hn
	jgjuoLUFkvIcwqsb9UkBU2sT+g05qRQ8L9jVSKw0FoE4wnb4qf7bzmWWCWe/410OI8Wr1S7art4
	JCQol5GqT0lJNl2YDGl4Zys9ZEm5kte3nFYYiyoynxzZwu9L5H6/KuYbdfhaQy2xMKjRYUn/a7M
	LhqL+8Jnbd1AvfrBEqGTPMYpA==
X-Received: by 2002:a05:6102:3f49:b0:5dd:b5a2:b590 with SMTP id ada2fe7eead31-5e48e25d2admr787337137.16.1764775801069;
        Wed, 03 Dec 2025 07:30:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEON3Glz57/wGFQZShw1sXaC6kF3KNMdUKK2jt+Q+wq7dMX+n8OQ2mr3jPrEmVNdD8N8GATq1NNUPOIPjYdg34=
X-Received: by 2002:a05:6102:3f49:b0:5dd:b5a2:b590 with SMTP id
 ada2fe7eead31-5e48e25d2admr787331137.16.1764775800721; Wed, 03 Dec 2025
 07:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com> <20251202115200.110646-5-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20251202115200.110646-5-aleksandr.mikhalitsyn@canonical.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Wed, 3 Dec 2025 16:29:49 +0100
X-Gm-Features: AWmQ_bnqB1PZm-wIqzzXfJkbESDoT9yMXb4d6V9HO8FybglQXty1MBZiP1vB_GI
Message-ID: <CAEivzxf0a8EDzVJ+j7FLuarKHrCRPUtS9Z+tQ4se9E+xHvE0Fg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] seccomp: handle multiple listeners case
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Andrei Vagin <avagin@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Tycho Andersen <tycho@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 12:52=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> If we have more than one listener in the tree and lower listener
> wants us to continue syscall (SECCOMP_USER_NOTIF_FLAG_CONTINUE)
> we must consult with upper listeners first, otherwise it is a
> clear seccomp restrictions bypass scenario.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: Kees Cook <kees@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Tycho Andersen <tycho@tycho.pizza>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: St=C3=A9phane Graber <stgraber@stgraber.org>
> Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  kernel/seccomp.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index ded3f6a6430b..262390451ff1 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -448,8 +448,21 @@ static u32 seccomp_run_filters(const struct seccomp_=
data *sd,
>
>                 if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
>                         ret =3D cur_ret;
> +                       /*
> +                        * No matter what we had before in matches->filte=
rs[],
> +                        * we need to overwrite it, because current actio=
n is more
> +                        * restrictive than any previous one.
> +                        */
>                         matches->n =3D 1;
>                         matches->filters[0] =3D f;
> +               } else if ((ACTION_ONLY(cur_ret) =3D=3D ACTION_ONLY(ret))=
 &&
> +                           ACTION_ONLY(cur_ret) =3D=3D SECCOMP_RET_USER_=
NOTIF) {

My bad. We also have to check f->notif in there like that:

                } else if ((ACTION_ONLY(cur_ret) =3D=3D ACTION_ONLY(ret)) &=
&
-                           ACTION_ONLY(cur_ret) =3D=3D SECCOMP_RET_USER_NO=
TIF) {
+                          (ACTION_ONLY(cur_ret) =3D=3D SECCOMP_RET_USER_NO=
TIF) &&
+                          f->notif) {
                        /*

After Kees's comment I have some idea about how to potentially get rid
of matches->filters static
array. I'll try to rework this.

> +                       /*
> +                        * For multiple SECCOMP_RET_USER_NOTIF results, w=
e need to
> +                        * track all filters that resulted in the same ac=
tion, because
> +                        * we might need to notify a few of them to get a=
 final decision.
> +                        */
> +                       matches->filters[matches->n++] =3D f;
>                 }
>         }
>         return ret;
> @@ -1362,8 +1375,24 @@ static int __seccomp_filter(int this_syscall, cons=
t bool recheck_after_trace)
>                 return 0;
>
>         case SECCOMP_RET_USER_NOTIF:
> -               if (seccomp_do_user_notification(match, &sd))
> -                       goto skip;
> +               for (unsigned char i =3D 0; i < matches.n; i++) {
> +                       match =3D matches.filters[i];
> +                       /*
> +                        * If userspace wants us to skip this syscall, do=
 so.
> +                        * But if userspace wants to continue syscall, we
> +                        * must consult with the upper-level filters list=
eners
> +                        * and act accordingly.
> +                        *
> +                        * Note, that if there are multiple filters retur=
ned
> +                        * SECCOMP_RET_USER_NOTIF, and final result is
> +                        * SECCOMP_RET_USER_NOTIF too, then seccomp_run_f=
ilters()
> +                        * has populated matches.filters[] array with all=
 of them
> +                        * in order from the lowest-level (closest to a
> +                        * current->seccomp.filter) to the highest-level.
> +                        */
> +                       if (seccomp_do_user_notification(match, &sd))
> +                               goto skip;
> +               }
>
>                 return 0;
>
> --
> 2.43.0
>

