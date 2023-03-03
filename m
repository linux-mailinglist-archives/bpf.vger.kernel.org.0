Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5176A9DED
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 18:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCCRqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 12:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCRqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 12:46:04 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7BA1F5E7
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 09:46:03 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id o15so13276673edr.13
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677865562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nnfbulA9EBe9Ln5wiot4hChJ0hyus8xnnhrRS+1jorc=;
        b=FI98il0Vbw/3r99br5I64wxH0fnFf6Nt53L3WD7OTl96M12EFKoUUwhvZ/0dc5/ql2
         fX69tl00Jf5zNkEv4KQSEwJcQcYaerh9tXqOFwruvUP6FJW5wYQktsP5chWqGzcxLbE1
         1sKFMnOdOjII5Uus7d4fzFDjz6FRhRpIxXFUDAWHwVAB3YVcFnZtoVM2YnT2W6f8fSqI
         hNa3O9ps/RTUDdvRtEryYTJzN6iwLPyCtD0883OQtxxt5JWAZu+xUqzIg4di7Cm65Mr6
         bP0MnZV/lmRLoHhVkNWwNVQ26JVK578uWdNyINXcXd/n5VqCCksdyahVZ+xZuu/nKR3Z
         2oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677865562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnfbulA9EBe9Ln5wiot4hChJ0hyus8xnnhrRS+1jorc=;
        b=zHw7NfwNlyCSVmY0T72eQx8gbTZ3OLkFBhUe648NIELysnV90hTolAyhK2ByRh0OZY
         qvahtfirqCtx8f+qAKGiVwbRVRe8u+aJkS2SLvZRcbZc14zljocCkr+DaNg+3d79qu0F
         amF8sOpjlj2pGRvZjL0qw9V02Wp7+pqBW3PyB6Y+8m7HSl4XtkSSnkG3OwFnjD+bZvtx
         WYEDLge7Xyl+MZuRgD77I7pxVs7mL44kG2XnNP5PQ1LLc7Luj7eUzaRjY6fPimT8ImTH
         T3DIkPSQY3979vaeMBHy4uRPVue+mogPLWLgQld3j549mj/4xybLCm69AB/tSIg8/sCv
         Q37w==
X-Gm-Message-State: AO0yUKU/I3sgc46Yj8mrfvEFUND9RYZ0I2C6f+8zlEbBXQNoARDLIvaI
        XuafVYv5Pjf7A3ejIVsJz9gPg7xpzKC4vhsWexWd6iXwYoY=
X-Google-Smtp-Source: AK7set//5IUbX8w0urB7dTBvZJSplQteFxs/3fL6Psd/uxGEM6qB4VU/Va7vE5kCnAiG9f6Pf6XMS+XCxaSvFCQ/v9g=
X-Received: by 2002:a17:906:a18b:b0:8d7:edbc:a7b6 with SMTP id
 s11-20020a170906a18b00b008d7edbca7b6mr1369396ejy.2.1677865561853; Fri, 03 Mar
 2023 09:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20230303141542.300068-1-memxor@gmail.com> <ea8736cf-6d25-5e56-0359-6a80593dd3ec@linux.dev>
In-Reply-To: <ea8736cf-6d25-5e56-0359-6a80593dd3ec@linux.dev>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 3 Mar 2023 18:45:25 +0100
Message-ID: <CAP01T77XW-XenFnqz4aruFKzLWVHhyL0vE9cJEK_OuyRVW+Bww@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use separate RCU callbacks for freeing selem
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
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

On Fri, 3 Mar 2023 at 16:40, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 3/3/23 6:15 AM, Kumar Kartikeya Dwivedi wrote:
> > Martin suggested that instead of using a byte in the hole (which he has
> > a use for in his future patch) in bpf_local_storage_elem, we can
> > dispatch a different call_rcu callback based on whether we need to free
> > special fields in bpf_local_storage_elem data. The free path, described
> > in commit 9db44fdd8105 ("bpf: Support kptrs in local storage maps"),
> > only waits for call_rcu callbacks when there are special (kptrs, etc.)
> > fields in the map value, hence it is necessary that we only access
> > smap in this case.
> >
> > Therefore, dispatch different RCU callbacks based on the BPF map has a
> > valid btf_record, which dereference and use smap's btf_record only when
> > it is valid.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Thanks for your patch. I have already made a similar change in my local branch
> which has some differences like refactored it a little for my work. The set is
> almost ready. Do you mind if I include your patch in my set and keep your SOB?
>

No problem, please do.
