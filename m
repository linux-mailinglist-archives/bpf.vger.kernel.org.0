Return-Path: <bpf+bounces-752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45480706593
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 12:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D0E2815F9
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A08168B4;
	Wed, 17 May 2023 10:47:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE541549A
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:47:48 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384D72D49;
	Wed, 17 May 2023 03:47:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30786c87cdaso560048f8f.2;
        Wed, 17 May 2023 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684320465; x=1686912465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqvkmynEV6/dEj1F324kSuUIEax/RriRwvtPl5SBD9Q=;
        b=DOV6yM9dgDqxu/o3argXq7spycp9mQOqF4YFCCozRgcJGMQsomFhVXykW6RfhwpEiv
         /a0f2cTkEepZnT5QgNXf6RvLzzvSTWoL3P8Z7Gpx1I/muxcTBMVR7MDYXWnMXnxzmRMe
         VVg3i4z3QFNpTD2MMb0J7LWn3oHMsgaN+mQIG3cRjsDS48ZqfNyVAv9/qBYvzkYzyZr9
         dP8SJvZrVYNW0sNEHZpQRnv+MwzSP83lXswk9OCHG95Tw24QwwkZSeYT8hX8qu/CYbaG
         tgOzYr1po54vgH0Ki+BM7IZ3IeaMHl/yIlAjowj8b7gZ4s1UsQWjCCTW10o3+M2iAfOp
         oijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320465; x=1686912465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqvkmynEV6/dEj1F324kSuUIEax/RriRwvtPl5SBD9Q=;
        b=crzLWt+caaxsWNoEDVl/jOmHinEqH7PdxuGrfzn9N8y9/rT1RHC7nfWs1/KHdkVUN/
         g7PTTM7NHgRp3oKigOvxW5Twd+VkoKGHsO+I3884J/zP+xufwprS5XmgTcIoYpKIvA1f
         B22qSpnglwBMIkYLZcHz9c1QoXQejKkdmDjiOyVouDxe4c5nbXDFpkp1/OIhdCab/4bf
         MXWJ2ERm/hExW+7/Bi8prL9ESiaZ7IJqy/UXprJog6RlTVXJ9UaU3IrWMMIoaWNbXCA4
         Mqjc2YuYdF/HPASbZYIu3R8uLsW5B4UtT+AVb61nfSi8vmhZGjANOXhDfESZ3vOz/EEV
         w9xA==
X-Gm-Message-State: AC+VfDxLCAm0z8njI2YYPG+YZ4tfl1b29IgcTQ+iCncIFuGFYmJ8ZCU0
	d68cZL4dPmLI7M3Fs3kaHHo=
X-Google-Smtp-Source: ACHHUZ471C3w5wFUGqIt4z27L/T2S6UBevOn16Z1o3xjez4iuEJaWtfcI8ywEBpGacqYJ2cij8Y9bA==
X-Received: by 2002:adf:f8d1:0:b0:307:8b3e:285a with SMTP id f17-20020adff8d1000000b003078b3e285amr261055wrq.67.1684320465184;
        Wed, 17 May 2023 03:47:45 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d6983000000b002ff2c39d072sm2334322wru.104.2023.05.17.03.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:47:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 17 May 2023 12:47:42 +0200
To: Ze Gao <zegao2021@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Albert Ou <aou@eecs.berkeley.edu>,
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
Message-ID: <ZGSwzuM8oHgKaaga@krava>
References: <20230517034510.15639-1-zegao@tencent.com>
 <20230517034510.15639-3-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517034510.15639-3-zegao@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 11:45:07AM +0800, Ze Gao wrote:
> Current implementation calls kprobe related functions before doing
> ftrace recursion check in fprobe_kprobe_handler, which opens door
> to kernel crash due to stack recursion if preempt_count_{add, sub}
> is traceable in kprobe_busy_{begin, end}.
> 
> Things goes like this without this patch quoted from Steven:
> "
> fprobe_kprobe_handler() {
>    kprobe_busy_begin() {
>       preempt_disable() {
>          preempt_count_add() {  <-- trace
>             fprobe_kprobe_handler() {
> 		[ wash, rinse, repeat, CRASH!!! ]
> "
> 
> By refactoring the common part out of fprobe_kprobe_handler and
> fprobe_handler and call ftrace recursion detection at the very beginning,
> the whole fprobe_kprobe_handler is free from recursion.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-3-zegao@tencent.com
> ---
>  kernel/trace/fprobe.c | 59 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 9abb3905bc8e..097c740799ba 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -20,30 +20,22 @@ struct fprobe_rethook_node {
>  	char data[];
>  };
>  
> -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> -			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +static inline void __fprobe_handler(unsigned long ip, unsigned long
> +		parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
>  	struct fprobe_rethook_node *fpr;
>  	struct rethook_node *rh = NULL;
>  	struct fprobe *fp;
>  	void *entry_data = NULL;
> -	int bit, ret;
> +	int ret;
>  

this change uncovered bug for me introduced by [1]

the bpf's kprobe multi uses either fprobe's entry_handler or exit_handler,
so the 'ret' value is undefined for return probe path and occasionally we
won't setup rethook and miss the return probe

we can either squash this change into your patch or I can make separate
patch for that.. but given that [1] is quite recent we could just silently
fix that ;-)

jirka


[1] 39d954200bf6 fprobe: Skip exit_handler if entry_handler returns !0

---
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9abb3905bc8e..293184227394 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -27,7 +27,7 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	struct rethook_node *rh = NULL;
 	struct fprobe *fp;
 	void *entry_data = NULL;
-	int bit, ret;
+	int bit, ret = 0;
 
 	fp = container_of(ops, struct fprobe, ops);
 	if (fprobe_disabled(fp))



