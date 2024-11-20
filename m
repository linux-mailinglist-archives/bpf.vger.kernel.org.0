Return-Path: <bpf+bounces-45301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 837979D4320
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 21:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204001F21EA4
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 20:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9261714A3;
	Wed, 20 Nov 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="arOtEsuP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A313C689
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134809; cv=none; b=IkQlXLOPQS8weDPEf6DoCxYXoFQ60Po8HFUTBOkcWZQl79kq/DzO6UdD2/NTb+3/fOWFJFM9dRNBVicavO4pjggKiW4DNtIy+0JrMoAXwU5gek+3znVNISvCoQx56eFEMuz9iCnfSfcKMuaZYRhLkNvt7WGi7xkm4FH5JWtH6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134809; c=relaxed/simple;
	bh=PFvaS2xCNB/338I+bM6LZey4FUjv0SGsrVTlcylLEVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWY18DR5ju4Pe7N5WvEycvq6muZlENs0eV744qYRLwwFpyiPIwrR5m1/nZ4PtHgaOVUGsWMc9AViecFcw9bkKXFIL178I76wMuZmnLMFQPQkFyEu0kZEBQ8hs3OVY/0ddlVAWGnSUvIo2IrBXKQUiCY+il2KZJfolQfq9+kfW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=arOtEsuP; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5ffbc6acbso175088b6e.3
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732134807; x=1732739607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lD3e2zU+8DR7zrFaLuLnlvbhl8xXthiwkjgmnnPvoSA=;
        b=arOtEsuPiqtEwtGwP575es8tXNfoV+3uVIKZuRnJf+zC9dLYfvH3EK+O+Hbb2g96rf
         JJ4iN1L0fy+QZlsLAW6T1gfRNm9n4111BSXJaHsa5y77d0z2D+LCR4qM+ElCLNmDdfsQ
         bAHgSw8eZ/5rtPco8wCwg4CAAV4LTqJXVwxZ2BqBpc6Q4RC+ErtQsfNnAU5SGtJVfDFb
         aIOg6ye8PnVrEWKNVoJA65MObAJnDA+0+qkSpuVFOM8Wv0YQvHIYXzbzfPUu8T5FqzhO
         KVH6xnFocHfBIE3VsV/IKJYB/uNgkC/+UwBFeSZ4tg3UKrafUDm3dqvg3uG1DvcU90JU
         e7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732134807; x=1732739607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD3e2zU+8DR7zrFaLuLnlvbhl8xXthiwkjgmnnPvoSA=;
        b=qqPQrAEEWOgc4NtHjnGqBVCRdccpOMA+7tzdayENTZu+bBZo24YsaWBlm7iUz/fyM5
         hmnx2SVT+Yzu1zkElZyFPBeB9EfZ0n+TV8Z721A88RrsUiEcy9/vjHe+oqsxYhGZIvoM
         KBU6u0SclXgGIq6B4g6vsM0oB/IKBwTh5iazUZ6vNSacLmLg4K1fmkkEegOAyl5aixuW
         bo1NmYNSWEQcFv+x+crHmEnwgQXm4gX4TM2gWjRAuLO/3Wz91jEIq74fZqkfK5JOMoeO
         cDS4g9x7umErS9fzTRyKmbTy0FBpj5zDZubBzIl1GGuF+iOwpH1fwN64cYjaTojlTXrO
         Igsg==
X-Gm-Message-State: AOJu0Yxu9D3LnZaEMSxj5qZ8cQxIgCsPb2+NXhVNC8Pcwoba9FvmhspS
	CeDFG/1q6HKNOF3RWuwQZvYEu+09WfupeoS3Ou7N86yAZg57rPcac5inJ5Xh6sYl5lEhgrDyjoH
	A2VNGk1QxA9n4C4TR1Edo63DZYKXyrhGid1WmGQ==
X-Google-Smtp-Source: AGHT+IG8fndGcX50XTBsTT0rWZHNy25EkMTy4MMAj3odhI4lGn7bdcraVUgr1wg6k1xjk/gkYA7nMjFWGw4lEJr2gKY=
X-Received: by 2002:a05:6808:1485:b0:3e7:63ce:2025 with SMTP id
 5614622812f47-3e7eb7d19camr3813966b6e.37.1732134807255; Wed, 20 Nov 2024
 12:33:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50b7301fcfd0682c9923b3639c1589f3eb37af33.camel@crowdstrike.com>
In-Reply-To: <50b7301fcfd0682c9923b3639c1589f3eb37af33.camel@crowdstrike.com>
From: Maxim Mikityanskiy <maxim@isovalent.com>
Date: Wed, 20 Nov 2024 22:33:11 +0200
Message-ID: <CAD0BsJWf=28Cte5KBpM_O6bsB55kfR885f2ikfn1+UmJHgMYqg@mail.gmail.com>
Subject: Re: Recent eBPF verifier rejects program that was accepted by 6.8
 eBPF verifier
To: Francis Deslauriers <francis.deslauriers@crowdstrike.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"ast@kernel.org" <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Francis,

On Fri, 15 Nov 2024 at 22:59, Francis Deslauriers
<francis.deslauriers@crowdstrike.com> wrote:
> I added a stripped down libbpf reproducer based on the libbpf-bootstrap repo to
> showcase this issue (see below). Note that if I change the RULE_LIST_SIZE from
> 380 to 30, the verifier accepts the program.
>
> I bisected the issue down to this commit:
>         commit 8ecfc371d829bfed75e0ef2cab45b2290b982f64
>         Author: Maxim Mikityanskiy <maxim@isovalent.com>
>         Date:   Mon Jan 8 22:52:02 2024 +0200
>
>         bpf: Assign ID to scalars on spill

This commit was part of a series with a few new features that are
indeed expected to raise the complexity with some programs. To
compensate for it, a patch by Eduard was submitted within the same
series. Could you please test your program on this kernel commit?

6efbde200bf3 bpf: Handle scalar spill vs all MISC in stacksafe()

I.e. whether it passes or fails, and If it fails, what's the biggest
RULE_LIST_SIZE that passes. Let's see if Eduard's patch helps
partially or doesn't address this issue at all (or helps fully, but
there is another regression after his commit).

> It's my understanding that a eBPF program that is accepted by one
> version of the verifier should be accepted on all subsequent versions.

That's basically the goal. Obviously, some new features will increase
the verification complexity, but we are trying to compensate for it or
to make it insignificant.

For example, when I introduced my changes (with Eduard's patch), I
tested the complexity before and after on the set of BPF programs that
included kernel selftests and Cilium:

https://patchwork.kernel.org/project/netdevbpf/cover/20240108205209.838365-1-maxtram95@gmail.com/
https://patchwork.kernel.org/project/netdevbpf/cover/20240127175237.526726-1-maxtram95@gmail.com/

As you can see, Eduard's patch really helped with most regressions,
and the whole picture looked good enough. Apparently (if this series
is indeed the culprit), your program uses some pattern that wasn't
covered by the set of programs that I checked.

> I'm investigating how this commit affects how instructions are counted
>  and why it leads to such a drastic change for this particular program.

I'd guess, most likely, something inside the loop body became more
complex to verify, and it's repeated 380 times, further increasing the
total complexity.

I wonder where 380 comes from. Is it just the maximum number of
iterations that the old verifier could handle? Or does it have a
deeper meaning?

Is bpf_loop an option for you?

> I wanted to share my findings early in case someone has any hints for me.
>
> To reproduce, use the following file as a drop in replacement of
> libbpf-boostrap's examples/c/tc.bpf.c:

I reproduced the issue on 6.11.6, the highest RULE_LIST_SIZE that
works for me is 35, but I currently lack time to take a deeper look.
Do you have any new findings in the meanwhile?

