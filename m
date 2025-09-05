Return-Path: <bpf+bounces-67605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8953BB463C1
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7B41890FC6
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885927B51C;
	Fri,  5 Sep 2025 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyJorUPd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63933271468
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100993; cv=none; b=eP097hkQND4z9Vqin3g4WPHHMaFf46uIaWzj7kpd2PMJeDxb2FuX1rdNfoY/ybFDmhgcIxSxU4dKENYcuYSLOS9XNZyQ2H3ZrkeyzLrf9Wsdjv20CFCobThro5fMuyaEjlvZD0QZhdvJEQK12Up/ZFQAOruMHY+BRd6koUDSYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100993; c=relaxed/simple;
	bh=YecS/BIRs3C8Vi5x1OayNas5XGZ8wmb15SkDFrVLxWE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDGjNU9wep3DtLpNWUTN68yhR49Sz4yEBS9m8Vnhi5b49aPiECzJ+BaimQsVlaAPtsjEPkl+jZUVpcEQEv9W45HM1rVJT6XA79TfwoT7lhuTT9xcNqFUn9brPBV7L3+gyPdQtyK2y3Ou+WxZhoiDkr4dwzP42S3crQi6CiRjUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyJorUPd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445826fd9dso30273925ad.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757100992; x=1757705792; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YecS/BIRs3C8Vi5x1OayNas5XGZ8wmb15SkDFrVLxWE=;
        b=QyJorUPdTa0osOFfkrauS7VSPju40Bo7KIwUEWBQPoZtVnntmi2eXM67iyXk4E1YC/
         fedjZyHTJVS7xFJPrqgiAjXrg1XAiyC6ny3Hb65FZW6BRsJipcEbCb6QcTSSI4ivlWHH
         1FK1gLqHABundODYmY3fn/NmkRAp7FPgm3psvHrrDIubOxhLsBuSxDjqm05/qS8Zckvi
         iVnwQRrEf8zJvINLxPT8jvZPEsXo1t0tp7To1bvEqS+BW1bv88lMEFIDoFe1mvgAIo33
         /LjtlU4jFr/bDwTj8HzRxem/KTXeE7Rat8G1v2Fzd2s/9CWBimpaJ1TtXyQ5jSwTSvRi
         K3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100992; x=1757705792;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YecS/BIRs3C8Vi5x1OayNas5XGZ8wmb15SkDFrVLxWE=;
        b=R8ATwCxMBqqSPIRaThZUj3ltaxAHR2yxPVkr1L3B9m3bjcEJ2VodCms0rB02uB/cx4
         AKSh1rmjUqVQuhBBeSSe7llEjmgS8cqBClr1/Z6zVBRjj9oU/EVR7ZFl9akahBWQIW0p
         +53FTwS6+9fp9qCWb6XZ062tcFVAQu+8uhT7lwOt443c3EZ53ppprvINM4UyfWRd75e3
         1iajfemTKChajx/QEoSEVU056b1nKy1hfeq174xHJYvWEAg56UTilj5RIIm2mbEOIx/Q
         6864wH1V+u91viYC/yDTmlINeEPSeK6H53fIa7a/FX7pfrW4xeTP8sNPJyG3522g0mC0
         iD9g==
X-Forwarded-Encrypted: i=1; AJvYcCW9m4g3OVkA/SyWPP9mop4Nr0+/vTnTzhxk5TCUJTr6YshHsHC7SSMI1LbH+P54nwDBV4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmxFg8ve9p1MMbGGPrlQ8irSm12U4zfkEz+2Is+Y1CBmb9V7L
	msXb62MGNp5FsUbGLoDxvfJLemg+m65Cbhauvcht5ARovkndnsMgx/QF
X-Gm-Gg: ASbGncvsyQS6JkFtKV9jI/R81IfJrTNWYXsOMhNnFoyPzNzqekl1+r0y1VdNC97WpkD
	lIyL52y3KS25Flru5/fOOMWVKGUu8Ou0fTXXHVaCda6Uya3s5J59qatiDbTWxCAQTALnQn7h7U2
	jgQD1f8vm0ZnY+btVXgFxWYFD1JlXfIcJ+7RoUhA0IJlmwbRCkfeN9FEeQ1c18/vYsaeLga//E8
	NgYh9+IlDXq3YRk3xDXwTLbUer1V9HHsmcslMETU4zS5rFX4cEX64VpSmytL6iXwNylpYsobu5L
	eBuRucLorWesJHwhcASIBTjrcdEpTygR7SutZWhV1TAKyWCF/j+hrN5pxSGUGRDDJ64EU0x/ttg
	UsfuXyHwkAfRw+NB+Pw33E6Vlai9Aoykcl4+kWNI=
X-Google-Smtp-Source: AGHT+IFANHT0STJHLxDeZKyJi0e0f9/uQZWFqCE0UA/spmUM7ttHOwK+wZKVQTo/KJspNUCOsxhBpQ==
X-Received: by 2002:a17:902:da92:b0:24c:be1f:c1f3 with SMTP id d9443c01a7336-24cbe1fc63amr113103825ad.35.1757100991619;
        Fri, 05 Sep 2025 12:36:31 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cde5b6484sm39787455ad.19.2025.09.05.12.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:36:31 -0700 (PDT)
Message-ID: <9da2cccfca407012506e700089fe298d3edfda2e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: refactor special field-type
 detection
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 12:36:27 -0700
In-Reply-To: <20250905164508.1489482-2-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 17:44 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Reduce code duplication in detection of the known special field types in
> map values. This refactoring helps to avoid copying a chunk of code in
> the next patch of the series.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

