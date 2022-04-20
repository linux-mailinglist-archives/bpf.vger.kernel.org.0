Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2250873B
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352684AbiDTLqA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 07:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352651AbiDTLpz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 07:45:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA9419BF
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 04:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59DEAB81D1C
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 11:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8429C385A4
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650454986;
        bh=SJX0hL833Q2ataycRYrB6BhXBqWa4plfzhGevB+mLF0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H9AtkhIaDOQCpmpniEKXzeRK/B8Auf7tvM7/FFl+cRE9DfsWQIi9uULIdw8+HXmy7
         GYIhiejgF8gVm2P2hHQuOgH8HwY00k53Xqatu/F7e7kTEHmXNV6ugkboizTiMBUN2y
         J454630Ka8MYTwxbkxJlwYPXOdamiCcFMdoLJZMG/40aErlrsZ4vsdVuG0fzNX9TDl
         tPTFQsnrE/UQexew+4hac7NGpYk3QOq3yGk8hC0VrAPwNPxfat3mROCGj2tFkK4EqM
         ktSPggD9gZNSlIpQEooDyaKZEMbf3XVCRhUvrn4K2m0SSSDy9UV+rZm16UO5OG3m7u
         EdvB6FAgo9K8w==
Received: by mail-ej1-f46.google.com with SMTP id ks6so3007055ejb.1
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 04:43:06 -0700 (PDT)
X-Gm-Message-State: AOAM533nnlI8U/Lg51d2hACnm2pHxzjqXtUmD6pwaAoqlxoMRLZjnwLf
        ZEHhDn4SV1e1z/62DiQLDgTLnEdQQAZYmxWcTe82lw==
X-Google-Smtp-Source: ABdhPJyANcMdvA+ktghYJ4f27ywVan8fgMqIgZ69qYBtSH3bIIwYJZEjs0aaoX0yznuqG16ZBoHNgWlTZ78/VQ4KW/g=
X-Received: by 2002:a17:907:6089:b0:6db:a3d7:3fa9 with SMTP id
 ht9-20020a170907608900b006dba3d73fa9mr18759957ejc.593.1650454985018; Wed, 20
 Apr 2022 04:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220414162220.1985095-1-xukuohai@huawei.com> <20220414162220.1985095-6-xukuohai@huawei.com>
 <CAEf4Bzb_R56wAuD-Wgg7B5brT-dcsa+5sYynY+_CFzRwg+N5AA@mail.gmail.com>
 <6c18a27f-c983-58f3-1dc0-5192f7df232a@huawei.com> <82e7faec-7f0c-573f-4945-de7072744dcb@huawei.com>
In-Reply-To: <82e7faec-7f0c-573f-4945-de7072744dcb@huawei.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 20 Apr 2022 13:42:54 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6QZek1VV-QgO52Kp9X4cCJnXaD7QJFkMtMLtzDTzDDsA@mail.gmail.com>
Message-ID: <CACYkzJ6QZek1VV-QgO52Kp9X4cCJnXaD7QJFkMtMLtzDTzDDsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] bpf, arm64: bpf trampoline for arm64
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        Shuah Khan <shuah@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Collingbourne <pcc@google.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steven Price <steven.price@arm.com>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 20, 2022 at 9:44 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> On 4/16/2022 9:57 AM, Xu Kuohai wrote:
> > On 4/16/2022 1:12 AM, Andrii Nakryiko wrote:
> >> On Thu, Apr 14, 2022 at 9:10 AM Xu Kuohai <xukuohai@huawei.com> wrote:
> >>>
> >>> Add bpf trampoline support for arm64. Most of the logic is the same as
> >>> x86.
> >>>
> >>> fentry before bpf trampoline hooked:
> >>>  mov x9, x30
> >>>  nop
> >>>
> >>> fentry after bpf trampoline hooked:
> >>>  mov x9, x30
> >>>  bl  <bpf_trampoline>
> >>>
> >>> Tested on qemu, result:
> >>>  #55 fentry_fexit:OK
> >>>  #56 fentry_test:OK
> >>>  #58 fexit_sleep:OK
> >>>  #59 fexit_stress:OK
> >>>  #60 fexit_test:OK
> >>>  #67 get_func_args_test:OK
> >>>  #68 get_func_ip_test:OK
> >>>  #101 modify_return:OK
> >>>
> >>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >>> Acked-by: Song Liu <songliubraving@fb.com>
> >>> ---
> >>
> >> Can you please also take a look at [0], which is an ongoing work to
> >> add support for BPF cookie to BPF trampoline-based BPF programs. It's
> >> very close to being done, so it would be good if you can implement
> >> that at the same time.
> >
> > OK, I'll take a look and try to implemnt it.
>
> already implemented, but there are some conflicts between these two
> series, will send v3 after trampoline cookie are merged.

Awesome work, Thanks for doing this!
