Return-Path: <bpf+bounces-22158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96717858005
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 16:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51730282C1D
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A005612F37D;
	Fri, 16 Feb 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWpI0SXL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923EA12C7FB
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095792; cv=none; b=Z1yHI0r+w7dmFd7dJMB1PQPv0uqaIL6h3c40hNdDv5WCJIACmFr9i+YYAtDui2z4RKN9dG0lmp3Rh8gOJjRuG42zEqJQ7krYz+bB5ytD1l0vOMo4JN1JH20GTc9Gstloy+7QJFCRDNzRE6Yss3KaMpr1nRXH1MdviPvky4OA6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095792; c=relaxed/simple;
	bh=2E/aQdJDUsWHxAWp6K2EkL9TliJ4YDDfcJcWfUZfsC8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA8HJsuYf7gSe0OM8eLx4X+tuM0fMeO5cJ2Kkbo5Qx9SJQ1kDFri/RzyyMtnz+7dWkQwIDQjc26xADvsJorHyG7j27XNEYyCOSzTXJJxNkZp04Mf26Np2oo6CmuA3f6eEuyWuFaqZ6wGL/wiqxNU0VSAbrj6ZgOfhJYU3fB+u9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWpI0SXL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e05775202so12586066b.3
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 07:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708095789; x=1708700589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvkYZJoypoyfEA8zFEb7f4B1jdmhuKep4CDS/2LQwJ0=;
        b=OWpI0SXLIxs7/duh1Bs9MJgP2BTJnCxe+l9Ol3HOCmTUhPUbnzZZhS2vdz94j5/PnF
         0fySGah/XOJfN+wkIopl6Gket6EoClgwkBjeqEcsPUR8By26pXMI+z3Gc149W9/h70at
         t9Erm+rh+Yxf70oe0KGiem8C2ceXQsowK0cnpjkNWxpG7MLTIJ8BL5HybSD37Uobz3cE
         IJTI/ExYhB91X3sQt7UgMrNCpFgyQQrowSo8XtBdwWJRubLbpe+jG8FVLqpbzwIX+/r+
         RGljAB9b2r9tamJ762wsGPnxftvY1zx1lMtHa2Svp55dTjCk/1o+Kb8mj+XDEDPNyDYQ
         xKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708095789; x=1708700589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvkYZJoypoyfEA8zFEb7f4B1jdmhuKep4CDS/2LQwJ0=;
        b=rmX+pv7wUUELoIQ2ZtihF1TUVfCWlX3shh7stt4FZwzeWwFx27YnrRedLl/gpx7St4
         yLPyft+cqXKC9h2y9o42FRs4P9z+ujXuwL0Y4Hp2HGyIsu5kXqNRZtGc3AiFPRR6tsh7
         0iWtpgRvw1O37Lakx3lwcqYVZzXbki/rQ4srBbLieq3FlDyH4bS3XwJKkC8DXSi3WSj1
         Pzqv64ejs4IpLCc5vaHjJnOSrRubLu7Wlv9OFsKLu3nSyUe77XT+OZr6yIw/Fqt903RH
         R8nkrNEWQs8xhWhsIldXg/DnuEZIUu/efQdTFG2zU1omYDKON3f7nVrTGy/8CZ7BGfzL
         fnlA==
X-Forwarded-Encrypted: i=1; AJvYcCVa0nLULtnxvb/ozLgUiT7krDupZLTh7aDl2BTVluoqE/H4WbVmK6orJbkAv0WsQB/02iGVi+pqMnU2SNQ7LWxMNS2R
X-Gm-Message-State: AOJu0Yy9KoS/9ZETB1rEaRV+WJ83QblPT4zx61sbnGgJ1PIbdqYg/RKv
	CqM3odJyMut9wbn/c+MwCyC+YzOgU843lPVf0AkDf+YU2fia7RHY
X-Google-Smtp-Source: AGHT+IEitHWVUi0HgWE4Pd9hqT1PaTvNbSidd2ulC87X6cTq8TZW6cAZ7/4aUSy+MeozR2nHoKfpwA==
X-Received: by 2002:a17:906:4115:b0:a3d:4984:8d73 with SMTP id j21-20020a170906411500b00a3d49848d73mr3811544ejk.18.1708095788584;
        Fri, 16 Feb 2024 07:03:08 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906448e00b00a379ef08ecbsm19445ejo.74.2024.02.16.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 07:03:08 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 Feb 2024 16:03:05 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
Message-ID: <Zc95KbHKtfREu3ch@krava>
References: <20240207153550.856536-1-jolsa@kernel.org>
 <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava>
 <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
 <ZctcEpz3fHK4RqUX@krava>
 <CAEf4BzY_UBNe4ONqKGg5VtA-nY-ozgpQ=Du1+8ipQNnZ+JKCew@mail.gmail.com>
 <ZcvadcwSA37sfDk4@krava>
 <Zc0op6a3ZrI7JD9z@krava>
 <20240215112722.2120471e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215112722.2120471e@gandalf.local.home>

On Thu, Feb 15, 2024 at 11:27:22AM -0500, Steven Rostedt wrote:
> On Wed, 14 Feb 2024 21:55:03 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> 
> > Masami,
> > we recently discussed the possibility to store data between entry/return probe,
> > IIUC your current patchset [0] allows that, but it seems to be shared across all
> > the tracers for the given function (__ftrace_return_to_handler).. is the plan to
> > make the shadow stack per tracer and function? /cc Steven
> 
> The shadow stack is per task, but it saves unique data per tracer per function.
> 
> It allows up to 16 different tracers attached to function graph tracing at
> a time, as there is a limited shadow stack size, which all the attached
> tracers use. Now you can create your own shadow stack per user (bpf
> program?) and have a single registered function graph user that will demux
> the data coming in and out of the function.

ok, I guess that's fgraph_reserve_data/fgraph_retrieve_data api

we'd like to share data between bpf programs executed from entry
and exit handlers, that should do it

thanks,
jirka

