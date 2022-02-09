Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D64C4AE97F
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiBIFqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:46:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbiBIFjv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:39:51 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F10C0045A1
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:39:48 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id m8so844456ilg.7
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqQXyrjAsKa/Xf75OvQvRpTW5bHmnbZZCd0DV2cM2GY=;
        b=QIkd2IZTdL/W+Ykr+tx3xA846UD75tn80tBL/KVAtBaynjOz/YLLa4+PZO1WAQ4d1I
         g7WPhF9z0Kikn4osTKwjuc9Rh/0w/GXkGG6enLJV3QY63bS4yr4ebb2ZOsscyj24cqK9
         Xrp5Jccp7jozj70EYtVoZL0lIZ9abnU4Uu9La8xFocMMiWCb1cOwe+PHfXfv+dmwhUn/
         jvXBOSaqIOZ07OedfFZDZs6KMAgEXEQLIpe0+lk5wqD2mwQ4dmXymPj+4PIdroqDBgrK
         aEreAEYq/g0cPPX8VHdxLQy8eycZROGzvAgAaMDmeo0Rpkgt0x9PtOGb4o2U/awtS8Qu
         Td4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqQXyrjAsKa/Xf75OvQvRpTW5bHmnbZZCd0DV2cM2GY=;
        b=5VuU78f+hmYfaqCw98VqmkOQ/DeSdo4l2/L1cxNPT7CHQof7uelvwfgQftbBw2WbEK
         siDwPCNDqkFYL6eyGRTkQXQABIiVzDCt6FYtae/ufP+0D7HB1pv9ect9c5jgc6hKlus2
         tliAYHtecTrwD2rtrZCyy+eicGh9OHLuzKusVsUnX2JDEt6wtns/dkGAT95mpdXwi9xG
         6EgentUiez7swK2GjnjdxYq4lPchRdU1N9FduEP91C8zoS9XKjZ6Eb8i5L5JN/K9SJwX
         HjFMmTGVxfAwiaHyAdxIz1/pd5UubYosMbIJBSomWNA9pr06yO+zfNya6ZT4oEayIzEI
         6oEQ==
X-Gm-Message-State: AOAM532Hyz7agmSIGVZiKihA8W6sam/ufdpFLMRDOMOnVe8EGfHdmvuJ
        suevHUppRVnE0rqupMnRF4ZH1qMm90tDarqcmX0=
X-Google-Smtp-Source: ABdhPJynq9sLryBwvT8+r2fKtKlBAOa9ReVhMrJxGjhz2PRrIKNdGH47nynxfBieToxcybJ7geuHkztdPvhgj1d/3p0=
X-Received: by 2002:a05:6e02:1bcd:: with SMTP id x13mr331440ilv.98.1644385181714;
 Tue, 08 Feb 2022 21:39:41 -0800 (PST)
MIME-Version: 1.0
References: <20220209021745.2215452-1-iii@linux.ibm.com> <20220209021745.2215452-9-iii@linux.ibm.com>
In-Reply-To: <20220209021745.2215452-9-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 21:39:30 -0800
Message-ID: <CAEf4BzZHg2Ju1jkUYeCTgWpubFLOBJDG-QzD91QRxfC8Op3cww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 08/10] libbpf: Allow overriding PT_REGS_PARM1{_CORE}_SYSCALL
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>
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
> arm64 and s390 need a special way to access the first syscall argument.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 41a015ee6bfb..f364f1f4710e 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -269,7 +269,9 @@ struct pt_regs;
>
>  #endif
>
> +#ifndef PT_REGS_PARM1_SYSCALL
>  #define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> +#endif
>  #define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
>  #define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
>  #ifdef __PT_PARM4_REG_SYSCALL
> @@ -279,7 +281,9 @@ struct pt_regs;
>  #endif
>  #define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
>
> +#ifndef PT_REGS_PARM1_CORE_SYSCALL
>  #define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> +#endif
>  #define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
>  #define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
>  #ifdef __PT_PARM4_REG_SYSCALL

I've changed PARM4 handling to be the same as for PARM1 for
consistency (and flexibility, if we ever need as much)


> --
> 2.34.1
>
