Return-Path: <bpf+bounces-13725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE027DD23F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B46EB20EF5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA201F191;
	Tue, 31 Oct 2023 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5ePFYsJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79E1DDD0
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 16:39:18 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647E74EFF
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 09:36:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso4025223f8f.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698770204; x=1699375004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhE/2mejQRvgYRLrd1/KmV+d2EQPndZ060DnAMZHI3U=;
        b=W5ePFYsJYGwfubU5w1PwdTrFfJkaJsgaXQU7GAByJlZDiomeT2w43FVfE9u7nQjKl1
         6l7pNuBcoSEv5pBNtA+BtzCQZne9J88cqgu1qwCK2Up75MQgy+jlh69gldnY6m0cDmTv
         R7MwHuyw2BK1gSwXfYRRopvS0KbyHYlpxrFrQeRc0vGQQUg9i946H4c8NpwPPTS3cG0e
         ut/G+BS/7YJCXIOD9wQykeOdHJhGe8MISqf050P27cBSrFVNnoseE3ySg6kmqvUKY1fC
         8iBdKtHSQI829FNLR3d6URHHB3sJmCuyRVjeTrWj5rBROhDsDyr+6OMTz7mtKyoVygmR
         0Jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698770204; x=1699375004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhE/2mejQRvgYRLrd1/KmV+d2EQPndZ060DnAMZHI3U=;
        b=Tcw9bliU5bw78X/7Y/mpP9EmI9bS3O+ZmLa9lypYfEmbIy1wHps5AxJ5/ZLKok5dzr
         2Y6SCkdKebDxh1sRZWns8PuxMWsa070PAL9Y2qBZriw5uSwddPr9lA8deO+6bMxXgnoi
         HLYH4Y5yvusqG/2b2cPRMyhSMaLUOAA5t3UmuXFpxVF7rxIy8pRYBhoojE1/WiCiS1RL
         OMnzw6I7iGSHoCm5eWyUMUbGXHZlq4qkj8qriPdh7CH+hLsdusTddJ00oWOUqMNiN7qA
         +TrMzr0DelvnJw/0EpaXTm+EseazwpN/opIlyLBbHMqrTkbX2kgLpf6ZVYhrsOFlpSqu
         JVFA==
X-Gm-Message-State: AOJu0YxQil53S5nkLKviH/pMn+9W5/LvnXT2c9sKy1JLJd+qM99ds6ZY
	RrWT1e7B+6WpZXT3grtAD7e3whbG/JdVIQIgJ3YlFJPz
X-Google-Smtp-Source: AGHT+IFWP0Z3naYVAWz80kOqHkVhGpbN4hguRST+QWyNmRddMrhGqo3em4/WQj/WpOU+eWjajBry3kyfJW86+RsJYR4=
X-Received: by 2002:a05:6000:4cf:b0:32d:87ca:7b0d with SMTP id
 h15-20020a05600004cf00b0032d87ca7b0dmr9562775wri.56.1698770203614; Tue, 31
 Oct 2023 09:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-21-andrii@kernel.org>
 <20231031022033.536yvwc5vcc4toh2@MacBook-Pro-49.local> <CAEf4BzZC3NYUZu2uK+Mi3GgMrLOqe=ShXpkQpor-dLZxbjM-Tw@mail.gmail.com>
In-Reply-To: <CAEf4BzZC3NYUZu2uK+Mi3GgMrLOqe=ShXpkQpor-dLZxbjM-Tw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 09:36:32 -0700
Message-ID: <CAADnVQ+a-39-Gppmh3VgVaEYfnpHg9v9+mjPGEbX4PoSqaeMLw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 20/23] bpf: enhance BPF_JEQ/BPF_JNE
 is_branch_taken logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:16=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 30, 2023 at 7:20=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 11:13:43AM -0700, Andrii Nakryiko wrote:
> > > Use 32-bit subranges to prune some 64-bit BPF_JEQ/BPF_JNE conditions
> > > that otherwise would be "inconclusive" (i.e., is_branch_taken() would
> > > return -1). This can happen, for example, when registers are initiali=
zed
> > > as 64-bit u64/s64, then compared for inequality as 32-bit subregister=
s,
> > > and then followed by 64-bit equality/inequality check. That 32-bit
> > > inequality can establish some pattern for lower 32 bits of a register
> > > (e.g., s< 0 condition determines whether the bit #31 is zero or not),
> > > while overall 64-bit value could be anything (according to a value ra=
nge
> > > representation).
> > >
> > > This is not a fancy quirky special case, but actually a handling that=
's
> > > necessary to prevent correctness issue with BPF verifier's range
> > > tracking: set_range_min_max() assumes that register ranges are
> > > non-overlapping, and if that condition is not guaranteed by
> > > is_branch_taken() we can end up with invalid ranges, where min > max.
> >
> > This is_scalar_branch_taken() logic makes sense,
> > but if set_range_min_max() is delicate, it should have its own sanity
> > check for ranges.
> > Shouldn't be difficult to check for that dangerous overlap case.
>
> So let me clarify. As far as I'm concerned, is_branch_taken() is such
> a check for set_reg_min_max, and so duplicating such checks in
> set_reg_min_max() is just that a duplication of code and logic, and
> just a chance for more typos and subtle bugs.
>
> But the concern about invalid ranges is valid, so I don't know,
> perhaps we should just do a quick check after adjustment to validate
> that umin<=3Dumax and so on? E.g., we can do that outside of
> reg_set_min_max(), to keep reg_set_min_max() non-failing. WDYT?

Sounds like a good option too.
Just trying to minimize breakage in the future.
Sanity check before or after should catch it.

