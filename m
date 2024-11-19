Return-Path: <bpf+bounces-45154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6004C9D2255
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2251B23AE0
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028D71B0F0C;
	Tue, 19 Nov 2024 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDDYHoth"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123B1547EE
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007833; cv=none; b=IAShgpQV7SjOD4U2TG/vQt7lDHiuoNZLO0oM36UBumBXcB/86KvwsGcjVT4ughWY/R15d6Cc3P823455qujnK5C1mF84365zo8xFQVL7e/pEo6AUCyjrM4xFYgJN+KF3c3J6Y+VsiUZQHNfZ2Ec4IAgFjJU/cFWexvsFZVogYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007833; c=relaxed/simple;
	bh=g810kb0XgvzxYZQtrMTm+l/lpKzxxUTGIDTHgLMIkq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmgdQanX2cRZn1d4dexr+OPfkB5+kiRHPqXVRSKE/RxVWwENb3YsqHknP4GIbCdgGanjjaggiuzAp8dcZU347/Pum3Wi87vrzWFo6WqEFUxfP2gibwG+lAjn5YuC/AHUM7fH9CGd4argXrgXBrHHAcWf5sahJxqn/zPr6uyUOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tDDYHoth; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ebc1af9137so322527eaf.2
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 01:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732007831; x=1732612631; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mh9tKfQZDVb7Srbzricoyx+VzVp7BjyJVZmRNXjCsTY=;
        b=tDDYHothy5Z8/MjQH9Uv+r7JVAFrKy+UcW1UzNJVH4LkuEjXwkswPEAwOqq0J4mGPr
         xv8z1M4e+t/f1wEgLeW1FxNwrKFv/umbGPvkjvEm6DBD2mTUldApLSaUFuSUXN4kuAWH
         Gw+kAnHWHhYd86+MVJGfFRjDxsavf8pMq1cO8Q2pwS2OdtBcRdEyWsNK025zOzDAIfG0
         vjIyiZEXpv/youE5cTlbAKkyU7yEiYbDkCsHVd0nPMpSamHdjR6chHHicy+BM4wl5mWo
         ZfpLIf4+2ahMBg+6iFmPOZItFS399UAoXqUxvd8JZzzHigus22NAWo7TRRXZlxF3BU3Y
         EN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732007831; x=1732612631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh9tKfQZDVb7Srbzricoyx+VzVp7BjyJVZmRNXjCsTY=;
        b=GioiPJCFV/Rwne4Q8p/FfOpgWJq05TIlmlYJLsDv4J+NsdW9vcUE+pvhMtM13rJpJb
         qBH+XkA+3MGRPX5WyjcaoJMD1Mow7DuEKPAJpTEIQzCZOi7BdtPEp6+W3vIsKJR81OHR
         /rSoBkt6ZyEpWkkRocEXVVIlzwpUQTXLuVzccT6ytKgM6rucbbFxr6YnSfKygd0uHSSI
         vKtmDek9D9QJ+gibWmhtBUb2PmR88JdroKFkJ3ru/A++DXyGtIFGZJn7zhZsHM38SYDM
         ZOjFChUQ8ZfOGNc/y+rjxqjs/knyZAlRvqybRFGYAQOLTVjcui7V4hdB1GwfbWmvh3Az
         eYOg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4JaX0QNvvuDNnp9QVTdgIbr3tKcdeIRvB35yEw7+SXxbArNX0Sghv6yPW5epGC3orsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dyAOvbI5KBKi24WKEJreQ3vLr9Fvnt2wPiEg02qs26AbYO4l
	oUwzYNYMLXNp4puysDK44q3VW5+67icMS+CgAKO/7ZrOmQPZCgkkMz5QWVUdZQ==
X-Google-Smtp-Source: AGHT+IF6oNS7zAaqiMj3qBtazoexGSI49TeW8s00tlEKm6P+2kEMfwF3rimz60UqsKAumxJWheQLUg==
X-Received: by 2002:a05:6830:2a8f:b0:718:a3e:29b7 with SMTP id 46e09a7af769-71a779213bamr15070132a34.7.1732007830619;
        Tue, 19 Nov 2024 01:17:10 -0800 (PST)
Received: from thinkpad ([117.213.96.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dade0esm7241941a12.66.2024.11.19.01.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:17:10 -0800 (PST)
Date: Tue, 19 Nov 2024 14:46:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <20241119091659.rmdufvdi6jkynvfe@thinkpad>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
 <20241104-imx95_lut-v5-2-feb972f3f13b@nxp.com>
 <20241113174841.olnyu5l6rbmr3tqh@thinkpad>
 <ZzTrdUX0NUsHQLvd@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzTrdUX0NUsHQLvd@lizhi-Precision-Tower-5810>

On Wed, Nov 13, 2024 at 01:09:57PM -0500, Frank Li wrote:

[...]

> > > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> > > +
> > > +		if (!(data1 & IMX95_PE0_LUT_VLD)) {
> > > +			if (free < 0)
> > > +				free = i;
> >
> > So you don't increment 'free' once it becomes >=0? Why can't you use the loop
> > iterator 'i' itself instead of 'free'?
> 
> It is used to find first free slot. This loop check if there are duplicated
> entry. If no duplicated rid entry, then use first free slot.
> 

Ah, so you have combined both in one loop. A comment on top would've been
helpful to understand the logic.

[...]

> > > +	if (!err_i)
> > > +		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
> > > +	else if (!err_m)
> > > +		/* Hardware auto add 2 bit controller id ahead of stream ID */
> >
> > What is this comment for? I don't find it relevant here.
> 
> The comment for why need mask 2bits before config lut. for example, dts
> set stream id is 0xC4, but lut only need 0x4.
> 

Ok. It was not super clear. Could you please reword it as below?

"LUT only needs the lower 6 bits of the SID as it will prepend the 2 bit
controller ID by default."

- Mani

-- 
மணிவண்ணன் சதாசிவம்

