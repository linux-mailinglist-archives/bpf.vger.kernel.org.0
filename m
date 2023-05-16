Return-Path: <bpf+bounces-602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE17044DA
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 07:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378891C20D43
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D61D2A4;
	Tue, 16 May 2023 05:49:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F6107B2
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 05:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95401C433D2;
	Tue, 16 May 2023 05:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684216152;
	bh=x1pTlw1V19z0aDBofMrV/rBF4TFc3StzNYctHqoKgiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nA86npDtnLbRixJeEJg4inJyd169D0VJZZ0/sLDEFPzRPkAe7vbxJMs2z2lbPG5km
	 q6WbR7Rs4E52slK0McHeP0OyGPuNF+ExqWT5d3ufMurZH9QEo/ZNoaYHlVuElFxaSG
	 S0vxArdko6V6Kaxgc812/k7NIYblAYXd/UR4l410vUMJ1DrAVlwZyjVeVx0Tn0P3n+
	 WvIW2rRvuKfKWZATQlTz+siXoCIM43k2k3uv2PLjUs4ElBJ1z3i3VuoLp99BCdKtiU
	 MPEPHHqEQsfSQUen/dA9KH1krrySABXFMYaD80jLM8zUuNr4XBGuTfieqCno/Ui6k5
	 UTuTpfTQTWUCQ==
Date: Tue, 16 May 2023 14:49:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yonghong Song <yhs@meta.com>
Cc: Ze Gao <zegao2021@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, Song Liu
 <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ze Gao
 <zegao@tencent.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to
 avoid recursive trap
Message-Id: <20230516144908.f062ab19327634fc40cfc3b7@kernel.org>
In-Reply-To: <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
References: <20230510122045.2259-1-zegao@tencent.com>
	<6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
	<ZFvUH+p0ebcgnwEg@krava>
	<CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
	<ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 12 May 2023 07:29:02 -0700
Yonghong Song <yhs@meta.com> wrote:

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
> > 
> > I'm considering providing a general  fprobe_blacklist framework just
> > like what kprobe does to allow others to mark
> > functions used inside fprobe handler or rethook handler as NOFPROBE to
> > avoid potential stack recursion. But only after
> > I figure out how ftrace handles recursion problems currently and why
> > it fails in the case I ran into.
> 
> A fprobe_blacklist might make sense indeed as fprobe and kprobe are 
> quite different... Thanks for working on this.

No, I don't like fprobe_blacklist, because you can filter user given
function with <tracefs>/available_filter_functions :)
If the function is not listed there, you can not put fprobe on it.
IOW, kprobe_multi_link_prog_run only covers those functions. (white-list)

At the tooling side, it should check whether the probe is defined for
single function or multiple functions, and use kprobe-blacklist (single)
or available_filter_functions (multiple).

Thank you,

> 
> > 
> > Thanks
> > Ze
> > 
> > On Thu, May 11, 2023 at 1:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>
> >> On Wed, May 10, 2023 at 07:13:58AM -0700, Yonghong Song wrote:
> >>>
> >>>
> >>> On 5/10/23 5:20 AM, Ze Gao wrote:
> >>>> BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
> >>>> however it does not takes those kprobe blacklisted into consideration,
> >>>> which likely introduce recursive traps and blows up stacks.
> >>>>
> >>>> this patch adds simple check and remove those are in kprobe_blacklist
> >>>> from one fprobe during bpf_kprobe_multi_link_attach. And also
> >>>> check_kprobe_address_safe is open for more future checks.
> >>>>
> >>>> note that ftrace provides recursion detection mechanism, but for kprobe
> >>>> only, we can directly reject those cases early without turning to ftrace.
> >>>>
> >>>> Signed-off-by: Ze Gao <zegao@tencent.com>
> >>>> ---
> >>>>    kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
> >>>>    1 file changed, 37 insertions(+)
> >>>>
> >>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >>>> index 9a050e36dc6c..44c68bc06bbd 100644
> >>>> --- a/kernel/trace/bpf_trace.c
> >>>> +++ b/kernel/trace/bpf_trace.c
> >>>> @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
> >>>>      return arr.mods_cnt;
> >>>>    }
> >>>> +static inline int check_kprobe_address_safe(unsigned long addr)
> >>>> +{
> >>>> +   if (within_kprobe_blacklist(addr))
> >>>> +           return -EINVAL;
> >>>> +   else
> >>>> +           return 0;
> >>>> +}
> >>>> +
> >>>> +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
> >>>> +{
> >>>> +   int i, cnt;
> >>>> +   char symname[KSYM_NAME_LEN];
> >>>> +
> >>>> +   for (i = 0; i < num; ++i) {
> >>>> +           if (check_kprobe_address_safe((unsigned long)addrs[i])) {
> >>>> +                   lookup_symbol_name(addrs[i], symname);
> >>>> +                   pr_warn("bpf_kprobe: %s at %lx is blacklisted\n", symname, addrs[i]);
> >>>
> >>> So user request cannot be fulfilled and a warning is issued and some
> >>> of user requests are discarded and the rest is proceeded. Does not
> >>> sound a good idea.
> >>>
> >>> Maybe we should do filtering in user space, e.g., in libbpf, check
> >>> /sys/kernel/debug/kprobes/blacklist and return error
> >>> earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
> >>> requesting kprobe in the kernel.
> >>
> >> also fprobe uses ftrace drectly without paths in kprobe, so I wonder
> >> some of the kprobe blacklisted functions are actually safe
> >>
> >> jirka
> >>
> >>>
> >>>> +                   /* mark blacklisted symbol for remove */
> >>>> +                   addrs[i] = 0;
> >>>> +           }
> >>>> +   }
> >>>> +
> >>>> +   /* remove blacklisted symbol from addrs */
> >>>> +   for (i = 0, cnt = 0; i < num; ++i) {
> >>>> +           if (addrs[i])
> >>>> +                   addrs[cnt++]  = addrs[i];
> >>>> +   }
> >>>> +
> >>>> +   return cnt;
> >>>> +}
> >>>> +
> >>>>    int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >>>>    {
> >>>>      struct bpf_kprobe_multi_link *link = NULL;
> >>>> @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >>>>      else
> >>>>              link->fp.entry_handler = kprobe_multi_link_handler;
> >>>> +   cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
> >>>> +   if (!cnt) {
> >>>> +           err = -EINVAL;
> >>>> +           goto error;
> >>>> +   }
> >>>> +
> >>>>      link->addrs = addrs;
> >>>>      link->cookies = cookies;
> >>>>      link->cnt = cnt;


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

