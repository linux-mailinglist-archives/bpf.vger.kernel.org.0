Return-Path: <bpf+bounces-78622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 722FBD156FB
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 907403007656
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADDA341ADD;
	Mon, 12 Jan 2026 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/sh6hFR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8685D341077
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253278; cv=none; b=kHlcG8DMxa+HV8gGgvQ0JqIYfijb8UOfgqx3scurTny74judegdH64rQ9g4a2kTnt113p4lYQkzG4jpP3F8dow20BgLqDaIIQv3IQQ2ewYS9jbcZwezEH2LccXnfuT3gf+BHPAF4bkA6Ii6FqQ4Pc+XdQtlDPgWTP4wIfGClDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253278; c=relaxed/simple;
	bh=2cfeRh/TqwL/Pv0ox/+JPyizCsTVyFt6ByQhjDKnX3E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMfnlScaMGwKjkQSs+4/CNn4jMjw7rRn1E71V3PnO27a0jaOxDzFc20aemKY6vOcSLCN9FSMa98Q4Vtp9deunitApLZeDKPdkjGcqBgqqNvM7MG8v5tn5mg8s/HG0bVaVlcHTnshg58TNkeEw4yk5AEQ6m/WwsQJrzwRM7oz/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/sh6hFR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so5126042f8f.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 13:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768253275; x=1768858075; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQq++ScOu7vE0Lz/RtZKByNqj4pSUn78IDE7wyXt0WA=;
        b=A/sh6hFRnLJm/+CQmrimGB7Thd9dV9AWzSmNNZ5TuA208Vg2xYSwBkQyxlf7z3tywq
         5RReQKE0asslxgwS+5qZvYG2pdmhiQjVmvkPwshrqUSTOCUaDD/YgiCAfYZhc+nLYciD
         Af5d1nFdsw7SfkcmH4I1XLTb8ApgFey54AIDDibsY4X5nc0JZFv0VjRJw/UfiiYrj2wU
         Ktm+VvAJy0a9SatISliYe0cM50/EgE0crTrNff9Df70428pXrwckIFkNhnGSODSMES94
         0hw6X/gGUBl5ODUVvYUwgcPjfhvQJnC8kkZV5HhmZYnw0OONJErDNmNgVd4YgxTAjbLF
         JDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768253275; x=1768858075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQq++ScOu7vE0Lz/RtZKByNqj4pSUn78IDE7wyXt0WA=;
        b=wSa/KtTLnhDzwZ10OspbCfx4grBbVBkeFkEr7g13ZeUeEZPozOeeQFCvEosUINwbDT
         A+jdCT98r/enkJvTXGeJcrRyRN8aZjxewGBlaT8pv2vIYlK06Lm3ebYHezl4jASCg8lC
         xRHFwYc9PipyT39R3ceQDvhkgj0avawwvcQr/wmNQzRdiOF5m7lDILCF7g1pa6wbi17v
         6mT1PQaTSnndxDAcXseC3FBk+8cUprBulMZqdFg1VRaXoRnljR8fwIR0goQ631bK5Fsi
         LKQdOole/gwFMQV3FDmAxDj8Bd5usdl+wq5cDK0buGvRYxM+1r1/oAIbeGIqoQHKltHe
         1WZg==
X-Forwarded-Encrypted: i=1; AJvYcCWwsayfzUL+XVtSBbs+uWx/ekN/9HgCPWeLJ1mHl0xRRKytGx/dUWgx0omcMoKKzR71OzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSmB47/WfWy6lmXfNnpg/w3wZDr12bM3LqM8740PFQXEhJIsI5
	Fc8ejojZjbFPT2kv2kLrBdLXvkJ4C63PbAAw70/J9uieLZGwpgV9BR/H
X-Gm-Gg: AY/fxX4y1VFVoYpMgHFk1WQgupzO+4J3SEaz5SkXo8hNh+bXvAFu5ZjFxswBhhbmPiJ
	/38kjYAjP1k6qEJ8vnwuh3cQ9tesDMrh5taJXf86CJ88T1ZHGZlPvgeYp1CX1+o1b51HrY3B8QA
	ZYAGLZajiPRAWoSZppXzQ3l5R3GjQM+rxqewoAel+u9uyOROoWE2RfM7fCIGsLTyrK9SyGB06Ms
	T94E51sin631lkx0bzVXTFkppP7YK5FvJ4MTuHevMaatP7KhJt6Z6miYz61qX7FayH/702McbQW
	cr0h/2cdwfrYeQJcWuqWHJPwcq+ZzrsAcEWmAG8sMGt89RBxMzwQpq8JzPF2ilsp/4sS5yo+dyg
	E1nulaf11rDSu2GHVztFk9/k239Xuv0rxkVOQaZfDoifxRahJOVztnkiZHBq3/V67er25f8iri/
	I=
X-Google-Smtp-Source: AGHT+IEaR0UW2C1CAn+Cjl3UGT4xxu7bcNb4qy4s5ukdVRcSA5IGeSTNKCNErEm4FMX6pr1j+2gIQA==
X-Received: by 2002:a05:6000:290b:b0:431:369:e7b with SMTP id ffacd0b85a97d-432c3760c49mr22314037f8f.18.1768253274576;
        Mon, 12 Jan 2026 13:27:54 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm40113986f8f.16.2026.01.12.13.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:27:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Jan 2026 22:27:51 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv6 bpf-next 7/9] bpf: Add trampoline ip hash table
Message-ID: <aWVnVzeqWJBXwBze@krava>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <20251230145010.103439-8-jolsa@kernel.org>
 <CAEf4BzYgqWXoKTffa5Y6Xm-nPbL9aFgrStR0GfUs4-88f10EgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYgqWXoKTffa5Y6Xm-nPbL9aFgrStR0GfUs4-88f10EgQ@mail.gmail.com>

On Fri, Jan 09, 2026 at 04:36:41PM -0800, Andrii Nakryiko wrote:
> On Tue, Dec 30, 2025 at 6:51 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Following changes need to lookup trampoline based on its ip address,
> > adding hash table for that.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h     |  7 +++++--
> >  kernel/bpf/trampoline.c | 30 +++++++++++++++++++-----------
> >  2 files changed, 24 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 4e7d72dfbcd4..c85677aae865 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1325,14 +1325,17 @@ struct bpf_tramp_image {
> >  };
> >
> >  struct bpf_trampoline {
> > -       /* hlist for trampoline_table */
> > -       struct hlist_node hlist;
> > +       /* hlist for trampoline_key_table */
> > +       struct hlist_node hlist_key;
> > +       /* hlist for trampoline_ip_table */
> > +       struct hlist_node hlist_ip;
> >         struct ftrace_ops *fops;
> >         /* serializes access to fields of this trampoline */
> >         struct mutex mutex;
> >         refcount_t refcnt;
> >         u32 flags;
> >         u64 key;
> > +       unsigned long ip;
> >         struct {
> >                 struct btf_func_model model;
> >                 void *addr;
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 789ff4e1f40b..bdac9d673776 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -24,9 +24,10 @@ const struct bpf_prog_ops bpf_extension_prog_ops = {
> >  #define TRAMPOLINE_HASH_BITS 10
> >  #define TRAMPOLINE_TABLE_SIZE (1 << TRAMPOLINE_HASH_BITS)
> >
> > -static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
> > +static struct hlist_head trampoline_key_table[TRAMPOLINE_TABLE_SIZE];
> > +static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
> >
> > -/* serializes access to trampoline_table */
> > +/* serializes access to trampoline tables */
> >  static DEFINE_MUTEX(trampoline_mutex);
> >
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > @@ -135,15 +136,15 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
> >                            PAGE_SIZE, true, ksym->name);
> >  }
> >
> > -static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
> > +static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
> >  {
> >         struct bpf_trampoline *tr;
> >         struct hlist_head *head;
> >         int i;
> >
> >         mutex_lock(&trampoline_mutex);
> > -       head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
> > -       hlist_for_each_entry(tr, head, hlist) {
> > +       head = &trampoline_key_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
> > +       hlist_for_each_entry(tr, head, hlist_key) {
> >                 if (tr->key == key) {
> >                         refcount_inc(&tr->refcnt);
> >                         goto out;
> > @@ -164,8 +165,12 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
> >  #endif
> >
> >         tr->key = key;
> > -       INIT_HLIST_NODE(&tr->hlist);
> > -       hlist_add_head(&tr->hlist, head);
> > +       tr->ip = ftrace_location(ip);
> > +       INIT_HLIST_NODE(&tr->hlist_key);
> > +       INIT_HLIST_NODE(&tr->hlist_ip);
> > +       hlist_add_head(&tr->hlist_key, head);
> > +       head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
> 
> For key lookups we check that there is no existing trampoline for the
> given key. Can it happen that we have two trampolines at the same IP
> but using two different keys?

so multiple keys (different static functions with same name) resolving to
the same ip happened in past and we should now be able to catch those in
pahole, right? CC-ing Alan ;-)

however, that should fail the attachment on ftrace/direct layer

say we have already registered and attached trampoline key1-ip1,
follow-up attachment of trampoline with key2-ip1 will fail on:

  bpf_trampoline_update
    register_fentry
      direct_ops_add
        update_ftrace_direct_add
	  ...
	  /* Make sure requested entries are not already registered. */
	  fails, because ip1 is already in direct_functions
	  ...

jirka
 
> 
> 
> 
> > +       hlist_add_head(&tr->hlist_ip, head);
> >         refcount_set(&tr->refcnt, 1);
> >         mutex_init(&tr->mutex);
> >         for (i = 0; i < BPF_TRAMP_MAX; i++)
> > @@ -846,7 +851,7 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
> >                                          prog->aux->attach_btf_id);
> >
> >         bpf_lsm_find_cgroup_shim(prog, &bpf_func);
> > -       tr = bpf_trampoline_lookup(key);
> > +       tr = bpf_trampoline_lookup(key, 0);
> >         if (WARN_ON_ONCE(!tr))
> >                 return;
> >
> > @@ -866,7 +871,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
> >  {
> >         struct bpf_trampoline *tr;
> >
> > -       tr = bpf_trampoline_lookup(key);
> > +       tr = bpf_trampoline_lookup(key, tgt_info->tgt_addr);
> >         if (!tr)
> >                 return NULL;
> >
> > @@ -902,7 +907,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
> >          * fexit progs. The fentry-only trampoline will be freed via
> >          * multiple rcu callbacks.
> >          */
> > -       hlist_del(&tr->hlist);
> > +       hlist_del(&tr->hlist_key);
> > +       hlist_del(&tr->hlist_ip);
> >         if (tr->fops) {
> >                 ftrace_free_filter(tr->fops);
> >                 kfree(tr->fops);
> > @@ -1175,7 +1181,9 @@ static int __init init_trampolines(void)
> >         int i;
> >
> >         for (i = 0; i < TRAMPOLINE_TABLE_SIZE; i++)
> > -               INIT_HLIST_HEAD(&trampoline_table[i]);
> > +               INIT_HLIST_HEAD(&trampoline_key_table[i]);
> > +       for (i = 0; i < TRAMPOLINE_TABLE_SIZE; i++)
> > +               INIT_HLIST_HEAD(&trampoline_ip_table[i]);
> >         return 0;
> >  }
> >  late_initcall(init_trampolines);
> > --
> > 2.52.0
> >

