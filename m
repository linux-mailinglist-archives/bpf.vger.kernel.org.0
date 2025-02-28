Return-Path: <bpf+bounces-52922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84481A4A612
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66335189C488
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A891DE3AC;
	Fri, 28 Feb 2025 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7vZnaCu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A441DC05F
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782373; cv=none; b=qVsa0crxn3IR5vWh1vetVqknMR/9ymNV70OCo7H/BhR2mRPG5FN3Y7pQ6/EsNzkV+j/hIPk2OOcvdKaJFrSlGpluPMiuRWNcRrYqq5XlhAAw5q6pMEAHB8pyM/bb7kgblEOYpPdvDjviHpMtTqvoujelMDUtHhKvxYLWjhxWDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782373; c=relaxed/simple;
	bh=n8i1kRDLjmWbMBYbGnqmdTdCOe8qpcpQMuWXAFrMYos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ8CTJZPtbSgWD7pSgXsWcq81E5v1Zym5H2JL7LSCIpwkVeK59owNbm/WB4oaY83p1DMsS4e69y8iUqvwGahrYaw0gSbS6OTNlhjXO45Geq1waN9cqtza0lB45p50dwqZ72LlS6Jsobs3wGI7vYabSyTPMpiRBANDR9Yt2Fng88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7vZnaCu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-219f8263ae0so51019535ad.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 14:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740782371; x=1741387171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTv3vIKEu2N0YsxCv0o8ff29DJ8VmgxUVuRLxUXSrwE=;
        b=i7vZnaCuyYUBR5ESwShHrhBrHDaHQzAc7GU7aagrziTSnaPaqyYcgTC54m8Co0YkTW
         VsW/cYTeTTTM8Fox1tHo6YMfN3RFDJkPC1E3HbjiWahuRvZPD+AeuZ8hV5fdpGhKZKlL
         sAkAvsghzfLr94VydUR0eTRxcUNA5bOqVTKcwOP/JfZ5d3648rqK6jxo/pEzpfXFVhBm
         LDog38kVuJgixZzNg0MUfLkzgBaMZYTIirX5b8IaxDI+Di5xYuMiC4OaP1tBnGdtG7uQ
         e+tufbyZ+vKHOKJvgoAFOE9BGacqz+UuxedxdvymttBRxpcCqw1NmnCTLztYVhpRYhtg
         7NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782371; x=1741387171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTv3vIKEu2N0YsxCv0o8ff29DJ8VmgxUVuRLxUXSrwE=;
        b=g7pLlRJPhxkCyxLAjOPhdIz77O4AeHl42bVkv3yUi63QmIj4PnS3eUhjFuaYOSvS2L
         br+zIvPNnO9m8Jw7E12sJCqBIYSQqiU2xZv+IpXf6AWojFMQiLAyQwbvNNwFxAyxwdK/
         3iwUqj/A1SmH4rIJAc+6sfWHQjgx/UCvl4awrEM9dFjyl2bPfYm61C0AG6sGD8LAvSTO
         u177s24RmcdPqfupplyBquzfvE7X1kNP2+lS0MSSI0hbxh76s2uqoICn1UQmuSvVXk3s
         q98Y6dRTBKLqgfAPXV8fN3605yapIXmzeMAX9zBihX9A+osncYVEp12g+2JHOFTYPO5n
         wx0g==
X-Gm-Message-State: AOJu0Yz24d/COdeJ8rwAF3ltHrF3NXWnCgrgQ9ZUlZzwb5eam7WF4xdL
	htIWNJXQJkZOxw6o8hVgVDHL7fIywtGvsDM35wdVvXkn2cFq2C2K9nvrnOGl+ikSpOrKJ56OjCL
	QBg1upN4e38nKgaCECWCHrTFkBOc=
X-Gm-Gg: ASbGncuaKYit5+YK5a98joYq6CN12y2bsPG6tjqjniiPTAvmcZ4c+yeJtmire6aEI7h
	DftnDXcoreoVzUJtFhubZLZ4uOehNonZPV1/SWap82T+Rr59sahAja9wqUq+6J+ioYFEUjLMMUs
	tUvfEmLnnd80DHxi9+01QQheXkbL4TssehzGpmQ28mow==
X-Google-Smtp-Source: AGHT+IFLgrFqMraV35QGkmLAJw+tz18OiZgTP1GaxBsizkZ0hrHMhiYCvIl5KX1XlF9/9oYLWnYZzdCOFeiROORAk3Y=
X-Received: by 2002:a17:903:fa3:b0:220:ea90:191e with SMTP id
 d9443c01a7336-22368f6a660mr79020835ad.4.1740782370988; Fri, 28 Feb 2025
 14:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 14:39:19 -0800
X-Gm-Features: AQ5f1JoOoHDAC3Cwi9Qco6FY_yqobeup44r4JiVu6_rCK4DaOMFuHZb-bZWLFCU
Message-ID: <CAEf4BzbLzhMMPpu4KbgqyHsPZwbO2VEh54h5HhOjN702nygWMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce bpf_object__prepare
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 9:53=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce a new libbpf API function bpf_object__prepare enabling more
> granular control over the process of bpf_object loading.
> bpf_object__prepare runs the same steps that bpf_object__load is running,
> before the actual loading of BPF programs.
> This API could be useful when we need access to initialized fields of
> bpf_object before program loading, for example: currently we can't pass
> bpf_token into bpf_program__set_attach_target, because token initializati=
on
> is done during loading.
>

I think this cover letter and commit messages in patch 1/2 could use a
bit more work. Here, I'd elaborate on anticipated use cases (and there
are a few already):

  1) taking advantage of BPF token for freplace programs that might
need to lookup BTF of other programs (I'd also mention that we don't
want to move BPF token creation to open step, as open step is "no
privilege assumption" step so that tools like bpftool can generate
skeleton, discover the structure of BPF object, etC).

  2) stopping at prepare gives users finalized BPF program
instructions (with subprogs appended, everything relocated and
finalized, etc). And that property can be taken advantage of by
veristat (and similar tools) that might want to process one program at
a time, but would like to avoid relatively slow ELF parsing and
processing; and even BPF selftests itself (RUN_TESTS part of it at
least) would benefit from this by eliminating waste of re-processing
ELF many times over.


I.e., think about writing this for someone that doesn't have enough
context. They should get at least some of it from your descriptions.

> Mykyta Yatsenko (3):
>   libbpf: introduce more granular state for bpf_object
>   libbpf: split bpf object load into prepare/load
>   selftests/bpf: add tests for bpf_object__prepare
>
>  tools/lib/bpf/libbpf.c                        | 194 ++++++++++++------
>  tools/lib/bpf/libbpf.h                        |   9 +
>  tools/lib/bpf/libbpf.map                      |   1 +
>  .../selftests/bpf/prog_tests/prepare.c        |  99 +++++++++
>  tools/testing/selftests/bpf/progs/prepare.c   |  28 +++
>  5 files changed, 267 insertions(+), 64 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/prepare.c
>  create mode 100644 tools/testing/selftests/bpf/progs/prepare.c
>
> --
> 2.48.1
>

