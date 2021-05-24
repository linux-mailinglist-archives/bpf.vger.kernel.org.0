Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133C138F37E
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 21:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhEXTLV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhEXTLT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 15:11:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE302C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 12:09:49 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n10so28948016ion.8
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+Guu9x1ZPLAivxm5q/M8ZHARPFU5YqRnu1JQkwy11us=;
        b=ok4W1d73jlfRrPAhIZOY/RKGDwfK/tkcXfxF4Nd2BaiXnriRiOf3CzQITPMDOcAozH
         4JMmpj8NrPMmAaKV/uXncG1THg1Km3R8L4LznB9QZlwOOZvIamoheOWdsff0hEqNfbrb
         SigSxjjhR35123A4l3SIzxSIYMes+W4vG1WBJ+ORc/qIGWXdnR8uO88iLvbxDckPONMH
         ORmbBQg+KDMvBxbVTJpeRUKpWdBX0K3xeFtQuNNF3s9+pl0skyK1CT2LZA/QnvmLCqcV
         IopTa/S5Lc6JfybUk0CN31YrlaZ3UKRJsIL1mRUfxL7OSQQCt20e5xN0BpFN6MD0N5xu
         N+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+Guu9x1ZPLAivxm5q/M8ZHARPFU5YqRnu1JQkwy11us=;
        b=E2avKLc2QRvVA/2y85CxQM1n3b/X7CugXOvlGsPsDZ2xfeCdEnlRFhN/WtHhLqWXR4
         GXxM4ET8pfKou1PmoEiTanCiErOWIfvaO2YFvjwe8+03JBC3+IYwqd656J/9yQiax+gH
         nQCziaklUk8P88m5J2KciGQrU0BrtyKvZYmUnbKciZ7ys0E2kXSRAqvu1nlo7/lp6DfR
         zbVbIjX86WY5rMjkzsb/BICFTMv1NFYRU1ivb+++e27NxqULECaOOmRUP2eIKR8mQutq
         X/oA7LSBUtRbPIqZbsrmL/R6ipZPOBx44xMgC3lhMjTiBAUNhXez13oNvfOFR4Qp8J2k
         uCmA==
X-Gm-Message-State: AOAM532KrsvrTRUe9RyqGJOGcKlyZ/7Rp0xnq/T1IaLV+2i+1pRv4OEK
        EwudW2f2m33ZiXndOGI3X+I=
X-Google-Smtp-Source: ABdhPJyfzvmaeCkzQlKw6N2/geRsH+hVuNZ5ahe3YGjBu4hqUt2mdPWRcj9ave1VM7F7baQn2S0Skg==
X-Received: by 2002:a5d:8481:: with SMTP id t1mr17515800iom.39.1621883389159;
        Mon, 24 May 2021 12:09:49 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id t12sm11766337ilm.69.2021.05.24.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 12:09:48 -0700 (PDT)
Date:   Mon, 24 May 2021 12:09:40 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Message-ID: <60abf9f4acc78_135f620819@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzYSUzhhFC-wujFfXVPkWfv3cY9_c_12h2YLw=+uUtEpLg@mail.gmail.com>
References: <20210522162341.3687617-1-yhs@fb.com>
 <CAEf4BzYSUzhhFC-wujFfXVPkWfv3cY9_c_12h2YLw=+uUtEpLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add support for new llvm bpf relocations
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Sat, May 22, 2021 at 9:23 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > LLVM patch https://reviews.llvm.org/D102712
> > narrowed the scope of existing R_BPF_64_64
> > and R_BPF_64_32 relocations, and added three
> > new relocations, R_BPF_64_ABS64, R_BPF_64_ABS32
> > and R_BPF_64_NODYLD32. The main motivation is
> > to make relocations linker friendly.
> >
> > This change, unfortunately, breaks libbpf build,
> > and we will see errors like below:
> >   libbpf: ELF relo #0 in section #6 has unexpected type 2 in
> >      /home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_tcp_nogpl.o
> >   Error: failed to link
> >      '/home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_tcp_nogpl.o':
> >      Unknown error -22 (-22)
> > The new relocation R_BPF_64_ABS64 is generated
> > and libbpf linker sanity check doesn't understand it.
> > Relocation section '.rel.struct_ops' at offset 0x1410 contains 1 entries:
> >     Offset             Info             Type               Symbol's Value  Symbol's Name
> > 0000000000000018  0000000700000002 R_BPF_64_ABS64         0000000000000000 nogpltcp_init
> >
> > Look at the selftests/bpf/bpf_tcp_nogpl.c,
> >   void BPF_STRUCT_OPS(nogpltcp_init, struct sock *sk)
> >   {
> >   }
> >
> >   SEC(".struct_ops")
> >   struct tcp_congestion_ops bpf_nogpltcp = {
> >           .init           = (void *)nogpltcp_init,
> >           .name           = "bpf_nogpltcp",
> >   };
> > The new llvm relocation scheme categorizes 'nogpltcp_init' reference
> > as R_BPF_64_ABS64 instead of R_BPF_64_64 which is used to specify
> > ld_imm64 relocation in the new scheme.
> >
> > Let us fix the linker sanity checking by including
> > R_BPF_64_ABS64 and R_BPF_64_ABS32. There is no need to
> > check R_BPF_64_NODYLD32 which is used for .BTF and .BTF.ext.
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

> 
> LGTM. Is there a chance that those relocations will get renamed or
> expanded before LLVM diff lands? Or it's safe to apply now and LLVM
> side won't change much?
> 
> >  tools/lib/bpf/libbpf_internal.h | 6 ++++++
> >  tools/lib/bpf/linker.c          | 3 ++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 55d9b4dca64f..e2db08573bf0 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -28,6 +28,12 @@
> >  #ifndef R_BPF_64_64
> >  #define R_BPF_64_64 1
> >  #endif
> > +#ifndef R_BPF_64_ABS64
> > +#define R_BPF_64_ABS64 2
> > +#endif
> > +#ifndef R_BPF_64_ABS32
> > +#define R_BPF_64_ABS32 3
> > +#endif
> >  #ifndef R_BPF_64_32
> >  #define R_BPF_64_32 10
> >  #endif
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index b594a88620ce..1dca41a24f75 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -892,7 +892,8 @@ static int linker_sanity_check_elf_relos(struct src_obj *obj, struct src_sec *se
> >                 size_t sym_idx = ELF64_R_SYM(relo->r_info);
> >                 size_t sym_type = ELF64_R_TYPE(relo->r_info);
> >
> > -               if (sym_type != R_BPF_64_64 && sym_type != R_BPF_64_32) {
> > +               if (sym_type != R_BPF_64_64 && sym_type != R_BPF_64_32 &&
> > +                   sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32) {
> >                         pr_warn("ELF relo #%d in section #%zu has unexpected type %zu in %s\n",
> >                                 i, sec->sec_idx, sym_type, obj->filename);
> >                         return -EINVAL;
> > --
> > 2.30.2
> >


