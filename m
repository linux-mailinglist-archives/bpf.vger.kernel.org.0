Return-Path: <bpf+bounces-45794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEA39DB178
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E14A28248A
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A7773451;
	Thu, 28 Nov 2024 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1EwRWtG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813BB7404E;
	Thu, 28 Nov 2024 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732760892; cv=none; b=ioEGVyDBW8oBF9nv7IFG4huWv52MLPnOmlCU3KEuYq8+wTy4E3uI4EJDtoknGioKSeld3HYwoT36fTE4q5JVcwAHJsdd0nlqOlA180W3+PJLjC95yEJPYmbM7AYgzMeMxx0VIiSAghrZTNCAiEGza7svW9e18ZcWBrO5I6VVunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732760892; c=relaxed/simple;
	bh=KRLLvV0v/gAxyjccF9CRZFbxmNkYr22ARld5uyY9ePk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4aSAG3RL/1dy1niz4nPG1Cijf313bpPTrFBsWPPO/CSj7+W3hYU7Pc3o/yi8gq/K8SMS3/tt5D/ulJ07yaJVR+OvTs6XqspfLQHCEIC76fWQwa74ki64MaPxhOPR6ypp9FrjIGSOpWEXjybiwJEGIubQ2LrqTRkm15OQc8lt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1EwRWtG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-432d86a3085so2581305e9.2;
        Wed, 27 Nov 2024 18:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732760889; x=1733365689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRLLvV0v/gAxyjccF9CRZFbxmNkYr22ARld5uyY9ePk=;
        b=M1EwRWtGStLpa1gXHxfW6SMf/vjAs2IkDgQr21C9yowH9SoSLHW2zdpmJS3/jflAmM
         DI9RURr2G8h0ZqJm0NrE247qGd/65xXuHOD0j6xjQ/aIqkGu/kbF7WddihJYapWx2nfR
         AAlOB5SEE8fnITD7HLwyBkS94OobnN74Ns7quBB5fOYgKUQCdgOLuzxTeuqiHfN+ftTT
         aHUGW9CRZYgkCiBkyNY9DhhLmGfZn60zteTpK4xI1Y/6RmZL73aEwoLL3GxHIqS0xVGw
         lPy7WPrNCRpdk6Ivb32d6kRkEcGt79XhNW63tCl2K1yjmhP/gCnEGJxd06Ih1LZyLoqY
         x31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732760889; x=1733365689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRLLvV0v/gAxyjccF9CRZFbxmNkYr22ARld5uyY9ePk=;
        b=HRGcHCo+UwejkaGwQMvV2xMrzOpUsWJsnLrAUQDczSJCfIypE0zNtODgdO2xQEdQLW
         D0V2uXtSVI5nkgqxvSn/JkNb4vuSBFjB3DzZsWrdZPwrYKCpUCgtfjspmV9Ze4YR54kc
         pp6VgzymbXdvZ30S/C8BoRWRbHx+remJ7xaYb39Zqwx++xCdkohb48MrB/onQTR5YyWp
         ZZf6PvlRKVE6vcgJJYj/QSp6RS2B9zpWfJ0uG4T/babNPj9a9Mnb/eVoOmrp24HauNiX
         cZ4UeOgdCiwMZaxA73W7ZALN9qlTpZ9MLtmhl/noEZhQHCuXv43o72vlVUmj03JOiZ5h
         1Maw==
X-Forwarded-Encrypted: i=1; AJvYcCVu3b709dPOntvOzoKv/vy4CI8QxnlUVcAkiUuzoDAs1J3n2f6cDxk00+gBDitizlTmru8B9H4XMJJsrbKx@vger.kernel.org, AJvYcCXlx4LueHfHB3O9ShF05xHDykGFUYIk5XDjGpy3VOQbQ7DC2/SNwqcQlot83J/AQ8IN0Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyM1jrtYb7SFy9EYPM8epa2b3E9vh1Rj6bnFvbnFmWS+hffrQD
	kkCgC25zQczEl3HJfXbSJTlZ14tp8FA5YRBydoQ/Gukd/5sqZ5eLXFFJTxX3OtzQSc7ypSFly69
	eJoWhuh58F0l0NcqfCmyacnB2lvI=
X-Gm-Gg: ASbGncsCS5oy1UHPb6B1dK2t1aYYAabxlNnkSlSt1VkcDfrcEBDL3vkjUMS5MOVFY6k
	qp1W1VWCpYBp1QXQwIogEMViE/ziaXw==
X-Google-Smtp-Source: AGHT+IE3I2cdv25wTRXMa1canTQ17M4o5QxQP/G4MUrnUMgHV1IiVi/bQ7Qp+5Qo4Tpt6RTy8RHXJe/O7iCiXx1ysGY=
X-Received: by 2002:a05:600c:444f:b0:434:a378:51a8 with SMTP id
 5b1f17b1804b1-434a9df7bf1mr46000695e9.27.1732760888592; Wed, 27 Nov 2024
 18:28:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYHeh_=iHOYL88pXXdHGZuAmQNM0jM+9iPUou+7+YLjjQ@mail.gmail.com>
 <20241127230349.1619-1-hdanton@sina.com>
In-Reply-To: <20241127230349.1619-1-hdanton@sina.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Nov 2024 18:27:57 -0800
Message-ID: <CAADnVQJ+eoczS6JK7aUZSWzUFggEyXW+w4oMiB4iY4F9FpMVRA@mail.gmail.com>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
To: Hillf Danton <hdanton@sina.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ruan Bonan <bonan.ruan@u.nus.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Aleksandr Nogikh <nogikh@google.com>, 
	BPF <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 3:04=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Tue, 26 Nov 2024 13:15:48 -0800 Andrii Nakryiko <andrii.nakryiko@gmail=
.com>
> > On Mon, Nov 25, 2024 at 1:44=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > > On Mon, Nov 25, 2024 at 05:24:05AM +0000, Ruan Bonan wrote:
> > >
> > > > From the discussion, it appears that the root cause might involve
> > > > specific printk or BPF operations in the given context. To clarify =
and
> > > > possibly avoid similar issues in the future, are there guidelines o=
r
> > > > best practices for writing BPF programs/hooks that interact with
> > > > tracepoints, especially those related to scheduler events, to preve=
nt
> > > > such deadlocks?
> > >
> > > The general guideline and recommendation for all tracepoints is to be
> > > wait-free. Typically all tracer code should be.
> > >
> > > Now, BPF (users) (ab)uses tracepoints to do all sorts and takes certa=
in
> > > liberties with them, but it is very much at the discretion of the BPF
> > > user.
> >
> > We do assume that tracepoints are just like kprobes and can run in
> > NMI. And in this case BPF is just a vehicle to trigger a
> > promised-to-be-wait-free strncpy_from_user_nofault(). That's as far as
> > BPF involvement goes, we should stop discussing BPF in this context,
> > it's misleading.
> >
> Given known issue, syzbot should run without bpf enabled before it is fix=
ed
> to avoid more useless discussing and misleading.

If you cared to read the thread it would have been obvious
that printk is the culprit. Tell syzbot to run without printk?

