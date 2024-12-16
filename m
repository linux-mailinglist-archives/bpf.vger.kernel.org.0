Return-Path: <bpf+bounces-47038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB989F30E3
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 13:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69701885650
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 12:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E50204F88;
	Mon, 16 Dec 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSU8lSYA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F3C204C3A;
	Mon, 16 Dec 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353435; cv=none; b=bZo1Vxa2rowrDQzxTCel1etmR7rQFq0sdMNSJVxKR8/ZvfA7dist2SlSVv51d0MANSLVC+Qps+kajgbaHl+VcXJnbWL9kNmmJ49iLE24jS9ey5FUO6jAYvu6EPDXA/SzsmZyGfyQ525ZKN0osmkTzGM5yMdhbDNlKXNBgHkEhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353435; c=relaxed/simple;
	bh=wcKNy17lTGJLydZrs7KJkl1zb7eLmvlD6ct9qXIC/jo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPElGE23eXrvpty5yg1yOypqP+PLTzEjIy86RwWmsoZVYZbkYwru5CEXH8ccGytgxRRlOxSd6zJBG7/kpHQhW5f20Kbx5PyZay5se+QFTtV0nDnNm2iYwI6ao4G5v1mU014woTiKGbsOKZZs/DbcTXm4zzqU8Egwg0dPJJQi6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSU8lSYA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862df95f92so2018430f8f.2;
        Mon, 16 Dec 2024 04:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734353432; x=1734958232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYTu620PtRa9BvXXAMLUJ30SROoCXOvfv0ERCSXsRn4=;
        b=TSU8lSYA/IVQmNzh1a/KtI8fjTpnck29uuPgNMrOh37oUcnAA2SGormDKBItTCfneA
         Rw/pXlRu6BIn855pCO2P+e9ZxOn8iDti5ifxZp5wQWNvACDMWWNjwvazT193dCvHhfn7
         V0mGkf/4NTCQyj6Akj9CauRt/XA5VuuhSeEi+LysqZFHbwg+dLmnh4Rh85HnDabrKWBm
         jrKxO3hbaUspRN9iZgvi6G0jbp3zVnVGx9wTVTqKXS1qu3YO3o4MGpEzAruCLKWOyFi8
         RBvx06pVjprJ9oXiCxUYakEFaET0Grq3FJ/wBkKSBHPOp8hljr1I/1NyFL1bwTXzfSOX
         D7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734353432; x=1734958232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYTu620PtRa9BvXXAMLUJ30SROoCXOvfv0ERCSXsRn4=;
        b=Vg/sLly0iTEb0vDx9G/7TrcCcUQtZJu7Em8c44Jj2BUQ8pPJvvwEjfTOGdWxB/IaCn
         I7k8WXIEd7ldGMjlslWb3Sb//r7hVjdvm3dzsKfxMmfZ3SiEO6QT+n4lbxYVqWMBgFtJ
         zlu3DiLZY95JcX1ICOZNiKexF8D/5v1YldW3QIac/qHYujBJofo5g0hKN0172yJQJxpc
         wuXeEbTT1sxlrDN4XUN8UIzI5jIje+MRSH/KBfmSvhrVrQqHxls/NvnXMlPOq6c+d+Zy
         OKsfv93oaT1RxvRBbocqO7ZrzCLMOxe7YRxet6BQfMGUoJgEubBReI/GbagN29fEY1XM
         iqmA==
X-Forwarded-Encrypted: i=1; AJvYcCVoiZSSuYsof7SkiozTHjc+JwXXVLor30w4n7Kg82G+w76CzS+leVNF7kmPOYnu0YaZOPM=@vger.kernel.org, AJvYcCXTtpd3DG8cby7Ai7dHckdiZrTmHX5VzmbbU+LPPNAOl8wM0d/htTtSJ6aTXuYDNQGkG7AObycCLmvaKKIc/vOGVJhi@vger.kernel.org, AJvYcCXZZDnNCbgdc8mKgGbUc68EleP/mWyzmfYztC5xCJ+PpvVi6Z6Di9qcAVxqPYXx/mRQHGrvufcsSjC6aBV8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4brokCWFHrqOhkmCV7RsngCGZ5QkmMXG/ThvrYUfliB9QpXKx
	nKIrqifwGwbz5C+/o6n8Rh4ygbTyTWBYDmdhzAE5cZABDczhJetq
X-Gm-Gg: ASbGncuoilstzCKhvjMh+wjqBKA0PDyqynJ1M6UkFFtMafuDMFwFxmNaE4KlgDeD0wu
	B+Q4Wn2DVj2sL5WWLSnCiVD6ocstouI42hg28aIzcerh6TQ7wgc9wzcLnrbf2iZWSOK+kdbV4kb
	wPQnaN+7KYnuvRBuqsgYp2foWJ+DQGlSbLhFdQKE32GZyonSHm1fSOU2m2v+Glxa/BcJWD0QG27
	5nqbTdoxz6+gj75qmDKq8HCE3aBI/2KRCvqjZvwrJwxtKzJBuNZcdTq2LqAQiZsrpljUa6BRy+7
	8cRU/s4wEPeVODxzMIDnn8Cwqm8rGg==
X-Google-Smtp-Source: AGHT+IF5dpqJH0p9aEAMRZspfaq9uP28+SF1CA67w0e4bAkAr12nBBB6F2bhj6gzq/tBsTk7BKwXhQ==
X-Received: by 2002:a5d:5984:0:b0:385:fc32:1ec6 with SMTP id ffacd0b85a97d-3888e0c081bmr9033638f8f.50.1734353431975;
        Mon, 16 Dec 2024 04:50:31 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706588sm142177595e9.29.2024.12.16.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:50:31 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 13:50:29 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Laight <David.Laight@aculab.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	'Jiri Olsa' <olsajiri@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <Z2AiFdDsrSjZ_-3-@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
 <20241215141412.GA13580@redhat.com>
 <Z1_gFymfO3sAwhiY@krava>
 <c5fb22629d3f42798def5b63ce834801@AcuMS.aculab.com>
 <20241216101258.GA374@redhat.com>
 <0916e24539ba4bae9fb729198b033bd7@AcuMS.aculab.com>
 <20241216122204.GB374@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216122204.GB374@redhat.com>

On Mon, Dec 16, 2024 at 01:22:05PM +0100, Oleg Nesterov wrote:
> OK, thanks, I am starting to share your concerns...
> 
> Oleg.
> 
> On 12/16, David Laight wrote:
> >
> > From: Oleg Nesterov
> > > Sent: 16 December 2024 10:13
> > >
> > > David,
> > >
> > > let me say first that my understanding of this magic is very limited,
> > > please correct me.
> >
> > I only (half) understand what the 'magic' has to accomplish and
> > some of the pitfalls.
> >
> > I've copied linux-mm - someone there might know more.
> >
> > > On 12/16, David Laight wrote:
> > > >
> > > > It all depends on how hard __replace_page() tries to be atomic.
> > > > The page has to change from one backed by the executable to a private
> > > > one backed by swap - otherwise you can't write to it.
> > >
> > > This is what uprobe_write_opcode() does,
> >
> > And will be enough for single byte changes - they'll be picked up
> > at some point after the change.
> >
> > > > But the problems arise when the instruction prefetch unit has read
> > > > part of the 5-byte instruction (it might even only read half a cache
> > > > line at a time).
> > > > I'm not sure how long the pipeline can sit in that state - but I
> > > > can do a memory read of a PCIe address that takes ~3000 clocks.
> > > > (And a misaligned AVX-512 read is probably eight 8-byte transfers.)
> > > >
> > > > So I think you need to force an interrupt while the PTE is invalid.
> > > > And that need to be simultaneous on all cpu running that process.
> > >
> > > __replace_page() does ptep_get_and_clear(old_pte) + flush_tlb_page().
> > >
> > > That's not enough?
> >
> > I doubt it. As I understand it.
> > The hardware page tables will be shared by all the threads of a process.
> > So unless you hard synchronise all the cpu (and flush the TLB) while the
> > PTE is being changed there is always the possibility of a cpu picking up
> > the new PTE before the IPI that (I presume) flush_tlb_page() generates
> > is processed.
> > If that happens when the instruction you are patching is part-read into
> > the instruction decode buffer then you'll execute a mismatch of the two
> > instructions.

if 5 byte update would be a problem, I guess we could workaround that through
partial updates using int3 like we do in text_poke_bp_batch?

  - changing nop5 instruction to 'call xxx'
  - write int3 to first byte of nop5 instruction
  - have poke_int3_handler to emulate nop5 if int3 is triggered
  - write rest of the call instruction to nop5 last 4 bytes
  - overwrite first byte of nop5 with call opcode

similar update from 'call xxx' -> 'nop5'

thanks,
jirka

> >
> > I can't remember the outcome of discussions about live-patching kernel
> > code - and I'm sure that was aligned 32bit writes.
> >
> > >
> > > > Stopping the process using ptrace would do it.
> > >
> > > Not an option :/
> >
> > Thought you'd say that.
> >
> > 	David
> >
> > >
> > > Oleg.
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> >
> 

