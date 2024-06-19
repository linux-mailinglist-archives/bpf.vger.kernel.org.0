Return-Path: <bpf+bounces-32506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A7B90E669
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 10:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2F5282CE1
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99E7E10B;
	Wed, 19 Jun 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMQF1u7t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12D7E0F2
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787510; cv=none; b=kOHN9wNNS6oWI/8FeHf4PqB2Ec7j3rvw3FEEBh+Z34jrfcPSJ/KpHEtVucnwRU/C8fqXOITNcFmvUkBTNAhFqO/59T9X0wjLBNlayllIeNT4YYuiPcD3zviVk5u+31ct2YrKLPr6W++8ezMORo9tvjW3BmozFiUNC1qMzlyChKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787510; c=relaxed/simple;
	bh=A1Oal7iyzrcwvZH0SMy+coQIMk2FwYBpHvjUiqLJUd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upwH2CFoLrzXxkOUuR754SDHKGTDki9Ml8VfUh2nP4Gcih5/ZhYaceA5SH/Jia4eT26158pUOW8y+HX5KWb3s4J9TIUMAUtTa+BDjDXKVzv/InyAKtIcbv4zwj3Tpus7UFrLfJ3sZVS7JOAWli53gPS+g07UsljSpXKhJIa3zOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMQF1u7t; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-57d07673185so964818a12.1
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718787507; x=1719392307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7eqMtJE2QHqvBMAS60x2XJcrW0lKyRz+EoTnO39B2VA=;
        b=TMQF1u7tuklW03c9Y6osnQ+ge2UNYQIcHw34wzWVBln/12wcJeF/zzfgtbqjbjmL3g
         drEJMJ4UiQDN6I5ut6UWhA8k5cWYim8sQhyi1Xa6swuRacK1CDukg+63jP/Y9Z+rGZfK
         rRQ9vE58fKba2HV87e/Fuj+iw5WKQ7FGamdtFQgjuIvY50bohnu2uztFPDA8IrveG1LA
         Va5w6idLPuW3n5HZmWb+lnlBkG8Sf9Tk2K4BdbMmgvvJEv7o/1k6s81Mzu+MDg9xFWpz
         pzalh0DNF5U6jpvKsxTm6tf7V2CRoClnZQWlolwKsJykMRtNDBn5PDKL5IiGzWUi2Wte
         Lk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718787507; x=1719392307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eqMtJE2QHqvBMAS60x2XJcrW0lKyRz+EoTnO39B2VA=;
        b=eACkSpk1fwqcKsCerkmQiwN4KK0ZaJsPLyvNoFsNqJhkjy1msOfrpLRxE3rEE6C7Rw
         jdxPaZP29eD+hJixruwpT5iosTI64x1DB5O2hJrRB0bHSZVqv9m/wNc53aTWSPneLraE
         /OrG9Wplj1IGAauV/Oxd1ho2O0W1+yito8pXfvhJqjfChpoiDdmmFJWdWWFQLKaeF8hV
         FDSHnFUZ84ArNO9bjPbAe9HGJzdbko26YhnaN4XXscWjgNJZmDejGaTDywVhZNK4EV2Y
         cUuAuoYRf4PdIz+CnhrEgM1ySf3Is+gGVTIoApJek3oqu7RPCygaag8a9usUKUfxmoMg
         fKPg==
X-Gm-Message-State: AOJu0YxmvB3LT1Co+P21C/powcid1pCjIUSGeBDMxDL0WGT+iFkXa4HF
	+ahiu6RRNAbjUJ3GAspurrQQG/0IKv5IlYJPK4oFOfeD0N94LjVqT3aSyZL1mC3KK3zlhiT42iY
	v/pNepjjn+/fx5pxVL5+gZ1PV7wY=
X-Google-Smtp-Source: AGHT+IGc6R7bUtsD+Deb3kI8nFkPBGHOF8bXgB5DtlI7y8gKnCr1zseqGOOuUY2Sfa8U9HWkZMPCrRv4fYQlJbtLXL0=
X-Received: by 2002:a17:907:7f0f:b0:a6f:9e2d:6b52 with SMTP id
 a640c23a62f3a-a6fab6096d4mr173008966b.3.1718787506547; Wed, 19 Jun 2024
 01:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnA9ndnXKtHOuYMe@google.com>
In-Reply-To: <ZnA9ndnXKtHOuYMe@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 19 Jun 2024 10:57:50 +0200
Message-ID: <CAP01T75tCoNSEARtnYHHU+Ry+e+a7jLRgMdGuBGy7ssX8UdN5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: relax zero fixed offset constraint on trusted
 pointer arguments
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, void@manifault.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Jun 2024 at 15:44, Matt Bobrowski <mattbobrowski@google.com> wrote:
>
> Currently, BPF helpers and kfuncs which take trusted pointer arguments
> i.e. those flagged w/ KF_TRUSTED_ARGS, KF_RELEASE, OBJ_RELEASE, all
> require an original/unmodified trusted pointer argument to be supplied
> to them. By original/unmodified, it means that the backing register
> holding the trusted pointer argument that is to be supplied to the BPF
> helper/kfunc must have its fixed offset set to zero, or else the BPF
> verifier will outright reject the BPF program load. However, this
> fixed offset constraint of zero enforced by the BPF verifier onto the
> trusted pointer arguments is rather unnecessary at times and limiting
> from a usability point of view, as it completely eliminates the
> possibility of constructing a derived trusted pointer from an original
> trusted pointer. A derived trusted pointer is simply a pointer
> pointing to one of the nested member fields of the object being
> pointed to by the original trusted pointer.
>
> This patch relaxes the zero fixed offset constraint that is enforced
> upon trusted pointer arguments such that the constraint is now only
> strictly enforced on a case-by-case basis. The updated semantics of
> when the zero fixed offset constraint is enforced and in turn relaxed
> may be summarized as follows:
>
> * For OBJ_RELEASE and KF_RELEASE BPF helpers and kfuncs:
>
>  * If the expected argument type is of an untyped pointer i.e. void *,
>    then we continue to enforce a zero fixed offset as we need to
>    ensure that the correct referenced pointer is handed off correctly
>    to the relevant deallocation routine
>
>  * If the expected argument is backed by BTF, then we relax the strict
>    zero fixed offset and allow it only if we successfully type matched
>    between the register and argument. A failed type match between
>    register and argument will result in the legacy strict zero offset
>    semantics
>
> * For KF_TRUSTED_ARGS BPF kfuncs:
>
>  * The fixed zero offset constraint has been lifted, such that
>    KF_TRUSTED_ARGS BPF kfuncs can now accept a trusted pointer
>    argument with a non-zero fixed offset providing that register and
>    argument BTF has type matched successfully
>
> With these new fixed offset semantics in-place for trusted pointer
> arguments, we now have more flexibility when it comes to the BPF
> kfuncs that we're able to introduce moving forward, and increase the
> overall usability of BPF helpers and kfuncs that make use of trusted
> pointer arguments.
>
> For some early discussions covering the possibility of relaxing the
> zero fixed offset constraint can be found using the link below. This
> will provide more context on where all this has stemmed from:
>
> * https://lore.kernel.org/bpf/ZhkbrM55MKQ0KeIV@google.com/
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Patch LGTM, thanks for putting all of the complexity related to
release args into its own function, helps with readability.

