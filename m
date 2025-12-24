Return-Path: <bpf+bounces-77398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC3BCDB430
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 04:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284E03026BFB
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 03:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B358327BF6;
	Wed, 24 Dec 2025 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HROQHsR+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBE3195E8
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766546962; cv=none; b=lMQegK3AQsQpJELHX+vCp01HMGj6aCxMlXG4SC/PNgjQl0xy9YrSPTzOkZSGt9yLkH0xXsb4rm97fXcycMGzmer3sPY3ReX8++Qs9HHZCsSXsjQYUYZwaCs5g1lmY3Jf3VXuJkQZeJwOs30s/t7rfBbRXyV81p+Ab3hH82hTGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766546962; c=relaxed/simple;
	bh=inVN/SQ5KwzGY8MAD1jKAu2cmNNUf+O9LNTekh//pHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhBRrkEnP2MGAI4aOWo9vqiz+20GlN4qs7G45qg8m/A0q5cy/tzPVTdRpmKusM9ZXVzC15wcvMbVjrETJqow7Nn7RXXL+RTy2ZBXe+c+WWyt2zjImQtJ+qOTot7K0L2l+gbgcYLkLMiAYAt0mpUSzcEZn/BJKONGN+Oem3uEGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HROQHsR+; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0c09bb78cso40246585ad.0
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 19:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766546954; x=1767151754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=diw0Qc+yDTn19zPh7h7fAWDU3GOrQlj5JQqDOF64Qec=;
        b=HROQHsR+AcwUcupnrCh3KdV+ffsHB3LxHF5O9dSbZkVbmSx5eCYLbxlgx4+6EPy/nK
         c23qpmNRGy/ZDYfvr7YeoZfYAiuafPkbzgN5DIECKU+VhfIfgpudO/DkXzVPGYQnhgWJ
         NLvfTb5AwLmIbn5lzGmV37Z889YIC+DKEUmIDd0W9d7XJagTPysJf8eQRGDxNzBWrV1z
         PU3JEpFYoIuLswyvhmTGEHP1bh7+zI8cnpR0nsZBOuYwPbIqAP42fE7qchT4srRScGzK
         7O5oDM/Ag9ZE7h0ML611+a4lKqlyJTL7dpOO5gSotK4FsSEp2mddbmZsnWnKiguvbYoD
         SnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766546954; x=1767151754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diw0Qc+yDTn19zPh7h7fAWDU3GOrQlj5JQqDOF64Qec=;
        b=H3Zu4G7uKGLoQAtp379xz0/s8nVuoiKRu79KYP7izevdnWxZIlXtdGWogjJQrfDBmi
         opnF69KmWounJq1mmPkIThCUmMrUzY3MUrRaaR7fD/p4Hk3t2QVidtPY3Q8IHWz4vhwA
         Qx/u3ADvcPNcWvx2Y1Kd5FnMs/V3SdH0L1+j9+BG4N6be8IQIMPkH5mPW1f4IFE5uyxO
         //0ck0Det6zLn2hU2bGSKPSf3ygnwkHcsKz9Cuc+NrCL19C4HWy3Zw8cBsm5FmA+4xMG
         YCa1zR3Kw9o1Xe+VfZWQx/fpwJVuH/tdM8BaxHqygULPLB/XIxj4YMppmFjiPIKQ5MqR
         dB6g==
X-Forwarded-Encrypted: i=1; AJvYcCWnqzjMI87z5J+fdjCsHePHTsXNx1k9gDk5y4JwzvGJrB0vWwhYwtYD8GWQ8dPapX0c2Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvqIUxtroC+lxwrPrNUZxSgRhsBPcaMhMV3vfFN4PPUetbcuS
	Ro7XXyzOkrBbnbwQex7J0skEy/Oq6SjtA+0TQVS+g9VGIDx2q2nxEjn6
X-Gm-Gg: AY/fxX7wlk2buBqPa+b212et26Yl0ovCWGoo1zLb4Z4pZE0qZYz7fNR01Cs9f81is8t
	PNYJJ/o558NPpZWStZHG0ou8IV5CMkyQMR6FRfs5ZvKF9gVf8+m9gEO3RTWyfwI2k/m5wgjUtlU
	OQD1zdygObyUUqIouy1I3WM2sOClQ8gPL2gtBXGH1PO6lD4o1P7yuiXQAFFRMN+Ueszi26SDYFU
	u0k2CTZ3W3bQiWcTT0+aDbG2P5ncwSR2PLvmfyCqwsnlwA8LqxPjf+6lsy9Re1POqrgvYGYe0RI
	kPTw9q/oEn9WLKcfoji0hEV7h6/iYXDId1VJ8SnUc46sYRY0Bx6L7SBnpbIohvGI70v6LSYImkT
	eIamWZGsROP5gpKyDxossEvsQgZS6MJVPpcLXwGuKfen9q4BZjvo5DEnn2mLnwn2aLuEVi6EH4k
	WFfyO31yZhwGZmdw==
X-Google-Smtp-Source: AGHT+IE1s4MyrKS5piryfyLLSh58wQn7omfzxPX8sPqSVysMXTObhVDTZ20JEL62xCJSeReVARMDvg==
X-Received: by 2002:a17:902:cec7:b0:295:134:9ae5 with SMTP id d9443c01a7336-2a2f0d41127mr154739475ad.24.1766546954094;
        Tue, 23 Dec 2025 19:29:14 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d74bbbsm140863885ad.94.2025.12.23.19.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 19:29:13 -0800 (PST)
Date: Wed, 24 Dec 2025 11:29:08 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
Subject: Re: [PATCH] buildid: validate page-backed file before parsing build
 ID
Message-ID: <aUteBPWPYzVWIZFH@ndev>
References: <20251223103214.2412446-1-wangjinchao600@gmail.com>
 <gkguoyowtzk2mtr264pgzh7xescgwhczjg4f6piuppnpebcgjb@atkroomgpyyk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gkguoyowtzk2mtr264pgzh7xescgwhczjg4f6piuppnpebcgjb@atkroomgpyyk>

On Tue, Dec 23, 2025 at 11:05:49AM -0800, Shakeel Butt wrote:
> Hi Jinchao,
> 
> On Tue, Dec 23, 2025 at 06:32:07PM +0800, Jinchao Wang wrote:
> > __build_id_parse() only works on page-backed storage.  Its helper paths
> > eventually call mapping->a_ops->read_folio(), so explicitly reject VMAs
> > that do not map a regular file or lack valid address_space operations.
> > 
> > Reported-by: syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> 
> Check the previous discussion on this at
> https://lore.kernel.org/all/20251114193729.251892-1-ssranevjti@gmail.com/
> 
> The preferred solution was to use kernel_read() call instead of adding
> more such checks. Please check and test the patch at
> https://lore.kernel.org/20251222205859.3968077-1-shakeel.butt@linux.dev/
> 

Thanks for the pointer.

After reading the discussion and the patch, I agree with you.
I also tested your patch, it fixes:
https://syzkaller.appspot.com/bug?extid=e008db2ac01e282550ee

