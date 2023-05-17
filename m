Return-Path: <bpf+bounces-688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67C705CC2
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44A21C20DAB
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA4AD48;
	Wed, 17 May 2023 02:00:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCBBAD2F
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 02:00:33 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D865A49C1;
	Tue, 16 May 2023 19:00:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso339780a12.2;
        Tue, 16 May 2023 19:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684288825; x=1686880825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKuJtUgRGoAveoB6dPRcY53BxMHmJW4YivLP7XJy1Ow=;
        b=oEJH3YQ6WJ1R0OeRcB1/RwAm81/CWoDJLhbS/+eBIUbEEgBfrBcwY4jg02JHw4xZGl
         2IJfYYQjgXKHbc1Ai3f81W4K9sTZCQAO+WSkEMbI1vQD/TyYDVSLtlwqQEy19TIbmi/y
         IJ/MxVA0NVWR4uhCrNUVK513twP+NIU3bPu/zGrg+ZsRCsm7yAAOOVkPR5qvMvkucsXm
         jG7Ood62c+ARTTr3hKMnTWA2o7RoVGHzT3y2QwOE9VPCWREMHlmxAO/DDiyFMJFJMxB6
         q/w0HkiATVBsVpcbCZDmPe++RtEEFQXqwUBKisYQhi+wnYe9t+yadRw0fyTFkZO2Zd2M
         nQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684288825; x=1686880825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKuJtUgRGoAveoB6dPRcY53BxMHmJW4YivLP7XJy1Ow=;
        b=VPi+8BxDzwZ3NUcno3hAt7y7XRmk8puKqtDUW0s0v5cvp9SSlxaq/bX/c6R+oGZnzL
         DUWhNPpsLVqOMQExHcLKeBoqgKCc34dodv52FyzephKw+MYKE8zynKeQArcYGgGO54Y4
         9M2zjlWi78AXAPwvZTtb4cGWk0+j+YUZAIwRXHMlNamudgGsyhrI1xMxlVYYgMoPjBnp
         06htJ9aQOeRb3rQDn3TSnzKuzSxg9mwTzMSei3/epgPVCu4cxKsukHnSJPs7XiDW/2Rx
         o8x26cLymIF1JMBZUEL/nI9No2GUI4D1h2YqO7rCc4PGCc1ctleOmgcWuPpd9oOh1Vmq
         peEg==
X-Gm-Message-State: AC+VfDwiavPPvboqUU1lv/blJ3LtnMotcyMoK8OJaP2sqX7mCBxJC8Bs
	REizXsSX5GsP3tN37oWVmh7I2Zi8AfesdMqGDs4=
X-Google-Smtp-Source: ACHHUZ5ODPhwCTAYdcAaNc6Khvr+LCB4zW0u1dxcHa+DA93pmjpNLl78rK2aOOMj6HEyRyZD4FRw1jZuCyKZ5xevtzQ=
X-Received: by 2002:a50:fb87:0:b0:50b:c72a:2b26 with SMTP id
 e7-20020a50fb87000000b0050bc72a2b26mr857161edq.9.1684288824921; Tue, 16 May
 2023 19:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516071830.8190-1-zegao@tencent.com> <20230516071830.8190-5-zegao@tencent.com>
 <20230516102006.76dfd68a@gandalf.local.home>
In-Reply-To: <20230516102006.76dfd68a@gandalf.local.home>
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 17 May 2023 10:00:13 +0800
Message-ID: <CAD8CoPA=VQOnnZujzH7n3X1t=PpoduB20vM0KQh8aPubySzCzw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rehook, fprobe: do not trace rethook related functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, 
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

Got it!  Thank you, Steevn.  Maybe I can give it a try later :)

Regards,
Ze

On Tue, May 16, 2023 at 10:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 16 May 2023 15:18:30 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> >  CFLAGS_REMOVE_early.o                =3D $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_rethook.o              =3D $(CC_FLAGS_FTRACE)
> >
> >  endif
> >
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index dd61752f4c96..4070a01c11b7 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -17,6 +17,7 @@ CFLAGS_REMOVE_ftrace.o =3D -pg
> >  CFLAGS_REMOVE_early_printk.o =3D -pg
> >  CFLAGS_REMOVE_head64.o =3D -pg
> >  CFLAGS_REMOVE_sev.o =3D -pg
> > +CFLAGS_REMOVE_rethook.o =3D -pg
>
> Unrelated to this patch, but someday we need to change the -pg above to
> $(CC_FLAGS_FTRACE).
>
> -- Steve
>
>
> >  endif
> >
> >  KASAN_SANITIZE_head$(BITS).o                         :=3D n
> > --

