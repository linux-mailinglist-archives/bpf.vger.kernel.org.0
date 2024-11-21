Return-Path: <bpf+bounces-45381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C39D4FCE
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5271C2833BB
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C79A189F37;
	Thu, 21 Nov 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDHM1RpQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D83B41A8F;
	Thu, 21 Nov 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203335; cv=none; b=SWt+oTmhZZit/I1/dGbvo7GCSIsNF2UjYld7hhxoQhsIBZOTaT2AzRYvWbaVTLMqWgZfDTa3ggME8r7JeS9TrBXe5LjFodwwp1ZX8CpCOX4WNi0ft0nyaE6PaIJv0Nqv4XFMlyuh5lRZCleJT+VjIidwnIfgLJYH/mDKxrMxJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203335; c=relaxed/simple;
	bh=s3B6KDwq2wWcZl/AqSpHlNNnUkEaNyDWXIsvkzPgCUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPPz1RTQf3tUud+6ed5hJaEvfz/uKowiLsM3KnZeclF6Y86bisMLK0afQSsGS+YZmKW1ozYcLuijuM3GR1VqhXxOqB0HwNMj+9sr450qJk+WRn5aLxq5nCQrTkr9OVdFV21s+goE77Cf5XzdUJt9/da2vsUl42Kl+M09lXBKcIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDHM1RpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B4FC4CECD;
	Thu, 21 Nov 2024 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732203334;
	bh=s3B6KDwq2wWcZl/AqSpHlNNnUkEaNyDWXIsvkzPgCUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cDHM1RpQEHhJGHOiAq9ERJHmHdSW0vA1YbCxudrak6fnKpg2qLSrfmyTUM6wqJ4Aw
	 fSW4idV6tfD7C/jXWvjVZE57VtiLvTeYp8hD5QT2qehkhPgdFCax8VI48DJ0BN/dK3
	 vSYb2zMXzmOqc0CduadBxF/F19AQHYq0ijkzWUIF8Gx9DDbyIz4xOv7f8w/RCFDDoZ
	 5AE0ATK5/2tA9vX9/8wEaP0eW4OnadS9o3A0JH/g/C+F73LyyNdKsk3z2MWNX600Gf
	 VIPqCpGLmKk7ABniZt6U4Q7T1l/bHgb7xYOwY46PWXL/mMB/3ectpl/OTosWEZrZYG
	 0UHKbgzjzoChg==
Message-ID: <6e2e589b-4ddd-411e-a1a7-a2caf9689417@kernel.org>
Date: Thu, 21 Nov 2024 15:35:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix the wrong format specifier
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 liujing <liujing@cmss.chinamobile.com>, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241121121712.5633-1-liujing@cmss.chinamobile.com>
 <edfccd59-007c-411d-8ca0-17bf3b9f1f43@bootlin.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <edfccd59-007c-411d-8ca0-17bf3b9f1f43@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-11-21 13:43 UTC+0100 ~ Alexis Lothoré <alexis.lothore@bootlin.com>
> Hi Liujing,
> 
> On 11/21/24 13:17, liujing wrote:
>> The type of lines is unsigned int, so the correct format specifier should be
>> %u instead of %d.
>>
>> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
>>
>> V1 -> V2: Fixed two other wrong type outputs about lines
> 
> This commit changelog line should not appear in the commit message. This is
> still useful for review though, so you can keep it in the commit by using a ---
> separator (see other patches on the ML), which will make it automatically
> trimmed when the maintainers will apply the patch.

Also next time please remember to tag your patch as "v2" in the email
subject.

Patch looks good, thank you!

Reviewed-by: Quentin Monnet <qmo@kernel.org>

