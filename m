Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E7017A691
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 14:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgCENl7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 08:41:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36062 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgCENl7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 08:41:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id t24so5993062oij.3;
        Thu, 05 Mar 2020 05:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eg8qOXXxTZFH+avf9eVy3dxxHHbyWn0g+mO5XgLQ+LM=;
        b=FmtSTEvH4JMkzvU0rV87l8dSnNd84J4k4OZljnkIKeA+JdbhSP2k3UYVQHAj/RdzZo
         3X0XIgdmwfssLPelrx2aDyIQUJYesIXKOkcKZNCtmXlc89vmsPXqkm+yQXN3ygynVjbx
         kA/QSQ/XlzuAL3x3oTPFD5Kkb7hT2/DZcQumspk3pMO31H0x5RSlrPF2krNULhOMuRRs
         7gHmKFAPVWUPnfWSCSlJLvyV4AYkbm+vUQVwHSMiCzuwiIG2lHJFWjrz/R6fMGO+g2PT
         JIXFfICm6nMqSzkHWrXGgBrbUtNWAFrx7Ld2iLBooTpGfVfsdKb0XRNnsuhaqmnGm5Wr
         r19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eg8qOXXxTZFH+avf9eVy3dxxHHbyWn0g+mO5XgLQ+LM=;
        b=C91yfvNHiKvlUR5jUaZAWKFMaW/lhjwACwHYsQwIhpTgpa8BRH3fD3pPRZD4Ph6Cg5
         2Ri+7b+2dal7Vm6CD/h2Z51HdfPnVgDfAn80eELCu14/ErlK9GtiUObqYFP4ojagSax2
         /4BV8sEVV+vpCYpB8giSYQ3BDJ0oUuwBjoGnXel3uKi/p20o0UsjB6emfnyN7Sn9ZFVU
         mgenznFSeoyHv7zG184cQ8rNbLN0RgAGFh30nxzPVeLd4+zEdgNHk7cpzMWxgZK+mShy
         w/UshD8Fy9ebxxSrKG+UNNLOUaOqac+ymGlqm4xFcee6v/Khe58JDexTNwiFoYsWur0u
         auaw==
X-Gm-Message-State: ANhLgQ3p3X7aZDuDXP7Hns2onQMMAOkuxvi/KmehvXO+C49nSsjykGaj
        Q3eCh4NoIo7aIufiNudLCSyN9INXDJPkiJFpBYI=
X-Google-Smtp-Source: ADFU+vvtxT5hJ8HqcW7oErtibqc8cObhOkR6SqqTz7pQJCUcRgKfjJTnBK7VFvyHTTwWd+9UuWVXYTEiLpwYZAjhOD4=
X-Received: by 2002:aca:3544:: with SMTP id c65mr5466604oia.160.1583415718336;
 Thu, 05 Mar 2020 05:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20200304191853.1529-1-kpsingh@chromium.org> <20200304191853.1529-5-kpsingh@chromium.org>
In-Reply-To: <20200304191853.1529-5-kpsingh@chromium.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 5 Mar 2020 08:43:11 -0500
Message-ID: <CAEjxPJ4G4sp5_zHXxhe+crafNGV-oZZZ2YYbbMb61BZx0F_ujw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/7] bpf: Attachment verification for BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>, jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 4, 2020 at 2:20 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> - Allow BPF_MODIFY_RETURN attachment only to functions that are:
>
>     * Whitelisted for error injection by checking
>       within_error_injection_list. Similar discussions happened for the
>       bpf_override_return helper.
>
>     * security hooks, this is expected to be cleaned up with the LSM
>       changes after the KRSI patches introduce the LSM_HOOK macro:
>
>         https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/
>
> - The attachment is currently limited to functions that return an int.
>   This can be extended later other types (e.g. PTR).
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> ---
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2460c8e6b5be..ae32517d4ccd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
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

CAP_MAC_ADMIN was originally introduced for Smack and is not
all-powerful wrt SELinux, so this is not a sufficient check for
SELinux.
We would want an actual security hook called here so we can implement
a specific check over userspace
being able to attach BPF progs to LSM hooks.  CAP_MAC_ADMIN has other
connotations to SELinux (presently the
ability to set/get file security labels that are not known to the
currently loaded policy).
