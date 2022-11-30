Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6FA63CC93
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 01:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiK3Aoo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 19:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiK3Aol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 19:44:41 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86556DFEF
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 16:44:40 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v206so2969021ybv.7
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 16:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqawpMU2AHWvowbxYuk3aJ+v+RArSp9Jtb/OVp1IRyk=;
        b=k6GZZr9QichmidC1/Sq2jeQrPRcpr2Hbdx2+gAIoO+H3qlm6FoiPMEMIDimVrLsvkA
         CSH75/r29Twqk+vTBmTsLMAq76NuklUJ/iS3YMNqj/n8HkK2Yk46gfMwOzC4f7Z+bWdg
         7mNjhhn3u3n+QAW+1yh4raQSIcszLNMPavBysudwWmDJFycHBkhFDs0Zo6Nzo9H8B7mQ
         O1p5h8tT1+psfWO1dEk5y69biJTOfoA409ZlpNGpM7m7K9UO+74wrSxDAEdcrWhM1hEt
         1F0J6O3XuwpXohYe75NDS+ezQORgL6ZhSeopGfJrbxcpGD9NRI7a92jQ7irqSDeDjuw1
         MF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqawpMU2AHWvowbxYuk3aJ+v+RArSp9Jtb/OVp1IRyk=;
        b=VVdpYTJYuXrpGl2snV49KhB2vPfK8fk1baSwkzv0gB1zSmEdsYm6TRVB/l2dGVUSQ/
         s6cuIAhmBVNZF1uWSXmPTL+GxAg4FaOKk6wiw+TPJoWEvZQMNYETyQ4yFAQKTiymyvGm
         rEQ8ZUIDEBJ/VY9LVRLaVChaE3my/FsrZB9z7p8FZR4AO6qiKZn/+DjBpxD9Lw5QIoyr
         J06akoQ4qY5c4SMhRaTqH4X6lJJtRHFxLDfy6hNLItBXX84HSVk+KVB88/D22DVNfv9V
         KghoyzQVJDwhI/ra+ZF3qKzLuIujDeWRjhKrJVCQ1/NgLk7WowIdSrjCwnTk14OoJsAA
         6kvQ==
X-Gm-Message-State: ANoB5pmXoNUDeNtX4odg1V0+NEjx2MpZeTvgALtvTt7BIdt1IQvNx/5B
        Vd5+s5tqBVV4H4pKqz/aaacAGFop1g7EWgUr0BoX0g==
X-Google-Smtp-Source: AA0mqf7zOFXyyAIPdm32Ppa/yI8lKCreqNfgF8jdq9KeVoTlsTRhKuk+3cZqwh4oc+6sRh/vCPmdtgohtVaxUF0S43U=
X-Received: by 2002:a25:99c8:0:b0:6de:1f2b:7eba with SMTP id
 q8-20020a2599c8000000b006de1f2b7ebamr35612767ybo.524.1669769079709; Tue, 29
 Nov 2022 16:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20221129161612.45765-1-laoar.shao@gmail.com>
In-Reply-To: <20221129161612.45765-1-laoar.shao@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 29 Nov 2022 16:44:28 -0800
Message-ID: <CA+khW7jjfQOLnx6-4UyJ8sYTj12qzp_NmiZJ-uiSwGU754hbXg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Allow get bpf object with CAP_BPF
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 8:16 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> In the containerized envriomentation, if a container is not
> privileged but with CAP_BPF, it is not easy to debug bpf created in this
> container, let alone using bpftool. Because these bpf objects are
> invisible if they are not pinned in bpffs. Currently we have to
> interact with the process which creates these bpf objects to get the
> information. It may be better if we can control the access to each
> object the same way as we control the file in bpffs, but now I think we
> should allow the accessibility of these objects with CAP_BPF.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/syscall.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

As far as I can tell, requiring CAP_SYS_ADMIN on iterating IDs and
converting IDs to FDs is intended and is an important design in BPF's
security model [1]. So this change does not look good.

From the commit message, I'm not clear how BPF is debugged in
containers in your use case. Maybe the debugging process should be
required to have CAP_SYS_ADMIN?

[1] https://lore.kernel.org/bpf/20200513230355.7858-1-alexei.starovoitov@gmail.com/
