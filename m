Return-Path: <bpf+bounces-769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A2B706822
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F241C20EAF
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791D2C75D;
	Wed, 17 May 2023 12:30:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0BB3111B
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 12:30:09 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B41720;
	Wed, 17 May 2023 05:30:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so1066374a12.0;
        Wed, 17 May 2023 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684326605; x=1686918605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zG7OAtWW1ntr+yw/2O/iG28G8+bEDuvHfZ1bydZEJAA=;
        b=WxpIe5pMxx0VA25leALbaHV7URbrgAZQgUBOO+Dm/oEU4zI7xovBGNR0Fqdj3S0U5D
         +wX/5bbik+VhVwaVqkhO/m/bAJfyUm6S98KhIjZNjJmORqxyH79So3CJNh8nGmLwlmzz
         0gEEtIchHsxOUZ+D/QMa8VshbsujBhVWd+NHfczwXI7dwfKp3Ud2ghErffmsQNPHs3QT
         3SC5awUHHfdaGU5KKUxQh4cPlmsVI8rB9OtER/noYauADAGyKyMVc8GF2mViI2dv+f9X
         nQofY16nsB6wxSSeolmYXUVITJPW4DgOomnU4IAy50pVTuxZt0MURD8TkOrG9H68lWX2
         mDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326605; x=1686918605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG7OAtWW1ntr+yw/2O/iG28G8+bEDuvHfZ1bydZEJAA=;
        b=G5elhPSq27nzaGlBsTXeBHPHQrxMTdcLAmhRFEvpUfnuB8qS2viFF4wlNT7vJMvN/7
         ToHzXONZ+gxs9JO/JF0X246L5oYvw4QGOWZynrV48Q4nfwqr75Hi32jhqAEi9oXo/NPj
         3RfuzSIzkKY/ERmICwTn+N0BQN4IaqRuriDXv/i+khZfdAzifJa9/Ux7WkMetT1KNfry
         bvWnwLs5hebnK+wXFsBHUgEBUKCC7SyRmPx+7NcOy+cnUEuFC4TYJZM3wouESrYsgoIA
         7J56jaFnDD9LUMquu/JTUkrEWi4zaQRy6Rxm7zmwZPprtUP3mT77C4F5PMsSf9wyStZq
         2mOQ==
X-Gm-Message-State: AC+VfDwScL5eZL9S1th8wE5t9bQvOCIExXlEUWq2+tQ+clKl9jOA/OVr
	uEqgaYyt9z99aUTlyjrbFoo=
X-Google-Smtp-Source: ACHHUZ5fZJXdzpqMUilN3IDYmrxIKIW+aD2uyjM+ZYcZgxAxMpplHCS3A36ogwRDUcF+oXUh5RDHSA==
X-Received: by 2002:aa7:d1c5:0:b0:510:d075:9e13 with SMTP id g5-20020aa7d1c5000000b00510d0759e13mr1374346edp.22.1684326605340;
        Wed, 17 May 2023 05:30:05 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7db8f000000b0050bc863d32asm9472513edt.27.2023.05.17.05.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:30:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 17 May 2023 14:30:02 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ze Gao <zegao2021@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v3 2/4] fprobe: make fprobe_kprobe_handler recursion free
Message-ID: <ZGTIyrPXkCiwFPBo@krava>
References: <20230517034510.15639-1-zegao@tencent.com>
 <20230517034510.15639-3-zegao@tencent.com>
 <ZGSwzuM8oHgKaaga@krava>
 <20230517204236.e0f579399e5a69505a4ec7ef@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517204236.e0f579399e5a69505a4ec7ef@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 08:42:36PM +0900, Masami Hiramatsu wrote:
> On Wed, 17 May 2023 12:47:42 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Wed, May 17, 2023 at 11:45:07AM +0800, Ze Gao wrote:
> > > Current implementation calls kprobe related functions before doing
> > > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > > is traceable in kprobe_busy_{begin, end}.
> > > 
> > > Things goes like this without this patch quoted from Steven:
> > > "
> > > fprobe_kprobe_handler() {
> > >    kprobe_busy_begin() {
> > >       preempt_disable() {
> > >          preempt_count_add() {  <-- trace
> > >             fprobe_kprobe_handler() {
> > > 		[ wash, rinse, repeat, CRASH!!! ]
> > > "
> > > 
> > > By refactoring the common part out of fprobe_kprobe_handler and
> > > fprobe_handler and call ftrace recursion detection at the very beginning,
> > > the whole fprobe_kprobe_handler is free from recursion.
> > > 
> > > Signed-off-by: Ze Gao <zegao@tencent.com>
> > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-3-zegao@tencent.com
> > > ---
> > >  kernel/trace/fprobe.c | 59 ++++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 44 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > index 9abb3905bc8e..097c740799ba 100644
> > > --- a/kernel/trace/fprobe.c
> > > +++ b/kernel/trace/fprobe.c
> > > @@ -20,30 +20,22 @@ struct fprobe_rethook_node {
> > >  	char data[];
> > >  };
> > >  
> > > -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > > -			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > +static inline void __fprobe_handler(unsigned long ip, unsigned long
> > > +		parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > >  {
> > >  	struct fprobe_rethook_node *fpr;
> > >  	struct rethook_node *rh = NULL;
> > >  	struct fprobe *fp;
> > >  	void *entry_data = NULL;
> > > -	int bit, ret;
> > > +	int ret;
> > >  
> > 
> > this change uncovered bug for me introduced by [1]
> > 
> > the bpf's kprobe multi uses either fprobe's entry_handler or exit_handler,
> > so the 'ret' value is undefined for return probe path and occasionally we
> > won't setup rethook and miss the return probe
> 
> Oops, I missed to push my fix.
> 
> https://lore.kernel.org/all/168100731160.79534.374827110083836722.stgit@devnote2/
> 
> > 
> > we can either squash this change into your patch or I can make separate
> > patch for that.. but given that [1] is quite recent we could just silently
> > fix that ;-)
> 
> Jiri, I think the above will fix the issue, right?

yes, it's the same fix, great, thanks

jirka

> 
> > 
> > jirka
> > 
> > 
> > [1] 39d954200bf6 fprobe: Skip exit_handler if entry_handler returns !0
> > 
> > ---
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 9abb3905bc8e..293184227394 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -27,7 +27,7 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> >  	struct rethook_node *rh = NULL;
> >  	struct fprobe *fp;
> >  	void *entry_data = NULL;
> > -	int bit, ret;
> > +	int bit, ret = 0;
> >  
> >  	fp = container_of(ops, struct fprobe, ops);
> >  	if (fprobe_disabled(fp))
> > 
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

