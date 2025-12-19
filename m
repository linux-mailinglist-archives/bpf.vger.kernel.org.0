Return-Path: <bpf+bounces-77142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8777CCCF23A
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 10:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 460513080683
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E6271470;
	Fri, 19 Dec 2025 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a46tb6SV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB832BEFFF
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136480; cv=none; b=mRTLzL/6QPlPXUGbcjtAkFFGWoI0yrhOpQmVx85IUL2hkYDzucaeD0yWTPPfcBaDie9F7+bQT+zK0XDSSXWLq0vfoCGRG6tIuQ8Tlf/K8RlGuVOMlh1Moouc2vVet91PZCKTrP51nzCAomxYcFvCKC+tTVDRpz/MSY1K37BveWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136480; c=relaxed/simple;
	bh=AWCb9Zlk3X/yQ+3/BM0yomxMF6ZXBp57Sea52ZPFdrk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/khNLVgPTdL4cqqKGfqo7f/CObc7T58jc1XFr8Tk2jb/LqO9Lq+3MNgAry+OsxWn31RdfvIqel0FE/F991A8g021VouaLk5j7wWmDqK8oGe4nn+fzs8RtJgbjwVnrfnniq1Ttw6O3UQtQZLLn6QxIdB+9Krqci4/qo2xXNu9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a46tb6SV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so15620255e9.2
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766136467; x=1766741267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmnXlxHoWq0NbG8Ccw5YQt/6uSNtB/ujN6Gu6zmgr7g=;
        b=a46tb6SVG4+Va3N/aQFdClrZMP12l4SGTA8d/Kk4HrWnXkBJZP0a65WHnIIBFKWr71
         QeB+wOzChmzWs0/CpRhFQ/15KUt4aNs0QSim+4E8q3tqTv2uQ11+/i+k3AKuj8KciiPZ
         LvC7Di5FP2pTLALZqTrSFN9oWIAb4nDhqwtiOnAANEJPlL0Y8scD/d7i3zR13zsEL+ll
         91sdx+twkF4Fu2i86jLLHlgl5Hz0a//y65xfoTNNWrdn3Vau4mpug8R5zB7Gt1tYuQxj
         ArYY27NaxfBNqu0RBkiT/xDHohiuBfA6M3Xr5HJMoktbCmGzorBMHMOJALF7zq45uTA6
         H9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136467; x=1766741267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmnXlxHoWq0NbG8Ccw5YQt/6uSNtB/ujN6Gu6zmgr7g=;
        b=wgJlTdqSmGpnUqpxBGUflrBt1YOt3iyLBVXy+cCwc4XKs+g05YW4WJZwI8bojg7k+o
         KbRwoDaJoIJLdLcAuc4cE+porhcH8DIybB5I2tfbE7VKCVhg/QSEDs67MHKTpqY1bJpJ
         WxbnpdIQnQrjnyJ6oWrIYo/ig2lhq94NSxuM1fPGd04jlIBXMbqkW2h1BLRaEc+nWa13
         ScmUH0x0G1XHnCglSetioUiPYaaP+dC9pEYJbhfJdK5hN7NU73eh+S/ns8wIcpXGNpSe
         nXY77xvlCANXIS+UWTnnkUG6LSZAnUDaYk+/i3vZNOUB8fbJhDZNz/xbcZxtxxAMm9A7
         X5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX1I931yXNgFEmpr/xtBnTl/a2uLzYguZVEHGYE8LhAYDy5JsCZUyYGPg+Qs8s92HXelog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtl3k2QTc1oi9DVa6iYCQO8VabQ0RAM7gYBKtEK2NlsoJLwUm/
	BVuRLykodcsjeg9gP9MU9XJZVnjQ9f++Moe0tP/5Ks8yg3s/Au2jSTwa
X-Gm-Gg: AY/fxX7VJ32Rt0oajrElI8q/MCi3uMX3ed0fJ/5vuOIvRfo7hPgZ4sR0z0LVI2Yk1oq
	9TIur4nIip9GLh1DnV+5L39inIoIy5Ak52BOGLoByZamBmtMwOFKITdREP1qvJ2nYbjh/fhMEmj
	7U+anA8FuHkMzcdir3HDaUiRCVWJcynC0yI/dfuOqz1ZeHYwgKMHQB/cbfzptZ8MoRnitl/bsYO
	1gT8bVLC0TnHxsi7UNzLS6aWtneOzGFxRnP4wZgRn1EiFdY3SFSoqJrANhuYQef1zuKJC2HjXhB
	lVr2rOMXsUSRpf6AtXxzuuLmAInTN4eDQryRbgClCJVZGQYymYB9JMTqwiRQJdNOfuFic4gQu6G
	3h9UfBWgrDI+bnwjG9k2sr/BJamxEuW9t19rULEwF7LsXUkY2vEb1KWhhi+Rv
X-Google-Smtp-Source: AGHT+IEyiXP2r+UagAVyzsxyVSYES1j9aAQG6eYvB7U3MJyHwiFSEqfhleLuOyMaRGuuYSwfofjO1g==
X-Received: by 2002:a05:600c:4e90:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47d1959440dmr18983345e9.34.1766136467150;
        Fri, 19 Dec 2025 01:27:47 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm90595515e9.12.2025.12.19.01.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:27:46 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Dec 2025 10:27:45 +0100
To: Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 5/9] ftrace: Add update_ftrace_direct_del
 function
Message-ID: <aUUakb_Bv1sDfJUR@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-6-jolsa@kernel.org>
 <20251217204814.38756224@robin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217204814.38756224@robin>

On Wed, Dec 17, 2025 at 08:48:14PM -0500, Steven Rostedt wrote:
> On Mon, 15 Dec 2025 22:13:58 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> > +/**
> > + * hash_sub - substracts @b from @a and returns the result
> > + * @a: struct ftrace_hash object
> > + * @b: struct ftrace_hash object
> > + *
> > + * Returns struct ftrace_hash object on success, NULL on error.
> > + */
> > +static struct ftrace_hash *hash_sub(struct ftrace_hash *a, struct ftrace_hash *b)
> > +{
> > +	struct ftrace_func_entry *entry, *del;
> > +	struct ftrace_hash *sub;
> > +	int size, i;
> > +
> > +	sub = alloc_and_copy_ftrace_hash(a->size_bits, a);
> > +	if (!sub)
> > +		goto error;
> 
> Again, this can be just return NULL;

ok

> 
> > +
> > +	size = 1 << b->size_bits;
> > +	for (i = 0; i < size; i++) {
> 
> You can make this for (int i = 0; ...) too.

ok

> 
> > +		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
> > +			del = __ftrace_lookup_ip(sub, entry->ip);
> > +			if (WARN_ON_ONCE(!del))
> > +				goto error;
> 
> And you can remove the error label here too:

ok

> 
> 			if (WARN_ON_ONCE(!del)) {
> 				free_ftrace_hash(sub);
> 				return NULL;
> 			}
> 
> 
> > +			remove_hash_entry(sub, del);
> > +			kfree(del);
> > +		}
> > +	}
> > +	return sub;
> > +
> > + error:
> > +	free_ftrace_hash(sub);
> > +	return NULL;
> > +}
> > +
> > +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> > +	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions;
> > +	struct ftrace_hash *old_filter_hash, *new_filter_hash = NULL;
> > +	struct ftrace_func_entry *del, *entry;
> 
> One variable per line.

ok

> 
> > +	unsigned long size, i;
> > +	int err = -EINVAL;
> > +
> > +	if (!hash_count(hash))
> > +		return -EINVAL;
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> > +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > +		return -EINVAL;
> > +	if (direct_functions == EMPTY_HASH)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&direct_mutex);
> > +
> > +	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> > +
> > +	if (!hash_count(old_filter_hash))
> > +		goto out_unlock;
> > +
> > +	/* Make sure requested entries are already registered. */
> > +	size = 1 << hash->size_bits;
> > +	for (i = 0; i < size; i++) {
> 
> 	for (int i = 0; ...) 

ack

thanks,
jirka

