Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7191D687081
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 22:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBAVgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 16:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAVgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 16:36:16 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901C3D0BD
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 13:36:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hx15so411386ejc.11
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 13:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F3/9HkLSBRgDwjqrq4t9uciv77/xrcwOCdiUOYZB3R8=;
        b=iy0f4SPnlIASKIJJ7xLvY6jvVGLZ9T9rCl1wiYocH3C4FaZLa6alSbfBIsXnnnwQHZ
         aGfUpILX4dQE6Hkor4rZaxVd7lledvrgZfCLZsVeyOBmizlrRtbjpj/ITSZqvS7yrmTM
         pB4UgBUQKUFmGzB0uJUynviRCQZbFDRQGfSdkKwoXSsAdN3S8zZnL3NwVxjOjuY0wvMT
         3UUBeFHX4GF4Jn27S45cBg5fswjDDxdWxfwF1zm/aE26plXUpKLk30JbwTxw+DTHCYB2
         AjEJ8FXCosuYapQR69yl+z9doE1toXkXC/s8En22FNhKgORwSCqeKmbQhBU2WY8jplRc
         GM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3/9HkLSBRgDwjqrq4t9uciv77/xrcwOCdiUOYZB3R8=;
        b=wXFmEl4G/GVy1XNkH4HN9Yl9nOdDLBI26ZI5fDw2uL2VSm7N9a3TNDdI/szdOFj0Kj
         8ghbQBKRrJm1CI4yVDNSJW0eDdbHrPPMkf/PIRHSYvkqbXmibmR3XgmNakQIc6/Yxl7O
         hyYlZ2bAImv01kUGmnsDXg/kW9K8jOqa6OkLEPrhVsXWDcGhdeFqt6RtVJqVMVO5LDBn
         /W8eL2ZOX+d2SdaRcWdlw5W64HyGFJo72+DS8lnVChZLLHd79s0ytWkhGG9imoUVOAmO
         RB5GbSH27m0W+w/ngtH1jabz5yvpynz3i7IWJAVKfs9ejV4DpsxwSbjN66CcJlG1SNFL
         OR3A==
X-Gm-Message-State: AO0yUKVgQ9ZtI+XU69EZleFRIJs1WROhPrAx4S489QUQEKRjSWwZHFyq
        76Z7zVWQQSQnKTC0s5x3ixEF8nInnGF1dyl8at8=
X-Google-Smtp-Source: AK7set8rndmF8fXjoDhVAadPsvDCxGiu7HCB+0L5QKUl7fPFp/weCsbmf51XrxPSi+SrTZzt7rskWM+PClayorTZhFE=
X-Received: by 2002:a17:906:cb9a:b0:877:5b9b:b426 with SMTP id
 mf26-20020a170906cb9a00b008775b9bb426mr1059507ejb.12.1675287373631; Wed, 01
 Feb 2023 13:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20230131180016.3368305-1-davemarchevsky@fb.com> <20230131180016.3368305-3-davemarchevsky@fb.com>
In-Reply-To: <20230131180016.3368305-3-davemarchevsky@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Feb 2023 13:36:02 -0800
Message-ID: <CAADnVQKkK1GuHtMEkMomTPvVbtybnhaWmWvmeYku_rXgy3zd2Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/11] bpf: Improve bpf_reg_state space usage
 for non-owning ref lock
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
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

On Tue, Jan 31, 2023 at 10:00 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
>                                        struct bpf_active_lock *lock)
>  {
> +       struct bpf_active_lock *cur_state_lock;
>         struct bpf_func_state *unused;
>         struct bpf_reg_state *reg;
>
> +       cur_state_lock = &env->cur_state->active_lock;
>         bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
> -               if (reg->non_owning_ref_lock.ptr &&
> -                   reg->non_owning_ref_lock.ptr == lock->ptr &&
> -                   reg->non_owning_ref_lock.id == lock->id)
> +               if (reg->non_owning_ref_lock &&
> +                   cur_state_lock->ptr == lock->ptr &&
> +                   cur_state_lock->id == lock->id)

invalidate_non_owning_refs() is called with &cur_state,
so the last two checks are redundant, but I suspect they hide
the issue with the first check.
Just reg->non_owning_ref_lock is ambiguous.
It needs base_type(reg->type) == PTR_TO_BTF_ID first.
