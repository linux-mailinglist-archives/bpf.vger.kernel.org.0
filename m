Return-Path: <bpf+bounces-78781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F974D1BBE6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 348813035338
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FDB355036;
	Tue, 13 Jan 2026 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEDNyfpP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C036BCC3
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347878; cv=none; b=Wt1UCo1EMsZyDJNlq4LQAbzJnk76KUvKFoalSi5QK+WhAZex4bw/v22Ka4lTBe+x18T5dJqJi624jWSJlE6jnrLoIYXYtVKe3wKTyFGf32F0rPsfT2CocUInYPMOs/FLplhp15V5t6CLaxOjWDlYO8Ue1U7ljLw0bnlZXErHEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347878; c=relaxed/simple;
	bh=naWJNIFRQlEdpMHmk5ownLngDFSb+6b+Xjr/XcBcU3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgJ6hoi55VeIf2tl4pUnRzUMiLZkmgZezW2jlgnS3Cqy8KWpnHsZ+Lsz3SjwpRBGn2WQoKHaeaDXTi1jZmnyso2Nyk1QAby+LQz914MTsMgKw6+sqyBrB4IL/+5NacH1slYMCxIvQPne18xY3A2GP0NB4G/O43x60nZ4xyCfvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEDNyfpP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d256c2a9so4394257f8f.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 15:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768347875; x=1768952675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naWJNIFRQlEdpMHmk5ownLngDFSb+6b+Xjr/XcBcU3c=;
        b=hEDNyfpPmk7rSlHY7ocQAO5eIShqlrfcBBUJ3bzBlZmysJw+HGu7hP2lDP4Yno+W/C
         xtzbkpVzU16BM/JlLbCscKV3kqzEhi5nTFWgZv8dSdApl0QrzDZUqN3Cu3dEhbbJEt27
         qNwchFflme1TsAJLLvIlTgisf9Q/MnSI58q5LpPBaTutlOT+H8bQAY4LuA5OA735uqb+
         Ujjq7uH7U7LuJtLTjfvul5nlk8k0pu0HFJ/cB29B1aCioHSObW4cxKOnYQZXUIB6UVyY
         me/8rNkgVWvTzxodP3W+crtPd0CrX9jb0rEjhKmmakkFrMIw0OMyIUjyUIMOVIps1BCq
         LsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768347875; x=1768952675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=naWJNIFRQlEdpMHmk5ownLngDFSb+6b+Xjr/XcBcU3c=;
        b=vf43AXLpeZ0gLikc3VKqfeJblNqLEMvM8ptylWQswDG9yM8xAVdSL5Ws3Qj4FYFJjl
         ysl4qlWZfuh7fW0MDyStQwD5VYo15DHtb3GYpTfnc8Ji4+A5aLZOFjUXqUnr6EVpcDjw
         bIYIQP1UkOTr88ofB1KNlxvi1ME/nVTLW2n6BSgOEJdnu/ZdoLj+wkYxaFPeXEVVE8/7
         ZAzGmU6ShK7YskcXG9ZIAj7bYJkQ56v8iTzFhJKlsybABNkTfcwviA19ShgovbWOlLfO
         OEkhV6Fc2YW8EupJHlueZHbqLaNGm/T2S4BM3vz1Y8Krglo+L9xuS5Lin3gKPHlpcPOJ
         s2NA==
X-Forwarded-Encrypted: i=1; AJvYcCVqGLGPfRCxn8spmVhE6F4eVvDs01XltTI83oIlWQwj+eHoM2sjc30j4G8V9pg2DX0v34A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzfUVyojoYXRU9qvaENVL3bm/oYPX2XZR9B7+9CEQ9URi7rI89
	BAmDO5o4Lr+O7b1ap079UR6MMAxwpNQAOfSaY5OMfjjbxIarxJE/hzsXW4q0pOBS2e6LgBMYYcQ
	PNEm6YGhjMAFArX/qugpi7u5gYJDyFz4=
X-Gm-Gg: AY/fxX4gZyDtGS6DnZeojPoD+BjQaFqwq8CISQ1oCYzHsUa19+vjr005KlPv8VkVFe4
	XPe/GzflM/s2Mrta31NJL8oYJj0CoFoASGPevB/IEzfEj59MRfC4c6ilPlyR9QuGQ0QzTylSy40
	M0eQpUtiMaabSWXN9cRJgxwk8uFPTPp02Sa3QKj2b0Lgm9xHI7Z7ixjbgMhsNFnwxdW2SROp4Dm
	3b+4KkuqwfLcXgwmq+xjuM54s9Y4RsQYFylnP3ApYMTOmH0z1D/IzMI4mQ7sNgRjKxwV8wbwaRN
	jnP+buG40wXFbRWCbPe1cuWKnGCh
X-Received: by 2002:a05:6000:2502:b0:430:f622:8cd4 with SMTP id
 ffacd0b85a97d-4342c5576a2mr546852f8f.49.1768347875049; Tue, 13 Jan 2026
 15:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
 <20260109173326.616e873c@fedora> <20260109173915.1e8a784e@fedora>
 <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
 <20260110111454.7d1a7b66@fedora> <CAADnVQJ_L_TvFogq0+-qOH=vxe5bzU9iz3c-6-N7VFYE6cBnjQ@mail.gmail.com>
 <20260111170953.49127c00@fedora> <CAADnVQJiEhDrfYVEyV8eGUECE_XFt7PGG=PFJRKU4jRBn-TsvA@mail.gmail.com>
 <20260112085257.26bb7b5b@fedora> <CAADnVQKvY026HSFGOsavJppm3-Ajm-VsLzY-OeFUe+BaKMRnDg@mail.gmail.com>
 <20260113142340.xEFFVvni@linutronix.de>
In-Reply-To: <20260113142340.xEFFVvni@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 15:44:23 -0800
X-Gm-Features: AZwV_QiZTOkqU7DSGKGdqwRyoCz_0cyvCLSbxWK4R4mCP4W56GAgkxLydSRDg94
Message-ID: <CAADnVQKMR6kkqC5JQceg6A8F6qSd_cYQE--1ToxwDUxTytPbGA@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 6:23=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-01-12 09:19:58 [-0800], Alexei Starovoitov wrote:
> > > Now if you are saying that BPF will handle migrate_disable() on its o=
wn
> > > and not require the tracepoint infrastructure to do it for it, then
> > > this is perfect. And I can then simplify this code, and just use
> > > srcu_fast for both RT and !RT.
> >
> > Agree. Just add migrate_disable to __bpf_trace_run,
> > or, better yet, use rcu_read_lock_dont_migrate() in there.
>
> Wonderful, thank you.
>
> Is this "must remain on the same CPU and can be re-entrant" because BPF
> core code such memory allocator/ data structures use per-CPU data
> structures and must use the same through the whole invocation?

It's per-cpu maps.
htab_percpu_map_lookup_elem() returns a pointer to per-cpu value
which needs to be valid for the duration of the program.
Not much else.

