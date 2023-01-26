Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D154067C2EA
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 03:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjAZCsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 21:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjAZCsX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 21:48:23 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BD064685
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 18:48:22 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vw16so1651347ejc.12
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 18:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GuQ8faoWy7oZ+nat6D7YCV0vd7EDEMYhcz6BZfNuwW4=;
        b=Ab/scE++SdJeCExMbzkiIfXW9drLvMeILDK/rCJLy9OWo3NOxqCSkb6i7JxkJylEMk
         x2sVEE9ydSK03TdzVP8ekGPs5zi9N9D+AcmYKeLBImn6Gh+HFxxvHuHsBNWI5C2XVjbW
         NYeR5k26GQJf0DdpBb/AoWC/lOZYQanOWBrVa+10xjxcSGXh/WLK5MWO80qYMYUeb6/a
         he7u7WSnHsPGoHa6E/nz7HKI5jF+eRCbD7woWl0wFiz4Ngr+kFlZ1PWpQZe3M+T8QJsZ
         x/g0hfBFztr7+0iKWXdJcmSNUIqVdVSdxkHhaqnwFTwKiGXGKXO3wYUAf8T/e60RmlUT
         9/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuQ8faoWy7oZ+nat6D7YCV0vd7EDEMYhcz6BZfNuwW4=;
        b=Evwjz7Ab97ziynMsK+l3996IYecm+gi101xTjoy6wE+0+WOhke+haRH1WR3S3JB9Cf
         0GaLwjJ0PRQ9vMQP52GBTRQyeN56VwCCrmB8dyfFKYjRKFOFDcXSNmzR1NDYn6+nq7p9
         TUoR0XKxbK7tDpLXqdwAoyoKv49njjY+pubTviGbF4Qyv6BdhUSPXCA0W3lVtFIgHvhh
         8jHSZyCzRSdXoOFk3ZFFJcPNNrqTMGcakSXu3rSJLJQrlyw7qWIL77S23+Y9LAbEVX8w
         a6Bmdht/TAr28k2gFDWvJAKQ3c99q3lIYjyG2dPcsFhj91OdAEtXh+CjD7Sl+CXv20uL
         Ga2w==
X-Gm-Message-State: AFqh2kqyZNvHtp7BYH98A61byW4hYK2omSNrJ29bPh6F4NjQLP9t16ma
        XysT0sF+aSAiX5DDOrkauxUDd2I6X6wJ+Nxxw9oItXsR/nY=
X-Google-Smtp-Source: AMrXdXtQ2nz/3mwBUacCNlb1wmtvB71Or1Yu37rxvgQTW53l2pMJMVE/2JSQFa9/YPPnHRFWX7jDgPcipU4G37dZ0M8=
X-Received: by 2002:a17:906:380e:b0:877:5b9b:b426 with SMTP id
 v14-20020a170906380e00b008775b9bb426mr4120361ejc.12.1674701300655; Wed, 25
 Jan 2023 18:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20230123145148.2791939-1-eddyz87@gmail.com> <20230123145148.2791939-5-eddyz87@gmail.com>
In-Reply-To: <20230123145148.2791939-5-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Jan 2023 18:48:08 -0800
Message-ID: <CAEf4BzbH-nBdD2N0-bFh0pQrU2o6sqOmrswMRYVgAgeLQWQS9g@mail.gmail.com>
Subject: Re: [RFC bpf-next 4/5] selftests/bpf: __imm_insn macro to embed raw
 insns in inline asm
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Mon, Jan 23, 2023 at 6:52 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> A convenience macro to allow the following usage:
>
>   #include <linux/filter.h>
>
>   ...
>   asm volatile (
>   ...
>   ".8byte %[raw_insn];"
>   ...
>   :
>   : __imm_insn(raw_insn, BPF_RAW_INSN(...))
>   : __clobber_all);
>

Ah, now I see why it's __imm_insns. Makes sense. Hopefully this won't
be used very frequently anyways.

> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index e742a935de98..832bec4818d9 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -61,6 +61,7 @@
>  #define __clobber_common "r0", "r1", "r2", "r3", "r4", "r5", "memory"
>  #define __imm(name) [name]"i"(name)
>  #define __imm_addr(name) [name]"i"(&name)
> +#define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
>
>  #if defined(__TARGET_ARCH_x86)
>  #define SYSCALL_WRAPPER 1
> --
> 2.39.0
>
