Return-Path: <bpf+bounces-32355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FECC90BF58
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 00:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163A81F215FE
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E3199EBC;
	Mon, 17 Jun 2024 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3Vk/POF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD228FC;
	Mon, 17 Jun 2024 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664844; cv=none; b=ETdnRfapUECaJJG6eAlAyiSs+3Etg+ZTyVRhyFFBPGRxt4suQBRE6vNwyC3E1Muo+iPxjy0S0FF6cRItVRpDZrO1zfnPtGWSmQ1fQPMAS/PKjCgXq4meJSY08TL4y9Ms2o3YjpWDAcO73D7wrR8A668Jr74mtzoHlgMDxRqSX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664844; c=relaxed/simple;
	bh=gKVq9NreA83zmWg4zI8Bf9GfsmIQOHyb/2gaXDn+jEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkNhToLXxPJkfESFqlsGEYZocYe96nuv9Q3J77MvM4HW4aZCNMg7P6UB29U+7DFNADjt960zuKb5JvadznjKPQQBX7AQWobPTDQS++0ClgdOTX22k1ofPNNU+wEZ7mLSWyjum4iWAY5NUgSfx4McpEysvt68e2OHzyei86/PPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3Vk/POF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso3936906a91.2;
        Mon, 17 Jun 2024 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718664843; x=1719269643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euP5QDKTB5EI7sJME0BwF0iiV4DR44cs6erLRRFFlyI=;
        b=W3Vk/POF2CHC8gjQ+LWCMrOIRXnQ+tqXjhPKp1ZEgHyt0NtyjPdZL3ZWCUjphTtDGy
         MOQoZfdZPjhmQudIHOTEFr1eAhp/oI7vCQk1fbo+NUDYkoESLAd0QSV6vo1lkDVrovWg
         tMFOshG0WrLpdQLq67h6EIOR3tHETPTdqHCC5S6UtfdPK8xUpM8G9kKPf7mg0dj9E0Zx
         BSSyDm/7o7NPe6XGBkH7jvZAF5KDfttgZOFUDiYF7JUFNzWSmzU0Mb8wDxPFHaR0A8t0
         qo5UFJAtP7y8czuFIMjZb9LHwQc5rG24ThHFsnNKisp2xHknG5hhDackmPcBEF9zL09J
         pB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718664843; x=1719269643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euP5QDKTB5EI7sJME0BwF0iiV4DR44cs6erLRRFFlyI=;
        b=qYyxifpA+bWXoqdQCkIYsMufL94TRu5DwOweaJ5Lv2TkCLUO7c+vsPCpNL8dbfo1c3
         zSwd4SMUS8D2rMyXi0R+ySg9+oycVyrn5Vn8ZlUovJ+UhQihJ5JqFKbhceNEETkDp9ZQ
         QxVObv9zEuXhHLVVZoN2gHTnumDbUgAtp/iA1i+IPUC8BCZsVTuoJhHbdZMQEtfOZq7y
         hWuf0HQm7cJVFXYIzUeFK8g9jlfzrxer8ufZEdR02hQXgfPnD7wYqvfEVpJUGif/ORqI
         PcrQeTjPnrQIUuzSwuu3/S75DwQxOSJOZX+yOjOcuRpVfvpXvFfZ/ypGAjvATc3hzWWJ
         7RwA==
X-Forwarded-Encrypted: i=1; AJvYcCXLe5q6FSK5GfhKJ/pVLTDRb3ngWKezzt8sDzpmzTymhTlD7gnjaKIdqdtg3K+qVMufvgmM8yh+5MXdSAaav2ZNgBVDajO8r8X0Fs5s0bkl9+LJwT8HVnBBEd05U5EiGIcjhEyg0D3R1Ol7uExgdtsxNb1NYoamQFPll6hPaBWmYs0cbta0
X-Gm-Message-State: AOJu0YzDG3R7xhfanMEDwXZIJrtj8vW75VvJOIpSCtPnng77QNvejlxN
	/IOxL5KBWHfEGgEjhuscbaFFpd58Az6BYjWRSuKNvPS0BSzJfcK6jtT1aFHjtm0EOGKnGG3GJtZ
	gsSZyYneioiN7k6IMC6OiHYAEwTk=
X-Google-Smtp-Source: AGHT+IGPGwNguwIysJ7Ic3F6GSehGgYoAOs0VsCnmqllCklhAUSuV+oj4WPhV9FO4RkKaiubPmDvw0WZvaeA2Wf/chA=
X-Received: by 2002:a17:90a:5ac6:b0:2c6:de10:6ac3 with SMTP id
 98e67ed59e1d1-2c6de106bbbmr836066a91.31.1718664842643; Mon, 17 Jun 2024
 15:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604200221.377848-1-jolsa@kernel.org> <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com> <ZmDPQH2uiPYTA_df@krava>
 <ZmHn43Af4Kwlxoyc@krava> <CAEf4BzaFcpqFc8w6dH5oOJNKsAXZjs-KCFAXLp8TMBtS5ooo4g@mail.gmail.com>
 <ZmbePPIKqc6XuVjL@krava>
In-Reply-To: <ZmbePPIKqc6XuVjL@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 17 Jun 2024 15:53:50 -0700
Message-ID: <CAEf4BzaqDSGBbaEuOpEW5NbosgN8jE4CUE8s+-dgs-0sV6_geA@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to uprobe_consumer
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 4:06=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jun 06, 2024 at 09:52:39AM -0700, Andrii Nakryiko wrote:
> > On Thu, Jun 6, 2024 at 9:46=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Wed, Jun 05, 2024 at 10:50:11PM +0200, Jiri Olsa wrote:
> > > > On Wed, Jun 05, 2024 at 07:56:19PM +0200, Oleg Nesterov wrote:
> > > > > On 06/05, Andrii Nakryiko wrote:
> > > > > >
> > > > > > so any such
> > > > > > limitations will cause problems, issue reports, investigation, =
etc.
> > > > >
> > > > > Agreed...
> > > > >
> > > > > > As one possible solution, what if we do
> > > > > >
> > > > > > struct return_instance {
> > > > > >     ...
> > > > > >     u64 session_cookies[];
> > > > > > };
> > > > > >
> > > > > > and allocate sizeof(struct return_instance) + 8 *
> > > > > > <num-of-session-consumers> and then at runtime pass
> > > > > > &session_cookies[i] as data pointer to session-aware callbacks?
> > > > >
> > > > > I too thought about this, but I guess it is not that simple.
> > > > >
> > > > > Just for example. Suppose we have 2 session-consumers C1 and C2.
> > > > > What if uprobe_unregister(C1) comes before the probed function
> > > > > returns?
> > > > >
> > > > > We need something like map_cookie_to_consumer().
> > > >
> > > > I guess we could have hash table in return_instance that gets 'cons=
umer -> cookie' ?
> > >
> > > ok, hash table is probably too big for this.. I guess some solution t=
hat
> > > would iterate consumers and cookies made sure it matches would be fin=
e
> > >
> >
> > Yes, I was hoping to avoid hash tables for this, and in the common
> > case have no added overhead.
>
> hi,
> here's first stab on that.. the change below:
>   - extends current handlers with extra argument rather than adding new
>     set of handlers
>   - store session consumers objects within return_instance object and
>   - iterate these objects ^^^ in handle_uretprobe_chain
>
> I guess it could be still polished, but I wonder if this could
> be the right direction to do this.. thoughts? ;-)

Yeah, I think this is the right direction. It's a bit sad that this
makes getting rid of rw_sem on hot path even harder, but that's a
separate problem.

>
> thanks,
> jirka
>
>
> ---
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index f46e0ca0169c..4e40e8352eac 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -34,15 +34,19 @@ enum uprobe_filter_ctx {
>  };
>
>  struct uprobe_consumer {
> -       int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
);
> +       int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs=
,
> +                       unsigned long *data);

can we use __u64 here? This long vs __u64 might cause problems for BPF
when the host is 32-bit architecture (BPF is always 64-bit).

>         int (*ret_handler)(struct uprobe_consumer *self,
>                                 unsigned long func,
> -                               struct pt_regs *regs);
> +                               struct pt_regs *regs,
> +                               unsigned long *data);
>         bool (*filter)(struct uprobe_consumer *self,
>                                 enum uprobe_filter_ctx ctx,
>                                 struct mm_struct *mm);
>

[...]

>  static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
>  {
>         struct uprobe_task *n_utask;
> @@ -1756,11 +1795,11 @@ static int dup_utask(struct task_struct *t, struc=
t uprobe_task *o_utask)
>
>         p =3D &n_utask->return_instances;
>         for (o =3D o_utask->return_instances; o; o =3D o->next) {
> -               n =3D kmalloc(sizeof(struct return_instance), GFP_KERNEL)=
;
> +               n =3D alloc_return_instance(o->session_cnt);
>                 if (!n)
>                         return -ENOMEM;
>
> -               *n =3D *o;
> +               memcpy(n, o, ri_size(o->session_cnt));
>                 get_uprobe(n->uprobe);
>                 n->next =3D NULL;
>
> @@ -1853,35 +1892,38 @@ static void cleanup_return_instances(struct uprob=
e_task *utask, bool chained,
>         utask->return_instances =3D ri;
>  }
>
> -static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *reg=
s)
> +static struct return_instance *
> +prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
> +                 struct return_instance *ri, int session_cnt)

you have struct uprobe, why do you need to pass session_cnt? Also,
given return_instance is cached, it seems more natural to have

struct return_instance **ri as in/out parameter, and keep the function
itself as void

>  {
> -       struct return_instance *ri;
>         struct uprobe_task *utask;
>         unsigned long orig_ret_vaddr, trampoline_vaddr;
>         bool chained;
>

[...]

>         if (need_prep && !remove)
> -               prepare_uretprobe(uprobe, regs); /* put bp at return */
> +               ri =3D prepare_uretprobe(uprobe, regs, ri, uprobe->sessio=
n_cnt); /* put bp at return */
> +       kfree(ri);
>
>         if (remove && uprobe->consumers) {
>                 WARN_ON(!uprobe_is_active(uprobe));
>                 unapply_uprobe(uprobe, current->mm);
>         }
> + out:
>         up_read(&uprobe->register_rwsem);
>  }
>
> +static struct session_consumer *
> +consumer_find(struct session_consumer *sc, struct uprobe_consumer *uc)

why can't we keep track of remaining number of session_consumer items
instead of using entire extra entry as a terminating element? Seems
wasteful and unnecessary.

> +{
> +       for (; sc && sc->id; sc++) {
> +               if (sc->id =3D=3D uc->id)
> +                       return sc;
> +       }
> +       return NULL;
> +}
> +

[...]

