Return-Path: <bpf+bounces-38686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED6967B93
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 19:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC3B1C2149C
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA7184529;
	Sun,  1 Sep 2024 17:55:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AC17ADE1;
	Sun,  1 Sep 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725213331; cv=none; b=oY/LWyaMWGtLRi+Jq1AZEGviYNxlqmsmG2NXOeDCldGzGANYRI3BF63GMMXsMtAN8g9dm3OXJbPnsWKv+AZAbw4P2gag7FjOQ7NBsgGPkCm3YLIXSHC7Y+Ydd6N0M5G3nQu7zhOzwFsSoj8zBkcbtdJEktqgdODCo2igl5MCcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725213331; c=relaxed/simple;
	bh=IM/chwYrXihDE8FLF8hiPYl6Hkd/A04mZYL++PJG0ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNZDARET1Ujf1Razb8DDI9o1w0C57U2qpuSXMech/XQuGkunkNjpMM1Xeezx+1HBzBdmIayX9Xx6V/86FBIFp2cFSMjBp6D2lgMSnXRhKJFYAUkM8oIFTmdZZFqpfPSKJZHxWh9Y2kcdjfLxtNIxvg87B2uUhzx9bnatppEdSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d30f0f831so12645055ab.0;
        Sun, 01 Sep 2024 10:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725213329; x=1725818129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPCSj8FBVReSaeYCO2iGVjW5XuPs23A+QCwQAzU/9t8=;
        b=e0O1oUo+fOvPZaQr6f1CGJe4Y+4NRSvpFkM8VC/udgHtzL6qr4aNR5Z4C8UmWjnLvM
         yPKrPf7rtrjp+e9gNZc673Hh7Yv+WB2OEXqVkaLbBkW5b+Zw+lX36qI8hprklzS6MBwx
         pydwVeY5JbgaXxQzRMtiEOUjEsj32e9H+SRvq+icpSr1SSVLo43TiXe0Szt4J9EePKjW
         Dnfje+wX5V73lkqE0wJ7T0qyH37vT8nURs+iVS2yan95IqHMtf+uyK+YaEOtH5XiY6qR
         ZEZ6nfzKbNLImcRKQCXv90GEgaAGEHby30DoSG9WkEcnYTLDU7zrTItJ4Bmf7YeLd2nr
         bkyw==
X-Forwarded-Encrypted: i=1; AJvYcCULzz2WtW9/QtcMTwr2c1wIk1m6JKGOIleepD0LKwXKevmOCwsPIdUGFKWl5vGUkXP09d3I6p4PE42Q@vger.kernel.org, AJvYcCUhSwOXiDNG+3qf1FN1vGwx8RY32DK7TXcFVjLxCyP8X6O6oINcHggcJ/l6S55tYPJXJN8=@vger.kernel.org, AJvYcCUsI0YQZs2FCNAYmbukke9z4F4l7ov803BJDa0xNvO6muBo641UbantfHvUvYKfkCaKXANRPYZnU3HOCgy6@vger.kernel.org, AJvYcCVFJjS+TgR8sNB3JLA82n6AwK6qfYPe5n+G7V7mIbwC3iA48g9Qi6WIY2GzsFhaowPw6vQh9FQQmh20Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZpi8DAhszWOLJOlLs3gnyG+zcqEPXUH2Wz53wZYyOurJPsxe
	JdMhDIfEM56W5VjnT2Jq8ndHR8VtH4jcLaBq2Y275Mk6RxvlCaO1
X-Google-Smtp-Source: AGHT+IHBzBuDzpmGhMq1SRqwPuQgXk2zIrVcNlSo1Z3AcvkCcvK8Npof8O6DWfAfKPf7z5UlPibP3A==
X-Received: by 2002:a05:6e02:1c23:b0:39b:25dc:7bd6 with SMTP id e9e14a558f8ab-39f49a1fc8cmr69803675ab.4.1725213328575;
        Sun, 01 Sep 2024 10:55:28 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e74388dsm5295193a12.3.2024.09.01.10.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:55:27 -0700 (PDT)
Date: Mon, 2 Sep 2024 02:55:26 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <20240901175526.GM235729@rocinante>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>

Hello,

> Fixed 8mp EP mode problem.
> 
> imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid
> confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to
> pci-imx.c to avoid confuse.
> 
> Using callback to reduce switch case for core reset and refclk.

Applied to controller/imx6, thank you!

[01/11] PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
        https://git.kernel.org/pci/pci/c/c9d04436880c

[02/11] PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
        https://git.kernel.org/pci/pci/c/f82e7aa14378

[03/11] PCI: imx6: Fix missing call to phy_power_off() in error handling
        https://git.kernel.org/pci/pci/c/3268637c4f74

[04/11] PCI: imx6: Rename imx6_* with imx_*
        https://git.kernel.org/pci/pci/c/09bec00b3591

[05/11] PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
        https://git.kernel.org/pci/pci/c/8bc6b9ccba59

[06/11] PCI: imx6: Simplify switch-case logic by involve core_reset callback
        https://git.kernel.org/pci/pci/c/79049b791bbc

[07/11] PCI: imx6: Improve comment for workaround ERR010728
        https://git.kernel.org/pci/pci/c/ea7eddfc0c9d

[08/11] PCI: imx6: Consolidate redundant if-checks
        https://git.kernel.org/pci/pci/c/dce6ed132a2f

[09/11] dt-bindings: PCI: imx6q-pcie: Add i.MX8Q PCIe compatible string
        https://git.kernel.org/pci/pci/c/99807815121a

[10/11] PCI: imx6: Call common PHY API to set mode, speed, and submode
        https://git.kernel.org/pci/pci/c/b7e35e029881

[11/11] PCI: imx6: Add i.MX8Q PCIe Root Complex (RC) support
        https://git.kernel.org/pci/pci/c/3474e6ceabdc

	Krzysztof

