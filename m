Return-Path: <bpf+bounces-47045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E843C9F354E
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD681611A9
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59A14E2C0;
	Mon, 16 Dec 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLFZ7JWA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5114884F;
	Mon, 16 Dec 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365193; cv=none; b=IK80gSY+SDsSkfKRW7j05EXuveol9wQZrllSPlyAWisq1OPuNoCgN6ukBWIKo/fbmSvL0HK1qo4STy/rdEh9UPLTwMThJnQspirGu93xp9w/0XpLodxoHp3ix4MRobDekeVgW86g5Q+GkQIFoYx6FqvwZD1n+QaH2nUqtXvfXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365193; c=relaxed/simple;
	bh=7xDkbihr5c/iY8HU5JFp67ilRK4KZaw3vmuWZjUI1q8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi6Nr7U8vAsNoPEep/Cwt5vcwU6GezYsb1bi8RQG3qB9sYeGgaUmmWC9NJYd6xiV6unMMPqUPnWmlaDYQcemfiDN3huro66fwm+PGIIUbnb339a/dE7Pjb9/rXmMjbdQBtqMv4hKIu8IyxaBBU/Sxw3AmC3EsBm0gJ4L1++M4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLFZ7JWA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso19222755e9.0;
        Mon, 16 Dec 2024 08:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734365190; x=1734969990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGqyisqmMAu4dOam1OVi9m1FcFaUXOIPgO9eWA/wASA=;
        b=eLFZ7JWA2oVmuFZ9TD8PSJdqJsRzfhUHMde+/0npf7nUcYI5lsge1ymloWKCO8FjPj
         LpsSyvX2k8EJYpZbtUuJ7qJ5QVl+u9RnCDDTSZPj/rOUadNl7XzgRN3H9ZOwZIh9iKuV
         ywlWN3KeGLdD08XAw8Ox0LZddga0cec3KCLuru0fImQa0Ca1jWheGAjVg9irhvMO4GL9
         CAwgXiSvTf+Hl7HPM1kSYGOFgaPcTrx9Tr0mYk1HJ5fDVrC5Pn0smVSzuV79wEOBPj4e
         rZbxngixkWJxFJ6T2FYqAapBxUAsRgqknZ9CEpr1XfAbdsvcUnIzJKeb8y75GPyOhAXn
         3AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734365190; x=1734969990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGqyisqmMAu4dOam1OVi9m1FcFaUXOIPgO9eWA/wASA=;
        b=DTMo0uy47fF6TJwlSm/pISlbpkp7maq2mat6gNepnUiHg7+aVtyMME3gnEGDt+tQXY
         Jz4Zl8xmqhA3FcTnaragOPW9QGKx5CO9KQyHo3JZDhFm9l4G8ZDfXvGFuEC0/VmQIiAO
         b9oRl/ALf5L8CgXl/J7TpROflUoeN271H2QRt2hKCrcwowH0Eqfa+Y2+TE1e77sVhU2g
         x3Rwj20ZS26mDh8HMz7raqcd+pwJzrkvS3yX7h23NtlmmtiEgUkxGS7RZEycaTXkv0y3
         6JoPCb2BOgNY3p5PaLx0OPKu5rMLpDOzccVyncs5Vz+Si7ulv4Cfs9O0POiloEUXoBXP
         S1NA==
X-Forwarded-Encrypted: i=1; AJvYcCWJM3a9UfODZrco7o308EXZlnL5bMUwXZIbU+6m6L3WQVJigqGFvMIgxr5qsZ/lmzynuhiaVwD7la1pyM1u@vger.kernel.org, AJvYcCWm2hSh4zQq18KkosXaWjhHJf8ZfmdZgXMxi8d/9twYoXk2jbBvH901dYOs5X2JsG7A/RYtw6HbzP5vaw05Sw5BbpLa@vger.kernel.org, AJvYcCXRIh9RcInJxSWVy3+ms7lzq5GwpDT8NCDkI5i0P1EwCUmmLmLZH40rZRxn1/VSE2AeOHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlPMgnPDPyEQxKBxXiOqiyPBLHBWftCMYpxFw3Ci8kMxWLMMk
	zkC9xNyBYIKnLtn2Z9kpf52NqrvBzxekcTWcqMhWEQms/CcfKka3
X-Gm-Gg: ASbGncsOSwo16Iqw2RbdgWyN8WsnF43F1gZ9HkalWSV6HKennZqDCJMSTMCIqOsJObd
	6xvQDQm1VWT5XcsMaEV8eUXwnDGyxRXQs59NcA4NowhDkCVCk7ZsRqUWIOYMJpTllw2wwbJOcGL
	ArVfeLiS2WHBDfuPKwFKE2008oxqGASg+erBl1aochNDvfWCGGoTgsxZD8AtEolwZG0hVlxXUh8
	uNJsqDUMRyd+l2IkyI0kUxmCHvMeGJoU9GhL2ssPU8=
X-Google-Smtp-Source: AGHT+IGFFSp98N/h0XGnnlSck95VjUoxFw5f4Id94RYv6cdOomxczF6C3VYA5YCOsO31uxZWHS4Dqw==
X-Received: by 2002:a05:600c:1da7:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-4362aa9dd6dmr115042585e9.21.1734365189882;
        Mon, 16 Dec 2024 08:06:29 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706cd3sm146868265e9.28.2024.12.16.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:06:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 17:06:27 +0100
To: David Laight <David.Laight@aculab.com>
Cc: 'Jiri Olsa' <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Message-ID: <Z2BQA0tVRXJRMHnl@krava>
References: <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
 <20241215141412.GA13580@redhat.com>
 <Z1_gFymfO3sAwhiY@krava>
 <c5fb22629d3f42798def5b63ce834801@AcuMS.aculab.com>
 <20241216101258.GA374@redhat.com>
 <0916e24539ba4bae9fb729198b033bd7@AcuMS.aculab.com>
 <20241216122204.GB374@redhat.com>
 <Z2AiFdDsrSjZ_-3-@krava>
 <e206df95d98d4cbab77824cf7a32a80f@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e206df95d98d4cbab77824cf7a32a80f@AcuMS.aculab.com>

On Mon, Dec 16, 2024 at 03:08:14PM +0000, David Laight wrote:
> From: Jiri Olsa
> > Sent: 16 December 2024 12:50
> > 
> > On Mon, Dec 16, 2024 at 01:22:05PM +0100, Oleg Nesterov wrote:
> > > OK, thanks, I am starting to share your concerns...
> > >
> > > Oleg.
> > >
> > > On 12/16, David Laight wrote:
> > > >
> > > > From: Oleg Nesterov
> > > > > Sent: 16 December 2024 10:13
> > > > >
> > > > > David,
> > > > >
> > > > > let me say first that my understanding of this magic is very limited,
> > > > > please correct me.
> > > >
> > > > I only (half) understand what the 'magic' has to accomplish and
> > > > some of the pitfalls.
> > > >
> > > > I've copied linux-mm - someone there might know more.
> > > >
> > > > > On 12/16, David Laight wrote:
> > > > > >
> > > > > > It all depends on how hard __replace_page() tries to be atomic.
> > > > > > The page has to change from one backed by the executable to a private
> > > > > > one backed by swap - otherwise you can't write to it.
> > > > >
> > > > > This is what uprobe_write_opcode() does,
> > > >
> > > > And will be enough for single byte changes - they'll be picked up
> > > > at some point after the change.
> > > >
> > > > > > But the problems arise when the instruction prefetch unit has read
> > > > > > part of the 5-byte instruction (it might even only read half a cache
> > > > > > line at a time).
> > > > > > I'm not sure how long the pipeline can sit in that state - but I
> > > > > > can do a memory read of a PCIe address that takes ~3000 clocks.
> > > > > > (And a misaligned AVX-512 read is probably eight 8-byte transfers.)
> > > > > >
> > > > > > So I think you need to force an interrupt while the PTE is invalid.
> > > > > > And that need to be simultaneous on all cpu running that process.
> > > > >
> > > > > __replace_page() does ptep_get_and_clear(old_pte) + flush_tlb_page().
> > > > >
> > > > > That's not enough?
> > > >
> > > > I doubt it. As I understand it.
> > > > The hardware page tables will be shared by all the threads of a process.
> > > > So unless you hard synchronise all the cpu (and flush the TLB) while the
> > > > PTE is being changed there is always the possibility of a cpu picking up
> > > > the new PTE before the IPI that (I presume) flush_tlb_page() generates
> > > > is processed.
> > > > If that happens when the instruction you are patching is part-read into
> > > > the instruction decode buffer then you'll execute a mismatch of the two
> > > > instructions.
> > 
> > if 5 byte update would be a problem, I guess we could workaround that through
> > partial updates using int3 like we do in text_poke_bp_batch?
> > 
> >   - changing nop5 instruction to 'call xxx'
> >   - write int3 to first byte of nop5 instruction
> >   - have poke_int3_handler to emulate nop5 if int3 is triggered
> >   - write rest of the call instruction to nop5 last 4 bytes
> >   - overwrite first byte of nop5 with call opcode
> 
> That might work provided there are IPI (to flush the decode pipeline)
> after the write of the 'int3' and one before the write of the 'call'.
> You'll need to ensure the I-cache gets invalidated as well.

ok, seems to be done by text_poke_sync

> 
> And if the sequence crosses a page boundary....

that was already limitation for the current change

jirka

