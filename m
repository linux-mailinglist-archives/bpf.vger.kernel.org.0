Return-Path: <bpf+bounces-31213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652C88D86FB
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 18:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883E91C21896
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDC135A5B;
	Mon,  3 Jun 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pQYfF/Zh"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E79B65C;
	Mon,  3 Jun 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431362; cv=none; b=PwWzpEM+EeUrvqmlUED/ediPtZG3VRY51sAAcokxIVk8muM/CLVE6M05cy2PVpihgXwGOTPlz08AFET0s/CwZlQTVgUpNYhtmN70tkG3+rwCeHr4nt3yoAlcvUH7e8jnKZg7/WAMP/MCmLqAhLQHa80fAvIjJrHrw5DRy2250j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431362; c=relaxed/simple;
	bh=yoFA2I1h2qPvTQAqtAmosaYwIFLXZaG3ciuOVVc4Cso=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ibL081lYzzrv6m17B/KYQz8LSTGDXsM21osZz7vFEYrxENCeJAzuaoojObIe3ifGHu5mWVP1VhkK1KHEg0Ex0zf+cxFgGPhwu17PfYZSxoZAUiAW1ZzhAbLbZHxMSPRRkD3xwkcMAg07MphsqiZp3qpZUdspFkOa6eJzkrC6ELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pQYfF/Zh; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wJxRxb1PevcOA6QDt35NFWNZEovf/in7717kqIxKbWE=; b=pQYfF/Zh1fApWV3eSLfTRkckAG
	Ogla3kSF535OAszg+b6SGI19OhmQ3h1Q6OMjDQ2Psi5UdE2gdEnhm7eTheWPx5lVB0rRynILqcDtK
	gEf3NlkgqEzWXkNIBnVQrhND9tUVmD3QEuBlPgZaUpyGKfZwpKcdjvoxeWoGO83vaRQu5PuNMm+XW
	3xb7r+PO03XfVgYULNUsTN7jSTEvZ/t3JPHqsgAkcDupiAxzrqNoeXGVWHoAlBx89joPZPprGiEAi
	zN1rDa42AbuKp5dzabhb7Yhb2Wi9/IEKjcyXiOHHqX0CtLXVTh3rffucCZrupKanT6aiUg7g/Cpi/
	4y/BYmFw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sEALk-000PYs-FJ; Mon, 03 Jun 2024 18:15:56 +0200
Received: from [178.197.248.29] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sEALk-0008db-17;
	Mon, 03 Jun 2024 18:15:56 +0200
Subject: Re: [Patch bpf] bpf: fix a potential use-after-free in
 bpf_link_free()
To: Jiri Olsa <olsajiri@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Cong Wang <cong.wang@bytedance.com>,
 syzbot+1989ee16d94720836244@syzkaller.appspotmail.com,
 Andrii Nakryiko <andrii@kernel.org>
References: <20240602182703.207276-1-xiyou.wangcong@gmail.com>
 <ZlzI0bhlMP1sAHEI@krava>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ba683305-7e58-b3f0-0bfb-3dec25e05134@iogearbox.net>
Date: Mon, 3 Jun 2024 18:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZlzI0bhlMP1sAHEI@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27295/Mon Jun  3 10:28:26 2024)

On 6/2/24 9:32 PM, Jiri Olsa wrote:
> On Sun, Jun 02, 2024 at 11:27:03AM -0700, Cong Wang wrote:
>> From: Cong Wang <cong.wang@bytedance.com>
>>
>> After commit 1a80dbcb2dba, bpf_link can be freed by
>> link->ops->dealloc_deferred, but the code still tests and uses
>> link->ops->dealloc afterward, which leads to a use-after-free as
>> reported by syzbot. Actually, one of them should be sufficient, so
>> just call one of them instead of both. Also add a WARN_ON() in case
>> of any problematic implementation.
>>
>> Reported-by: syzbot+1989ee16d94720836244@syzkaller.appspotmail.com
>> Fixes: 1a80dbcb2dba ("bpf: support deferring bpf_link dealloc to after RCU grace period")
>> Cc: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>> ---
>>   kernel/bpf/syscall.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 2222c3ff88e7..d8f244069495 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2998,6 +2998,7 @@ static int bpf_obj_get(const union bpf_attr *attr)
>>   void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
>>   		   const struct bpf_link_ops *ops, struct bpf_prog *prog)
>>   {
>> +	WARN_ON(ops->dealloc && ops->dealloc_deferred);
>>   	atomic64_set(&link->refcnt, 1);
>>   	link->type = type;
>>   	link->id = 0;
>> @@ -3074,8 +3075,7 @@ static void bpf_link_free(struct bpf_link *link)
>>   			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
>>   		else
>>   			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
>> -	}
>> -	if (link->ops->dealloc)
>> +	} else if (link->ops->dealloc)
>>   		link->ops->dealloc(link);
> 
> nice catch

+1, thanks Cong !

> Acked-by: Jiri Olsa <jolsa@kernel.org>

I think it would also be slightly nicer to just fetch the ops once, which
wouldn't have caused the issue if it was done back then in the first place.
Do you mind if I squash this in and then apply it to bpf tree? Looks as
follows :

 From 220fb40d88c7b5d1f3234a5f1b807f6067450832 Mon Sep 17 00:00:00 2001
Message-Id: <220fb40d88c7b5d1f3234a5f1b807f6067450832.1717431085.git.daniel@iogearbox.net>
From: Cong Wang <cong.wang@bytedance.com>
Date: Sun, 2 Jun 2024 11:27:03 -0700
Subject: [PATCH bpf] bpf: Fix a potential use-after-free in bpf_link_free()

After commit 1a80dbcb2dba, bpf_link can be freed by
link->ops->dealloc_deferred, but the code still tests and uses
link->ops->dealloc afterward, which leads to a use-after-free as
reported by syzbot. Actually, one of them should be sufficient, so
just call one of them instead of both. Also add a WARN_ON() in case
of any problematic implementation.

Fixes: 1a80dbcb2dba ("bpf: support deferring bpf_link dealloc to after RCU grace period")
Reported-by: syzbot+1989ee16d94720836244@syzkaller.appspotmail.com
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20240602182703.207276-1-xiyou.wangcong@gmail.com
---
  kernel/bpf/syscall.c | 11 ++++++-----
  1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5070fa20d05c..869265852d51 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2998,6 +2998,7 @@ static int bpf_obj_get(const union bpf_attr *attr)
  void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
  		   const struct bpf_link_ops *ops, struct bpf_prog *prog)
  {
+	WARN_ON(ops->dealloc && ops->dealloc_deferred);
  	atomic64_set(&link->refcnt, 1);
  	link->type = type;
  	link->id = 0;
@@ -3056,16 +3057,17 @@ static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
  /* bpf_link_free is guaranteed to be called from process context */
  static void bpf_link_free(struct bpf_link *link)
  {
+	const struct bpf_link_ops *ops = link->ops;
  	bool sleepable = false;

  	bpf_link_free_id(link->id);
  	if (link->prog) {
  		sleepable = link->prog->sleepable;
  		/* detach BPF program, clean up used resources */
-		link->ops->release(link);
+		ops->release(link);
  		bpf_prog_put(link->prog);
  	}
-	if (link->ops->dealloc_deferred) {
+	if (ops->dealloc_deferred) {
  		/* schedule BPF link deallocation; if underlying BPF program
  		 * is sleepable, we need to first wait for RCU tasks trace
  		 * sync, then go through "classic" RCU grace period
@@ -3074,9 +3076,8 @@ static void bpf_link_free(struct bpf_link *link)
  			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
  		else
  			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
-	}
-	if (link->ops->dealloc)
-		link->ops->dealloc(link);
+	} else if (ops->dealloc)
+		ops->dealloc(link);
  }

  static void bpf_link_put_deferred(struct work_struct *work)
-- 
2.21.0


