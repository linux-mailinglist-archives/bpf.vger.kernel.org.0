Return-Path: <bpf+bounces-844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72E5707821
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 04:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3401C21025
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 02:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EDF391;
	Thu, 18 May 2023 02:41:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5D19B
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 02:41:04 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487F4A4;
	Wed, 17 May 2023 19:41:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso2325719a12.2;
        Wed, 17 May 2023 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684377662; x=1686969662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvuS+HgRZ1bspmBU6wiV8HHPPWVgSTK6mbF2J7r8elM=;
        b=OV2HjeTQRvOE28w3kuWvGeQTEcCRAnrKBo+JgGMQE0BdhKK7ThtnlCmTbUC4ExRGmz
         9hL2vMs9+tf4uP+9rteZ2zqamZn4fA+0NU4ZEjEDxE0ILBapwSDAH/iqgg+CjX4oXxkO
         ZcYl6q+UkXAHuvxgAqws/9POw+br1cIQIwOrDdZnhGm7S4Az7fxWg1SnQ1SkAoqfhBhi
         vZOrJix0+FPDsuq4R9iMn/OjsZiztgdSDcFDYfHfHIEWXBXN/YrEwDeLpq6oxy9SIGx8
         WP+RZFVRFLU0aBOloRjUG1P3JP3hQi35QGNjY6ql5X8kGn7jcWJafTp6DB235heOD2hq
         C6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684377662; x=1686969662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvuS+HgRZ1bspmBU6wiV8HHPPWVgSTK6mbF2J7r8elM=;
        b=cpw6K8jPdraYjRBXCkxeVJTL2W+lCQSi4C4jbCSa1ZYG3U1B6idEltUg60NMeOrpVf
         +H+EXEN1HkuD1JSucG23U4UcmLv4ZsOR8nf0dmpSfZg7ME3+OU00YhZEtheIOzNPuGm2
         iByktk55zWRPxo5d53E6oBLy72e0gOgYhNxKTxV9u8iBRWQ1c7ssYZlTNYDhY++PebOz
         fuISD0lR0ysqF0qd11Adp3uXP7M1QQghg89JPzeNu1+Mp92jyP4ZYL8DPkLtjIM538hn
         0k4Up/i2Zx0/Vob2a0TOR+VPEGW6uWjCgopOHCeerSkwC0snJE3lwS8jAmKng3zGQgzF
         gzRg==
X-Gm-Message-State: AC+VfDzuH4sR/wVadZu317mbhOACSAabbtKnM1NUAvWJJVwJieXMRx2U
	wVa7zuXa4u6M+u/6e/v9mZS3EzN5HnQXx0+62Fk=
X-Google-Smtp-Source: ACHHUZ74N3y/birfKsUf7wOYJMDB/xrv32vrcZZh8zmds+Zi++oTNcW+fxRnXwEJOzpqehXkuoPfOCUAP0kwf7p4xWQ=
X-Received: by 2002:a50:ef04:0:b0:510:47a3:e775 with SMTP id
 m4-20020a50ef04000000b0051047a3e775mr3731713eds.41.1684377661551; Wed, 17 May
 2023 19:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517034510.15639-1-zegao@tencent.com> <20230517034510.15639-2-zegao@tencent.com>
 <20230517205947.c1710ed175519b59f56e09b1@kernel.org>
In-Reply-To: <20230517205947.c1710ed175519b59f56e09b1@kernel.org>
From: Ze Gao <zegao2021@gmail.com>
Date: Thu, 18 May 2023 10:40:49 +0800
Message-ID: <CAD8CoPCBKyADGuUAaR6E-aO4wyy1LnCaBhuxoKz3nrTvPdHLYA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler
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
	Ze Gao <zegao@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Great, thanks!

Regards,
Ze

On Wed, May 17, 2023 at 7:59=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi Ze Gao,
>
> On Wed, 17 May 2023 11:45:06 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > This patch replaces preempt_{disable, enable} with its corresponding
> > notrace version in rethook_trampoline_handler so no worries about stack
> > recursion or overflow introduced by preempt_count_{add, sub} under
> > fprobe + rethook context.
> >
> > Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Cc: <stable@vger.kernel.org>
> > Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-2-=
zegao@tencent.com
>
> Note that you don't need to add Link tag of the previous version for each=
 patch.
> I'll add it when I pick it :)
>
> Thank you,
>
> > ---
> >  kernel/trace/rethook.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> > index 32c3dfdb4d6a..60f6cb2b486b 100644
> > --- a/kernel/trace/rethook.c
> > +++ b/kernel/trace/rethook.c
> > @@ -288,7 +288,7 @@ unsigned long rethook_trampoline_handler(struct pt_=
regs *regs,
> >        * These loops must be protected from rethook_free_rcu() because =
those
> >        * are accessing 'rhn->rethook'.
> >        */
> > -     preempt_disable();
> > +     preempt_disable_notrace();
> >
> >       /*
> >        * Run the handler on the shadow stack. Do not unlink the list he=
re because
> > @@ -321,7 +321,7 @@ unsigned long rethook_trampoline_handler(struct pt_=
regs *regs,
> >               first =3D first->next;
> >               rethook_recycle(rhn);
> >       }
> > -     preempt_enable();
> > +     preempt_enable_notrace();
> >
> >       return correct_ret_addr;
> >  }
> > --
> > 2.40.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

