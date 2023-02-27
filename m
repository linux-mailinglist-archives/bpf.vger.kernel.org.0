Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005276A4BD8
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 20:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjB0T7i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 14:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB0T7h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 14:59:37 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5B27486
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:59:28 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536af432ee5so209879577b3.0
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2BoiLY/I9WZPLsn2jXn4mX6U7XPZEaMkqMyIa9hfL10=;
        b=Q4AkdwHPpx997feSrVIE9BbxxhhozlCs2weq6+pFXJFIJmDHhk9pjiqKGfiV5XIEhx
         zM48hh0q0L09BaKsmmNgcn+Cx7kOBB2dt0XrU559BFrubs/0Spe2uuMpr9Yxf96lmsS6
         Y53w/Gc7o3Bl3Uzc46zu/zTNANvdOKDDrQchaslJcmvSbXiGEQJeDJ8p9ym2K8HEKMpm
         wmx1GbeeeENMPFMaT6P1RxH3reZvizn68UvqBjqWe/iAygdsF8Rvqmzs+MZCKtvEnFa0
         oOW8jc1bX6TkReInMJ6Aekw4PV27CSy2VGJfrRtQrHn+Rsg1j4Vy1pagDi5TIOgOfkcE
         mYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BoiLY/I9WZPLsn2jXn4mX6U7XPZEaMkqMyIa9hfL10=;
        b=AHN7UIpuwjwimT4ilEq7Q4ARuV20QU6Bqlzin9jLcM5lMHd2RA3nfKq9dqclFLgA2o
         I3HJwtk2KQkhKS0mPvxYDv2k/tf0QpHpWt/IMgCvah0vz0LUSapqpoyumAngSnWWr5nv
         AnKUswzYUruC0IGZBqavp11lHUIeUQnbg/7iVW8aCvnfzQ8BLQswhkVuT0ZIWM3jgmuf
         +uMRno0zh+1HV28gYJRg+1nCVNCdveUME/uNZ15u7oSt6HzaPVoRKZLcq1TB9WXbSizJ
         Vo8HAFvDfVK+qPqWwWv6soiRmCkZGRlAWJyeA5WmobWHc6aiPwxDcoBnAKAgkSZO2aPz
         3sow==
X-Gm-Message-State: AO0yUKWyV1wUQ0Oo4s94EWjblDDejSx3FIb0ZmMdRRc59lkE90/2pabM
        79wOkfQB0CBEDLAqIQ2guHD+0zcu49CLO3Tbp2Khl3rd
X-Google-Smtp-Source: AK7set+HvKcpQerpw3hU6gXSfaDs+Thhw6WHF3TeuuKoczmMGsbRc+UuPRSjWsSy/Dtw8u4YphSXUGKxc8K29qdw+cw=
X-Received: by 2002:a81:b621:0:b0:52e:b7cf:4cd1 with SMTP id
 u33-20020a81b621000000b0052eb7cf4cd1mr11025962ywh.5.1677527968030; Mon, 27
 Feb 2023 11:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20230223095346.10129-1-puranjay12@gmail.com>
In-Reply-To: <20230223095346.10129-1-puranjay12@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 11:59:07 -0800
Message-ID: <CAEf4BzZH2L+9ZgvHQ0jpHr-i2Zh7r-Vb0-MM=EcGcTw---ioHw@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Fix arm syscall regs spec in bpf_tracing.h
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     puranjaymohan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, iii@linux.ibm.com,
        quentin@isovalent.com
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

On Thu, Feb 23, 2023 at 1:53 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> The syscall register definitions for ARM in bpf_tracing.h doesn't define
> the fifth parameter for the syscalls. Because of this some KPROBES based
> selftests fail to compile for ARM architecture.
>
> Define the fifth parameter that is passed in the R5 register (uregs[4]).
>
> Fixes: 3a95c42d65d5 ("libbpf: Define arm syscall regs spec in bpf_tracing.h")
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
> Changes in V1[1]->V2:
> - Fix signed-off-by and send-from emails.
>
> [1] https://lore.kernel.org/bpf/20230223094717.9746-1-puranjay12@gmail.com/T/#u
> ---
>  tools/lib/bpf/bpf_tracing.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 6db88f41fa0d..2cd888733b1c 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -204,6 +204,7 @@ struct pt_regs___s390 {
>  #define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
>  #define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
>  #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
> +#define __PT_PARM5_SYSCALL_REG uregs[4]

that's an "interesting" omission on my part, thanks for catching and fixing!

>  #define __PT_PARM6_SYSCALL_REG uregs[5]
>  #define __PT_PARM7_SYSCALL_REG uregs[6]
>
> --
> 2.39.1
>
