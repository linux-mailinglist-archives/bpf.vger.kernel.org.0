Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289B65979BF
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbiHQWlk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 18:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbiHQWlj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 18:41:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B69C2D1
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 15:41:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g18so81452pju.0
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 15:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5zip/1GJ4+oLY23FmtWqcDW0nrhwukluajbAYnOOlNg=;
        b=H1txome9CG26mQwJ6qHTtwZuvGBg9wrSUit3+IRiCbY9Qhhrxf8dOyvuqTTD35kpxI
         g33Xrp0IVl2BrrIqDHB3kngbFTw/yyqcSg5j5xOnPKCIvUn88zeCJtFPku3WPnwqupxV
         L5ieCKK/36D6HSZg++wn0CcS8dSiW0tnYpgmVgwqtO8reRLpsvhKa9mRFlRZr7707FkS
         HD17P9bIY3UQLePB+JrnkMvLab4HW0Eu6uhbcBLY7GrsLXlB2HJssAD5QV3dKlDDd13B
         BIcD5IBmyDMzC+3NU4Y/XtqT/6M2sy1bj1+9uiKGckuCbOw9b2Q2LueUxJmnR4ol4B/M
         cycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5zip/1GJ4+oLY23FmtWqcDW0nrhwukluajbAYnOOlNg=;
        b=zjUYCOe1Liw+0NvftHhx7TTXjOFYpUZox+wzn3yYsbZKRkaB3YteX8e+einBJ0HBUV
         6YMJXGkCmeWgE6l3z63VXE/8Bdxm5rDf4bVKw9SSAzfpenio0q8vstrlvZigQz0IL+ba
         GUjQ18XulFjnhZlROQI3cWUdJZuFmBI+P5K5lXsmU7imOUhBnI/inBX/80jeyoBA0i3c
         eADt7LIs7qdLCKwqSj6XQJx8fPmEHqVA+LDAMZxzLJDt4b4CilgoV2oQRm3swdfRmthw
         FP16xlW70iShYV07UbEN2bKmpA6+xt82b8MSwbh3cpJivVJNlRqq+d4US8MhZj/Q/3PN
         m4Zw==
X-Gm-Message-State: ACgBeo3wvGrrcJgdQSU/vWB+DYEF/bn5nda1vkyfAh/fCFqezP9FLEqc
        3CcDVuZaAyAED2/KD2CHFkj0LrexY3/FhZqKNVkwxw==
X-Google-Smtp-Source: AA6agR7l9XXUx4PqlUCcHizcMKohq7Lg2kBikHkZ5s32yA+rnNSmFkBB1IHWAb+ib1f9IZOfmTZ23b9u8Y0rUYdTNws=
X-Received: by 2002:a17:90b:4b04:b0:1f5:2da0:b2f6 with SMTP id
 lx4-20020a17090b4b0400b001f52da0b2f6mr159231pjb.195.1660776097931; Wed, 17
 Aug 2022 15:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220816201214.2489910-1-sdf@google.com> <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
In-Reply-To: <20220817190743.rgudkmzunhtd5vxf@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 17 Aug 2022 15:41:26 -0700
Message-ID: <CAKH8qBukudivY5XMwq6k42oUmHdAnbBAw2AjMeBT+Qnj3OZZhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] bpf: expose bpf_{g,s}et_retval to more
 cgroup hooks
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 12:07 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Aug 16, 2022 at 01:12:11PM -0700, Stanislav Fomichev wrote:
> > Apparently, only a small subset of cgroup hooks actually falls
> > back to cgroup_base_func_proto. This leads to unexpected result
> > where not all cgroup helpers have bpf_{g,s}et_retval.
> >
> > It's getting harder and harder to manage which helpers are exported
> > to which hooks. We now have the following call chains:
> >
> > - cg_skb_func_proto
> >   - sk_filter_func_proto
> >     - bpf_sk_base_func_proto
> >       - bpf_base_func_proto
> Could you explain how bpf_set_retval() will work with cgroup prog that
> is not syscall and can return flags in the higher bit (e.g. cg_skb egress).
> It will be a useful doc to add to the uapi bpf.h for
> the bpf_set_retval() helper.

I think it's the same case as the case without bpf_set_retval? I don't
think the flags can be exported via bpf_set_retval, it just lets the
users override EPERM.
Let me verify and I can add a note to bpf_set_retval uapi definition
to mention that it just overrides EPERM. bpf_set_retval should
probably not talk about userspace/syscall and instead use the words
like "caller".
