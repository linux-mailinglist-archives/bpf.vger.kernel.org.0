Return-Path: <bpf+bounces-8938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA15378CE5E
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 23:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE42280FE3
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 21:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0FE182BE;
	Tue, 29 Aug 2023 21:08:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC814AAF
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 21:08:46 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7A10EA
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 14:08:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40078c4855fso45439035e9.3
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693343306; x=1693948106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePEFkQXpT6KgH+MkEm671vg2sXf3+NOP3qQSWej3Q0I=;
        b=BUMgj2l+1vP+CrXRriG4fAss1t2dI2LCI7OZdQVMqFWtR5rW9BImLDsWsQQbJqTYoy
         TUvGccdbvCcAhWs6Dpdxl/tx0hDPe88Ry3aWJPshHRZhikxCLfYesbpaoJ7QsywxAG4q
         O6STtqh/GemFWcMfVQ9zy5H3VTbTk8VzlSDFhZG9tfPi0QrA30+wE7nb2gKib3kCCzas
         3iRffIKWUabV/zPj0ihaWftvmYmBNgw4OyT+KMjg2o4VWJy1cN5kk9WAWOCiioScxQlZ
         2xOydTRzTbJ2gSohwdbeaN8OMjyasaUc3MaQALiTe2BQuOJ8tkTVIzOdVWAsR+3e2+eD
         HDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693343306; x=1693948106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePEFkQXpT6KgH+MkEm671vg2sXf3+NOP3qQSWej3Q0I=;
        b=WRU2v7F4qN1EFQSk7ACYBPY1wh2HCdJ69VaeSNqmpkryE98HP9suFRfEEUaKUHEFHx
         lUCO4CkQT7VSMVD2VSQZ+ognKa7jqKup5pNGYs0LXfzctOE2wkG4KIvlQE6EbMGIcvD4
         uoMyo6JW/Uz0BBDmWvhdzLmYVT9vz+FqZA+CBl+X4IQDDa02JAaKUoclGJmTaaCeV9Up
         /CwNycy0YWj4ryIBtkRIHITn8/l8Rs26LQYKVF0qccvQ2bfEoiij87VV0J6fDGP74NvT
         Y97k7lioyQnByyu5K9UoGJYKFHof56JSOJMlYWw7v1ErtaymRoP3A6Ak/aEGS3MLCdMO
         mKXA==
X-Gm-Message-State: AOJu0YzfeI8d2MGoypWvwJYJ/QaibZuJgTYAi6qTwpTWBgQcrnqAqzkV
	FO8t+aFz55dZOfnZ4fbP4U/34e5BNg0pud6CcaPh8Q==
X-Google-Smtp-Source: AGHT+IFo3cl8zuXncsoiYUt7PFXoflw69sKYdVlOz9vR0L/j8ak0bfeApZEnpl6vENdZhoGbzBCK6UYNMbrCTuLtsWU=
X-Received: by 2002:a5d:6108:0:b0:317:7eec:5e9d with SMTP id
 v8-20020a5d6108000000b003177eec5e9dmr173442wrt.16.1693343305825; Tue, 29 Aug
 2023 14:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <57628f7a15e20d502247c3b55fceb1cb2b31f266.1693342186.git.daniel@iogearbox.net>
In-Reply-To: <57628f7a15e20d502247c3b55fceb1cb2b31f266.1693342186.git.daniel@iogearbox.net>
From: Marco Elver <elver@google.com>
Date: Tue, 29 Aug 2023 23:07:48 +0200
Message-ID: <CANpmjNP4qKMTEsSKZH_zQLnOOXA-9tWpFx_4w3E3swPQ5aJT8Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Annotate bpf_long_memcpy with data_race
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, syzbot+97522333291430dd277f@syzkaller.appspotmail.com, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 29 Aug 2023 at 22:53, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> syzbot reported a data race splat between two processes trying to
> update the same BPF map value via syscall on different CPUs:
>
>   BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update
>
>   write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
>    bpf_long_memcpy include/linux/bpf.h:428 [inline]
>    bpf_obj_memcpy include/linux/bpf.h:441 [inline]
>    copy_map_value_long include/linux/bpf.h:464 [inline]
>    bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
>    bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
>    generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
>    bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
>    __sys_bpf+0x28a/0x780
>    __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
>    __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
>    __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>   write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
>    bpf_long_memcpy include/linux/bpf.h:428 [inline]
>    bpf_obj_memcpy include/linux/bpf.h:441 [inline]
>    copy_map_value_long include/linux/bpf.h:464 [inline]
>    bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
>    bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
>    generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
>    bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
>    __sys_bpf+0x28a/0x780
>    __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
>    __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
>    __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>   value changed: 0x0000000000000000 -> 0xfffffff000002788
>
> The bpf_long_memcpy is used with 8-byte aligned pointers, power-of-8 size
> and forced to use long read/writes to try to atomically copy long counters.
> It is best-effort only and no barriers are here since it _will_ race with
> concurrent updates from BPF programs. The bpf_long_memcpy() is called from
> bpf(2) syscall. Marco suggested that the best way to make this known to
> KCSAN would be to use data_race() annotation.
>
> Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Link: https://lore.kernel.org/bpf/000000000000d87a7f06040c970c@google.com

Given the "best-effort" nature of this, I do think data_race() is the
right approach:

Acked-by: Marco Elver <elver@google.com>

But, tangentially related, reading the comment it looks like the
intent is that this should always be plain long loads. Loops like this
tend to make the compiler recognize it's a memcpy-like operation and
replace them with builtin memcpy, which in turn may turn into calls to
real memcpy(). Are such compiler optimizations ok?
If it's not ok, and you'd like to prevent the compiler from turning
into memcpy() calls, then there are several options:

  1. Do the READ_ONCE()/WRITE_ONCE() as you already suggested.
  2. barrier() within the loop.

If defending against the compiler turning it into memcpy() is a
side-goal, option #1 may be better after all.

> ---
>  include/linux/bpf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f58895830ada..eb1bb76e87f8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -425,7 +425,7 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
>
>         size /= sizeof(long);
>         while (size--)
> -               *ldst++ = *lsrc++;
> +               data_race(*ldst++ = *lsrc++);
>  }
>
>  /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
> --
> 2.21.0
>

