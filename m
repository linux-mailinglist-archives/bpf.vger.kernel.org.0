Return-Path: <bpf+bounces-46795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1A99F013C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38D5162A23
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095AC610C;
	Fri, 13 Dec 2024 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt64ScMB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D010F9;
	Fri, 13 Dec 2024 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050734; cv=none; b=e3X8rt7t8+gC/AgXb0iy2qq4Q9QuVkEINHfrq+RF8vE3PTE0yPouJW5vnSsRodDVcjGKxRnHOVctAhul6XszTpXC6dB3/zdpnNF6Ygm8gKgA4DdfZcTxrRjFPQME6YNRzSnfJDtCsUQ1PkMGhCyrOqlEFu1deSFPAtgLeH9fvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050734; c=relaxed/simple;
	bh=zcG9KwuEdRhQdYRRkMFCbtKOoh1Xb1iDnjaoWY0LEU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jki9DeaDFVzvrDTR6ea6ATbbBUQeBMYLbBaELMeGKAjgzWNJrl4jNr5G5nTVCVRGKmLNFZLD9iLcrWyRIWo7pusQVYC/M/KmzmSZKCOXpuijmETfWM8yRl3EAxdVPgPU/alZCQfJpIS638vc4WybKU5q9XBeRzZsfibuVXWkydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt64ScMB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so827329a91.2;
        Thu, 12 Dec 2024 16:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734050732; x=1734655532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpl/wBRIsI5lYcdmv7L+1k5aJgGHeKn5KKHHv/EPRZc=;
        b=jt64ScMBKApIJxUsQUgDgFBIY943mGGkEFZKT3vlB67OOl0eeH3CIOAM9EZ0jG7+Vr
         2AZV/onHc1HFcSQFv/eptfSS3ArmzyxCKSXy0i5moLdnf+5/Qy/LCBGuQ6ikxAme6oZL
         3YVs1y0gOPUGcIkc8j2rJNVDWXSseXV2bw4Qk5gLytyk/zBXXpuXjo/ggNfYSXRcRv6U
         NJ8DMNcBndY1GIzMm3wJQSym9DN6qb4qhvFqt2q5RjaY6DnkTty64qMa4EvX/PSp882T
         UE1eQ2HYlyUOgAQUp7U14Jpb9GKy4J/w14aT2vc8xwSzcc3l5j4Cdmi9rLroKmQ+oyT3
         h/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050732; x=1734655532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpl/wBRIsI5lYcdmv7L+1k5aJgGHeKn5KKHHv/EPRZc=;
        b=N0552VI86NTUvrdfhzp+ebNcizJy6OytL1eaSB1IIWNMGzAP62ohNBSV7xe+xwZz1I
         XlDVjxiGfxwjDFVXpdTdSRAorxrIBa2DQo2C7ykw1P2kY88R9L50F44MG7E60rdhIJc/
         XWuw3y9VLOmdmoOi/lVqoG1leMdpkf51irfBHdr/5NR1DjzOeivMV4U8e4ox+zeqyWKq
         TAh9MhlHvZRt3EOI7EP+/g0HhfqT4HCbodJgGuBS9Bx+KNRnSZhdKG71/MhxlCiTyMSA
         upuFJ17JPoEVWjYi4OV0IQKKcOLY8R89AZ17N0/NrM7w5k8rWf1XCJZ+rpXuKRfA6rQR
         NuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVp/8ue1i9T9of/nePw1q9ZOZfpP6p5oUuTDgqUHCtT5THdB6ZAw/IdbmPpPs8Em0WuqFvTUwkwc+9DeJiIiNu6O18@vger.kernel.org, AJvYcCUeWfsFjdqMp3Yi6/Nn6qjIc6aXfCKJ9RYWyE4zQcfSFwHet/oKEZsK88W4+xDLRYhUOfEgzHCWGa97xZVk@vger.kernel.org, AJvYcCXwMebJU6oeBZpCwj+t0DIANgyHAqMb1jt2YiwxIJb9kgANeVah3Ig9riZHXcxFmpj+FpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7Si19FK1lEBMp5s8bfz5kHxn5ls5pe67jT/cNVj4ifWd6rTh
	GK11zqjzblXRqG+5y3VfmC+eglnvqXG2rugWz1l5UekqmEcEcRfykSyalgeTi1WKM3GukXq5dbH
	OOVpZugJX5xqjsPyt6ook/J02yaw=
X-Gm-Gg: ASbGncuzyvSB01YqWVwKOG47QFFKOhjMXRupriQi9knL8DxRganaYplH74MUduM3g5H
	+sWgnRPUdYjkw+vMP1VVxFeS1qAn0xJgaK6x3/rashtxfFA6ZK/5KSA==
X-Google-Smtp-Source: AGHT+IFTscyzczGee8BvvNE8iF2eDsKNdb/LXDFgpd8TYj/VntFMEATKE90ADcaPw32QtiyOt0yWp6YdykTxoCxa2bE=
X-Received: by 2002:a17:90b:314b:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-2f28fd6c7cdmr1122930a91.19.1734050732194; Thu, 12 Dec 2024
 16:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-4-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 16:45:20 -0800
Message-ID: <CAEf4BzZ4uN-budb8TAZM0HEQ45Cpof=pdGPeRcBiFVr1A+U=mg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/13] uprobes: Add nbytes argument to uprobe_write_opcode
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding nbytes argument to uprobe_write_opcode as preparation
> fo writing longer instructions in following changes.

typo: for

lgtm overall

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  3 ++-
>  kernel/events/uprobes.c | 14 ++++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
>

[...]

