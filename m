Return-Path: <bpf+bounces-50378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B18A26BA5
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 06:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6D27A487A
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 05:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66021FFC75;
	Tue,  4 Feb 2025 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN6SOxyA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198F1FF1CE;
	Tue,  4 Feb 2025 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648748; cv=none; b=cKWVgFdc4gxYQ6DMXDA2Ybwhj7iH5B4SVLQV6oFGfKpZT8D/AbLf4rW4WfSyjbuAbQQx8MbjNSj80siJYl5l1tqb6OSzRjVfH4j2ZNICWobpFcpQUTPbIx0Oh+nLIzUZuhAZ+i97p0judWqbgd58j3ZlzjZAj/2kmkQa66iBVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648748; c=relaxed/simple;
	bh=ybLRHyYfFf1hecYOks1SBw6qj0bwIS2jA69BBqhE3l8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/TB8IPuHujckEWsKNJG/bPL506GMqliuBDxFkYPpN6KF/ETZu3oMuKLCoZabL9rOxCTb6C6zrthuBr5JWLjwtrvur6gYAOVU7GxvQ0q2OKPZUUIhsOxnev6jRzX4dPfV5SxJgK+0oQJzOHE+4O9TWXvpQgNGNRrcVZtr2pVGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN6SOxyA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21ddab8800bso72577165ad.3;
        Mon, 03 Feb 2025 21:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738648746; x=1739253546; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ybLRHyYfFf1hecYOks1SBw6qj0bwIS2jA69BBqhE3l8=;
        b=LN6SOxyAZ8Ai1ZI292fT6Hbb5h2huPBgn/wXWP1R9yww1rlc4ya67sV3vTwhfb2dCI
         XihR/nPqbTI3GmD3GNERpTBWlwUZ6TQ/NARvMR8j2RBCaKSILZOWjab/64OOX76BMXGp
         d6r2YJhxa+JGV32Bx9giXexyUaL74Yc1S5JEYkSrph7RK+RX5funQqRiXlgUCHdhhKDL
         SDr+iYN6AGjMB4j+hCB5/4QlUeILRny8xUheFN4NLJVJPPdHEAkL3kwPMZAb7FSE9rSj
         gOBqBmqFlwVxaqWVYHLqsAZmoc5cs8OSMjaHgqdSBoUUu5T1ISQjpDBIuw1xR5TGd12i
         UQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738648746; x=1739253546;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybLRHyYfFf1hecYOks1SBw6qj0bwIS2jA69BBqhE3l8=;
        b=GToPEOx4M1EyNItcZMKVroKpi2vwpRubLjJNdcwICsfuXscrbKu3kdk6529oEREFWZ
         BerMaYmALR7XJDWIu2Dm00ASmTgaEIxvPeMHXWjcyASxDIffmJcb3N1mZRc8XqVw7Pm7
         EiHQSEsEUslEmX6ZkE+Wpt6sHJ3/QuCJTFaG8gOGNPEs8dF5CqdSw9uu74RLwA9d2Lhp
         U4J1hYWfTARgNLG4r8al2FMTOQz/nsfRuZVcFoA/XLK8vvEbg4DE2rcIeIXeNw0RzS1O
         VsBaIwuDUael78l08+1ttEuSnfFMBwcXu9vzxLq0h4Kzs70YMbSyixT56qQr/7+bpdIT
         KcYw==
X-Forwarded-Encrypted: i=1; AJvYcCV0b0Fdj/tzyi9vagNxBpUCB2vvRJkFR8y059ky9W5N2PM4GHfvBPCb7aXhrbQWFcuW2MYxmiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4ZSJzD5lxucaGGEpYblAfmHlCRPomGju1ce6oDu5JW8ydPzV
	5GY3U39BGIV1W4tBCOFtQCVJNWCsUiL49sf5C3o0BaVADrP3Og7E
X-Gm-Gg: ASbGncvvUHF/T4RFpqbWXmPqLppqEKGf3W43mgnHmp6dlE/1Go3dPTYYcRhEYpnxfbT
	ENl6v0qH/lYC6iQFBUt6xduYagqO4tiECgDApf9A2BvCFwaW2DbU1/lkSzuRzxcWtLHrNjXSAp0
	YzUPtv2C2GMPzVGhRx8Yb3mOLM2SLOK0LSgid+JleQZvTDeRGxjNJ0eVCa65hHBC2XOyFro9mWI
	P1pqV9kGBuQpKmsvEuN/ywhkD7UhJ3f9RkG1zVprFJ+2+OpaMg4YHkb8DNuiubKgz+i2TQXaQkQ
	5EHUIN3b4tgE
X-Google-Smtp-Source: AGHT+IFDYLruy3Xhw89PDhmdIFs6KtMomvvQkHFLkPOYKg+kfwZmmjublAytRQh4fhpJXDDEgMAJrQ==
X-Received: by 2002:a05:6a20:9c8b:b0:1e1:aef4:9cdd with SMTP id adf61e73a8af0-1ed7a5b5399mr36557110637.1.1738648746176;
        Mon, 03 Feb 2025 21:59:06 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0479887sm9061875a12.52.2025.02.03.21.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:59:05 -0800 (PST)
Message-ID: <1e1b18b0ed90cd675543c17b837e7a18e8110ab6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 07/18] bpf: Generalize finding member offset
 of struct_ops prog
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, 	yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Date: Mon, 03 Feb 2025 21:59:00 -0800
In-Reply-To: <20250131192912.133796-8-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
		 <20250131192912.133796-8-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-31 at 11:28 -0800, Amery Hung wrote:
> Generalize prog_ops_moff() so that we can use it to retrieve a struct_ops
> program's offset for different ops.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


