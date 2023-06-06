Return-Path: <bpf+bounces-1946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC007249DE
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B765E280FB2
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0241ED4C;
	Tue,  6 Jun 2023 17:09:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6151ED33
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 17:09:12 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA0173E;
	Tue,  6 Jun 2023 10:08:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so8978173a12.0;
        Tue, 06 Jun 2023 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686071335; x=1688663335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axeQBjIk+qwJ1RO7wNCxa/rzAi/RLd5g07eZloe/TyQ=;
        b=ZyMsjj5W6ar9PSi5kKlZg7gv5Kg4p62QVznWlIGeL1Frg2m3bG2YL6i7RubzrvObYn
         wvJe2hRkpbdEwdZTP0nZRgGGuI8vppi3wldkPPQ71PCzbJkwa6GiDYFigVn5i4MY8yu5
         Z2+kdcRZkz/3lk9WvUeFOuCwvTJtaE+siOzwiYma1l921EvxQ+FySrpI0dCRKRlBwLE0
         Y2/fnUtGVI5bTkhlUE5GCbPNiJv7oHCnvLevGLkvowdvUwgik8+ZZJT0pTkcN2U/2xwT
         FxNFvVzuNrAxVtUrjNHJMaHEdKj/IP2X6DHRcOSGxQEYFeUlpVHJvmEdsASdlB7v9uLw
         jLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071335; x=1688663335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axeQBjIk+qwJ1RO7wNCxa/rzAi/RLd5g07eZloe/TyQ=;
        b=aXSTmHbuAccUxPQXNZFHZ1p4ekpnmpDH7r7WZcs0Rcc7jAzk/FbXyT40aGwa6ti5vh
         y8G56rPT7geQTcQ3+v2+TQdQwoTZKjT/yNFPy9nao6wNRQHc5+Thny8vFN4W30oqC0YL
         +wS/PGZokxilg+it/EYFxJJiDGwMgU90MZFop6OZAZ21D2XfNo2UApkAmpA87Xue4oQD
         uPzAMXWG2JPtA2hw78gogxc01GP6ib5k0YxZEJjdvvSpkc1jrEJV3jXvERO6eCFLD1SA
         YJXNYKmmLu5ucFJn8EIiGv7U8ta/pGaMGkRWrQKpS+0ZMZtUP9m/K8fdNLZFu1+DWrOD
         8ZEQ==
X-Gm-Message-State: AC+VfDxUkdEvQ+QPTSl9U1fJZInA+VaPcA9ft3sArKf0WczPBVhJI9Mn
	CHsJZVKWvbryaUZogtko1+Ao9dZAEVxGD+Go1Is=
X-Google-Smtp-Source: ACHHUZ45oovp1yvRpfc3vJnMH5ivxdFeS0lWmwwGbAJ/sBmChsPEAz4fgUT5vf6rXniB1jvt8IG6Rl/6gYQgEKDXz1c=
X-Received: by 2002:aa7:df81:0:b0:504:b228:878d with SMTP id
 b1-20020aa7df81000000b00504b228878dmr2274485edy.25.1686071334891; Tue, 06 Jun
 2023 10:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a@epcas5p4.samsung.com>
 <20230606042802.508954-1-maninder1.s@samsung.com> <20230606042802.508954-2-maninder1.s@samsung.com>
In-Reply-To: <20230606042802.508954-2-maninder1.s@samsung.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Jun 2023 10:08:42 -0700
Message-ID: <CAEf4BzYavyL431eA_HZ-X8+wTeO4Cyt7tGDUbPB0yqPru=ZUSw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] bpf: make bpf_dump_raw_ok() based on CONFIG_KALLSYMS
To: Maninder Singh <maninder1.s@samsung.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	thunder.leizhen@huawei.com, mcgrof@kernel.org, boqun.feng@gmail.com, 
	vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com, 
	brauner@kernel.org, michael.christie@oracle.com, samitolvanen@google.com, 
	glider@google.com, peterz@infradead.org, keescook@chromium.org, 
	stephen.s.brennan@oracle.com, alan.maguire@oracle.com, pmladek@suse.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Onkarnath <onkarnath.1@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 5, 2023 at 9:28=E2=80=AFPM Maninder Singh <maninder1.s@samsung.=
com> wrote:
>
> bpf_dump_raw_ok() depends on kallsyms_show_value() and we already
> have a false definition for the !CONFIG_KALLSYMS case. But we'll
> soon expand on kallsyms_show_value() and so to make the code
> easier to follow just provide a direct !CONFIG_KALLSYMS definition
> for bpf_dump_raw_ok() as well.

I'm sorry, I'm failing to follow the exact reasoning about
simplification. It seems simpler to have

static inline bool kallsyms_show_value(const struct cred *cred)
{
    return false;
}

and control it from kallsyms-related internal header, rather than
adding CONFIG_KALLSYMS ifdef-ery to include/linux/filter.h and
redefining that `return false` decision. What if in the future we
decide that if !CONFIG_KALLSYMS it's ok to show raw addresses, now
we'll have to remember to update it in two places.

Unless I'm missing some other complications?

>
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/filter.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index bbce89937fde..1f237a3bb11a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -923,13 +923,21 @@ bool bpf_jit_supports_kfunc_call(void);
>  bool bpf_jit_supports_far_kfunc_call(void);
>  bool bpf_helper_changes_pkt_data(void *func);
>
> +/*
> + * Reconstruction of call-sites is dependent on kallsyms,
> + * thus make dump the same restriction.
> + */
> +#ifdef CONFIG_KALLSYMS
>  static inline bool bpf_dump_raw_ok(const struct cred *cred)
>  {
> -       /* Reconstruction of call-sites is dependent on kallsyms,
> -        * thus make dump the same restriction.
> -        */
>         return kallsyms_show_value(cred);
>  }
> +#else
> +static inline bool bpf_dump_raw_ok(const struct cred *cred)
> +{
> +       return false;
> +}
> +#endif
>
>  struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
>                                        const struct bpf_insn *patch, u32 =
len);
> --
> 2.17.1
>

