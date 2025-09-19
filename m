Return-Path: <bpf+bounces-68927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E75B89467
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 13:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0663BC34F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055C930DD10;
	Fri, 19 Sep 2025 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="baPpSguH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6062D94BD
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281353; cv=none; b=VUiaVjQLXQh+c363FzCYRZ9Zbp6aQmQFebpwlcjP3ibx8nfhkSjl6CkV0463kK2js4dG8t7HttIUxxCE1n15aG3YX8g/PEG4tXwTze2y0iz5uTar4WsrLKUX76mW4MJ68B+w1DzAWIID1g5T0aMkdA5lOuKQAQ/bDUOG+QWAxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281353; c=relaxed/simple;
	bh=hoyRD8cY6+eAWp0Ym0oqTHL+yd0Dp6KCPwO2D3eCKJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Er1ysE7YdDdCFC8QufMrlpRk05L13TcDQicCWqkv1kVQVHFZ/Xo7D2njNAC2cASh7pyaHmL5dJrB38VRWewTkElIYrGY6TgTBxmijDPTjEipWUwSsQ36znnnqk6y+hb/20ZvretHM1Yl0Wnc8DbzhUeiTssd1Ok77HtfX24Zp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=baPpSguH; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea473582bcaso3457005276.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 04:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758281351; x=1758886151; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7lPhtBvPOvEeVY2Tw1J4kWk3fxAvD+cbqglxKZ4L5k=;
        b=baPpSguH8CfCw51lUwZAi/EBle9vHTKVGZghlCMQ1aSKCDkTGXSnMyt62sqhIOYLVS
         D2aspQ7wqNL2Y26urF7lCY1dj5WPs4rn5BcMWF7RO2/qTm/0iFeUz3eRBDDTA4et8BSO
         cLeLBSh5Nyiss4zTJB1iOP4xJLl39Rv4eTrSEKeYRBY/0oCiTLxwKeWxqqWoLgRM3Pes
         VUOMydwke5rpcTX/SXmG+SP8E/8FEbq1QEeZM6XS5HwiAnY0ofy99NXCADBZkI3JSQ+/
         o9vFxrAX/w6cfdbLcbBZSx0ZUj6AHIeWDL/4lOQhtxgiP/XCo0A050JmuoOgHeb8mPc4
         7TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758281351; x=1758886151;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7lPhtBvPOvEeVY2Tw1J4kWk3fxAvD+cbqglxKZ4L5k=;
        b=Ba+jHtvdPJRfIXSoaYN52FOHemP+fXc5zcbDpZ6yIRTDOeNIWP8OLndE3OXtsds58a
         R3dPXZI9Fh094pvTI8cdvlMroyDm81I4+oX9LPe70WeCdvqxZCRfV6TmHjtyU+20kAKH
         +OCVkGeE/2eTEhWXGGxmKJX9PEeERa1hA4xvibaJwosqtbkNgWxN/eItfdy+Zlisqm9X
         aKL5SUS01g9/P+KZcp0DXMKtYBaFws5W8235w1R6VBCeDPOJujqcgHGM/QuOva9DHFBx
         7g53ppvKpKKcDUsNm5TdPm8/VMSQSJY2LjYmQcw2LUcHKzwSBq6clKXhWgjuWAR72Un3
         zepg==
X-Forwarded-Encrypted: i=1; AJvYcCUdLtdQexXxdFqNFy/ruuWQQEV0bXxJHhcNiuiSHpDIikwS1HuQ73JrYd7wDivbsmSx5Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXDc8hZEnDgI5NMNehTvqkt4xuNwBz3PMp8upcBG/xCYIkH+8
	rhLeZiAM0nmNZ/0QG7v4bY3kg55F9dFCCVpTpeFjy/uXxNi5MQcukWIcPC9521BY4bIs1h9kzRq
	cIk3f
X-Gm-Gg: ASbGncu69ydXg8A9P8LmCAOOgTjDbpiBI2ZYZ9kr9UMmxTQ6mI+tYlEt/kr/7R99/js
	NLO0Uj5QssnXjw18J8FmwYJmzcoy07bTRUGbCJsAZ9xB4vgi5JHzPq0dGf244xKPhgQwHXi68XE
	XupIIo4cMWTR/l/PqEUAbS8co33mrZ16fBdFYhVrrow6r2rEHvk3OWq+WG2b+VD0Qz6lerLLy3L
	Xme654sNq5NmL7PA0XHH4Zx7zMJAWG3mk+d4trSQv/RckScf0DHSlrStUKdc71B5KWDBjSgoKgm
	9ghjKWYgQvaJUVSFMhDLuDiBtRYs0Redv8fTrs6xvS9Xa6VoUELgaYq3sWaPmIIXOtpVm9jserX
	dcXoNj+4sSP1CgQ==
X-Google-Smtp-Source: AGHT+IG343kCVS+/qgurkYvvVqrq3Jkl6cJnzpfAyvWHus5fb7J8doUVLBe/IYPk5awTCYhicojNVg==
X-Received: by 2002:a05:690c:9506:b0:733:aa00:3860 with SMTP id 00721157ae682-739708ca5b2mr47901377b3.23.1758281350992;
        Fri, 19 Sep 2025 04:29:10 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716bdc47sm13585717b3.12.2025.09.19.04.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:29:10 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: sockmap_redir: Fix OOB
 handling
In-Reply-To: <01f6c3f5-be73-4505-8a34-212dee30b5fc@rbox.co> (Michal Luczaj's
	message of "Fri, 5 Sep 2025 13:19:46 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co>
	<01f6c3f5-be73-4505-8a34-212dee30b5fc@rbox.co>
Date: Fri, 19 Sep 2025 13:29:08 +0200
Message-ID: <87348iu1dn.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:19 PM +02, Michal Luczaj wrote:
> On 9/5/25 13:11, Michal Luczaj wrote:
>> In some test cases, OOB packets might have been left unread. Flush them out
>> and introduce additional checks.
>> 
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>
> Sorry, this should also have:
>
> Fixes: f0709263a07e ("selftests/bpf: Add selftest for sockmap/hashmap
> redirection")

I'm not sure if we're backporting selftest changes to stable.

