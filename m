Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1600F675E98
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjATUJl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 15:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjATUJk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918A1285A
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hw16so16638872ejc.10
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6NX4li+KX383hH+0c3kEuHFXpFOIoz1t5t6CtGyu2sY=;
        b=eaw7utx8I5/ikdaPuDrKL3IdNt4d2K/exD9A4IFXabN90kK7sJFMduxzqyVFky+aNj
         QPCrTDFmWiztbCxzeSL6J0SVBXSrIPujX+eBOZ1vH+CuoLUhewpM6zqfTZJKPeCvFkwC
         cITE8Buorlu8CP1V1GVVmce5qggnIYJLG/zQprFA5RVJ9jYgvO3mklEECQKiLzta73EN
         728wA7AnkmxOEcxqQJkcZ5tIlorApFFDLAxDOE+CGETgh4UkfFoDuJkOYyIXutkagS5A
         l0leKi1IaYDRZnlF1Zh4uTyz4jOMesmeDCvwSS6FCY9yRpl7z0TZ9OxY2wQ5odfwB7NO
         8xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NX4li+KX383hH+0c3kEuHFXpFOIoz1t5t6CtGyu2sY=;
        b=NTpgiDvdvh4kRMAGkcJ/OirVtUOnWowvIMgw0fkXx0R5gY3l1nkTk0gr8dqkD8OFgy
         LvQ1GQH2dotqxe0nRC2ekEU9pTVyYIQYky04qymt/RbVVr+01k9QbNJJ5H1OQpoODNoD
         /gg8ccAE89S5QIMc690pjOUtoIJMKkIastmpmzi1r4U+QXvrEw8GFFFrPi/Q/HFdwNeC
         KWU3Aw0icjitVhDx3j4xQNSLAK29XVNNc5/cMHOKN814cqq7S9AhfFJEkon7KliaEPa2
         cwFIDWGYJo8CTCi34qQFapp2kTfuPTobsYU7BriFnI82YRgUpGYRNpDxbAqvp5KaZKJh
         g8Dw==
X-Gm-Message-State: AFqh2kom6fSN8DLjEu/mi85ufI5H5mt9e7EZ9iRgqJeJvt0jwgs3kovY
        ctxqe6iRMmdTQ+I/G/iLWIJGwZsA5CkHYIl46s0=
X-Google-Smtp-Source: AMrXdXtXttw5pFk7Xpcn2OGpP00xfIp3553mRotMO5xu1T8eiKyCcx1kkaybry8QKsO0VNYtBeafwBZ/dnGJ50JegBo=
X-Received: by 2002:a17:907:9620:b0:7c1:10b4:4741 with SMTP id
 gb32-20020a170907962000b007c110b44741mr1383174ejc.8.1674245377894; Fri, 20
 Jan 2023 12:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20230113083404.4015489-1-andrii@kernel.org> <20230113083404.4015489-16-andrii@kernel.org>
 <ccecce089c56ae8b49cf5b45f7898ccbe9bf6220.camel@linux.ibm.com>
In-Reply-To: <ccecce089c56ae8b49cf5b45f7898ccbe9bf6220.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Jan 2023 12:09:24 -0800
Message-ID: <CAEf4BzZDFQs=34=WcbZEQa80TiXpD=aZ9ZXQ4Sw+mELY6Xt4UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 15/25] libbpf: define s390x syscall regs spec in bpf_tracing.h
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Alan Maguire <alan.maguire@oracle.com>,
        Pu Lehui <pulehui@huawei.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Florent Revest <revest@chromium.org>
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

On Mon, Jan 16, 2023 at 2:13 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Fri, 2023-01-13 at 00:33 -0800, Andrii Nakryiko wrote:
> > Define explicit table of registers used for syscall argument passing.
> > Note that we need custom overrides for PT_REGS_PARM1_[CORE_]SYSCALL
> > macros due to the need to use BPF CO-RE and custom local pt_regs
> > definitions to fetch orig_gpr2, storing 1st argument.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h
> > b/tools/lib/bpf/bpf_tracing.h
> > index 34ac0a2d7885..888beea6565b 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -157,6 +157,10 @@
> >
> >  #elif defined(bpf_target_s390)
> >
> > +/*
> > + *
> > https://en.wikipedia.org/wiki/Calling_convention#IBM_System/360_and_successors
> > + */
> > +
>
> Here is the more official ABI spec:
>
> https://github.com/IBM/s390x-abi/releases/download/v1.6/lzsabi_s390x.pdf
>

thanks, updated link in the comment (btw, I was surprised how hard it
was sometimes to find such official ABI specs)



> >  struct pt_regs___s390 {
> >         unsigned long orig_gpr2;
> >  };
> > @@ -168,13 +172,22 @@ struct pt_regs___s390 {
> >  #define __PT_PARM3_REG gprs[4]
> >  #define __PT_PARM4_REG gprs[5]
> >  #define __PT_PARM5_REG gprs[6]
> > +
> > +#define __PT_PARM1_SYSCALL_REG orig_gpr2
> > +#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
> > +#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
> > +#define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
> > +#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
> > +#define __PT_PARM6_SYSCALL_REG gprs[7]
> > +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
> > +#define PT_REGS_PARM1_CORE_SYSCALL(x) \
> > +       BPF_CORE_READ((const struct pt_regs___s390 *)(x),
> > __PT_PARM1_SYSCALL_REG)
> > +
> >  #define __PT_RET_REG gprs[14]
> >  #define __PT_FP_REG gprs[11]   /* Works only with
> > CONFIG_FRAME_POINTER */
> >  #define __PT_RC_REG gprs[2]
> >  #define __PT_SP_REG gprs[15]
> >  #define __PT_IP_REG psw.addr
> > -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
> > -#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ((const struct
> > pt_regs___s390 *)(x), orig_gpr2)
> >
> >  #elif defined(bpf_target_arm)
> >
>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
