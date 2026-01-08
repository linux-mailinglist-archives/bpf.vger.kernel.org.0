Return-Path: <bpf+bounces-78230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DEAD03844
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 15:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC83D300A3D6
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE80389E03;
	Thu,  8 Jan 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPcKelfH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qL5xVEv8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEE34F241
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883508; cv=none; b=BpRcJuJm8TwJmV6s8R/rGSXKQu1r5JwFbtpC7Bjif7srJnmNMcSHmWuxQCjJQWQ3aIckn7NUOcxJUgn1BkQ9zpCP12C0F1MNpeQ1/FuoKejcMixaP3AEXt5IL/hWwAovxmDoPfk28KcmHcvj/lA/qVmkzkcPDCgtaf+KehzPRbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883508; c=relaxed/simple;
	bh=2ikIko3KGMz2lxo6cPtvzB37bbtbezApYJoyH7zP/VA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dNdd5NTEV02RrzaOfu8mENtfHudVY0C86sU4DH9+SVOW7GoKSrRFF30d3FnrZlT3OnhaNltE9G10qi9x0ZqeDSLmQpCx3g0VTZXl7VZ1TltTq15ngSKvgnYFuhRLmnGn+qQX+q6GiDaiKb62AF8cpLYKvFcJ3/lMJuD5N+MN5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPcKelfH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qL5xVEv8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767883502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/Q7qpmP8A0+7zNfRe33pEqqMDnUmdV8WNFELb0p8Po=;
	b=ZPcKelfHmFP5kQWg81qncdP+1uqE1GmqxaRnnuIMpLh+eEGHAAThDilWFaadIQTiXkZC00
	spc+b49EAAEeNn1iVeROnekuAxCvTWQmb0hb+4gLNfZBS2kFF9TRGkPmjt4UWNeTyfdOTB
	9UdMlpNYH0uhwyKaYeMAAzyc+dEI2aI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-apFYWBanPvyqY7PP6HD5_g-1; Thu, 08 Jan 2026 09:44:58 -0500
X-MC-Unique: apFYWBanPvyqY7PP6HD5_g-1
X-Mimecast-MFC-AGG-ID: apFYWBanPvyqY7PP6HD5_g_1767883497
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b721aa1dac9so267453266b.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767883497; x=1768488297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/Q7qpmP8A0+7zNfRe33pEqqMDnUmdV8WNFELb0p8Po=;
        b=qL5xVEv8dAp7EyKck7LJOb8wCRJLY2bzjg10LosuJ4aGUXXq1KYU9SBQHIekxu6Eag
         SDDKv7pagT5fBa83wU9I/ZHZhnv4MeaXoawDXEPvrjEAXINTVWRjf1Sl3W+E/Rl9LB2O
         Dh92py/UtTvIvB0hCUiQ3dlJNKIjru/RZ36T7lYMfzTi323e7jBZ30/083Qe2wPLPGUf
         kd3HYzKhijj8f2anZh4IOADs4e94alUEWlwJ5E5837Z1wYOn/u6H0egSWQWlf0511coW
         o7BcnloBLgdrnI11i6n6DCtH4UXzpYLDIqe+i+EDJG1E1J7aVGQ68dmXwPL9rpkiUint
         8BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767883497; x=1768488297;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/Q7qpmP8A0+7zNfRe33pEqqMDnUmdV8WNFELb0p8Po=;
        b=UjuF78Q53LUYBcCm9qia3n/+bVjbJLIW+Q/7GrlqOt/fwyVEqSyQRgrzkoL0uIrJjn
         5x/Du4bf3oO4ZYAFmgoQfU1jdQ136fWCoj09FZd5Utna2zPLIz4VUNTKRIEzVZDsLqw/
         pTFd1D3Or6B+lWlAeMtb7XqHPBAt5xxB0Y1Qaym3Xd0O+H2emeHFT9ECm5zCVu9VezjA
         uC9OVvRd2Pmx6aqjTjz7XdkE3Py/+W1CvCurelUiSropNr04RgwiF+D9mWJ4Cx6kZQPP
         Y8HNaSGbjAL1/ft7UHKM92cKmURRTveX9w4w1pQhPWL1H7fdmj8BKZjThnnYZmJidg9d
         u3+A==
X-Forwarded-Encrypted: i=1; AJvYcCU3H+KSBtmHB/dH1ZhaTcnBOooT+8KbgmrqGjnfnrzRzGz1jmlYDPV3rdPhxcPD30FLgAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWaJLBplucArBojPZLplYB+X+rw9cEZCM+6+1DBYrCTgNZs+p
	RFQSvvAZAESqlkS5jiN5+MPudYoiQAlR4V/0SI8/xpaGH0l6dLvQpJsQHoguZw8Y3jEug2bAaAY
	4Mww8qC9RpwXHDnMRkdqClIFxO0wWGOhLVa+oZMV4Iyh2nfhD9dBAYw==
X-Gm-Gg: AY/fxX4npqsF/2m4CK1Pkt0xq5YhP28S15OCRNsB8ujQgaNe2rTGIbyFy5ySCcstA0Q
	MEsxapdCHwyg3+pcYmCMa2gbKueR9crlKurDwwF2EIqZ07DDSXDDgXrQA9UH6urZSwsDjvgDJJC
	Qo9l1AsyI/RmU3aJ1fkTjBMdkpTBW2NPtiOj54QlI7WU2wJV1Y7TsYUn5m3ggMaF3vlmmfxPIU7
	lq5nOcznKNLA+QhLE6kjt33Q3RNw30msOIDIwzVn489xr/1QNisTWf/X16RZ6jvUCdgDGIwFLmt
	CE6uIqlE/uqagGEGfzZ7lQjsAclBXS7T8ZF9nUUzcg4FgxUhdXriJ8N+mICHBa04RtNh1CE8PUZ
	VsKV1N+/1FE/r0Ka6Ji62g91SbfZ+F3FUjg==
X-Received: by 2002:a17:907:25c9:b0:b70:4f7d:24f8 with SMTP id a640c23a62f3a-b8444f77113mr649071766b.22.1767883496855;
        Thu, 08 Jan 2026 06:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcPSvlJsD8p2A3/nMpOjV9vchPE43dNxE7Zk85KfgaABHa/y3pNk4yLxoo08W1VeA6CV/+PQ==
X-Received: by 2002:a17:907:25c9:b0:b70:4f7d:24f8 with SMTP id a640c23a62f3a-b8444f77113mr649068866b.22.1767883496464;
        Thu, 08 Jan 2026 06:44:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe60sm817928666b.45.2026.01.08.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:44:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 30AE0408381; Thu, 08 Jan 2026 15:44:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Alexei Starovoitov
 <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] bpf: fix reference count leak in bpf_prog_test_run_xdp()
In-Reply-To: <1db0fa14-af3b-47e6-93dc-0adffaa3d934@I-love.SAKURA.ne.jp>
References: <af090e53-9d9b-4412-8acb-957733b3975c@I-love.SAKURA.ne.jp>
 <87qzs02ofv.fsf@toke.dk>
 <1db0fa14-af3b-47e6-93dc-0adffaa3d934@I-love.SAKURA.ne.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Jan 2026 15:44:55 +0100
Message-ID: <87o6n42mfs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> On 2026/01/08 23:01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hmm, this will end up call bpf_ctx_finish() in the error path, which I'm
>> not sure we want?
>
> Excuse me, but I don't think bpf_ctx_finish() will be called, for
>
> +out_put_dev:
>  	/* We convert the xdp_buff back to an xdp_md before checking the return
>  	 * code so the reference count of any held netdevice will be decremented
>  	 * even if the test run failed.
>  	 */
>  	xdp_convert_buff_to_md(&xdp, ctx);
>  	if (ret) // <=3D=3D ret was set to non-0 value immediately before the "=
goto out_put_dev;" line.
>  		goto out;

Oh, right; I think my brain just pattern matched on "if (ret) right
after a function call" and assumed there was an assignment to ret there
as well :D

Okay, not the clearest code flow, but not sure there's a good way to
make it clearer without quite a bit of refactoring.

>=20=20
>  	size =3D xdp.data_end - xdp.data_meta + sinfo->xdp_frags_size;
>  	ret =3D bpf_test_finish(kattr, uattr, xdp.data_meta, sinfo, size, sinfo=
->xdp_frags_size,
>  			      retval, duration);
>  	if (!ret)
>  		ret =3D bpf_ctx_finish(kattr, uattr, ctx,
>  				     sizeof(struct xdp_md));
>
>>=20
>> Could we just move the xdp_convert_md_to_buff() call to after the frags
>> have been copied? Not sure there's technically any dependency there,
>> even though it does look a little off?
>
> Unless
>
> 	xdp_md->data =3D xdp->data - xdp->data_meta;
> 	xdp_md->data_end =3D xdp->data_end - xdp->data_meta;
>
> in xdp_convert_buff_to_md() lines do something bad for the error path,
> I think this change will be safe.

Yeah, sure, this should be fine.

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


