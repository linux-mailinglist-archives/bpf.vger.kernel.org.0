Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD1F1789D5
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 06:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgCDFI5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 00:08:57 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38775 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgCDFI5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 00:08:57 -0500
Received: by mail-qk1-f196.google.com with SMTP id j7so183483qkd.5;
        Tue, 03 Mar 2020 21:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFBkP1RFFEIdcOgG68lfqjQkubJEyOh3u9uzQFg3PXI=;
        b=lhx+42/1YZ+owNuaccXqmeSdz8aF+t0mFBcSs1OBejc/ZSZ2J1sKt7uPbtsVOxsdXz
         b6zvtL+xRY4s3P3v7SZ4gcNAnU7/BI8kc9Lu2pffyiu9Q3yBNnjN82/YFdUJY+XorFm6
         nN62BbPq6DX3Hw+DU94GZSOLoSQCjvNkA3zGBKYQCaKaQrq+yz7xfRFoJbicYeUWCf6X
         G9S+dQPx/06Y7cJa/4zpPkUATPfKewHMHVjUIOCYAp6bb+dgsBbWf0t00XhBM6hP1EWH
         rmhtc8Xg7dcar/hERqAFDIqh+FlOCveYxLCZrWwuJwdSVmOqYtnEz5SBHgS4DP7AW6zr
         ocOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFBkP1RFFEIdcOgG68lfqjQkubJEyOh3u9uzQFg3PXI=;
        b=RGbCYkureHwrNyPntr7OVYhDI7Yk6/8WPBBqhrS62Zd/hV86ot9jnXjjcC++mWQP99
         Wj/2HbVAl0swiD+quc/ZMJ2E2m68JYoPNi7JjuPptKBjJ/m/je7KLcZZg0x6/IfFa/fV
         UJsNoYnW47qmwRmy76Egh2GQ8safKKLg0zvzvw91qiK1YvULiQzjgzo1zJep/Jt+ez8x
         9qe3TTVdosPy2ILFJTu2ZqCKUqAWWeD3D86v6zRAAbq9V4PbOIPGZ476Ympo0YTPnhqC
         lpQ8MoXkcBRMWA21/HUlh6H5Kq9L5+YPQ40LJnLbzAjBEKdqizXzP+ib3YU0IYxx700X
         eQlw==
X-Gm-Message-State: ANhLgQ2ybZydNlQtOyqlyjU0DnCHoM2/W3FzbcVZyN5Deh5b/Lnb0CJb
        6A5Kb1bI8LDLEuDGjaS0nk0gwCmHYSOOQ3MlzGo=
X-Google-Smtp-Source: ADFU+vtnpgo0x+Xbv4iN2D727XNRhH4imzc4Yl8wJSXCkknuXaeEnDGwns7S9VOyl/j/G2rnZ7TnBn0ONavCKWeqaQA=
X-Received: by 2002:a37:a2d6:: with SMTP id l205mr1369810qke.92.1583298536494;
 Tue, 03 Mar 2020 21:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20200304015528.29661-1-kpsingh@chromium.org> <20200304015528.29661-4-kpsingh@chromium.org>
In-Reply-To: <20200304015528.29661-4-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 21:08:45 -0800
Message-ID: <CAEf4BzbbaiLC+-Gytwcx=i0XTniNH6YNsfOfx3nrU1oo73VsKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Introduce BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> When multiple programs are attached, each program receives the return
> value from the previous program on the stack and the last program
> provides the return value to the attached function.
>
> The fmod_ret bpf programs are run after the fentry programs and before
> the fexit programs. The original function is only called if all the
> fmod_ret programs return 0 to avoid any unintended side-effects. The
> success value, i.e. 0 is not currently configurable but can be made so
> where user-space can specify it at load time.
>
> For example:
>
> int func_to_be_attached(int a, int b)
> {  <--- do_fentry
>
> do_fmod_ret:
>    <update ret by calling fmod_ret>
>    if (ret != 0)
>         goto do_fexit;
>
> original_function:
>
>     <side_effects_happen_here>
>
> }  <--- do_fexit
>
> The fmod_ret program attached to this function can be defined as:
>
> SEC("fmod_ret/func_to_be_attached")
> int BPF_PROG(func_name, int a, int b, int ret)
> {
>         // This will skip the original function logic.
>         return 1;
> }
>
> The first fmod_ret program is passed 0 in its return argument.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  arch/x86/net/bpf_jit_comp.c    | 130 ++++++++++++++++++++++++++++++---
>  include/linux/bpf.h            |   1 +
>  include/uapi/linux/bpf.h       |   1 +
>  kernel/bpf/btf.c               |   3 +-
>  kernel/bpf/syscall.c           |   1 +
>  kernel/bpf/trampoline.c        |   5 +-
>  kernel/bpf/verifier.c          |   1 +
>  tools/include/uapi/linux/bpf.h |   1 +
>  8 files changed, 130 insertions(+), 13 deletions(-)
>

This looks good, but I'll Alexei check all the assembly generation
logic, not too big of an expert on that.

[...]


>  static int emit_fallback_jump(u8 **pprog)
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 98ec10b23dbb..3cfdc216a2f4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -473,6 +473,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
>
>  enum bpf_tramp_prog_type {
>         BPF_TRAMP_FENTRY,
> +       BPF_TRAMP_MODIFY_RETURN,

This is probably bad idea to re-number BPF_TRAMP_FEXIT for no good
reason. E.g., if there are some drgn scripts that do some internal
state printing, this is major inconvenience, while really providing no
benefit in itself. Consider putting it right before BPF_TRAMP_MAX.

>         BPF_TRAMP_FEXIT,
>         BPF_TRAMP_MAX,
>         BPF_TRAMP_REPLACE, /* more than MAX */

[...]
