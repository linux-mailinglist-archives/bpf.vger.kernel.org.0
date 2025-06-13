Return-Path: <bpf+bounces-60568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AE7AD80F5
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02813B8217
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE4A221F06;
	Fri, 13 Jun 2025 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqH3+OQj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9E221727
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781528; cv=none; b=oXopuOFAAg90ptcnshS4nRN3gPIAWLMLmjQJ94c2JM+Tgr7BAwaWLHjaNBGcis7hy0nPtBEt40q+JDehZ4gnohnjBHgCl4ow0dF4vGXBZ9MzcwLEaqyBxzSIbUGLQdxIC7Q9x65yGSgE5n+5PHcTVma2MV0srcS1NfsRLxTQZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781528; c=relaxed/simple;
	bh=/CCRZ99z7gxF0fs2i8rxITmZmzhvjULnq3osWcZcCDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCkAJnwNsBBM8TETAWQy1c9D6mB/AZxBR3wcwMUC8QiR1oTjUmcbvqi86SnC0onY8U0+kK84mmIuYT2eIb8tETEAdKy4Xd23hzTqrhaNM87Nt1kJY3icebkSfcmAPHJJffofIVt5LmcIRxm/tzbWQJ5+53dlpHWKeVBDLzIsQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqH3+OQj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450ce671a08so9632785e9.3
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749781525; x=1750386325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ncZjjg4Ozbomfdi/Og4XXbudxd7GlqKH0y5Vd71SUg=;
        b=QqH3+OQjoBIZTyGQjjyJ9fRoiOIKFtAF6IZX7b+yBBEkEcFIsKhq81LMIR/cOjqAva
         f90NJZnmoFWzU9DIVJiNfN1FbPxXb3UWM103q8VxyuXIapIncMQ2Uc7FG59lHmWE1Z5R
         LWlSTdR/XDgLwh/MC2n5NTdZEEU7214NXE/2cWFZzvWLEoVbCD54hfLt9DUXZcSy2r1u
         JgdxL2CZrIHrZJMTIpI2AHDA9ROmp1Kq2MrQ2vMuP1bRlvBPxR2iZVDctM3vF2nYe0WE
         L5bgnopGaPDpHVHWvmZmhshlSa1MrPPsT/2Pt43tpLKQbVN0XtiwCTvr4fzOTjulVqkV
         Caig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749781525; x=1750386325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ncZjjg4Ozbomfdi/Og4XXbudxd7GlqKH0y5Vd71SUg=;
        b=MX6GA9GbSm6X7frXUJdzhdFPQ9RGAW4tXIl3tNNAVVGo2msz4v3WW2ywFTKR6OgiAF
         b2c/qWOMAM0kFuio/OJah6q/xBSk8fWcvburPL8a5kO5vSP+fZ+6b+r9IgrTo5+DDlbo
         Z429NxH4a8IUmPMr0FKUoreV9FFA9KzAAtXaR/RTY03m+J7YKAkYJxO7sdf3xwP9jAQt
         gFQ3w4aWelBhhBlBaVUa2MkLyuaZRJi4lYmMuKho5pj1x0w0LoxOAVMwS9Qya40PVCKt
         Lx43S136Do9XbNn5KPM1P/IZ2UcFfpZbJTYCcwzSr0Gj3Gqc1KtCgCLCX6EV7ieDynRX
         cCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJleT/z66NPl2qHVKGnXmmsBlUmEsKyhcymSO+8pf4a84ftoTP0jdeOl4WA5kguDFDQ9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7jtKz25/lYCwnK+UV92lzOa6kZyn8oZOft3N6KqvGGSNd3hUD
	gtdczn+niwUjMkAYCnsUZKS6fpUhkMBomYFejAiahs7tVb33lyZhQ5mDczfaklyRouj3sLiomKF
	xLDCfHAhWYBmGXj003DHTtsXxo5y+j4s=
X-Gm-Gg: ASbGncuAzvXAHotwGrAnAnDG0j5qw2Po8eDqgCFfgciVwiXQ8L/ofVBE3TvoldsAStL
	WmEo8P666xqitdBdlre7B24oAV3ctublg0oKaR6wBmtfICwwQBEO/3v2BWVMyRZxKSS2bmhJ+UQ
	dYhEV7G/WnVoHRR0LGjb1JvOCPwHjulgaEBmpbxwy3csj7jHmg3wYtX5eBiSIDODfj7CokYBRx
X-Google-Smtp-Source: AGHT+IGaPYEFKBYEreLtrwzisV4VDssYisLz9NPbVpr+GBPQchE4qR1wU7pLzxPu/A3YI9z4YAaWHwl86Mbm4i98j4M=
X-Received: by 2002:a05:600c:45cf:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-45334af6449mr10589605e9.29.1749781525025; Thu, 12 Jun 2025
 19:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612130835.2478649-1-eddyz87@gmail.com> <20250612130835.2478649-2-eddyz87@gmail.com>
 <CAEf4BzawQqu0z8Kq2MRpByPByw52Dq8NtNQnnQy1Mv_YVv4h4Q@mail.gmail.com>
 <1cd8ae804ef6c4b3682e040afea7554cb3bde2f8.camel@gmail.com>
 <CAEf4BzbSy_imqzs3Z+GAb1iA1WKs+vDkO1Q6pDmd3zzL-Ttzdg@mail.gmail.com>
 <CAADnVQJxQMEdbdTrDSZyb+SWxdwjJYWx6F6jmkff=OAeEoSTPQ@mail.gmail.com> <60dc085263d7d746f5c223f8df85f55679786c7f.camel@gmail.com>
In-Reply-To: <60dc085263d7d746f5c223f8df85f55679786c7f.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Jun 2025 19:25:13 -0700
X-Gm-Features: AX0GCFuSFUBD0uNnFkoGcUjXrqe_uHj_wVCHOBQJGT90PDbgE11dGdGvOm9qXCI
Message-ID: <CAADnVQ+NMO2_fGE8XevgFVFgSCSYU14RrqDhtbwF-zZuzn8Ebg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: include verifier memory allocations
 in memcg statistics
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
>
> File                     Program                         Peak memory (MiB=
)
> -----------------------  ------------------------------  ----------------=
-
> pyperf600.bpf.o          on_event                                      26=
7
> pyperf180.bpf.o          on_event                                      21=
3
> strobemeta.bpf.o         on_event                                      19=
9
> verifier_loops1.bpf.o    loop_after_a_conditional_jump                 12=
8

This one caught my attention.
We have few other tests that reach 1M insns,
but I think they don't consume so much memory.
What happened with this one?

__naked void loop_after_a_conditional_jump(void)
{
        asm volatile ("                                 \
        r0 =3D 5;                                         \
        if r0 < 4 goto l0_%=3D;                           \
l1_%=3D:  r0 +=3D 1;                                        \
        goto l1_%=3D;                                     \
l0_%=3D:  exit;                                           \
"       ::: __clobber_all);
}

I suspect we accumulate states here and st->miss_cnt logic
either doesn't kick in or maybe_free_verifier_state() checks
don't let states be freed ?

