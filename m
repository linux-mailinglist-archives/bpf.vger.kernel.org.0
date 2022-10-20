Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A734560674E
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJTRt5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJTRty (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 13:49:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64F73FECB
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 10:49:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy4so1320902ejc.5
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yaxHRyCO+h9HgVT4WixpFB0XnD61yyE0ASt9YoTl/qw=;
        b=KDIXzT9ActIFrchpN9OjSCYtNCb4hwPK7/xqQTfLO4whtwWvEUoWk3YxVsufN3bEfa
         or0Fbx+LECMWoOV0F2GPR5FcJclNGGsz0tvaS4FRYSf23cbNLsIL3T9c0LQn9zPfImFm
         BaNUiErq20hdNEMzQ17Ia2KEnzuZk6VitUMyhMX+H3yeQ4xbO2REcMOukqwy6uPY9ncu
         SMG66QG16cMMevFTGdOGKqxac0L5BrvRlPr2fLd9OkrRv7BXQJtQNIdjbfokzvEQkUZl
         BdUnMHjQHIVIIjdMiJQcR0gB5WTrQGdRAqLKLm52oOCK14A2HkXp+lh4idUWa8lkZcFy
         iRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaxHRyCO+h9HgVT4WixpFB0XnD61yyE0ASt9YoTl/qw=;
        b=TwgyZpDChMV4hMwSGy0Y0F7mCCbvkty9J+nnx7LTXUNlKAVETI0AJpiGC1fDpFLSo9
         Jcpu2PZBxFKcdUC+YUxF22sNxdkMRnU85iAONjMBbUKJvUyE3yRuLjR9B+RqJB3FGjJi
         MK0IHRTLRmVLNj11U08oWqmV09VcfTKWvFtGyRdmvWEXp49PnSit0BmrxjoGIH4IbpBM
         +ITRVS8oMimbeAn8HGX1gRbUeDK5Se+uDBfuEm9h39B38i3N8l8FciUGEAfZhHIc6IMR
         /q6znfYXhphZHtDDuRUCRnPZrz1ywW0LmPH71kNydK+JnD/GTH3By0wBVuuw5+XZhgyo
         Cp2w==
X-Gm-Message-State: ACrzQf2mSOq68bqwCNZTQW2NWSajNc26855BbLYr3WrgF3oSE+9ROeEH
        ERmDXJ76nVRI9+TVKUpN4/3nig7FDoSf1H8jw/0=
X-Google-Smtp-Source: AMsMyM5c8RtvnMBqNlkFQMvwp6ciCwp0GzX/G2byB9JpmihuY/S8VIHadddrvwKe8FfrcN63Lui7egp5swCrIP471cw=
X-Received: by 2002:a17:907:6e93:b0:78d:dff1:71e3 with SMTP id
 sh19-20020a1709076e9300b0078ddff171e3mr11387723ejc.94.1666288185325; Thu, 20
 Oct 2022 10:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221020123704.91203-1-quentin@isovalent.com> <20221020123704.91203-7-quentin@isovalent.com>
In-Reply-To: <20221020123704.91203-7-quentin@isovalent.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Oct 2022 10:49:33 -0700
Message-ID: <CAADnVQKHk88YFcTE55GXu7HwQkTb0TGNpnrB8Ec7PVZy9uVhOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/8] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
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

On Thu, Oct 20, 2022 at 5:37 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> +
> +/* This callback to set the ref_type is necessary to have the LLVM disassembler
> + * print PC-relative addresses instead of byte offsets for branch instruction
> + * targets.
> + */
> +static const char *
> +symbol_lookup_callback(__maybe_unused void *disasm_info,
> +                      __maybe_unused uint64_t ref_value,
> +                      uint64_t *ref_type, __maybe_unused uint64_t ref_PC,
> +                      __maybe_unused const char **ref_name)
> +{
> +       *ref_type = LLVMDisassembler_ReferenceType_InOut_None;
> +       return NULL;
> +}

Could you give an example before/after for asm
that contains 'call foo' instructions?
I'm not sure that above InOut_None will not break
symbolization.
