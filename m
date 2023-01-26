Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942C167C238
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 02:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjAZBQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 20:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAZBQH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 20:16:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBDC552A8
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:16:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cm4so579381edb.9
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wqdjX7OiMbcq2a5XFIO/kL+p6hEJIZQjalTt5+JD08U=;
        b=o4otcBz3E/S8e0l6i2ztsDXQ71k7+713sa7ITL9thOecLwetxgg/ClPyeqJQD3i2vH
         DVJqVHMa8SbQ0MYHZ4wj1/1oODKXC/Am7HUHe1yqbspXoPHdWnkWzYz77siA2WKFpMlA
         GXq4m4VrEefyJ/p60apOJK95OmfSE9vZvRB+I73vy0Op/Xo2WbkWqZRDsrcsitD1ecDX
         EaIJgSqYX2GmelcVaGxLIP61jk5VuA4TD75gqFqBE9xYnwj/CpeqJGQJ8D/OP0QPZaog
         8uklBxKj1wqoxlFt9oE9w1lnKeqe2pnKQLZ4DA1TcyczhP1dP5Go1hgLOouVNS+ls01h
         U7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqdjX7OiMbcq2a5XFIO/kL+p6hEJIZQjalTt5+JD08U=;
        b=FiIxzlue3PRY5Obx7IF33Hz/EXGyvP11rulng0VROKt4Ua/Ho0g/rsh8X8m6raL05q
         dCk7LcZXmZ9tA+kbaJ+2najDW9+PNpEDZ/NkzZOCFA6ug1baERPTuffouaURvgJwbHyA
         k6xiE+ozsgEiENU8uIB/R1SjFbK2u9p1qfxlu1tIU6geBeK8YUnUYbhopybXEhD/n/sC
         Ps6g15zZINPH8zi7bx/YcbUdwQuVaHeh5BLGf9laa5HXiNhx1tfUwDrtxv+Trasei9vT
         K/inzA/DLQ2JyfcRskmepCf0k3c/TAGB7f8UbmBkaq6ZnQEGp8QZPCZCkhfMlupA3kcE
         fijw==
X-Gm-Message-State: AFqh2kpp3y6ERbY52D5N27GICCKkFWYJNxoZg3yhUa7DxYJUxo5rFoGZ
        kJcNHJzEuQSXQALssi2NuwxRMUEmMhfwHs8XvXg=
X-Google-Smtp-Source: AMrXdXtYiFAKUvWlaqj9XeqvYQ0vEM61LCyv7sFl7KQLWPh4SQbyg/P6k+MXifUN3p0xVjvXRCATZUWfwS4huLkBQvA=
X-Received: by 2002:a05:6402:1008:b0:499:f0f:f788 with SMTP id
 c8-20020a056402100800b004990f0ff788mr4942065edu.25.1674695764661; Wed, 25 Jan
 2023 17:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com> <20230125213817.1424447-23-iii@linux.ibm.com>
In-Reply-To: <20230125213817.1424447-23-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Jan 2023 17:15:52 -0800
Message-ID: <CAEf4BzbaNhFw77bECCxf7cKenBTTe6YvMHbm+XiMQbqgukyW8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 22/24] s390/bpf: Implement arch_prepare_bpf_trampoline()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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

On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> arch_prepare_bpf_trampoline() is used for direct attachment of eBPF
> programs to various places, bypassing kprobes. It's responsible for
> calling a number of eBPF programs before, instead and/or after
> whatever they are attached to.
>
> Add a s390x implementation, paying attention to the following:
>
> - Reuse the existing JIT infrastructure, where possible.
> - Like the existing JIT, prefer making multiple passes instead of
>   backpatching. Currently 2 passes is enough. If literal pool is
>   introduced, this needs to be raised to 3. However, at the moment
>   adding literal pool only makes the code larger. If branch
>   shortening is introduced, the number of passes needs to be
>   increased even further.
> - Support both regular and ftrace calling conventions, depending on
>   the trampoline flags.
> - Use expolines for indirect calls.
> - Handle the mismatch between the eBPF and the s390x ABIs.
> - Sign-extend fmod_ret return values.
>
> invoke_bpf_prog() produces about 120 bytes; it might be possible to
> slightly optimize this, but reaching 50 bytes, like on x86_64, looks
> unrealistic: just loading cookie, __bpf_prog_enter, bpf_func, insnsi
> and __bpf_prog_exit as literals already takes at least 5 * 12 = 60
> bytes, and we can't use relative addressing for most of them.
> Therefore, lower BPF_MAX_TRAMP_LINKS on s390x.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/net/bpf_jit_comp.c | 535 +++++++++++++++++++++++++++++++++--
>  include/linux/bpf.h          |   4 +
>  2 files changed, 517 insertions(+), 22 deletions(-)
>

[...]

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cf89504c8dda..52ff43bbf996 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -943,7 +943,11 @@ struct btf_func_model {
>  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
>   * bytes on x86.
>   */
> +#if defined(__s390x__)
> +#define BPF_MAX_TRAMP_LINKS 27
> +#else
>  #define BPF_MAX_TRAMP_LINKS 38
> +#endif

if we turn this into enum definition, then on selftests side we can
just discover this from vmlinux BTF, instead of hard-coding
arch-specific constants. Thoughts?

>
>  struct bpf_tramp_links {
>         struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
> --
> 2.39.1
>
