Return-Path: <bpf+bounces-43013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A049ADB1D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A0B28360C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942B170A01;
	Thu, 24 Oct 2024 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpFI/XvH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7B12CD96
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745301; cv=none; b=IKTiecdEmzvPoDqaLJH0eWFPm5TUbfDYti6PvOFH7AaQGsdJyMkSjof6t4ua0GtCULyTtjH5CXHipvcJSLHQhW8eHJfoIFoVU+8+wbR8Kxkst+2l4DH+0Ib2uY9FArvfNkWDiYB9KL2/lhRCGxymbEwU5ZNw+idNXiRVYYzAvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745301; c=relaxed/simple;
	bh=UBIzPhDQIsqvvlF8qMY8ncIOq0XTdkztTDxOy9R89Cw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DHAHWkZ3oA4jJAjrem0k80lqDnFnAGQTQHBGayZXL7yHEwnsD6/8asFIfe8D1iI516EeZX3MYtGF8ntP9Gh4Sb7ZhqhtKT+hLvfQMqcmNQ2XT/01knwPaTk2MfKonkuhrjSIBetCy/FjhnZE8LMaqYAaDZ+ynhmngAFDGUiN17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpFI/XvH; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-288d4da7221so304909fac.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729745299; x=1730350099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9qxRzb35sDbgQTTEbAobaC4LLWcqQqXyabf9seb6pA=;
        b=IpFI/XvHXHjvC8Xbq6FB/jK5PxVz/DIqtl4eyr9MOOXluHVpPTDcm3lXXannSG3XIX
         wOHZTPi0zMI2af2sCS56Kh19goH0N2oodhymIWr29jfH4pHW4+vaUpM5xsvxUi9cJGZi
         2GbHBb3WC5vXESz5ShqnG6z3PGjjgw2LqqJlZtUzvhQ1IChdlHqu1LEEb+O9hy9NX3Yr
         d53ERj7EDCwtewSpBRF0jhZzNBucrpw76Xa9QindJRLvukqj2DgHA7E/0Ou2QklZwZ8q
         QIih+SP6lp4AbVNApscUmv6rFca80kzK4x3B9j4GNlAeoixFcMEHqFn1LXxYK6QwRzcH
         wKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729745299; x=1730350099;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L9qxRzb35sDbgQTTEbAobaC4LLWcqQqXyabf9seb6pA=;
        b=MyFVTqpeKJlYH45mlM2VA6yEX2PpknaF5nqjFGNVMZKmmuu73wUcQD5ACOiCmQFYR8
         XJ4WWSoO7VDVN70jh6i+qs/dzom2cK1HEWEyzU8umfXanYGvfmBTVpIecUG+ECby5Qx3
         mtwnJdWVFCfYU6GcqINvORxd4GA3JZTBbWiI2GXEUhrM1N65bFstsm/1nCf4GndBj+Jr
         EMCuIH/na1sWTbHtq5BT/hvMjjGc4OCFL35txeq+IcH96L24f/BS+iTdzakL6ZXKt1dU
         QuXaXNgScpKhPQFGPWqaFXD+Aop/caieMA4DmCU3NsTRIYSOtgy27e9DL3Ua4C9yBoUw
         EZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxdMqO1ZSTWsSET+sARPcKjKIqdDrJ9clEsoN0Nkkgwx30eTdL0Qp8kmII0YoYSmlKAbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0r03E7zvW6939JlSl06iyvjxf4J+VXW04X+4ZHB4W9AmHPnM
	PD8t6+hlJvVRyyYlLfLzGDgVOluzpDzqs0VAM1xqKr121FcBfb0y
X-Google-Smtp-Source: AGHT+IGLiZqkb4VvFDKzqCIFmbFMasoBg7530nsM5XvA+3lIodkly48fg9ypDGlJvnPCF71J4Yeejw==
X-Received: by 2002:a05:6870:fb9f:b0:270:25e:b341 with SMTP id 586e51a60fabf-28ced430883mr581131fac.36.1729745299105;
        Wed, 23 Oct 2024 21:48:19 -0700 (PDT)
Received: from localhost ([98.97.32.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1332f48sm7150696b3a.72.2024.10.23.21.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:48:18 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:48:17 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 ast@kernel.org, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 jakub@cloudflare.com, 
 liujian56@huawei.com, 
 zijianzhang@bytedance.com, 
 cong.wang@bytedance.com
Message-ID: <6719d191d8a9c_1cb220842@john.notmuch>
In-Reply-To: <20241020110345.1468595-4-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <20241020110345.1468595-4-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 3/8] selftests/bpf: Fix total_bytes in msg_loop_rx in
 test_sockmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> total_bytes in msg_loop_rx should also take push into account, otherwise
> total_bytes will be a smaller value, which makes the msg_loop_rx end early.
> 
> Besides, total_bytes has already taken pop, so we don't need to subtract
> some bytes from iov_buf in sendmsg_test. The additional subtraction may
> make total_bytes a negative number, and msg_loop_rx will just end without
> checking anything.
> 
> Fixes: 18d4e900a450 ("bpf: Selftests, improve test_sockmap total bytes counter")
> Fixes: d69672147faa ("selftests, bpf: Add one test for sockmap with strparser")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

