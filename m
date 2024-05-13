Return-Path: <bpf+bounces-29619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073E8C39B9
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4091F21237
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7CCA920;
	Mon, 13 May 2024 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX0gn08n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA262E541
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715561187; cv=none; b=G4hH1cQlCGMbQ0PrGNHyGxzhrtwJqTFQNUNucAj2W85bkxrTVyCzA7KYCwXCmw14eh8O7CuXLIpeahM1KTrmNps6M0w8bg0zRTK3J1DsQjeRs5gE4cj+zCEEuWDacfscN7L2iIExNqQti0jiYhFYRX/kulEDTXsq/NO7W99hbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715561187; c=relaxed/simple;
	bh=t8K18/2eTEsfBrFBcHPT8KmNPu9uGTd86w129FaPWps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcYvWuIE1rM5IF++nRtuwRdmWvotg7tZ3BWnkxYcG0qEf/Yki9Y9K4hrQMz7TnBx+EdL1pgmwQ2gTbRN6RupJBkbYWhgINZTkF/91tope9EAdpNI4eiYQWZvrY+zOtENSQjEFl2B7JfzKxeLWEKTQ0c4rxA2/msgoxMRV9R0CmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX0gn08n; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34e667905d2so2563074f8f.1
        for <bpf@vger.kernel.org>; Sun, 12 May 2024 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715561184; x=1716165984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMFa+A/9lJ93vUZfcCr0rCKVEw0i3/Bkxk4gQNOY7Uo=;
        b=GX0gn08n0BvdJXYUj/xaW7hr78yi2AwcyTZOoqsKxardVrIfz4NqaOC9vSP8g1aUmj
         WeP2JvdflhH0NK9fc10wyIzWx0iwvDbxyZvqstisTa62Kc31xA61nOx80/rVOTB4SWqS
         YFvYE7SHkTdxyH2sq49Ip7PIzom5l6t8SxH6U8pYpMYO0Qfwn3EyggKOeus6t2t6l3hZ
         EtAxY9FTejNVnswKS6bbzAQh//xEi0zjTxf0x+51MCsn/unHAVQBw6cWaEkWWnZvGIjh
         eeWCbGJllTC0bFFaIYAxtpTPnkj/Bby2+LDhgtTQ3e2VoBIqqHi0cinnlIj+QE0RIr0E
         4a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715561184; x=1716165984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMFa+A/9lJ93vUZfcCr0rCKVEw0i3/Bkxk4gQNOY7Uo=;
        b=SBoixFPUK1cABQA1US464ZvDzckpW8JtApx2qUbIqknLVAQD+7d5zLNckK6zmeam25
         FtPI7FnnsWAUHHgEpl3oYporjlS7x7+VOMrpWcbj9DREpfmi8iT9u8NHXlwWEkdmTg96
         jAlJKNYIT6ru3AxciBvy/9NSiokdIp7GUN5UKtbFvihPthtta+kxxeuJ2qwdZWbuP/xS
         driGpPS7PGkfKIQNyBskl4nAteRvJXxlyTiasirkSBWHYaocEmu3EtQuVBuu+b2WLpj/
         igStK0mU7Kac5uRINqKWfDdW7ZpznUCl6Lph0ZR0VOpCp/nfmLPxDKLWvhWqT7l6aa4W
         Wkfg==
X-Gm-Message-State: AOJu0YwaF18oDAPD7cu3UOckZfg+qjAgFE/lE6VN+eOxzlqbB1hTpGVG
	DlSzohxEfthXQJ1n69DC3KfT+UzKTMb6SQZWUhp3QQMaD5zo7nGUkyOZCKEbmAmZQT5mN09+dTj
	h0yVKKjXEDN52MvkXyVXex9RxkAlyqA==
X-Google-Smtp-Source: AGHT+IGEGwoFGaCX05ExdambEWtMeH+dLhYNijvUgZQTZGJk2R8JsiP7orWXhdxt+woxJJWLm5qMc60VKuooy5lO/lc=
X-Received: by 2002:adf:ef43:0:b0:34d:b588:f22 with SMTP id
 ffacd0b85a97d-3504aa666a1mr5256837f8f.68.1715561183860; Sun, 12 May 2024
 17:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511212243.23477-1-jose.marchesi@oracle.com>
In-Reply-To: <20240511212243.23477-1-jose.marchesi@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 May 2024 17:46:12 -0700
Message-ID: <CAADnVQKUytdTK5ri4WUcB9VCmX4S+Hjkx7YkcDAPwP3UX05jBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2] bpf: make list_for_each_entry portable
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, David Faust <david.faust@oracle.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 2:23=E2=80=AFPM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> [Changes from V1:
> - The __compat_break has been abandoned in favor of
>   a more readable can_loop macro that can be used anywhere, including
>   loop conditions.]
>
> The macro list_for_each_entry is defined in bpf_arena_list.h as
> follows:
>
>   #define list_for_each_entry(pos, head, member)                         =
       \
>         for (void * ___tmp =3D (pos =3D list_entry_safe((head)->first,   =
           \
>                                                     typeof(*(pos)), membe=
r),    \
>                               (void *)0);                                =
       \
>              pos && ({ ___tmp =3D (void *)pos->member.next; 1; });       =
         \
>              cond_break,                                                 =
       \
>              pos =3D list_entry_safe((void __arena *)___tmp, typeof(*(pos=
)), member))
>
> The macro cond_break, in turn, expands to a statement expression that
> contains a `break' statement.  Compound statement expressions, and the
> subsequent ability of placing statements in the header of a `for'
> loop, are GNU extensions.
>
> Unfortunately, clang implements this GNU extension differently than
> GCC:
>
> - In GCC the `break' statement is bound to the containing "breakable"
>   context in which the defining `for' appears.  If there is no such
>   context, GCC emits a warning: break statement without enclosing `for'
>   o `switch' statement.
>
> - In clang the `break' statement is bound to the defining `for'.  If
>   the defining `for' is itself inside some breakable construct, then
>   clang emits a -Wgcc-compat warning.
>
> This patch adds a new macro can_loop to bpf_experimental, that
> implements the same logic than cond_break but evaluates to a boolean
> expression.  The patch also changes all the current instances of usage
> of cond_break withing the header of loop accordingly.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> ---
>  tools/testing/selftests/bpf/bpf_arena_list.h  |  4 +--
>  .../testing/selftests/bpf/bpf_experimental.h  | 28 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/arena_list.c  |  2 +-
>  .../bpf/progs/verifier_iterating_callbacks.c  |  9 +++---
>  4 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing=
/selftests/bpf/bpf_arena_list.h
> index b99b9f408eff..85dbc3ea4da5 100644
> --- a/tools/testing/selftests/bpf/bpf_arena_list.h
> +++ b/tools/testing/selftests/bpf/bpf_arena_list.h
> @@ -29,6 +29,7 @@ static inline void *bpf_iter_num_new(struct bpf_iter_nu=
m *it, int i, int j) { re
>  static inline void bpf_iter_num_destroy(struct bpf_iter_num *it) {}
>  static inline bool bpf_iter_num_next(struct bpf_iter_num *it) { return t=
rue; }
>  #define cond_break ({})
> +#define can_loop true
>  #endif
>
>  /* Safely walk link list elements. Deletion of elements is allowed. */
> @@ -36,8 +37,7 @@ static inline bool bpf_iter_num_next(struct bpf_iter_nu=
m *it) { return true; }
>         for (void * ___tmp =3D (pos =3D list_entry_safe((head)->first,   =
           \
>                                                     typeof(*(pos)), membe=
r),    \
>                               (void *)0);                                =
       \
> -            pos && ({ ___tmp =3D (void *)pos->member.next; 1; });       =
         \
> -            cond_break,                                                 =
       \
> +            pos && ({ ___tmp =3D (void *)pos->member.next; 1; }) && can_=
loop;    \
>              pos =3D list_entry_safe((void __arena *)___tmp, typeof(*(pos=
)), member))
>
>  static inline void list_add_head(arena_list_node_t *n, arena_list_head_t=
 *h)
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index 8b9cc87be4c4..13e79af0a17c 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -326,7 +326,21 @@ l_true:                                             =
                                               \
>         })
>  #endif
>
> +/* Note that cond_break can only be portably used in the body of a
> +   breakable construct, whereas can_loop can be used anywhere.  */

I fixed this comment to be proper kernel style.

> +
>  #ifdef __BPF_FEATURE_MAY_GOTO
> +#define can_loop                                       \
> +       ({ __label__ l_break, l_continue;               \

fixed white space damage.

> +       bool ret =3D true;                                \
> +        asm volatile goto("may_goto %l[l_break]"       \

fixed broken formatting.

> +                     :::: l_break);                    \
> +       goto l_continue;                                \
> +       l_break: ret =3D false;                           \
> +       l_continue:;                                    \
> +       ret;                                            \
> +       })
> +
>  #define cond_break                                     \
>         ({ __label__ l_break, l_continue;               \
>          asm volatile goto("may_goto %l[l_break]"       \
> @@ -336,6 +350,20 @@ l_true:                                             =
                                               \
>         l_continue:;                                    \
>         })
>  #else
> +#define can_loop                                       \
> +       ({ __label__ l_break, l_continue;               \
> +        bool ret =3D true;                               \
> +        asm volatile goto("1:.byte 0xe5;                       \
> +                     .byte 0;                          \
> +                     .long ((%l[l_break] - 1b - 8) / 8) & 0xffff;      \
> +                     .short 0"                         \
> +                     :::: l_break);                    \
> +       goto l_continue;                                \
> +       l_break: ret =3D false;                           \
> +       l_continue:;                                    \
> +       ret;                                            \
> +       })
> +

This copy paste of the macro is a bit annoying,
but I don't see a clean way to make can_loop and cond_break
to use a common macro without being unreadable.
So applied with the above fixes.

Thanks!

