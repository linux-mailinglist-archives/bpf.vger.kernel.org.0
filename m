Return-Path: <bpf+bounces-64435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39597B12A00
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 12:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD894E1C29
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E5231A4D;
	Sat, 26 Jul 2025 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAA/ye0Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B972AD16
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753524459; cv=none; b=nKRHc0e35170uJE6Th9KvZPNSkCIVcyQ1hxozawpGHbGbiwPcw4K1ktJ2FN8pCpEa3L2k0N3lU8a9AKiaDauh0QU4AFFqCbxZUzGKfq45wX0esyI87rBIo5bBvcbhIdkqXZjBpqVooIcLPocBMdeHVh7awVJxTqygM1dtDjbk6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753524459; c=relaxed/simple;
	bh=y16qXHE9lemtcj3aeZuB40aGElB1O1tbMfXxo+OOeeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B00B0RK4ngYu57voq3CkkhWqkNZ7ZyWzdbDMFrlvqzlTxX7qN4uAH5l5L3agheZa6QqFWK/+bDBtyesAcfpS++46LPG+c2aQtEG2C8OWfjqheGsFCwL+MPs1s+paaHzGoV9A9c43ZoJvvp0wIADr1qdxoq8N8K+//PsR0fKGll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAA/ye0Z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a54700a463so1744190f8f.1
        for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753524454; x=1754129254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PT8Y7yVVoIJN1J2Isz0SnUcr3S/6OoEUP7CnyJWKrYo=;
        b=BAA/ye0ZgPzT1aWHUKfz9OcZpq5QCibMU78Ya7Fap/XQGCrI1GK499n6+wiLXqbx6g
         338Ybu9UDOMMAEJt0OGeCWAFzT+17ritGJgLeR0i+rDzbPJs4f0eTv1dXowgdCRTW/Bz
         ioutrfJ94zHkrgJh64y0HmokCCcv01GSST3qUZH9D2F3CO8dj92C1WkRosHRVWWadsQQ
         8w21sQU6dMpKZFjgywYTG4AoLx6jUtQUS366/cyr5y0anlMPRgaSGI92ZwL6vEyU6HGK
         5ShCpg8iId8MrYUcGK0N7wIAgADXiMvPon399kk0YLGcvdqKyC2VdnpAT2DeL1SJ6u47
         9MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753524454; x=1754129254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT8Y7yVVoIJN1J2Isz0SnUcr3S/6OoEUP7CnyJWKrYo=;
        b=trhAly2+2gVZPEXnio1JjZCW2Wj0dGjqRmqC5V/L5SELgRTg9o9BCpXFojf4+n46f6
         wpYWAzLaMXrLNZSQv/KRO5JPtEt7LVpJ2TMyNuseXIx11kBfrE/gQNcfEbjlrMJxJ79m
         XWylBVZIAi+NmGx/DK8vnagt/L21VrXrnT1J1Su3qVSN4dk3RozmiDxIXxal+Wsse0Vm
         7J7ZCF4rDnlzBYQGTO+DegOZ8MxcUrIcpe24jY3K6SA9vnS12Sq+gG4agOb+gxBOyWlO
         vX0X4xVPT2m6WbSISH1zgeztWJbdGYgc00gLLimoJ2sCIKgTGpTMtwLJ/TZBDbAZkipQ
         yU0w==
X-Gm-Message-State: AOJu0YxCyTTU3xz01A8XO1kNFnZI4oPZVf9YBT4cM5gscLbqoU3BCpJK
	+nxDzhqM2XOzsoXlav+rjfNJ6hRC65vT/k78snqcbW8UFo5xITC9Ngjw
X-Gm-Gg: ASbGncvqZXD2OIJMAGJOteua5xiHDum4NDiN+Tq+u074EvrU1/ZsU5Zult8ZVw8qBSu
	BQPd2eLotuQkjyX24xe8gtQv80EeJfDDeAusLpOZMcQlQeV4V7VrjLUstAvKgGcjW3uTjSnpwuM
	sFwHe4ZPtRij3/lVwLQdF3tQz7NHlfz0BxsRZGGk9BaiJ9soehwnSxMdv+y3K/q8pkY4hv3TzIQ
	ilDxqF2mGUavFyyazKq6n6/30U6ZDM9nG3GRJEyDsBj8YO58EMDeyFzRwnQ6nnC6pWe7NAACQpz
	tybdpm5yawSzapPiuxGnjCGU5kgoOIPmY37DcJlUSu9p+NqdY7m9htzzBqscXAoNtXKlqIwA+es
	1v0hQdTTqtf4P981qqYh5/H1z8SCIHadnZgCL+jrXhqkRL9GHVzcGkihfCIQnVVTBTU86nNdpp9
	BRtFcPw1LzV2c9jQfRddQozMjNywe7Hbg=
X-Google-Smtp-Source: AGHT+IG863L2Zyxf/t7QlyTNlZ7gQNVUrAs/QHtd+Wge3TeK8CDu2kXjIHYMhDjwFaRJwFEGNrkrLA==
X-Received: by 2002:a05:6000:2912:b0:3b5:e07f:9442 with SMTP id ffacd0b85a97d-3b77135efaamr7109887f8f.19.1753524453720;
        Sat, 26 Jul 2025 03:07:33 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d448ffe25653721a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d448:ffe2:5653:721a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcbb7sm84285275e9.18.2025.07.26.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 03:07:32 -0700 (PDT)
Date: Sat, 26 Jul 2025 12:07:31 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Test cross-sign 64bits
 range refinement
Message-ID: <aISo449B0QhMyf2H@mail.gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
 <8f1297bcbfaeebff55215d57f488570152ebb05f.1753364265.git.paul.chaignon@gmail.com>
 <905853bfc266a6969953b4de8433ef9ca7e7a34c.camel@gmail.com>
 <aIKtSK9LjQXB8FLY@mail.gmail.com>
 <6d75ad3a05ebf56ab2f68e677264e8142c372fbc.camel@gmail.com>
 <d7f52ed7d0f0b3fd2ce8336f4161b776cfc0d628.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f52ed7d0f0b3fd2ce8336f4161b776cfc0d628.camel@gmail.com>

On Fri, Jul 25, 2025 at 12:15:18AM -0700, Eduard Zingerman wrote:

[...]

> So, going back to the question of the test cases, here is a relevant
> part with debug prints [1]:
> 
>   7: (1f) r0 -= r6
>   reg_bounds_sync entry:                  scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146)
>   reg_bounds_sync __update_reg_bounds #1: scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146)
>   __reg32_deduce_bounds #8:               scalar(smin=-655,smax=0xeffffeee,smin32=-783,smax32=-146,umin32=0xfffffcf1,umax32=0xffffff6e)
>   __reg_deduce_mixed_bounds #1:           scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,  umax=0xffffffffffffff6e,smin32=-783,smax32=-146,      umax32=0xffffff6e)
>   reg_bounds_sync __reg_deduce_bounds #1: scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,  umax=0xffffffffffffff6e,smin32=-783,smax32=-146,      umax32=0xffffff6e)
>   __reg32_deduce_bounds #7:               scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,  umax=0xffffffffffffff6e,smin32=-783,smax32=-146,      umax32=0xffffff6e)
>   __reg32_deduce_bounds #8:               scalar(smin=-655,smax=0xeffffeee,umin=umin32=0xfffffcf1,  umax=0xffffffffffffff6e,smin32=-783,smax32=-146,      umax32=0xffffff6e)
>   __reg64_deduce_bounds #4:               scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e)
>   __reg_deduce_mixed_bounds #1:           scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e)
>   reg_bounds_sync __reg_deduce_bounds #2: scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e)
>   reg_bounds_sync __reg_bound_offset:     scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))
>   reg_bounds_sync __update_reg_bounds #2: scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))
> 
>   8: R0=scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))
>      R6=scalar(smin=umin=smin32=umin32=400,smax=umax=smax32=umax32=527,var_off=(0x0; 0x3ff))
> 
> Important parts are:
> a. "__reg32_deduce_bounds #8"     updates umin32 and umax32
> b. "__reg_deduce_mixed_bounds #1" updates umin and umax (uses values from a)
> c. "__reg64_deduce_bounds #4"     updates smax and umin (enabled by b)
> 
> Only at this point there is an opportunity to refine smin32 from smin
> using rule "__reg32_deduce_bounds #2", because of the conditions for
> umin and umax (umin refinement by (c) is crucial).
> Your new check is (c).
> 
> So, it looks like adding third call to __reg_deduce_bounds() in
> reg_bounds_sync() is not wrong and the change is linked to this
> patch-set.

Thanks a lot for the full analysis! I've added a patch in the v3 to call
__reg_deduce_bounds a third time. I reused your analysis and trace from
above in the patch description. Note I added you as a co-author; give
me a shout if I shouldn't have.

> 
> As you say, whether there is a better way to organize all these rules
> requires further analysis, and is a bit out of scope for this
> patch-set.
> 
> [1] https://github.com/kernel-patches/bpf/commit/f68d4957204f21caac67d24de40fb66e4618f354

