Return-Path: <bpf+bounces-13740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC977DD5C0
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17840B21042
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E5121118;
	Tue, 31 Oct 2023 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3hn3Jaj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302720B32
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:04:46 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A00A6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:04:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso9911341a12.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698775483; x=1699380283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myPjyW46OciasY/8kqcBhEYWtmIYdeQin5G416qcOyM=;
        b=d3hn3JajyoECAID6IchhEOxOxUgx4M/MuZK8VsC07ZJZs6kDSRHDQMP0TE4IyZIrcI
         NRcZv7zrwo7/YQ1sng9uylPDmyFJP8pUd5/GukhcYGgmeqIHCy7sRkyA2e/m2qOeeO6C
         D4b1+3Wjk1XWc2NAA2PWxmFnLeU6I0yHlkTLDWUTbl+AWL4GfXmV/nHMm9Up6G4kMWbr
         obFFYI4GO4CkQeoNf6ldZt7GIwe/AGhNYJeXT9ftIys3ukR6mFYcDORr5m24U12Na2go
         tiXnfKFIFVflBeuCPT2uGg+nFNXkkr6OcRHBGZyKIt2yNJmNKsGgf2vpMlVbL7FaYkWG
         LFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775483; x=1699380283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myPjyW46OciasY/8kqcBhEYWtmIYdeQin5G416qcOyM=;
        b=i6U3zbUOlkzIwn7/sfIR5ZnfTJpBL0IoVptBAW5NzDCCfqrY6rfgAO2MaX3wDDae3i
         Lth7sNr7Dp2pVjPC71ZPGTcGrESYR+Cv5fYCOghf3x/H/R1njAzM5THzy/VwkneWNG9h
         wgyI5tJXbjRf1OIen4SHzB8nmYwdW9WXXve6xkl6lh6LXtXVxOoYnyyngRySvvQQOt9X
         GyrG/DGmBoqzxaMs3OVjQ33HAAVrxqQgZUou/yWyvop2gQffSs2yl6Dus7tDGgvBeK+M
         u5tlfFiFS50jbxf08vIz9Gz4RD0OZeeLx5Yw2+ArpVtAaDPts4KtA4eO+TrY1QMLRGV4
         srBg==
X-Gm-Message-State: AOJu0YyBSL+EmCJtJ6Dsrbt0GdXYao8q092sjaUF9mgsDMpNrwXWZhhK
	wlBcLGV7s4zzKLLfEG0/lCGYvty0uPwhCn0o+OU=
X-Google-Smtp-Source: AGHT+IHPhK7HDiF2NgqYSMQNA16ZbN+DN7JtwiULXthrhOm3fkvR9e/HnTBI5JypTvgNFGmQTpWjBBy64Ya+zGQ5wbk=
X-Received: by 2002:a17:907:608e:b0:9c7:5667:5648 with SMTP id
 ht14-20020a170907608e00b009c756675648mr83221ejc.51.1698775482873; Tue, 31 Oct
 2023 11:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-21-andrii@kernel.org>
 <20231031022033.536yvwc5vcc4toh2@MacBook-Pro-49.local> <CAEf4BzZC3NYUZu2uK+Mi3GgMrLOqe=ShXpkQpor-dLZxbjM-Tw@mail.gmail.com>
 <CAADnVQ+a-39-Gppmh3VgVaEYfnpHg9v9+mjPGEbX4PoSqaeMLw@mail.gmail.com>
In-Reply-To: <CAADnVQ+a-39-Gppmh3VgVaEYfnpHg9v9+mjPGEbX4PoSqaeMLw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 11:04:31 -0700
Message-ID: <CAEf4Bzb6jNpXr6LGHHrW17zaM_H1aDR-hY+eQg5dZUF0ZboufA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 20/23] bpf: enhance BPF_JEQ/BPF_JNE
 is_branch_taken logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 9:36=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 30, 2023 at 11:16=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 30, 2023 at 7:20=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Oct 27, 2023 at 11:13:43AM -0700, Andrii Nakryiko wrote:
> > > > Use 32-bit subranges to prune some 64-bit BPF_JEQ/BPF_JNE condition=
s
> > > > that otherwise would be "inconclusive" (i.e., is_branch_taken() wou=
ld
> > > > return -1). This can happen, for example, when registers are initia=
lized
> > > > as 64-bit u64/s64, then compared for inequality as 32-bit subregist=
ers,
> > > > and then followed by 64-bit equality/inequality check. That 32-bit
> > > > inequality can establish some pattern for lower 32 bits of a regist=
er
> > > > (e.g., s< 0 condition determines whether the bit #31 is zero or not=
),
> > > > while overall 64-bit value could be anything (according to a value =
range
> > > > representation).
> > > >
> > > > This is not a fancy quirky special case, but actually a handling th=
at's
> > > > necessary to prevent correctness issue with BPF verifier's range
> > > > tracking: set_range_min_max() assumes that register ranges are
> > > > non-overlapping, and if that condition is not guaranteed by
> > > > is_branch_taken() we can end up with invalid ranges, where min > ma=
x.
> > >
> > > This is_scalar_branch_taken() logic makes sense,
> > > but if set_range_min_max() is delicate, it should have its own sanity
> > > check for ranges.
> > > Shouldn't be difficult to check for that dangerous overlap case.
> >
> > So let me clarify. As far as I'm concerned, is_branch_taken() is such
> > a check for set_reg_min_max, and so duplicating such checks in
> > set_reg_min_max() is just that a duplication of code and logic, and
> > just a chance for more typos and subtle bugs.
> >
> > But the concern about invalid ranges is valid, so I don't know,
> > perhaps we should just do a quick check after adjustment to validate
> > that umin<=3Dumax and so on? E.g., we can do that outside of
> > reg_set_min_max(), to keep reg_set_min_max() non-failing. WDYT?
>
> Sounds like a good option too.
> Just trying to minimize breakage in the future.
> Sanity check before or after should catch it.

Sounds good, I'll have a separate register state sanity check and will
see what minimal amount of places where we should call it.

I'm assuming we are ok with returning -EFAULT and failing validation
whenever we detect violation, right?

