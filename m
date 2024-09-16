Return-Path: <bpf+bounces-39993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA4979E60
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ECE1F22A76
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A73214A4D1;
	Mon, 16 Sep 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvihebfl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B56149C4F
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478583; cv=none; b=XgS540iIvNBo4zSOVXSK3C/ml13KSVMLhcfYDtVv+E8kYr9zyPyScF4q0dfWC4tDk5u7jIUl4xlWeWc7i/yABGPIH51wEFjPOpNfLTUxoFTccaww/JpTEdTIk/oIQHldNIX0D3/SPjBybk5Xu5YIY8SNdTdNsFarb7DT/zL+vEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478583; c=relaxed/simple;
	bh=y09cAINBf6adaBgmqJlVXKavgamvxOnFxR+f/cj4Ua4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzKvbANKWaW07y6nl8v6zxBdX90gmkLrk1uHNzXCMIiSABskjSxUOF085CknVda3SvDeNceEx9QmgZAHf3ReKTsdBp3NfpNTx8aEM0Grhpx042WMJKG0Hyuz9YTaI4ZKId9Bn7nstB0z9EQZNhLqPrGEva+qYXdu/ZU2Guo+NPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvihebfl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e11e4186so4077138b3a.2
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726478582; x=1727083382; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y09cAINBf6adaBgmqJlVXKavgamvxOnFxR+f/cj4Ua4=;
        b=Gvihebflwi2Cfto89F1B/JnbnrsHfHFOXiIMB6r2LXlsWy/ZoNxc1mmYnxN5tZW7ky
         otIHEhwO2EoY5sxnIu4l0GKeSXlRkz2JVyGGua6MrZL162xV3VuRLnnTkG5Qcm1Wmh3K
         6gpPYHVqeb6/4OvBaUHyUmag2ew5TczCAo5E8L1LEML4stFjsk9kk5aar53eN5BrrONW
         N7JvCoR0MUWcVX5mXLxctqCAklklm1RQS/ajuBiz+3ZRQPWz8qvtUBSKDxyVksVApbVP
         XH3D1p/5kR1mlOyHNgzpia2cEnaGW5xXsZ7qlGm7iwsrKhMla3o90hXSkr44klCmsgU/
         9SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478582; x=1727083382;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y09cAINBf6adaBgmqJlVXKavgamvxOnFxR+f/cj4Ua4=;
        b=AvAYsBSFAOjCqr6PXo0Sc+vNEElPO8/bSFtKL7ism49JXMe/3IXRKX2RN05A0FkOZK
         TnSOwzEBVLAd+KNP2Y+XOMOaxoVqo4BnL09loMMF1IuUjnQC4GGprmGPdMJ2MZ7QIlqf
         +qx2zztso3IZCIx0+57/8Y/ceH/9odGpkdTIHiKMXQXHd8YictqgNZBAGfqfmpK1ae4p
         PnB0KR27OadaKelMYl26yeOv87V8KDMk59ySr52SENMWLV6M7Ifi95BbkodpcUA5Qfdk
         MWD6Grq81YqX3Bi4qctIywzgpPyNGtZJa3MQoxYR2xB/CKCk2Dx5Bi0jFDLljMuu6fIM
         +7AA==
X-Gm-Message-State: AOJu0YzOPwImwqU5bOgXD+OB7nlFoJhNcmRK3b+uA80LjqQXkQxSdZSF
	9U9sapNal2ESZ2dKng8uoINIZ2wB3QKpf335wffqvFUbfWdETQS/YJHdZg==
X-Google-Smtp-Source: AGHT+IEN93IpcvW2dg2wAbUa+vA1HgiBTc6nF8NYXkm+ysw5q6uBxMXJqirJmuVWR9k2AoiRNC//uA==
X-Received: by 2002:a05:6a00:244e:b0:719:2046:5d4f with SMTP id d2e1a72fcca58-7192620670amr22987108b3a.24.1726478581451;
        Mon, 16 Sep 2024 02:23:01 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ad3dsm3366889b3a.180.2024.09.16.02.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:23:01 -0700 (PDT)
Message-ID: <c57f0a12b81a2b3469326fb24ca018e03d35c15a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] 'bpf_fastcall' attribute in vmlinux.h
 and bpf_helper_defs.h
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, arnaldo.melo@gmail.com
Date: Mon, 16 Sep 2024 02:22:56 -0700
In-Reply-To: <20240916091712.2929279-1-eddyz87@gmail.com>
References: <20240916091712.2929279-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-16 at 02:17 -0700, Eduard Zingerman wrote:

> Modifications to pahole are submitted separately.

Note, corresponding pahole changes are submitted here:
https://lore.kernel.org/bpf/20240916091921.2929615-1-eddyz87@gmail.com/

[...]


