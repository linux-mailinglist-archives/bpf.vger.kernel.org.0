Return-Path: <bpf+bounces-75536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D1C87FE1
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 04:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5623F3B5899
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 03:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882DE225416;
	Wed, 26 Nov 2025 03:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixx06dNQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB62C0F76
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129104; cv=none; b=sAtzL9tRA1gb3i/2XQwSfrox7D6EuNJ+BDDzb1MUKe/43P95MS+ne9Vs0KBir4jcXfV/RcruDgMRbLma73cHxc96a29PG6xZdkjI1FQiVap53k4IYaAKRUIH17gYS+6m0JaQrkeoYyNDWGWol3fobgQulLeJuzZs5uajB/Ee6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129104; c=relaxed/simple;
	bh=m1iMt1/FrFb3gShZhl1/pyZdiIkfY8WZcDGft1mTERk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqMtvKJrGCnVkURQY5aCMEgmKyAUUsFfVTxvQ80okyz/do//do+OrHVQRMo26Msc3V5e1cbdQ2kmSIKwvYIflopWXOuhn87Ndjuu3vCIYcRNZ0UtPLcfpGIF/oXa8A4wgM3trSn3E1EhJ2mb0oZaQVA5x1j2GTHFpDJB0QE1dMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixx06dNQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so35200535e9.3
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 19:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764129101; x=1764733901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN0VYJh+0n8miRhPdSjKd1m/lOG9oIZNbyLr3JJfiBE=;
        b=ixx06dNQcW+aOF47nT6FLfrmZD3xPOmd4FZXQ5mgKOuT2OU3ZY4p2cNUq4KNVLBAZp
         YNvap2AHcXzUba55FwWE2DJoBE7xqm+SgrcbfhJGSkL+pVmT5cN631bHnak55rE13mbf
         uXCSAj3fIDEgQu/V1cVePQsB05dHVK/ATSVOI+tr5Hg6WEXZeHmfib9jMqrkJsR9TP4e
         jbLmLeIvy45m259QNwhZ7JkBrOUKGg7L6AjeaMH+ZJqKmkHrHz91ycWu5n9S0Pf996q/
         nj7TB8Au++WLWRZdYwVXZ5YYFelJgfyE72RULmrBn8eT2iEyrWKutJno07DzyNNfWCNM
         NacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764129101; x=1764733901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VN0VYJh+0n8miRhPdSjKd1m/lOG9oIZNbyLr3JJfiBE=;
        b=Vg6XkgJC9Y6DV/jTj4Bej03YJj72l8HN7Insg7GvAsjE4tNnzbzJevnwOzRO67+K8a
         UIs37csmDBlQHyLiq0VeImD0XQZKn6MGvx0qOE/81aGBUPZ4SEhljdZ0zqh950qfPeqe
         RT+y4EdJYy0hRi2voFPBM97VpS2iBXCM/eD4BCbbI4YFexp0OpY9FVA3tFs3QZlhV4/6
         omybufosj7eglptmw4gkGBIgvKEpuENLmkuXjXtCKtOn1zFknzUhuHKmtCCYYo1f8gfF
         b5g/frhMdcW4ucfH5qoBPDqiyG7u4h/Qq9cVbW+/CEbVaTb/4bMPfLAOGyExiyBV9D6V
         U+8w==
X-Gm-Message-State: AOJu0Yw9ROGFmgvoXq5o0xEBe2DfgNFhLQzvv3A00MIkFdyF7xji/RRM
	M0JmCvyXqgIeFMI/EqgHdv0AcV8cP6VShPARZ2dKkkAjA7SBPraEIHJ5YNB755h8FBdSRVCirUT
	sif15zgAeBWZe/qSyAeLEAu/Qh+0dSnc=
X-Gm-Gg: ASbGncvn8aOhpDUA1gcrucTg6IYz9QV8n1dCKy+PXCiltavWmb59FWizaxIonmAYDXY
	lTWPG7/iEHCsQolSm0ySKjnF3ClAhvT9nCxe0IBZYwzNY6OdAYaBNe99lJQLUehEFj27Rn+qr7j
	VEER6NXXrg91Gh7LMMhDMOo5aocJK3Clzo16pa4NYk5Vmu60d+X3yll6sqmyEXCjLlX9noi7q3S
	7ROtVUM2JrKQHEsxGFbU13jbdGfhiSvGknrUyk4ejKNBOvgJIM8WxcK0zrp6uBfh4eBsbiPdLYK
	z3F82Gl1ohV8JpKLizZKhzbqk9pbj3vNj01Mb9o=
X-Google-Smtp-Source: AGHT+IGGNNToRsbEhdIfsK7xyF2SeNs5CYKyls2RAlylOfcYUp+ftk4E0nEeJGVoxRRsnZqAzpTLMaPGxdA+bSRshhc=
X-Received: by 2002:a05:600c:1994:b0:477:5aaa:57a6 with SMTP id
 5b1f17b1804b1-477c016e402mr159060355e9.10.1764129100597; Tue, 25 Nov 2025
 19:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125203253.3287019-1-memxor@gmail.com> <CAADnVQ+HV+p6P8eLFz8Nsp2=apE8KYGAxTY3LJ0vQoy3AV42uw@mail.gmail.com>
In-Reply-To: <CAADnVQ+HV+p6P8eLFz8Nsp2=apE8KYGAxTY3LJ0vQoy3AV42uw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Nov 2025 19:51:29 -0800
X-Gm-Features: AWmQ_bm4soRDBO6ilS7THU7YvZjLdUuprwwkspG-Jgjg3Maznb6e1O5PvRP9Ug0
Message-ID: <CAADnVQ+WrJ3kwccbwMOkuqvFGJKJzGSoHh_46Kgus8PzH+k9vA@mail.gmail.com>
Subject: Re: [PATCH bpf v1] rqspinlock: Enclose lock/unlock within lock entry acquisitions
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>, Jelle van der Beek <jelle@superluminal.eu>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 6:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Overall all makes sense to me, but I thought the patch will fix
> these messages from stress test:
>
> [   12.636716] INFO: NMI handler (perf_event_nmi_handler) took too
> long to run: 12.473 msecs
> [   12.785373] INFO: NMI handler (perf_event_nmi_handler) took too
> long to run: 261.095 msecs
> [   21.455161]    >=3D 251ms: total 5 (normal 0, nmi 5)
>
> but the stats seem to be the same before and after the patch
> when I played with the patch in bpf-next.
>
> I suspect there is more here to discover.

I tried:
        if (unlikely(idx >=3D _Q_MAX_NODES || in_nmi())) {
                lockevent_inc(lock_no_node);
-               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
+               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 16);

and see that it hits 4 sec timeout just as well while
stats show that lock acquisition is unfair:
cpu4: total 20 (normal 13, nmi 7)
cpu5: total 319 (normal 160, nmi 159)
cpu6: total 470 (normal 238, nmi 232)
cpu7: total 25 (normal 13, nmi 12)

which, I think, means that queued_spin_trylock() in nmi
has no chance of competing with queued lock logic.
Other cpus from !in_nmi() ctx keep grabbing and releasing
the same lock multiple times while in_nmi waiting is
hopelessly spinning on trylock.

I think we should consider:
        if (unlikely(idx >=3D _Q_MAX_NODES || in_nmi())) {
                lockevent_inc(lock_no_node);
-               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
+               RES_RESET_TIMEOUT(ts, NSEC_PER_MSEC);

until proper queueing logic is implemented for in_nmi.

