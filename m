Return-Path: <bpf+bounces-304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A02E6FE33E
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 19:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEAF28142A
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B326E174C7;
	Wed, 10 May 2023 17:28:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879923D60
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 17:28:04 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354AF26AA;
	Wed, 10 May 2023 10:28:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ab13da70a3so73109385ad.1;
        Wed, 10 May 2023 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683739681; x=1686331681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14SzeB2Vs1W83Y2m7j9/1bFYAIAlXQOw2zKIeSsOFhI=;
        b=gCRz4BqjH9pr6rwQQnegssBrq+NVmWXOyPdlPDSWAO1fygieli77caq04l3ko+fRsY
         cFkrgyUtl5bZbcMD714N2rkMKnssMTPdUhiocjxt+zD33fEoPoks+QZkVVzn8vhcKQZR
         rhZIWLRQ+jCBXEtuKmPPqmcbAv/OjzS/atpSXDZrGE5yWs4aOwCeR1LMShiCBiuzWk8T
         MqExPAsUIMK7VKJtmIkeqwjeL/VRXi4VyyKmsOBgzGepAqqy7bh20RVrXoLc0QOIFksq
         Jco099twCxKnnuxirTtloXWeUONWr46e5muncbk8sGktwURFrhECoEeBmt6V/juIrpX3
         0jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683739681; x=1686331681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14SzeB2Vs1W83Y2m7j9/1bFYAIAlXQOw2zKIeSsOFhI=;
        b=Zbx5LZJQAVM2zIMNx/pUYDk+l5S9YIDMm3LCmH9AhEsxSN8FYEiqJeQtyCGVKXXtl2
         db6WVnsYL7i4741ApTLDaDKGslxgRzJEt/8XZVu+b457IltLqWMm908wHTV7J5c3MmDj
         78fCCoa1P6jPPeQDbPsDPEvFqTI1spxFzGmLtC1Ci4ooHIvK3F+GAym3766IuPdpTA63
         TIDAgneK0izvixsCW+XVOrCQExVQSw0Zt/DWBVo2xBb80lXZqiMoXzjZOZNpJ1P9xVj/
         FitMRjEDyuVAp8EhsBFpfzwtZj05EEuFtS2lJEI7quGvWilx5f0bUMyFVSnGYfTQONxG
         Ls5w==
X-Gm-Message-State: AC+VfDxQ3rBMFF5UqODWGm/rOct9HHt4CGlxx8Kmc7tvqN1l8ey58dan
	veb3vKyFfsUp+520h01P8AQ=
X-Google-Smtp-Source: ACHHUZ4R5h18ZyJbvVBpOVpl3OCG3fgMMwCyr3XVNv+VxKMCaKwGOQ5egsUGDqJxOoG2lYBAZMCPeg==
X-Received: by 2002:a17:903:294c:b0:1ab:1b8:8a5f with SMTP id li12-20020a170903294c00b001ab01b88a5fmr18386100plb.33.1683739681391;
        Wed, 10 May 2023 10:28:01 -0700 (PDT)
Received: from krava ([2001:4958:15a0:30:84fc:2d48:aeac:9034])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a04ff0e2eesm4071002plb.58.2023.05.10.10.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 10:28:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 May 2023 10:27:59 -0700
To: Yonghong Song <yhs@meta.com>
Cc: Ze Gao <zegao2021@gmail.com>, Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Ze Gao <zegao@tencent.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
Message-ID: <ZFvUH+p0ebcgnwEg@krava>
References: <20230510122045.2259-1-zegao@tencent.com>
 <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 07:13:58AM -0700, Yonghong Song wrote:
> 
> 
> On 5/10/23 5:20 AM, Ze Gao wrote:
> > BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
> > however it does not takes those kprobe blacklisted into consideration,
> > which likely introduce recursive traps and blows up stacks.
> > 
> > this patch adds simple check and remove those are in kprobe_blacklist
> > from one fprobe during bpf_kprobe_multi_link_attach. And also
> > check_kprobe_address_safe is open for more future checks.
> > 
> > note that ftrace provides recursion detection mechanism, but for kprobe
> > only, we can directly reject those cases early without turning to ftrace.
> > 
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >   kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 9a050e36dc6c..44c68bc06bbd 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
> >   	return arr.mods_cnt;
> >   }
> > +static inline int check_kprobe_address_safe(unsigned long addr)
> > +{
> > +	if (within_kprobe_blacklist(addr))
> > +		return -EINVAL;
> > +	else
> > +		return 0;
> > +}
> > +
> > +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
> > +{
> > +	int i, cnt;
> > +	char symname[KSYM_NAME_LEN];
> > +
> > +	for (i = 0; i < num; ++i) {
> > +		if (check_kprobe_address_safe((unsigned long)addrs[i])) {
> > +			lookup_symbol_name(addrs[i], symname);
> > +			pr_warn("bpf_kprobe: %s at %lx is blacklisted\n", symname, addrs[i]);
> 
> So user request cannot be fulfilled and a warning is issued and some
> of user requests are discarded and the rest is proceeded. Does not
> sound a good idea.
> 
> Maybe we should do filtering in user space, e.g., in libbpf, check
> /sys/kernel/debug/kprobes/blacklist and return error
> earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
> requesting kprobe in the kernel.

also fprobe uses ftrace drectly without paths in kprobe, so I wonder
some of the kprobe blacklisted functions are actually safe

jirka

> 
> > +			/* mark blacklisted symbol for remove */
> > +			addrs[i] = 0;
> > +		}
> > +	}
> > +
> > +	/* remove blacklisted symbol from addrs */
> > +	for (i = 0, cnt = 0; i < num; ++i) {
> > +		if (addrs[i])
> > +			addrs[cnt++]  = addrs[i];
> > +	}
> > +
> > +	return cnt;
> > +}
> > +
> >   int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >   {
> >   	struct bpf_kprobe_multi_link *link = NULL;
> > @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >   	else
> >   		link->fp.entry_handler = kprobe_multi_link_handler;
> > +	cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
> > +	if (!cnt) {
> > +		err = -EINVAL;
> > +		goto error;
> > +	}
> > +
> >   	link->addrs = addrs;
> >   	link->cookies = cookies;
> >   	link->cnt = cnt;

