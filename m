Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19756C380
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbiGHWFI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiGHWFH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 18:05:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5F9CE33
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 15:05:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id n8so171942eda.0
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xq1t+A6HSFTNWySW+PmE9usV7wae6cQs5yr2yyg0JeI=;
        b=MJkkIulRRrwCnfXrRWiWTB5exC68JhteVMUQ0zZM9W10Es98tIsLUJpW+Y1SDLtFGx
         LhAVM/PfW1GFxrBexcr+LzpdUVx/BMjlE0cBizJpyfIUwBCyGDqQtWfPb7Hnh1AjQqNL
         NWc1/l+8qJvv7+XpIP0ZmoilK/fjh5yqkCSx++sewZsDDcuMtHP89aNNev+juS2qXidH
         //Wj22kAdfcr0nduY11mTF17QsJt9j4tta6bS4zta+xc3GtvAk0xMjYMd7+KWdzQF6ff
         Kqt+Ey7muLxEfI21ys4kXkUrpWb26qY6LD5PlM+tv97798EOyEvpLSQI00nF9Lo7FCwo
         fUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xq1t+A6HSFTNWySW+PmE9usV7wae6cQs5yr2yyg0JeI=;
        b=QQETQ8GRc3m3rDfT9MwOmViCsIhF34ugokt5fTbb4YxWjZQRI/lwtl7PXtsbtao5j8
         VgrvHcjies2WrtR8Bk12vEmuN1g66PlVfWXRMg/E5d5RfQTxc1OxdUdVbg2xvBnZTdFq
         CKTOSlMbevNdFLYDXgB1Ii60QWdtxldQRMA9BhMvMM4coNL0XXCPJOsNe6I/IYCq4oxU
         fBkgGAPbqwqBrXzRGqYfhpNk+q5MOjswnwcsNGGjLeT+ZLSpfcPZnMkjT4Egjdaog8et
         Lu9y5Z08QcGvrqFFKGiT27qadnmomfrXjXYIbQO4cveaizm4ztiFwK2eFH+H+CpK36jI
         B5bw==
X-Gm-Message-State: AJIora8N/WIVNpK9bNwvhZ9rZJpj8biMWARtnOkhHj7kHSkaOrlx3POf
        /n5CoNK4hKfTEyKdXXzirDc5fQnmbzXGkYEa8Hc=
X-Google-Smtp-Source: AGRyM1vRTJfXmAL0rdzCuFEZf5icPH7Nakt+jQY46lAvJVtw3psN9Cqxi4kul5JGyBC9+0vCIprSMcL/14S3i5hrOLY=
X-Received: by 2002:a05:6402:228f:b0:43a:896:e4f0 with SMTP id
 cw15-20020a056402228f00b0043a0896e4f0mr7453722edb.81.1657317905431; Fri, 08
 Jul 2022 15:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <20220707004118.298323-3-andrii@kernel.org>
 <Ysf6TRzh9hgsAjep@krava>
In-Reply-To: <Ysf6TRzh9hgsAjep@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jul 2022 15:04:54 -0700
Message-ID: <CAEf4BzZfrXdE_qST8PDJQd6GMVokGeo1w7qjZHxk0Ae-ggyKkQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
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

On Fri, Jul 8, 2022 at 2:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Jul 06, 2022 at 05:41:17PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > +static int probe_kern_syscall_wrapper(void)
> > +{
> > +     /* available_filter_functions is a few times smaller than
> > +      * /proc/kallsyms and has simpler format, so we use it as a faster way
> > +      * to check that __<arch>_sys_bpf symbol exists, which is a sign that
> > +      * kernel was built with CONFIG_ARCH_HAS_SYSCALL_WRAPPER and uses
> > +      * syscall wrappers
> > +      */
> > +     static const char *kprobes_file = "/sys/kernel/tracing/available_filter_functions";
> > +     char func_name[128], syscall_name[128];
> > +     const char *ksys_pfx;
> > +     FILE *f;
> > +     int cnt;
> > +
> > +     ksys_pfx = arch_specific_syscall_pfx();
> > +     if (!ksys_pfx)
> > +             return 0;
> > +
> > +     f = fopen(kprobes_file, "r");
> > +     if (!f)
> > +             return 0;
> > +
> > +     snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
> > +
> > +     /* check if bpf() syscall wrapper is listed as possible kprobe */
> > +     while ((cnt = fscanf(f, "%127s%*[^\n]\n", func_name)) == 1) {
>
> nit cnt is not used/needed

yep, leftovers, nice catch

>
> jirka
>
> > +             if (strcmp(func_name, syscall_name) == 0) {
> > +                     fclose(f);
> > +                     return 1;
> > +             }
> > +     }
> > +
> > +     fclose(f);
> > +     return 0;
> > +}
> > +
> >  enum kern_feature_result {
> >       FEAT_UNKNOWN = 0,
> >       FEAT_SUPPORTED = 1,
> > @@ -4722,6 +4781,9 @@ static struct kern_feature_desc {
> >       [FEAT_BTF_ENUM64] = {
> >               "BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
> >       },
> > +     [FEAT_SYSCALL_WRAPPER] = {
> > +             "Kernel using syscall wrapper", probe_kern_syscall_wrapper,
> > +     },
> >  };
> >
>
> SNIP
