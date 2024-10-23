Return-Path: <bpf+bounces-42871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B312D9AC03B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 09:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E84284AAE
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59E11547D5;
	Wed, 23 Oct 2024 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icxfXzVK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4C433B3;
	Wed, 23 Oct 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668614; cv=none; b=os54g4X2UBHrWbiikU3GIh5s2CtffejvVsRKe2iXJbdeWWtzNQl261tCKK1YwPpK17v1301djoGMagg2rMjwNWALVhFE9HwoXS2iQJ6L1P1XWsy3r17ZXQHcoSL+ws9K1vLSSPZHBcEt8C9wMrI5GFcIWkLQKX2JPQUVDpJTJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668614; c=relaxed/simple;
	bh=rT5H9hNVJdEwkAbli0uDb6oJBRqP5GzqNw3n+PHhtIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByKcX1lFfVGzJ5Xj90eBDrIxq+zqdLYPIycqtFOoapria4EMxg2ORKvJJziPzhaMcfVznIZbyLBmrGg/pfxme4Pnz1QqifI6BQZ+KSKRRquRZUcVv/p6u+ncUOOoFlxYFsXmlWTtSpKHKPKWKSFxCoBu5fhUEGuylxDCWJCT7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icxfXzVK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71ec12160f6so2342888b3a.3;
        Wed, 23 Oct 2024 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729668612; x=1730273412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz/vGJDpJqbujH1vwB1YvoHpkj4IgO+fz2agzfaSRIA=;
        b=icxfXzVKagMV06q2kjJY1stiZ7/fVfTttD1ivpyCVxiBf9+9NatsadHOdG/XIki9bh
         ziPAJR+zvSuDgtH//FFMBfhyflN1mgMKSGzENVVjnXYTw2NXmnHG6I+rKBV9C4yxMiMh
         rcRD+ZY/lb2BrWJFcFEXwTL79b3OoQS6Cwcbez3Bd3ZLZZvCwLC75VgNIGqOcQ1I8LJD
         39zXcIHTXQF7kXKz/oBJd7UtlD1gMniNyL57TUErF95gyeeszpvzA2O70rvz0oEAbknn
         yqr5A9D8eRoc8gUVI48j9duhlX4sGH+/z9hqeNn5m9bu1opkDUx5qInWRj73jtduFVMg
         vDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729668612; x=1730273412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz/vGJDpJqbujH1vwB1YvoHpkj4IgO+fz2agzfaSRIA=;
        b=tQNqimzRiv64kWwogwWv9porsK+yaFU3jucU2/48nqg8Qjq4BmUvbZmp+1X8XOy8l0
         D1SPwlxBHBjDJ8XyTV471vw+RN8HibmwsY0xhEsqJdH1azbqqhoOxJVCiiBmOMPi0RC/
         BWWXRsBV85vdq4PKabqKHfhcdH0XC6EBWYP2SKj8CHvI6AlChLAPtRO72910pL6sziN+
         1iNzGJ09l4LLTriwcdwEksHopXnv22Hn5/T9teaf2Qs/fDkQCSgbw1UjfP6mX+D3DotF
         I5Bj6u62hDVTbBHiWN9m8RFobxZ2mJsUib8jb6VVXKWnvza76E/Dw868hXOgiM+2TYck
         wyVg==
X-Forwarded-Encrypted: i=1; AJvYcCUg0DbLn6Nh//wHJ0AxBda0GQWxiE4ANFiiiouOx60pFQfj1qKmSgc3a58nAiHZF+2StZ4Xk2becxyXyZGe@vger.kernel.org, AJvYcCW0w2o8kDTzniLIan8zHtB2ofr4Fgca8zZyvqKlek7jBmKaz/ol6N/Qzkpo7Ml2oohIHuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5UkjiDcJt6zbpwv6vQ36JtkeYQydIdq23O7s1VOqAu2meXnQ
	jvWF4pIRmnVazpmFTuFNKtLUpOx1sEzaJhuXbnUp7iplXpvnmzty
X-Google-Smtp-Source: AGHT+IE28Ex4k6ZDhMbDF7OwnRPNLjnxktTVGmsAn93ay6ClDGOfipEuNNlCTTQ1dRklFyNYYdWsiw==
X-Received: by 2002:a05:6a00:3d48:b0:71e:47a2:676 with SMTP id d2e1a72fcca58-72030a6ecabmr2535426b3a.6.1729668612064;
        Wed, 23 Oct 2024 00:30:12 -0700 (PDT)
Received: from localhost.localdomain ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1332f5fsm5760529b3a.49.2024.10.23.00.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:30:11 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:30:06 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
Message-ID: <Zxil/uyqq5qDHuRX@localhost.localdomain>
References: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
 <26f04a6b-4248-6898-8612-793e02712017@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f04a6b-4248-6898-8612-793e02712017@huaweicloud.com>

On Wed, Oct 23, 2024 at 10:03:44AM +0800, Hou Tao wrote:
>
> Without the fix, there will be KASAN report as show below when dumping
> all keys in the lpm-trie through bpf_map_get_next_key().

Thank you for testing.

> 
> However, I have a dumb question: does it make sense to reject the
> element with prefixlen = 0 ? Because I can't think of a use case where a
> zero-length prefix will be useful.

With prefixlen = 0, it would always return -ENOENT, I think. Maybe it is
good to reject it earlier!

