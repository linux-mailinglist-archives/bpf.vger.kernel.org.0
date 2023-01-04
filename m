Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2500465DF04
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 22:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbjADV2T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 16:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbjADV2A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 16:28:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C2D42E15
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 13:21:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u9so85897588ejo.0
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ2sdJqOOH0xkTd/98w/9p+A1fU95LvCEavMdkHzweI=;
        b=PdTuyi53UuT18vgpKHJjY7uSP8VP6giXTgGxOe6mR2JxwrQ/U8Px1diHcIgzxwNj+O
         MDQb+oa0Qkt6aCAIy7mEThKJ8vFGJSSAZ+t/ZLi7uDzJT7HXOhckL6WyOGtnmzE6xGOA
         fkFlz6WKUlDwcqfvmDX8Ccv5VBGVCZlYvgnOj4+OtIeHJKtM+BPJvCbLFChWzWEUN+dF
         MSFIE+vhlQsfjCNO88jPTrMTVoSOF5OmEWxNJGkYFPbstsvL0Ruz0bS/Yv8JN4pEePnM
         8uMoOHUCQ6362B9m7XEJWtb+wGTsUZ+2c9abrr6BnCDRWByCrGMdGBKPpcsmO3jU5Cd7
         R0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ2sdJqOOH0xkTd/98w/9p+A1fU95LvCEavMdkHzweI=;
        b=b7DI5ixbRpNtG7o0QQ5eMhcw9jq7kQgnLD083Z1z3RxypCCbNmeedYLF9gF4ViGJgu
         WFc2vkLpT5jcDr9ReI64KquoMCJS6KjhRr2m/ojdfHY2mhUwkXexEB2cmkEpuSlhFQT5
         209OvKpv5LmtEngAvbKStV6rSgf7RhbIINQfWpkufa2AgWRj+vnUZ0wZb/fNvVukoFf/
         dd+TAWJSrd01WBzzRuc5+txKAqJMzWFij6z/kmyyJJlis12ib/VUMLxT3I/RqLKhuExY
         AJEbbpl1U6wPUfmXunWFsdKyoP1+k19BcRCcxeW/DVv2O1SNi1IUiVfEYD8K29AgIA57
         5zaw==
X-Gm-Message-State: AFqh2kp2lassGqvzC7A46r3pvt/PsbWQOUxpwdb/sC23X69m7YAv6GkK
        sbMdZ+jNTk8JJiILXRfJyJuMF+/lLAYmN0X+DqebrJqCTq0=
X-Google-Smtp-Source: AMrXdXvxctyc+zNdJS8n34fkCTEioKQ2cLeFmWKbMyUFo/PW6MdlV6HbOcQrcBD9DHFsCSnE90VIAIIZK50xlAlvAuc=
X-Received: by 2002:a17:907:2917:b0:838:1b80:9a7b with SMTP id
 eq23-20020a170907291700b008381b809a7bmr6238202ejc.708.1672867291941; Wed, 04
 Jan 2023 13:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20221216221855.4122288-1-kuifeng@meta.com> <691f88317785d0114a1c6b3626be7b7538b1978f.camel@fb.com>
In-Reply-To: <691f88317785d0114a1c6b3626be7b7538b1978f.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Jan 2023 13:21:20 -0800
Message-ID: <CAADnVQ+uPF=xB92a+pTJqAgg1CGbH-XSOH0M=c6mhUGCdSM-nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: fix the crash caused by task
 iterators over vma
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     Kernel Team <kernel-team@meta.com>, Yonghong Song <yhs@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Wed, Jan 4, 2023 at 1:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>
> Hi everyone,
>
> This patchset seems to be forgot during the holiday season.
> Hope this message gets some notice.

It was applied to bpf tree
commit 7ff94f276f8e ("bpf: keep a reference to the mm, in case the
task is dead.")
