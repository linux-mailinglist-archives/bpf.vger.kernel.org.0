Return-Path: <bpf+bounces-60467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D23CAD7345
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BD0172BA6
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE724C66F;
	Thu, 12 Jun 2025 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jLMaqWT1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C8149C4D
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737179; cv=none; b=EpY864CtB1f/s52ZGt+6meVxQdlCov4jUi6nZJre50s1eAIz54wnbuA3yGGP1MMnnrifYfD7ZztzqwkoDDMZCcKaclhDZaZAUAn+ehSjZ7LBZ003fF/rYbfzWD2yvRm0nDABN0PYFb/Yf3Q42gz8CTOR18/ZiC/GiXVMXFstDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737179; c=relaxed/simple;
	bh=4ChK7e4PZIbGo6yIhGanb9DQUsVcV2UEtIFr/3kfE74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gG1cVpkZd3mwmHGgHMXzAWUoHrTB6V5nHQwkrC9hvU20WGBL+B2zBz+QMi9lFryydzBMsJyQMRhdr2wFxq9Zer/87vdKg0tl3Am5aVxTUu+d8gkQJVA0uOqqafbT+glxaRr3IMiGOdFdNt5a50R4ENE7buSw8U927oY8vm2APwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jLMaqWT1; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-874a68f6516so84208339f.2
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 07:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749737176; x=1750341976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU6I8KFtIF7gtlB8ZnFNNleYs6udjVIddSeSWWR+RTk=;
        b=jLMaqWT1BEgl0/V26AQ6QvbOzAwrlSs6JmaTA/YqKMgf3CGUpUJey8j6TYA9+bpF6z
         hrHwFR4BplAvwb3U+OE70O4z2OhO4kfFkgBuiktW+5HKHPK+7FEwEd6xn4DMoJG1CCMi
         4CpqQM37OLf3pxLphThmlhZSMVQnbiAPEalhpi6g9LSChwx4vATi7FTQiCwH/bItCC4t
         OWfVrrWWKnksu6ZmXeamxhTmFU9JciUVqNXwJnhHasBMiG0a12bgqImDxEPgi1bk5smP
         SOg+sxWUzPwnh2Q/DyLroiUYLmIgnFYbiLGwEJL80pU5XoQyfQyIieOmWomvjYZODEqP
         5qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749737176; x=1750341976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU6I8KFtIF7gtlB8ZnFNNleYs6udjVIddSeSWWR+RTk=;
        b=CysfBx73p9AX8MjuchXlQq9bYCTReNtqv2Crw1DmTDT8tJPZjA0ubBQLRAKKjBP+Qe
         DpxCXZ3nfJCGFNQHqnVgTFU1+uobuGRw6rRUtAQGWbPBA4MVW3359eqt9XepcAToXVMU
         lX+dA+QEEmNhxa+wntzErVuo0zxg4P1y4vd1n3vi+vqlrK1pwCrp+zF8K/zBNszHqlpb
         2aMSI/VMZKVkLZ2cz+j1WLEXxr1LdDrmiYdtVvRtxgPC1HPMalsMxIfB+ycl00ip8GmP
         9QEpjYw55gMpReXxE8iDibO8dggafXRieRUVmtCWcPTmrIOAsoI4XrTzsAa44pUtZL7o
         txew==
X-Forwarded-Encrypted: i=1; AJvYcCXt9610Ac2k4C8i/7y0EfP6wrdUMjn7Sm+yw+PHW3NoXsAGMlRJy1kznwq5lfe0w0bSNEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZBHz5GYRUpnoHWJHtS6OE+3XhTDSd9ffRp9f9sDE03C9pUli
	9VCtXH7D/8fZZSXDoUlzDdcMd4YiFLvSi+RkRcrdK5EuSQNCJH0bAHWPjTdbiWPlvbk=
X-Gm-Gg: ASbGnctJ9AUYtCd3PLRAKV3mCLhzs4iQRivxDktWTt4LbXltlcalsxuRZRcJzwmE6vC
	8xrYnmUhTJOhA/Rub0lspDjI3hmfHgh3Z0Z6TyO/7OP/fVrMlbiygcJkBhO/HwBI1Ny9ElIy+ey
	7xx1r/EM9hMYcCpAjbvhr60LTqPfx/iTMGYMdiPpL8FFUq+5vHgfgqvJmt7BpL+sZfarZMTTufl
	w0Isl6bgnhIbaoEVY2Ms1eQpg/YkAf+C10WlL3TX0s4p5p6vcGxKmBLVAP404g/Ng+A8vDhFmur
	ZWZKjS/Tm6ybtq0C3eEdifrcs+7tbMvRCHd2eZS71KNANjRbJiIg+tT1/Ds=
X-Google-Smtp-Source: AGHT+IGwa/W/bwZ6mhkAXRr6G5LVK0LhE+hanV4uE2MJO+JAFyftWu8co4CAKe/KphaDCpHFbCPT8Q==
X-Received: by 2002:a05:6602:3a03:b0:869:d4df:c2a6 with SMTP id ca18e2360f4ac-875bc49bbd2mr915998539f.14.1749737176105;
        Thu, 12 Jun 2025 07:06:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875c7f64de6sm35469939f.33.2025.06.12.07.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 07:06:15 -0700 (PDT)
Message-ID: <e6194c29-18de-4dc9-a2fb-2ad63816481d@kernel.dk>
Date: Thu, 12 Jun 2025 08:06:14 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 5/5] io_uring/bpf: add basic kfunc helpers
To: Pavel Begunkov <asml.silence@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: io-uring@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1749214572.git.asml.silence@gmail.com>
 <c4de7ed6e165f54e2166e84bc88632887d87cfdf.1749214572.git.asml.silence@gmail.com>
 <CAADnVQJgxnQEL+rtVkp7TB_qQ1JKHiXe=p48tB_-N6F+oaDLyQ@mail.gmail.com>
 <8aa7b962-40a6-4bbc-8646-86dd7ce3380e@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8aa7b962-40a6-4bbc-8646-86dd7ce3380e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 7:26 AM, Pavel Begunkov wrote:
>> For next revision please post all selftest, examples,
>> and bpf progs on the list,
>> so people don't need to search github.
> 
> Did the link in the cover letter not work for you? I'm confused
> since it's all in a branch in my tree, but you linked to the same
> patches but in Jens' tree, and I have zero clue what they're
> doing there or how you found them.

Puzzled me too, but if you go there, github will say:

"This commit does not belong to any branch on this repository, and may
 belong to a fork outside of the repository."

which is exactly because it's not in my tree, but in your fork of
my tree. Pretty wonky GH behavior if you ask me, but there it is.

-- 
Jens Axboe

