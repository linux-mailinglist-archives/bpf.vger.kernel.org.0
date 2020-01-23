Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A7014725F
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 21:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAWUHE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 15:07:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44925 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgAWUHE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 15:07:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id w8so3475059qts.11;
        Thu, 23 Jan 2020 12:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpS8SNmX9i1WKyCuqTNSk92t9OSwIsxjQWYeVC963ns=;
        b=reOOCz/iEMCRfrK6f3Qh2y4cWrG3wG5z1scR2wWmlL9XTCqpKz3OOtUwLG6q+mh2q1
         geiNGfk/ycRwsXOPm0sz9xIwM5/oshWd9Q/3+YgDVqKm1s5ORBLeHrn/zxwgy9XkB69C
         +tmGx+RjODrgMZF7aB0yzccf9EY+kDW6J1L5djLIUXyQkoyMHDEpOrG8Ckg7+z2KDP7w
         XEiP3f6VY/C7RayEM0C2XtXMhssIQYk7cusr2ewST7YwyPELv220I2otF/J/5sM8SoZo
         gpwM1WfuSYNH1sPW8UNQnhul6Ik4scRLxZECPJt5HZ2NDLCX/srtmw9RdDQhaowUnqoq
         ws+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpS8SNmX9i1WKyCuqTNSk92t9OSwIsxjQWYeVC963ns=;
        b=Fopx9y3iPeyGNMwMJ/jq8It8sIVVEIcUN6uKzXm0eTaMs9B1GlwW1jmzXRH5RtWdEQ
         0YiVcs+ZZJOEjDmNZ74B6iqQKErS2a+90w8E5s80fo3cylyhCaEZ3eIssAaCGjPD+yUk
         61KLQNxBmzprWJvF5SuOmqw6dtm7hMw0zjtvnR1y+DLFQVWeX6hXHZ7c3s1+HzTuE54/
         sToxbdl5lFCOA+CPleUmIS2CAiHoM1Pjbd9AJpvthjDFeNAhbDTEEZY9sjyW5xNHIlcL
         rHGKwOMoDY/+IpwGiYRBMVXe7JsN8bw+PyfKnKW+FA8q6KkYftY0QAXlSUfu/+EYHpLv
         k8AA==
X-Gm-Message-State: APjAAAUFkYMJaD7i8WIMuKuyNNA2fZhDorgQtiBtIV4A+zTFEhGkLbUa
        /doubPbeGy9EujkZtt5EUbjLgCsDJLKdD3+J4lE=
X-Google-Smtp-Source: APXvYqxUAU1Dzpe4sekFIwJerqWcBXSxsB4ohvhBCArOKrV8UaCBhMNs2trwSrWlOruAu9t7zoLAbsvs8+aMEOco4u4=
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr17456358qtu.141.1579810023325;
 Thu, 23 Jan 2020 12:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-2-kpsingh@chromium.org>
In-Reply-To: <20200123152440.28956-2-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Jan 2020 12:06:51 -0800
Message-ID: <CAEf4BzbBAM1+E3j6pBaLjBwnvOVKV=oWrnANONEm8SCoGj=ZbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/10] bpf: btf: Add btf_type_by_name_kind
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 23, 2020 at 7:25 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> - The LSM code does the combination of btf_find_by_name_kind and
>   btf_type_by_id a couple of times to figure out the BTF type for
>   security_hook_heads and security_list_options.
> - Add an extern for btf_vmlinux in btf.h
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> ---
>  include/linux/btf.h |  3 +++
>  kernel/bpf/btf.c    | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 5c1ea99b480f..d4e859f90a39 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -15,6 +15,7 @@ struct btf_type;
>  union bpf_attr;
>
>  extern const struct file_operations btf_fops;
> +extern struct btf *btf_vmlinux;
>
>  void btf_put(struct btf *btf);
>  int btf_new_fd(const union bpf_attr *attr);
> @@ -66,6 +67,8 @@ const struct btf_type *
>  btf_resolve_size(const struct btf *btf, const struct btf_type *type,
>                  u32 *type_size, const struct btf_type **elem_type,
>                  u32 *total_nelems);
> +const struct btf_type *btf_type_by_name_kind(
> +       struct btf *btf, const char *name, u8 kind);
>
>  #define for_each_member(i, struct_type, member)                        \
>         for (i = 0, member = btf_type_member(struct_type);      \
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 32963b6d5a9c..ea53c16802cb 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -441,6 +441,18 @@ const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
>         return NULL;
>  }
>
> +const struct btf_type *btf_type_by_name_kind(
> +       struct btf *btf, const char *name, u8 kind)
> +{
> +       s32 type_id;
> +
> +       type_id = btf_find_by_name_kind(btf, name, kind);
> +       if (type_id < 0)
> +               return ERR_PTR(type_id);
> +
> +       return btf_type_by_id(btf, type_id);
> +}
> +

is it worth having this as a separate global function? If
btf_find_by_name_kind returns valid ID, then you don't really need to
check btf_type_by_id result, it is always going to be valid. So the
pattern becomes:

type_id = btf_find_by_name_kind(btf, name, kind);
if (type_id < 0)
  goto handle_error;
t = btf_type_by_id(btf, type_id);
/* now just use t */

which is not much more verbose than:

t = btf_type_by_name_kind(btf, name, kind);
if (IS_ERR(t))
  goto handle_error
/* now use t */


>  /* Types that act only as a source, not sink or intermediate
>   * type when resolving.
>   */
> --
> 2.20.1
>
