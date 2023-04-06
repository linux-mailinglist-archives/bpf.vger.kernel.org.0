Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156FA6DA225
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbjDFUDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 16:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjDFUDR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 16:03:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C725D9033
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 13:03:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-932277e003cso133340766b.3
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680811394; x=1683403394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3je9yarvK+0HYdVu4thcLJxFZ0H/sLuYdimSj8MuCg=;
        b=VKGDdikXtY3g3SMhpWfzkfODV1WBapVeW/gEIOPpu25gol69+/jVugrhZGO/qxYaBE
         qAI3UAy/d+TEXJ/eFavrJuxLawMnwnybS6t8RZN5wfR5YMx+hPM4PouSLP/kEj+otAnr
         zDfcwBkklGsBY7o8Yu3ggMffgQCObCsd2T4FyePXXPupK9sNxKHxShiSi8r25qH76Gkc
         uoRTWP09neo4ZidGG2IX649DJDTQywSlPP7C1AI3oztsF8+oxvnsrQI3yrFeAUGkfZM2
         E+0LJDge2MuhnWu/50cLLzgwCVFlR8a2rAwVvs0Mq5vcJiPbg4zPnLn7j8H2pWVvEyb3
         hqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811394; x=1683403394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3je9yarvK+0HYdVu4thcLJxFZ0H/sLuYdimSj8MuCg=;
        b=FHYwSK6S+w9oWkv+oNLn8vh68qbu4iv5EQ7aAyi69UnNWKFVNtyCWM4hGxCinF3mcL
         UfeXt/4e4SZt2PTz55FmhPF+Rpkjo34xZmC334+sTXUXa0D/H12JE/noJBKi1/w6WEqe
         8ly4Wkpr1MfsPxpbQRhkTVl3rKEY19RdRImLTAW+ZXgBA5+OjfXNmoxK64ceXpmbAxrx
         6vKT9zoj0iR8RaC2GxkTEo/HmARCDX+GmFN+uC1OaoB4tVs1ujX7PGXVGGka4e15B9Cx
         SGAnei3c18Azi9H/MSXCZ+FI1aG0Gl7vcNwjG3oXZfyjWfF85olJMYrXEf4ageoJQhTy
         sCbg==
X-Gm-Message-State: AAQBX9d7uetsGaLEnY/UvitU1/ymp4x6cXtq3fiDVxDdnbva6nAr/tbD
        McOls2P5FBQxAx1MYJqj/O+glKaqUhEjv+kqglE=
X-Google-Smtp-Source: AKy350Zz1d25GKLCmkJKsNALYXLNG9I7m4OUWSwkOsH8KoimlWExQpfuohB5ywFHKwTBziqqeGLhfw8aTcLiP8pwmqE=
X-Received: by 2002:a50:d6da:0:b0:4fc:ebe2:2fc9 with SMTP id
 l26-20020a50d6da000000b004fcebe22fc9mr368024edj.3.1680811394000; Thu, 06 Apr
 2023 13:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230406164450.1044952-1-yhs@fb.com> <20230406164455.1045294-1-yhs@fb.com>
 <bcdb8bde-6aa2-5f01-f03d-53498330f623@meta.com>
In-Reply-To: <bcdb8bde-6aa2-5f01-f03d-53498330f623@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Apr 2023 13:03:02 -0700
Message-ID: <CAADnVQJQ=oJDb8+SQ9R-dNC9irgZRUYLKFFg+VfXRwBCXNS1Rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Improve verifier JEQ/JNE insn branch
 taken checking
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 6, 2023 at 10:49=E2=80=AFAM Dave Marchevsky <davemarchevsky@met=
a.com> wrote:
>
>
>
> On 4/6/23 12:44 PM, Yonghong Song wrote:
> > Currently, for BPF_JEQ/BPF_JNE insn, verifier determines
> > whether the branch is taken or not only if both operands
> > are constants. Therefore, for the following code snippet,
> >   0: (85) call bpf_ktime_get_ns#5       ; R0_w=3Dscalar()
> >   1: (a5) if r0 < 0x3 goto pc+2         ; R0_w=3Dscalar(umin=3D3)
> >   2: (b7) r2 =3D 2                        ; R2_w=3D2
> >   3: (1d) if r0 =3D=3D r2 goto pc+2 6
> >
> > At insn 3, since r0 is not a constant, verifier assumes both branch
> > can be taken which may lead inproper verification failure.
> >
> > Add comparing umin/umax value and the constant. If the umin value
> > is greater than the constant, or umax value is smaller than the constan=
t,
> > for JEQ the branch must be not-taken, and for JNE the branch must be ta=
ken.
> > The jmp32 mode JEQ/JNE branch taken checking is also handled similarly.
> >
> > The following lists the veristat result w.r.t. changed number
> > of processes insns during verification:
> >
> > File                                                   Program         =
                                      Insns (A)  Insns (B)  Insns    (DIFF)
> > -----------------------------------------------------  ----------------=
------------------------------------  ---------  ---------  ---------------
> > test_cls_redirect.bpf.linked3.o                        cls_redirect    =
                                          64980      73472  +8492 (+13.07%)
> > test_seg6_loop.bpf.linked3.o                           __add_egr_x     =
                                          12425      12423      -2 (-0.02%)
> > test_tcp_hdr_options.bpf.linked3.o                     estab           =
                                           2634       2558     -76 (-2.89%)
> > test_parse_tcp_hdr_opt.bpf.linked3.o                   xdp_ingress_v6  =
                                           1421       1420      -1 (-0.07%)
> > test_parse_tcp_hdr_opt_dynptr.bpf.linked3.o            xdp_ingress_v6  =
                                           1238       1237      -1 (-0.08%)
> > test_tc_dtime.bpf.linked3.o                            egress_fwdns_pri=
o100                                        414        411      -3 (-0.72%)
> >
> > Mostly a small improvement but test_cls_redirect.bpf.linked3.o has a 13=
% regression.
> > I checked with verifier log and found it this is due to pruning.
> > For some JEQ/JNE branches impacted by this patch,
> > one branch is explored and the other has state equivalence and
> > pruned.
>
> Can you elaborate a bit on this insn increase caused by pruning?
>
> My naive reading of this: there was some state exploration that was
> previously pruned due to is_branch_taken returning indeterminate
> value (-1), and now that it can concretely say branch is/isn't taken,
> states which would've been considered equivalent no longer are.
> Is that accurate?

Pretty much. It's because when is_branch_taken() is certain on the directio=
n
of the branch it marks register as precise and it hurts state equivalence
later.

>
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
>
> Regardless,
>
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
