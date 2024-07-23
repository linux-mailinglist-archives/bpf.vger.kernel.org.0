Return-Path: <bpf+bounces-35332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D8293981A
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BA21F221E6
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A170613A24E;
	Tue, 23 Jul 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTMGJpCE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7AEC2
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699934; cv=none; b=matwFS7iUnGgsM4/mLtSu1lGe5CLLwJvGJ6ga6jQ4dA1JjrWmSzk1uqe09RAP/5ZJc42IiRwBO4u5ITaGeRHfyIsA3RuspvVSvfPbHrwZFSZJv7TcRDeczsM5+q7GH8CuI6IGCFE5xjSKnfeqM8dHHX1oNWLPlgyJ53LK3fz8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699934; c=relaxed/simple;
	bh=vBOmrOFNTsO89A8chxNl8U9BJsaL2YyB64Q4qYYlNew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ta7b0APUsnb2ZupnSA+Nd32/AVv0bBJ/G0LUqTZcTlb42m9zpm8lVz9rJeU2Qf4JzVjGxD26ERL3kUIVdwf8fR+ZBvxHSQmRFWDLodJRC250sKBcty2Oi+pvTO++r+g2k8aGWKUu2nDv3DimaJwnI09ClyGf1RB/Kx5vxUB5eZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTMGJpCE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3684bea9728so2815419f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721699931; x=1722304731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxbnbrU+o36sUwqRiz/zvNR0FF/k2vVjIhpbaQqTKCI=;
        b=CTMGJpCEmhyRT8CExxXq2zJ6wVpOrkXLTtyruhOO8uylL/wpxPwJO+8sV33pnhJZNH
         4bryes2hMhv2G1RaMe26+W1/oFe+Heu6X+2EiwThS0HLWAylOkn/Rp7eWFqHRRWZqe/6
         ba0pcisja0VaJ/UlwLNfpIq9J/43a5kkr4L3/Nu1QIHfprCdTdcXTDoSy+zkxnC9naPf
         1FP/Bojkv6j6/TYV8pi/7Ys8Z3PMFUDZFzF6Shz/aV+71llk8Nsiw9p4JrAgkw6qtlan
         B19vaFYfPGCqWcF68NBPtnmyyHLNB/1etvFtzR3Gxia7N9dfDNP9GtUpKBKNTg1qfWQ8
         jbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721699931; x=1722304731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxbnbrU+o36sUwqRiz/zvNR0FF/k2vVjIhpbaQqTKCI=;
        b=Yp0ydn9aMfOiOjMnsh29JVuPfIVnvtQUXjfr9Nm64AAgAPFL1RAHymYzDuFeGGqoxk
         w2/uwJN6A/Vsy606gvWo3EhJLq8eD2TlqvunpL0rUQM0nuA7hy5mpx138x5N+GhdAehq
         PL3I2zd8qPKhjruZ05/hyJYegWsrN97Bu0CW7/rFv7eXg7A7lQRGsc4VgxCSWPNf/F8Q
         GCgi/BM3OqoEsw6q+1fIg/nck4A1kcUDiqEEeO/x050EqIUWJDZcoF4F5dKS5gQoBXLm
         2fh8XrvzfVUI6lsfeOiuF2sw6UD5v1iEF9oTwvWldZFNw0Ipv4YXuCU+0Hfnx0Xpaa5D
         eejg==
X-Gm-Message-State: AOJu0YzcXPFqBSNZXWUKf0k/LieXOFOegwCACYKjr8bG7iWTK2jhKfqA
	Ad0+CQWNGatnsIhZMKEJ/6gkBuXN+mQYYBMo7SWyCKrmsmbJlHfStUyzXlhgodIpkdt6mgExabX
	7QTqaqxtgLGqAzgFkOBUBSpqX8LA=
X-Google-Smtp-Source: AGHT+IEgct7rwSE811Q/Ocr66VYoBldz5UGmiPwW1RKEydrMH3EPBKE7O6p5W+U685g9kIOKJTvQPFp/DR2HPtG+Q1o=
X-Received: by 2002:adf:f98c:0:b0:367:8ff0:e022 with SMTP id
 ffacd0b85a97d-369dee5971amr889377f8f.63.1721699930652; Mon, 22 Jul 2024
 18:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718050223.3543253-1-yonghong.song@linux.dev>
In-Reply-To: <20240718050223.3543253-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 18:58:39 -0700
Message-ID: <CAADnVQK3JhpQZ4Fv3xw9k74Ytkffv9b6jTH0_DBfxT1cPawkUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fail verification for sign-extension
 of packet data/data_end/data_meta
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 10:02=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8da132a1ef28..3a04eab7a962 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5587,11 +5587,12 @@ static int check_packet_access(struct bpf_verifie=
r_env *env, u32 regno, int off,
>  /* check access to 'struct bpf_context' fields.  Supports fixed offsets =
only */
>  static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
int off, int size,
>                             enum bpf_access_type t, enum bpf_reg_type *re=
g_type,
> -                           struct btf **btf, u32 *btf_id)
> +                           struct btf **btf, u32 *btf_id, bool is_ldsx)

There is a conflict now:
  static int check_ctx_access(struct bpf_verifier_env *env, int
insn_idx, int off, int size,
                            enum bpf_access_type t, enum bpf_reg_type *reg_=
type,
++<<<<<<< HEAD
 +                          struct btf **btf, u32 *btf_id, bool *is_retval)
++=3D=3D=3D=3D=3D=3D=3D
+                           struct btf **btf, u32 *btf_id, bool is_ldsx)
++>>>>>>> bpf: Fail verification for sign-extension of packet
data/data_end/data_meta

Pls respin.

pw-bot: cr

