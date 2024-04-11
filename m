Return-Path: <bpf+bounces-26579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331838A1FB7
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 21:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74661F251BA
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611A179A8;
	Thu, 11 Apr 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAbYdYQg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61414F65;
	Thu, 11 Apr 2024 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864933; cv=none; b=NYdF3eBAA13iMv7VN7oHW1WPwx3ewYT3IrBSg0Otmcp07sTptNSll8FUSpLAWXFSV5FfpEmFmDVzPJ8DYpD6878tPRLWQ1WsEEj3i+3sAkCiIn16d5cZCGh0mYaXsJ5r5HnQLYJmiNWLxiENxR7o5v6VQDmdZMKDz6zYdV5LEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864933; c=relaxed/simple;
	bh=JRdPyGUbZVubMMz0NFuT40OeYtqTJKc3vzOubKZxhjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2riZqfjBufqB+gM6Hez/LO/hY6nmaNVSMAe1TwJuEUluLrmWmcBjSTaNRA4uaON366DLlRjRl2HROSBb6JUYJx+0XaSe6fzS7YDSTAVvawv6QuXMY6HNTtB/lkIBkneBwxCy/qFvAZ0+i0EFSs3B5D2j0q0J2iENs4/qGWHN/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAbYdYQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1E9C072AA;
	Thu, 11 Apr 2024 19:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712864933;
	bh=JRdPyGUbZVubMMz0NFuT40OeYtqTJKc3vzOubKZxhjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iAbYdYQguLxogEkgCpKXle95Wbo5P6N7f+/G0Ha/E/6j9pOJdgGUlfucyxp2jARUR
	 LR9K4POrNDHGceDpiUl5xsW0ej3nviRkAYCCGwjcTUCjcmNAWM74TqNTBI/879PQfl
	 CxDz73QbfQ743ICKF9YFzDAtUmqadf3mtlg+lMHF0vW/Tpc8S4dN9tU1gNv8Quc5ML
	 5J4tqCkHw/XrlT1fvqHpZ8Y8fhjjM/ysqv3RLnjqeObg8/UpoNkyQRQtqHdwlnYXqo
	 YoSfrIjBMQZTRfSWJePpGhuR19w1cJdueyEUl/GTKGyXHFuwMgRd0uUuZy8DnlbsRd
	 kMBrtiJ8gXZ0A==
Message-ID: <397767d1-5f1d-406d-ab9c-bb185d9dee9c@kernel.org>
Date: Thu, 11 Apr 2024 20:48:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RESEND PATCH] bpftool: Fix typo in error message
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240411164258.533063-3-thorsten.blum@toblux.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240411164258.533063-3-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 17:43, Thorsten Blum wrote:
> s/at at/at a/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks

