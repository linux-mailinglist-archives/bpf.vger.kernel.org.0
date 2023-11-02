Return-Path: <bpf+bounces-13991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB47DF8A5
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62EA1B212B7
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560E200BD;
	Thu,  2 Nov 2023 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGes08du"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE261DFEA
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:25:32 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BD5B7
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:25:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2030511a12.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698945929; x=1699550729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6D1AAkqVfvVEHfysk9LRGuXUuKlzNpnFcIIu/P8vTA=;
        b=FGes08du25IGrosTAcYXycFAnaXzhwil1D2JhzfHbQWeXIl1aSCDG7/kzojgWDi6qA
         DlRKLCNl6SAay7cQBxJQ5N9eXrknPa7DJ0ADlvE5s3LWJ8eU+jOcavvRjPWidi2BCY6E
         Ys1N5Yrq2IqKenUe3TWnriFfTkYq3GamWw/4TZR7wfa5QuL39SvEZnZ3byckRWJp07B9
         HNjPf4JDOuMegBYSUS9LcQ34UGlpstskedxVSTWyhXgGhgGAMGjUCPDtI/A8U9L+lliw
         9tmK5OELwZ0ZXgdAkzxQRLptHBjv49lMYCkMWswOdq35CvAPjBH1uMDgvYqwhN5vU1L8
         qR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945929; x=1699550729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6D1AAkqVfvVEHfysk9LRGuXUuKlzNpnFcIIu/P8vTA=;
        b=PsU4neJ5D3AalEZMwZOIqhfE2Cf4tuEWG4WT1h/Kmyo8BZexYS9H9JUUHiEm1EZp0E
         KAKDSaCqs3nZCFYIdtDZfGYP20esJXURvxATLjaqWwMWCwGEaZItPZ26iM8DF/SaqgkC
         BoonX3E2IyxTsitjVbMGeLx0LkmVRr93g+FSAQgYVv3qWgDLv3yFU2urpc6QsTOYtBqr
         kKA2X+6PydjEcQGS6AaBkaKdfZFwenfaCmNyJKxwXweAl3kUhJXpRUmzq7ZBk9qag+Sd
         Z21GC8777sxEZFYc97dFXN5MfQQpokOD+tFRyHSU/Z0naVx9P7A+clznwJ3ILd/MEqIG
         KS0w==
X-Gm-Message-State: AOJu0Yxyp2w6rGYFk1XUmXk8ulHwvUplK/wcOOpqCA6iqT9I9YdBNk0H
	ouPmgpppo3rpTVsDt8k7RiATPBJ7EVTszPe+BSw=
X-Google-Smtp-Source: AGHT+IEzM0hraft0farR+oFE3CLWqbpdEbVusyafAJ7N8TKn9zazkEo+eHGLs0QMrEzIkxUB40Dws73szKfhrlK8WiI=
X-Received: by 2002:a17:907:841:b0:9bf:65b0:1122 with SMTP id
 ww1-20020a170907084100b009bf65b01122mr5041987ejb.69.1698945929287; Thu, 02
 Nov 2023 10:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102165432.1769965-1-song@kernel.org> <20231102165432.1769965-2-song@kernel.org>
In-Reply-To: <20231102165432.1769965-2-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 10:25:18 -0700
Message-ID: <CAEf4BzYtfjZRq5xfAZJUmBS=bWVp6JP87Dv3dySyW_4hXwKoRQ@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for
 in kernel use
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:54=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> kfuncs bpf_dynptr_slice and bpf_dynptr_slice_rdwr are used by BPF program=
s
> to access the dynptr data. They are also useful for in kernel functions
> that access dynptr data, for example, bpf_verify_pkcs7_signature.
>
> Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr to bpf.h so that kernel
> functions can use them instead of accessing dynptr->data directly.
>
> Update bpf_verify_pkcs7_signature to use bpf_dynptr_slice instead of
> dynptr->data.
>
> Also, update the comments for bpf_dynptr_slice and bpf_dynptr_slice_rdwr
> that they may return error pointers for BPF_DYNPTR_TYPE_XDP.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  include/linux/bpf.h      |  4 ++++
>  kernel/bpf/helpers.c     | 16 ++++++++--------
>  kernel/trace/bpf_trace.c | 15 +++++++++++----
>  3 files changed, 23 insertions(+), 12 deletions(-)
>

Oh, what a bad timing, I was too late (or too early, depending on how
you look) to comment on issues I've found. Please take a look comments
on v6. I think your usage of dynptr needs fixing.


> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4825d3cdb29..3ed3ae37cbdf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1222,6 +1222,10 @@ enum bpf_dynptr_type {
>
>  int bpf_dynptr_check_size(u32 size);
>  u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
> +void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
> +                      void *buffer__opt, u32 buffer__szk);
> +void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offse=
t,
> +                           void *buffer__opt, u32 buffer__szk);
>
>  #ifdef CONFIG_BPF_JIT
>  int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tra=
mpoline *tr);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e46ac288a108..af5059f11e83 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2270,10 +2270,10 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid=
(s32 pid)
>   * bpf_dynptr_slice will not invalidate any ctx->data/data_end pointers =
in
>   * the bpf program.
>   *
> - * Return: NULL if the call failed (eg invalid dynptr), pointer to a rea=
d-only
> - * data slice (can be either direct pointer to the data or a pointer to =
the user
> - * provided buffer, with its contents containing the data, if unable to =
obtain
> - * direct pointer)
> + * Return: NULL or error pointer if the call failed (eg invalid dynptr),=
 pointer
> + * to a read-only data slice (can be either direct pointer to the data o=
r a
> + * pointer to the user provided buffer, with its contents containing the=
 data,
> + * if unable to obtain direct pointer)
>   */
>  __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u3=
2 offset,
>                                    void *buffer__opt, u32 buffer__szk)
> @@ -2354,10 +2354,10 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct b=
pf_dynptr_kern *ptr, u32 offset
>   * bpf_dynptr_slice_rdwr will not invalidate any ctx->data/data_end poin=
ters in
>   * the bpf program.
>   *
> - * Return: NULL if the call failed (eg invalid dynptr), pointer to a
> - * data slice (can be either direct pointer to the data or a pointer to =
the user
> - * provided buffer, with its contents containing the data, if unable to =
obtain
> - * direct pointer)
> + * Return: NULL or error pointer if the call failed (eg invalid dynptr),=
 pointer
> + * to a data slice (can be either direct pointer to the data or a pointe=
r to the
> + * user provided buffer, with its contents containing the data, if unabl=
e to
> + * obtain direct pointer)
>   */
>  __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *pt=
r, u32 offset,
>                                         void *buffer__opt, u32 buffer__sz=
k)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index df697c74d519..2626706b6387 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1378,6 +1378,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct b=
pf_dynptr_kern *data_ptr,
>                                struct bpf_dynptr_kern *sig_ptr,
>                                struct bpf_key *trusted_keyring)
>  {
> +       void *data, *sig;
>         int ret;
>
>         if (trusted_keyring->has_ref) {
> @@ -1394,10 +1395,16 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct=
 bpf_dynptr_kern *data_ptr,
>                         return ret;
>         }
>
> -       return verify_pkcs7_signature(data_ptr->data,
> -                                     __bpf_dynptr_size(data_ptr),
> -                                     sig_ptr->data,
> -                                     __bpf_dynptr_size(sig_ptr),
> +       data =3D bpf_dynptr_slice(data_ptr, 0, NULL, 0);
> +       if (IS_ERR(data))
> +               return PTR_ERR(data);
> +
> +       sig =3D bpf_dynptr_slice(sig_ptr, 0, NULL, 0);
> +       if (IS_ERR(sig))
> +               return PTR_ERR(sig);
> +
> +       return verify_pkcs7_signature(data, __bpf_dynptr_size(data_ptr),
> +                                     sig, __bpf_dynptr_size(sig_ptr),
>                                       trusted_keyring->key,
>                                       VERIFYING_UNSPECIFIED_SIGNATURE, NU=
LL,
>                                       NULL);
> --
> 2.34.1
>

