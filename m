Return-Path: <bpf+bounces-21582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C1284EF07
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470FC1F22A0D
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D62B184D;
	Fri,  9 Feb 2024 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPSh6adM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F35663;
	Fri,  9 Feb 2024 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447053; cv=none; b=IaFVUCOSVNv5bQGtSBRpEw28Gkc/FWArorK14JP6vjWVFiMjY3VER9hC99VumYeph6+G4HLnLw3nEcHan5ZyL6Z3qLm6bMBhvyNtArfoBRHWVemRPKVsCbUZx/SMIBkxVrc4fb5MUskTqEJLgYfLda2UT3nXoViDGWfK46/HAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447053; c=relaxed/simple;
	bh=7afYQWsKUrAcpAeznLizU1hFIZ9xJ5fDSzGextpy+8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7nxmZgt8bukDocjlfMUwIFX5kxy4FEJzJO2iS0sfeIYdqWED1gu86XANaYCyeqwjC5A8/IYUhj7gz70eaJf7+tnlGaBsDtVO/fWfruXqo2VWdSXdj/q9cc/xCIuiIIqTY1A1S+X5ZuF6Umai2lp2ZXqWiaDZMHGamUmjB77vMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPSh6adM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68009cb4669so2265676d6.1;
        Thu, 08 Feb 2024 18:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707447051; x=1708051851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nj9opqbQ5/AcFYVCj/vP5eercGB3ykX399OJ84biNsE=;
        b=hPSh6adMMw8Qio8TJYQ0ehXbSTBcDfsILTDctSLk9WxjlyoGnvyhiWGD84mHjQti5D
         oLW/4JiKX3/+HsTiJEKWRRqd1Fw4DcD7iAHFdS/HFbD7C5HDiDy7CN4nA9z82ODZfToh
         LzztFw189W48KXchlaooJcPwB5JKVEl+p+Kh6aBC/DnmM7zJChucc4sv7iwmIKeJ6Zv0
         p5Q9U25q3o/auQ0oQe6tikfHIt9Gl3KglQa7kbWIW+a/wOxcYZUp4HPxEIaelZEMRusc
         iKPrNIPwOZqiumZXwwt+jMp+5th107ZsD0KZOpLyD76enA28U5bQ4zNh/CU5xwkK9jw9
         +3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707447051; x=1708051851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj9opqbQ5/AcFYVCj/vP5eercGB3ykX399OJ84biNsE=;
        b=ukVr9GLSkRzTtTGTESPaId/CXwglS8hYNN0KGr+wvAsZg4Hl9QcSm1JJBSXRL+PshV
         7jWG0NftwXJFzg41wSyvCkyY3xRLP6GCQbnosDzBzw9B0YAeXcLxzttdFQaM7we/LjcZ
         w6kpo0UR5yIZA4aFXJE1kasJR6WpWLzkrCmCsGczF+otou4sRFZuYcaXAxo5rH3MKOrJ
         oIwJa2cLfX4gJAAbk6Xm7KfPvsDrIxxfba/zD5Tqr8zagZmyaovSiS2FO/2z3KP69Y7z
         y6ipPpUSO9IuDlBd1Gj3Sw9G/Cf/+zZhNOfhYhdz8ml60tfkVc8C5TUGday4GXo11qSl
         IRKA==
X-Gm-Message-State: AOJu0YyldLR2d5xrHmCFoBWbKOUu1Ij0sLyt8OaXi+pEdxyrHKaMurb+
	ShY7kfOVuU3TgBldwOBCU00n88TRQpPcQO845GEGCUpNip5Jw+tc
X-Google-Smtp-Source: AGHT+IHkcvpt/oyuKL6dZTMlzk4EHfqgduaB3NjUqo79ofdNrhbIIjXXee3ZA5FrNviknnwSYi3Baw==
X-Received: by 2002:a0c:aa1b:0:b0:68c:c249:4c47 with SMTP id d27-20020a0caa1b000000b0068cc2494c47mr309388qvb.28.1707447050935;
        Thu, 08 Feb 2024 18:50:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCIynohXxMMivTiDa/ehKzYq04RxDtgYQ5miiPimefr/7rpfEkzDi+j/XRJyXugl4AHYteurMru3C+cEwE/G52cmFX0FtYQ7OKLjzn
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id lr9-20020a0562145bc900b0068cd399760fsm163333qvb.61.2024.02.08.18.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:50:50 -0800 (PST)
Date: Thu, 8 Feb 2024 16:50:49 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: remove check before __cgroup_bpf_run_filter_skb
Message-ID: <3htegzrugq4xwlizizsaku6g2pzwhndcnxxxmji4fvblisiuro@icvcsa3mky3w>
References: <ngc7klapduckb67tsymb3blu2wlmdsjo4pa4gbaivgxezbwzxp@v7akqu7gbwl4>
 <ZcV1GgitdBUIcKJT@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcV1GgitdBUIcKJT@google.com>

On Thu, Feb 08, 2024 at 04:43:06PM -0800, Stanislav Fomichev wrote:
> The check is here to make sure we only run this hook on non-req sockets.
> Dropping it would mean we'd be running the hook on the listeners
> instead. I don't think we want that.

You are correct that we don't want to run the code on listeners. However
the check for that is in the function this macro calls,
__cgroup_bpf_run_filter_skb (the check is on line 1367 of
kernel/bpf/cgroup.c, for 6.8.0-rc3). The check doesn't need to be done
twice, so it can be removed in this macro. 

