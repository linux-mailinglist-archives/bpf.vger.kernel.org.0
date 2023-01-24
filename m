Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875B3679D00
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 16:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjAXPJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAXPJq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 10:09:46 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67A4A1ED;
        Tue, 24 Jan 2023 07:09:33 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id g16so11210437qtu.2;
        Tue, 24 Jan 2023 07:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBwqRmWn/rmFVN9SX1KoveZZb+DYMp4qsI8rYESR2CM=;
        b=PX+HFe3WVP8jAd6W6P8lfTfZfsLuJmNHXS9CHUPsXm0J8pSkU0/INGY/TArbHVkqYb
         ZxDXRYOFGgeuLhWb/EHlItVAYJFPn35i8Kh2x/pUiEC+4zW3fnq6aU97dr4qTUWP/a+J
         sqxGNWd4wnkclOqG0vwneoe/sBEZTwGY0sgkdqSEspb9kZx6xAWOT1pkJ+p/S226ca2H
         pBso1+cFaVIKhMlVCcEUwXCUoKZuzg7yclWne5dQS95zCz6p2dgkInEqjvgxiD87rZdT
         K82gB0g8wAUkDlq9fQmSW3ZTcGRBaVCVxVIhxVtB93aUITydrbQYHbjC3GNatFH16awz
         k7sw==
X-Gm-Message-State: AFqh2kpKh+mFRJ9GwaXsuSh/LgdK3T1bKt2V1LQBMoqwc8odWwqrO6SO
        qq6IZRMSxiVxhHbPJDKXIOA=
X-Google-Smtp-Source: AMrXdXtov1RLU+gX84CUw/q0yux4+NsPeyeC24GWOCIo+TUEBzJ0D+ja5xCWCO2TCt+cNjRkw2j2PQ==
X-Received: by 2002:ac8:58c3:0:b0:3b6:2e8b:3364 with SMTP id u3-20020ac858c3000000b003b62e8b3364mr52508790qta.38.1674572972519;
        Tue, 24 Jan 2023 07:09:32 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id 2-20020ac82082000000b003b2957fb45bsm1410304qtd.8.2023.01.24.07.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:09:32 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:09:32 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf/selftests: Verify struct_ops prog
 sleepable behavior
Message-ID: <Y8/0rKGG2DSjDsIg@maniforge.lan>
References: <20230123232228.646563-1-void@manifault.com>
 <20230123232228.646563-4-void@manifault.com>
 <CAADnVQKnyz4gqDXfo0OTDuGGbn3i-+roB4M4Q-uxiMLrSP=S=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKnyz4gqDXfo0OTDuGGbn3i-+roB4M4Q-uxiMLrSP=S=g@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 09:32:03PM -0800, Alexei Starovoitov wrote:
> On Mon, Jan 23, 2023 at 3:22 PM David Vernet <void@manifault.com> wrote:
> >
> > +static struct dummy_st_ops *open_load_skel(void)
> > +{
> > +       int err;
> > +       struct dummy_st_ops *skel;
> > +
> > +       skel = dummy_st_ops__open();
> > +       if (!ASSERT_OK_PTR(skel, "dummy_st_ops_open"))
> > +               return NULL;
> > +
> > +       err = bpf_program__set_flags(skel->progs.test_3, BPF_F_SLEEPABLE);
> 
> Feels that this is incomplete without libbpf support.
> Instead of:
> +SEC("struct_ops/test_3")
> the users should be able to:
> +SEC("struct_ops.s/test_3")
> 
> and the above manual set_flags won't be needed.

Thanks for the pointer, agreed that's far better (and matches existing
behavior for other prog types). Will address this in v2.
