Return-Path: <bpf+bounces-56722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F06A9D20C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C113BBAB8
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A500821C166;
	Fri, 25 Apr 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFgK1mxG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE876219303;
	Fri, 25 Apr 2025 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610198; cv=none; b=IRwVcGJynMeaOMzREWrmAKsMRQDEBt1DrfOJ0bIeLQzEPFd5f9kOPmkTbJV+S0MyMLwtWGtn8X3vJ9a8Nn3xAjTweCZRT3pVzHUMj8K0Y88kFsJHmsCFhdU6I5rnWNaiCg9wOSEMngN2OFJlNA48xOW2xP+gzShGRmCIxK4lqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610198; c=relaxed/simple;
	bh=n4kqhT7GqQL7ewcpNVtoptzgVUov77wzYh2GMvFeFLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e7sK3PYtXV5IuxAY/SNoBz7v1ew54jm48jibTnzTIcxPyPqjZ78G4vQEFRbx9o7KDa5iq102AblVIIE8kin46be2jkBVkXkMB2MRjArtYENC1OrAt38UE41JBuvWl6lZy9zy+pjIS1II5WQA1lpXy3N1z4by/vqQNG88hYOpc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFgK1mxG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso39502865ad.1;
        Fri, 25 Apr 2025 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745610196; x=1746214996; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O72gn9kR1nz94erxUiMK+2B4889QajzPSc5EcH4w7oQ=;
        b=FFgK1mxGO3IxmuD6ENS8eyJUf1hRiYo6Z2854eiG5lcPG2F5BlA7H+r+c3HGGLT61h
         WbJvJcUHxnjSeLPqo28Z4+yipSK63vuyHjtQ69sMCgEw7whWVJAFL+etQ4wsc20KFKyU
         x66bIaYY4S9YhuOovbudfsxMkfgn0o20vym5eSu6/sT7M29p77KvdNqYDc3IysU2NCAY
         rT/7YW5vZd6cSiD7pl4CGZkZVArDztI4EmbHcYXN9J79R4Dw2lp3iwDUNIIjbqHHwIS3
         QStyJ92worhU6jkozzXinc1b3E21FeA1XxZDD/HQP1EYn63+5VRlliktUw9eSzvWrFvv
         3A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745610196; x=1746214996;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O72gn9kR1nz94erxUiMK+2B4889QajzPSc5EcH4w7oQ=;
        b=BsTnIEiRySPPRO3vXPZA+8018K1rq90VYC1t6a0RNGOkL+LzECQW9V2IobithFUvJQ
         MImqPtMOtYc864n6sbblmY6ZOAm9fuDmpsiW7XyrEvesOLuBnPxphRK8gqWsTSdqTkAs
         V8r+IbyAROh3TFxQjSpM/gu9Tu6O9Yckr6fXC2/NK1Awo+UFTTJ8ZCCD+MGB46AKwwt9
         UfmZ2hcsVAwXp/WXW+ILIYz1AgrWBesqj35L7wUkXQdXTZdI/Ail5V0armiMIwyl225t
         8i6AYyTqvxbKZkiY638H4AMGe1cVmK1iZDbFIMTiXF+utujpwLe7ujARd+TIZdlFQqsE
         ucpw==
X-Forwarded-Encrypted: i=1; AJvYcCUBqoJlyjkx9nGer1Wo/kmogNYq14mh1Rh1YKCXNy1WKYwS/QDojx+6qQLCKf67i5HOaaE=@vger.kernel.org, AJvYcCUI1NT77ApQYLw9cBrW+0DuJ4pHakm9CclRaEqhx1Lf17aFDRYBVcp57lD99vD2ZJVg+Iwtf9dqyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2SWfBje4c1DFJbBZlug46BWHfrONflz+i/NZ7YG9lP9x+IsS
	L8RkpaSu2GmOLIYlxNYgVbj1vFoXtLIWuRZoCUoixhGSf+aDsM02vZBHHcyT
X-Gm-Gg: ASbGnctm33Zir2I5GVlij/43yyc5cy9hToEXi99jEbrARotZHAo4IQnK45PzJbnJw/D
	0DH71bnDBBEixyNvuh8w8i7KnNzV1fIiXxbCPbMrEKD/m/15+Bur9kwNM01sc3ct5DCG8gfa4U7
	Ez7+0dHZawnOWTZcF3qM+sOGTOO2JU/JsSiEgSmwlbpQ4A9Yi5ND+QHx0kwK49iRyahmUutiEvR
	NTenigQ9ZCs+KD5re4TpyfhqIyiwfshT9KQTpVT78tekgmc13qTnxpDTNhtfUtW961vdOK6OUKM
	ihfceRzmeKHA1t5bSpqDYgmidBWMVO3q72Ms8MHTSj+1Rq+mCg==
X-Google-Smtp-Source: AGHT+IHpHc9vDl2/wlDzc1r1tDIY6Cg3nbLf1cZp64W7ABpbEeQEXuhbEnsncnRvx4CxA2IbaeMjNg==
X-Received: by 2002:a17:903:1788:b0:224:1935:d9a3 with SMTP id d9443c01a7336-22dbf5ded71mr53976815ad.21.1745610195837;
        Fri, 25 Apr 2025 12:43:15 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::5:5728])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77395sm36502055ad.5.2025.04.25.12.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:43:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,  Arnaldo Carvalho de Melo
 <acme@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Ihor Solodrai
 <ihor.solodrai@linux.dev>,  bpf <bpf@vger.kernel.org>,
  dwarves@vger.kernel.org,  Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: pahole and gcc-14 issues
In-Reply-To: <m2v7qsglbx.fsf@gmail.com> (Eduard Zingerman's message of "Fri,
	25 Apr 2025 11:14:26 -0700")
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
	<m2v7qsglbx.fsf@gmail.com>
Date: Fri, 25 Apr 2025 12:43:13 -0700
Message-ID: <m2h62cgh7y.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
>> Hi All,
>>
>> Looks like pahole fails to deduplicate BTF when kernel and
>> kernel module are built with gcc-14.
>> I see this issue with various kernel .config-s on bpf and
>> bpf-next trees.
>> I tried pahole 1.28 and the latest master. Same issues.
>>
>> BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
>> When built with gcc-13 it has 454 types.
>> So something is confusing dedup logic.
>> Would be great if dedup experts can take a look,
>> since this dedup issue is breaking a lot of selftests/bpf.
>
> It does not look like the problem is with dedup.
> Quick glance at structure definitions does not show any duplications,
> just much more structs compared to clang:

Or maybe it is.
For example, task_struct is added to .ko BTF generated by gcc, but not
clang. This can only happen if dedup fails to merge structures in base
and module btf, right?

Here is an interesting observation:

$ bpftool btf dump file ~/tmp/objs-gcc/bpf_testmod.ko format c | awk '/struct task_struct \{/ {s=1} s {print $0} /^\}/ {s=0}' > ~/tmp/task_struct.ko.c

$ bpftool btf dump file ~/tmp/objs-gcc/vmlinux format c | awk '/struct task_struct \{/ {s=1} s {print $0} /^\}/ {s=0}' > ~/tmp/task_struct.vmlinux.c

$ diff -pruN ~/tmp/task_struct.ko.c ~/tmp/task_struct.vmlinux.c
--- /home/ezingerman/tmp/task_struct.ko.c       2025-04-25 12:37:48.312480603 -0700
+++ /home/ezingerman/tmp/task_struct.vmlinux.c  2025-04-25 12:38:03.096644654 -0700
@@ -18,7 +18,6 @@ struct task_struct {
        int static_prio;
        int normal_prio;
        unsigned int rt_priority;
-       long: 0;
        struct sched_entity se;
        struct sched_rt_entity rt;
        struct sched_dl_entity dl;
@@ -46,7 +45,6 @@ struct task_struct {
        short unsigned int migration_flags;
        int rcu_read_lock_nesting;
        union rcu_special rcu_read_unlock_special;
-       long: 0;
        struct list_head rcu_node_entry;
        struct rcu_node *rcu_blocked_node;
        long unsigned int rcu_tasks_nvcsw;
@@ -55,16 +53,13 @@ struct task_struct {
        int rcu_tasks_idle_cpu;
        struct list_head rcu_tasks_holdout_list;
        int rcu_tasks_exit_cpu;
-       long: 0;
        struct list_head rcu_tasks_exit_list;
        int trc_reader_nesting;
        int trc_ipi_to_cpu;
        union rcu_special trc_reader_special;
-       long: 0;
        struct list_head trc_holdout_list;
        struct list_head trc_blkd_node;
        int trc_blkd_cpu;
-       long: 0;
        struct sched_info sched_info;
        struct list_head tasks;
        struct plist_node pushable_tasks;
@@ -166,7 +161,6 @@ struct task_struct {
        struct mutex_waiter *blocked_on;
        struct mutex *blocker_mutex;
        int non_block_count;
-       long: 0;
        struct irqtrace_events irqtrace;
        unsigned int hardirq_threaded;
        u64 hardirq_chain_key;
@@ -277,7 +271,6 @@ struct task_struct {
        __u64 __mce_reserved: 62;
        struct callback_head mce_kill_me;
        int mce_count;
-       long: 0;
        struct llist_head kretprobe_instances;
        struct llist_head rethooks;
        struct callback_head l1d_flush_kill;

