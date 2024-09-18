Return-Path: <bpf+bounces-40052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C690797B735
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 06:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32BB1C21FD9
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 04:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE6137764;
	Wed, 18 Sep 2024 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH2D1Pj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88884136A
	for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 04:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726633042; cv=none; b=C0yfJt1c78INP0WptDcbu5wH5Nb8DKEzjC5/RQ55jv3Qi5cxwhkgbTuFjcnODG7wQTj/3rFL0xFit4h+VQkmRcc1pTJUHpYqzkb8KeIvsWaaxbUA/fmVOznNbVEJ+LRzwIFAyHKZ5RmP/Qe8Y888XhCNCFllwgBe/L3YSa/vkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726633042; c=relaxed/simple;
	bh=YxkvnPOXdmuOrcP4HP3VawxMoO6+bXeONarFZSOP3bk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M4cxueXY+tEdQWfXA8LIv90c70XKNGACqbOW2O7QyegfsYyZ6WBRe9KTR1hfX4vxXqL1psiIQ0l9H4l2qnpTAO4rc1MEX+ba93C475SpG9lTStihT9HEFpXXFqW833xSEnbAl0z7Xf6bwXLdiZ98uDcIQJr2/N76bQJ54CjKV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH2D1Pj7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9ae8fc076so628429485a.2
        for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 21:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726633039; x=1727237839; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HvbxF9h0mE0bKeqpZoun+BLK/FMTXHJyV8xietoly6Q=;
        b=mH2D1Pj7B34OHY6vJ9rLRxFRKvnhG+8NyKCYq6R5Climr1J64OKdwwzh1XbiU25CFu
         tsmtbpZ7XNTcQ2a2UdOI1w2fRhwRwbg/LhID9KkpWhyAZ5A6kCLqiZwccD8ybVVeOiYk
         I6O1DM2otz2ctsGSUdfI1MFG1hxn5MlZVsPs/FFUiX6JjO9VLeP9sNV1WD2div7NsACD
         MNtQXIhqzU7r71QzQWf5GyQPNIcUDwL8N6nvSjrX7gAwmzfs+cxBskqTqfuYuPpY0eNL
         CQxF4Qy/cgzMeEnKiOGIm9h2+Zx6DGhuDNy5G5s9QhXsJSehgAoIAbZaO89Jv5+LuuhG
         UgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726633039; x=1727237839;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvbxF9h0mE0bKeqpZoun+BLK/FMTXHJyV8xietoly6Q=;
        b=Vib1xxxS+w9YWDD+lXZTyIIkCU9YyQ9BzMLXErTBwXXuZhrq8e8gHeWiSWFjnW1Fhk
         hbixCaD0LBdUmykgRDkeT1WE+IVuPREl2W2ztFBKj/+Gu2/+6BwaKN/Xo/fgnG5e+rYD
         Kq6BRkPjZQogctyNz51FU1JA6Zkm7vlskXzQYJpECj+IwJ8iyZzQewX/xFLN1EAxHpr3
         JCNndH1NsVlHeKKwUZ0iJ8b6vxlZuD1ZYbl+G4lcUJKGpkBOocz/pw5ctI4gTYcTMf6C
         /iDefbDQ2dST+Hr5DzFgWFdmVL2JNnoh6oqQ4TeuSDCirrB8H9NJ9HFWRRCPLlCinDT4
         oAMQ==
X-Gm-Message-State: AOJu0YyNNF4SNC4QTf37dUH0QGyB4J8TcnuiIyT1c7REz3ZH5QkSpERO
	CTfXQR972Zn0FPyAeOhAZJKHPSeuPUt8RLCAYQFtCgw3aHF58g+/l7nBfopOKNiOYcK0S5B0wPE
	H7Md4Si/qgX5SaDTmA2taUYkgknWhNWWQXJ45579Q
X-Google-Smtp-Source: AGHT+IGfdfnpcQl62BRBXnyWjvm3H21S5IwZIWHyGp3Rm1Soqocu5eJ0H+gNO6eU+6Mkv8p9gmQjFc6yAvnc2cdZSkE=
X-Received: by 2002:a05:620a:48f:b0:7ab:3679:2e6f with SMTP id
 af79cd13be357-7ab36792eecmr2086157585a.36.1726633039008; Tue, 17 Sep 2024
 21:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yunwei 123 <yunwei356@gmail.com>
Date: Tue, 17 Sep 2024 21:17:08 -0700
Message-ID: <CAEnnukYMva1e7FKjtpSeX7H8Uqp67b8-tb1g4TV8m-k80WDLSQ@mail.gmail.com>
Subject: Can we Understand Kernel Development in New Ways?
To: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone!

I have been working on a new idea related to eBPF since last week, and
I think it might be interesting. It might help answer the questions:

- Can we understand the high-level design and evolution of complex
systems like the Linux kernel better?
- Can AI help us with what's never possible before?

Stop forcing stupid AI to do buggy kernel coding, or just using RAG or
fine-tuned models to give wrong answers.

We are doing a completely different way:

- By carefully designing a survey, you can use LLM to transform
unstructured data like commits, mails into well organized, structured
and easy-to-analyze data. Then you can do quantitative analysis on it
with traditional methods to gain meaningful insights.  AI can also
help you analyze data and give insights quickly, it's already a
feature of ChatGPT.

Imagine if you can ask every entry-level kernel developer, or a
Graduate Student who is studying kernel, to do a survey and answer
questions about every commit/patch/email, what can you find with the
results?

- The Github repo: https://github.com/eunomia-bpf/code-survey
- Some early experiments and reports related to eBPF subsystem:
https://github.com/eunomia-bpf/code-survey/blob/main/docs/report_ebpf.md
- The commit dataset:
https://github.com/eunomia-bpf/code-survey/blob/main/data/bpf_commits.csv

This approach is in early stages, but it's general. I'll be at the LPC
and OSS Summit and would love to chat if you're interested! Also, if
you=E2=80=99re uncomfortable with your data being used, let us know, and we=
=E2=80=99ll
filter it out.

(I just came across the idea last week, and didn't get the early
experiment results until yesterday. It seems LPC CFP is closed...?)

Best,
Yusheng

