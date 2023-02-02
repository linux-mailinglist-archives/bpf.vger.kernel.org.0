Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6685E688AAD
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 00:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjBBXWM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 18:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjBBXWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 18:22:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116DB126E5;
        Thu,  2 Feb 2023 15:22:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so10667865ejc.4;
        Thu, 02 Feb 2023 15:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rviDfZJ7YTKUN9q8tTacj2WhJV16nqhHvC9JQz3qi+g=;
        b=jeztccfQkFixWpHultZ5E3L1dS1BBvb7dmM6vVqKGRwFu5p6zPIgfi37zoscrLgJc2
         2QYd2mcFQBhQirltUiPTGdpgVM9YzwlszJ0YRcNtrhG5NSuK/VG+WQ/The2A7ftF6K+U
         omfkudfwDQPD7y16tcRV3w/DixaNgaS/dZmsMkmRcJttOGer+TnoJDZMUhRvk2jrUj4z
         hN8zAc2V+ZB1RWEn7fa76YcqO/dDYBAw2kEFvx59cKBOB8oc/d4Qt1SCD8mQKmpAKyAS
         ab/LYlQedf5dnbPPkq6sWdDLv9Z7O1ocExnaVyvnmIIMWpt7MMlhCSSZrRpXi8OvJbFD
         6r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rviDfZJ7YTKUN9q8tTacj2WhJV16nqhHvC9JQz3qi+g=;
        b=IJto6vw5YuKnY4ubg/Oue5xnGTR9n1MM+y4rhDWsR/5GWf+x1dKBsROpEKL9zTwcGR
         iIHS/3WB/u3Z+ke944A/zAugHHskd6corWLaa0wDIDpHcDVZ5bPg6Z87X59Qc+kiRL+R
         /cl1fqCMBC8Noya5i/i0VpzCWe0PC8M5xomBIdpRS0C7agnzG//6Zp8JF8FPU/YMzkFe
         0xrqrnS75jh5jUr2Koz81XWDvCYK/u9+rTbGAiOConGoOVSvg+f2Zf6wEJZreiLbE0zQ
         je/zxHv33OiVfZ9OPCObgpjKx4vnxnA4ehDMKIhhWPgoTQtMZKm9EfsHX4TCgDv3CJp8
         1lBQ==
X-Gm-Message-State: AO0yUKUwRShMuj2St1QizDLHV/ESbJ2ktch8G6V2PmJT1AuHYfSXZt1A
        BDvSJCNJ5ZivrQVsb/HqgBdM6GCma3aZ8aqOP6LKhLlUp6UOlA==
X-Google-Smtp-Source: AK7set96QfcBQXvc7CVlQ70GDj/JNplSQOfRXrzPIcgKokFiT19PtLnTOFh3kYQr+ojU5dqTPTRBUKWVxf/II3Q8okY=
X-Received: by 2002:a17:906:fc20:b0:86e:429b:6a20 with SMTP id
 ov32-20020a170906fc2000b0086e429b6a20mr2365718ejb.247.1675380128441; Thu, 02
 Feb 2023 15:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20230202163056.658641-1-void@manifault.com> <20230202163056.658641-3-void@manifault.com>
 <CAADnVQJjmnEpXWL8-SAPt5zYXnFYeF8-wXXpA9shOhqUXNPw=g@mail.gmail.com>
 <Y9wq1Fy8sgpGB+pe@maniforge> <1ea9adb3-851c-0c04-1655-07d9f3b7f3b0@iogearbox.net>
In-Reply-To: <1ea9adb3-851c-0c04-1655-07d9f3b7f3b0@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Feb 2023 15:21:40 -0800
Message-ID: <CAADnVQJeaU=F9uym9RctfODHbeV-TTK8DiQFTFm_R=N+qF6gYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add KF_DEPRECATED kfunc flag
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
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

On Thu, Feb 2, 2023 at 3:11 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 2/2/23 10:27 PM, David Vernet wrote:
> > On Thu, Feb 02, 2023 at 01:21:19PM -0800, Alexei Starovoitov wrote:
> >> On Thu, Feb 2, 2023 at 8:31 AM David Vernet <void@manifault.com> wrote:
> >>>
> >>> Now that we have our kfunc lifecycle expectations clearly documented,
> >>> and that KF_DEPRECATED is documented as an optional method for kfunc
> >>> developers and maintainers to provide a deprecation story to BPF users,
> >>> we need to actually implement the flag.
> >>>
> >>> This patch adds KF_DEPRECATED, and updates the verifier to issue a
> >>> verifier log message if a deprecated kfunc is called. Currently, a BPF
> >>> program either has to fail to verify, or be loaded with log level 2 in
> >>> order to see the message. We could eventually enhance this to always
> >>> be logged regardless of log level or verification status, or we could
> >>> instead emit a warning to dmesg. This seems like the least controversial
> >>> option for now.
> >>>
> >>> A subsequent patch will add a selftest that verifies this behavior.
> >>>
> >>> Signed-off-by: David Vernet <void@manifault.com>
> >>> ---
> >>>   include/linux/btf.h   | 1 +
> >>>   kernel/bpf/verifier.c | 8 ++++++++
> >>>   2 files changed, 9 insertions(+)
> >>>
> >>> diff --git a/include/linux/btf.h b/include/linux/btf.h
> >>> index 49e0fe6d8274..a0ea788ee9b0 100644
> >>> --- a/include/linux/btf.h
> >>> +++ b/include/linux/btf.h
> >>> @@ -71,6 +71,7 @@
> >>>   #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
> >>>   #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
> >>>   #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
> >>> +#define KF_DEPRECATED   (1 << 8) /* kfunc is slated to be removed or deprecated */
> >>>
> >>>   /*
> >>>    * Tag marking a kernel function as a kfunc. This is meant to minimize the
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index 4cc0e70ee71e..22adcf24f9e1 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -8511,6 +8511,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
> >>>          return meta->kfunc_flags & KF_RCU;
> >>>   }
> >>>
> >>> +static bool is_kfunc_deprecated(const struct bpf_kfunc_call_arg_meta *meta)
> >>> +{
> >>> +       return meta->kfunc_flags & KF_DEPRECATED;
> >>> +}
> >>> +
> >>>   static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
> >>>   {
> >>>          return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
> >>> @@ -9646,6 +9651,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >>>                          mark_btf_func_reg_size(env, regno, t->size);
> >>>          }
> >>>
> >>> +       if (is_kfunc_deprecated(&meta))
> >>> +               verbose(env, "calling deprecated kfunc %s\n", func_name);
> >>> +
> >>
> >> Since prog will successfully load, no one will notice this message.
> >>
> >> I think we can skip patches 2 and 3 for now.
>
> +1, the KF_DEPRECATED could probably for the time being just mentioned
> in doc.
>
> > I can leave them out of the v2 version of the patch set, but the reason
> > I included them here is because I thought it would be odd to document
> > KF_DEPRECATED without actually upstreaming it. Agreed that it is
> > essentially 0 signal in its current form. Hopefully it could be expanded
> > soon to be louder and more noticeable by not relying on the env log,
> > which is wiped if the verifier passes, but that's separate from whether
> > KF_DEPRECATED in general is the API that we want to provide kfunc
> > developers (in which case at least 2 and 3 would add that in a
> > non-controversial form).
>
> This ideally needs some form of prog load flag which would error upon
> use of kfuncs with deprecation tag, such that tools probing kernel for
> feature availability can notice.

Interesting idea.
By default we can reject loading progs that try to use KF_DEPRECATED,
but still allow it with explicit load flag.
