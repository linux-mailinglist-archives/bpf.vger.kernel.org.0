Return-Path: <bpf+bounces-836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB937076D4
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 02:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5010F1C20FFA
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 00:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3DD198;
	Thu, 18 May 2023 00:17:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F24160
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 00:17:03 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC87E8;
	Wed, 17 May 2023 17:17:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96598a7c5e0so227321466b.3;
        Wed, 17 May 2023 17:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684369020; x=1686961020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh43Wrfv+5aBpD3zk+YIOr3pgIKi6Fm6XvjoyCfmrss=;
        b=O2q6Qm5/BCw7eL+R4iqW2KRYtOD7PxCsAMTNdmblRTQBQ9SXxj97E+uiLaHvdw+0vH
         IZAgUyLD9tdpA6WzvAnycAcJlidqsKRKjEyDwYPcgFRoiRvn+aGoAETE0zL7U0uecutc
         llNmsUorv3L9LvscGZeLrSn73CHxCEwpMLc242B+rU5ye9EYoqGyqECI6UmFyVNI137l
         BrXk4d74hq54C4WH4aTFrG6aAlMIlKYkIqfTmGGIoIU7n6R2fgdc8MiqqwfXql+JUk9B
         mbUicBybFzH8SUZx97fcymQ4dD0Koiso43k2URk/mqAAZSJcQr2pCjX4Y8H2fcQR9saN
         B11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684369020; x=1686961020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh43Wrfv+5aBpD3zk+YIOr3pgIKi6Fm6XvjoyCfmrss=;
        b=hGWaBkA9Nl8f1lfmM8bb2W3g+Rw7y8f1R0wFaQ+vb0ETaUqBomKp2BhZ9XCYeeShmv
         Jazzn3PejGSIMeDaydMaQ9qm3hGP9BlqWmos1au5TYk+mLopHhSTaIxmUKks0sM0eAp+
         DR3X8muvNP4YpUuDE3lMMlo+82nbq2uMusUmpDO2ZkNyqKF9cc+z0cWackSUkkbnbuR/
         0jFOPB3k1PuY6l7f8JMRHLGFA/XGOnU96qid5PCQcrrXFKpEEClz0lHG5b6SsmOMSDPQ
         1YbNSJK7BTEE9RUsz+f+AZGsWm8PksfzON00kY/WgGKWtGsqr04QfPFnWAJA1PS+RHFv
         ohwg==
X-Gm-Message-State: AC+VfDwzpZhuZhgNDG5lhabffeZGEEmWWNpF5YSdiF9Ld5xQXDyjImO5
	SrTLOL1WF4wAQKCFQchCMvjaKFBykA99Jm1NztQ=
X-Google-Smtp-Source: ACHHUZ4tffbvWb2kOWbRDAM1NZzsqQL8R1kGzCDWJgVZSv6SDwKWRnc526sFoNefgRlhM2mGaZLNKOiitqvHwbCzGkc=
X-Received: by 2002:a17:907:7250:b0:966:b4b:eb0 with SMTP id
 ds16-20020a170907725000b009660b4b0eb0mr42160555ejc.30.1684369019531; Wed, 17
 May 2023 17:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517034510.15639-1-zegao@tencent.com> <20230517034510.15639-3-zegao@tencent.com>
 <20230517232751.09126a6cec8786a954e54bcf@kernel.org>
In-Reply-To: <20230517232751.09126a6cec8786a954e54bcf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 May 2023 17:16:47 -0700
Message-ID: <CAEf4BzbxRXGR8uL=gkU9A=bER-zUbYSKgBhPLju1JZBUn9LrvQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] fprobe: make fprobe_kprobe_handler recursion free
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ze Gao <zegao2021@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 7:28=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 17 May 2023 11:45:07 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Current implementation calls kprobe related functions before doing
> > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > is traceable in kprobe_busy_{begin, end}.
> >
> > Things goes like this without this patch quoted from Steven:
> > "
> > fprobe_kprobe_handler() {
> >    kprobe_busy_begin() {
> >       preempt_disable() {
> >          preempt_count_add() {  <-- trace
> >             fprobe_kprobe_handler() {
> >               [ wash, rinse, repeat, CRASH!!! ]
> > "
> >
> > By refactoring the common part out of fprobe_kprobe_handler and
> > fprobe_handler and call ftrace recursion detection at the very beginnin=
g,
> > the whole fprobe_kprobe_handler is free from recursion.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-3-=
zegao@tencent.com
> > ---
> >  kernel/trace/fprobe.c | 59 ++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 44 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 9abb3905bc8e..097c740799ba 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -20,30 +20,22 @@ struct fprobe_rethook_node {
> >       char data[];
> >  };
> >
> > -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > -                        struct ftrace_ops *ops, struct ftrace_regs *fr=
egs)
> > +static inline void __fprobe_handler(unsigned long ip, unsigned long
> > +             parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fr=
egs)
>
> OK, I picked up this series to probes/fixes. Note that I fixed this line
> because the "unsigned long parent_ip" was split into 2 lines.
>

Hey Masami,

Regarding [0], I was bisecting BPF CI failures related to
multi-kprobes, and it turned out that [0] is the fix we need. It would
be great if you can make sure this fix gets into Linus' tree ASAP, so
that we can get it back into bpf/bpf-next trees and fix BPF selftests
for everyone (we mitigated this for BPF CI as a temporary workaround
for now). Thanks!

  [0] https://lore.kernel.org/all/168100731160.79534.374827110083836722.stg=
it@devnote2/


> Thank you,
>
>
> >  {
> >       struct fprobe_rethook_node *fpr;
> >       struct rethook_node *rh =3D NULL;
> >       struct fprobe *fp;
> >       void *entry_data =3D NULL;
> > -     int bit, ret;
> > +     int ret;
> >
> >       fp =3D container_of(ops, struct fprobe, ops);
> > -     if (fprobe_disabled(fp))
> > -             return;
> > -
> > -     bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> > -     if (bit < 0) {
> > -             fp->nmissed++;
> > -             return;
> > -     }
> >
> >       if (fp->exit_handler) {
> >               rh =3D rethook_try_get(fp->rethook);
> >               if (!rh) {
> >                       fp->nmissed++;
> > -                     goto out;
> > +                     return;
> >               }
> >               fpr =3D container_of(rh, struct fprobe_rethook_node, node=
);
> >               fpr->entry_ip =3D ip;
> > @@ -61,23 +53,60 @@ static void fprobe_handler(unsigned long ip, unsign=
ed long parent_ip,
> >               else
> >                       rethook_hook(rh, ftrace_get_regs(fregs), true);
> >       }
> > -out:
> > +}
> > +
> > +static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > +             struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > +{
> > +     struct fprobe *fp;
> > +     int bit;
> > +
> > +     fp =3D container_of(ops, struct fprobe, ops);
> > +     if (fprobe_disabled(fp))
> > +             return;
> > +
> > +     /* recursion detection has to go before any traceable function an=
d
> > +      * all functions before this point should be marked as notrace
> > +      */
> > +     bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> > +     if (bit < 0) {
> > +             fp->nmissed++;
> > +             return;
> > +     }
> > +     __fprobe_handler(ip, parent_ip, ops, fregs);
> >       ftrace_test_recursion_unlock(bit);
> > +
> >  }
> >  NOKPROBE_SYMBOL(fprobe_handler);
> >
> >  static void fprobe_kprobe_handler(unsigned long ip, unsigned long pare=
nt_ip,
> >                                 struct ftrace_ops *ops, struct ftrace_r=
egs *fregs)
> >  {
> > -     struct fprobe *fp =3D container_of(ops, struct fprobe, ops);
> > +     struct fprobe *fp;
> > +     int bit;
> > +
> > +     fp =3D container_of(ops, struct fprobe, ops);
> > +     if (fprobe_disabled(fp))
> > +             return;
> > +
> > +     /* recursion detection has to go before any traceable function an=
d
> > +      * all functions called before this point should be marked as not=
race
> > +      */
> > +     bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> > +     if (bit < 0) {
> > +             fp->nmissed++;
> > +             return;
> > +     }
> >
> >       if (unlikely(kprobe_running())) {
> >               fp->nmissed++;
> >               return;
> >       }
> > +
> >       kprobe_busy_begin();
> > -     fprobe_handler(ip, parent_ip, ops, fregs);
> > +     __fprobe_handler(ip, parent_ip, ops, fregs);
> >       kprobe_busy_end();
> > +     ftrace_test_recursion_unlock(bit);
> >  }
> >
> >  static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> > --
> > 2.40.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

