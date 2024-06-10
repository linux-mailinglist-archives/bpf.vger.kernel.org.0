Return-Path: <bpf+bounces-31704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4932E90201D
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 13:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A46E1C218AC
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7BC79DDB;
	Mon, 10 Jun 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVXFs51Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C278C9E;
	Mon, 10 Jun 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017602; cv=none; b=WaYlQMDRr0y8aevJIeXNoMgm2JcfSJ7uThad3LtnX2Elr3rIaAshHAI+yMgSi6DLouMiIlgjZ5KdbsKeqbxubUAO5PYwRv9i6bfZVNDRXZgns36Tr60utmdFyQYpiVWCPHd2Szm/FhlGmIeSrvNwCeDmhpUaJe7YPMrNnH4kCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017602; c=relaxed/simple;
	bh=eN89P4Gijgwbd1kZfDZOo9Byb5RugBJUfe2RaqfLcY0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXfLAIsW5CmYDC5zlM7aUQ51tjibX+Y7NjEZrh6BJWayPDammsMHmbYM4fSTNTsCyZhhggpEyRJRcwyIF/vzMWLkjs6oEqXOYqtUptMqH7ETe6uzuiadIk7WEpl8vulX3K+dQfFmzw/Tf4rwpV6afk/xZnH/CC5OId8zwC/KFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVXFs51Y; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso222401066b.0;
        Mon, 10 Jun 2024 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718017599; x=1718622399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v/RJsnygqWaLtOBqetJ6C6fOKKEH8iBaTz+Irtp/U4Q=;
        b=GVXFs51Yt4dUCs9Vf7mANaWZUu85lOAcLqNMUdgtbRYkJiTGYf6zzMSGxROYHYVEEM
         zNvqJw87u5YmIiNTri8Dcw+9FGZNfQDUP95ofCIdbGFZP37LNRVq5QCC4dQE7UoswmZZ
         U30b6foiw7X7YftJIwF8epdqgasMKmTRCePh4TsTTfBO7q50IDYQ3Aeqorje1yp0j3XW
         4ZRBo+Ls6QCEjG6mixe9lKtAteZekOSJyq6PVyfb+hlrxos6JJzeBn/WHsS/nvnYVNWd
         7zc4QgHR5tdL48Y1D6E/rpkEWsx/Ow1KUAEfrUnFzzc+iZYVkoE/IInpeWV65xLTD2B2
         SkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718017599; x=1718622399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/RJsnygqWaLtOBqetJ6C6fOKKEH8iBaTz+Irtp/U4Q=;
        b=Mma/Guv4BOrmPzEQK9AxYObwqBWKMOmnb/pX4VDcK86QwUakglNwLtP/EikZD2Sifm
         3u1Ba3H/zqBuSyppftbu8LYkMuRM9NWFpUiHjQIeYAQHeQXGxoSsQeerBHqBHu1M/dsC
         5byLehcTUdK1KTZusOFXCSsMHmW8UH2JI9AA68wB/O1kC4JQyjmAouavJuQfeXvMPAJh
         De02QJUTySBtA6HL9qIpU7jMHhuBFtx1CxoUCcNu+qgAH8USVxQOk9kzTA1bxgKzxOpw
         1GhFz5GZj+ooTCBTREe5/ZgcwYsd3ZiMuxalmf+crM488mp2f1s7jDGzgg1B9E9bsGT7
         FcIg==
X-Forwarded-Encrypted: i=1; AJvYcCXBhE1M5i7kCtSHUUAoPr2RXWI0UVNssl8zAcIHXhJm/W1dnrDwC5FCY/LaWGCGPN3PLgW09tIxdwdw/DXCfMZbOgJjGi+LDS14wiIW6CFI2Qw3kufVHAjiOQxIQtqtm4DVlzQov4fae5RNuz7OXVDz6f6qjbXO8CZCGDM3txmeK4bxsNx7
X-Gm-Message-State: AOJu0YyzTKI875uypNr7Hw3Q3a5pK8MaYDiC4gVS6RnYFeWgmDnCCeNO
	3pW4P1GK07ttPuR6IxPFIFDUEEU8B7PDKgQGjJCGA1KrRuug1xe4
X-Google-Smtp-Source: AGHT+IHJB0mDHbzvs0d/HvBmKjQMT/69SEguC+92/PgSRWl+LReXxTJ6A0PHSsyRZkT8BmCzt+L8kg==
X-Received: by 2002:a17:907:9723:b0:a6f:1f7b:6a8b with SMTP id a640c23a62f3a-a6f1f7b6be5mr163160566b.66.1718017598781;
        Mon, 10 Jun 2024 04:06:38 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20e40072sm94792566b.89.2024.06.10.04.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 04:06:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Jun 2024 13:06:36 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <ZmbePPIKqc6XuVjL@krava>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com>
 <ZmDPQH2uiPYTA_df@krava>
 <ZmHn43Af4Kwlxoyc@krava>
 <CAEf4BzaFcpqFc8w6dH5oOJNKsAXZjs-KCFAXLp8TMBtS5ooo4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaFcpqFc8w6dH5oOJNKsAXZjs-KCFAXLp8TMBtS5ooo4g@mail.gmail.com>

On Thu, Jun 06, 2024 at 09:52:39AM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 6, 2024 at 9:46 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Jun 05, 2024 at 10:50:11PM +0200, Jiri Olsa wrote:
> > > On Wed, Jun 05, 2024 at 07:56:19PM +0200, Oleg Nesterov wrote:
> > > > On 06/05, Andrii Nakryiko wrote:
> > > > >
> > > > > so any such
> > > > > limitations will cause problems, issue reports, investigation, etc.
> > > >
> > > > Agreed...
> > > >
> > > > > As one possible solution, what if we do
> > > > >
> > > > > struct return_instance {
> > > > >     ...
> > > > >     u64 session_cookies[];
> > > > > };
> > > > >
> > > > > and allocate sizeof(struct return_instance) + 8 *
> > > > > <num-of-session-consumers> and then at runtime pass
> > > > > &session_cookies[i] as data pointer to session-aware callbacks?
> > > >
> > > > I too thought about this, but I guess it is not that simple.
> > > >
> > > > Just for example. Suppose we have 2 session-consumers C1 and C2.
> > > > What if uprobe_unregister(C1) comes before the probed function
> > > > returns?
> > > >
> > > > We need something like map_cookie_to_consumer().
> > >
> > > I guess we could have hash table in return_instance that gets 'consumer -> cookie' ?
> >
> > ok, hash table is probably too big for this.. I guess some solution that
> > would iterate consumers and cookies made sure it matches would be fine
> >
> 
> Yes, I was hoping to avoid hash tables for this, and in the common
> case have no added overhead.

hi,
here's first stab on that.. the change below:
  - extends current handlers with extra argument rather than adding new
    set of handlers
  - store session consumers objects within return_instance object and
  - iterate these objects ^^^ in handle_uretprobe_chain

I guess it could be still polished, but I wonder if this could
be the right direction to do this.. thoughts? ;-)

thanks,
jirka


---
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..4e40e8352eac 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -34,15 +34,19 @@ enum uprobe_filter_ctx {
 };
 
 struct uprobe_consumer {
-	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
+	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs,
+			unsigned long *data);
 	int (*ret_handler)(struct uprobe_consumer *self,
 				unsigned long func,
-				struct pt_regs *regs);
+				struct pt_regs *regs,
+				unsigned long *data);
 	bool (*filter)(struct uprobe_consumer *self,
 				enum uprobe_filter_ctx ctx,
 				struct mm_struct *mm);
 
 	struct uprobe_consumer *next;
+	bool is_session;
+	unsigned int id;
 };
 
 #ifdef CONFIG_UPROBES
@@ -80,6 +84,12 @@ struct uprobe_task {
 	unsigned int			depth;
 };
 
+struct session_consumer {
+	long cookie;
+	unsigned int id;
+	int rc;
+};
+
 struct return_instance {
 	struct uprobe		*uprobe;
 	unsigned long		func;
@@ -88,6 +98,8 @@ struct return_instance {
 	bool			chained;	/* true, if instance is nested */
 
 	struct return_instance	*next;		/* keep as stack */
+	int			session_cnt;
+	struct session_consumer	sc[1];		/* 1 for zero item marking the end */
 };
 
 enum rp_check {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..cbd71dc06ef0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -63,6 +63,8 @@ struct uprobe {
 	loff_t			ref_ctr_offset;
 	unsigned long		flags;
 
+	unsigned int		session_cnt;
+
 	/*
 	 * The generic code assumes that it has two members of unknown type
 	 * owned by the arch-specific code:
@@ -750,11 +752,30 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	return uprobe;
 }
 
+static void
+uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_consumer *uc)
+{
+	static unsigned int session_id;
+
+	if (uc->is_session) {
+		uprobe->session_cnt++;
+		uc->id = ++session_id ?: ++session_id;
+	}
+}
+
+static void
+uprobe_consumer_unaccount(struct uprobe *uprobe, struct uprobe_consumer *uc)
+{
+	if (uc->is_session)
+		uprobe->session_cnt--;
+}
+
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	down_write(&uprobe->consumer_rwsem);
 	uc->next = uprobe->consumers;
 	uprobe->consumers = uc;
+	uprobe_consumer_account(uprobe, uc);
 	up_write(&uprobe->consumer_rwsem);
 }
 
@@ -773,6 +794,7 @@ static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
 		if (*con == uc) {
 			*con = uc->next;
 			ret = true;
+			uprobe_consumer_unaccount(uprobe, uc);
 			break;
 		}
 	}
@@ -1744,6 +1766,23 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
 
+static size_t ri_size(int session_cnt)
+{
+	struct return_instance *ri __maybe_unused;
+
+	return sizeof(*ri) + session_cnt * sizeof(ri->sc[0]);
+}
+
+static struct return_instance *alloc_return_instance(int session_cnt)
+{
+	struct return_instance *ri;
+
+	ri = kzalloc(ri_size(session_cnt), GFP_KERNEL);
+	if (ri)
+		ri->session_cnt = session_cnt;
+	return ri;
+}
+
 static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 {
 	struct uprobe_task *n_utask;
@@ -1756,11 +1795,11 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
-		n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
+		n = alloc_return_instance(o->session_cnt);
 		if (!n)
 			return -ENOMEM;
 
-		*n = *o;
+		memcpy(n, o, ri_size(o->session_cnt));
 		get_uprobe(n->uprobe);
 		n->next = NULL;
 
@@ -1853,35 +1892,38 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 	utask->return_instances = ri;
 }
 
-static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
+static struct return_instance *
+prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
+		  struct return_instance *ri, int session_cnt)
 {
-	struct return_instance *ri;
 	struct uprobe_task *utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
 	bool chained;
 
 	if (!get_xol_area())
-		return;
+		return ri;
 
 	utask = get_utask();
 	if (!utask)
-		return;
+		return ri;
 
 	if (utask->depth >= MAX_URETPROBE_DEPTH) {
 		printk_ratelimited(KERN_INFO "uprobe: omit uretprobe due to"
 				" nestedness limit pid/tgid=%d/%d\n",
 				current->pid, current->tgid);
-		return;
+		return ri;
 	}
 
-	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
-	if (!ri)
-		return;
+	if (!ri) {
+		ri = alloc_return_instance(session_cnt);
+		if (!ri)
+			return NULL;
+	}
 
 	trampoline_vaddr = get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
-		goto fail;
+		return ri;
 
 	/* drop the entries invalidated by longjmp() */
 	chained = (orig_ret_vaddr == trampoline_vaddr);
@@ -1899,7 +1941,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 			 * attack from user-space.
 			 */
 			uprobe_warn(current, "handle tail call");
-			goto fail;
+			return ri;
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
@@ -1914,9 +1956,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	ri->next = utask->return_instances;
 	utask->return_instances = ri;
 
-	return;
- fail:
-	kfree(ri);
+	return NULL;
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -2069,44 +2109,90 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 {
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
+	struct session_consumer *sc = NULL;
+	struct return_instance *ri = NULL;
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
 	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	if (uprobe->session_cnt) {
+		ri = alloc_return_instance(uprobe->session_cnt);
+		if (!ri)
+			goto out;
+	}
+	for (uc = uprobe->consumers, sc = &ri->sc[0]; uc; uc = uc->next) {
 		int rc = 0;
 
 		if (uc->handler) {
-			rc = uc->handler(uc, regs);
+			rc = uc->handler(uc, regs, uc->is_session ? &sc->cookie : NULL);
 			WARN(rc & ~UPROBE_HANDLER_MASK,
 				"bad rc=0x%x from %ps()\n", rc, uc->handler);
 		}
 
-		if (uc->ret_handler)
+		if (uc->is_session) {
+			need_prep |= !rc;
+			remove = 0;
+			sc->id = uc->id;
+			sc->rc = rc;
+			sc++;
+		} else if (uc->ret_handler) {
 			need_prep = true;
+		}
 
 		remove &= rc;
 	}
 
 	if (need_prep && !remove)
-		prepare_uretprobe(uprobe, regs); /* put bp at return */
+		ri = prepare_uretprobe(uprobe, regs, ri, uprobe->session_cnt); /* put bp at return */
+	kfree(ri);
 
 	if (remove && uprobe->consumers) {
 		WARN_ON(!uprobe_is_active(uprobe));
 		unapply_uprobe(uprobe, current->mm);
 	}
+ out:
 	up_read(&uprobe->register_rwsem);
 }
 
+static struct session_consumer *
+consumer_find(struct session_consumer *sc, struct uprobe_consumer *uc)
+{
+	for (; sc && sc->id; sc++) {
+		if (sc->id == uc->id)
+			return sc;
+	}
+	return NULL;
+}
+
 static void
 handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 {
 	struct uprobe *uprobe = ri->uprobe;
+	struct session_consumer *sc, *tmp;
 	struct uprobe_consumer *uc;
 
 	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
-		if (uc->ret_handler)
-			uc->ret_handler(uc, ri->func, regs);
+	for (uc = uprobe->consumers, sc = &ri->sc[0]; uc; uc = uc->next) {
+		long *cookie = NULL;
+		int rc = 0;
+
+		if (uc->is_session) {
+			/*
+			 * session_consumers are in order with uprobe_consumers,
+			 * we just need to reflect that any uprobe_consumer could
+			 * be removed or added
+			 */
+			tmp = consumer_find(sc, uc);
+			if (tmp) {
+				rc = tmp->rc;
+				cookie = &tmp->cookie;
+				sc = tmp + 1;
+			} else {
+				rc = 1;
+			}
+		}
+
+		if (!rc && uc->ret_handler)
+			uc->ret_handler(uc, ri->func, regs, cookie);
 	}
 	up_read(&uprobe->register_rwsem);
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f5154c051d2c..ae7c35379e4a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3329,7 +3329,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, enum uprobe_filter_ctx ctx
 }
 
 static int
-uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
+uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
+			  unsigned long *data)
 {
 	struct bpf_uprobe *uprobe;
 
@@ -3338,7 +3339,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int
-uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
+uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs,
+			      unsigned long *data)
 {
 	struct bpf_uprobe *uprobe;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8541fa1494ae..f7b17f08344c 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -88,9 +88,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
 static int register_uprobe_event(struct trace_uprobe *tu);
 static int unregister_uprobe_event(struct trace_uprobe *tu);
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     unsigned long *data);
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs);
+				unsigned long func, struct pt_regs *regs,
+				unsigned long *data);
 
 #ifdef CONFIG_STACK_GROWSUP
 static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
@@ -1500,7 +1502,8 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
 	}
 }
 
-static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
+static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
+			     unsigned long *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
@@ -1530,7 +1533,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 }
 
 static int uretprobe_dispatcher(struct uprobe_consumer *con,
-				unsigned long func, struct pt_regs *regs)
+				unsigned long func, struct pt_regs *regs,
+				unsigned long *data)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;

