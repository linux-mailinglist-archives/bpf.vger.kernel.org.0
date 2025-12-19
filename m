Return-Path: <bpf+bounces-77140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2350ACCF228
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 10:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DDCE304B724
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06A32EF65C;
	Fri, 19 Dec 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvB2haNo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675022A1D4
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136464; cv=none; b=svzNx/pl32tMicjj5ZfYYmXW1GK0Y/75mlz4PO3I2f/rYjnkddlEfTenwXHKwyYqKTnc8Sx1nA2hKRy+aWUl2PRHxqOcTR30KJCOUr05mjxRcOmU2y9X+bTeg0QQEm7djMK/AvpSSl+oG5R0U1uEsaYC/brTRNVNk8HqCnMzjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136464; c=relaxed/simple;
	bh=/Uh5/0uVYB5Mde+NWjpZ+Op18cNz2TMpFHw4AqCywEE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZp5v6VsJwsHYiVXYr20s/YckqZIuRZX7MEeaOvLCT6BYR3PliIDWg7lMPAVccZvJoFUSZy6fXsSxuG+resDFHYCVMhYeCgLBWK+m9/GQlIpCQYreVzH0x3FTLFjjRzwD5tcvuRv4YsS6fjxnFTsvGgZnAMVXcBEya9ncJjuGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvB2haNo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso10696295e9.1
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766136461; x=1766741261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4nPSaxdkYRmJvc/bAjl6gt7fyBjx03ifV8lSbnPKMU=;
        b=lvB2haNoJ6rJGO5tuJZsnHm7qG6ftihuwZq2NmKG84UNPt4FW92aMHVTkG263IUmql
         bUxkoG30RRQiID7ANr4jdJdSQPn0qCM6KaABBuw3szVaWlptDEta0nDbcG/yGcLNjyl3
         8qBsxxgI/73dmFmoULoCffOmD2t+FoxSHUpbQOXbZtszoe/ow6AiyGuVBeI2wiqq4Rdl
         4LBuQACsQQW3T/OPeWMwbnnbYJBdQoWIh8A3bFhNx1kdIULjkox2AJlZx+H/JYw5XGKy
         fMR/6ukPVlpRA+cFWtBJUfRFUUKLOC2QNP2ve+FRmlk9vRRfpxWQCQmGuJz0d8NDaTbk
         6bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136461; x=1766741261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4nPSaxdkYRmJvc/bAjl6gt7fyBjx03ifV8lSbnPKMU=;
        b=rAdhsO7PIzODHyNUs0HXtr4zODFoBKRJ+CEjQ6ISiLFDEtNEtdCRlHArMKiRJtFDKQ
         CqkH0EFvo09q86HF+J25TuuGG/tl8CSYyLeZKCkVUL0IEplUmpPBlXxqT8n+SxtlFDyK
         tjJ3xSqfakLFkQIRT518p9Z2i9dRfHyqpb3pw/nLpJrbdyix/Q8Bgy12aNJqkDCf1/Wv
         GI87VlmVChlnUVNeDcZgwO1oUmMUCYktCJFkMCjJQ4kBD1E+oL9KJvrtlxfsahBqm3el
         Gf4UZ7NZoednNjW/fri38bbKrjEfMVGoeTZdv0WHlLvb/OftyEqzVEY3O+HWInHPorgA
         6TQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqW5O5/RAjWA8nkQ086julVquLs8HiWxfVtOJL/wtHkJhO0Z2i/yGog0bVHG1dY0YIHbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqX8SwaHTDV440AR7A+mfbpD9WCUcsv6oEgvVk1r5m0rSiAwPY
	5bHHfuxoyEeWfNT1gp2wELPmzN2K/F2DIku6bp7SPk5OOKc4yUdWFl8E
X-Gm-Gg: AY/fxX6+ML22zrqCIQcRBBLj9P4Zq5e+lzM76PO5DFP0zdpF4oIU1vsURwHmxskOxuu
	MsA0s6koH4Nf+aL0yKUTpedqN1CFyOQfaDG2r7XUfTsUvVxJF4INAj44XdXPhEXVTS8ykV4BQKv
	MiyXMs1EBkAl/GyyNG/8iZ7WQMaX3NbbABOU2pwYHK67onCWBZ4rskV6iVbFJCOxuCXroB8WR4i
	5i/XK+Cln3xJLQcCNQbzfaJGmCaQNJVPnwRG/9Rma/0A6TBgKCq7Bik4ymiY6fKiVlpCfOdRe8P
	4X+5xwO2J+cdaSF9Ql2V6JQc9Nw/XapHw+7ROfws4eB5UqRfcomaFZzNRveABiMJS2/n6NxpiGf
	xF5QOowWYu/XILnr5XZm0mBiyyMck0+2kJxXTXApNe/ePn3R6dZ2vrtZ+Cen2
X-Google-Smtp-Source: AGHT+IFlqi3iHxkGvauVr0NGTT2g6Itjhn/GDO0PNuIXTX1fYZewz4dI/OFWH3DrEPm2JlrPjHWWLw==
X-Received: by 2002:a05:600c:820d:b0:477:7c7d:d9b7 with SMTP id 5b1f17b1804b1-47d1958e475mr18862055e9.33.1766136460836;
        Fri, 19 Dec 2025 01:27:40 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm88493555e9.7.2025.12.19.01.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:27:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Dec 2025 10:27:38 +0100
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
Subject: Re: [PATCHv5 bpf-next 4/9] ftrace: Add update_ftrace_direct_add
 function
Message-ID: <aUUaiqP4kjGwlUMG@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-5-jolsa@kernel.org>
 <20251217203909.474ae959@robin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217203909.474ae959@robin>

On Wed, Dec 17, 2025 at 08:39:09PM -0500, Steven Rostedt wrote:
> On Mon, 15 Dec 2025 22:13:57 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> 
> > +/**
> > + * hash_add - adds two struct ftrace_hash and returns the result
> > + * @a: struct ftrace_hash object
> > + * @b: struct ftrace_hash object
> > + *
> > + * Returns struct ftrace_hash object on success, NULL on error.
> > + */
> > +static struct ftrace_hash *hash_add(struct ftrace_hash *a, struct ftrace_hash *b)
> > +{
> > +	struct ftrace_func_entry *entry;
> > +	struct ftrace_hash *add;
> > +	int size, i;
> > +
> > +	size = hash_count(a) + hash_count(b);
> > +	if (size > 32)
> > +		size = 32;
> > +
> > +	add = alloc_and_copy_ftrace_hash(fls(size), a);
> > +	if (!add)
> > +		goto error;
> 
> You can just return NULL here, as add is NULL.

ok

> 
> > +
> > +	size = 1 << b->size_bits;
> > +	for (i = 0; i < size; i++) {
> > +		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
> > +			if (add_hash_entry_direct(add, entry->ip, entry->direct) == NULL)
> > +				goto error;
> 
> Could remove the error and have:
> 
> 			if (add_hash_entry_direct(add, entry->ip, entry->direct) == NULL) {
> 				free_ftrace_hash(add);
> 				return NULL;
> 			}

ok

> 
> 
> > +		}
> > +	}
> > +	return add;
> > +
> > + error:
> > +	free_ftrace_hash(add);
> > +	return NULL;
> > +}
> > +
> 
> Non static functions require a kerneldoc header.

ah right, will add

> 
> > +int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> > +	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions;
> > +	struct ftrace_hash *old_filter_hash, *new_filter_hash = NULL;
> 
> BTW, I prefer to not double up on variables. That is to have each on
> their own lines. Makes it easier to read for me.
> 
> > +	struct ftrace_func_entry *entry;
> > +	int i, size, err = -EINVAL;
> 
> Even here.

ok, will split

> 
> > +	bool reg;
> > +
> > +	if (!hash_count(hash))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&direct_mutex);
> > +
> > +	/* Make sure requested entries are not already registered. */
> > +	size = 1 << hash->size_bits;
> > +	for (i = 0; i < size; i++) {
> 
> If you want, you can remove the i declaration and use for(int i = 0; ... here.

ok

SNIP

> > +	}
> > +
> > +	if (err) {
> > +		/* reset direct_functions and free the new one */
> > +		rcu_assign_pointer(direct_functions, old_direct_functions);
> > +		old_direct_functions = new_direct_functions;
> > +	}
> > +
> > + out_unlock:
> > +	mutex_unlock(&direct_mutex);
> > +
> > +	if (old_direct_functions && old_direct_functions != EMPTY_HASH)
> > +		call_rcu_tasks(&old_direct_functions->rcu, register_ftrace_direct_cb);
> > +	if (new_filter_hash)
> 
> free_ftrace_hash() checks for NULL, so you don't need the above if statement.

ok

thanks,
jirka

