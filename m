Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FDE6316DE
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 23:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiKTWe7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 17:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKTWe6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 17:34:58 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3230A222A5
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 14:34:58 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c203so9721728pfc.11
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj1YTiDYMKN+U/iJe/mExzifsiwf4vYVCerk4Qjccqc=;
        b=CTbGoV3ga46W8aGNDeoQF7Isc/tVufgNGyUjCTt7mxLjmr4dtjGLb5hBZq0XgR+BBO
         eVUES3qdlXCz2YupadREAeDB35JzmCc/KqGF/9OAELtAauFDpgo7TDfCn98fRB3jdmGI
         Mo8zf3YEWaspBxCuhLeg8rx1nU4yuzL8PDFQXSvmNypWXY6jFkGvNwlTZaYegY/9GlDm
         efe4DdZ8zV6f7iw1452tpL/Iyz+76ujMR2avHD0WgLsrOON48nTCvTpk8hEUZv6tF/lv
         Gjk6eIyefxlsY3EXYZvvipQ2FwgCC0rmCebM41K8cYsVkI9o14jIl2Ip7szcG38mnV3m
         bBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj1YTiDYMKN+U/iJe/mExzifsiwf4vYVCerk4Qjccqc=;
        b=0IPEqwknrWGIZh2k6qUV0fCcXtQKF8pGWdBphb1PgphAr9976uUowWmuKRDBQx/5iq
         s9LA/ep4brGlqAcN1OD0alrucbyMy5Lyn2g0BYFI7EphRANtJPlWNBrpiJbCKRggeloh
         VWnKe/0gqWa2vC2d0zjLDKSm8YSFdTOSyRdvj4Jy7ArOLVH25wCZpCDIAegTDHN9lvAT
         foYjje8vfeCMlgxCAy1C/CoQwHWDIyZrinnN6ypgG6Zxccca7dYGAhedSWbYP974WnYB
         kO16JYGFvDoPCI/WZOLlP68yiNrTzbD0Fn0EiyYnAPTPWG0zFelJ+4VhhH0dIe8OPlSa
         6q/g==
X-Gm-Message-State: ANoB5pnIKvD98FfZzvQhWwIR45RHHyd/lvd7cpLz6z+p3its77SkMo0Z
        VVsgEI3WKem9i1RZqVTnsSs=
X-Google-Smtp-Source: AA0mqf7fuEmQIAPkuMRzBQrG3dRcQanhMRsN/gzaxhb+MByVxYKEb6UbmIEOqz3rUk/dUdAi4YzuRw==
X-Received: by 2002:a62:f94c:0:b0:56e:174e:efdf with SMTP id g12-20020a62f94c000000b0056e174eefdfmr17257684pfm.29.1668983697635;
        Sun, 20 Nov 2022 14:34:57 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:7165])
        by smtp.gmail.com with ESMTPSA id o67-20020a17090a0a4900b00218b3f1b430sm615389pjo.54.2022.11.20.14.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 14:34:57 -0800 (PST)
Date:   Sun, 20 Nov 2022 14:34:54 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add a kfunc for generic type cast
Message-ID: <20221120223454.ymzd4oqt7nsrbgkn@macbook-pro-5.dhcp.thefacebook.com>
References: <20221120195421.3112414-1-yhs@fb.com>
 <20221120195437.3114585-1-yhs@fb.com>
 <CAADnVQ+92vwqUB=J-QJYtrW0Yqvx2HAJJBREkXPJtW0+gyS1mQ@mail.gmail.com>
 <20221120204930.uuinebxndf7vkdwy@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120204930.uuinebxndf7vkdwy@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 02:19:30AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Mon, Nov 21, 2022 at 01:46:04AM IST, Alexei Starovoitov wrote:
> > On Sun, Nov 20, 2022 at 11:57 AM Yonghong Song <yhs@fb.com> wrote:
> > >
> > > @@ -8938,6 +8941,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > >                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
> > >                                 regs[BPF_REG_0].btf = desc_btf;
> > >                                 regs[BPF_REG_0].btf_id = meta.ret_btf_id;
> > > +                       } else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> > > +                               if (!capable(CAP_PERFMON)) {
> > > +                                       verbose(env,
> > > +                                               "kfunc bpf_rdonly_cast requires CAP_PERFMON capability\n");
> > > +                                       return -EACCES;
> > > +                               }
> >
> > Just realized that bpf_cast_to_kern_ctx() has to be
> > gated by cap_perfmon as well.
> >
> > Also the direct capable(CAP_PERFMON) is not quite correct.
> > It should at least be perfmon_capable().
> > But even better to use env->allow_ptr_leaks here.
> 
> Based on this, I wonder if this needs to be done for bpf_obj_new as well? It
> doesn't zero initialize the memory it returns (except special fields, which is
> required for correctness), so technically it allows leaking kernel addresses
> with just CAP_BPF (apart from capabilities needed for the specific program types
> it is available to).
> 
> Should that also have a env->allow_ptr_leaks check?

Yeah. Good point.
My first reaction was to audit everything where the verifier produces
PTR_TO_BTF_ID and gate it with allow_ptr_leaks.
But then it looks simpler to gate it once in check_ptr_to_btf_access().
Then bpf_rdonly_cast and everything wouldn't need those checks.
