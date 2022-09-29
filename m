Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E85EEA74
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 02:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiI2AQs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 20:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiI2AQr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 20:16:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4AB118DDA
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:16:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e18so19360439edj.3
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wEMSsW/9nKtYc1Z8eKtfCCVBe+RKz19fuXdfkKpG0B0=;
        b=n+Eo4xT66XiYSVH/zruWp9EPeOEnJvR84VcKaoSPhDzgnyiPkv82QNL7VnguEUyN4+
         iBeNWD2C9GDHyISfo1mLYlHVbVMB7Vqtcj8o19Wh4/57RgDRgfqjRvF98ko1RynjBrW0
         /k8qOl/WR+Ce7JQzjou0rfHb3JTQN16Ag4wdxOck9APIQAquItya4DZhRTdD6PdXHJ3L
         AWB1rYJip+F+wVkBC6H1rDn9NT9pmGLx68K/S25HhrtJiE9tatQ2TCXpgDWOCdZ4MoDh
         jtra/IG+ghJxaFQf1uiA2hu2SoK6dObf+1tl1zByLiUMDQSdRdJnyq1NoBRZ+km9mgCe
         T69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wEMSsW/9nKtYc1Z8eKtfCCVBe+RKz19fuXdfkKpG0B0=;
        b=XCxAzEWJvhfcaPOL+Vqw8ff7jJdMvfYfkzAT+D14dKpnGMKn3drmlI1vWXvdXDa3pP
         wSjrZXsWvAycZjrc0fxvas3pfqUvrdjSwXN+zpk34FIGQSVwTFiXCH79y3F9I7J5ect4
         RM0LZQ8RwZHvM398lK5tJ2wdJsRdGZibi7gSseYumeX5+79ZSmcw+DQHWt2rsNhkT0Eb
         Ds2jzuONPCDVyMOwmcX3mX1BR6Jewzwy8ey4dNlWwhx8EF7xS4NZmaGqyXd/avW7rkVU
         yn+kf6w/Ibaj6VG/sOfcJ4xTp+e8CYcS7UzweZ+LxJKEjb2eyKHMhGcakJNuyQHc6I0e
         FD0g==
X-Gm-Message-State: ACrzQf3KEqCdOsONg1KMgzVdDwAozWdaLyxm2IwK7gJVOEBtIVjPotXW
        QK81PNwl/Hi5WiwRtSmtmDTx1ZbmTYtslCDXbmw=
X-Google-Smtp-Source: AMsMyM7YOdUerQeL2Gq242mWnIiNna1rErs4yJIoyd4xRl6hHaRu8RBk8Dm/x54/O4GEcabHuVFe6nHLrozlNeshGfk=
X-Received: by 2002:a05:6402:518e:b0:452:49bc:179f with SMTP id
 q14-20020a056402518e00b0045249bc179fmr626220edd.224.1664410605406; Wed, 28
 Sep 2022 17:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com> <20220924133620.4147153-4-houtao@huaweicloud.com>
In-Reply-To: <20220924133620.4147153-4-houtao@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 17:16:32 -0700
Message-ID: <CAEf4Bza79XbtYF_04MhdcN0o4Akot0VpWaR+mOoGwXsz7yT=xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Support bpf_dynptr-typed map key
 in bpf syscall
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
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

On Sat, Sep 24, 2022 at 6:18 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Userspace application uses bpf syscall to lookup or update bpf map. It
> passes a pointer of fixed-size buffer to kernel to represent the map
> key. To support map with variable-length key, introduce bpf_dynptr_user
> to allow userspace to pass a pointer of bpf_dynptr_user to specify the
> address and the length of key buffer. And in order to represent dynptr
> from userspace, adding a new dynptr type: BPF_DYNPTR_TYPE_USER. Because
> BPF_DYNPTR_TYPE_USER-typed dynptr is not available from bpf program, so
> no verifier update is needed.
>
> Add dynptr_key_off in bpf_map to distinguish map with fixed-size key
> from map with variable-length. dynptr_key_off is less than zero for
> fixed-size key and can only be zero for dynptr key.
>
> For dynptr-key map, key btf type is bpf_dynptr and key size is 16, so
> use the lower 32-bits of map_extra to specify the maximum size of dynptr
> key.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

This is a great feature and you've put lots of high-quality work into
this! Looking forward to have qp-trie BPF map available. Apart from
your discussion with Alexie about locking and memory
allocation/reused, I have questions about this dynptr from user-space
interface. Let's discuss it in this patch to not interfere.

I'm trying to understand why there should be so many new concepts and
interfaces just to allow variable-sized keys. Can you elaborate on
that? Like why do we even need BPF_DYNPTR_TYPE_USER? Why user can't
just pass a void * (casted to u64) pointer and size of the memory
pointed to it, and kernel will just copy necessary amount of data into
kvmalloc'ed temporary region?

It also seems like you want to allow key (and maybe value as well, not
sure) to be a custom user-defined type where some of the fields are
struct bpf_dynptr. I think it's a big overcomplication, tbh. I'd say
it's enough to just say that entire key has to be described by a
single bpf_dynptr. Then we can have bpf_map_lookup_elem_dynptr(map,
key_dynptr, flags) new helper to provide variable-sized key for
lookup.

I think it would keep it much simpler. But if I'm missing something,
it would be good to understand that. Thanks!


>  include/linux/bpf.h            |   8 +++
>  include/uapi/linux/bpf.h       |   6 ++
>  kernel/bpf/map_in_map.c        |   3 +
>  kernel/bpf/syscall.c           | 121 +++++++++++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h |   6 ++
>  5 files changed, 125 insertions(+), 19 deletions(-)
>

[...]
