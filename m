Return-Path: <bpf+bounces-65341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7EB20C5B
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCDF4233E6
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4873D2D3743;
	Mon, 11 Aug 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koNSET90"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAC264A60;
	Mon, 11 Aug 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923147; cv=none; b=Jjm91gQZ5WYTqUGRJkmpjpiq/GRzG6XfCwhQ3wrVtiRky6E4w4JNlanqvgqMasJbsKILr1J+3JGaPgN4ZLSLqhmFPHdcm6HPMYi2ntbRqCZ7WxXsNlRsfx8Mq+9HAZr+PRGuN+km7jReJi4ic5U6KOxivBWGqzOrRm4E9fjyMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923147; c=relaxed/simple;
	bh=ifGAXlbozYs3K4GIdILeV4fl10TVo7tI2pHUZvvUmKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPSAN1S9qZTrsfks73PU5qodxxe6apTqiXU90Btg1C3Aeb9ftLmYCPINJPSVP3hyUgNY88VwcDxv23ShCODMoqrZl79XtWU1cLD5sisX2KyJpa1fzBfH6uMRjrBldcKJr2Qv6HwOk/4YnhnNDgejxJspM3r6SIbgocGkGhLC2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koNSET90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EB4C4CEED;
	Mon, 11 Aug 2025 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754923147;
	bh=ifGAXlbozYs3K4GIdILeV4fl10TVo7tI2pHUZvvUmKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=koNSET90HP7qS3LJV5osLYX3L2l0cZJ0kauDHijdeJcXIV9Qw1dvK2ikrL3fiZE89
	 vvM0E93JhXCwW0j5wSSeGmV0aWz6Ufu++reTSviE3s7aQG6nrzbZin5mC9dfNgOl7Y
	 aU0FFesEeZsEvimS/9y4PTt7a6Yp2deEWno8PYF/JczpS76iw3qQUGYQXabp/6mYPc
	 5rexegRcwsC36+/zfCrc/uE5oW0JyzmfZxGx8rWjLJITrq7PY1vQ+jJtPikqGjlbNN
	 Fff/aqSGU6Zn2r/B9zrQMsMWtz0Bgyg/si/wv7TUNUUDkjYxbesjl2l4XaK2uIJmaZ
	 6SV/AHeDCy+0Q==
Message-ID: <02f7a7d1-297b-4304-8c11-dab091e20f2a@kernel.org>
Date: Mon, 11 Aug 2025 15:39:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] bpftool: Add support for signing BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20250721211958.1881379-1-kpsingh@kernel.org>
 <20250721211958.1881379-12-kpsingh@kernel.org>
 <2b417a1a-8f0b-4bca-ad44-aa4195040ef1@kernel.org>
 <CACYkzJ42L-w_eXyc1k+E7yK4DGC3xjdiwjBAznYJdXWzuq4-jA@mail.gmail.com>
 <CACYkzJ4_DUx-HXmygptxKDg1PjkwnQGKzkfRMms8O_wN2Urpmg@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CACYkzJ4_DUx-HXmygptxKDg1PjkwnQGKzkfRMms8O_wN2Urpmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-08-11 16:23 UTC+0200 ~ KP Singh <kpsingh@kernel.org>
> On Thu, Jul 24, 2025 at 7:07 PM KP Singh <kpsingh@kernel.org> wrote:
>>
>> On Tue, Jul 22, 2025 at 5:51 PM Quentin Monnet <qmo@kernel.org> wrote:
>>>
>>> 2025-07-21 23:19 UTC+0200 ~ KP Singh <kpsingh@kernel.org>

[...]

>>>> @@ -533,6 +547,11 @@ int main(int argc, char **argv)
>>>>       if (argc < 0)
>>>>               usage();
>>>>
>>>> +     if (sign_progs && (private_key_path == NULL || cert_path == NULL)) {
>>>> +             p_err("-i <identity_x509_cert> and -k <private> key must be supplied with -S for signing");
>>>> +             return -EINVAL;
>>>> +     }
>>>
>>>
>>> What if -i and/or -k are passed without -S?
>>
>> We can either print a warning or error out
>>
>> A) User does not want to sign removes --sign and forgets to remove -i
>> -k (better with warning)
>> B) User wants to sign but forgets to --sign (better with error)
>>
>> I'd say we print an error so that we don't accidentally not sign, WDYT?
>>
>> The reason why I think we should keep an explicit --sign is because we
>> can also extend this to have e.g. --verify.
> 
> if (!sign_progs && (private_key_path != NULL || cert_path != NULL)) {
> p_err("-i <identity_x509_cert> and -k <private> also need --sign to be
> used for sign programs");
> return -EINVAL;
> }
> 
> I will error out, I was waiting for Quentin's reply, we can fix it
> later if needed.

Hi KP, I meant to reply to your email but forgot, apologies.

Yes please, it makes sense to me to error out in that case. Let's make
sure that users have the right syntax rather than letting them
accidentally turn off signing.

Thanks for your other comments and clarification too, looks all good to
me :)

Thanks,
Quentin

