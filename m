Return-Path: <bpf+bounces-77766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1956BCF0CCE
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 11:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD58300B83D
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78A26ED5C;
	Sun,  4 Jan 2026 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZfKE/JN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF61FC8
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767520861; cv=none; b=XsWSZfVzDSnxdqOds2uN4bTDlUJXOcLqXqREc74zYiMwUIqNR/B29P4QaOWNbYLxTRGdU7g0bzOjHvHiG8zIAc8fnlgdZ6KPXHS0Sm4bIeJ19zDRsirGNWbf85IGxv/x3AQ1vHLXxsWBIYNZA4fr5zzwS476DOKqf7qdGWP57II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767520861; c=relaxed/simple;
	bh=0RPZIxSaX4TH50/WI7hcpzHnzIU6efmP445eGO2GjgU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UIV0IHBnJHqIkqmMyI3N0li3wZmZS1SpNFyNm2WoDFewuGD9bTs4jDK5J43Lgpnb6ehO/VPzbYZiSVeSZqf21Hem5tiw8Lxd6Lff8hAmREpsWW+sSm3JCvk8+YhTlF+cd8gIEMM/9T5gPGjlm7M89wRv/7y6NrAZ44Y72VzWjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZfKE/JN; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65d1bff2abaso7136763eaf.1
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 02:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767520858; x=1768125658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxvq+P5T+UHE6EUP4AwDIrBCHrlsHw1NSZS7vNRvQhw=;
        b=KZfKE/JNRV2RrG1O9jAR2dk+VQYEkHj8RWSeEx3xLuMbEOtBeJVitrlH1IxRsWP2vl
         P9v5oUfiJ8T9A+IbqzSeOL/VmdBgxHibJ3BVm3SDuKWzHmt/T2aO9i5vm3z7h5WdJU2o
         HaR3aTXa2wS3zItECIYTa3WPROMzeKBCby0R72AhxlmRJpnCLup3uFGywCSnEP5xhDHV
         T1oV1o81QKKwhQANWSteTwMnPsbjPrlRdDA5EnIKY9An/jfVjCYFq1xz1qMSits9Afve
         R8xZcKZNlUjN79y5oqRmbweRFU6e3DlHlOVpEr9N81GOWZkoKwPzsHDkKcVexf2g7qFW
         ZlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767520858; x=1768125658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxvq+P5T+UHE6EUP4AwDIrBCHrlsHw1NSZS7vNRvQhw=;
        b=SxdYI3eWDbAtcYwDl0JunncA+8EXD5ID2CGnf3+A4OkOg3ahBhGCoQFVEj5b35YnXD
         BBXcWw9ulFALI9/T7yVaL5AFn67W+2z/9JlIyWoXakzbQ5cwnj1/58NTue00XLdvXF4X
         wzZsUGB/XnmH27awp/pJkNPS1WfBYVPWy/GGyLRBUfeogrcMBpKOjiSDUKpHusjxCpX2
         YicuBNfjMkQKXTnJpBOgwXpAVLcHewfqloebZbjAdhwHBEoNY1wVCbLXzD/kw+8dlnUV
         DoXdrU6jpef0N9Dsbfbpohf57nfu+go/ue8zW+im8cfgCwP+uD/P3T5OYwh9VmVGfTlV
         pabg==
X-Gm-Message-State: AOJu0YwVqj9jGtIyUKY+GcoJL6F3MLoUffN50Ok5k6HjeuDg3rF4jQsl
	jzen/pE7bcBRLT5PrUebtOqFNQl/zkmlGWXNb5ar6JUTKYHfgZoWiZ6A/G6VtTLTL4YqEtWm7hc
	X2QyfbmGLjJJYRVyvvE+49x/r+b32OctAQ6nQpFNWQhRd
X-Gm-Gg: AY/fxX550hl9ijzIsHYdkSaqExO2VyNv8xeJReXDQx5g5v/6a5XQTSGh7ssrf5Oad7s
	gTbxmkOaK0BSpmGdzcWAcrQ2QqrilKb/EKFHe4wNyHfvIUMCzjRnThxeF40F8zb3qo0nUV0auqc
	2XnkRxWt7CjbjtXh+8yWfuIwKKqC7XdugjksfvUHO4KfXSq4Rfwx2WWRsBAJ49pUQKxArtR0i36
	fHOMk0s+amUS4HGDkTscBM1Fj/Wzn/FJonHaThyRmYfv8aN8NdZ2ld7vuk34GMwLKqP3IMs
X-Google-Smtp-Source: AGHT+IFjOat6AafrVh3tFmMh92HqUoeMjpv0YkNMtNnWjJoZ6Gg+MtVdqZFm9Uyc8I1op1qkL/CJjpeX6q+n6WR4TiU=
X-Received: by 2002:a4a:a551:0:b0:659:9a49:8eb0 with SMTP id
 006d021491bc7-65d0eb2ef2emr13926536eaf.52.1767520858269; Sun, 04 Jan 2026
 02:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Fei <feihui.ustc@gmail.com>
Date: Sun, 4 Jan 2026 18:00:47 +0800
X-Gm-Features: AQt7F2o_RWtXnXNA0o8EhGOMpo1RDDWryh6qk04ncBCFrlx5ap8KIL9YTaGy8yE
Message-ID: <CADNPQri-onx+S+PqHKsOJwgwRKT6YBPyBt+U1hkDKgUr=05sPw@mail.gmail.com>
Subject: [BUG] bpf/verifier: kernel crash in is_state_visited() during
 bpf_prog_load (5.4.139 elrepo)
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com, 
	yhs@fb.com, andriin@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi BPF folks,

Sorry, please ignore the previous email. I forgot to disable HTML
formatting. I=E2=80=99m resending the message in plain text.

We hit a kernel crash while loading/using BPF programs. The crash happens i=
n the
BPF verifier path during bpf_prog_load() and takes down the server.

Kernel:
  5.4.139-1.el7.elrepo.x86_64 #1 SMP Sat Aug 7 08:29:46 EDT 2021
  x86_64 GNU/Linux

Hardware:
  KAYTUS KR4276-X2-A0-R0-00, BIOS 06.07.00 (10/14/2024)
  processor : 63
  vendor_id : GenuineIntel
  cpu family : 6
  model : 143
  model name : Intel(R) Xeon(R) Gold 5416S

Workload:
  - BPF is used by: parca-agent which is a profiling tool

Crash / oops (key parts):
  BUG: unable to handle page fault for address: 00000e4900000e48
  #PF: supervisor read access in kernel mode
  RIP: __kmalloc_track_caller+0xa6/0x270
  ...
  Call Trace:
    push_jmp_history.isra.0+0x3e/0x80
    krealloc+0x84/0xb0
    push_jmp_history.isra.0+0x3e/0x80
    is_state_visited+0x48b/0x930
    do_check+0x136/0x15a0
    bpf_check+0x357/0x1440
    bpf_prog_load+0x3fd/0x6f0
    __do_sys_bpf+0x16a/0x11c0
    __x64_sys_bpf+0x1a/0x20
    entry_SYSCALL_64_after_hwframe+0x44/0xa9
  CR2: 00000e4900000e48

Tainted: G        W         5.4.139-1.el7.elrepo.x86_64

We can provide:
  - full dmesg around the crash
  - the BPF program / verifier log (if you tell us which knobs you want)
  - a vmcore if needed

Questions:
  1) Is this a known issue in 5.4.y verifier (is_state_visited /
push_jmp_history)?
  2) What additional info would be most useful to collect (verifier
logs, config,
     reproducer, etc.) to narrow this down?
  3) Any workaround to avoid the crash?

Thanks,
Hui Fei

