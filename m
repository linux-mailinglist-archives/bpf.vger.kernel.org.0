Return-Path: <bpf+bounces-845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307970783C
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 04:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEE21C20F91
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D44C392;
	Thu, 18 May 2023 02:49:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC619B
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 02:49:48 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47431E5;
	Wed, 17 May 2023 19:49:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so2710748a12.1;
        Wed, 17 May 2023 19:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684378186; x=1686970186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7liFIXx8tC5EuopqHF+4OZT7BnqM1nFKp7piVkw/qM=;
        b=GLLrnD3CmE0XvGT+JxYZ7cQgV+1xvzVZ3Txzfjp4d0gGxnjEpPejY1rn9MygPZ3+ZD
         I/V1uQlegefxNQba9jqi8ad8/5Yy9WkJQlhMQ6d0+huqeN5Gmbe9JxiubjKUtiEvaYX5
         Gdm/xO0LN8lv4Ht86D77Xs/pQYkwA6mnZZma92DQrRYjkGCuwiizsWB9/h3mUEyUlGjE
         G3UM6QEPAGQwJnQNWOjO/et4vCOjmS6O3gRh8jXFuQWCC56B/iaCunmXizBsm+LgCXqd
         WT3d6WMhuKJBqAyIOGMy/A04umW083VL+C1uTgcEkPDv1qVysbQbNm9SyUslkbQbDYMC
         i1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684378186; x=1686970186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7liFIXx8tC5EuopqHF+4OZT7BnqM1nFKp7piVkw/qM=;
        b=ih6rF6ZxsHwDT1uVnBb/iskPdwq36N7e4VSPPIy8E4y3Ajs5/OmG9+j5ESDk8oVwiT
         4N6MeMxU2mUd7H1uG+2XWINVkn0gxHsHv22QDV+5XDbdatrs+BM2CzkdRGq+DXO3CTXC
         NzOm4R9xVuTF8MEnIXM3ZE9ztDAG5PCJfkj2fewqdpN/frLINsqNd90HD7wdKgz95+Fe
         mJRqGZS0gMrynGRo7Txl7SqSId6EhvUODMimhS3PQOBcyXR6j7tJ3//vsRS/vERBBVKG
         G/ecbyCiwf/nCHk43eUVwRwGbsmSCaey6f5qQz4KPLL5JIpvCQ6GtK5ZVyoFS8Rdy0sE
         JjVw==
X-Gm-Message-State: AC+VfDyhK6yji/2AHy2vSiwbnTUK8KEuln/C7runwkS3Od9Uy92Me3Ss
	kPP3tEi72X1UEtTD9cd2vnCz0lpjIiiooc6WFVU=
X-Google-Smtp-Source: ACHHUZ793GNNj1zvlruifdVIL05R5dyN2IJ6aEpAWbno+Q7MmGhMkY3LMcXR8PdR134IXAQrGeWXb+7Ql+x39U1c8z4=
X-Received: by 2002:a05:6402:749:b0:50b:d303:d2a4 with SMTP id
 p9-20020a056402074900b0050bd303d2a4mr4318229edy.27.1684378185524; Wed, 17 May
 2023 19:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517034510.15639-1-zegao@tencent.com> <20230517034510.15639-3-zegao@tencent.com>
 <20230517232751.09126a6cec8786a954e54bcf@kernel.org>
In-Reply-To: <20230517232751.09126a6cec8786a954e54bcf@kernel.org>
From: Ze Gao <zegao2021@gmail.com>
Date: Thu, 18 May 2023 10:49:34 +0800
Message-ID: <CAD8CoPC5N9sNTsYof1ig_mExh9qZHY=FjMwNfqxc23N=q3J2HA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] fprobe: make fprobe_kprobe_handler recursion free
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, 
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Glad to hear that, hooray!  :)

Thanks
Ze

On Wed, May 17, 2023 at 10:27=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
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

