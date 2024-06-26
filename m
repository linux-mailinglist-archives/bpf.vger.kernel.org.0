Return-Path: <bpf+bounces-33177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2224C918796
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEA71F2271C
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979518FDA3;
	Wed, 26 Jun 2024 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmQdy7mt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60C18F2CA;
	Wed, 26 Jun 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419952; cv=none; b=SVvtrmFU/AGhxNOr06bGPb3qSGar89aA5/cSEj/Dzt8l56N+bQ6kMTMYYmQe2dyCsSHp8tiUygRmedPlX0X7Ry8WMeYtYg6TXaC6oCHvaneq9Frl+9v7FrDBunK9ZFKkKKPp1KB4snVurYGV67aq1BH9akA/RRgiU91i6WaPxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419952; c=relaxed/simple;
	bh=XE6pwL6dsdiz5xjRoMJf9n0tb/ajimR+y1vYBe1dYPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIOb+SOZPH9McxIvBq7/RzjGXrCEqjsdAZHQUPx4uxnkyNsgVFwizE6AsGe7tDiN8vXg+jlvttcs2kGsLHxVgOOimTz7RiVYUvL0m2/kAfokbHCBRyPrKa+cFrfxZcd63y/XtFrCiIZN1bDXr4z0p1b3dmqxFmXIq+K8Ao0XMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmQdy7mt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-717f17d7c63so3887596a12.0;
        Wed, 26 Jun 2024 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719419951; x=1720024751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE6pwL6dsdiz5xjRoMJf9n0tb/ajimR+y1vYBe1dYPA=;
        b=cmQdy7mtfdlePzpqiwCXJMOS67lm+dizt5hhdjU9H0MiY+xgLVx77iKEO/XyBkQCUh
         6YCIEVRNs2RvfreL5VkEbcoO16ra56SFGRzfJcCiG6rboWdrnpJWrK2N2LDA017bCXhE
         +kNkIrCip83fgXXruPKIjV0oOs+MHMovrsPNwjE+5AXG9MkZrulj9wnwy4Uh31Yyg5+u
         q+AwnHmzLP8hKnQtN8XugzNOOtVSI+1uLqR6cO/IUuXRRxAq+uE2QRRXpKDcmMcZ/ZHs
         +BqTYG7Y19T7CxUJ3ywOwTrZun7IxsoKFaP67SVaBwTOKfHxb8Q9wThMc7xct4PQ2SuI
         AxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719419951; x=1720024751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE6pwL6dsdiz5xjRoMJf9n0tb/ajimR+y1vYBe1dYPA=;
        b=naipsFSCL5Jyla73lY/d3uwlaivKDm2TY5MNAGCTmVm+yFAytXExbu+01RGEmBsfJ6
         sa/Uaiexs2qocuFgmsgR7kooLYTggSea9rd0XOBNJEFI/Uxano1b2vDQqQqFEE5juMs2
         FCvNdTm7+jvriRo70+ACVtjKO2KB5ftr+ulnkNAg6g9xNcpaz6ahM8m1DRhcM2kLgSck
         FIvGP7OA8tiNl1A/1NLPxlOyDbPPijUn1u9ku745k+/h/2T1iZE8gSlFMZCPrq2lioUh
         CisYigo7qCd/KfqBcBt2Ya0asTMBdUuJvd8hex65zLgQxzk7Q70lzSKEABP3432kl7lB
         ybYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcytEI4mL7mWMquDi8dpKdzN0qzE/cK1rCjwJ2XxC+zlUM9p31yrnJO15BqKaB4XGZ8VUovHSMKmzKdDY8+oLNZHCGbLu4VSV2fMFXMtKng4TKcBfrJIaEKnZeWpj7BW4sSm6/F5Ws
X-Gm-Message-State: AOJu0Yw8Wyuz0gq9/+jST3iH8ppbbL7o74Lqn1gNDTU+Qhj7SYfDkUl+
	8gArl7O/kqHHzdB2Vrh/SQX1QiOP4gW7WQIv762bwdKkVb6LfniH/85CXiKO+SwJohLREYLnX4n
	kRODEpuT6EFAnt74pSiPMCqMD6I0=
X-Google-Smtp-Source: AGHT+IHaSRj6jlmwRm6hcSn9v0kziMhficzDoNx7tnNpHiVQ8S/DjM91iTfoPok8IMU6AEBEOtjiW4OqSeAThRGlvYQ=
X-Received: by 2002:a17:90a:d0c4:b0:2c8:858:812a with SMTP id
 98e67ed59e1d1-2c86146d1f5mr9497497a91.38.1719419950716; Wed, 26 Jun 2024
 09:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-3-andrii@kernel.org>
 <20240625102925.665f2fa3b39dc7602b1321d8@kernel.org> <20240625144952.GA21558@redhat.com>
 <CAEf4BzZqGNVqAmk_wrGP+MmxQidEr4=FdYiYpodpRd1TAib81A@mail.gmail.com> <20240625190748.GC14254@redhat.com>
In-Reply-To: <20240625190748.GC14254@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Jun 2024 09:38:58 -0700
Message-ID: <CAEf4BzbktxogF_a3pEewkXcS9WA4S9FQ3D_St_apvX=DLrcZmQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 12:09=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 06/25, Andrii Nakryiko wrote:
> >
> > On Tue, Jun 25, 2024 at 7:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > Why?
> > >
> > > So far I don't understand this change. Quite possibly I missed someth=
ing,
> > > but in this case the changelog should explain the problem more clearl=
y.
> > >
> >
> > I just went off of "Called with mm->mmap_lock held for write." comment
> > in uprobe_write_opcode(), tbh.
>
> Ah, indeed... and git blame makes me sad ;)
>
> I _think_ that 29dedee0e693a updated this comment without any thinking,
> but today I can't recall. In any case, today this nothing to do with
> mem_cgroup_charge(). Not sure __replace_page() is correct (in this respec=
t)
> when it returns -EAGAIN but this is another story.
>
> > If we don't actually need writer
> > mmap_lock, we should probably update at least that comment.
>
> Agreed.

Ok, I'll drop this change and will just update the comment.

>
> > There is a
> > lot going on in uprobe_write_opcode(), and I don't understand all the
> > requirements there.
>
> Heh. Neither me today ;)
>
> Oleg.
>

