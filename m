Return-Path: <bpf+bounces-618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522FA7049B7
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 11:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2C52815A6
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B1182D0;
	Tue, 16 May 2023 09:51:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB954156E1
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 09:51:53 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958891FEC;
	Tue, 16 May 2023 02:51:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so21212147a12.3;
        Tue, 16 May 2023 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684230706; x=1686822706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGRnr0pf14CHov8UGeE0opuOVSemy26gQSSgqCQ8OBg=;
        b=TyARuFrePmLKzB8Y4APhEC1j3pOxio/NqSOHioZ3lmLXGK4vgLurB9WR8Xw8wEjvuO
         /yfg1Da7tiI8dzFEUflqoVQzHmxBBnpuU71cWAw50ixw7Ka9TRejd+rX7vG2S8Ne48r8
         f6V9/YrBojQxHWio238iQe75dZ7bcWtO3IaVZ/5wDp3yAOdqaQmnJ/2ySO3Mq2qUVvQd
         sOJNoY85jjHhy8Sw0/IFm+REkH+A+srv4nBaS6drUg95ae6FuXM8X11uuk9yj2B4Sc3d
         zdhE+SFulVdAWHIKroDxhu/T9R6ja8UPKEziJmYYS0WRcA9mExznmwHyM0kf+vRWl9LQ
         4FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230706; x=1686822706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGRnr0pf14CHov8UGeE0opuOVSemy26gQSSgqCQ8OBg=;
        b=kIZmlY8kMDJ0LUfG2AvAztI6zBG8cRTa5pldp2q7I98Lf8K7PFKk+61vt5QMas1kst
         qmZGNy8dzVavSCw48wfykvy8Q0y/hjVqD+CYCtcMppds7l4NPJo8fkKFJed3wASioxHn
         NEiThRh7uaDNvlm8pxwKe/MZylR18k4eo8i2tGcwqOGKf2lAtBljVta02jbt7Z+h8GK7
         KM4RMv+BzKPU57q4dTR33mhUwp+VlEH8BE+OqPxMkZ5n/8Pen4Jc5pzfJoGC6A1LzruT
         73CzXRcHyoiezmI2zstWw9uAVCugjyXJr7c43BebaYLdRjKuic4IPDRcSoHt574Su1XW
         nDCg==
X-Gm-Message-State: AC+VfDwcRNIoSUAgFZRygGidtDTIRrpcPnUhw1ZuA76G5bB3OZoSD0VP
	QsF4xV649h/77Pt0nVJPrYnYOhNV8VXbOyOnrMc=
X-Google-Smtp-Source: ACHHUZ5xpt1T33EGstq2xec0xYohfOgkI64LW6Py10ItFNbeyutFXIVDZoxai5C+HNRhgxKoCsdtIb8OrXa0qnnf6os=
X-Received: by 2002:a05:6402:482:b0:50c:52d:7197 with SMTP id
 k2-20020a056402048200b0050c052d7197mr25360576edv.2.1684230705817; Tue, 16 May
 2023 02:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516071830.8190-1-zegao@tencent.com> <20230516071830.8190-3-zegao@tencent.com>
 <20230516091820.GB2587705@hirez.programming.kicks-ass.net> <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
In-Reply-To: <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Tue, 16 May 2023 17:51:34 +0800
Message-ID: <CAD8CoPDu=u4vxEYiaZfne92yZ=uTcAEPzWPbdjncyfbSyuCpfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
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

Sorry for paste the wrong link, it's this one instead:
  Link: https://lore.kernel.org/bpf/20230513001757.75ae0d1b@rorschach.local=
.home/

It's the original discussions of this problem.

Regards,
Ze

On Tue, May 16, 2023 at 5:47=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote:
>
> Precisely, these that are called within kprobe_busy_{begin, end},
> which the previous patch does not resolve.
> I will refine the commit message to make it clear.
>
> FYI, details can checked out here:
>     Link: https://lore.kernel.org/linux-trace-kernel/20230516132516.c902e=
dcf21028874a74fb868@kernel.org/
>
> Regards,
> Ze
>
> On Tue, May 16, 2023 at 5:18=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> > > Current implementation calls kprobe related functions before doing
> > > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > > is traceable.
> >
> > Which preempt_count*() are you referring to? The ones you just made
> > _notrace in the previous patch?

