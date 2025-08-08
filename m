Return-Path: <bpf+bounces-65279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A4B1EE73
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 20:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1859B1C24D51
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D621CC63;
	Fri,  8 Aug 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghruLc0N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907D1F4C84;
	Fri,  8 Aug 2025 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754678342; cv=none; b=Rh8oPgGd3EuangGcd1+I2TFEArkypvtq+uMEtmo5rjavVc9P3FuiLyPGKAGgBywWxoeNcNF6vdhCPmzfY3DBnUmW3YTYQ5cV1U/8SLPyiqsCvgomir3bUrhaikSYRlV1eL4qRJU0ToBJb/cB0PiO101mbqipVoc+OeM+PQjXI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754678342; c=relaxed/simple;
	bh=wTcaw0dDssgCkxpjul2gQBoQ/cKBTeFMxCtlAzWgAfQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im/xgt404gQs4t6zgoF/pSc1EtJURw0Pg9PrnyF1X19zl5gLqWn3midRt+QAlRGEc0Uoog3w/dZ/gWfiWkISrH18OsbpwEgQdkNjvhS/4kb0N4M22h9+xkfXzoqk7x04O5ESDVJEcIczQy7HNw5rzZj4Yv0jxUhtmLXYwXZxHEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghruLc0N; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af94e75445dso454790566b.0;
        Fri, 08 Aug 2025 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754678339; x=1755283139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gWwtBN6ebQOcOxsCD+ybzhCBORN9wnDQdVJlpxrz/s=;
        b=ghruLc0N4uuMhjZQZ3iSHrp2Xr79Zysue/DK4it3qA8GyN0JXxB5xgva7FJ1IGxocP
         fbVU+28wOFRnPZ0KHgjHs2QObUAfO1wYJJFhhcP6Onizbarc6532o0H9RwDQnhnGlFyr
         qDmHwaYIt3ZHhQtw4937GfsfGG4Inl9GUc7Mhv0YYjEBfWGcQeSB/CrxQxXLW8HlfgDn
         pd57ilpcHKcgdZ1YxaSabQtgJFs3EwU/zJXWJIlXZVXDbOinC2pDqBF+E3tSq4t8/6N4
         BWqcUi10hSL6oi4ZQEMV6bDyvnFuqvKrgcihlTfBPIICXa/5p22CYsqZrpeLHWumTy36
         ptfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754678339; x=1755283139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gWwtBN6ebQOcOxsCD+ybzhCBORN9wnDQdVJlpxrz/s=;
        b=jW9KeYMeTeMgk8QeY4uH7duhFsPNooaiCHuFWuYryGuH3O++Fu6NqS8to6TiZPsdkH
         SUZYhrhj361v5eIig3T9Ka31lOJmndUCgxFf0p+VbMtb1e03UV3CuyoN0c09L3p+cHPE
         KFJKGrufyeuXrvBvFtbp+41pmh00rsJQpsnfi1u1YRl8OlCuY02lEu6vFDr2vs8EE3cx
         DGxohu4aeI3IYtWoCT8NkQfg0MAHOW3YYbTHBhr0B9kkfElxuKhmamQAQcv2Q7+mw+/+
         vN+IptD0dMjbEVC5rPDB0HcNI72jlF8dGWidrdHP/ax/yjzPnbEzWUfMQQn9DTBHZGzN
         tnzA==
X-Forwarded-Encrypted: i=1; AJvYcCUexm5nWDcIsrwoLT+bLMs3TLVwO5T670wSYCF6R/OqvoPjuv67Hfu3t/xDZZlPU3MIsqE=@vger.kernel.org, AJvYcCUgB02T/X4F/Kqx2KETmo0rsq36b7dNiLifPRhdWU7QbWzK1lBKOgbRgZ/L1xITkkUX9Ek718V5dw5acMsQY/CC2YoX@vger.kernel.org, AJvYcCXaxeH4ukZwDy1mBMy3g9AuI6BIfpBVFeSQSh9c29JYxXVDeNYbdZuTfpg3e1NP8oBuL6jqjeRHPwTuEfQR@vger.kernel.org
X-Gm-Message-State: AOJu0YxS/M747Pkwb9OoJ5fgPihiA6cZcLwK+N5nF5GiBZSrUrdF18cK
	USBLU/MO2fc9Aui2eNBLU5ZZKW+o2noLcc9CDCGATijZn0cAQrBg3Gea
X-Gm-Gg: ASbGncukDdL8mlYp1rDx8NnU1M5qe6clar4CX9o4HeXLft7ylYe5WyRVkRQ/Ek5CU6o
	taLxHo4YxV2NOG5L8qEfsJFMXfU4zIbCoAki7gti0va2WxMTDUAMd0NFU8iC1wbvzaRGgpDFLc1
	Mb7++7Qnvq2kOxeoEADUB4wbLQvCxnxig+pTHeq5dgkgm+5j+1EllBusSyNN/svvEiKRqpGsurx
	GTlYhgFRetAhuirKFPd33hMiQ/kD39XcJo8B80ORupkZfZKcZMiO1nB4MmPSEa/QsSnuXpRBcTJ
	NtnFFX1yCHAtrPt1e6lhrODqtsIqLqMSYvjBYVV7Wgo5UhmD9FpOe1t05pKXmYyddezaRHjD+uT
	CNrvT8yaboAbYjw==
X-Google-Smtp-Source: AGHT+IHm4FM+H2cY+xcahr29t1p51xqTQjA9Z1EzXFR/hkulXj4tdkM3UyPID6AE1hwChDqdy2Ks4Q==
X-Received: by 2002:a17:907:8691:b0:ae1:c79f:2b2e with SMTP id a640c23a62f3a-af9c6540d48mr356899166b.40.1754678339050;
        Fri, 08 Aug 2025 11:38:59 -0700 (PDT)
Received: from krava ([2a00:102a:406f:c1c4:19f6:67fa:c879:8862])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ecfsm1532455666b.94.2025.08.08.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:38:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 8 Aug 2025 20:38:56 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 1/4] uprobe: Do not emulate/sstep original instruction when
 ip is changed
Message-ID: <aJZEQDgIPr9wVUWP@krava>
References: <20250801210238.2207429-1-jolsa@kernel.org>
 <20250801210238.2207429-2-jolsa@kernel.org>
 <20250802103426.GC31711@redhat.com>
 <aJBrXwHESPRTpwYa@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJBrXwHESPRTpwYa@krava>

On Mon, Aug 04, 2025 at 10:12:15AM +0200, Jiri Olsa wrote:
> On Sat, Aug 02, 2025 at 12:34:27PM +0200, Oleg Nesterov wrote:
> > On 08/01, Jiri Olsa wrote:
> > >
> > > If uprobe handler changes instruction pointer we still execute single
> > > step) or emulate the original instruction and increment the (new) ip
> > > with its length.
> > 
> > Yes... but what if we there are multiple consumers? The 1st one changes
> > instruction_pointer, the next is unaware. Or it may change regs->ip too...
> 
> right, and I think that's already bad in current code
> 
> how about we dd flag to the consumer that ensures it's the only consumer
> on the uprobe.. and we would skip original instruction execution for such
> uprobe if its consumer changes the regs->ip.. I'll try to come up with the
> patch

how about something like below?

jirka


---
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 516217c39094..b2c49a2d5468 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -59,6 +59,7 @@ struct uprobe_consumer {
 	struct list_head cons_node;
 
 	__u64 id;	/* set when uprobe_consumer is registered */
+	bool is_unique; /* the only consumer on uprobe */
 };
 
 #ifdef CONFIG_UPROBES
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f774367c8e71..b317f9fbbf5c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1014,14 +1014,32 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	return uprobe;
 }
 
-static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
+static bool consumer_can_add(struct list_head *head, struct uprobe_consumer *uc)
+{
+	/* there's no consumer, free to add one */
+	if (list_empty(head))
+		return true;
+	/* uprobe has consumer(s), can't add unique one */
+	if (uc->is_unique)
+		return false;
+	/* uprobe has consumer(s), we can add one only if it's not unique consumer */
+	return !list_first_entry(head, struct uprobe_consumer, cons_node)->is_unique;
+}
+
+static int consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	static atomic64_t id;
+	int ret = -EBUSY;
 
 	down_write(&uprobe->consumer_rwsem);
+	if (!consumer_can_add(&uprobe->consumers, uc))
+		goto unlock;
 	list_add_rcu(&uc->cons_node, &uprobe->consumers);
 	uc->id = (__u64) atomic64_inc_return(&id);
+	ret = 0;
+unlock:
 	up_write(&uprobe->consumer_rwsem);
+	return ret;
 }
 
 /*
@@ -1410,7 +1428,12 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return uprobe;
 
 	down_write(&uprobe->register_rwsem);
-	consumer_add(uprobe, uc);
+	ret = consumer_add(uprobe, uc);
+	if (ret) {
+		put_uprobe(uprobe);
+		up_write(&uprobe->register_rwsem);
+		return ERR_PTR(ret);
+	}
 	ret = register_for_each_vma(uprobe, uc);
 	up_write(&uprobe->register_rwsem);
 
@@ -2522,7 +2545,7 @@ static bool ignore_ret_handler(int rc)
 	return rc == UPROBE_HANDLER_REMOVE || rc == UPROBE_HANDLER_IGNORE;
 }
 
-static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
+static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs, bool *is_unique)
 {
 	struct uprobe_consumer *uc;
 	bool has_consumers = false, remove = true;
@@ -2536,6 +2559,8 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 		__u64 cookie = 0;
 		int rc = 0;
 
+		*is_unique |= uc->is_unique;
+
 		if (uc->handler) {
 			rc = uc->handler(uc, regs, &cookie);
 			WARN(rc < 0 || rc > 2,
@@ -2685,6 +2710,7 @@ static void handle_swbp(struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
+	bool is_unique = false;
 	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
@@ -2739,7 +2765,10 @@ static void handle_swbp(struct pt_regs *regs)
 	if (arch_uprobe_ignore(&uprobe->arch, regs))
 		goto out;
 
-	handler_chain(uprobe, regs);
+	handler_chain(uprobe, regs, &is_unique);
+
+	if (is_unique && instruction_pointer(regs) != bp_vaddr)
+		goto out;
 
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;

