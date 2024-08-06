Return-Path: <bpf+bounces-36436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508129486A6
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 02:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51EB2837DA
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 00:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7726A947;
	Tue,  6 Aug 2024 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MMaCtAK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD868F6D
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904604; cv=none; b=UlI9ev2Ts/8M0W3A5pWgzb9z9baVb41VyHRVFmp/cPlzVxSr8y362N2AdCjlPClJiMY0np7daa8P+0R5zcZb9Ye5WTHMLp7hK/GHoHKZFo9gdWQmbTbyG4NSUvjzgpMEXtwPoWE60pA/uUPp03fdnw7enEfpQfM9yO280IvXq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904604; c=relaxed/simple;
	bh=7nXzsm5lZsyoe2KYHR7mAFN5Di2jrUPt9eEDIzEOn2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPf13zoV3z8Jy27Con2hF9alUyuCKzhfMEdjHXqm7wZUnKlR+jSouvcyqc0XPu2rsmdD4DlJ7vL9NxWzJFLt+RymlH6gFWpFT1RCjBLroZUcfNMYIuoiLuybirZwAZ1bS5vmE9MGfA0+sFEwPzDtpmX5hpq0QbWZVv+nrM60evQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MMaCtAK8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb55418470so36661a91.1
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 17:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722904602; x=1723509402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pplKHmr8EQUNWlMcxLWDiYQCbu1qDuf1WOvlJRSkiA=;
        b=MMaCtAK8q57Ma7YRldYy3uVY3Fr9DqeSpUx3n7E2+vQJlD9m2yOQum+p2Fo6bU6ITd
         H54CeLH+0uMzkH7yghHL/lC6jAr+Yln6N2WY0u79Ucx9IhJzzccLxvN7ztadbcAr8w9j
         wsynwBuCQK/FwTB8M3GLK2oTwM/qzlLFEtR2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722904602; x=1723509402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pplKHmr8EQUNWlMcxLWDiYQCbu1qDuf1WOvlJRSkiA=;
        b=ARJW7ODdkS+DU3AEv9G9hszT+A1CLZIzfbe950//EyYnCW1zrwV4OsRo5nQUTg2Z+A
         Jwb0cUaDCiSPJpOb34CxF1hfacketNeaBUZHGLgIWX5xGbJFG/BOGmwpb9IxK/OTlrj3
         6FjGWgmn77wHhFL9DPYp8FGjiIZvh8jU2WU2/AqV0x2wXuvVZmlDmAhoP1CVWsFrenuq
         v+H9YQosf8oJK1Pad0jozq/WfJEF9oFtMTsbYGymBrBDYHoB0Ja5SeQn1JyyqaT1Oc7R
         Quk8R8YqHlPS41qoEcrpvh8aX1Y8FY9HRdx7DxoHe2G7CVGqera//EiuEiPe0RrI+c95
         b7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWeHvZWqu7WyP6D138usBs4J3Quk0RNuZX4fCxMdnSQa2iV+TvmEVcl02VK2NzcZ64o8dLyDvzRjxzReEeW307Kb+s5
X-Gm-Message-State: AOJu0YxDI7XYyYCfqCSpu7TY/HnagwAMSe08COqZ2OqY62jsUiiRXiZ9
	7NH5YJXs+vxoxf+iuHh545QeSuCJyKaG4L3BL4vz2/pjlHTsbfbC6ZEc6nCbl+Zu8kCQi1BFBQ6
	Bqd6WKVEB0tpgsU51Su+p19Q199b4WfpZosmW
X-Google-Smtp-Source: AGHT+IHB9BEhSWGe9GLNuS6Dm7ZTZZe2UpxioIrIh4RcepSEQAn5YPOgfkAxaCARqqd+KnKQ1tppT5pDOwojFV3vL6o=
X-Received: by 2002:a17:90b:3643:b0:2cf:ce3a:4fef with SMTP id
 98e67ed59e1d1-2cff9445836mr12346878a91.19.1722904601682; Mon, 05 Aug 2024
 17:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com> <1e6e6eaa-3fd3-4820-bc1d-b1c722610e2f@lunn.ch>
In-Reply-To: <1e6e6eaa-3fd3-4820-bc1d-b1c722610e2f@lunn.ch>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 5 Aug 2024 17:36:30 -0700
Message-ID: <CAMdnO-J-G2mUw=RySEMSUj8QmY7CyFe=Si1-Ez9PAuF+knygWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
On Fri, Aug 2, 2024 at 3:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     user_ver =3D stmmac_get_user_version(priv, GMAC4_VERSION);
> > +     if (priv->synopsys_id =3D=3D DWXGMAC_CORE_4_00 &&
> > +         user_ver =3D=3D DWXGMAC_USER_VER_X22)
> > +             mac->dma =3D &dwxgmac400_dma_ops;
>
> I know nothing about this hardware....
>
> Does priv->synopsys_id =3D=3D DWXGMAC_CORE_4_0 not imply
> dwxgmac400_dma_ops?
>
> Could a user synthesise DWXGMAC_CORE_4_00 without using
> dwxgmac400_dma_ops? Could dwxgmac500_dma_ops or dwxgmac100_dma_ops be
> used?
Yes, the user can choose between Enhanced DMA , Hyper DMA , Normal DMA.
This SoC support has chosen Hyper DMA for future expandability.

>
>         Andrew

