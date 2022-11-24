Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDFA63805E
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 21:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKXU4t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 15:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXU4r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 15:56:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030BB898C9
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 12:56:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vv4so6386789ejc.2
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 12:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k9cPBIaAD83/lqJTSkOSDrIQLq+9v0ILHuq+/aFXFjw=;
        b=Y6pxmvlPcJbX1gv67zq19OK9ihbve2ioDJmLB6rg15apMYsGNnrm+jr4ZE5myhumyp
         /8tBc8TlVgLB0uCsaC3Z1Uja5xFsWtNm7A1FTeAzVnqg+/yUh72WBOiB1u3tsVk+V3pF
         zewkp+/LPlThHcF7hhDkzFxFFA+c3h5Brn7XV7WaQ9gUzLCPQ9/FG60bhvIx2jupaXg6
         IYBHbhNAOIZ15HKz6TV+3UB5tlDi8qSBstK/Bcvl4nYtkiirRJcl74256p9S+wPfqfDe
         ysy7y8R4SPLxdiDCfkXxJuKpWo7Rlb+DnrtGG1vE1AJnKgPV1aGuebZlXZW0hucw9kBn
         rC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9cPBIaAD83/lqJTSkOSDrIQLq+9v0ILHuq+/aFXFjw=;
        b=Og7DHVQmXI3G7wjJ6oZK3nbh/VLfoqLNWlRX8GHcZxdfAQJzwDKkMFN0ay3W431uMp
         5JekLIbeq5NAnIYXzfbgsOnXxGe88wPQ/dA5BUQ7tTvbPIUNwWj0dHhOF9s1HomXl1Se
         fA0w3ezpC2QH1NOpY14+V0bffQ37NvZrvaAT0FY9y/SfHUPM+ulxBizcSLObVtaZDGfD
         fTtj6h6WQENKL9J2lQnCJKNdlkurDa7urObEQDU8x7DvpzcySmU3Oh46TYCpcS/Y8/Xh
         kVQ70lVau4wcApPYofz4qeFRKEbXSMtIWIhfdSeVmJEfn/OPd8kZ8x1pE2D/jWFhtmmg
         bwhA==
X-Gm-Message-State: ANoB5plAwvjiB9uX62irgfRstj9Y1ViHmui4eXnjSDPVc6E3flljLCG2
        yHIG7uNnJROMS9wQqIDcqzcc+1cHj0TvQzRffX8QbB6kdTQ=
X-Google-Smtp-Source: AA0mqf7GDhPxVvDzUEeaFVbWxS8fsO3y7+M/+44g+dNzQBgmCvX9HPifEAbY2UjFWSm4sg87TwbVBpaTH+vMnpB40R8=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr17453474eje.94.1669323405479; Thu, 24
 Nov 2022 12:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20221124053201.2372298-1-yhs@fb.com> <20221124053217.2373910-1-yhs@fb.com>
 <CAADnVQKVm1W0JpSD4YbH+teMVg8EHtR-+DXM-eR--EDHXxYz9Q@mail.gmail.com>
In-Reply-To: <CAADnVQKVm1W0JpSD4YbH+teMVg8EHtR-+DXM-eR--EDHXxYz9Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 24 Nov 2022 12:56:34 -0800
Message-ID: <CAADnVQKm0V8_M6bV9_cQuooNtfRpBW=-=T8Vi5+vmR2BW=BN5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
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

On Thu, Nov 24, 2022 at 12:34 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 23, 2022 at 9:32 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > @@ -16580,6 +16682,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
> >         env->bypass_spec_v1 = bpf_bypass_spec_v1();
> >         env->bypass_spec_v4 = bpf_bypass_spec_v4();
> >         env->bpf_capable = bpf_capable();
> > +       env->rcu_tag_supported =
> > +               btf_find_by_name_kind(btf_vmlinux, "rcu", BTF_KIND_TYPE_TAG) > 0;
>
> It needs btf_vmlinux != NULL check as well,
> since we error earlier only on IS_ERR(btf_vmlinux).
> btf_vmlinux can be NULL at this point when CONFIG_DEBUG_INFO_BTF is not set.
>
> In the previous discussion I thought we agreed to
> fix convert_ctx_accesses() vs incorrect application of
> BPF_PROBE_MEM for PTR_TRUSTED pointers.
> But I didn't find it in this patch.
> So I'm fixing both issues and planning to apply after testing.

Turned out the initial PTR_TRUSTED patch was buggy.
prog_type_args_trusted() is incorrect.
It marks fentry/fexit pointers as trusted and our own selftest
is crashing.
I'll send a separate fix.

So going to apply rcu set with just btf_vmlinux fix.
