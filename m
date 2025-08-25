Return-Path: <bpf+bounces-66433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0542EB34A59
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4767A9821
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07027EFFE;
	Mon, 25 Aug 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJXBp3+I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F9304BB5
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146683; cv=none; b=KeqxT0ilXd93DiNOqNKMgbobGSlcdDbS3TWvvomqCCaScFWoCVTZoRvGft/qPqvbzGXhjB4AGHc90glRwi3mB0z+ZHlb6aCe6thFGYwV5d6Z8M8MbxU3hw7puGuXwzf1LBeEVDkT6e9/S6mgU0cvBGE+ARgSZ7EKVLRl0n4Ivu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146683; c=relaxed/simple;
	bh=TbneTmz/DuaXAeUaerxGMmRboisM0alogBQ98mBSCzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxWzVbYan5MzuNye/BXlgKf9eHtTH43JZne7PXny/38UvHvpUn0YMgU4Iltk6tm4lxdhKluj8XTGBigSP3FZrS6xqkxxxpOWJC/x9EzDfS4rbLd0Zxe+MW8uxD9R80gGxl7VBvdkhLR6DRLBDA3pBrUgfl11E/Pa3X45pIudvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJXBp3+I; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-50e2e0ce5f3so3961355137.1
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756146674; x=1756751474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbneTmz/DuaXAeUaerxGMmRboisM0alogBQ98mBSCzc=;
        b=NJXBp3+IgzNSiP80aoAOZmVxNT2vSXRMo8scglWH21oVABXSC/adeOCmXPh3cQYnR3
         Jfd3khjIw3E0HV0BWitM0g3ev5o7J1dGnkRdGTMtckPm/KoO8T9uwQ5oh0f05sRot8Le
         dpQPIRPtd33+0gyFgMO0Skfmrv1gPrgNLmk+UXsXXG9Pvz3XrD62YQNF+81QlBYUiBbx
         D/yMi0teNnjA+IiyL8Or8Sem70WG+ic93gosouwqUcDvBFn3TrIwK4mutLup35yjuOAb
         bsBzDhcXSiTaQPE877S3oTeJrY3IW9s0mmlOc4TcBkbAcBc1bbQksYO10L2o+An/M2fH
         G7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756146674; x=1756751474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbneTmz/DuaXAeUaerxGMmRboisM0alogBQ98mBSCzc=;
        b=PHlO62jInzF2spbfB9eSS4S7ZSbXh5TfhTCCe5LN3HpkjkPhD+E3V5ZFgYKs5xxXJW
         haLGg5koAclw8rFz7UZvaGSxk5w6Njuo+308OPE6Aggqy40wFwbyukkUxmnu7ejOqUCk
         sAlJayWnt/eFo0SbwaWImw7fVAdER/urkTCVLPpDW2rNzpEcQEULwIOgnEyweiSI8t1X
         bE6oSxlqgEzN3sTr1cU4dCFTLhlVsjxne9OAISUT0FgYYTJQlT8K2X8oGY2HGMOPdV6F
         w+e1MiFqsB+YKOh+ws+Pk3m0PdsActludoJagilJE6XHIOeOEQXKD7vWbU9Gh/F57qb+
         mu0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTLEJFQD0nrBaUFljt4m29nCVbDXQcZ9lqhj5k+NdnzG5Wsp8yCM4pcuebb7TGA7mh7Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMCVReLU0p+4mwZazVq/LkuxS/5OnhpjydJEXkFMbmpHzY0TK9
	HTd4+gTHYV2ds8ZH+QAyovpxtEvH1VcycYiMIJ70nGsTFPRmQ6elf8H4u9FHVjM6Eq1JloNS0Nm
	DvJ1JlN9obaQc6hSeRdrA3Jw3xYc79yPy/bKI
X-Gm-Gg: ASbGncsVGVxgfISNcaIH9wowg7so9A52VuwYaAI26CRSMMjVsEHy7TMvbVKKTE09jXC
	srVCkq+TXQ+nLjA4ddat3UQLnSeLRuC0F17rnpRicCuxDx2F6kH08zNpLn8fXn5o4YNV8rdypqC
	AqQ6MHoP0uXr/VlnZoLQfkOPOgRfI+XIHFlDl7EhDqpopROO57v8rBvG/hFKxwURo9PO3QvW12P
	ZfaBxr/jelbzEyKRVaZS4o+abr4o+PLQf/5zs7WFw==
X-Google-Smtp-Source: AGHT+IEKQg5COvytjPTpC9UABL6h3wLQgXJ26ojcHoikoRhh7+y2JzwcL6Z73125EGbR25Q9iEXbtf8hpHMNFNgeEuc=
X-Received: by 2002:a05:6102:6cc:b0:523:a3a2:2638 with SMTP id
 ada2fe7eead31-523d649a02dmr304038137.2.1756146673609; Mon, 25 Aug 2025
 11:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
In-Reply-To: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Mon, 25 Aug 2025 14:31:02 -0400
X-Gm-Features: Ac12FXy90cpQ2oqLGhsC351MP0Pn6NsrObo2kCzt-VHH5-DPjoQszvjSvR3OH8Y
Message-ID: <CAM=Ch04T8MO7CmrXSPmOQJSzLG8zcx-j-C32GppkdaVdWaFZDQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/2] bpf: improve the general precision of tnum_mul
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:30=E2=80=AFPM Nandakumar Edamana
<nandakumar@nandakumar.co.in> wrote:
>
> This commit addresses a challenge explained in an open question ("How
> can we incorporate correlation in unknown bits across partial
> products?") left by Harishankar et al. in their paper:
> https://arxiv.org/abs/2105.05398
>
> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> from which we could find two possible partial products and take a
> union. Experiment shows that applying this technique in long
> multiplication improves the precision in a significant number of cases
> (at the cost of losing precision in a relatively lower number of
> cases).
>
> This commit also removes the value-mask decomposition technique
> employed by Harishankar et al., as its direct incorporation did not
> result in any improvements for the new algorithm.
>
> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---

Reviewed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

[...]

