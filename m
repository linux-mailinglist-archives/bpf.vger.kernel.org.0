Return-Path: <bpf+bounces-52409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FAFA42BEC
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0DA17AFE9
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B70263F59;
	Mon, 24 Feb 2025 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPR75QMw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C6198A38
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422826; cv=none; b=l4QjCo5peB7TSR0vNQf9Izi+Efz7zllrQwUVkgAgY11GSJPyM8cGdJ80IG/FRgJIjSSxxlTyJn/7mZ1e/QSsVDcDxqoH27oT1NwjMkHpr3ZhF9HTpKGEjvyWsS3izpJqvgYDYs/gjyR7wswEY99nnKLswTHB2qIAN38kFs3VfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422826; c=relaxed/simple;
	bh=P8wIH/9ecutcrHu56mM8k9urk+HpnwlChUuGdoA7U4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq0lhPiUNq02Y4B8vDMI7aJw96fW2Og5Gu9cJ+elR51hZ2yNtBvnhdlMrvpOwdjDMJH6sEo2sL/6mL7NT7IgnczxtU1ojUtbGZ0QzrcalcQ3TBTxc1yahoJRVdmj8IaO6kvvvDxhKKWreog0XJPbi71whc6R+fyR9jyNG5CzEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPR75QMw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f22fe889aso4249160f8f.3
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422823; x=1741027623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jjer69476fXdQgjvSYyLKClwSOlF5QTqcGFir0xEKFA=;
        b=MPR75QMwO8wldKLYyaTRlaOah1bVntI3w6+6fne+bYYLJchxgwA0xjFbu1CuzbIsEK
         Y4pyPcL2Z52qhF74HHLWFYAU8Hrfyz8Ci1MIXcyyg1WtUVQ0ZnjlVW19wqp8J4GCF7st
         anuudJaXXcGegMCehKsqkvZz2Fqsy1fFXacJ0XyPjd9GVC/2FVUfSPxpdZSXairECFD+
         e23hQciMHPzBLi4i2OZspXlfhTsYiN9iwbII7lo4DSxsRhkwI8o5+J5QF14fC5pKBxbd
         /kFWsOoGeFbjXSnrQqR7Y4SbZYRddR77K9Jd23OQXOiNBeBspHgV//TF+HZ/l9NfRYkJ
         qgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422823; x=1741027623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jjer69476fXdQgjvSYyLKClwSOlF5QTqcGFir0xEKFA=;
        b=nGJSEGfYRqaSDfcSiz9zik18NjOGG/60yduDEqwzPses1vbeapb6RMz9JBncSDVSM9
         szZtiCtn2wlkL21WrOvB0xjqYvKh5HX52HiYQo1WDF3yHhiTjbtHBoYV89xY+07OlYk7
         v4cXljiLDZDMmQcpM5tjhngzZYxkodGVswwptzlfSVOGpOUY7WAet0AtF/CAm36bWKfF
         96UPk6NBT/DLEWYLC2lRbqKF1Pkz9gNQ1R9TF3Ux6/i/Cvm9xErVZBluN+tD3DIyjgok
         LmFnKtwrM0hSN//Gnx2TxsH8uun5Gh/WvlgsJCAueSHmbhXz+kmH78kc7LKJmIS06A+H
         Bm+A==
X-Forwarded-Encrypted: i=1; AJvYcCX5guJCZn0ulyXapeQXLBAYVcE3W4+VHFznJkLy2QvEUOusFmNRo/rg/GR24EGQrmPGuCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8EBaCXvEh28fKJ/hKsRxA0syFKf3SYJfb+ZXGBp2yaokcU32
	vnaM3w5Q6mGEIK4YWr+Osrjr3smd+sqg+fcHoiAPUNcJnRSs4WFO
X-Gm-Gg: ASbGncvfQltk2WloQlQeVof2W0LRecN36PHeHlduxKOf06jTyBVkzXl7vtEa/GahNu1
	nTCHxQ9f26ylj8nA01WHNk8+WlLBxKLqA7HDmyriMu7Kyr+bpBdGx2UqaT2Znpo78ngE5OfHg0z
	Avh85vSkk6k/QLXfwfvGiXdnnRaeOYozN0gQjO8ZcBSIyaDdexNRGbKloSghsme3aCGZTJ+B/lU
	LT4br1RtTB2EdUmSvCgmdTpg4fd7kYLUwj9bTEd91t26fLyc86A5j50xD91DuvkKX/VBXQkcpIv
	QByL7s/iTxqH5SrxVtg8E1b2CdbXwXQoIrbc7bU=
X-Google-Smtp-Source: AGHT+IGnp79TGzLNiybv1beS4iybyAIWQwYxtQalhUZGS2LAtsCjXk7zs8CElagRTdFr3J3b2Scq6w==
X-Received: by 2002:a05:6000:18ad:b0:38f:32ab:d4f4 with SMTP id ffacd0b85a97d-390cc5f58admr194748f8f.4.1740422822613;
        Mon, 24 Feb 2025 10:47:02 -0800 (PST)
Received: from f (cst-prg-14-58.cust.vodafone.cz. [46.135.14.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205728esm3920766b.144.2025.02.24.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:47:01 -0800 (PST)
Date: Mon, 24 Feb 2025 19:46:52 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, bpf <bpf@vger.kernel.org>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] SLUB allocator, mainly the sheaves caching
 layer
Message-ID: <svy4dxxdgbt4mnapfrqod7c2imufgb4daao7id3j5p7tgeok4j@jtknbmybpqsg>
References: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
 <e2fz26kcbni37rp2rdqvac7mljvrglvtzmkivfpsnibubu3g3t@blz27xo4honn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2fz26kcbni37rp2rdqvac7mljvrglvtzmkivfpsnibubu3g3t@blz27xo4honn>

On Mon, Feb 24, 2025 at 10:02:09AM -0800, Shakeel Butt wrote:
> What about pre-memcg-charged sheaves? We had to disable memcg charging
> of some kernel allocations and I think sheaves can help in reenabling
> it.

It has been several months since last I looked at memcg, so details are
fuzzy and I don't have time to refresh everything.

However, if memory serves right the primary problem was the irq on/off
trip associated with them (sometimes happening twice, second time with
refill_obj_stock()).

I think the real fix(tm) would recognize only some allocations need
interrupt safety -- as in some slabs should not be allowed to be used
outside of the process context. This is somewhat what sheaves is doing,
but can be applied without fronting the current kmem caching mechanism.
This may be a tough sell and even then it plays whackamole with patching
up all consumers.

Suppose it is not an option.

Then there are 2 ways that I considered.

The easiest splits memcg accounting for irq and process level -- similar
to what localtry thing is doing. this would only cost preemption off/on
trip in the common case and a branch on the current state. But suppose
this is a no-go as well.

My primary idea was using hand-rolled sequence counters and local 8-byte
cmpxchg (*without* the lock prefix, also not to be confused with 16-byte
used by the current slub fast path). Should this work, it would be
significantly faster than irq trips. 

The irq thing is there only to facilitate several fields being updated
or memcg itself getting replaced in an atomic manner for process vs
interrupt context.

The observation is that all values which are getting updated are 4
bytes. Then perhaps an additional counter can be added next to each one
so that an 8-byte cmpxchg is going to fail should an irq swoop in and
change stuff from under us.

The percpu state would have a sequence counter associated with the
assigned memcg_stock_pcp. The memcg_stock_pcp object would have the same
value replicated inside for every var which can be updated in the fast
path.

Then the fast path would only succeed if the value read off from per-cpu
did not change vs what's in the stock thing.

Any change to memcg_stock_pcp (e.g., rolling up bytes after passing the
page size threshold) would disable interrupts and modify all these
counters.

There is some more work needed to make sure the stock obj can be safely
swapped out for a new one and not accidentally have a value which lines
up with the prevoius one, I don't remember what I had for that (and yes,
I recognize a 4 byte value will invariably roll over and *in principle*
a conflict will be possible).

This is a rough outline since Vlasta keeps prodding me about it.

That said, maybe someone will have a better idea. The above is up for
grabs if someone wants to do it, I can't commit to looking at it.

