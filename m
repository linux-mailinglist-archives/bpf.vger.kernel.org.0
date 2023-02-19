Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01969C2DF
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 23:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjBSWXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 17:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjBSWXg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 17:23:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A4EB4D
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 14:23:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k5so6024557edo.3
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mcu3FFlI3Cl+PJaeR+LhESwSYtNrx+Z+dfvy/EIIt58=;
        b=hfBiBRq+iWOI5Ytxg1P18nrzQecgUtRoG1wi3TNxbOs/i06pNAwzPlmQVtp+ldT+49
         yVbak/cj961N0/pmSLk+qVVs8d26qtFaaJBhM2Nh5qq3Gt6m1woBSOHYUB7/PgyMdkqv
         ccGwJCPlR9vcc1Z2HrVStZiSpVCtDO0eY6j4QDuWpPhzuyZpAeUsIG1PfmouiSkQMQIK
         951qDWrKMePaXDgTZvYBd5SRr8tcwuu7OykP9QJZsfhtg6R3nbO33N9pt+jCCAZ34M/Q
         FYsyB+gWVHJK/IBT36M+9Gr0BEY/VEv7/aaq2KnrKUWNk25AoRqqjzDUJeGhDP71Jdia
         RzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcu3FFlI3Cl+PJaeR+LhESwSYtNrx+Z+dfvy/EIIt58=;
        b=gIKZhnQ8M0k/LJetQauwTzn5iADD1xbL7AqOnjL+lxPbLfW37QNCu70oaO/y2AB54q
         /NFdS/OJNvQ1AKi1OppF5IEpWWKbk9nouQf1LEy2tuKWTmVog8Pb66Tjg51LLrBeWKhr
         7keit8lSvU7OhHv6yjjBLEln06A8VqQBdlEucGxx/QWV7eOrEGQz+WtbIC2PzwwegoQ6
         a0ctd9Lq8+8HadYaSChcOGTcbS8NMKzLnZGZvCkay4f1/NR9vG+3FgKYtOYjKhN1K3g9
         TYvRiy8lqgEjE/rnL+HFZ6KUFkce8T0Dzb49635OD9IhC9slZx8MJb9jFb1aG78K4gGq
         BDTw==
X-Gm-Message-State: AO0yUKVY1u4KAfDmGew9QvUQhSg+2oskH+DS9s/u9oNojArTbssCkhXO
        0bq5WA8CfgeylNGZjWlf9dY=
X-Google-Smtp-Source: AK7set94XJzYyJCNO/hmqI4C/0CIrhKZzQMOIZe4OV/5Cjq7OWlWvSbXZac0Owy7w0Cfc3LoqpqD6A==
X-Received: by 2002:aa7:c552:0:b0:4ad:bb59:bc8b with SMTP id s18-20020aa7c552000000b004adbb59bc8bmr2526518edr.32.1676845412831;
        Sun, 19 Feb 2023 14:23:32 -0800 (PST)
Received: from krava ([83.240.60.112])
        by smtp.gmail.com with ESMTPSA id s22-20020a50ab16000000b004acb6d659eesm1044074edc.52.2023.02.19.14.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 14:23:32 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 19 Feb 2023 23:23:29 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, olsajiri@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC dwarves 0/4] dwarves: change BTF encoding skip logic for
 functions
Message-ID: <Y/KhYf+jipES0pQN@krava>
References: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 17, 2023 at 11:10:29PM +0000, Alan Maguire wrote:
> It has been observed [1] that the recent dwarves changes
> that skip BTF encoding for functions that have optimized-out
> parameters are too aggressive, leading to missing kfuncs
> which generate warnings and a BPF selftest failure.
> 
> Here a different approach is used; we observe that
> just because a function does not _use_ a parameter,
> it does not mean it was not passed to it.  What we
> are really keen to detect are cases where the calling
> conventions are violated such that a function will
> not have parameter values in the expected registers.
> In such cases, tracing and kfunc behaviour will be
> unstable.  We are not worried about parameters being
> optimized out, provided that optimization does not
> lead to other parameters being passed via
> unexpected registers.
> 
> So this series attempts to detect such cases by
> examining register (DW_OP_regX) values for
> parameters where available; if these match
> expectations, the function is deemed safe to add to
> BTF, even if parameters are optimized out.
> 
> Using this approach, the only functions that
> BTF generation is suppressed for are
> 
> 1. those with parameters that violate calling
>    conventions where present; and
> 2. those which have multiple inconsistent prototypes.
> 
> With these changes, running pahole on a gcc-built
> vmlinux skips
> 
> - 1164 functions due to multiple inconsistent function
>   prototypes.  Most of these are "."-suffixed optimized
>   fuctions.
> - 331 functions due to unexpected register usage
> 
> For a clang-built kernel, the numbers are
> 
> - 539 functions with inconsistent prototypes are skipped
> - 209 functions with unexpected register usage are skipped
> 
> One complication is that functions that are passed
> structs (or typedef structs) can use multiple registers
> to pass those structures.  Examples include
> bpf_lsm_socket_getpeersec_stream() (passing a typedef
> struct sockptr_t) and the bpf_testmod_test_struct_arg_1
> function in bpf_testmod.  Because multiple registers
> are used to represent the structure, this throws
> off expectations for any subsequent parameter->register
> mappings.  To handle this, simply exempt functions
> that have struct (or typedef struct) parameters from
> our register checks.
> 
> Note to test this series on bpf-next, the following
> commit should be reverted (reverting the revert
> so that the flags are added to BTF encoding when
> using pahole v1.25):
> 
> commit 1f5dfcc78ab4 ("Revert "bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25"")
> 
> With these changes we also see tracing_struct now pass:
> 
> $ sudo ./test_progs -t tracing_struct
> #233     tracing_struct:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Further testing is needed - along with support for additional
> parameter index -> DWARF reg for more platforms.
> 
> Future work could also add annotations for optimized-out
> parameters via BTF tags to help guide tracing.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com/
> 
> Alan Maguire (4):
>   dwarf_loader: mark functions that do not use expected registers for
>     params
>   btf_encoder: exclude functions with unexpected param register use not
>     optimizations
>   pahole: update descriptions for btf_gen_optimized,
>     skip_encoding_btf_inconsistent_proto
>   pahole: update man page for options also

changes look good, but I don't have that much insight into dwarf part of
the code

anyway I tested on x86 with gcc and clang bpf selftests and it looks good,
and duplicate functions are gone

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  btf_encoder.c      |  24 +++++++---
>  dwarf_loader.c     | 109 ++++++++++++++++++++++++++++++++++++++++++---
>  dwarves.h          |   5 +++
>  man-pages/pahole.1 |   4 +-
>  pahole.c           |   4 +-
>  5 files changed, 129 insertions(+), 17 deletions(-)
> 
> -- 
> 2.31.1
> 
