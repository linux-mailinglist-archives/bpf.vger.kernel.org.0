Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5C697480
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 03:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBOCm4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 21:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOCmz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 21:42:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C53A241;
        Tue, 14 Feb 2023 18:42:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jg8so44842046ejc.6;
        Tue, 14 Feb 2023 18:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BR1uv2nDTDOrLd03+m2o4o1sSENoLRVyMOgnbiD8tFw=;
        b=G5Y5AU5c0+uj0o6IXa8n7f40gvj0IuQQnTMrvgz2oouq8bSm/Yx4Nmym1uRx5l0uFp
         BzKfrJpi2XHKHEimG/m/+qzOKzAKekmU4kbShxXdeTkX75fGjNujExDS3aFMjLp4tCSL
         5D6EODgIq/kzp5eHB+lXUNCqiAVfqLgyHfp+oOCoo4lePGuN1dz1MjPwFtCZHN4c/R6u
         t8L7fAP2/h5LkRpJKZd4JWrGL4YDUF/GqsQ+1iCQHMFRu5Q/rtGVoLO7ziycn8P5FCd9
         445XYwY8DjhiEyDapvfp7C5eucFMC6/5zLTPJKquOngFebRb42L5WaunetTvvI1EABNJ
         gClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BR1uv2nDTDOrLd03+m2o4o1sSENoLRVyMOgnbiD8tFw=;
        b=j1k1Tl12KXjtj2WJD6FG73lYN+a7l22N+UbU8B9zur23Fk8lnoNpFWREp7yWFGmEV1
         6kO+iEGZqiIwUQjHgvbtgZbAaT0mzwdIuNZFY5aszmkgrVaWgAn9Y+i40HaUyx9okXwx
         9esI2EsB/yAjqjfU/L6f2V+ePf6oLZvGnzgr1bLu9mGlQVgHIlr1qaFso80D/T8E87h5
         9VTK4LsZUUdkgDOVW/H71+x7kfIliG3MWGkGwW+tDUBu0oK1EAx2Bn+nrNg+PBc8BL7c
         Eiu7Q8yGD1KChT7wYIuBtx1qz8Iy2delQZHUqfIiDdFpbI89B1hqjNMKiW3H3+2Jfnyj
         ARLw==
X-Gm-Message-State: AO0yUKVb4Ukstof3i8N4GYrztbNwX/lDuA0PasNDNnSuI9rbVuSPV8tl
        DUQjDld1nTn0d5OUHTCScTZqNKu7v0QoNhZNROM=
X-Google-Smtp-Source: AK7set+3mwTsN57VCAY2PZdW2x1zTSyn4/sptrg9kWDbeue8XGQkIY49VCN7z4New6hr3JdMQogAj6XCORvK+MRJ+Wo=
X-Received: by 2002:a17:906:2dd8:b0:8b1:2898:2138 with SMTP id
 h24-20020a1709062dd800b008b128982138mr306819eji.3.1676428972462; Tue, 14 Feb
 2023 18:42:52 -0800 (PST)
MIME-Version: 1.0
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com> <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com> <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com> <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo> <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com> <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
 <19bf22cd-2344-4029-a2ee-ce4bcc1db048@huaweicloud.com>
In-Reply-To: <19bf22cd-2344-4029-a2ee-ce4bcc1db048@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Feb 2023 18:42:41 -0800
Message-ID: <CAADnVQ+ZVDgiBMFrCpqjZK6kTLfOF_2zxRBMqvHZmoUZW5p3=A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Tue, Feb 14, 2023 at 6:36 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 2/12/2023 12:33 AM, Alexei Starovoitov wrote:
> > On Fri, Feb 10, 2023 at 5:10 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >>>> Hou, are you plannning to resubmit this change? I also hit this while testing my
> >>>> changes on bpf-next.
> >>> Are you talking about the whole patch set or just GFP_ZERO in mem_alloc?
> >>> The former will take a long time to settle.
> >>> The latter is trivial.
> >>> To unblock yourself just add GFP_ZERO in an extra patch?
> >> Sorry for the long delay. Just find find out time to do some tests to compare
> >> the performance of bzero and ctor. After it is done, will resubmit on next week.
> > I still don't like ctor as a concept. In general the callbacks in the critical
> > path are guaranteed to be slow due to retpoline overhead.
> > Please send a patch to add GFP_ZERO.
> I see. Will do. But i think it is better to know the coarse overhead of these
> two methods, so I hack map_perf_test to support customizable value size for
> hash_map_alloc and do some benchmarks to show the overheads of ctor and
> GFP_ZERO. These benchmark are conducted on a KVM-VM with 8-cpus, it seems when
> the number of allocated elements is small, the overheads of ctor and bzero are
> basically the same, but when the number of allocated element increases (e.g.,
> half full), the overhead of ctor will be bigger. For big value size, the
> overhead of ctor and zero are basically the same, and it seems due to the main
> overhead comes from slab allocation. The following is the detailed results:

and with retpoline?
