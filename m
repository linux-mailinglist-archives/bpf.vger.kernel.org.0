Return-Path: <bpf+bounces-35424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C493A80B
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B60B22052
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040B14264A;
	Tue, 23 Jul 2024 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4/wGO/Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605713D622
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766205; cv=none; b=St4HzRJodbaimQs0+1D/BT4n6PSF77iHWlUBgYCv8gtjNLAFB3wE7bmNioz+2PUdbr+7lEbM19NxukBCcCv4XeGgvy8knjJVIl63+XfPHwiPHIkV14QpzwpQ07d7aMAYj5qmTSul0FP/axiW5vZo70xwMAr8g4VnuBDRTdAg3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766205; c=relaxed/simple;
	bh=00AB/39N3va5OYIFh8nxb6ODy/s07sSVuZCI/nT3wv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOYamoPDfNwJZJYVArcsULz82lQ6vFQdDh89DqQtwdId+41jmMRkYigbtOkS7oPqncC9Z3vv9PbdyeDgTP7tC8cFAyfgJVW1hk4kxS4DLqzjEH17XZJ35V9NE4RL7lCrvFuUpVCcVaRAhjK4x0tFie2joJMmGhdVfuDqVvXwMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4/wGO/Z; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e7b121be30so710070a12.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721766203; x=1722371003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPP4KblZAXLH60fdRxnknii0DEiVmjB7BexDZPNYTFU=;
        b=a4/wGO/ZDxaOj1ArfJj0PbyBRDpcQIkseBfBD0ulW9qcDhUiwWQ1ncqE1ylbuEPyF+
         V7NhsRzJSJf/LL10iwOezJvf9WERLg3kGK911QpNtyts+TMgSTJfHH2cbrTCRpleVvTU
         +yn/pJbMdik9sCAphB/mPmuRFIWt64LKh83G0Sh+pke00essmbR027HHirUjDoRybaFl
         d+NwjwIyt0CbJfP/BgXhe2G4XDTQxX0Oe66a/YK2hhLJzubDg9FAUnH21S0m7kiBH7yv
         IIewVR3oO61r10A4SQkpzlipd8Vpea7VvJAAEUx46TbrAeTF47sEvKxYKncPgHNeOEl3
         OjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721766203; x=1722371003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPP4KblZAXLH60fdRxnknii0DEiVmjB7BexDZPNYTFU=;
        b=DgvXeDJ8zg/HEyu7MIxNCnZ8WefQWDgwlOpAzhj3rOTsv2DIjRJ1wPuMTfaIl8uMik
         YPg93JpnlY6WHyRtgJf/g2VIeyTw15vHqs7jVfZ0g2MacDviU06JPSwvPAK9q0TW69dj
         qBkg3Ox0Qv8yJGESduVQ16x96pNzL05pL0RrO/2tZIRqCccQ/DJitHGyvn0UAeYYBFV3
         OA1rLO9+Bu3x/nue1L3FQJrjX7H1fCJ2OdLY0JCoS7tB/6M2eJEPr+//lir8p1xT/ImD
         Vu7aDfcoSB9FkOcP+Zf48TPl6KRLRNZkvR+U/8w8/07q8xVkwffxwhNB9AV2Kzd7VWfe
         HsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK69OR/j0KsUnZogiX4YcUVkVVNqTCddRVv5P+/hUFkATHFkgVy7/DDgdmzmDnZGFmIhc5zc4nPjYyMTxSYpWYObvO
X-Gm-Message-State: AOJu0YxNb15vUMtTSn8HliW4Xv6JJNOp4l6uCu71QRmyQBPq4AjxkjEi
	GZ1OwtCBkTYXREYyXxu6ijI6zuo5SXuwsmf5m756VXpSPrRQvrabe1RyUWDAOiJbJw/l8nspGxF
	Q+SFTEfzUuLf6NbDxOElWGmLnsLs=
X-Google-Smtp-Source: AGHT+IEM4TaQaIh6EsNtAeLU1Nb1H+pzQCPXig0KIpebZkwxnnenAW4ag+15773tJCk8QVg4GOdljQQdkpN+T+cIM5s=
X-Received: by 2002:a17:90b:364c:b0:2c9:64fb:1c7e with SMTP id
 98e67ed59e1d1-2cdb514ab36mr171244a91.14.1721766203450; Tue, 23 Jul 2024
 13:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722202758.3889061-1-jolsa@kernel.org> <20240722202758.3889061-3-jolsa@kernel.org>
In-Reply-To: <20240722202758.3889061-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jul 2024 13:23:11 -0700
Message-ID: <CAEf4Bza0Nb=q41nNm+64MFxH+Y0xjAZwmef9nhM1G2yUH9o_Gw@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 2/2] selftests/bpf: Add uprobe multi consumers test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 1:28=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that attaches/detaches multiple consumers on
> single uprobe and verifies all were hit as expected.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 213 ++++++++++++++++++
>  .../bpf/progs/uprobe_multi_consumers.c        |  39 ++++
>  2 files changed, 252 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consum=
ers.c
>

[...]

> +               } else {
> +                       /*
> +                        * uprobe return is tricky ;-)
> +                        *
> +                        * to trigger uretprobe consumer, the uretprobe n=
eeds to be installed,
> +                        * which means one of the 'return' uprobes was al=
ive when probe was hit:
> +                        *
> +                        *   idxs: 2/3 uprobe return in 'installed' mask
> +                        *
> +                        * in addition if 'after' state removes everythin=
g that was installed in
> +                        * 'before' state, then uprobe kernel object goes=
 away and return uprobe
> +                        * is not installed and we won't hit it even if i=
t's in 'after' state.
> +                        */
> +                       unsigned long had_uretprobes  =3D before & 0b1100=
; // is uretprobe installed
> +                       unsigned long probe_preserved =3D before & after;=
  // did uprobe go away

fixed C++-style comments, pushed to bpf-next


> +
> +                       if (had_uretprobes && probe_preserved && test_bit=
(idx, after))
> +                               val++;
> +                       fmt =3D "idx 2/3: uretprobe";
> +               }
> +
> +               ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt);
> +               skel->bss->uprobe_result[idx] =3D 0;
> +       }
> +
> +cleanup:
> +       for (idx =3D 0; idx < 4; idx++)
> +               uprobe_detach(skel, idx);
> +}

[...]

