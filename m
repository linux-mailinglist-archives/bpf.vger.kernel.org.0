Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C75508EDD
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378253AbiDTRw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiDTRw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 13:52:28 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC9446668
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:49:41 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e194so2648803iof.11
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMdgLGLBzU6uHTp6bo1bE5AYY82CQiqsSnwEwshmd20=;
        b=qfvajyR4xdG42otZGIcpfGRR07luv8aX+Ri3IRvGWSqKQyzulVXGiM/nGtryL2cIxA
         1X4AsSDnZoBkeaeqEMkykpkrMdSVD2IL+TFcmkr+m9Q0adOtthdW8TgXI2NRtSR633em
         O0aFb5k76zsp8+nR5qH8CSMXJZdKBGew3T+v96+Zb+8p/JeXE96vQu/Qx2RkBQOGtqW+
         +r3auWcUpwSi1Jbx6m3xYWoAjNQOopGq1sOiFWcGLD7o/EeDAsufjhmDvwq5lt96jTRa
         x87RqyS2Plpwt3J7NL3ooywdsEZYUZs7H3nci4olTC5shVCf/jalFuaAfFue9XtVYqYS
         /IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMdgLGLBzU6uHTp6bo1bE5AYY82CQiqsSnwEwshmd20=;
        b=SA+/PMdZIW5jL5odx1iJ5RqW+9R93Hui3zpur5XYaPA9uV5UKu0pmJZHLBwGnXehCa
         XjNjmlV5N+r1Y1h7Kd7nfg+ps0+Tdqmv/JJuulL979RDaG4EBAnVTfo0gprCJK7eHs+n
         A/LXCdo85FspVLpJpO++qZA6PVlYwtQI4OU9+R8NXcWmSDd2ZJ/z4V4v+ojVd2sov194
         /i1ZARDiOtd7WsgtDTJYFxxXsNNoJCJXYla8JtNUdXAmf+70cg/tdUOITnJSkXsCAeXB
         RIq1LCcHyJ57uZbT6hVwGWVcSCD5hYC1jhmN5rUVX7LzF9DORJXJ1RyaMQi5pSSVaCa2
         +HoA==
X-Gm-Message-State: AOAM5318WOaosJa6YFTTXMGMs/nkg+/0rboVAiV60Q0XrYKyTmf/bxYy
        /OpaN0brK4MW7um3CJoW2j8kP7AyBmDLkezMLITck7wqs1Y=
X-Google-Smtp-Source: ABdhPJwR7K2HKVjcANhUFZ82LIkVUna3fz503Fs2ZZnP6qv861w35k+K9NtjL63y+7t+jyIXOZmtToaB9/0VU6uDlQE=
X-Received: by 2002:a05:6602:3787:b0:654:9cab:b681 with SMTP id
 be7-20020a056602378700b006549cabb681mr6678923iob.154.1650476981057; Wed, 20
 Apr 2022 10:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220416042940.656344-1-kuifeng@fb.com> <20220416042940.656344-5-kuifeng@fb.com>
In-Reply-To: <20220416042940.656344-5-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 10:49:29 -0700
Message-ID: <CAEf4Bzbi-k54JFfYA2-GA6-YcpquFegPms5r+iMH-03C4EauuQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v6 4/6] bpf: Create fentry/fexit/fmod_ret links
 through BPF_LINK_CREATE
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 9:30 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Make fentry/fexit/fmod_ret as valid attach-types for BPF_LINK_CREATE.
> Pass a cookie along with BPF_LINK_CREATE requests.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

I think logically this patch should be #3 and current patch #3 adding
cookie to UAPI should go after this. So it would make sense to swap
them.

>  include/uapi/linux/bpf.h       | 7 +++++++
>  kernel/bpf/syscall.c           | 9 +++++++++
>  tools/include/uapi/linux/bpf.h | 7 +++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a4f557338af7..780be5a8ae39 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1490,6 +1490,13 @@ union bpf_attr {
>                                 __aligned_u64   addrs;
>                                 __aligned_u64   cookies;
>                         } kprobe_multi;
> +                       struct {
> +                               /* black box user-provided value passed through
> +                                * to BPF program at the execution time and
> +                                * accessible through bpf_get_attach_cookie() BPF helper
> +                                */
> +                               __u64           cookie;
> +                       } tracing;
>                 };
>         } link_create;
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 966f2d40ae55..ca14b0a2e222 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3189,6 +3189,10 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
>                 return BPF_PROG_TYPE_SK_LOOKUP;
>         case BPF_XDP:
>                 return BPF_PROG_TYPE_XDP;
> +       case BPF_TRACE_FENTRY:
> +       case BPF_TRACE_FEXIT:
> +       case BPF_MODIFY_RETURN:
> +               return BPF_PROG_TYPE_TRACING;

seems like

       case BPF_LSM_MAC:
               return BPF_PROG_TYPE_LSM;

is missing?


Looking at my experiment for cleaning up RAW_TRACEPOINT_OPEN and
LINK_CREATE, I think I also got rid of tracing_bpf_link_attach()
altogether and there was extra case for BPF_PROG_TYPE_EXT.

How about this. Given I have an almost ready kernel code and I'd like
libbpf to use LINK_CREATE if possible in all cases, let me add the
feature-probing on libbpf side and post it as a separate small patch
set that you can base your cookie-specific changes on top. That will
let you concentrate on BPF cookie side and I'll handle the libbpf
intricacies that are not directly related to your changes?

I'll try to post patches today or tomorrow, so it should not delay you much.


>         default:
>                 return BPF_PROG_TYPE_UNSPEC;
>         }
> @@ -4254,6 +4258,11 @@ static int tracing_bpf_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
>                                                attr->link_create.target_fd,
>                                                attr->link_create.target_btf_id,
>                                                0);
> +       else if (prog->type == BPF_PROG_TYPE_TRACING)
> +               return bpf_tracing_prog_attach(prog,
> +                                              0,
> +                                              0,
> +                                              attr->link_create.tracing.cookie);
>
>         return -EINVAL;
>  }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index a4f557338af7..780be5a8ae39 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1490,6 +1490,13 @@ union bpf_attr {
>                                 __aligned_u64   addrs;
>                                 __aligned_u64   cookies;
>                         } kprobe_multi;
> +                       struct {
> +                               /* black box user-provided value passed through
> +                                * to BPF program at the execution time and
> +                                * accessible through bpf_get_attach_cookie() BPF helper
> +                                */
> +                               __u64           cookie;
> +                       } tracing;
>                 };
>         } link_create;
>
> --
> 2.30.2
>
