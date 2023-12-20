Return-Path: <bpf+bounces-18351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF71C819590
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 01:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9DD1C20C43
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 00:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B72E5254;
	Wed, 20 Dec 2023 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBD59c7Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB423B5
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3367903b4dcso296904f8f.1
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 16:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703032318; x=1703637118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BECVn5wRMPK8eyEBlRE9iZsYklTZbyCmOHqC7ccxFNE=;
        b=HBD59c7QA64JgO/1/ddgqPHRRhsEYt/9acgVemokWAtJOPOg08jARHUn14y7369zbJ
         nzp8e1Vg6xgVK9AMvspfZGpXqL67Qx4r279wUAbyVDxmO/DP1czwMcPhMawIll0uSA+c
         mQVNZy/Us23HvRrhWvSUE6yLtgQ/9fMKqqzpKWSYYNOmAQBnmJCdB9c4k+Na286s5Jq4
         Eo4YuOmt52x8qAeRrL2u8UA2tw0u+bnxG7EQ7MkIt2dtFbJjXb0/ZhuFziZ/23B3W41x
         qnFzcO7Mtm7Pnyt0a4W7X0G7efIDax9GiUpNWMhiCCimSrflFYy2wa+WcgXCnr1auiw6
         tl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032318; x=1703637118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BECVn5wRMPK8eyEBlRE9iZsYklTZbyCmOHqC7ccxFNE=;
        b=C6SAEK+CNlMdjcN2XpJzLZ5V4YF0wyztm7xMZXO0+008uQbldhVO+w+jABzsyx7eW4
         si/iEO/RlwxWU7W5NFsoqtlsOTnEjwEnAzVMr5eGZ+Oki1kVsHOlXsrwRDARaYB5ZtmX
         DiPLLrg3h0roIB123hEcg1yhiS3uuBVI7qjoHhqlapYkZ/JAx/4Dke0xBANydD2chLCi
         e5GXYEQ+wmQjL5X4saANlQRDYr7hNDB1koFYMvJRfAP1jZH9tjkUa1+Ygu83NKgYC69+
         57TxwK5iZIBS5kH71BCr8y6qzGbwhQnx9DKNsdAGC2E0dV29Pj3CKoARigtbvwaovYbm
         7gqA==
X-Gm-Message-State: AOJu0YxLIAye9o/JPzo+FkHTrCb95M3xYomApyzwdM4lA/AxfM2Sl+JT
	nmRASu1WCFWDMB36/qlx6uZ/ys7RdQ9EPr0TnlcP5fZtPPE=
X-Google-Smtp-Source: AGHT+IHpWRqNT5/F4EB4uOQTLeRMKePAXDmlJ9vM7w68RGEEdmqlza5WcLVWre7ZCV2Yi4UyvfX6rX33/+Ue2P9nKjw=
X-Received: by 2002:adf:e2c4:0:b0:336:4a0e:4c81 with SMTP id
 d4-20020adfe2c4000000b003364a0e4c81mr6267348wrj.135.1703032318118; Tue, 19
 Dec 2023 16:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <901d67ce-1344-4015-ac2d-7ca7dc28acc4@polimi.it>
In-Reply-To: <901d67ce-1344-4015-ac2d-7ca7dc28acc4@polimi.it>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 16:31:46 -0800
Message-ID: <CAADnVQLm9P6ghj2Ohh2gXYF4_m-vdfxoH5nz8PyHCJUhUOsEZg@mail.gmail.com>
Subject: Re: Unexpected behavior from BPF/XDP program
To: Farbod Shahinfar <farbod.shahinfar@polimi.it>, Eddy Z <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 7:00=E2=80=AFAM Farbod Shahinfar
<farbod.shahinfar@polimi.it> wrote:
>
> The kernel versions tested are:
>
> - v6.1.0
> - v6.5.6
> - v6.6.0

..

> I suspect the issue is related to the use of bpf_loop but I do not have
> any strong evidence. Is this a known issue? Have I done something wrong?

You haven't done anything wrong :)
bpf_loop is indeed broken in kernels 6.5 and earlier
until the fixes are backported.

These patches fixed the issue:
https://lore.kernel.org/all/20231121020701.26440-1-eddyz87@gmail.com/

Are you sure you've tested on 6.6 ?
Above fixes should be there.

