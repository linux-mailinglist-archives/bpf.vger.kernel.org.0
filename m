Return-Path: <bpf+bounces-10204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5B97A3165
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E221C20995
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023E218E31;
	Sat, 16 Sep 2023 16:25:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA3125D1
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 16:25:05 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C997FCC0
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 09:25:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso2409588a12.3
        for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694881503; x=1695486303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU1Hig9h4rTslMokVurBhNLzb7A0NexknnG2ZvKgUds=;
        b=mUQ4doonKKVlAonoQxGkXf7/y9rfiPV39Aejr+N26R0SPsOZ5yNA0fcVw/oSM9uJBo
         fIKHn/lMxshgPgM1HQOrRL+K7a1wLZagAbDw2/qI4SbZzcLHwHoX/6zGylefa2o3/rJw
         pWaRvc05dS6P0OXskUFGSzKHLzKrFxKy4E6t2WT/KZNB5V3HawvrpWxahxS9HH2FDP2B
         U+K9O5tsWAil9M9svkYewg6BEwM3XHjYKlZ2wavh83UgcLHAekLOgOMRKtTIu0oeHTMN
         gkQEY5+Kpz+eBYlIJ6mZX0zXpPLkwlWqMLH6YOIuwzvljFo2uhQlM6WvVvMaknAq7vVd
         VJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694881503; x=1695486303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU1Hig9h4rTslMokVurBhNLzb7A0NexknnG2ZvKgUds=;
        b=Hmwx8Mt7iSIv8LEftTtgt0SGEmcXYIRQbRaq6/ZxRibzsL24J+WwvDOlWpcXJX8Sj8
         GI/jRF2XspX79ClJq6f1HmDeJsvNlaaQT/pu2YAtdlUHuJkgYWUq4IvhlHAaSnoMJlun
         NfTU8gsxE8m9s0kCHCnw6p1DFqTLBghb2AfqQTd+cg970qGM5eW8TegVZAAz4cRhTScF
         X5mY8Z8p6Yh2+PMun+ALkRTTkuqdlGpdP5KJWO1idQUbe/RQs0gpM5aDRi1gO2ffbCar
         v5pX25/P0J92es2Iq8s7VDB4t8brMGF784xCxQWkwmKYvOPJp5Noe5ZOO3m5TKy0+cLn
         O6Ew==
X-Gm-Message-State: AOJu0YwJvk7HdeYkGFRjpK2HArxc3RXxlaflN8AhTBSZUfH6uhesu/us
	v7R3FLKvQ0yQ8g0T3kbvm9l+ta+CtQNPUuiM1nA=
X-Google-Smtp-Source: AGHT+IEtQuHlqFy7YvxvOycl4LPvMuEw9p303614mMRx3GMpNDem3xSvW/WgY7bYnBN9a+1y8nKNguStaL2cCOv/Tuk=
X-Received: by 2002:a17:90b:3103:b0:25d:eca9:1621 with SMTP id
 gc3-20020a17090b310300b0025deca91621mr3824123pjb.6.1694881503245; Sat, 16 Sep
 2023 09:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-10-memxor@gmail.com>
In-Reply-To: <20230912233214.1518551-10-memxor@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 16 Sep 2023 18:24:52 +0200
Message-ID: <CA+fCnZeoRiciaYkk=DwcfhEDdKP7pjmynh8wyKtYqq0VXHDVGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/17] mm: kasan: Declare kasan_unpoison_task_stack_below
 in kasan.h
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>, Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 13, 2023 at 1:32=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> We require access to this kasan helper in BPF code in the next patch
> where we have to unpoison the task stack when we unwind and reset the
> stack frame from bpf_throw, and it never really unpoisons the poisoned
> stack slots on entry when compiler instrumentation is generated by
> CONFIG_KASAN_STACK and inline instrumentation is supported.
>
> Also, remove the declaration from mm/kasan/kasan.h as we put it in the
> header file kasan.h.
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/kasan.h | 2 ++
>  mm/kasan/kasan.h      | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 819b6bc8ac08..7a463f814db2 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -283,8 +283,10 @@ static inline bool kasan_check_byte(const void *addr=
ess)
>
>  #if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
>  void kasan_unpoison_task_stack(struct task_struct *task);
> +asmlinkage void kasan_unpoison_task_stack_below(const void *watermark);
>  #else
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {=
}
> +static inline void kasan_unpoison_task_stack_below(const void *watermark=
) {}
>  #endif
>
>  #ifdef CONFIG_KASAN_GENERIC
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 2e973b36fe07..5eefe202bb8f 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -558,7 +558,6 @@ void kasan_restore_multi_shot(bool enabled);
>   * code. Declared here to avoid warnings about missing declarations.
>   */
>
> -asmlinkage void kasan_unpoison_task_stack_below(const void *watermark);
>  void __asan_register_globals(void *globals, ssize_t size);
>  void __asan_unregister_globals(void *globals, ssize_t size);
>  void __asan_handle_no_return(void);
> --
> 2.41.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!

