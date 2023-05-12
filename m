Return-Path: <bpf+bounces-458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCAE701235
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 00:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A421C21383
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360CD22606;
	Fri, 12 May 2023 22:33:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CB22601
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 22:33:48 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F150E26B5;
	Fri, 12 May 2023 15:33:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96649b412easo1227952466b.0;
        Fri, 12 May 2023 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683930825; x=1686522825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IU2gGPYi6AoWZl8MlRsD1WjiXGseG7AJ7Zgys1xO5Qs=;
        b=JCwj0A8roa4azxQQR+Dwe+9Z9OqzhwSUwgJE2mS1JgPso41H3BVLfqMTXEi/M7dprp
         0J3n3RZk+D3+OdWT4I9UqxUMSCC8IdJZP7SasmN0ardxVU9NrcmO9O5rDG5cwpgjyqiO
         R2w3W4fa51dYXO35PBo7GZ4gvDXGdD/l4L7jBxWjYJYieyhsKPgKe9g+D1wpXKksHC6j
         zVV+OgAU46KgnEbXkxOB3PGaRSzQJjzvbe8OVigIu2SiN7Hehz8I+aWs4P4f8+oi5Ok6
         RqrqjHIx5PXjCQWrszlCdg97/w9pmD0eNjMsyUTDzTMedis6L3jfC2k+iouRTFN88UrV
         WLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683930825; x=1686522825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IU2gGPYi6AoWZl8MlRsD1WjiXGseG7AJ7Zgys1xO5Qs=;
        b=RwHrRjEfyLIH8bciiq9yU9WWUlNqlwy/R+mHwuMVifenx9ZLYXumIJF8lO2MZAal1H
         1WEpQDYadkQ/z+tCJ6hs43nvi2Mqm8AfhTv7c6YvJZgd9mJG+1jBy6PfRlmnF27JbZDm
         /vscOx4ys5lJ+hhF9kjHB9ylSk5WUad81ASOoLGz4sESsSXLAyK5vnzlQp3Lo1+VEA5I
         74+QcmBF0wehjrf2RGzp+EbpGTk8YqyE7XGWL9Vr7tg3+CtehYL+UU5KfPnVOXCX7RF+
         KlqieZl4W6IVNHI9bZlbpX4eg6hPdOiSZfbCil3I8dF3EBAQJN3iBQFMaiBnf15cvznM
         ZH1w==
X-Gm-Message-State: AC+VfDybuYBRgNNBBz6S/y5uwvDbY6Egxqut8ysjOOoItYvQRq6VRceH
	/tH/ALaRWTTLu8TgrrO++kvrv4FzYjrylZBLW5g=
X-Google-Smtp-Source: ACHHUZ7kPnc1oPNaLnTq/QbSAcQQxVdD1fx9SMxAHwD13LXDMMoRlj6yT/6NwKQwN7dFflmWpAWKwg==
X-Received: by 2002:a17:907:1607:b0:96a:440b:d5c8 with SMTP id hb7-20020a170907160700b0096a440bd5c8mr8959577ejc.59.1683930825169;
        Fri, 12 May 2023 15:33:45 -0700 (PDT)
Received: from krava (213-240-85-134.hdsl.highway.telekom.at. [213.240.85.134])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm6052772ejb.18.2023.05.12.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 15:33:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 13 May 2023 00:33:41 +0200
To: Yonghong Song <yhs@meta.com>
Cc: Ze Gao <zegao2021@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <ZF6+xU6sGGyGEhjE@krava>
References: <20230510122045.2259-1-zegao@tencent.com>
 <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
 <ZFvUH+p0ebcgnwEg@krava>
 <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
 <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 12, 2023 at 07:29:02AM -0700, Yonghong Song wrote:
> 
> 
> On 5/11/23 10:53 PM, Ze Gao wrote:
> > Yes, Jiri. Thanks for pointing it out. It's true that not all probe
> > blacklisted functions should be banned from bpf_kprobe.
> > 
> > I tried some of them, and all kprobe blacklisted symbols I hooked
> > works fine except preempt_count_{sub, add}.
> > so the takeaway here is preempt_cout_{sub, add} must be rejected at
> > least for now since kprobe_multi_link_prog_run
> > ( i.e., the fprobe handler) and rethook_trampoline_handler( i.e. the
> > rethook handler) calls preempt_cout_{sub, add}.

check BTF_SET_START(btf_id_deny) list for functions that we do not allow to
attach for tracing programs.. the direct ftrace interface used by trampolines
has likely similar limitations as fptrace_ops API used by fprobe


> > 
> > I'm considering providing a general  fprobe_blacklist framework just
> > like what kprobe does to allow others to mark
> > functions used inside fprobe handler or rethook handler as NOFPROBE to
> > avoid potential stack recursion. But only after
> > I figure out how ftrace handles recursion problems currently and why
> > it fails in the case I ran into.
> 
> A fprobe_blacklist might make sense indeed as fprobe and kprobe are quite
> different... Thanks for working on this.

+1

jirka

> 
> > 
> > Thanks
> > Ze
> > 
> > On Thu, May 11, 2023 at 1:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > 
> > > On Wed, May 10, 2023 at 07:13:58AM -0700, Yonghong Song wrote:
> > > > 
> > > > 
> > > > On 5/10/23 5:20 AM, Ze Gao wrote:
> > > > > BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
> > > > > however it does not takes those kprobe blacklisted into consideration,
> > > > > which likely introduce recursive traps and blows up stacks.
> > > > > 
> > > > > this patch adds simple check and remove those are in kprobe_blacklist
> > > > > from one fprobe during bpf_kprobe_multi_link_attach. And also
> > > > > check_kprobe_address_safe is open for more future checks.
> > > > > 
> > > > > note that ftrace provides recursion detection mechanism, but for kprobe
> > > > > only, we can directly reject those cases early without turning to ftrace.
> > > > > 
> > > > > Signed-off-by: Ze Gao <zegao@tencent.com>
> > > > > ---
> > > > >    kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
> > > > >    1 file changed, 37 insertions(+)
> > > > > 
> > > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > > index 9a050e36dc6c..44c68bc06bbd 100644
> > > > > --- a/kernel/trace/bpf_trace.c
> > > > > +++ b/kernel/trace/bpf_trace.c
> > > > > @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
> > > > >      return arr.mods_cnt;
> > > > >    }
> > > > > +static inline int check_kprobe_address_safe(unsigned long addr)
> > > > > +{
> > > > > +   if (within_kprobe_blacklist(addr))
> > > > > +           return -EINVAL;
> > > > > +   else
> > > > > +           return 0;
> > > > > +}
> > > > > +
> > > > > +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
> > > > > +{
> > > > > +   int i, cnt;
> > > > > +   char symname[KSYM_NAME_LEN];
> > > > > +
> > > > > +   for (i = 0; i < num; ++i) {
> > > > > +           if (check_kprobe_address_safe((unsigned long)addrs[i])) {
> > > > > +                   lookup_symbol_name(addrs[i], symname);
> > > > > +                   pr_warn("bpf_kprobe: %s at %lx is blacklisted\n", symname, addrs[i]);
> > > > 
> > > > So user request cannot be fulfilled and a warning is issued and some
> > > > of user requests are discarded and the rest is proceeded. Does not
> > > > sound a good idea.
> > > > 
> > > > Maybe we should do filtering in user space, e.g., in libbpf, check
> > > > /sys/kernel/debug/kprobes/blacklist and return error
> > > > earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
> > > > requesting kprobe in the kernel.
> > > 
> > > also fprobe uses ftrace drectly without paths in kprobe, so I wonder
> > > some of the kprobe blacklisted functions are actually safe
> > > 
> > > jirka
> > > 
> > > > 
> > > > > +                   /* mark blacklisted symbol for remove */
> > > > > +                   addrs[i] = 0;
> > > > > +           }
> > > > > +   }
> > > > > +
> > > > > +   /* remove blacklisted symbol from addrs */
> > > > > +   for (i = 0, cnt = 0; i < num; ++i) {
> > > > > +           if (addrs[i])
> > > > > +                   addrs[cnt++]  = addrs[i];
> > > > > +   }
> > > > > +
> > > > > +   return cnt;
> > > > > +}
> > > > > +
> > > > >    int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> > > > >    {
> > > > >      struct bpf_kprobe_multi_link *link = NULL;
> > > > > @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> > > > >      else
> > > > >              link->fp.entry_handler = kprobe_multi_link_handler;
> > > > > +   cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
> > > > > +   if (!cnt) {
> > > > > +           err = -EINVAL;
> > > > > +           goto error;
> > > > > +   }
> > > > > +
> > > > >      link->addrs = addrs;
> > > > >      link->cookies = cookies;
> > > > >      link->cnt = cnt;

