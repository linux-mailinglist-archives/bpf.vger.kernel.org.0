Return-Path: <bpf+bounces-29948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4E8C87B3
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AED31F235F3
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12175A0E3;
	Fri, 17 May 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR67lSmG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DF5787B;
	Fri, 17 May 2024 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954582; cv=none; b=YE25Jll1CKlcsT7SUi6Rdg5wkxxhywkbmb9Kbxh/GE82+FJiIPngqci37RGlnK+8dvJW14AWArfDqmOWcdU+/GSBbo1GsM/0RHrtFzFFvSBza0LWUgoCY8y2A/v/3dEagsynYEGZHGpKArp86JVMTupND4JI/bH1xwIpVh7/Qdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954582; c=relaxed/simple;
	bh=WAM7xYlzVR8/mJBSMLMh9WVrBCq4FxrxrccuaVGKlZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VRsCH/cIIcI7M9oCGeqkXu05iac/7xdsuGaytesWbebZjv7jtb4MRYehXjSqIjYd6G2XjMRU5e4ck5fKpNR/0KqHKsmQyf9cyekj2WdKUTzwsN18G2RCWzGtEfRV2vMyanTTBa1VZLtpbV2PWYpQorYpBxgJ72dn85BHS++xP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR67lSmG reason="signature verification failed"; arc=none smtp.client-ip=209.85.219.46; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1ed96772f92so9572015ad.0;
        Fri, 17 May 2024 07:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715954580; x=1716559380;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:dkim-signature:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYEnl5IGwmHfOFYX4u078jOFfacX6kSGq8wXy29c6Vo=;
        b=JY2PrbKaLkaqlTUUTfSD9Y1NO+79lgmu1YVf3LfKli9LKi8idukkjR7l96trB2/MVw
         2IHgw3/zBiqRPKqXMTcvdI9Tq/2UwKjZlrO5bR3YB0UYFpFxB+DrNKTf6aKheTqJiDQg
         v8tiwhVub0rSTaoayjHu6CsAI3+4KyJiUZFWU5haYuz5EV7NT0DxbzYynE/qSDzNgevk
         YWkWRs1rZmXd8YoaUMFDC+fYS9fh8KzkqmAgG2Xa3wLg9NcA76fkv+9qJAOTJ9fuiVX6
         tFhfutgdTugIheAmzhHYD39kDZdW4Ef6JVHwlQkWnRXt48Kz9uRBUn5X/765Y8VWGwga
         KnNw==
X-Forwarded-Encrypted: i=1; AJvYcCWgCkfmjZElVLqryMbIwa7bBOncVPbvbFuNyCPDetzzmwZLF0JYEYAX0JqBDnEE3TA3Su82hyYPnr/iWHW8g5IxIN/0SECtleakEW/z9UJBYuYjakE9eFdt7TzxeDFjuLiFHPgW
X-Gm-Message-State: AOJu0YyqiKlQ/2nO0fafhbij7VfelSmVCf8Xax2LZU1zZ/EZFIWyb3hj
	YB7FY2uzOHq+4WGBOlmfVy2ckcRzct8FakgpnnDTyz7v11Cgnlwl
X-Google-Smtp-Source: AGHT+IG3fNJCxjGxm1jcmR1pmrtVMtoQdGVRbgHYoCA+YWDA59b3UnRiVNLkVdzoJvtGw4yIK3S1Dg==
X-Received: by 2002:a17:90b:30cc:b0:2b4:fcfd:7b5b with SMTP id 98e67ed59e1d1-2b6cc759306mr20281516a91.24.1715954580308;
        Fri, 17 May 2024 07:03:00 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:26be:370:d9bb:b9a0:16e:48c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b6d0b8c887sm13888234a91.21.2024.05.17.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:02:59 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	dracoding <dracodingfly@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: Fix the gso BUG_ON that treat the skb which head_frag is true as non head_frag
Date: Fri, 17 May 2024 22:02:51 +0800
Message-Id: <66464991ac8ea_54e932947a@willemb.c.googlers.com.notmuch>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20240515144313.61680-1-dracodingfly@gmail.com>
References: <20240515144313.61680-1-dracodingfly@gmail.com>
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5B145A06; Thu, 16 May 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6a3652a74f9so3484026d6.2; Thu, 16 May 2024 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1715882386; x=1716487186; darn=vger.kernel.org; h=content-transfer-encoding:mime-version:subject:references :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date :message-id:reply-to; bh=c2+WnzvsrG3q05AgFPxDjhS97HlYQRIW0WgMF8TeUeo=; b=FR67lSmG+viUYDkDT6xwHR5ayK1pQRZdqwHJSGA1mbsI4DXrTSYKOD7mo7I8zY8Yxj CEEP8IPKSj9ZpVy3Os1nqjSeMJAy1B+FIGhYT2gmpDlUrqDCOfdSsTWQdh3xMMlj7NMw prFXeiU57uAjcN/osBgLfS32XXZ0ZG8kui/fcD5rsSYANXA64uH/x3rDYNYDeQsvG9de G8MMtpIr1uiST4ACbansycEzu4Xv0PLnRXl1bCRZ7tMEUeyXW98Sb6JR04bMAu+XYAoV /gy/Ph2VyMA5VMSdZmGhY/b2NbLl+0bmiOyZgDfO5mXvi3QnLJ2bJkA1z+GzdbKiZ0Z7 pBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtkhtjcGgA2shL+FGFbrPX8lAbsRYK6do47tumH6KpqM9/QcWOffw7PpajU4QEUBUcs8oSFJdflvOagMyh1kzl7hXKtQvjg5NmTKYEaJziWYiDJMXzz5cdn4c/XVrKrVJY
X-Received: by 2002:a05:6214:5a08:b0:6a0:b594:177e with SMTP id 6a1803df08f44-6a16825a4b1mr207278616d6.57.1715882386314; Thu, 16 May 2024 10:59:46 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112]) by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f187c47sm77551616d6.48.2024.05.16.10.59.45 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Thu, 16 May 2024 10:59:45 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

> dracoding wrote:
> > From: Fred Li <dracodingfly@gmail.com>
> > 
> > The crashed kernel version is 5.16.20, and I have not test this patch
> > because I dont find a way to reproduce it, and the mailine may be
> > has the same problem.
> 
> That is a pretty old kernel.
> 
> There has been work in this space in the meantime. Such as commit
> 3dcbdb134f32 ("net: gso: Fix skb_segment splat when splitting gso_size
> mangled skb having linear-headed frag_list") or commit 9e4b7a99a03a
> ("net: gso: fix panic on frag_list with mixed head alloc types").

The mainline kernel is using the commit 9e4b7a99a03a("net: gso: fix panic
on frag_list with mixed head alloc types") version, but it not work for me.
It disable NETIF_F_SG only if it has non head_frag skb. This case is it has
only one head_frag frag_list skb. I will send a test case which will cause 
the system crash, also in a newest kernel 6.6.8.
 

