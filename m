Return-Path: <bpf+bounces-45021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFAF9D008D
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 19:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B078A28355D
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAF195B1A;
	Sat, 16 Nov 2024 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kwaOetkz"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9079F6
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731783265; cv=none; b=eLFWOvQlg58CptNDJGdd9Q0P6aM93nT9nJpAwzej+B3gw5BqGpR6YS9bBqN0YbOK9e+sJOm8ARea2LHFf8XcHD0ot+dWVqF19gF7tnFxjoVmA3xNq3OzK10bHpNLaxGrm0rWTPSQSv9wx0rgTHxemdokUGBTG8i0u4eJqp7F/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731783265; c=relaxed/simple;
	bh=HhJ5pN2/GxXKA4Rbq4lfzOtpM7okGHdMg4kVH9PY1lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O3POd7NxKVsPeQQwDxkgQXzS2tM41Kfcf10cVCoS7GFC6vYb2ZM/udo82rYHidWRzynb0GVPKEFac52zQ0kjYDJSTEKeHTBjoDo0b74YekPBYuoN0xHXF5uxJyvWrEYPigb7jgtQ4+Y0xm/fqi6Vrd/2jyoCc5WLiPU9TOvE3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kwaOetkz; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b992d5ec-c1eb-4ab2-b2df-2464d9a2a847@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731783257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhJ5pN2/GxXKA4Rbq4lfzOtpM7okGHdMg4kVH9PY1lY=;
	b=kwaOetkzI9lVNSyANWoe+1jPYaXDJ3EJN11Sw/RUTnYmMBoR7srIc0hQ9DBCmLjgweRVHn
	cI5Y/FPvDduzFrx1YDkOXel8heeL3aXNCUvRyg8h7+UOGNWfaSr2EoZg/FklfXHMGnueBJ
	fT86F5ldvJkkRuqIek+a3rsewYg5rxw=
Date: Sat, 16 Nov 2024 10:54:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: Change hash_combine parameters from long to
 unsigned long
Content-Language: en-GB
To: Sidong Yang <sidong.yang@furiosa.ai>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241116081054.65195-1-sidong.yang@furiosa.ai>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241116081054.65195-1-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/16/24 12:10 AM, Sidong Yang wrote:
> The hash_combine() could be trapped when compiled with sanitizer like "zig cc"
> or clang with signed-integer-overflow option. This patch parameters and return
> type to unsigned long to remove the potential overflow.
>
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


