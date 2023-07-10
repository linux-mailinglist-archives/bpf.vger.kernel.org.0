Return-Path: <bpf+bounces-4574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199974CE4A
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 09:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B253D1C209A1
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 07:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C85688;
	Mon, 10 Jul 2023 07:24:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484985239
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 07:24:40 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3303010F6
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 00:24:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992e22c09edso471933166b.2
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688973869; x=1691565869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1MOiJChk88GWf7I3z+bxMWhQ08qmj3LGxCKFuRqCTFQ=;
        b=jtk3tAVMFrf/1xNeWwnrV7sqwGrPZsDF0MKdTRn3wPPUvINS6WRaBTraywJDPPXgH9
         T+VGJZ2pwB6ob6q1ZtUeCVfcCgrTpGR7D41ODcgF7evMTaCSdslBAHnxb3u409JM7zk+
         ii8hVvGphXqOPkMUvem+Kpuq60+TXWQ2U7I8nPZL14TlvMQJXOnH76a+sBDCd1PHfoRg
         qakzpbXiGk6C0bIFBFKOf8VCadtbkpRE0Dsmfs/RWb9sOnP+MrbhJ/b+tXCslzstAvGR
         HOIQKZm6lBNl0r7hi2s5/GDHVpfSzSWJWdwBUaa9XqFwszOjP1gN4eLiYMRC/uZfytEv
         ZSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688973869; x=1691565869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MOiJChk88GWf7I3z+bxMWhQ08qmj3LGxCKFuRqCTFQ=;
        b=UsXV6Bc7IbcW+m7izipD750Bxn2EdbQ3QYHTzwWdqdOe2e4Uvsfdk5FOaLBtZ/45eE
         sSWLxRiKJnxaPb1rtJeQ8ICQvPN2RWYy9Q6dMty/93biTp+K9Lk467jElO9sxY23vTQo
         db9XWJgk1QMasien1kLvG8Ye4q6XGLkojcOYtXNUzIiFhiOvR+DiOND9HfKy5wCy2jqU
         2ZHbAkpYylFB8Jnt30qDcVSS6lEc+uHHF2ntqSOwS9x1SOS9ZIR5Ta2Du7OWjWk9OalP
         N9JoPPvH14XDWZH97cH6L9LqYw0splCMwOK1+FjIpqSwpcA3akl2aSshx52beyNf1VPb
         EPPg==
X-Gm-Message-State: ABy/qLZDilvX42vLf5+hfhHUoRDlQ8srQOfIfkPYeyEwhOxAa22BGvR0
	bg571a4lZsRao7BwvtD7VLA=
X-Google-Smtp-Source: APBJJlHRxA47JEYjg0iN70ovnhTVfiZVJPLKHtwaHx8TXd7JJDIxLYpoivF24TOQ+IKPi32uUaNx1Q==
X-Received: by 2002:a17:907:900f:b0:989:34a0:45b0 with SMTP id ay15-20020a170907900f00b0098934a045b0mr11777324ejc.49.1688973869400;
        Mon, 10 Jul 2023 00:24:29 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709064a8b00b00992dcae806bsm5702265eju.5.2023.07.10.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:24:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Jul 2023 09:24:26 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "jordalgo@meta.com" <jordalgo@meta.com>,
	"ajor@meta.com" <ajor@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 05/26] bpf: Add bpf_get_func_ip helper support
 for uprobe link
Message-ID: <ZKuyKj8jrEPzWYMM@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-6-jolsa@kernel.org>
 <CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 03:29:08PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:34 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support for bpf_get_func_ip helper being called from
> > ebpf program attached by uprobe_multi link.
> >
> > It returns the ip of the uprobe.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> >
> 
> A slight aside related to bpf_get_func_ip() support in
> uprobe/uretprobe. We just had a conversation with Alastair and Jordan
> (cc'ed) about bpftrace and using bpf_get_func_ip() there with
> uretprobes, and it seems like it doesn't work.
> 
> Is that intentional or we just missed that bpf_get_func_ip() doesn't
> work with uprobes/uretprobes? Do you think it would be hard to add
> support for them for bpf_get_func_ip()? It's a very useful helper,
> would be nice to have it working in all cases where it has meaningful
> behavior (and I think it does for uprobe and uretprobe).

I'm not sure we discussed at the time we added this helper,
but I see same problem as we had with kprobes where we need
to know if the probe is on the start of the symbol

we use KPROBE_FLAG_ON_FUNC_ENTRY flag for that in kprobe's
get_func_ip helper version:

	BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs) 
	{
		struct kprobe *kp = kprobe_running();

		if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
			return 0;

		return get_entry_ip((uintptr_t)kp->addr);
	}

I don't think we can have same flag for uprobe, we don't have
the binary symbol data as we have for kernel

I guess the app needs to store regs->ip and match it against symbol
addresses in user space

jirka


> 
> Thanks!
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 4ef51fd0497f..f5a41c1604b8 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -88,6 +88,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
> >  static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
> >
> 
> [...]

