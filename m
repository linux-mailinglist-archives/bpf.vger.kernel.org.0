Return-Path: <bpf+bounces-45362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EBC9D4C27
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAE9B236F3
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960D1D0F56;
	Thu, 21 Nov 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2u1SsIm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4153C47B;
	Thu, 21 Nov 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189324; cv=none; b=NBqsc8RgHtK1MNeDm1aq+n2CEXW3mVtm0HDnxt238BSG0q8ILkO0cyYIj3E4kQnYtIzg+LgWEwTvqoM0DXFKGhL8B/IDrnuetGAzRz0XDo5ZxCIz/pqcRyBjtNgIDMBdigNNh7fw/9ob6bdHsGSAyllssz0cPxYDHY3V9AACVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189324; c=relaxed/simple;
	bh=GN7T/oKi6RZ26ifF9n4LUCLL2FNXyzaNe8nav9f304U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrFS7OqV9VqH2PXB9NZL7jpJ7TJvHR71m8w/WXmVowDQFDzMP1nelhcT5VSX/mgsZZCc13A1z+34BTViLJn9XOMDjZ4br3munyAVVtFKh+E/xxtGKH8E5bY87MNN8jeplUkOIo1fjO477+1PwkXYsqtILSS57gQBnQN0H7tj/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2u1SsIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11119C4CECC;
	Thu, 21 Nov 2024 11:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732189323;
	bh=GN7T/oKi6RZ26ifF9n4LUCLL2FNXyzaNe8nav9f304U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O2u1SsIm5hUW0RcLqZ6v0L4Ij6MdIMt7hJKQ1es+MluZISJsuEqlTXqupLbxftDaY
	 DYJpB7jZugsdlvxfFh6OioeHg6p9ZBoPiEVt6uOqmxtrTLoZ+X50fi6A6gMJ3t/ZsB
	 yi9aUsjcJ+zN3ih/Y1fU9bu3sUYrPNK5W1lSyXBRXICN4c+iQrgFy5GjaQieLEZl5/
	 szyn1+re5zBEfaVyTmsKLmN+QKjuOUBGpPt29OwcgqUOPybRn21sh4YJSuk61l2g4G
	 3a/Jzht7WQQHvlcTlJqVGhCv4M5IM3FNDlKK/NRMwSLouNSml0vQL+FPgmSF01CavE
	 KrDWKelyn1YTQ==
Message-ID: <beb38cbc-9ac8-4205-aac9-3bb1b2fa6e97@kernel.org>
Date: Thu, 21 Nov 2024 11:41:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix wrong format output
To: liujing <liujing@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, liujing <liujing_yewu@cmss.chinamobile.com>
References: <20241121084731.3570-1-liujing@cmss.chinamobile.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241121084731.3570-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-11-21 16:47 UTC+0800 ~ liujing <liujing@cmss.chinamobile.com>
> From: liujing <liujing_yewu@cmss.chinamobile.com>
> 
> %d in format string requires 'int' but the argument type
> of pf is 'unsigned int'.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you

