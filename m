Return-Path: <bpf+bounces-12702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091B7CFD72
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C292821B4
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730862FE07;
	Thu, 19 Oct 2023 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sUoD+aIc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F92745A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 14:59:04 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F0D12D
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 07:59:01 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-355fbb84257so5398765ab.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697727541; x=1698332341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+fSKfoprD2xjep9haqaGcjsUyuDzAiaP8KcDuihTMA=;
        b=sUoD+aIcaveSUSQ0/cmDczMrbov3C1nT/mruXdO99rQ/odOehiiDEv6Z/HozS/9CPm
         Db6jo18+L18LikJf9G5Y8x1BXOo6bbBEbWvqIePhegMNknQfDWgqgNnHUkPW1nKqM0vu
         BaYMN96YJamvXWEfHQ5jxN/Q5apVFDPowcyEkVG7NfjtKQnat/a8p+VV8EzB5DmOMq+q
         99g+IbfVibMzeNYIZ4rkNNUjp/748Ko43Qesf+jkL5afgc8Ms2oPQvoaQFnJTpem83q9
         NwXZUumY1p79ks6jj74djdfnD86bWlWXITDuBUDGr9sDJ7U+5DkQLBuKb5LKR+3TVjUW
         Ap6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727541; x=1698332341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+fSKfoprD2xjep9haqaGcjsUyuDzAiaP8KcDuihTMA=;
        b=w9gs1RyQFzRfq5AJ+GbaxesBC89snyraZr9Zi6Q48Gt5+Xu0szBXjSWpTAVxhSH9Ff
         BiS+MRbF+lrKLMKgRBLobCrFORql+7nly0ox8GbG655bOi6rLvoAfaTjDbWpMv2Wmb5a
         4dhE5AOyIykKnAg+hO2OfKttXivkeDSaYncTxBcBXSlc+I7n/46P+kNGXJTeMyY3rZEc
         rXJQsEPiVsviC1RWna6IaPLuIuxBqEberFmT4mrhlIQixNIpy4w3gPxIcdv3WodKCDui
         vZHBvhbCKq1euO7u5wurfJd/gJ9tCfd6HyTgzrHGwgOO4ZQzLT+f2eYgmHu+eDSjQIZT
         DN0g==
X-Gm-Message-State: AOJu0Yywh74r/NOH7VBFHXxzsBcCQK03h2vogb9YKAapB4XnfYWEBoTd
	Gz9D728A3FE5tXkCakg+Lucinw==
X-Google-Smtp-Source: AGHT+IEh/tK0F10IvZvGnoSbcbP2On+lPSGmusrkOrr9+UtW+WgbOIcoUk3HPRR/bznJy32nKzETUQ==
X-Received: by 2002:a5d:9d56:0:b0:79d:1c65:9bde with SMTP id k22-20020a5d9d56000000b0079d1c659bdemr2438497iok.1.1697727540691;
        Thu, 19 Oct 2023 07:59:00 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s1-20020a056638258100b0045b16bddb8fsm1932502jat.111.2023.10.19.07.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:59:00 -0700 (PDT)
Message-ID: <7bb74d5a-ebde-42fe-abec-5274982ce930@kernel.dk>
Date: Thu, 19 Oct 2023 08:58:59 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] io_uring: Initial support for {s,g}etsockopt
 commands
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, sdf@google.com, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 martin.lau@linux.dev, krisman@suse.de
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org
References: <20231016134750.1381153-1-leitao@debian.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231016134750.1381153-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/23 7:47 AM, Breno Leitao wrote:
> This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
> and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
> SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
> and optnames. SOCKET_URING_OP_GETSOCKOPT is limited, for now, to
> SOL_SOCKET level, which seems to be the most common level parameter for
> get/setsockopt(2).
> 
> In order to keep the implementation (and tests) simple, some refactors
> were done prior to the changes, as follows:

Looks like folks are mostly happy with this now, so the next question is
how to stage it?

-- 
Jens Axboe


