Return-Path: <bpf+bounces-41267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A233A995589
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71539283EF1
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE11FAC38;
	Tue,  8 Oct 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kP7dPyVZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C31FA24F;
	Tue,  8 Oct 2024 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408124; cv=none; b=tat1woaGUWUBOsvVDyjaM7dJFeo/olUVrQY8524dA9gTduHBG3MtcDiUfLQAW4kokJCzHkiJorpazbztsQWlHoIWkcDHu1yYI4QywGDcJ/cJC7yRGvHXvkdhE6ysdGLsdl5ZUtzmc8VBYLNRYQknFZoKA2Rqb2ehCCVGJPjPVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408124; c=relaxed/simple;
	bh=mZsL7LGzO3t6j2s7+X4u2FtI7RkpmZfDmUCmVZFMIv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jK+NgB+GvW5a1WBueBkvBj51FIl/nToPU4i1b3uqlaNLfeckn9e7lcOVLiDnt0hkhcyG8gBdGIZrG57RzkOha3ggXH/G3GM1//35/9M6VVDJQvTmTi0XILYNqkQsqtXBj2fFTNAKnY0c6EHx/5KC086xSxCtuNfA4cJjm984VTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kP7dPyVZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d43657255so927919666b.0;
        Tue, 08 Oct 2024 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728408122; x=1729012922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZsL7LGzO3t6j2s7+X4u2FtI7RkpmZfDmUCmVZFMIv0=;
        b=kP7dPyVZZ1EZomhiDsPv6g17o2xG9ZTbLgWmvwv6iV9MbV0JnfScU7N9CNSrmSDnWH
         /6cfjbtgHCI6asoC/jKaeEtr8o2pEOqyG6wYQNRSlrporpy5yNdfXzzvANhATICul588
         E9LJtSDJoKYbdcdpEA0Cmrif5SDw4nxzE5swJjG/YPKlg8UJT934eiuhqfbsuBrXiHrB
         BAr4HQsfegJRzw08rD3dtUBM6tbQCSV5uVrL0TdeOG68S1BZBxYaMi4XPs//LOci1TYx
         nP57CTJWPl0KInrIyLRrzT+pWnK1wpoGYgxRWr18DK0F3VaixQdZf4tHAJ1o/PTqx3YH
         hGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728408122; x=1729012922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZsL7LGzO3t6j2s7+X4u2FtI7RkpmZfDmUCmVZFMIv0=;
        b=VWt1rbqd3Py5ROQt75uyDWBolR7V08Q/Qvftd69B17df+8IHoIeKQ6fl00dIr2Ub42
         522mUJY1MWQfq8XNmavgDZdkd/Es3B4tiTht8u0S89ZM6gYNg6Zgfyvr7RA7MGaYci3/
         BIXSc3ZYsQ1GCnb8eWcq1T5s3rJMHDplrY8sIRDWitZD0RehOwvEbuGbFOt8ldSFyCai
         98cHBfPLey/BMbTqb1wPNVQYUfs169nrjBXfouU8cQXhPphFc4DriC6AAF9g0cgYERhh
         3cpAudY68klzsRSkpFZOPAOi+nZKDDS/pXgKI+cz+UOTgsftVfE7KFfShvFDKxfzRMY/
         Ms6w==
X-Forwarded-Encrypted: i=1; AJvYcCULFAFJSUtCmVl7uG4Gj45wGQ1caCllCc0SKNOCwUWw4SWBU7jYzKx6uhWLUNVML29Z5wGQPPLtNdrRdVHp@vger.kernel.org, AJvYcCXqW7laMmXoABPNNdSqQ0tUqDgRhj148qOGRbsRRkDwEWaUoPQR4netrVevOi4hG3hjbqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsWdSaviSiF5efXI4mOhQbO+GpLYjgbS/hsTRK48P7XUHYCcn
	RxkTtTnloHJ/PPJ6qwdyAOCwJXqksvjSQq/tGgt4iS9sPMJbg+V1uMakw2LQ7CERH/XjGHjv/Qd
	C4vCUeBzEenag/yYPFImV7imukEQ=
X-Google-Smtp-Source: AGHT+IF/9aIhaEes5EXW3dE0CQQ9NT7bJLLGfAIQF5Oe+fCTp9Jd2kOhV4oFI8j3JbgumFrpnd8Thx+Hp5lvvGrJkWM=
X-Received: by 2002:a17:907:868e:b0:a99:462c:8728 with SMTP id
 a640c23a62f3a-a99462c8b7fmr1129165666b.3.1728408121283; Tue, 08 Oct 2024
 10:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007164648.20926-1-richard120310@gmail.com>
 <3be8b6307e7576e5a654f42414a1f0f45a754901.camel@gmail.com>
 <CAEf4BzbpxXqNLa02r0=xw-bHzDoO5BELHqX+Ux35Hh7XRNY92w@mail.gmail.com> <b7c4b77e22bd8005ad5758706ddefe878f949d94.camel@gmail.com>
In-Reply-To: <b7c4b77e22bd8005ad5758706ddefe878f949d94.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 8 Oct 2024 10:21:47 -0700
Message-ID: <CAEf4BzYTuOJ88FR6oN1KDbM5bWuiYo7eVdrrn0FLziuzi3B_Fg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix integer overflow issue
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:49=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-10-07 at 20:42 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > Not sure what Eduard is suggesting here, tbh. But I think if this
> > actually can happen that we have a non-loaded BPF program in one of
> > those struct_ops slots, then let's add a test demonstrating that.
>
> Given the call chain listed in a previous email I think that such
> situation is not possible (modulo obj->gen_loader, which I know
> nothing about).
>
> Thus I suggest to add a pr_warn() and return -EINVAL or something like
> that here.
>

That's what confused me :) If it's impossible, there is no need to
handle it, we know the FD has to be there. So I'd just not change
anything.

> > Worst case of what can happen right now is the kernel rejecting
> > struct_ops loading due to -22 as a program FD.
> >
> > pw-bot: cr
>
> [...]
>

