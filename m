Return-Path: <bpf+bounces-75517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E004C8787D
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A98B4EB4E7
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120E02F28E5;
	Tue, 25 Nov 2025 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvxsyoBO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA325B311
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114870; cv=none; b=A1R2YJzxgH04kSFs41Kxgzy9xHecN0wdEd2+ZVCXUp6o7L1SjerXAtsUWDApG1qYG7383a57nY7pt9wCgGPK1dOKEFwued1HtOzgJBWf/+2cPIOlU+yTnC7+NMGDAE3SGK6MxSXv1Q0Zbtgum+/JE+X0Xo8Ew8OtXfZk9nFVgSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114870; c=relaxed/simple;
	bh=W+U+0BaeK9ffOm8ROpFp3LMrGxOmROwhfa5rx3TX9II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba7/FJM2pGqacn8aZU4YBS0UNsKJelyExMogAUvLmOnIRD6tDOd68XdzEwa/IKJwjPznzBVKtD0lnET5OvzfGYHdWiuKckysowhUS1CxAblytm1b/OulTydZjUHS1Gdw7hxsicbLHEMNJowfxpuPbHZgygBbfQebxwRLkuzKwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvxsyoBO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so6426671a91.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114868; x=1764719668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZpq4xpUxpvL6e+Vla1vMOOFNlf33LepiFdLqiItueI=;
        b=VvxsyoBOfjaTLEQnlvQa50byZLOAC0pAasqiJi8yD5GGATYqSzZsvRbZKZ+j2Pwlys
         GUst7QcOGZY/MisHv3sIqNI7qUq9dRwv/95A5VLsRqk9KRyD0t07XeQn6CaBuKL8C+EC
         55XML96hX9fGTf0x8hMeo++b8JdtXY2e7V98DGCB3gmpkSIaq0vq9laL8XYddW1Q8zIe
         LhyEwJzCFN85H8hj+mC3UnEnXvfYwEG6Krd83AQMLR+EwC2VCD6On6sAceYG21alMtuM
         bg8LalFsGpsGAr+/1mmmh8OV2eWcPUB56bzGno7LTrqGbuF2Lw5R7QW27mITsdiDDFpF
         7r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114868; x=1764719668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZpq4xpUxpvL6e+Vla1vMOOFNlf33LepiFdLqiItueI=;
        b=jPF1DMVH07jUfNmZFH7E01K/YwXqWWWLZlv0liY3nm1PD76jfy0AzCDX/JTCflM05T
         V+jupJa0J3KlHSXeGY+xv37fS5uD36KQ+yKI0OllB5v4Pc/j9lw7gXksV5fPzRJvDQAK
         QbCnNqg3swJigBPYCgT2+cmEoH0rC2Y92uGTwS1TQDWoWFvCkyH0Rz6/rb0F+pPKvaCL
         iBar9YahPrG+UDf9nZJ9egkK6k9ItxFg+q4MoLfmjX/zFh8lmueEbIucXWVHSYPNwR89
         CLKUMPBW3q0j56auuAylXI5OvvXlUopaMO2cvdwxAeDro6fHadBYmtY8TI7UAe7hBIkz
         Oaaw==
X-Gm-Message-State: AOJu0YwifJtmfv4k9sVpwrIqYJfzhmxIR/bTb977Xu55xtqDPrGFXiIt
	lnI5+gchrkKgONOIrd1e8hPQ2F66J5WOJ1r0qFt22jZ8E5J3icwNbPf2zu02hWrCh8AFZOEs2QT
	8r4I3PILNMTLiPv2YRELoJ6UcqSVqpXs=
X-Gm-Gg: ASbGncu9MD1cC37bIa9j9zv3CiDw7rLEOI0SU3Pi+P00Qh6B9SaXSVZMWm8OpJp626g
	KL508cYyMN5fySJYvfcSiqRev/MR1cO6Yi48w/Sk2BPAR2zTxIcHQonH+ccXCAa6GSNXl0O2JpM
	iVTxxC+k143DtIXHy+xD6my4xQDEHvsy3cw2joH9K90Bc9XCsSyN5wGLJbDAvyg/Vr+6tFPahfk
	mQMRHAVirCEa8dmhcaSwMAS4kW/eka3jXOivLa1nQjZeiYDYz6CBg3Rqy3C4Pil5aEB69m6YlI0
	SyeYyirGxpn9OgA1KZABIg==
X-Google-Smtp-Source: AGHT+IEg9PsfqVp7jP26YRVgq1kQLfalnlhyJlYUGo7Igvj32E2SFPIwo3ye16EiJ0LMrUlmh0BZ/1e51LxX/9tTBR8=
X-Received: by 2002:a17:90b:2c86:b0:340:54a1:d6fe with SMTP id
 98e67ed59e1d1-34733e60868mr16762780a91.15.1764114868426; Tue, 25 Nov 2025
 15:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-3-ameryhung@gmail.com>
In-Reply-To: <20251121231352.4032020-3-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 15:54:16 -0800
X-Gm-Features: AWmQ_bna2XyFfkWnxTEA7MX_FwRcUwdAzEYeTRf80HWJjECU5bmh6xmjUb52FTM
Message-ID: <CAEf4Bzb0Lqthpnhp+O8gGENVUsd78oiQcRTQx-TudbpWPZTxAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/6] bpf: Support associating BPF program with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
> a BPF program with a struct_ops map. This command takes a file
> descriptor of a struct_ops map and a BPF program and set
> prog->aux->st_ops_assoc to the kdata of the struct_ops map.
>
> The command does not accept a struct_ops program nor a non-struct_ops
> map. Programs of a struct_ops map is automatically associated with the
> map during map update. If a program is shared between two struct_ops
> maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
> associated struct_ops is ambiguous. The pointer, once poisoned, cannot
> be reset since we have lost track of associated struct_ops. For other
> program types, the associated struct_ops map, once set, cannot be
> changed later. This restriction may be lifted in the future if there is
> a use case.
>
> A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
> the associated struct_ops pointer. The returned pointer, if not NULL, is
> guaranteed to be valid and point to a fully updated struct_ops struct.
> For struct_ops program reused in multiple struct_ops map, the return
> will be NULL.
>
> prog->aux->st_ops_assoc is protected by bumping the refcount for
> non-struct_ops programs and RCU for struct_ops programs. Since it would
> be inefficient to track programs associated with a struct_ops map, every
> non-struct_ops program will bump the refcount of the map to make sure
> st_ops_assoc stays valid. For a struct_ops program, it is protected by
> RCU as map_free will wait for an RCU grace period before disassociating
> the program with the map. The helper must be called in BPF program
> context or RCU read-side critical section.
>
> struct_ops implementers should note that the struct_ops returned may not
> be initialized nor attached yet. The struct_ops implementer will be
> responsible for tracking and checking the state of the associated
> struct_ops map if the use case expects an initialized or attached
> struct_ops.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf.h            | 16 +++++++
>  include/uapi/linux/bpf.h       | 17 +++++++
>  kernel/bpf/bpf_struct_ops.c    | 88 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/core.c              |  3 ++
>  kernel/bpf/syscall.c           | 46 ++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 17 +++++++
>  6 files changed, 187 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

