Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8982260BB15
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 22:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiJXUq1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 16:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiJXUpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 16:45:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD211DF95
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 11:53:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bn35so5247577ljb.5
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FZAjU0BHDBuQVUlJTVUiE7p9D8v+ywK9rNj9aC9B5bY=;
        b=Kjcq1YwYPIFxh8VWlKw4WwpSwhL0xwjtRmuldifLKkXGYx35+1/i+cAeUBlL2SbXyd
         64YC8sGtwr2Ldxl/us7ek/p5jEDknpq8MTl+E6u/oZ/VuQ7f5IyJywUZGzFT6FXqlVoG
         y4JFXFGTcPg3u/95Z+9eeDJqKqB9IUpxJFN7aacsqmWJvvOeDgDAGCZhvxLYQT7kjSia
         gT57uku22Bmbgf5F0Eos/UdSMoxTlVxBBGDCuv2JoXyog/yb68Z780ciHrIPCGw3tVcs
         dUGug3ixqAj4nv23yC3nTFJEHAF/psPA2Mx2i/cqbW3lojyKP8TbC50s/cmtUJeDtM+l
         Tujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZAjU0BHDBuQVUlJTVUiE7p9D8v+ywK9rNj9aC9B5bY=;
        b=RXS5Axh6SkD4cWPXM3HBurary9lMyYEY137j1jot2hABbMfY8Vwx5SBAG8UO7yExSC
         O5G3pXrHn8aq3iimyJ+v4/+QSRsoEVVGxGpXr/hOBpAzPRjlVOSZs2+ldPZgJ/GI8BKV
         Ur7/iW2PjiK5NA1rTf38NjjG7jIClPkeSsC1e1ds33SPyhPh+L7d4wACV2sfLlkTw90Q
         sc5wBikDXOAGWt0ziNYeuotdItqnCVA2ZEm3puRh0L/rmF+dtKUII5eI8LJdA4mi/CCn
         fB3jXHRJ42+nHt/u0rPtkmNLCnSD80Mc/HTDMTA/V10/wndVmESIOaRlcwfOviS2NnDn
         2TnQ==
X-Gm-Message-State: ACrzQf27sxCl6wtKEGvRcpA/fsDBldaULESSVWpGo5uC6FJ8IPhf/e3s
        LjAbFIsTwwrTmMaiX+VrS5dohBFD7nzjqt2NM3vO1SP1
X-Google-Smtp-Source: AMsMyM5guVEvCRtkIY8OtEWPDq1GN6/UihGBUi/84RI0agb9qXJ6WrJv2LsNP2k6oWddAlBB2ps+K4wMgUdVDnNjgLs=
X-Received: by 2002:a17:907:1c98:b0:78d:3b06:dc8f with SMTP id
 nb24-20020a1709071c9800b0078d3b06dc8fmr28134295ejc.58.1666636871444; Mon, 24
 Oct 2022 11:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221020123704.91203-1-quentin@isovalent.com> <20221020123704.91203-7-quentin@isovalent.com>
 <CAADnVQKHk88YFcTE55GXu7HwQkTb0TGNpnrB8Ec7PVZy9uVhOw@mail.gmail.com> <1dc2c77a-2dea-25a4-fa64-b65460c7f1cb@isovalent.com>
In-Reply-To: <1dc2c77a-2dea-25a4-fa64-b65460c7f1cb@isovalent.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Oct 2022 11:40:59 -0700
Message-ID: <CAADnVQ+4ErnQCZSz=hVqv_FJ9UHTV5LqsTWwP2ve_ujqabwOgw@mail.gmail.com>
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

On Mon, Oct 24, 2022 at 4:05 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> 2022-10-20 10:49 UTC-0700 ~ Alexei Starovoitov
> <alexei.starovoitov@gmail.com>
> > On Thu, Oct 20, 2022 at 5:37 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >>
> >> +
> >> +/* This callback to set the ref_type is necessary to have the LLVM disassembler
> >> + * print PC-relative addresses instead of byte offsets for branch instruction
> >> + * targets.
> >> + */
> >> +static const char *
> >> +symbol_lookup_callback(__maybe_unused void *disasm_info,
> >> +                      __maybe_unused uint64_t ref_value,
> >> +                      uint64_t *ref_type, __maybe_unused uint64_t ref_PC,
> >> +                      __maybe_unused const char **ref_name)
> >> +{
> >> +       *ref_type = LLVMDisassembler_ReferenceType_InOut_None;
> >> +       return NULL;
> >> +}
> >
> > Could you give an example before/after for asm
> > that contains 'call foo' instructions?
> > I'm not sure that above InOut_None will not break
> > symbolization.
>
> Hi Alexei, I ran a quick test and it doesn't seem we lose any
> information. Building from:

Thanks for checking. The output looks good.
