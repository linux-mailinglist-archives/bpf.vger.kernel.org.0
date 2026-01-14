Return-Path: <bpf+bounces-78873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FC3D1E693
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5336230BE13C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA5139526E;
	Wed, 14 Jan 2026 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFF35kug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76E393DFE
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390106; cv=none; b=sfN6LBXNsvJwfzITqe96eOi4Xb6Sm2Tc4jETUnBm9GZyIAcQx3tEnLFJvPNfsJ09R/epjRw2MmHd4sqnLHiHkY4oYUhI4jEmSNMnGVr7K/llv6yvVuMDSU31yd6R4S3CKNUlW4vzWjn7vqMsP7Pk8kErfkxQ83JVxP+oQldyWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390106; c=relaxed/simple;
	bh=0fGVhftsc+nGHo+Lm9VKmninWdcz1+QWpalR0QeBDSM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfyZ4wgYVXQZTpjgndk7CA8sm2rlUW5SITGJyBiKqWbt+6xF/dAueizsReO4hTQWrLfgw1vxgJhuqLO0LfSj9xAOfXkNC4FpaGxvW/c/pNVIW3s3jKZb2/6APQzxc93CLY81Yp+qJqXvVol8DR03xvT8rYgENr0BJW1H6/wJpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFF35kug; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso51624025e9.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768390098; x=1768994898; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGVDUUpgpDLMWHZgDOLEkAjObayE3q3JK8jeYcF9PIs=;
        b=XFF35kugUQxnCboeg0kWoGprR6/B0CUuUgWyN8gQOF7GT65jnzwWCBjfvibxdL0vVv
         3G87ZVe+M4ar9sHRztusxXCeQ0nZYK5gPrZkMRAz4RuvWegTaypQCDv9xjee2jYLiOpv
         i0fDhs3/U1sRAD93DiW4r6iB+l0Q3hl1JSJg373CEF2alY5mDV5kVdaoW+njviEX83A3
         je3WIF59O7CzephDfNYav3Wz+XivtdBYXWTgbUSSRSbNcCVKC+rgDVrIf+DeEkC0P5za
         V0q6OMd52b4WKl6+Ub1if/pp58kAiE6lsNI3H6+q6tGzP3M8M5FhN6glRVkqqFSVglYv
         In6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390098; x=1768994898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGVDUUpgpDLMWHZgDOLEkAjObayE3q3JK8jeYcF9PIs=;
        b=Rd/0HnSFzO7Dj/p3jyqfmaq0iFz9MwZ6C6HWNDw7RVkc4+Bhdfsng5MExFXINIdAeR
         T/CTO15JvCdVbqWd570koNyiT/lzUklPPPvmRz64i/D75upqYn6qoH7w8Nraie8kNFrY
         otzEi/krsNFU0yf/MGRONfw3cHr5ybchJTsRa1eT4rKmQ6I7bHwjeJ6Q1YQ6Fv5BYbN9
         QoUdGjJuGtqkH8vVG/XvFscAQulrXIAzSNt7jHK9EYJ7vbKOE2NV4WdVl2LeNRqLqxGN
         swfxISFZCu29LekXGeyMGPh2oFSuK2vfMyZeh2CWSehnPmu7+S2+VCyRr81KQb8UJ+3f
         e2ag==
X-Forwarded-Encrypted: i=1; AJvYcCUIjLaXumnTNS1nA9owsTftuHNMa0po6wJpHXA6YADFC8BOFeEaJwv2zs5zMM5B7BJxAaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOxtrA0JgwkN+JedxKzrbh3IhLg24AMagrxtUDCTYFtxuO36z
	AekgSOnwUaV80rAfZPEzaKAjr8TQuMk9oOBnvjk8eNCudIyV1UjccvPh
X-Gm-Gg: AY/fxX4ea2HmSMdDO4Xebtu8iM8X7oxeb8Wy+ywuldZ6q/ZOMHW3N0s6qrz6LIyi/Mo
	3+lkWIDrjr35+7DCidBUX2P6KHa6fUgiKmhbxsw9hw65Elg+n9WooPOD3f7Y/s1o4ePknJb4af3
	RO/Tk8UtfVFlqpxS1QTybuErz/pjXrjSYWrxdAcn7aqP/2eAdNCqfOgHJcYVLeKoTb3DLSEXjq4
	H1kr8USM4DIo1o+5MIYkytIZpHIqPLzwMzClypKMaruUAPpDH+1QS5a23pMsg0P8mD6j1WkmYvx
	5LjT6bdlGJNUgK1b6AA8izJ1sD5NIQXkW5VJv5t73aweyBarLxwcrol4o3bOlPMRj7tDteoElfM
	Aen+7cWql+Ga8DLmZA4uCu1bgelwxKfxOz1yTyPPjo9PlM9dsOhdUZTAp3Tqxdowsj+TL/5kNKy
	c=
X-Received: by 2002:a05:600c:4f0b:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-47ee4819824mr18444405e9.18.1768390097518;
        Wed, 14 Jan 2026 03:28:17 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee54b90d5sm23620545e9.2.2026.01.14.03.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:28:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Jan 2026 12:28:15 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and
 bpf_func access at runtime
Message-ID: <aWd9z8GVYO12YsaH@krava>
References: <20260102150032.53106-1-leon.hwang@linux.dev>
 <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>

On Fri, Jan 02, 2026 at 04:10:01PM -0800, Alexei Starovoitov wrote:
> On Fri, Jan 2, 2026 at 7:01 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > This patch series optimizes BPF tail calls on x86_64 and arm64 by
> > eliminating runtime memory accesses for max_entries and 'prog->bpf_func'
> > when the prog array map is known at verification time.
> >
> > Currently, every tail call requires:
> >   1. Loading max_entries from the prog array map
> >   2. Dereferencing 'prog->bpf_func' to get the target address
> >
> > This series introduces a mechanism to precompute and cache the tail call
> > target addresses (bpf_func + prologue_offset) in the prog array itself:
> >   array->ptrs[max_entries + index] = prog->bpf_func + prologue_offset
> >
> > When a program is added to or removed from the prog array, the cached
> > target is atomically updated via xchg().
> >
> > The verifier now encodes additional information in the tail call
> > instruction's imm field:
> >   - bits 0-7:   map index in used_maps[]
> >   - bits 8-15:  dynamic array flag (1 if map pointer is poisoned)
> >   - bits 16-31: poke table index + 1 for direct tail calls
> >
> > For static tail calls (map known at verification time):
> >   - max_entries is embedded as an immediate in the comparison instruction
> >   - The cached target from array->ptrs[max_entries + index] is used
> >     directly, avoiding the 'prog->bpf_func' dereference
> >
> > For dynamic tail calls (map pointer poisoned):
> >   - Fall back to runtime lookup of max_entries and prog->bpf_func
> >
> > This reduces cache misses and improves tail call performance for the
> > common case where the prog array is statically known.
> 
> Sorry, I don't like this. tail_calls are complex enough and
> I'd rather let them be as-is and deprecate their usage altogether
> instead of trying to optimize them in certain conditions.
> We have indirect jumps now. The next step is indirect calls.
> When it lands there will be no need to use tail_calls.
> Consider tail_calls to be legacy. No reason to improve them.

hi,
I'd like to make tail calls available in sleepable programs. I still
need to check if there's technical reason we don't have that, but seeing
this answer I wonder you'd be against that anyway ?

fyi I briefly discussed that with Andrii indicating that it might not
be worth the effort at this stage.

thanks,
jirka

