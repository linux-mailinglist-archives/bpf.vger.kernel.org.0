Return-Path: <bpf+bounces-57261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6088FAA794A
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EB71BA1087
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295151D63D3;
	Fri,  2 May 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9EYs+9H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C9376
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210819; cv=none; b=iIzMRmetbXAc0KhWd1JyCec4MkY/48/O0I75POHKc+7Gg4Wfnuovo7ycolsxd0ZK8MIrs4mbbqoNaX9hRhjc17xHiAyb8EpB5m9h5jXuIO6a+tPTSVTThfv2EZ7ARVWdS8XIRBCenYGVHtElpaP63F9sdMBTK6fzNPogZ31q8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210819; c=relaxed/simple;
	bh=xyM8CQozs8nj8XquxrsfRrkj4nT7HfioAGkRj55pPmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJXi37q43xmwjQacPRYP4TLZOrOaegMm9s2Fol8d4chnfVunG8mAOue0J5iA2SJ4JBxB2SaZY0z1GwVBxiZNfTmczLZXZAFQ2f6R0UGzKSYZwzG7TWgNzkrJvwa0cAdy2Vm8DasyjqXRUlbVa9OEDSaFtL9DwfKwQvbMAri/ZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9EYs+9H; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394a823036so22332775e9.0
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746210816; x=1746815616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyM8CQozs8nj8XquxrsfRrkj4nT7HfioAGkRj55pPmk=;
        b=h9EYs+9H+hlrVp+YVU9w/OhgCbBbFzNRZejmykJkP7MDllMyxnVtd3Ihdhl5LJ9VF2
         p6RJu373Mekr9HGvBlWIufxzeRTs4HJZDr4z/AzjvLeJf4Te360FsosrHFnL/7WQ5nyj
         TwYJ/mf3H9SPPfA9RwOInDahSEOPtMgYgjYSXYAvJwntoI3yXGH2MHWDfR0VQi7hDJLc
         o2nTyx8oJINJ/rGWnKTFJownb9Wa72ek4/IACFP7TOimjSk3rlo7wT7DiRsg2RA/PDFs
         Gn2P/BYT5onJumSlEP8CsJYSWWOdOxDy79rep7ybI/7gXB/oyUQsJMfuW8CLBZglzJkD
         AWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746210816; x=1746815616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyM8CQozs8nj8XquxrsfRrkj4nT7HfioAGkRj55pPmk=;
        b=kzsXNI0iO516SMdPJCmEGu6NSeKzFQfRyyMg5FwPbYfHoaF27nHpjsMU2TRb9TcDmD
         OoWUe3uJQWDKQmxyIk2XEocPBqzJEfp53MaIsUdvOrcToj+/7k1kwVpWyeix4+lCWEU4
         +6vaNSPLU9Upucj7iuCT6vXMOZmdBQEC94qnACtZyDxWM/ZBT0a5NtXS/PTQwUKACm3w
         eY/1CMxEryd0YDIB4yjBA1fIUZ5ALpbGNQGsAgIdg3aqGIkGl/u2UtT2PLzcmC6C73pz
         RPutRoi9vqzzQL+r9oyhNG8Km8HMdgdMtCA6Y5Cwgr7ZAwiqewDpnpHmV0bQLKqoqhB4
         Fbug==
X-Gm-Message-State: AOJu0YwumPez41fk8pNXk2erfLa/Ah27uz5qclK4zIraKPwGFO5wYBk4
	FMSIgBUansE9SEPUI7ZksB21Sd9a7vEzO+fjWCNtDJKbfx/boLM7bHVkA9/qBwHFgRji9iJtllD
	W+BuiQ27TEMshLIxXbH8XOOXpWCs=
X-Gm-Gg: ASbGncu9+QGArxRBrcmRe8l66hnAZ2Z8F6a2vD//0VLKBUeNyHYTOvV2uZClpcan+SY
	0E8+T+V+XJxaLejSCJFLUtnKUO0lhcJlNOu3xcXgXl2WgZzSYYYlFDwYuAJ7ZlB36P9cSTDfXi1
	LdwJgMnLcYfTHvdWhJaupSXe6fb4dwvbzkiD59Pw==
X-Google-Smtp-Source: AGHT+IH6uwxaWpb7d5jiphQg9nVi9tOvfaokSAw0/eiLPTUS73cmOA30Ax77K+59gI4wF4zq8K43SUpTt5T+hNpDGQk=
X-Received: by 2002:a05:600c:1c16:b0:440:6852:5b31 with SMTP id
 5b1f17b1804b1-441c1ce8c8emr347185e9.10.1746210815917; Fri, 02 May 2025
 11:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR11MB652381F4B833B4B5CE2AEABAA9832@PH7PR11MB6523.namprd11.prod.outlook.com>
 <CAADnVQJ0aRud=VeQ7dWhFqEqVQQCozKqtP9mHwuHOj5ua+5J4A@mail.gmail.com> <b40406d4b9a3bcc826d68a35af05112fb3bef8c9.camel@intel.com>
In-Reply-To: <b40406d4b9a3bcc826d68a35af05112fb3bef8c9.camel@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 11:33:24 -0700
X-Gm-Features: ATxdqUEmxqFRoSr2d4zvkdrlokkzPzl9tb_tBFTzq_QTNi2buXXDLs4FWikZtVA
Message-ID: <CAADnVQ+YsR=dH4VksVxBeKyVSXDp-Ce8qa9Z6u_79sigCpcLHQ@mail.gmail.com>
Subject: Re: Looking for feedback on kfuncs for dentry_path_raw, get_dentry_from_kiocb
To: "Preble, Adam C" <adam.c.preble@intel.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 7:09=E2=80=AFPM Preble, Adam C <adam.c.preble@intel.=
com> wrote:
>
> On Wed, 2025-04-30 at 16:00 -0700, Alexei Starovoitov wrote:
> > > +// The dentry argument needs to be ignored because the verifier
> > > can't verify
> > > +// the integrity of the pointer coming in from kprobes.
> >
> > Exactly.
> > It's probably obvious that we're not going to allow
> > unsafe kfuncs that can easily crash the kernel.
>
> Yes--I wanted this confirmation. I was kicking myself for leaving that
> comment in the patch, but I'm glad it turned out to be useful.
>
> >
> > > +__bpf_kfunc char *bpf_dentry_path_raw(struct dentry *dentry__ign,
> >
> > We can consider something like this (without __ign, of course),
> > but if you insist on using kprobes we cannot help.
>
> I don't know how I could call dentry_path_raw without suppressing
> checks on the pointer. My previous experience with any kind of managed
> runtime stuff would imply wrapping the dentry pointer in a safe
> container, but doing that from a pointer coming straight from a kprobe
> just kicks the can down to wherever it gets wrapped.
>
> I wouldn't say I am insisting on using kprobes, but it's all I could
> figure out to get all the events for the file/directory
> create/open/modify/delete events that I wanted. I was surprised there
> already wasn't some kind of special event type for that already. Is
> there? Should there be?

At the last lsfmm there was an agreement to carefully add
few vfs tracepoints.

> I have this future science project to try to extract PCI traffic, so if
> there needs to be a different type of trace for file system accesses,
> maybe that makes for a warmup.
>
> > You can walk dentry with probe_read-s instead,
> > but don't expect correct paths all the time.
>
> Let me make sure I understand then. Is the idea to basically safely
> derefence the pointer by using the probe_read functions to acquire the
> memory? So presumably I'd be writing an equivalent of dentry_path_raw
> in my bpf program using those copy operations. I'm guessing it's a lot
> like using copy_from_user in ioctls on any pointers that are coming in.
>
> I can give this a shot, but I don't think I was able to get any paths
> on the dentry pointers until I first called dget() on the dentry. I'm
> not actually a filesystem guy so I don't know if this is actually
> required.

Sounds like it's best effort tracing, so the best is to use
bpf_probe_read_kernel() in bpf prog directly that follows the same
logic as dentry_path_raw() but with probe reads.

