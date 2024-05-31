Return-Path: <bpf+bounces-30993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76B8D5899
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 04:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34635B23851
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 02:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A4577117;
	Fri, 31 May 2024 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4Nx0sdk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459E20DC4
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717122242; cv=none; b=TdR5XU6MP2U3uhsrcM9Pth+TlOa7VLehvJTr/eq/SJQw+DxxYK84piParkdjlAboITxLm7sufSeQ9s8oA3DAUfdGrp44pPVA92aXnEsBceS+j2YjTvu6H9Tt7KTe7hzssHi2xy0n+sMNAfcXl5A8XqZR5rm1zowYeRTFGfoYIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717122242; c=relaxed/simple;
	bh=2VyK1TEY83pB4ARWUxhOrY9Y44B/is7B6SKi7QXejdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHh6DWlMS+22DWpHsZ6LCvmOtWiF0CuThhdzZYAKN1wx/x02SnOKI1nfPOs7EpVO4dZlGJUbpEG4RLCYoN5mJUDzgF05+vljW+w0PV51qO1OhyF243yLyffvJRjl8163f4jz8H5B03p0QVarQ+IJe69D01gX5l1XFIH2IzsnS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4Nx0sdk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f47f07acd3so14200455ad.0
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 19:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717122241; x=1717727041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2VyK1TEY83pB4ARWUxhOrY9Y44B/is7B6SKi7QXejdM=;
        b=f4Nx0sdkUrgQovXgO6o3oKd6KZLzGvNrbboO4MvARYjO08ldzjFcaaO9aDEwYCpVfy
         6O2KihQK/saTYNC7Cek3YlsdTNDxXQLU3/lf4YXiTruLfzMfJlDJl+TFB09/NBwmnDO1
         teN22RyQSzlPN9rng8pVwhu9h4O5oKyaJiQj3PpgRotQyaJByaRH25oeQu1+D4wm8VbV
         MdfpTLiutFsfxkBQTLlSqebflq+is5ojllLiGohkhtt/CxPCB1PDv0+EtOqC6oW+oIdH
         +93XWC2KNb3yQ4qPCzx5+PvrA3mxPulOfzy+u65EV8D1Q4G8DR8ti7fuLVeo5b373MBV
         d+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717122241; x=1717727041;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VyK1TEY83pB4ARWUxhOrY9Y44B/is7B6SKi7QXejdM=;
        b=jpPulIZ1trmZM2E+ZN1FsXN6+KTeKyvKdlZaz87eXXqd1U/Cpdv/9z99HZkjjF0B8p
         OC1T7mFVeB7awJgh0jLoq8SMFziNl07Zf888uQBHIfP5WhVAdXcXqaJ8PKrIEDHq19A1
         t63SsBNR+0+udNnjnMztq/kJs03WSt3t2ncaeF+ypwa1k/psOk6OeVJzxEVsovSETogV
         D0P7lj+iQYXXrMEQF+wuAY65xDcjAUna+h2y3iMSjeac+8VrqBaxUQ3JJNY1dmM1PGQl
         shcwphxTMgclXr43RvUPV8laFUvmLx0ZQz/htuSw+qh88kkKGNt8RmA5mc2q3rTlDi1h
         UrEw==
X-Forwarded-Encrypted: i=1; AJvYcCVG9OoHmLIiQv1I7f9+jb/qJTkpe6LROICVGvypV7bEhtMzyBH1pRVo7fS0sIupnfowCW5z8DxIpwa1OTkyn9A7uB5f
X-Gm-Message-State: AOJu0Yy26L8Ro3RkaVh207yYHPAtVOaW6GdxO1nFUBhlsEUBTjtqGoxn
	8dXFQnsw//DBPU2e/B6wABl2vu8qOHlXnr/9+LffD1FO9uGL55LH
X-Google-Smtp-Source: AGHT+IHmdn+x9BliUXwdHv5NjGDTHx28f4/NAvzAM9THGYkWyEYOaxPcG7iW/Dv59a0xL0U/139QPw==
X-Received: by 2002:a17:902:eccc:b0:1eb:7081:3e23 with SMTP id d9443c01a7336-1f63710b3d1mr5998315ad.66.1717122240849;
        Thu, 30 May 2024 19:24:00 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632356aabsm4806055ad.78.2024.05.30.19.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 19:24:00 -0700 (PDT)
Message-ID: <66c463fd6ebe645a4469638a64d3439ebbc7a963.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/9] selftests/bpf: extend distilled BTF
 tests to cover BTF relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Thu, 30 May 2024 19:23:59 -0700
In-Reply-To: <20240528122408.3154936-5-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
	 <20240528122408.3154936-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 13:24 +0100, Alan Maguire wrote:
> Ensure relocated BTF looks as expected; in this case identical to
> original split BTF, with a few duplicate anonymous types added to
> split BTF by the relocation process.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

I think we now need a few test cases with types that have duplicate names.
Wdyt?

