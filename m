Return-Path: <bpf+bounces-76169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84206CA8A6B
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B703E305CAB5
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3C348867;
	Fri,  5 Dec 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngrO7crZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED5134FF61
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955909; cv=none; b=VWyiMm5OcAv/ihV3PpgZhUxbJSQUDb8ywflRAUcYwDBj+TARxkxcd73L/+oeg57+QMIJucAIp9ZKl+ARH3yj0sj2zql6CC55O817+3yaFW+8pbANZ3MLyW4CbyMCZrhUg5MKtsod6qlGOKOV68nEa1mIGfDuJvHeamC9l4b/ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955909; c=relaxed/simple;
	bh=e9CoZSp8ppByynofzj4R8fDqOU91q19IDQEVdfN/Rho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHnp/LYYS+qRuYLZ/AWDeTRHtfm5kBz2Fzs6AteJN3ZcpudC+BDNkCVbY3B3l/GzRVGp8R0qhpefUVc0CA/vK1b9ZJJQL7bCvED2ieLXJcGfus84FE6I/TJ0KgRzsMqP8L5+XskZ32bgz8gEFyTsd6bfvkekOAuepE8CnfMVmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngrO7crZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b713c7096f9so362053566b.3
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764955906; x=1765560706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JRTQ5qP3nDJv7XXYMbTJlNjt9BNu8NHYBKExw2nneY=;
        b=ngrO7crZoD//Q5eTsIcdJCLVOLciaLwGj+bzv5klL4CI8XH0sej9ITJuvPcZUZhv+j
         NBIy8dvcqR2prZPLFc8PJcijbHRf0bfxf8h0KWA8t1H54X7GaS6nmQ7QV8u5WhR2hEJD
         2hhRNd9MhO3VzqdQ45FSr3WzQUytEkpyd4KkjtCrykl3p6j9v43xxxv8Mq3m85ACadwM
         v9+xBkOeAPF/6rANBJuhlh3NeyxBO+bmXytpvSoJ7xeqCx5vTU6lKjTu5mHrxqKjOwXz
         3sjAdZ2AvPwam/Lqu01cMsMQsXe3C8rDOKShN0mnbbeUqd7BJRlwXEtSmw/+HirAApVx
         wDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955906; x=1765560706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JRTQ5qP3nDJv7XXYMbTJlNjt9BNu8NHYBKExw2nneY=;
        b=vTU2tngGO2vZfIOsR51JONJvN9pplnHQXUoPYw8tG/7mtwlWZrXR/2HVodG3rL53hS
         KeglFjRJStbHW4/vxYAz2sGalt3D7F4MSSV50ibU/8UKdOqcJ//aUGCAtmcom513XO+q
         tgGxw+cK0T3wjKCLR6wYfKTEEqLMVo3auoZE9f141+UWqWa4wv8UrTUNcSFAD9ZYkThQ
         /M+Pni+Y3b1onRfk9/NaUEpn4IxH1A+QnZV4rCoVusDKprF33LSf6rO2iOZCzncywk+/
         tLLYl3vuMmQzhUinE5a1f5EwQai3aFxo1MG31AF95Ir9kqCJaJkbmBL1AKrXrVIKJioB
         f+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6NdEXNNz5eWJ7Z6RkjeZL3i4xkdvhc2wjatn/LO/5HAk8SfqgPClUSYHHoo0w8SrGa7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijI6xPkrzhr6b7Fa84pKsN7ZdNZX8iTs35sjZjVcKKcV/Zcry
	RtBuLjWiUugMRz0ylRTVioduRO9dU3AzktJxW9bcwoCoGL6Unjme+VBl2deVWvncvYkWKifugVB
	a+9Vuw1kjH/uGq+6b41mNnDcYJS7UFiw=
X-Gm-Gg: ASbGncsAVIUjGZVUb2ZIdnhS2LN2cK9zRV5qerRutFrH6uXPo7n587gry9NXElKg2ZR
	URE2l6e+Ui0opoE5nBh7wbhBV7LkM7xPy5EHb0Wwv8Fm8WVuSCHsCOGXB5UZuccDYH0P1d1eufH
	VuTzJ9ZmCHJ8+bBTgnpuwsNR70MBH9FxI856YMFZ+8RU5Lhmq9eYtaM6umEY9BBaNCiirLJPREt
	RRpUBhF5UI9ptyULPDGKz4wYryJFuWbMlADr8BxKE7b5XDBCHYf4UeX9xzqjhsgRCtT5Lo6Cs7p
	OqKPcGUIb0ULwlIwPnIdGuYkKOCNxg==
X-Google-Smtp-Source: AGHT+IFRCgHfKGsAkZVPOlUmrl9vw+MR8hBEZgtV7PRhOjUmwdoMWwyUcdUQ+ugYeG8JzPcdndAeoqqxibr+uphApf4=
X-Received: by 2002:a17:906:dc95:b0:b6d:73f8:3168 with SMTP id
 a640c23a62f3a-b79dbe71c0amr1072539666b.3.1764955905366; Fri, 05 Dec 2025
 09:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205171010.515236-1-linux@roeck-us.net> <20251205171010.515236-13-linux@roeck-us.net>
In-Reply-To: <20251205171010.515236-13-linux@roeck-us.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Dec 2025 18:31:33 +0100
X-Gm-Features: AWmQ_blDI-utBDx2W6qm1w5i1hudk3paNzpT1OYcZ7gDhfKrn0IT4xpTqmkqetY
Message-ID: <CAOQ4uxiqK6Hj2ggtcD-c7BAtuBcm+LrKVkQOxi93OXhwSE98Dw@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] selftests/fs/mount-notify-ns: Fix build warning
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, wine-devel@winehq.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 6:12=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> Fix
>
> mount-notify_test_ns.c: In function =E2=80=98fanotify_rmdir=E2=80=99:
> mount-notify_test_ns.c:494:17: warning:
>         ignoring return value of =E2=80=98chdir=E2=80=99 declared with at=
tribute =E2=80=98warn_unused_result=E2=80=99
>
> by checking the return value of chdir() and displaying an error message
> if it returns an error.
>
> Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant runn=
ing inside userns")
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Update subject and description to reflect that the patch fixes a buil=
d
>     warning.
>     Use perror() to display an error message if chdir() returns an error.
>
>  .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notif=
y_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify=
_test_ns.c
> index 9f57ca46e3af..90bec6faf64e 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> @@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
>         ASSERT_GE(ret, 0);
>
>         if (ret =3D=3D 0) {
> -               chdir("/");
> +               if (chdir("/"))
> +                       perror("chdir()");

ASSERT_EQ(0, chdir("/"));

and there is another one like this in mount-notify_test.c

Thanks,
Amir.

