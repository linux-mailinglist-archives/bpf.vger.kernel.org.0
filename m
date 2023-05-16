Return-Path: <bpf+bounces-670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F23705632
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 20:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55099281215
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BB5290E9;
	Tue, 16 May 2023 18:42:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E88290E6
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 18:42:43 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D58682;
	Tue, 16 May 2023 11:42:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so25648466a12.1;
        Tue, 16 May 2023 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684262560; x=1686854560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctdc7Vyub0mk2EGAJTcTi0bqYHOoN+2odaP2Y74iYhQ=;
        b=ITTFYV9T1R0GCoNhHcirFKAfxFgL9j67lWUr6BaPppSIm8pNaLJGdLD1e9JxWTi4nh
         aifTJbWIjyEOctvzEoey3XKA3OO5GctYulwVfv+shOcOfDJQTEwnXC2PQuJI4kGjZSUB
         txhqj858QhYHIbMuQV7V6JzldmbLoZL4bvloWK9n+UUIBJvEOududEHqm7SabzlpWw37
         NjEo7QTa58bf9G3mwyYTi2A+s++GIGZy5WDYKSPmsS3qJSu//Ooeww60wQRjPXPp6Y3P
         diVnqUEE6m8JzLKNpFc6WVsUx0Ff1oD8UVyudDpP7+nCcRWlu2KmfTNGYq5CJoVfUA5w
         tDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684262560; x=1686854560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctdc7Vyub0mk2EGAJTcTi0bqYHOoN+2odaP2Y74iYhQ=;
        b=g/B7KHG2ZhUFTHk5Evl8zkW2Mtz3mGW6O5rcQaxgUeV5B1qfo6JfuBv20v2IiC+O8x
         01DIA8qjwFWROxgwF3xRSbx6AV/FNE3Lh/siP+eUGqekf6j5eHEGnGEMqcMya3Vi18aH
         lXzd6JoAFjj1/r3hL6xLm4CT+Q50jYje82QMQ06U9hRy2nO6aoaneUQwprU68np8gKQN
         UyEQmU/m+3NVC1vB5HVKVSmg3i7Tm9OpjqyWZd7C4bxWaEgalZw97rILEZGn80svzKa0
         B2fw6VPyynD6duNqjbfDmq+elOXzlf9FmZ5BRxPsM/+qCFIm5UA0pliX5r+PTuRkvsLq
         7KOQ==
X-Gm-Message-State: AC+VfDxnCrFLHf57MM0QYkoAfRr5QnavUNxgeJff6VELWuJcuXIHofMn
	PB1XaGwqyE194aRrFbPT7p3C/n5I0oEiRXkAJSpuxGMgpwjqhA==
X-Google-Smtp-Source: ACHHUZ5auCBVedIw+9g8zXMtUaifjrxWpSLDT4qGZEDOWMARxDQNXhz/LN8vqaTnrZvYr3HU/wSlGrY0Osx48mbsgCg=
X-Received: by 2002:aa7:cfcc:0:b0:50b:fb29:1d8f with SMTP id
 r12-20020aa7cfcc000000b0050bfb291d8fmr228386edy.0.1684262559943; Tue, 16 May
 2023 11:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511142535.732324-1-cgzones@googlemail.com> <20230511142535.732324-3-cgzones@googlemail.com>
In-Reply-To: <20230511142535.732324-3-cgzones@googlemail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 11:42:27 -0700
Message-ID: <CAEf4BzYRzqGSd8QkNsEPpHzWoSDcH3h6o1m=fxQDKQNT_OCsQw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] capability: use new capable_any functionality
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Serge Hallyn <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 11, 2023 at 7:27=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v3:
>   - rename to capable_any()
>   - simplify checkpoint_restore_ns_capable()
> ---
>  include/linux/capability.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index eeb958440656..4db0ffb47271 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -204,18 +204,17 @@ extern bool file_ns_capable(const struct file *file=
, struct user_namespace *ns,
>  extern bool ptracer_capable(struct task_struct *tsk, struct user_namespa=
ce *ns);
>  static inline bool perfmon_capable(void)
>  {
> -       return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
> +       return capable_any(CAP_PERFMON, CAP_SYS_ADMIN);
>  }
>
>  static inline bool bpf_capable(void)
>  {
> -       return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
> +       return capable_any(CAP_BPF, CAP_SYS_ADMIN);
>  }
>

For bpf parts:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  static inline bool checkpoint_restore_ns_capable(struct user_namespace *=
ns)
>  {
> -       return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
> -               ns_capable(ns, CAP_SYS_ADMIN);
> +       return ns_capable_any(ns, CAP_CHECKPOINT_RESTORE, CAP_SYS_ADMIN);
>  }
>
>  /* audit system wants to get cap info from files as well */
> --
> 2.40.1
>
>

