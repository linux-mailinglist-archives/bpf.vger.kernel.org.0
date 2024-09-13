Return-Path: <bpf+bounces-39820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF503977E82
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD3A28330A
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826A1D86E9;
	Fri, 13 Sep 2024 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmKo88L6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7B17BB3A;
	Fri, 13 Sep 2024 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227267; cv=none; b=kYjw2LQf29HZLPgfgAU8Xe1EkwHq8dI8dh7KO88KjMLyC7xPUSkqv/r38nnIR4dyncPmRjOUnbvHMjMBVASwK/6VLYusrxvKAL6i/mSkhUo/ioGKWa93KaD4P0kU0rdI/CyrmB+rOzgogmvTCfQCkSd0hF9lKR06KMgM61dys1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227267; c=relaxed/simple;
	bh=qjBBJv5v2gm3wY2djZDvadSm/8czuYeffT2c/+nK2c4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwOf/CRqCd79HLcbVxTb2CcUedqPScS2n3aQEjxFQ+pMDgDUKh4LZvLAIi8UTAH/14yrrJmmonl1FLQEJMnGMa8rRPy0vscSIPGGTGvqxL9mVEhin37endOZJr0eD4BM8l1A5PbCm/ZL0DdasDG1os6rIAj6f5sVOFh1FtUQ61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmKo88L6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb2191107so16611245e9.1;
        Fri, 13 Sep 2024 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726227265; x=1726832065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eg0XbsF3NEOr5LqRDFRid3OG+/E/RMVh1PeNbC0zwLk=;
        b=YmKo88L602Bi/ws9eKI3pfmwgqZ/w+tSTNwp98MMzEF0bz64t/QttxMr7IGyY5Yl+L
         3sK8JMih11lW69+23m3J66dlbTZ+2egJlGKZUZatuI7MWAtdIITx6Kqmhx1LruIWV0HH
         P+Xb8DmKb4g4N6ayf3De5mmnFX8DfnVnE0nwFZcQhPE/CBLEa1MMBk+JXtWCDwXd69Aq
         tSiEUaFu86PD9alrtVFRFz2XD23xcBKR5DDOQjJmUngJLBqKu5OT92H86GNyyYxVMj2k
         SUJ1Nlwchxh6nNL+Nt5tEj6ojgK6xtUnNszNmuPVxNiToa6cpzKCgk4ayFkIk7F/iYLI
         Oqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726227265; x=1726832065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg0XbsF3NEOr5LqRDFRid3OG+/E/RMVh1PeNbC0zwLk=;
        b=eKecUL6J7u/RfQwtOk3DQdTp9y/uU/KdTmfHAXUjndW7aUFFZeCLpMk/haDDuswCcM
         VU0dqERh91YXEZrQj8ciuKvltP0YxTfRYEHQKRwqJF1Xgf8B8/6bXC63MrILGDkJS0Lf
         EaC8j6lMYS9LvoUl3Pe57QnO5movzJJxOQHNcnrqbYxqvnQ/4zaJ2ivHEffaKtyT0vKN
         Xw1JdwbCMZPFXCqxmZ9j3w24gw7zS+pOSVI6E535QYg8Z3mvqVla0gGevCNj3WkIBnjA
         MIJ7RL6oTVCnQ9Y8lxFNB+SXlVrwcPY5CTw6ri8VLdYuTJLMS0PdHAgyZcwNYZqwuEQB
         l4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUMkiUNwWuxiNoR11L76BCX2rOS+gSmFg+6R9rrWBMaWrraOQggMTwKzH6hVbVMxsJ+QFs=@vger.kernel.org, AJvYcCW5vAZ+jK6LLHGSP0FUXSyuvHoXhDuDZQLgbN45wjZz3gQCQ+VD90cVmZjRXawuCsDdRl7HPCg4iX1MsAjL@vger.kernel.org, AJvYcCXV9BPmQ7J3qCSPH4PA/DYLReibTgjJ87KEzoiAKqFSTKQ9CvkuxJXG+0RTIwAuQTfyk5OvCddTSCZazEal03CYHT6r@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5tdWS7u+l+mNMAA5LEYU43wIEW1q8QweuNZGHaeo1y7H9xSR
	SeHN8GqLzFvuKCZhZAFsPzO69Ay5TnRMIHZpai22tmcUuNywibgc
X-Google-Smtp-Source: AGHT+IGEy86tRJ0MiRSM/IdLkvXvq50We4HiAMZY3ZZ5iidHhX94298z9Qdn4x3+hUAT6TWqpqIVkg==
X-Received: by 2002:a05:600c:198b:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-42cdb5684damr48394795e9.26.1726227264352;
        Fri, 13 Sep 2024 04:34:24 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3840sm16711981f8f.89.2024.09.13.04.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:34:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Sep 2024 13:34:20 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <ZuQjPCdLkKnPQsu0@krava>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240912162028.GD27648@redhat.com>
 <ZuP2YFruQDXTRi25@krava>
 <20240913105750.GC19305@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913105750.GC19305@redhat.com>

On Fri, Sep 13, 2024 at 12:57:51PM +0200, Oleg Nesterov wrote:
> On 09/13, Jiri Olsa wrote:
> >
> > I'm not sure the realloc will help, I feel like we need to allocate return
> > consumer for each called handler separately to be safe
> 
> How about something like the (pseudo) code below? Note that this way
> we do not need uprobe->consumers_cnt. Note also that krealloc() should
> be unlikely and it checks ksize() before it does another allocation.
> 
> Oleg.
> 
> static size_t ri_size(int consumers_cnt)
> {
> 	return sizeof(struct return_instance) +
> 		      sizeof(struct return_consumer) * consumers_cnt;
> }
> 
> #define DEF_CNT	4	// arbitrary value
> 
> static struct return_instance *alloc_return_instance(void)
> {
> 	struct return_instance *ri;
> 
> 	ri = kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
> 	if (!ri)
> 		return ZERO_SIZE_PTR;
> 
> 	ri->consumers_cnt = DEF_CNT;
> 	return ri;
> }
> 
> static struct return_instance *push_id_cookie(struct return_instance *ri, int idx,
> 						__u64 id, __u64 cookie)
> {
> 	if (unlikely(ri == ZERO_SIZE_PTR))
> 		return ri;
> 
> 	if (unlikely(idx >= ri->consumers_cnt)) {
> 		ri->consumers_cnt += DEF_CNT;
> 		ri = krealloc(ri, ri_size(ri->consumers_cnt), GFP_KERNEL);
> 		if (!ri) {
> 			kfree(ri);
> 			return ZERO_SIZE_PTR;
> 		}
> 	}
> 
> 	ri->consumers[idx].id = id;
> 	ri->consumers[idx].cookie = cookie;
> 	return ri;
> }
> 
> static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> {
> 	...
> 	struct return_instance *ri = NULL;
> 	int push_idx = 0;
> 
> 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
> 		__u64 cookie = 0;
> 		int rc = 0;
> 
> 		if (uc->handler)
> 			rc = uc->handler(uc, regs, &cookie);
> 
> 		remove &= rc;
> 		has_consumers = true;
> 
> 		if (!uc->ret_handler || rc == UPROBE_HANDLER_REMOVE || rc == 2)
> 			continue;
> 
> 		if (!ri)
> 			ri = alloc_return_instance();
> 
> 		// or, better if (rc = UPROBE_HANDLER_I_WANT_MY_COOKIE)
> 		if (uc->handler))
> 			ri = push_id_cookie(ri, push_idx++, uc->id, cookie);
> 	}
> 
> 	if (!ZERO_OR_NULL_PTR(ri)) {

should we rather bail out right after we fail to allocate ri above?

> 		ri->consumers_cnt = push_idx;
> 		prepare_uretprobe(uprobe, regs, ri);
> 	}
> 
> 	...
> }
> 

nice, I like that, will try to to plug it with the rest

thanks,
jirka

