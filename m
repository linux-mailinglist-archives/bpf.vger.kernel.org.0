Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF851785D5
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgCCWon (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:44:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35194 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCCWon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:44:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id v15so1402932qto.2;
        Tue, 03 Mar 2020 14:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7vELyfRZRbHG3aDEADGwy5iA7Rma4R/72cE2T/sDjY=;
        b=o55c9uGqZ8X9KdJ6sWYnVIQAPXvMWRNksuInDSh3XkpInKt6lIpeilgVtP53303Gbg
         GYnLHmf/O3RfuerS7/mLPZA5kpY43qNZ1nT1IkY8+IrMsGku5fKskk63DgPIJqiSQ00m
         5dHfOoVi5QxeX2Cov5z7NxUIkvE7SZsUaAN6TR9+Ub2S9izk7D579CEzEsckpANZShdv
         gXw8WT/dcnboeAV0fOUYa68n3cQ2akA537wJC6AbCq47ojSEBTHjDFGKKjyT3q5NjdAH
         jBrswacxSgMoWa2zn63dlWtGiY0FmMBWsBlt74EP+diLqU+cjHikpCrVtlG9l2rilI8j
         fwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7vELyfRZRbHG3aDEADGwy5iA7Rma4R/72cE2T/sDjY=;
        b=RkECOmJadejJL2NpoISP+XsWtMok8+Li5AK4P1MksQBe7fzTQHF3d6xBsuxTcezA/K
         a2X6XtiyogWJRNFymFgAzu+Gssso4sckoD8ViG9gLm03LTOH5yKqyrvoxnLqfXy5GAmz
         r/qYY7nPgPaFNwi7Dg4WY+yl0ddqeiyCwozbwbANDAeYmPw/z5+XFqwNemr+RF05w4MB
         RFZadTuoj4Cpp5JQSXjaDu337Bpznh6bHjBp+JJEVjYDWMgaPx5hQ/ouQS6Xjqx9OFJk
         /RFzNngWOF3HBIsoNxtF7OoyWlglH24eLKFALNHrCqEd5wylUPmdQ0hCIj1ZLZ9DPlv6
         wV8A==
X-Gm-Message-State: ANhLgQ3zpI+z0xyrsBMn60vj5ynQE8L/r9lSUD49RxgpTwkRHEMQ82cM
        SNphyp/2Nx3kbl7oiB9/TuDGDpMxwww4dRSi7eQ=
X-Google-Smtp-Source: ADFU+vtwSXV5BLr/eV6O+BnrFc85DTqoJ6GiHaCnPdNwEzhIsxTFdfGqT2v00YELazzYuDyR1XzbjKrDozEWCdlaRig=
X-Received: by 2002:ac8:530e:: with SMTP id t14mr6455605qtn.141.1583275481959;
 Tue, 03 Mar 2020 14:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20200303140950.6355-1-kpsingh@chromium.org> <20200303140950.6355-5-kpsingh@chromium.org>
In-Reply-To: <20200303140950.6355-5-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 14:44:31 -0800
Message-ID: <CAEf4BzaviDB+WGUsg1+aO5GAtkJuQ6aYSiB8VaKL0CoQRPs8Xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] bpf: Attachment verification for BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> - Functions that are whitlisted by for error injection i.e.
>   within_error_injection_list.
> - Security hooks, this is expected to be cleaned up after the KRSI
>   patches introduce the LSM_HOOK macro:
>
>     https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/

Commit message can use a bit more work for sure. Why (and even what)
of the changes is not really explained well.

>
> - The attachment is currently limited to functions that return an int.
>   This can be extended later other types (e.g. PTR).
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  kernel/bpf/btf.c      | 28 ++++++++++++++++++++--------
>  kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 30841fb8b3c0..50080add2ab9 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3710,14 +3710,26 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>                 nr_args--;
>         }
>
> -       if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
> -            prog->expected_attach_type == BPF_MODIFY_RETURN) &&
> -           arg == nr_args) {
> -               if (!t)
> -                       /* Default prog with 5 args. 6th arg is retval. */
> -                       return true;
> -               /* function return type */
> -               t = btf_type_by_id(btf, t->type);
> +       if (arg == nr_args) {
> +               if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
> +                       if (!t)
> +                               return true;
> +                       t = btf_type_by_id(btf, t->type);
> +               } else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
> +                       /* For now the BPF_MODIFY_RETURN can only be attached to
> +                        * functions that return an int.
> +                        */
> +                       if (!t)
> +                               return false;
> +
> +                       t = btf_type_skip_modifiers(btf, t->type, NULL);
> +                       if (!btf_type_is_int(t)) {

Should the size of int be verified here? E.g., if some function
returns u8, is that ok for BPF program to return, say, (1<<30) ?

> +                               bpf_log(log,
> +                                       "ret type %s not allowed for fmod_ret\n",
> +                                       btf_kind_str[BTF_INFO_KIND(t->info)]);
> +                               return false;
> +                       }
> +               }
>         } else if (arg >= nr_args) {
>                 bpf_log(log, "func '%s' doesn't have %d-th argument\n",
>                         tname, arg + 1);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2460c8e6b5be..ae32517d4ccd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19,6 +19,7 @@
>  #include <linux/sort.h>
>  #include <linux/perf_event.h>
>  #include <linux/ctype.h>
> +#include <linux/error-injection.h>
>
>  #include "disasm.h"
>
> @@ -9800,6 +9801,33 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>
>         return 0;
>  }
> +#define SECURITY_PREFIX "security_"
> +
> +static int check_attach_modify_return(struct bpf_verifier_env *env)
> +{
> +       struct bpf_prog *prog = env->prog;
> +       unsigned long addr = (unsigned long) prog->aux->trampoline->func.addr;
> +
> +       if (within_error_injection_list(addr))
> +               return 0;
> +
> +       /* This is expected to be cleaned up in the future with the KRSI effort
> +        * introducing the LSM_HOOK macro for cleaning up lsm_hooks.h.
> +        */
> +       if (!strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
> +                    sizeof(SECURITY_PREFIX) - 1)) {
> +
> +               if (!capable(CAP_MAC_ADMIN))
> +                       return -EPERM;
> +
> +               return 0;
> +       }
> +
> +       verbose(env, "fmod_ret attach_btf_id %u (%s) is not modifiable\n",
> +               prog->aux->attach_btf_id, prog->aux->attach_func_name);
> +
> +       return -EINVAL;
> +}
>
>  static int check_attach_btf_id(struct bpf_verifier_env *env)
>  {
> @@ -10000,6 +10028,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>                 }
>                 tr->func.addr = (void *)addr;
>                 prog->aux->trampoline = tr;
> +
> +               if (prog->expected_attach_type == BPF_MODIFY_RETURN)
> +                       ret = check_attach_modify_return(env);
>  out:
>                 mutex_unlock(&tr->mutex);
>                 if (ret)
> --
> 2.20.1
>
