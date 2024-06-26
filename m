Return-Path: <bpf+bounces-33134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6E91794D
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 09:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0A11F24081
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F117156F57;
	Wed, 26 Jun 2024 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HbvToHoa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FC1474CF
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385316; cv=none; b=rhHaLFHX5YTL3o+1TfP49sKwqLefLD8lD7KE4gmikCFwovJvdEx/lwiwtUu2qP5axPJQJs+YAFHY1C0Bf/m+KkZdKaqBewhPO8LqB7QvGbmYsZoR67n7NTNLxsTMxu0Vi9PZVCIRXEN9Dy6yPiZ5Sya7EZDyg0YjgWjRqkzsTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385316; c=relaxed/simple;
	bh=OGvgc2KneuynUrDgooPLkWmILwuReEjCUK/ToIEB4T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE/NXdq2r3sOdg2UjlDKawT0ArfOQ686/hV4zyou/mjwK8tFOsiIacP8d9iAZMaKfkWphpjjNvfGMjRUjgvbUup9q7MjgMmPxcOI82TvZ8xYxEE6Hb2BptiLUMaOUiCFGeng5ou2D9MalfiKMSvDymhUPtacQ5lfy1xJUns7bAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HbvToHoa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso33913291fa.0
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719385312; x=1719990112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nA1x+J+b2IT6ve0HpdA3/HCBu9mWxJI21oPGiFwWMyQ=;
        b=HbvToHoaQpXAe+MERM5s+Hx7HkWGFikkQQt5SThJ/GO4BqKffWF3SlT3v8knqJ/eBE
         EXFRAPzB/3IYS1b85dq+g3ffn7Wf8uJ28MKvsTRX/+aqPbrgUFz6gF6gzCduCHL3HvOX
         jUVakqGQ4NBCwwENAmubV2Vob38WgOdqcMy7VFkf5ab0jfQS10R3B7sH3YoS1JLhGgnZ
         7Xy2yVui1VCSAgKm6OL4dqrpscm/yoWt8nfGSealFFPLnRmxAkVfKFLbGxckYx6FOyGu
         sSn99y2LEtwzLXPWVaJvRE+zrI735ESIk4o3EXRdyn2Mcws2TbMeeLcET1qzAcVG0wxc
         FFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719385312; x=1719990112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA1x+J+b2IT6ve0HpdA3/HCBu9mWxJI21oPGiFwWMyQ=;
        b=ATegayfwqKhWxVkk6w+e8HpC6tEL8lmqweNjTcO8H8Nwn27X1OSya/NfMFxnRawW+P
         RQsQAEe8tSG4evCpeNXwHmgdk7YwAd8gJjOfHaRucQC64zp7l5oak9vZSS+ERqnrSlmT
         Iuf/hV4hpGzo1tcq7PXTOUa4qXIQDmeAX5cqg1hS9khSnbrX3etkcccPI99gf65lJBe1
         qlhYx3cPLPp9zFWwAo5XBKXEavFZzpfb3qSecnXHkNNrK8ey1w2R/Kn3TBVjdYux3enM
         LqY0gr8VJo1iqba/An/FaB4uUkQA/dGrh++9C+vFmZINlo1eC14jUYsx/LNMDa+OiAuA
         tVvQ==
X-Gm-Message-State: AOJu0Yynmtq1dptmpvIdfPjU1dl1IFOOsXr8qQGCQlc0OA1+uHP63bwf
	FJo+4tR+AfXM1OUBWxVx4dMi+sLfXkVi+VqTPyirql7FgxoCMMt1LZ9bEME8tUA=
X-Google-Smtp-Source: AGHT+IEtSqpX4nkQtBjACbvpdud+/3sMmzgR5hW4CEWxYnW1K8+1IXWBWBnIeK8FLwoR8mXLZCm0mg==
X-Received: by 2002:a2e:b179:0:b0:2ec:5685:f068 with SMTP id 38308e7fff4ca-2ec5b337265mr54240481fa.17.1719385312176;
        Wed, 26 Jun 2024 00:01:52 -0700 (PDT)
Received: from u94a ([2401:e180:8840:49da:ed05:227a:7b40:7717])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f053asm92434375ad.18.2024.06.26.00.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:01:51 -0700 (PDT)
Date: Wed, 26 Jun 2024 15:01:44 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Totoro W <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: your mail
Message-ID: <7occhv45aax2irfmy7ocevanzm5yhtpknz67lyndrf2iq67pve@j5nblmzivwyb>
References: <CAFrM9zuz8Wh5g7ykOkmFXwVdxgB7NQWzDbvv7=CEpEks54GnSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFrM9zuz8Wh5g7ykOkmFXwVdxgB7NQWzDbvv7=CEpEks54GnSg@mail.gmail.com>

On Wed, Jun 26, 2024 at 02:11:18PM GMT, Totoro W wrote:
> Hi folks,

Don't have answer to your question, but noticed that your email was sent
without a subject.

This looks like a worthwhile question, so perhaps consider resending?
Without a subject this might be easily dismissed by the maintainers.

Shung-Hsi

> This is my first time to ask questions in this mailing list. I'm the
> author of https://github.com/tw4452852/zbpf which is a framework to
> write BPF programs with Zig toolchain.
> During the development, as the BTF is totally generated by the Zig
> toolchain, some naming conventions will make the BTF verifier refuse
> to load.
> Right now I have to patch the libbpf to do some fixup before loading
> into the kernel
> (https://github.com/tw4452852/libbpf_zig/blob/main/0001-temporary-WA-for-invalid-BTF-info-generated-by-Zig.patch).
> Even though this just work-around the issue, I'm still curious about
> the current naming sanitation, I want to know some background about
> it.
> If possible, could we relax this to accept more languages (like Zig)
> to write BPF programs? Thanks in advance.
> 
> Regards.

