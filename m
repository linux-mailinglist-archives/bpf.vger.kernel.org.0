Return-Path: <bpf+bounces-36689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137494C2BB
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 18:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D4F1C20856
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442B218DF70;
	Thu,  8 Aug 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH/PkKLp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E238646
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134392; cv=none; b=GWYvFeE7BNENfU/VTgfLoqw2JAuLpl+9owZ/h7dTXlN3BLGtCTv8J/GbFA5XA4HM3VEFZv3WUZY8rWo75gOfUpFqPq97C5Qxco5/Qe9+2vtNKV2T85vLVg6fqCnNjPAvzhPh9MLqzeFVxgH64yVcNN+ZLVmvZ7Ht5fP+OLsWlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134392; c=relaxed/simple;
	bh=gxQX94EdIxHAwR42BoIEnjCFor25IVcG7GZvyt+bee0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPVOUCbF3Uul180y2tmY8EJR0VxHWXreI1/gNqHCVnRRKaKDO/MFzD5dMT8bcCSA++ZrWBWlRBhI1vFvtP2NIsLjx6A05qRjjF8+tXkMIop0OE/haVY/tQBdbkg954FVc3Deo/Az/5RehoS1JIuTRI7wqYUpV35KCm8hD5e/Hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH/PkKLp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3686b285969so622302f8f.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134389; x=1723739189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/QqJtuXH5RcjL8863NZRXVID/pEcEciLxV9TBXw7l4=;
        b=mH/PkKLpwl3Pm423Cm+EO6H2k3Du11V7RkLlBgOwNzkTehb4VPPtAvVJsYUM/YVEyC
         eaL8CRWFttJPPJFnSA01nsUIVMajYdaDl84syTlPXHWa6hYBqZJ5GUh4K7RlF7TdGZwe
         1v0z7GAJBGfHh/ULjW1t89jOIkWehyoOejUA64ddwgW5FNy5pJoG+whMOzdUhJFIvQ3Y
         RAl0vkBAurjKm3jInpey1pBAM2HYmb1+sDVqerpReXgs5ev6994WCh+58mw+XF0PsctB
         tYmozbxcUIC7JPTFW5cH6kvJ3yW4gYfXFoF3r8JEVNovlD51jVtROebOJEptU1XCpnZe
         BxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134389; x=1723739189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/QqJtuXH5RcjL8863NZRXVID/pEcEciLxV9TBXw7l4=;
        b=n/YzjMKBZ7fspcOqR2Ppu4xM6Sm3zwBouBHQiCEwhaTCl3i8G6QmxS4zwL5KiwknaL
         wXxM5qOCuZLLtOrvyq0a/8ZZPExq4vkfGCL0S4fkjvSXVPXgTdwCALAR039wzkAWNPeZ
         3pa4v+NkEoi/L7gb58OC9lbyXacRh+P9k06NKUkSTyhGZkTK6D9Se2UOUJM1+yI1zlXK
         fxrBzwwMwcAavwVEF0Uza/jz9ED4QnXPwbr2icjxYqKxNwztAgVYw81fGtncMxIwbEPW
         SLaWCd7L5i0FYRBzXSNq/FOtE1ODDR4JRxL01J3DNGqRSZNO4+Kgb8eccSrl7OWKpVYH
         fAGg==
X-Forwarded-Encrypted: i=1; AJvYcCUy9lXGIYeY2LB+oeOqhgX2FxO8D9aNrkTXZkq9dexF9asNDIxh2brAfZRXaDfGvwuP+p3CNTrEbQIN9wZJbIRk34S1
X-Gm-Message-State: AOJu0YwZl3szljAMYTaFjezHLrBA3ZEbyQZqWHJyYe+kFZtgtsaI15SF
	nbT4LfnwWDTKQu0FUpKms3IhkZUmCXCVzO+vr160chu+64RLjGBDRT8lx+nvxHf0os4yx9lxAsO
	tKIRPBKl/DS0jtWfEjfMcxjKYSd6weKIL
X-Google-Smtp-Source: AGHT+IHvr9t77s5ZO3y3eM9ZIXkwtECc/M8i3it+XT5LDatFk/Ww9A4E2+nx/OkCVNDtfj3zsb4TAAEFtztdwB3EDj0=
X-Received: by 2002:adf:9c01:0:b0:367:8a72:b8b4 with SMTP id
 ffacd0b85a97d-36d274e681fmr1547965f8f.33.1723134389263; Thu, 08 Aug 2024
 09:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803025928.4184433-1-yonghong.song@linux.dev>
 <CAADnVQKt8FQjuZKFTGbyf5uKGZ8gfjzSvC36CbZ7ENbkuCmopA@mail.gmail.com>
 <e42a26b6-1520-40b9-850a-28d660bd9149@linux.dev> <87cymmqmry.fsf@oracle.com> <6f32c0a1-9de2-4145-92ea-be025362182f@linux.dev>
In-Reply-To: <6f32c0a1-9de2-4145-92ea-be025362182f@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Aug 2024 09:26:17 -0700
Message-ID: <CAADnVQ+gxrq5O2N168xYZa3UGWx_kNyPQihFPt=FLC56j9KOnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix arena_atomics selftest
 failure due to llvm change
To: Yonghong Song <yonghong.song@linux.dev>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 10:26=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> >>
> >> Maybe we could special process the above to generate
> >> a locked insn if
> >>    - atomicrmw operator
> >>    - monotonic (related) consistency
> >>    - return value is not used

This sounds like a good idea, but...

> >>
> >> So this will not violate original program semantics.
> >> Does this sound a reasonable apporach?
> > Whether monotonic consistency is desired (ordered writes) can be
> > probably deduced from the memory_order_* flag of the built-ins, but I
> > don't know what atomiccrmw is...  what is it in non-llvm terms?
>
> The llvm language reference for atomicrmw:
>
>    https://llvm.org/docs/LangRef.html#atomicrmw-instruction

I read it back and forth, but couldn't find whether it's ok
for the backend to use stronger ordering insn when weaker ordering
is specified in atomicrmw.
It's probably ok.
Otherwise atomicrmw with monotnic (memory_order_relaxed) and
return value is used cannot be mapped to any bpf insn.
x86 doesn't have monotonic either, but I suspect the backend
still generates the code without any warnings.
Would be good to clarify before we proceed with the above plan.

