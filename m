Return-Path: <bpf+bounces-13680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E37DC659
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58F8B21086
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55603101ED;
	Tue, 31 Oct 2023 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W978X5K4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFD101E1
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:16:40 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E03127
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:16:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-540105dea92so8067633a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732997; x=1699337797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mgu/8gdvXyguahCyj+3Q67wXWj9HYumf2LnRdg7Kbvc=;
        b=W978X5K4Ceg2ngVhnqFoBPRkdt7PFoHDpHCvodXgUqkQtW3djMQJZ/psRRelbPq5sO
         kDubJCgFaqoQW6IWNCZQrGbX4W23LsKKJjTsq1shadLubbBoKyApD/xzmfK0spbPs/L9
         aY/vPyHp7q/aTzfI8/0NAZebyYIK5wQ+zB+KK627cLLvfFuC5KV84zeYOTXs67pCpWG3
         YU0vSFN8TzkDJAcPCNgZFI/iJngm1fneKDXDCPgB0eEDu+JPxQwzrl+Ak2Q9bsGnOY3+
         Ui/Lnz1KEUrb8RLtq4sR7kVmzlYaGs5CEDFbGZu1DeT4zm8rO9FsTcd96+iK1gXImhzh
         xQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732997; x=1699337797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mgu/8gdvXyguahCyj+3Q67wXWj9HYumf2LnRdg7Kbvc=;
        b=VesnOlfYf8mxQOBhAIts5m27Xp7baXnzdJT79b7lK6e94arnUPTf53M6Xq7Rb5reMw
         2Uf2SEDTC12r4Xhl5F79H4ntUh+5yxQwLlxR8diB6nC7xAM0O6I74j6g0/I8oRgwCMec
         H7EmC0qOwCuyZzsGBl8k4u3VKdrHhef4R0qgyATnnU1xVB65Yl++Sdr6BdIga9pZ0i+6
         QxneM2QiFv+b9d4tKMLNRVx/rkkYgxIAs+oCWWp3f1NF1KuilmPLuuAFMIvxD/QMhY+I
         ZMfdx4BmqjQhBZ2bwaTy/eWs3uhGivO0ABHfCKgRtVV8jRCX3D3ZKVpE9TsZUcmTU1V5
         82sw==
X-Gm-Message-State: AOJu0YypWfde6lMGDpdqWu213eWHWxhHRyhVBBEkboCWtd8+aPWOZZoA
	A6t8vMQcIX3UlZjeulPf0ip/iWH99x8YhlzfQ3s=
X-Google-Smtp-Source: AGHT+IGh/ApQOJ3ODODI4RiTpID2ej/cVj57ZX2OCTsj+4APeJpGT2znAJwfuFhb0R/eMmpTXGu94hHOw6/fIN9I9bM=
X-Received: by 2002:a17:906:daca:b0:9ae:3d17:d5d0 with SMTP id
 xi10-20020a170906daca00b009ae3d17d5d0mr10331469ejb.31.1698732996688; Mon, 30
 Oct 2023 23:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-21-andrii@kernel.org>
 <20231031022033.536yvwc5vcc4toh2@MacBook-Pro-49.local>
In-Reply-To: <20231031022033.536yvwc5vcc4toh2@MacBook-Pro-49.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 23:16:25 -0700
Message-ID: <CAEf4BzZC3NYUZu2uK+Mi3GgMrLOqe=ShXpkQpor-dLZxbjM-Tw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 20/23] bpf: enhance BPF_JEQ/BPF_JNE
 is_branch_taken logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 7:20=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 27, 2023 at 11:13:43AM -0700, Andrii Nakryiko wrote:
> > Use 32-bit subranges to prune some 64-bit BPF_JEQ/BPF_JNE conditions
> > that otherwise would be "inconclusive" (i.e., is_branch_taken() would
> > return -1). This can happen, for example, when registers are initialize=
d
> > as 64-bit u64/s64, then compared for inequality as 32-bit subregisters,
> > and then followed by 64-bit equality/inequality check. That 32-bit
> > inequality can establish some pattern for lower 32 bits of a register
> > (e.g., s< 0 condition determines whether the bit #31 is zero or not),
> > while overall 64-bit value could be anything (according to a value rang=
e
> > representation).
> >
> > This is not a fancy quirky special case, but actually a handling that's
> > necessary to prevent correctness issue with BPF verifier's range
> > tracking: set_range_min_max() assumes that register ranges are
> > non-overlapping, and if that condition is not guaranteed by
> > is_branch_taken() we can end up with invalid ranges, where min > max.
>
> This is_scalar_branch_taken() logic makes sense,
> but if set_range_min_max() is delicate, it should have its own sanity
> check for ranges.
> Shouldn't be difficult to check for that dangerous overlap case.

So let me clarify. As far as I'm concerned, is_branch_taken() is such
a check for set_reg_min_max, and so duplicating such checks in
set_reg_min_max() is just that a duplication of code and logic, and
just a chance for more typos and subtle bugs.

But the concern about invalid ranges is valid, so I don't know,
perhaps we should just do a quick check after adjustment to validate
that umin<=3Dumax and so on? E.g., we can do that outside of
reg_set_min_max(), to keep reg_set_min_max() non-failing. WDYT?

