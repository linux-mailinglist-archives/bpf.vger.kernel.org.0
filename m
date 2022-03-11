Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C721E4D573C
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 02:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbiCKBRZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 20:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240714AbiCKBRY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 20:17:24 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1777519D615
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 17:16:22 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v14so1878921qta.2
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 17:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXC5XHcV/Wbu2T0eQaB0nXVhI1w5Uiw1+os7WF404f4=;
        b=khGZZDjneArK+aWQ0eJ+CVypbvxl8Hccs4Kv00uBVk+YSpulAXMLw1UvswkczaBPbF
         PxbAsulQN4WiJPAEHzLAcp8a9kUq61LLqQVu+nofwfCB9Cida/hZz5CovewY/1tAC67x
         NiAUI2Mm2PB8pG87KIlV0tIDbbeLJbLgEy/pC0r8Y3ioKBhnf3zpXv+0B7fKWX6WXFFs
         4DwR27knrmYdywlxS2Cb5N2ySX6wj33aVhKOgg4ymJhlG0lfRhhb+Yf9mRxtIGy6mnRR
         gpis9PcXSVk6WbbyznDzUrVuuUkhbE6rEDxT0yfnBMNVLeQvQBC6InLIe4rHiqll45JX
         0snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXC5XHcV/Wbu2T0eQaB0nXVhI1w5Uiw1+os7WF404f4=;
        b=y9SxFd1p+6WJLmQkRWMG83UdmsS09msmMrm2CvjvINehlxKxmN3OTeZar31sQwXH8V
         3hilrY8VbLRPtvIbAc0nb6P7inC9EFXqNLZhACij9rhdHLN3ExqUtlUG6t/Lkq9rNoLX
         6HX4mg5VjWqSbA7CxOEM/nJitwjPTw4E+4mm1ypYPR4AYcPA3kSuVT+wzeGsFXQQOYX6
         /wZoSTK5pjPw6eeFWmUjRG2R3H+0kfaTDfhTIYLdFwpLpe/pyYZdqIRf8oLQvZHkzlkL
         P4GPbsnBhxsarTxsHr0dO30psq7eKr+WeE8zcchAQM5s4jO+rWsvYOFoK8rGUlKXSgGQ
         NTuA==
X-Gm-Message-State: AOAM5322TyCkN9XKfM0MljAe0+qMABdlQuFbdQkPLUSHgssPXfoUiHiZ
        9Es1IJPtyiRFO7qep5gJyQxDikDOXQzRSyHie/IgGQ==
X-Google-Smtp-Source: ABdhPJwG8+Fvk1gGoWOkRZPRHLE7hlXkRbEqoEWnnxcszrpsuCbuBYlBgeeswv5iqor1ZPCsjz1cVlbjY4RbY/dZRiI=
X-Received: by 2002:a05:622a:1303:b0:2e0:710e:1372 with SMTP id
 v3-20020a05622a130300b002e0710e1372mr6392872qtk.566.1646961381032; Thu, 10
 Mar 2022 17:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com> <a7f26f93-c5f8-2abc-e186-5d179706ae8e@soleen.com>
In-Reply-To: <a7f26f93-c5f8-2abc-e186-5d179706ae8e@soleen.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 10 Mar 2022 17:16:10 -0800
Message-ID: <CA+khW7hwT0PSiToAJcdX1Te9QwhWL671sMX+92VS+V6Zsp+0Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
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

On Fri, Feb 25, 2022 at 12:43 PM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 2/23/22 19:05, Hao Luo wrote:
> > For binaries that are statically linked, consecutive stack frames are
> > likely to be in the same VMA and therefore have the same build id.
> > As an optimization for this case, we can cache the previous frame's
> > VMA, if the new frame has the same VMA as the previous one, reuse the
> > previous one's build id. We are holding the MM locks as reader across
> > the entire loop, so we don't need to worry about VMA going away.
> >
> > Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> > test_progs.
> >
> > Suggested-by: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Hao Luo <haoluo@google.com>
>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>

An update with performance numbers. Thanks to Blake Jones for
collecting the stats:

In a production workload, with BPF probes sampling stack trace, we see
the following changes:

 - stack_map_get_build_id_offset() is taking 70% of the time of
__bpf_get_stackid(); it was 80% before.

 - find_get_page() and find_vma() together are taking 75% of the time
of stack_map_get_build_id_offset(); it was 83% before.

Note the call chain is

__bpf_get_stackid()
  -> stack_map_get_build_id_offset()
    -> find_get_page()
    -> find_vma()

> Thanks,
> Pasha
