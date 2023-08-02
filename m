Return-Path: <bpf+bounces-6706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EEE76CC9F
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA30281D6F
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA267472;
	Wed,  2 Aug 2023 12:27:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983337460
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:27:03 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4526AF
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 05:27:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31297125334so577237f8f.0
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690979220; x=1691584020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6LJ3o8lUW0Mj3F9e6XDb34AIxE0rdbUX8NZj9eTcRg=;
        b=DmeyCdpjn+zsYRZPFSaIjd0azUnzHmZdU9bL8l0sPQWNoTt3NS7do0McdOFGw4pbSf
         1c+R2jtwmCzvLtQKY5acIMtmPSdeSGKYTvM25Vznzrl4nMPfzqrcc/xpTAqz9Nuvrc3y
         kb2hf7RTl7rmVX1Y4fW2h3AxMiNblC4Ay5ZlAKJx6L5mIUmB1xLC0/cEDpg8/+RseUqF
         IQMd+rzAbEizr8zfQ46kfe9rl3lCTf3MRceclNGopndnUZUJ+lJE+3Dc1x6BAXZAemQZ
         WXydMdleQhDXuRfCFBUO6rFd8Wbo5aAcbok0vka32Qu0azhb0qEqIV56LAUyAzHSitUq
         dYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979220; x=1691584020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6LJ3o8lUW0Mj3F9e6XDb34AIxE0rdbUX8NZj9eTcRg=;
        b=F09v/k89SqBxNl/N9WPvqWqaFK/Xc2D3Ca2ZAx23NvTR+RdlHMKANy7A0Sw2qOisGV
         7esKxK94bTiQUDGvHTG2np3W2u2gVt5VFgOtPHKcLZW2UbtkqSNDfO5PsNP4NrKYgcOG
         n/x2/JLcDeSqmHXFJje7Weqnmt4A3u9Oks4sqH3UeNLBdV+sam7HWcVzzBYhyT14jBvq
         NWpbkIdlqM8j3kIvvnGGGRRs9Et3/4g5St0zEPM52IWeD9ZN1qTpL/CWxGSi+llJYOmZ
         RTr7cgFxUZBkCm1q5vV3FLAERAHmWJe8mZT4PFDRdue0qMD0vyg1FR9qeK69vJ6qEiQr
         U1IQ==
X-Gm-Message-State: ABy/qLZUy5NS0Lcvl+csv7uRn5Rt3smCiiGrseyRkAiQjwfCwE63vr+5
	3xN3ccqb8zHFdmSMjrxMF14=
X-Google-Smtp-Source: APBJJlFP7MjRuy2EcyOBy+U2sGa8Ac9fXjn4hKT/ykmABO/aOF0BGbqixDEuoWmUr4Nt4BsXEy3cPA==
X-Received: by 2002:a5d:660b:0:b0:311:b18:9ca4 with SMTP id n11-20020a5d660b000000b003110b189ca4mr4941079wru.17.1690979219754;
        Wed, 02 Aug 2023 05:26:59 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fbcdba1a52sm1575442wma.3.2023.08.02.05.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:26:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Aug 2023 14:26:56 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add bpf_get_func_ip test for
 uprobe inside function
Message-ID: <ZMpLkJVPSVcc17Ou@krava>
References: <20230801073002.1006443-1-jolsa@kernel.org>
 <20230801073002.1006443-4-jolsa@kernel.org>
 <ca1c1fcf-4cc5-da44-d0ed-1bf7b6c66892@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1c1fcf-4cc5-da44-d0ed-1bf7b6c66892@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 12:30:36PM +0100, Alan Maguire wrote:
> On 01/08/2023 08:30, Jiri Olsa wrote:
> > Adding get_func_ip test for uprobe inside function that validates
> > the get_func_ip helper returns correct probe address value.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/get_func_ip_test.c         | 40 ++++++++++++++++++-
> >  .../bpf/progs/get_func_ip_uprobe_test.c       | 18 +++++++++
> >  2 files changed, 57 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > index 114cdbc04caf..f199220ad6de 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > @@ -55,7 +55,16 @@ static void test_function_entry(void)
> >   * offset, disabling it for all other archs
> 
> nit: comment here
> 
> /* test6 is x86_64 specific because of the instruction
>  * offset, disabling it for all other archs
> 
> ...should probably be updated now multiple tests are gated by the
> #ifdef __x86_64__.

right will update that

> 
> BTW I tested if these tests would pass on aarch64 with a few tweaks
> to instruction offsets, and they do. Something like the following
> gets all of the tests running and passing on aarch64:

nice, thanks a lot for testing that

SNIP

> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
> b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
> index 052f8a4345a8..56af4a8447b9 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
> @@ -8,11 +8,17 @@ char _license[] SEC("license") = "GPL";
>  unsigned long uprobe_trigger_body;
> 
>  __u64 test1_result = 0;
> +#if defined(__TARGET_ARCH_x86)
> +#define OFFSET 1
>  SEC("uprobe//proc/self/exe:uprobe_trigger_body+1")
> +#elif defined(__TARGET_ARCH_arm64)
> +#define OFFSET 4
> +SEC("uprobe//proc/self/exe:uprobe_trigger_body+4")
> +#endif
>  int BPF_UPROBE(test1)
>  {
>         __u64 addr = bpf_get_func_ip(ctx);
> 
> -       test1_result = (const void *) addr == (const void *)
> uprobe_trigger_body + 1;
> +       test1_result = (const void *) addr == (const void *)
> uprobe_trigger_body + OFFSET;
>         return 0;
>  }
> 
> 
> Anyway if you're doing a later version and want to roll something like
> the above in feel free, otherwise I can send a followup patch later on.
> Regardless, for the series on aarch64:

I'd preffer if you could send follow up for arm, because I have
no easy way to test that change

thanks,
jirka

