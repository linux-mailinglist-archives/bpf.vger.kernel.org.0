Return-Path: <bpf+bounces-29307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259CD8C177A
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578481C2112D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA191292DB;
	Thu,  9 May 2024 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ez92D9UX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1C83A0D
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286272; cv=none; b=sI8ugfxJWZH+JqL5dPyeMzlXqy9ZINGBc0x9oisjX3VnUYl2ewlBFJji+s+H0zLnbuxacqeu02sFyFJGjePtV4avvGrDeMKFwlOS3ZnGqIZVtcAv26LsyMFH4HFJSCDuPTumSddqDKb+wQnya+rZwlhwrvJ37oGFGh2GStWp7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286272; c=relaxed/simple;
	bh=YV//7fsqwnpC8rn7Ht8SARvm/2KOCQeO6XAmlJNmCxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOI/zi+PGjYUGN9sHFbmb59VOwmSb/4A0wwdP2+FYs2jb+GyZMBxHf8uMYl77diRWoNn/xCT6NfP+lrbVCWKObBM4ub1xqiMTdb/E6t+h8ZGUcqbFwZ57bXOdMzLrBC9f3QWqxIkEt7rHIOxn3YxxaPAUm3fUu7Z+nGFcj3+u8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ez92D9UX; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7f1d60dee9aso375439241.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715286270; x=1715891070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBlvSCCzNhiMSs/fdIYYqTI6GfHdvf7llrF9PbjYLSM=;
        b=ez92D9UXtVa/5zgB0EM4zjoF/hfYeU9pCfAFjSfETytdJxp8ehWm7YOOHl0AeB1GFV
         ze7X3zhMESPmNTsqPi6yOS5NMIeWWTh4GDOM+wjYaOFbX7qij58hdiEoqgIqZbkbUe8F
         eLgELerxBBmQfjn5bWS9SLP81BEDka9FPbmjRClQGjjIvMhJZdZ/dXJivrppq17c5JD8
         OWFs6Gxpq9cCUANgo3kvpYwBT6b0HRNAAo1JmwqHjfvH6u6y1iP1fXH3kAPorp2OpzEu
         DFXcr90bqR36+h74ZJdkLAYsANRRHobnln36HjxSoc0czsuhN9Z8/39Mho5hbrnMtqeO
         abOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715286270; x=1715891070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBlvSCCzNhiMSs/fdIYYqTI6GfHdvf7llrF9PbjYLSM=;
        b=dnFgg+wqT2Y6xu336gmoC3spe7G+2CF9/x662MBFfd2tBCOqxDYS98YlU9S70igNQS
         u/rGNziEqo4adYtFBsT5WSUuDJen9U8GOgYtcn6vE6E1uZ3+DX1I4lcHYwfUNUASJ2SV
         CWcwduIAyLuYH1iuFly0GGaVE2C98WMlZXXIuVOtEraEx58yz/oi/kQFA6EsWebLYJqo
         uNmALUycrpbZmEb8oC1Hj7skv/mRQt7Q4+Ha5wNfM/NDDUzRnJgbJcnw8cYTic5tYBa2
         lU8ocjdA678Dei5JJNF4xkJoNSVM0bP9SWKr13CrmxfB/fwnkoorS3ZyX6FeHozjazHD
         s37A==
X-Forwarded-Encrypted: i=1; AJvYcCUY0OiprOV/5JZ4gG3h/zpPRQ0vOcleIqcVJv1pWf4216x4moHZURv3bf3v+ljEhm0vcuPCoItNLjyK4hqEIs1lXLB+
X-Gm-Message-State: AOJu0Yx4m8q7Yqy0b2GD8A6PgKXHJoRx2ZQmFNeh/+XE0vhFRe+tbsLq
	t3fhMb5JjkgF6Z9sOsXkTeK0ppyitWTVqOFoRYBcE2zeOkLLeIsiFAQi+LUNb0UtXFl6LLJV3pG
	7SP6jgSwIB70mUBcG6dCdKfQdt9bUX7tAEVjG
X-Google-Smtp-Source: AGHT+IH8KzvWPNo+HCZvNXMR9+VREiiHcFItnWuyCOonwxk6dBAa2EME39LnQ5/ASqOHhsf8rqfTCey1gxGm1cJP4OY=
X-Received: by 2002:a05:6102:5090:b0:47b:b404:d63e with SMTP id
 ada2fe7eead31-48077e0b67dmr968926137.15.1715286268370; Thu, 09 May 2024
 13:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507221045.551537-1-kpsingh@kernel.org> <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook> <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
 <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>
In-Reply-To: <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 May 2024 16:24:17 -0400
Message-ID: <CAHC9VhS6hckf+xzhPn9gNQfFDiQhiGyJuzGVNXB=ZAr=8Af37w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
To: KP Singh <kpsingh@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, jackmanb@google.com, renauld@google.com, 
	casey@schaufler-ca.com, song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 3:00=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> One idea here is that only LSM hooks with default_state =3D false can be =
toggled.
>
> This would also any ROPs that try to abuse this function. Maybe we can ca=
ll "default_disabled" .toggleable (or dynamic)
>
> and change the corresponding LSM_INIT_TOGGLEABLE. Kees, Paul, this may be=
 a fair middle ground?

Seems reasonable to me, although I think it's worth respinning to get
a proper look at it in context.  Some naming bikeshedding below ...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4bd1d47bb9dc..5c0918ed6b80 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -117,7 +117,7 @@ struct security_hook_list {
>         struct lsm_static_call  *scalls;
>         union security_list_options     hook;
>         const struct lsm_id             *lsmid;
> -       bool                            default_enabled;
> +       bool                            toggleable;
>  } __randomize_layout;

How about inverting the boolean and using something like 'fixed'
instead of 'toggleable'?

--=20
paul-moore.com

