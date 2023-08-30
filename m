Return-Path: <bpf+bounces-8995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D178D7B3
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 18:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ADB2810B9
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9A6D39;
	Wed, 30 Aug 2023 16:53:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896D5383
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 16:53:45 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAAC19A
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 09:53:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26f51625d96so3156683a91.1
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693414424; x=1694019224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4JaiH+x2QYRd2YyCMhl2ijhGH4s2IQh38f/Hb1jRgU=;
        b=fBvDisWu0g5YqzxuwABeTvRkmmpwbnnSloi+GV+NTTAsqdQKOrkc++huwvBJa52pdH
         NJT44zgbJDjwv9LY+t1BQ9gNZ8fQ91seqlY5Lp6RS8plEYRyGOyPqlT1+q7AmnMyTloP
         559w2Jhg9dubsyHpyJl0knY3BR90Eb25krscrEXBDtVVjGkwIKPBF58qQkga1K56eQjE
         w5MLMBl9SHNVhmTFfeSm5bfVPltRwkdeJsqPZZbXNHPgqwNdE+rtJjIrADJJV4xlnXtG
         MKLqFqG2pJzgqGyAicJ6+iGJ3sGE6hD5ZiCyA3dLuQxFHaZn8GlbM4MaVYReRzQ34lyj
         zIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693414424; x=1694019224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4JaiH+x2QYRd2YyCMhl2ijhGH4s2IQh38f/Hb1jRgU=;
        b=GDdWQg9f861Tp/6+InC5efG2BBf90Bl4A5+xg+mqz2HeNM7RQMdfFNdF5so5CvnwAs
         XV4e/pMZVaeH8g/Z+Yz5InbCFAJdTN/jwHp6lQluf18wAgZBPscEYvc375p4AYjTOEBo
         /nrsueyonOBKgBhcmB4vRc2T1ZJB8vknzaTonpgBdcsuoxpOwzBAxJnHsE0IppBLMTgd
         TEHAfUELv5MHaGEbszxBc4Ib1ByAWnrtw7mr1an4gSbiXc8Catr3Pvx5FKMRShbaLx6P
         xQVByeq1BnxxvgEDt78VXkaGqipkNruW6j9OgYTvmSujCkvJMlpOYJpx3ZIbdMJLnwJD
         O0Mg==
X-Gm-Message-State: AOJu0Yzyc+fagELDbRogOdmT2GcUJcDZmUZG2py8Hq3YTWquQuBhyYfU
	kvRhrvJbuKKUSce5ryxcVeT1c5FJK65KxJc0ITs=
X-Google-Smtp-Source: AGHT+IEigPSDatMRvbNFWViDOtMM4iVhr3H20Yk5fdf79c3WY5ulnKGnhVE6pTLlrJDJK32MaAd7SZwmMJg+kjzJ+ng=
X-Received: by 2002:a17:90a:be11:b0:26d:1986:f7ec with SMTP id
 a17-20020a17090abe1100b0026d1986f7ecmr2549171pjs.1.1693414424002; Wed, 30 Aug
 2023 09:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-9-memxor@gmail.com>
In-Reply-To: <20230809114116.3216687-9-memxor@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 30 Aug 2023 18:53:32 +0200
Message-ID: <CA+fCnZfgr_BUDodo=0weoRk+E6=okWJtt0V1_sFXhoAXRczwmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/14] bpf: Prevent KASAN false positive with bpf_throw
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 1:43=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>

Hi Kumar,

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

Please also drop the kasan_unpoison_task_stack_below declaration from
mm/kasan/kasan.h.

Also, could you please split this change into 2: one that exposes
kasan_unpoison_task_stack_below and another that changes the bpf code.
This will greatly simplify backporting KASAN changes for older
kernels.

Thank you!

