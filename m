Return-Path: <bpf+bounces-35545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BB93B668
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A91281E59
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F115ECD1;
	Wed, 24 Jul 2024 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv6Fc9Er"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B89155A24
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844252; cv=none; b=DGp6/FbffslIEotnOPJ2xrgnwszOcVMU24J1N4+3OEbuSLt/Ir7CslLUEabfIiFPTjCgd2FLJwp30FAqUJ/r90aMBtp7kEZs5b6co2JdxETasU78OpDC9hE3QZjAONAsWnXaDOvBNQavoXuucx/Sk9pVb1zmWmaPYeGBF+1tLRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844252; c=relaxed/simple;
	bh=slavYCsacW2MmpZltK4apwG+1v4/8DJUFWLBB4DagR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ+db1H7O+Snh7cOWUstCi98vNs+7IMkv4eCRdLuiBGH4qnvHLntR301gOkQermuqB7envtDAN9my7Y9BK6sEfa8MC62U1tlx3mXemIKgbthng/Xi2VgVaxO3KriCosrfygI4meziqRKkjyV3AhxY+ouuq9JbGTcvlL+9RKBOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv6Fc9Er; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-661369ff30aso530327b3.2
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721844249; x=1722449049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Rb68PI7te+pXqcYrUWh36nXPGwZ4Jd0ljsCmfd4HRw=;
        b=Bv6Fc9ErZWo1/p2QJL72rApovuGg4YLldCU+l2oa7NZMCYG1pW+JZ1/n/H0+tEIKFU
         OVMT+4X/lTJrDltiiJA6iYlS08b46LD6ZUOfc4qgU6kJU394l6yBoCikg4xJJAEbkKLa
         pxrdPMFXmYalET/MpO2xomiNUwOvX9L5NnovPG+VLGFlvU/FJNYDmYtxd6Hmbe2AeLWA
         zFNwD6P3orHjFpmGL9pCe8BUbxNUF7XOt5jtLbHsSuYT593FnOjWQTHipk0EuoIDtF7u
         dFEewYmPgQ70PrE3SROK+fBStTAjI9OJrASw7+80hasjLlhXlNIRBpRs6i819RNjTg0g
         N9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721844249; x=1722449049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Rb68PI7te+pXqcYrUWh36nXPGwZ4Jd0ljsCmfd4HRw=;
        b=sKNtOQ0kovBMQxVEnU9GzNuEuNDSOyS9twXrom+01d1J/haw8UEJnt3E6BS5PhpHQQ
         u7YWiB3krD/S3EWh+03TCnud44Q06zRgAlzpuhpJ/0P8ZIt8YUFjYPpZ0iyfbWduOsvU
         XQgH95mCCPCjQUFEk2gp52Dqn+K5my/WylR3C1+TvCoCFqV2M/N6Ye0L8HPUnmTC3CxG
         T2vwIEK3u5powSpqYZ6r5DkxZ+HiEc5bF7WYlpWrP8tarAyRLaTXGCN04hKKQ0h0YnAH
         FNo7IcYK4nUVE2adYUDlO/wipZFxErZTfWdiwSnrEx6zq72SgGrbUzp5ULItqwxM9MnM
         1iWg==
X-Gm-Message-State: AOJu0Yy+2ZN8SFe0WPjPxwUgG+0/kLoL4eB5Ujhv/Ntq3doqIt2UYEzw
	X2fVuXRMhkx4sbCUYPEjuU/+57F4oDPhmbFXMyWD2m4oKd6YQVAN
X-Google-Smtp-Source: AGHT+IEihbCpLd1D9qjIe4HjU7rg8NI6FeJjYkkK0ptPieed/zNE33r+X0vQZipBGk3vM4HgAMfFDw==
X-Received: by 2002:a05:690c:c0f:b0:64a:e220:bfb7 with SMTP id 00721157ae682-67513ed68a4mr2643117b3.30.1721844248671;
        Wed, 24 Jul 2024 11:04:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:abc3:64f6:15ee:5e16? ([2600:1700:6cf8:1240:abc3:64f6:15ee:5e16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66c4e92c902sm13845977b3.29.2024.07.24.11.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 11:04:08 -0700 (PDT)
Message-ID: <4b65a398-b938-44e1-a0b8-9a663c182577@gmail.com>
Date: Wed, 24 Jul 2024 11:04:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Monitor traffic for
 tc_redirect/tc_redirect_dtime.
To: Stanislav Fomichev <sdf@fomichev.me>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-3-thinker.li@gmail.com> <ZqEdE94dcBewr9Bu@mini-arch>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZqEdE94dcBewr9Bu@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/24 08:26, Stanislav Fomichev wrote:
> On 07/23, Kui-Feng Lee wrote:
>> Enable traffic monitoring for the test case tc_redirect/tc_redirect_dtime.
> 
> Alternatively, we might extend test_progs to have some new generic
> arg to enable trafficmon for a given set of tests (and then pass this
> flag in the CI):
> 
> ./test_progs --traffic_monitor=t1,t2,t3...
> 
> Might be useful in case we need to debug some other test in the future.

We run a few test cases with network namespaces. So we need to
specify namespaces to monitor. And, these namespaces are not created
yet when a test starts. To adapt this approach, these test cases should
be changed to use a generic way that create network namespaces when
a test starts.

Or, we just monitor default network namespace. For test cases with
network namespaces, they need to call these functions.

WDYT?

