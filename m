Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2468A4D8
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 22:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjBCVri (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 16:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCVrh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 16:47:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917DD8E063
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 13:47:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ml19so19206642ejb.0
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 13:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aL+5rVKkcEL5iDK242DQxLEQS1JDoWVjXx852HO1HB4=;
        b=LjgVZRviCkruwvECrJBwjKfkL/uANLqJPPbfPrhp//tkSmrGJu36Ur/BUDWISxDM9I
         uXB+w4Xxe13YhsqCOklklNcRsnldCVkH6GsSvHMC6zxlGJtACF9aIXliuqiGh2xMQIQM
         gFP0ux80xwtS9HU8+hZrvAxZbGs2pZ+fc8AEoVfmdncwIlpOFmuqriUMVEGr71/P/YSN
         5zoVBsWLhMENPy0MEPT9oSaBRq+F12uAmJ17fPdQa6+T8nmngR4+GSHs3PTx97VQa4hp
         aD4VM76QvBc8z5iIWdwzR2NvkfE6sAjpl3t1asWegsaDirMGIRF1vj3znMpMspPZadmt
         Mdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aL+5rVKkcEL5iDK242DQxLEQS1JDoWVjXx852HO1HB4=;
        b=0hmjsK9cnTBMM/SvtrSgglbLv3JYzmfsKEewmDDO+UUus+Jpk7HOeuOqKhXWxj6VyX
         R5mOK0SQMdXWIKIG5NShsYpYfIvy/V232XbAOdxsyuNyjqAq122PiIuXwmiLLh4RQc+k
         bkz5PVY8mJbULnz+N3kSEXoCO+fv2aXA39r4+9RlvFM3/GJnnNlz4iBCJCNwuvfk1d3O
         TsxFz5Zt6G+jA8NQ5Ri1V2LZ2aUdOt8lSRqBdn1UwoIVjdwENwsLtSw1Wv1QcrUTwBQw
         FeCFd9OvP1lFoglnOumCIGXTlEJTI6lRHHkktFT93ieBuk9fR1cIqvyo5bGujTaQ41h0
         vmSg==
X-Gm-Message-State: AO0yUKUKHbIBTncvQ5H4hYh/jRdnI+9lvI8BOY3zD5Q6eYDxDKSrxadD
        hRQat6iLA48SUNoQkz1T/Zf2S3eeknMwx7oa3Zo=
X-Google-Smtp-Source: AK7set/K9KjilbFqCyh1UBgpnhF+2niJaLkl2fGGeioFQwyMEFQW+8PHjJyxuVlMxJV3MQhFS+8GI9E8Nzk8d647LIs=
X-Received: by 2002:a17:906:cb9a:b0:877:5b9b:b426 with SMTP id
 mf26-20020a170906cb9a00b008775b9bb426mr3133751ejb.12.1675460855104; Fri, 03
 Feb 2023 13:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20230203080849.2462797-1-hao.xiang@bytedance.com>
In-Reply-To: <20230203080849.2462797-1-hao.xiang@bytedance.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Feb 2023 13:47:23 -0800
Message-ID: <CAEf4BzZ74W0Vx_7+7CU0co6fKHEmo7XP+wJ+wb2HHxDnSRqP+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/1] libbpf: Correctly set the kernel code
 version in Debian kernel.
To:     Hao Xiang <hao.xiang@bytedance.com>
Cc:     bpf@vger.kernel.org, Ho-Ren Chuang <horenchuang@bytedance.com>
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

On Fri, Feb 3, 2023 at 12:17 AM Hao Xiang <hao.xiang@bytedance.com> wrote:
>
> In a previous commit, Ubuntu kernel code version is correctly set
> by retrieving the information from /proc/version_signature.
>
> commit<5b3d72987701d51bf31823b39db49d10970f5c2d>
> (libbpf: Improve LINUX_VERSION_CODE detection)
>
> The /proc/version_signature file doesn't present in at least the
> older versions of Debian distributions (eg, Debian 9, 10). The Debian
> kernel has a similar issue where the release information from uname()
> syscall doesn't give the kernel code version that matches what the
> kernel actually expects. Below is an example content from Debian 10.
>
> release: 4.19.0-23-amd64
> version: #1 SMP Debian 4.19.269-1 (2022-12-20) x86_64
>
> Debian reports incorrect kernel version in utsname::release returned
> by uname() syscall, which in older kernels (Debian 9, 10) leads to
> kprobe BPF programs failing to load due to the version check mismatch.
>
> Fortunately, the correct kernel code version presents in the
> utsname::version returned by uname() syscall in Debian kernels. This
> change adds another get kernel version function to handle Debian in
> addition to the previously added get kernel version function to handle
> Ubuntu. Some minor refactoring work is also done to make the code more
> readable.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> ---

yes, the patch looks correctly formatted, but you haven't addressed
all the feedback. Please check my last reply on previous version and
submit a new version with feedback addressed. Thank you.

>  tools/lib/bpf/libbpf.c        | 37 --------------
>  tools/lib/bpf/libbpf_probes.c | 93 +++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+), 37 deletions(-)
>

[...]
