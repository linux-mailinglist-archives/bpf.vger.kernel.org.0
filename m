Return-Path: <bpf+bounces-20295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4367383B7AB
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 04:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7767E1C24838
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0EE29AB;
	Thu, 25 Jan 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGYvof5G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553479E2
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152443; cv=none; b=WlCQnX/aeprZcRVOuRdWwYHE40r9bq+zXqfMAazhNghnapDdgDs1vVfEMD9fOtEmTjutU71CkfxM2ReBk+2JGF2aCri+Qq4LsIezLnMhELMJZHa8ZZA8o7DByArAKLBvq9Ok70Run9lz4mnuYmB3trUMOtnsyZ7csOZ1Wz7iZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152443; c=relaxed/simple;
	bh=Jre4uhIsjR1k0q+UCyu0iETOWXWha9Si2UCFcl+ZD+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNN7+bhyu5uQxqfoj+/M0CmGhzHQqChlI5hY62cvj6W2j5lYFACPlP1h8ENKhaOlLGwYUmGt56nFP3UurtX/SWfqPcT7NN4fuHtHC/lUcgpNG9pJUAb73rv0cq9Apwytd55xvnKljy3Zz8uoZFRejjAzdXyMPupmwgdg13q8A2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGYvof5G; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3392291b21bso5273176f8f.1
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 19:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706152440; x=1706757240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur8a1M1Lx57Kx2hOFLmI+GGhr/ervjcbPnLVkkXV/m8=;
        b=CGYvof5Gv/rDLcDGaPS4/H37qpFXR7S12qWdRj1aj0EYbj4yqtmIofaI2OLH2TELRA
         vRF1djOAuqxCBxfAT5b3Mzy4bsjvTW6sqJzYxfvg/UrddjPzpzf20CiHTg3LwDPI/kJB
         HEn0J5U2uq1xc5m0I5BnjDQOf36k1NmTb2qMmZSh7M5UN/gyl33ephFMpjjOu3NRN9dH
         DA+Qlb8EBNyTDbJ/r7BZPsnaJ28PDq9t5PUdYadNTL064CyBr7eXtYQ4nTiFDvsV4NaX
         DTgrvmtu+VRrb7mr43Fsdv04VCDTxqmtsGs2Q1CYXvUqjUdNVRF6bFYrc79fCfTaPjKH
         +MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706152440; x=1706757240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur8a1M1Lx57Kx2hOFLmI+GGhr/ervjcbPnLVkkXV/m8=;
        b=ZTc6JNAaAgg3yOnDB7g8/nkzSuTAmK2iM9K9dXMl6cYl9IzCDvxNfevptFbr+1m8jw
         /6NHywCzBaKo9+2tADeTLlDHjr/oGEJwSftzZxusGTvF1CF/Xm9jwCkRLHZTncxRp4iY
         F9uECr39Z2azp9duRJHXNifwlythTsl/kTPB7XYUu5gRZxSz2Xnig1VElpN6wB0khtFA
         gHTKZGK1CHVzHx+Rg1Gho9ZbQq+gvKdoEcktYr3KUYMqIOvc2LoZ/kTFC0a7Cj1BZgi4
         NZixiJOWZ/Zwt8kw6OU8cqgusfKBkCI8VSQ/StfPmS80kaMI/vo3o5IeCKZLTGJ9CKCM
         NAJQ==
X-Gm-Message-State: AOJu0Yxibv3JGYY164ypwmutq/oIOiquEgf+Rj4A/1RBskp6ylLSObud
	az3RqBSyoJDg4IEN0i6VZHqtmAArB7PayXaNOZOL4MxF5nyl49vhtEPi/RBs8VeoGczDeFBfspv
	uPZEBrDJxbE9XWEzNZ3OALd4ZSjk=
X-Google-Smtp-Source: AGHT+IFdeH+hshm0prdv1DcuTNzyNgJFMEn7bWZrZqnOrTi6Ux6z7TLQ2aYkkhyTZIujvcJ/FPE2bMKVn+C2Z2ztWsg=
X-Received: by 2002:a05:6000:1cf:b0:337:3b9e:d01c with SMTP id
 t15-20020a05600001cf00b003373b9ed01cmr105068wrx.143.1706152439695; Wed, 24
 Jan 2024 19:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
In-Reply-To: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Wed, 24 Jan 2024 19:13:48 -0800
Message-ID: <CACsn0cmG5yui1Xt_HPDK+uTUk-4eML+Aw_wm5f9GKHUS+shycw@mail.gmail.com>
Subject: Re: [Bpf] Standardizing BPF assembly language?
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@ietf.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:46=E2=80=AFAM
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
> At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
> language (http://vger.kernel.org/bpfconf2023_material/compiled_bpf.txt).
>
> Jose wrote in that link:
> > There are two dialects of BPF assembler in use today:
> >
> > - A "pseudo-c" dialect (originally "BPF verifier format")
> >  : r1 =3D *(u64 *)(r2 + 0x00f0)
> >  : if r1 > 2 goto label
> >  : lock *(u32 *)(r2 + 10) +=3D r3
> >
> > - An "assembler-like" dialect
> >  : ldxdw %r1, [%r2 + 0x00f0]
> >  : jgt %r1, 2, label
> >  : xaddw [%r2 + 2], r3
>
> During Jose's talk, I discovered that uBPF didn't quote match the second
> dialect
> and submitted a bug report.  By the time the conference was over, uBPF ha=
d
> been updated to match GCC, so that discussion worked to reduce the number=
 of
> variants.
>
> As more instructions get added and supported by more tools and compilers
> there's the risk of even more variants unless it's standardized.
>
> Hence I'd recommend that BPF assembly language get documented in some WG
> draft.  If folks agree with that premise, the first question is then: whi=
ch
> document?
> One possible answer would be the ISA document that specifies the
> instructions,
> since that would the IANA registry could list the assembly for each
> instruction,
> and any future documents that add instructions would necessarily need to
> specify
> the assembly for them, preventing variants from springing up for new
> instructions.
>
> A second question would be, which dialect(s) to standardize.  Jose's link
> above
> argues that the second dialect should be the one standardized (tools are
> free to
> support multiple dialects for backwards compat if they want).  See the li=
nk
> for
> rationale.
>
> Thoughts?

Someone from Bell will go off and invent their own variation no matter
what we do. Snark aside I think it's useful for documents to be able
to contain excepts of code without needing to expect readers to decode
BPF from hex in their heads, and we should write down that format
somewhere.

Sincerely,
Watson


--
Astra mortemque praestare gradatim

