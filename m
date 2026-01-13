Return-Path: <bpf+bounces-78696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A9D1899C
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD2E33002891
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 11:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC17538E5DF;
	Tue, 13 Jan 2026 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1SPQIWS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7A38E121
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305513; cv=none; b=FEiHB9eBQ96WWxDqGdnrDhNR3ZXUlpne/VRzlWMzoxLV4Fm8qrLKNXczmo1UaX4dSQJbTBX+Cu7FCY/F6W6fUdsFGJhZ42Ojzr+ix2lLmTKor+yR2jD1NAIB2vbk+0jcDMj03Jq+WuwQ9xD834AQTNw8xWyeJpGUNjqfejv5kE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305513; c=relaxed/simple;
	bh=pPh4+HAZOzKHytLYGjFQqq/F7FgALn9JcQIVEqzGSJs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyr4R4Ci7jxkc1og29k1G/WbzVNiKBkGGa88fqsj5j2bSmfS9oKJh+R57WmXZsNolzmSsCNVvms+aPnsVmMYoQbvykUqJzTT8+9PAuNtY1g9DgQovGIReusw196EoftU8DJGPzukWoctdwak+xy/ImkGNH5R0b0JjcMVX3jxJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1SPQIWS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432755545fcso4389993f8f.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 03:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768305510; x=1768910310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2SGd3tXmtLkKwF012MQCllNNXd7BPnjgwOvsuNzDErw=;
        b=B1SPQIWStJcLCrNYC1t/16rjgbxToMBDJsewVl6wrF2vz7A9ZEIfFM8tb8OX0qotQU
         PQmMk4aaXts+E3rGweynk6SZxkbPjwSQvpLpqmliK/rl8+t3pGQl0mR/Aeo+2Derdf5E
         qZcgavPjJy2PeZbERIaPR+4iV4VnDfpWN4DOOfYn9LSSm/FUgYDfTv1FekXME335Adh5
         x4Oq1tN5DyC7nQFr2GRDXxHxVTUESMFQ+Id1b58V/QNieHotiTCC50ndnyqwR8nWxcDx
         iTv0oP1sTKv40bwukheQhLgz9aiTBetVbye/oP2jrhgOMqcGRr4zt7cshPz9qnUI8XSb
         KAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768305510; x=1768910310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SGd3tXmtLkKwF012MQCllNNXd7BPnjgwOvsuNzDErw=;
        b=BfgbQVQ/hICmIKOmXHtLErxoteuKf+eWqDQa70nLdPJ7UKXmNeJTVbCj4G7VxRE/N6
         ps5aERb4YMYKtor9o6NczE/J5wbWORXM73tvR/AblwLmTY5UcRfVqT460oh4Z470ecBw
         Bgt6iHsplXT+TTYFVlZUYFv9s1wDKK5F76vaTZZPjnu5CY0mlVb2nc2XzTTDquIDtkkl
         1vgBPXDxGbtkMrY7Ack8+7qJJAVbx7vt8aXJBkL0vvsi3FeM2d1OtpwTF0m/lsA1os6n
         Rmlro49oP9Io1RSLjgtM9A28VRRDwY4jE5STmF9f61wjC6u4alg54Re7aipyN7VvH9io
         8RxA==
X-Forwarded-Encrypted: i=1; AJvYcCVMaeZZrQ4K6C6/amV7OQIZ3TMg7Qv6G17lLIYWuC/eiCar6H3m5LUX+Yybn4XyKM7JZoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80WRDPFUrhLT8fXKUwWqfu6sR+9ORAHFC2HrgMP94q2OwopZ7
	vyyItQqPuQv+rVsYNyC/h8k4mQbdKLURKEUtem5jPJBao+0X8KrofAwj
X-Gm-Gg: AY/fxX4eShOBahzMQ1ZTtgv4o7VsA3mFYnIKJ2TteXkbtB6xgu4K/9sBF3Try6uj4n2
	s/OYniQiTUKmtjpffMM1KN064VlXtNEPR1JAnnQh0JAtM08uWDnpmNaKSMTfAXO6XAj5+gZb+a4
	ADyoPbOBLYFTALzVrJzhjZtPxXtULscVFICc4c+RYaI7Sxnz7SY9hGetlINMSe8anesvuYmX7yX
	7joQUcpArF6Xb3GwLWmsii3GJ0ThANXpjYvH+xnLb93LU8YQsjlhfHDTYRHsvbdSVBr96eB9Hoc
	OhiIolieKvERj30NR2sGDk8fIrJ9SXkbMLsLxfj/B3I1yp2+DnnQ7/50FDHsxNKZ4skJDhXLOyB
	Dh43QvP4fgx04a6YT7TjaWr+B0uXUM8c3LhaLauN1Ul9s3uRses7Z93Yq5stT
X-Google-Smtp-Source: AGHT+IGkvUuVDJVo/hzAbWsKzxOrW1kEblMrgxzCuB8BjwrLokZwyC+CIexQPCRUge4jrjh3WK73TA==
X-Received: by 2002:a5d:64e6:0:b0:432:851d:3676 with SMTP id ffacd0b85a97d-432c3774267mr27499901f8f.57.1768305509864;
        Tue, 13 Jan 2026 03:58:29 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9afsm46383138f8f.24.2026.01.13.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 03:58:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 13 Jan 2026 12:58:28 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv6 bpf-next 7/9] bpf: Add trampoline ip hash table
Message-ID: <aWYzZBBkIJCyuwbH@krava>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <20251230145010.103439-8-jolsa@kernel.org>
 <CAEf4BzYgqWXoKTffa5Y6Xm-nPbL9aFgrStR0GfUs4-88f10EgQ@mail.gmail.com>
 <aWVnVzeqWJBXwBze@krava>
 <98436a72-236a-43c4-b6ac-9d74b53b0223@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98436a72-236a-43c4-b6ac-9d74b53b0223@oracle.com>

On Tue, Jan 13, 2026 at 11:02:33AM +0000, Alan Maguire wrote:
> On 12/01/2026 21:27, Jiri Olsa wrote:
> > On Fri, Jan 09, 2026 at 04:36:41PM -0800, Andrii Nakryiko wrote:
> >> On Tue, Dec 30, 2025 at 6:51 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >>>
> >>> Following changes need to lookup trampoline based on its ip address,
> >>> adding hash table for that.
> >>>
> >>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >>> ---
> >>>  include/linux/bpf.h     |  7 +++++--
> >>>  kernel/bpf/trampoline.c | 30 +++++++++++++++++++-----------
> >>>  2 files changed, 24 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>> index 4e7d72dfbcd4..c85677aae865 100644
> >>> --- a/include/linux/bpf.h
> >>> +++ b/include/linux/bpf.h
> >>> @@ -1325,14 +1325,17 @@ struct bpf_tramp_image {
> >>>  };
> >>>
> >>>  struct bpf_trampoline {
> >>> -       /* hlist for trampoline_table */
> >>> -       struct hlist_node hlist;
> >>> +       /* hlist for trampoline_key_table */
> >>> +       struct hlist_node hlist_key;
> >>> +       /* hlist for trampoline_ip_table */
> >>> +       struct hlist_node hlist_ip;
> >>>         struct ftrace_ops *fops;
> >>>         /* serializes access to fields of this trampoline */
> >>>         struct mutex mutex;
> >>>         refcount_t refcnt;
> >>>         u32 flags;
> >>>         u64 key;
> >>> +       unsigned long ip;
> >>>         struct {
> >>>                 struct btf_func_model model;
> >>>                 void *addr;
> >>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> >>> index 789ff4e1f40b..bdac9d673776 100644
> >>> --- a/kernel/bpf/trampoline.c
> >>> +++ b/kernel/bpf/trampoline.c
> >>> @@ -24,9 +24,10 @@ const struct bpf_prog_ops bpf_extension_prog_ops = {
> >>>  #define TRAMPOLINE_HASH_BITS 10
> >>>  #define TRAMPOLINE_TABLE_SIZE (1 << TRAMPOLINE_HASH_BITS)
> >>>
> >>> -static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
> >>> +static struct hlist_head trampoline_key_table[TRAMPOLINE_TABLE_SIZE];
> >>> +static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
> >>>
> >>> -/* serializes access to trampoline_table */
> >>> +/* serializes access to trampoline tables */
> >>>  static DEFINE_MUTEX(trampoline_mutex);
> >>>
> >>>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >>> @@ -135,15 +136,15 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
> >>>                            PAGE_SIZE, true, ksym->name);
> >>>  }
> >>>
> >>> -static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
> >>> +static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
> >>>  {
> >>>         struct bpf_trampoline *tr;
> >>>         struct hlist_head *head;
> >>>         int i;
> >>>
> >>>         mutex_lock(&trampoline_mutex);
> >>> -       head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
> >>> -       hlist_for_each_entry(tr, head, hlist) {
> >>> +       head = &trampoline_key_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
> >>> +       hlist_for_each_entry(tr, head, hlist_key) {
> >>>                 if (tr->key == key) {
> >>>                         refcount_inc(&tr->refcnt);
> >>>                         goto out;
> >>> @@ -164,8 +165,12 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
> >>>  #endif
> >>>
> >>>         tr->key = key;
> >>> -       INIT_HLIST_NODE(&tr->hlist);
> >>> -       hlist_add_head(&tr->hlist, head);
> >>> +       tr->ip = ftrace_location(ip);
> >>> +       INIT_HLIST_NODE(&tr->hlist_key);
> >>> +       INIT_HLIST_NODE(&tr->hlist_ip);
> >>> +       hlist_add_head(&tr->hlist_key, head);
> >>> +       head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
> >>
> >> For key lookups we check that there is no existing trampoline for the
> >> given key. Can it happen that we have two trampolines at the same IP
> >> but using two different keys?
> > 
> > so multiple keys (different static functions with same name) resolving to
> > the same ip happened in past and we should now be able to catch those in
> > pahole, right? CC-ing Alan ;-)
> >
> 
> We could catch this I think, but today we don't. We have support to avoid 
> encoding BTF where a function name has multiple instances (ambiguous address).
> Here you're concerned with mapping from ip to function name, where multiple 
> names share the same ip, right?

so trampolines work only on top of BTF func record, so the 'key' represents
BTF_KIND_FUNC record.. and as such it can resolve to just single ip, because
pahole filters out functions with ambiguous instances IIUC

> 
> A quick scan of System.map suggests there's a ~150 of these,
> excluding __pfx_ entries:
> 
> $ awk 'NR > 1 && ($2 == "T" || $2 == "t") && $1 == prev_field { print;} { prev_field = $1}' System.map|egrep -v __pfx|wc -l
> 155

right, but these are just regular kernel symbols with aliases and other
shared stuff

jirka

