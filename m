Return-Path: <bpf+bounces-41687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA1F999A56
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9746E2841BE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA21EABA2;
	Fri, 11 Oct 2024 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKvr/Bk7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493E10A1F;
	Fri, 11 Oct 2024 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613358; cv=none; b=jv7NzXafd5woIswqa6kHBD8Mazu0xZV2j5XUz9k/5kM8AmJIPkM2tVP3qbf+D2tLDFgnliQQtjiXLs9qb1WEteNYYuXwITSWKWLQs1OyUFae2Pvvt5HLIWf8hDMCxSxDGJz7TDlvBXPBB1SsvPHEwu0kJbcLt7KVIN5aNKNR+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613358; c=relaxed/simple;
	bh=GskBzk3O4HBzB5hQTDHvvWsqnpr+JiOCOLHAtrfw5Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/+HmW096zJtlTaWdoZB/O2omO5snsG2RPySDZF9kHFv85cXnPu9edBHtAWXRtx6rdBEtrwUZpdEV+wCi5XmtszRwK7Hn4mr+j2mDOOuPLnNQvRq7LE6SasQSgZZg6/flMz+VCynrLvn+IskokuSyIFrGaOwbgIFnskhGAzFtBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKvr/Bk7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so1370686a91.0;
        Thu, 10 Oct 2024 19:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613356; x=1729218156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vEIPMlKM7uozz1PqqrcehmHg//QQVPOsU/coffPKY8=;
        b=ZKvr/Bk73CdEYKM9AtAL1qGmh2iMRnOOhXw2E/Y8c2qhy4w0eP+ED41Gw4pORNiFfi
         eXW512FGLTO1iQFfhzWkNBjBTZ5zZjgOHRmXmMFlnvTnzgocXfTR+xXJXOR4vnGdAgC2
         RqBPFbdRzTUEcH5c6q19I65N0gPoEB3Bj/0kAUqFcP4Mi23I7x3M4kFCBRtpg4nWt+in
         VSMJZp58PO3UpuW/yBM8akTxTiGh4vcYwur4tAI6trt2TB7Z+8H5qovTLWJmOU44qjQ2
         L00rHfmL+wfDAluOSxnQzTfuZY9RilPLQUhjMxf2vjqLYkoi5vqvqBwfXsPpJQEJhF7H
         HZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613356; x=1729218156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vEIPMlKM7uozz1PqqrcehmHg//QQVPOsU/coffPKY8=;
        b=mwQmQk8GcQdGVOGdUGUSXljNPjKgfJ0qTy8DMt4mrB6xmFauhfFqckl8lGARSqXugi
         gGzu1pJEZmYvxLtfdNpPZ55/lfFrNgrJ7j7GPYPh2BX/ytJrxhkOAOInX0ve/YwmXNPE
         sbu5WvakMm11w7fQSMhlV++IeRM9WhexV6NkX1Ek9rOpXRjXmDAMbdmn15dvrRNLK4hA
         YSYRdu6F3J1QRopPnO2azmZwsf1Tmb26GkKZHvzQ+TRK2OpaLmRpfJ/bw2Wo//RRtwP6
         r12IcEtdQ5kvJub1UN1U1ZiWhRH3e4hka/trxglxcbCWF8hnPe6XuNijR2grKPRxt0Ox
         9ygg==
X-Forwarded-Encrypted: i=1; AJvYcCU3KM5gv/RVPUa/1IZyfZF6N0bKHBgEZ1IzswVRnI8/cYMk2NF4J530VeXKSNhps+6V5NiLFLrZslg0KoVj@vger.kernel.org, AJvYcCW/Med3/FvwpcFNIvjMNmnee+EROszNDmd61lJ3HbNN4lLK1A5gFAMaVj41wzwT8GDDd+KSCSy4iSvFHPSHZV2XsVtb@vger.kernel.org, AJvYcCXwH59INJjENNKCkvbfs4iDfy+gdaxRqG/te/T4O3kUFuGsTEoS9T4i9wE9KzxtBthZO3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7dsIyQq+0L3r921iVL65BFdvKDtCcIblWC3q4KpG2v8SS/WgU
	LZZ2UYH53yFO2FavorcplBaucgSwTs8wuSbwgPZehZHrjE9i4G1/f8uhNZAkoskg6GM9mo9ciXB
	n7q8Oo6UzH2uppw5jP5+u+iyj698=
X-Google-Smtp-Source: AGHT+IHotBDDlxosmoeTh1nJ+f7oZPOvMuUZjkxEkWq6rU2XTNUtGPkv44QwArN9xHeRgzNi5iyEyBHT9bBZ/6kUngE=
X-Received: by 2002:a17:90b:1297:b0:2d8:7561:db71 with SMTP id
 98e67ed59e1d1-2e2f0d80e98mr1442851a91.25.1728613356010; Thu, 10 Oct 2024
 19:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-9-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:22:24 -0700
Message-ID: <CAEf4BzZE5k=MTAcGpUF1V38CYCqR10nT+LsB_wHYnT8XsVO-nA@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 08/16] selftests/bpf: Add uprobe session test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:11=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe session test and testing that the entry program
> return value controls execution of the return probe program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 47 ++++++++++++
>  .../bpf/progs/uprobe_multi_session.c          | 71 +++++++++++++++++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_sessio=
n.c
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

