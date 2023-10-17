Return-Path: <bpf+bounces-12472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA537CCB72
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E4F1C20A30
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2299CA65;
	Tue, 17 Oct 2023 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihcSn8BN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778E9CA54
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 18:58:46 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E11EC6
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 11:58:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507c78d258fso24108e87.2
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569123; x=1698173923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcSCete3RhbZYHvD2wFvMNaSSxKHdQNRC4K1hU+Bvpw=;
        b=ihcSn8BNpqddw9afRnD/SS10u5APg4p/IdnsXzdaTAVrkaj9QweI/LBaGTpYmQiBvh
         rKG3GiKDxIW0yVA6YiTLYfC1qKt6lbtUnlQzmGZw10hNB4IAwLfB8ZrZl+nClu38adtB
         k01q07K5NoBazmY4MYTs0hy+Um6b8/bQHHalpUxxAlCffqxzUUURyf0O4SH5VLgn7g7D
         qOojTQHO5jDOw4Jcj111K13D+ceNdQfGxDIyy11C+LBDxWuPJj8/xdfhoWBu6EStBmtw
         vqFMX3Ce5O4M8tPcjsoG7xykNIKcCic9S0/+NAhh3NJLliRrAVxHEPCISOvu0KtxqZWP
         23hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569123; x=1698173923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcSCete3RhbZYHvD2wFvMNaSSxKHdQNRC4K1hU+Bvpw=;
        b=FlJMXI7vxESmstGfnF8iVtmHgBSFfbgvqeS51syHA7Xnio8EDid7VdEauKthh19sIF
         mq9m+beOWACATFYBOxA29AFxROIEpTL1CM+bqKDradeMO8XE3WE56y33JUDGwW9M064m
         I3nLK5R/WgKJnwZPVE6id66s/ZxheWy4HB20Q5IGRTcIVfY8bsrpf4TCbupCgoJcgWGs
         cN8SKCsRJAN8nsdlFUmPTqMGcHoAbTSMV4pL6ErsPDjxgJbto4recIyDQsUy1QK1LdCv
         +kf0En2wFhlzpKUnG8wrw+eD/fgJwok9XLICIftperQIzdQM8JdXBt+wj8EzzjASWRiA
         qQPg==
X-Gm-Message-State: AOJu0Yz0WOOkpHpBXd6zI35c1F+mB4houm58M3jeMXIIeT2LvQ0Wfrv4
	fDsE7HaiiPkjsjeHBZ+GnIMJ/PXWcD1aYh6tPhU=
X-Google-Smtp-Source: AGHT+IEDkcsQ/iUsfpI1fK31VO/CRI+hnBngDdQ9zQYTdmLRo73mcBmeP9k3EdydsDmNOr0NINHSCPN1/k1czkG0Jv4=
X-Received: by 2002:a19:7506:0:b0:503:3680:6726 with SMTP id
 y6-20020a197506000000b0050336806726mr2260835lfe.6.1697569122925; Tue, 17 Oct
 2023 11:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013182644.2346458-1-song@kernel.org> <20231013182644.2346458-2-song@kernel.org>
In-Reply-To: <20231013182644.2346458-2-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Oct 2023 11:58:31 -0700
Message-ID: <CAEf4BzYbQzMU4T6KYt4UudXvZiPg4nQdQCxD9zqzoJLgqOE9bQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 11:29=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> This kfunc can be used to read xattr of a file.
>
> Since vfs_getxattr() requires null-terminated string as input "name", a n=
ew
> helper bpf_dynptr_is_string() is added to check the input before calling
> vfs_getxattr().
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  include/linux/bpf.h      | 12 +++++++++++
>  kernel/trace/bpf_trace.c | 44 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 61bde4520f5c..f14fae45e13d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2472,6 +2472,13 @@ static inline bool has_current_bpf_ctx(void)
>         return !!current->bpf_ctx;
>  }
>
> +static inline bool bpf_dynptr_is_string(struct bpf_dynptr_kern *ptr)

is_zero_terminated would be more accurate? though there is nothing
really dynptr-specific here...

> +{
> +       char *str =3D ptr->data;
> +
> +       return str[__bpf_dynptr_size(ptr) - 1] =3D=3D '\0';
> +}
> +
>  void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
>
>  void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
> @@ -2708,6 +2715,11 @@ static inline bool has_current_bpf_ctx(void)
>         return false;
>  }
>
> +static inline bool bpf_dynptr_is_string(struct bpf_dynptr_kern *ptr)
> +{
> +       return false;
> +}
> +
>  static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
>  {
>  }
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index df697c74d519..946268574e05 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -24,6 +24,7 @@
>  #include <linux/key.h>
>  #include <linux/verification.h>
>  #include <linux/namei.h>
> +#include <linux/fileattr.h>
>
>  #include <net/bpf_sk_storage.h>
>
> @@ -1429,6 +1430,49 @@ static int __init bpf_key_sig_kfuncs_init(void)
>  late_initcall(bpf_key_sig_kfuncs_init);
>  #endif /* CONFIG_KEYS */
>
> +/* filesystem kfuncs */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "kfuncs which will be used in BPF programs");
> +
> +/**
> + * bpf_get_file_xattr - get xattr of a file
> + * @name_ptr: name of the xattr
> + * @value_ptr: output buffer of the xattr value
> + *
> + * Get xattr *name_ptr* of *file* and store the output in *value_ptr*.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_get_file_xattr(struct file *file, struct bpf_dynptr_=
kern *name_ptr,
> +                                  struct bpf_dynptr_kern *value_ptr)
> +{
> +       if (!bpf_dynptr_is_string(name_ptr))
> +               return -EINVAL;

so dynptr can be invalid and name_ptr->data will be NULL, you should
account for that

and there could also be special dynptrs that don't have contiguous
memory region, so somehow you'd need to take care of that as well

> +
> +       return vfs_getxattr(mnt_idmap(file->f_path.mnt), file_dentry(file=
), name_ptr->data,
> +                           value_ptr->data, __bpf_dynptr_size(value_ptr)=
);
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(fs_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
> +BTF_SET8_END(fs_kfunc_set)
> +
> +const struct btf_kfunc_id_set bpf_fs_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &fs_kfunc_set,
> +};
> +
> +static int __init bpf_fs_kfuncs_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +                                        &bpf_fs_kfunc_set);
> +}
> +
> +late_initcall(bpf_fs_kfuncs_init);
> +
>  static const struct bpf_func_proto *
>  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
>  {
> --
> 2.34.1
>

