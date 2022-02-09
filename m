Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AC4AE977
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiBIFqH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:46:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiBIFjw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:39:52 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880FDF28B1F
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:39:51 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i62so1878251ioa.1
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkEA6kWv8KerwGputwTYPdNnTOFeRt6LMixpCSRieOU=;
        b=nvPcJjmB7SZw15JhT0DoMfw1aaLxYrorSmJ5u0AIyn+TNxrKSfDmQeLkMGF7BH43mX
         QxVDflnV9JZer3uRiTSeB0fLXufV3IUL+uVCaf73EHi/mjJy3d/CW4BYtQK90fjbB/oR
         IJ3Dv27Dz2rJvDM6M0bodUTEZswfi79afbXVMDWav2ZuiKPwFCg2OkRzOcpcnnoYMftL
         WigWd14lbD9TWm8tUO/Rw6F1He9dJrmgj1t3JHLFWPz/pAghg6EVTO28DdxofviLYUEt
         fdc8bhI06Xu3uXxmAcyLIfguZzRHE6w9wK7V4BlU/120M7SYVuxiGHz1lAYAplw+C6m2
         QM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkEA6kWv8KerwGputwTYPdNnTOFeRt6LMixpCSRieOU=;
        b=SkSX5yhMFEsa+RHKIptzNgCLw0ficfGX0sriVD12bRnC1J5D3Zc8JOFqz+2hsV4IFa
         DZUSWO2K0jAZQHjoC1bcUCC+wAwP3Sd+PH2co+82lLK4jau1YTvU76zQWYF/onGFU5Yi
         KUIRu41oaz30fZjq6vMoeJA3W/YnT3ZYB48brjdmjhMcOdQNMhxTrwfLkqzkVEic+9zn
         hgzZPCqKRpnqqvf07r5XPcucVYI9C2PDo9K0HDVPI+TK0tn+/b4HIQl5o8tfTYyD6RRT
         xPLtTmVP0Bwzfkjtd8IvaYDRekLuXDD9G9asiy0elcwoLjIqU9fty89bng92sebHImkc
         vEFA==
X-Gm-Message-State: AOAM532GCr5Dj8aqEG/zfxRE3V5xVc34dnUFlZOymQncjIyy6/M8URi2
        BrgoJXGdxYre+xGTFjFdtejaFJL4CbSKbPTOWhg=
X-Google-Smtp-Source: ABdhPJyJmTxSrM7G0wvNVvu7ls7IoqcfkIrFWtS6IHsWKKo+JvTxUVIClh7hS+YG+OXxHDG7uvZt1WXlwPL78THkxrQ=
X-Received: by 2002:a05:6638:2606:: with SMTP id m6mr219313jat.93.1644385190497;
 Tue, 08 Feb 2022 21:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20220209021745.2215452-1-iii@linux.ibm.com> <20220209021745.2215452-11-iii@linux.ibm.com>
In-Reply-To: <20220209021745.2215452-11-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 21:39:39 -0800
Message-ID: <CAEf4BzbVSq5sogCv-iZpyY-_SV7iudGv7grKmKw4XLNhOYd-SA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 10/10] libbpf: Fix accessing the first syscall
 argument on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 8, 2022 at 6:18 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On s390, the first syscall argument should be accessed via orig_gpr2
> (see arch/s390/include/asm/syscall.h). Currently gpr[2] is used
> instead, leading to bpf_syscall_macro test failure.
>
> orig_gpr2 cannot be added to user_pt_regs, since its layout is a part
> of the ABI. Therefore provide access to it only through
> PT_REGS_PARM1_CORE_SYSCALL() by using a struct pt_regs flavor.
>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 928f85f7961c..0e0414801457 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -114,9 +114,19 @@
>
>  #elif defined(bpf_target_s390)
>
> +struct pt_regs___s390 {
> +       unsigned long orig_gpr2;
> +} __attribute__((preserve_access_index));
> +
>  /* s390 provides user_pt_regs instead of struct pt_regs to userspace */
>  #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
>  #define __PT_PARM1_REG gprs[2]
> +#define PT_REGS_PARM1_SYSCALL(x) ({ \
> +       _Pragma("GCC error \"PT_REGS_PARM1_SYSCALL() is not supported on s390, use PT_REGS_PARM1_CORE_SYSCALL() instead\""); \
> +       0l; \
> +})
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) \
> +       BPF_CORE_READ((const struct pt_regs___s390 *)(x), orig_gpr2)

same manipulations as on previous patch


>  #define __PT_PARM2_REG gprs[3]
>  #define __PT_PARM3_REG gprs[4]
>  #define __PT_PARM4_REG gprs[5]
> --
> 2.34.1
>
