Return-Path: <bpf+bounces-38917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F296C717
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 21:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81611C21F05
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 19:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72721144312;
	Wed,  4 Sep 2024 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7ExRDUD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F0143757
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476818; cv=none; b=sZnLr7zu4SIvuBJSPoSJvYp65q1XteVSeEARBUE1auJz+vpthKt6HfUcBf3DsNi/yrfMR3/Hnr3cu/jVlggcCiv5iWEyF7Us1zwKxudkgERfj4rcH7tVYjZER6wNWkBMKNamRmbTEKp2k5JEvoErL30s+apIiFcGXPCj2xB2kBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476818; c=relaxed/simple;
	bh=vFT1VkJppxdFZIINEOPgU1+gh/haX03b9VwomumzyIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U3FB08flruAID/d/rRcrkqYPM1grSOiRh8L1kpW/l8YWlDJ5fBAZEMBPeMsxezEUKa3v5mwHGU+InNlxiMIB59zpAyWTdMJ8ushbUiMKtZcojfjaEkfOQ3EWZ0GbAK7O7DIelJaBl3SV+vbeZHXNwySQ8rHZiU61vJChS9lX5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7ExRDUD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-205659dc63aso32853705ad.1
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725476816; x=1726081616; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oa63yWsx+VBig1NJvJfvU190o4ebYAvSMkQvBjFLlUI=;
        b=j7ExRDUDFydaFH5a1Bb2WwfNgxzPn2tkU1BTWyen0iLFeQGia5Rf359gIDrFdbvi4U
         4jHsbUMaMKLGGxfgR9Wv1ytPt2uGNrfQt2RHNYdJvnrePAcfMxoiCv6R6OfBrDP1E1p/
         wuuMqU2WW6rtdrpB+FG9Hf///EbL/OYM8us/GBmgELfJ+V6EOD49gUYu+RG6ujgHcc2w
         SKWVX+CTsh0sVNHWoO62FQhV0gChPhV9tgtoT1L2rvbhvsyw8FKofH3ZmybCBKILwkhv
         WF1+ao/+qQeOwBtfxGnKwomR/U/VHKhQfmq3RGUqydz+2usDWrI/z1TpxP0BFpJaswto
         wxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476816; x=1726081616;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oa63yWsx+VBig1NJvJfvU190o4ebYAvSMkQvBjFLlUI=;
        b=H4mdTU/y5wDpCLCGU6qtWfliX7BjT1iWw2F4adqX8G/OMdW7XXbSit/uTuGOLAT76V
         xCzGL65ze1k8pfhNg81mVo4NFIbx+OuCp52aUwMsLvjI4b+t37vYhsfkSR+8qnMTN7Ij
         7/v9Ynq1TYkpk9SioATTOVjUUMYM/7KQlduU6Ns/6gsV5BSzCvPq/iAJJJyMhLuCNdxT
         Gr2o7KU+j0tpPd178Ec9jApf+7sbOh5L+5u+OZLc2SrPEPYA7SycuTeYICcnqcSQorZb
         a+Z8+XMiaEtpHJTeGkIMEF4f5c9E3ZMHl90x0Yg2a/KxmRA7I/N88FjE+BtXKpIgRB2t
         LQKA==
X-Forwarded-Encrypted: i=1; AJvYcCU3lKJmLqr5obUgAzQU4c2vdx+lU494rCr10muzSEPwig6c/plqTx6meKCVsihmcKP83mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pGYi5shbsWfnmVSxpjk3cl6kPEG4dXRQZNIvxH5smUKlCs9Y
	gvAEt914AIdb65o2r0Si4UMNAdoANYoEiF/uIIKtT+naaFEE0Q5Z
X-Google-Smtp-Source: AGHT+IHsL2NwEH2a1zgZGAM4mCorqoZeEMauS1yCwyYndP2gitrzsRi0MiOG96AI34muqQh/fYX6ew==
X-Received: by 2002:a17:902:ec81:b0:204:e310:8c7b with SMTP id d9443c01a7336-2054732a643mr131969655ad.34.1725476815953;
        Wed, 04 Sep 2024 12:06:55 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea582e9sm16755365ad.238.2024.09.04.12.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:06:55 -0700 (PDT)
Message-ID: <351452aa5c15eaf261f1379f14361bdcf73ab050.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Follow up on gen_epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@meta.com
Date: Wed, 04 Sep 2024 12:06:50 -0700
In-Reply-To: <20240904180847.56947-1-martin.lau@linux.dev>
References: <20240904180847.56947-1-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 11:08 -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> The set addresses some follow ups on the earlier gen_epilogue
> patch set.
>=20
> Martin KaFai Lau (2):
>   bpf: Remove the insn_buf array stack usage from the inline_bpf_loop()
>   bpf: Fix indentation issue in epilogue_idx

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


