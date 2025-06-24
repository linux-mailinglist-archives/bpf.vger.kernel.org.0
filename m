Return-Path: <bpf+bounces-61353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB8EAE5EDF
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF791B6735A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B5255F56;
	Tue, 24 Jun 2025 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNqXtYhN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD917A314;
	Tue, 24 Jun 2025 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752977; cv=none; b=F0RXp/SnXkdoqBa6Rhu+0OKP2CCvAsd3szvVQTnu5F7MsWMq5g297JSYJGEz7uTbXEMfJzbqIM5MX7pTihqVvqw0DSiLLNhmhLGcMRds4sDjGoEfLziByazUiHXSqEiCGRwQzb3YdVGnig8Z6AEJjEf+pkwEK1XeVpUHDWiALYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752977; c=relaxed/simple;
	bh=RHJWm97l1z86eZlG80G9Wnl+vHc5FKhGHFVeXhqLsUY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5IKF+VN1pflItG/qCEQd27dIH7oHIKgUyzxoJie8GpZ94Qx7akR0Mxw9LTRp2x0Wx35NetTCfZS9ZnZ7CvVhpdzzESd7O2Jcp7rAtKQznzjmO05HsQ02zn/GRflBEVY/2WztBK+AaF8ZfF7NkvQdBVNFDCiyUlg8y+bLFw0pQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNqXtYhN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso328031a12.2;
        Tue, 24 Jun 2025 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750752973; x=1751357773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mAcm5UIinGoMpKwWNc1ojafy/mX4XG65Y7yDM8lxv8E=;
        b=cNqXtYhN5K+iAACEDOIWQF7nlc5SEMNfddncG9KUg/Z+m/0LGp7NDJ9Cje7KAwjhIP
         GrQubti5PQ1vhB/kbuEFhoGlbzCVqKaT46/jneuL67mS6sloaueyhmH+NX2u2Wv77EhS
         wjUXybUG0SRQgyJuzOI++CzMF9gnBWckvT0beHgMbpAeabXvsk0b0G1Y6A0lJWw24kYR
         lbgCDsIga2J8RHJmgiKOBYA7xW8MBCdJ2ksGp8uAFnmgOfpNXk4ES45eVYRiZd/ya8Fw
         aaUVSUoQUlNX/mxWO3Eaws3r+YQTS3MHICpsDyL2gdtZArUXKZtof6EeEc2ctK13geef
         XCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750752973; x=1751357773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAcm5UIinGoMpKwWNc1ojafy/mX4XG65Y7yDM8lxv8E=;
        b=mHGkUjJperhSRK10oYca9s9Dl+Y1Sp17KHRFqoMlIAO5X6oAN06EvCkVXDrhdm9Gt1
         ouR6sQnKW3TyLfKfa9PMw6Ql7CAuAmLjpSsBneAJLLniQuqykpT6SL2DiCqNAR5W9lnT
         f5JAZt7lq4sSyeWJNt+Qc4+Hs4nVkFurKGBpFkxzYZKOFMvsP1/2yrrjvrIQKtIYjefX
         bb12X9fYbFq5tlAwQqZrS3W1eiQb7MoSxR8QWnCj98A9n83u5cfKYDAeJlJloYmalRgU
         3zeY8REMVqjHzYMRbKJZYYMWYjtuhatJdfgZdJ7cHiFsh5mT9umIe5iNy2mny7AyT9sW
         +7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4DNC5i7v12cop1P1VVoF1cmetqmcNtiP5O/XSuePV1EMiSA6Gurrx9uNmS7HB/7xnZSA7YzK4DB33tBVO@vger.kernel.org, AJvYcCUHODaEkXzxZeOxJwNNMsJ87HW+exlAWH3H9Kih/y7XAbkL/ba0ps0l8rRmETb0+roP4E8=@vger.kernel.org, AJvYcCXWJnU6oBEFjvCtOB73VYbHdaq0cZpIaIcAyVJ8KWozLwuCDug7uDJ19sIFW02Iu069UWWl1LxesOVvAMzUN5fLahvS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JgLEeGxJDI138ulex4ac/uP2+KbCdaX0LffdCstBb8HQSWd3
	wBjYx+nVf+etXteXZs4De8IOPUsRHMlUN6cEwQ2fEmMI1KSq0BpRV+pS
X-Gm-Gg: ASbGncsBhAVck5pBECw08S+DlmpgKtA9XBMlIFDNzUDZQfCMaQZDoBY+0x9s6vgqDmD
	GOAWmm7hUlTbYp9yMIh8XBkKkCODp1GQJ52mQy29BFf2R/C5/+HtEggATr+5AiCToy09CdfCxxk
	lR/T/fVhQq0mVvYdB//vSXzYJD46VwcXEX2zov4fdGJtCpu6/w7RXSdS/wzXPqZOHR7b1lGBnzH
	SG9HPIQqIb13wn+eoXlRApd4d0Fwh4cdEYkqGp1NhLhfX6TUGmk8yX5WHH60hOphvd24dfFDKtq
	2oJn47vbS/tf8FS1yV+ajP2lY0JRj07vUc0na2JYQ3CxiGjDPQ==
X-Google-Smtp-Source: AGHT+IFpo1YTfyKC9L7YcokNvlr++59Cb9VkIWvEcLrDGXixqSp+63diIhUWOy7XGW3xBFTxDYcAKA==
X-Received: by 2002:a17:907:d78a:b0:ad5:43eb:d927 with SMTP id a640c23a62f3a-ae0579d1f8dmr1503149466b.23.1750752972988;
        Tue, 24 Jun 2025 01:16:12 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e8218bsm836119166b.4.2025.06.24.01.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:16:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Jun 2025 10:16:09 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>, KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Show precise link_type for
 {uprobe,kprobe}_multi fdinfo
Message-ID: <aFpeyZnOuJ3Xr4J6@krava>
References: <20250623134342.227347-1-chen.dylane@linux.dev>
 <CAADnVQ+aZw4-3Ab9nLWrZUg78sc-SXuEGYnPrdOChw8m9sRLvw@mail.gmail.com>
 <CAEf4BzZVw4aSpdTH+VKkG_q6J-sQwSFSCyU+-c5DcA5euP49ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZVw4aSpdTH+VKkG_q6J-sQwSFSCyU+-c5DcA5euP49ng@mail.gmail.com>

On Mon, Jun 23, 2025 at 01:59:18PM -0700, Andrii Nakryiko wrote:
> On Mon, Jun 23, 2025 at 10:56 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jun 23, 2025 at 6:44 AM Tao Chen <chen.dylane@linux.dev> wrote:
> > >
> > > Alexei suggested, 'link_type' can be more precise and differentiate
> > > for human in fdinfo. In fact BPF_LINK_TYPE_KPROBE_MULTI includes
> > > kretprobe_multi type, the same as BPF_LINK_TYPE_UPROBE_MULTI, so we
> > > can show it more concretely.
> > >
> > > link_type:      kprobe_multi
> > > link_id:        1
> > > prog_tag:       d2b307e915f0dd37
> > > ...
> > > link_type:      kretprobe_multi
> > > link_id:        2
> > > prog_tag:       ab9ea0545870781d
> > > ...
> > > link_type:      uprobe_multi
> > > link_id:        9
> > > prog_tag:       e729f789e34a8eca
> > > ...
> > > link_type:      uretprobe_multi
> > > link_id:        10
> > > prog_tag:       7db356c03e61a4d4
> > >
> > > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > ---
> > >  include/linux/trace_events.h | 10 ++++++++++
> > >  kernel/bpf/syscall.c         |  9 ++++++++-
> > >  kernel/trace/bpf_trace.c     | 28 ++++++++++++++++++++++++++++
> > >  3 files changed, 46 insertions(+), 1 deletion(-)
> > >
> > > Change list:
> > >   v4 -> v5:
> > >     - Add patch1 to show precise link_type for
> > >       {uprobe,kprobe}_multi.(Alexei)
> > >     - patch2,3 just remove type field, which will be showed in
> > >       link_type
> > >   v4:
> > >   https://lore.kernel.org/bpf/20250619034257.70520-1-chen.dylane@linux.dev
> > >
> > >   v3 -> v4:
> > >     - use %pS to print func info.(Alexei)
> > >   v3:
> > >   https://lore.kernel.org/bpf/20250616130233.451439-1-chen.dylane@linux.dev
> > >
> > >   v2 -> v3:
> > >     - show info in one line for multi events.(Jiri)
> > >   v2:
> > >   https://lore.kernel.org/bpf/20250615150514.418581-1-chen.dylane@linux.dev
> > >
> > >   v1 -> v2:
> > >     - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
> > >     - print func name is more readable and security for kprobe_multi.(Alexei)
> > >   v1:
> > >   https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.dev
> > >
> > > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > > index fa9cf4292df..951c91babbc 100644
> > > --- a/include/linux/trace_events.h
> > > +++ b/include/linux/trace_events.h
> > > @@ -780,6 +780,8 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
> > >                             unsigned long *missed);
> > >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> > >  int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> > > +void bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len);
> > > +void bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len);
> > >  #else
> > >  static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
> > >  {
> > > @@ -832,6 +834,14 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> > >  {
> > >         return -EOPNOTSUPP;
> > >  }
> > > +static inline void
> > > +bpf_kprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len)
> > > +{
> > > +}
> > > +static inline void
> > > +bpf_uprobe_multi_link_type_show(const struct bpf_link *link, char *link_type, int len)
> > > +{
> > > +}
> > >  #endif
> > >
> > >  enum {
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 51ba1a7aa43..43b821b37bc 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -3226,9 +3226,16 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
> > >         const struct bpf_prog *prog = link->prog;
> > >         enum bpf_link_type type = link->type;
> > >         char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
> > > +       char link_type[64] = {};
> > >
> > >         if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
> > > -               seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
> > > +               if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
> > > +                       bpf_kprobe_multi_link_type_show(link, link_type, sizeof(link_type));
> > > +               else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
> > > +                       bpf_uprobe_multi_link_type_show(link, link_type, sizeof(link_type));
> > > +               else
> > > +                       strscpy(link_type, bpf_link_type_strs[type], sizeof(link_type));
> > > +               seq_printf(m, "link_type:\t%s\n", link_type);
> >
> > New callbacks just to print a string?
> > Let's find a different way.
> >
> > How about moving 'flags' from bpf_[ku]probe_multi_link into bpf_link ?
> > (There is a 7 byte hole there anyway)
> > and checking flags inline.
> >
> > Jiri, Andrii,
> >
> > better ideas?
> 
> We can just remember original attr->link_create.attach_type in
> bpf_link itself, and then have a small helper that will accept link
> type and attach type, and fill out link type representation based on
> those two. Internally we can do the special-casing of  uprobe vs
> uretprobe and kprobe vs kretprobe transparently to all the other code.
> And use that here in show_fdinfo

but you'd still need the flags, no? to find out if it's return probe

I tried what Alexei suggested and it seems ok and simple enough

jirka


---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dd556e89cce..287c956cdbd2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1702,6 +1702,7 @@ struct bpf_link {
 	 * link's semantics is determined by target attach hook
 	 */
 	bool sleepable;
+	u32 flags;
 	/* rcu is used before freeing, work can be used to schedule that
 	 * RCU-based freeing before that, so they never overlap
 	 */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 56500381c28a..f1d9ee9717a1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3228,7 +3228,14 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 
 	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
-		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+		if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
+			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_KPROBE_MULTI_RETURN ?
+				   "kretprobe_multi" : "kprobe_multi");
+		else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
+			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_UPROBE_MULTI_RETURN ?
+				   "uretprobe_multi" : "uprobe_multi");
+		else
+			seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
 	} else {
 		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
 		seq_printf(m, "link_type:\t<%u>\n", type);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0a06ea6638fe..81d7a4e5ae15 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2466,7 +2466,6 @@ struct bpf_kprobe_multi_link {
 	u32 cnt;
 	u32 mods_cnt;
 	struct module **mods;
-	u32 flags;
 };
 
 struct bpf_kprobe_multi_run_ctx {
@@ -2586,7 +2585,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	info->kprobe_multi.count = kmulti_link->cnt;
-	info->kprobe_multi.flags = kmulti_link->flags;
+	info->kprobe_multi.flags = kmulti_link->link.flags;
 	info->kprobe_multi.missed = kmulti_link->fp.nmissed;
 
 	if (!uaddrs)
@@ -2976,7 +2975,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->addrs = addrs;
 	link->cookies = cookies;
 	link->cnt = cnt;
-	link->flags = flags;
+	link->link.flags = flags;
 
 	if (cookies) {
 		/*
@@ -3045,7 +3044,6 @@ struct bpf_uprobe_multi_link {
 	struct path path;
 	struct bpf_link link;
 	u32 cnt;
-	u32 flags;
 	struct bpf_uprobe *uprobes;
 	struct task_struct *task;
 };
@@ -3109,7 +3107,7 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
 	info->uprobe_multi.count = umulti_link->cnt;
-	info->uprobe_multi.flags = umulti_link->flags;
+	info->uprobe_multi.flags = umulti_link->link.flags;
 	info->uprobe_multi.pid = umulti_link->task ?
 				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
 
@@ -3369,7 +3367,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->uprobes = uprobes;
 	link->path = path;
 	link->task = task;
-	link->flags = flags;
+	link->link.flags = flags;
 
 	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
 		      &bpf_uprobe_multi_link_lops, prog);

