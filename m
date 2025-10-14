Return-Path: <bpf+bounces-70855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08760BD6DE4
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 02:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2EE94E3DA2
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA042957C2;
	Tue, 14 Oct 2025 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeCSFKGw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3228BAB9
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400917; cv=none; b=XfNLjeJddapHWdDKO5WNFanjz56hsSBhTx0w75Z2pV8yMrurhY9L+RNWHljbHlC48dR60Tf8vFIpj7eev9Wjgt1IZT073JTbc4n+dV4W6B6UjtlWFpiKZP6oilnkaNfc3h30x7TpDSv3EgB9A7mWRfhNJu5RAddhwYKv++3YD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400917; c=relaxed/simple;
	bh=vbtIGUm7hDdWO8OPCXJs9MmT4PDfOXY/wBQB8dWOQGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTaJiKqHrORQLQJ+derJ5mzaN6nvRAgXBTwC4gDUsTbq9aNxpxEuGWhKPwKD1k8uyAMN7CwO/5PDOTU0NEtynKccqkPRlwImMtQMEEKXsQpepoaKLd0ovRYZux9PYAWzosUrDIv6571iCPT1UjrUd1Sokvzvv+ybLnxWaTX2iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeCSFKGw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330b4739538so4484643a91.3
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400915; x=1761005715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbtIGUm7hDdWO8OPCXJs9MmT4PDfOXY/wBQB8dWOQGc=;
        b=HeCSFKGwr7E8XCLsM7jqGL0sUNJPfKMJ+gySIOCB2J/36RUowrNa+BlAhRId3/X4Yu
         m+Y/FwbXAp1RI8X8nqranpfLed2kZ5IH8fTU1ML4B/fo59bwwnrDl5aLHSPeSQlhxXQv
         4QxYjzxRfKkU1nHEmzuh0+fbHMLi15dl/YKD7o92zuk76nKvlkVf0ON8+YVysvnQOrhf
         XPnCSsQEnK8lsuT3K5OREbbdZrFsj+SrITDOoEU8RjkhmGQ+a3sEu3gJ0rtHAFmi9Q4D
         mTlk0wahXasBfbKRsjw2FmeimJgIlzcOU1dPcEz0jXFkgFjJuCDZIm7X2z6OzwEwQunw
         Wg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400915; x=1761005715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbtIGUm7hDdWO8OPCXJs9MmT4PDfOXY/wBQB8dWOQGc=;
        b=kjRwP0P4NzbMOx6YCDDnj2WccMftVUvr1rIaOxe4tw8OZSYb57xkkmtoMILCOaOUt0
         F8QbBYN0Wq3lTlTvrbO4wSPp0lr7PJVExki8RxL511ob0jS85ZuUx2rn3cFWwbS7VvfJ
         kv+YsEMuHG8NxTCpGhmVSqficf/XTXE1/z48VHYCX+F2diWNGo31h0WaY39cHw+2HN6h
         OswvdKjzIMx7NmkJD0I7OpDK4xBIoLmeUZIZejMVEvThn6J5T1xauPm13PSviD6Jkavc
         ryvWYA1mtYwL/cqitSLQMMyd+4Nwb4dVKoJGhYlzShfEFn/62N3x2NNWglnJMx+4d3ej
         3cWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZivo4VIa7cuSxM4aubHQGkXCAgoAx6sVDpMJWYWDlxV941cqPbvWThy9eNBgCE/+JtN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQ90fPI6TYlLSKsHDUu2r0gJEfxGTN9BN8QavQr4O437eQMZl
	LsSOV5SMKSxoA8EHjPReAsOIU93nhbpIlzeln04YEUKoYz50jjxEzJvWpIzSw9HwtA7MKE3q2wI
	C+jrvL7Xypxeumj7HwwtBYReF+6SXR98=
X-Gm-Gg: ASbGnctTZpKG5wYmdkQnrqFJDxz027zi4m+aCLb01B+ZDO425cvJdZtgGgm62iv9FDv
	oVVlU5VTjmTFyOB+qYon/SyRzeT2mEMkJMI9L7bsG0xgU27ZyDwddIMK/3kHauGPLTyysSbEp+T
	PGFYc5tJaLpbfepCzw/lXNKEI8BaQTJduS1Y5woiGIuA63uwXo2ulpHw79PwO4HVMInMQbhYe7S
	ivBaGyfS6TrYhK1xbSyUPNP9dV6oDNMBpfNGOVnuQ==
X-Google-Smtp-Source: AGHT+IHARnLdlryg1PhvKDEi7oBisiWZjKWZuSu8vpVm+0nfd2Qp81tXbKk1PVPW5Er2+jS8pPs2aKsNpGBsv4cI6g0=
X-Received: by 2002:a17:90b:4a52:b0:332:84c1:31de with SMTP id
 98e67ed59e1d1-33b513ced6emr28797119a91.25.1760400915524; Mon, 13 Oct 2025
 17:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com> <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
In-Reply-To: <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 17:15:00 -0700
X-Gm-Features: AS18NWC8zop_0pqhOu3uFzZiyqIm33mL5cLx3lr7v0iVW2czeb3AtY-0ka9aqwc
Message-ID: <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Just a few observations (if we decide to do the sorting of BTF by name
> > in the kernel):
>
> iirc we discussed it in the past and decided to do sorting in pahole
> and let the kernel verify whether it's sorted or not.
> Then no extra memory is needed.
> Or was that idea discarded for some reason?

Don't really remember at this point, tbh. Pre-sorting should work
(though I'd argue that then we should only sort by name to make this
sorting universally useful, doing linear search over kinds is fast,
IMO). Pre-sorting won't work for program BTFs, don't know how
important that is. This indexing on demand approach would be
universal. =C2=AF\_(=E3=83=84)_/=C2=AF

Overall, paying 300KB for sorted index for vmlinux BTF for cases where
we repeatedly need this seems ok to me, tbh.

