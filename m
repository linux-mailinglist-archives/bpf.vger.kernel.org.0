Return-Path: <bpf+bounces-73013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDA3C20703
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DB93B9EF3
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34F242D60;
	Thu, 30 Oct 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgDbDeEH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45B2236E1;
	Thu, 30 Oct 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832718; cv=none; b=ZApFMSP9Xoe1VIIUsB9Ra7P/TBQqqzoYarWqZKtGGvL/ZBX66nheoj8qDtdwVU9YTQrp7QnFRtBPlSi95uCfB+hknvnFa90V8cJ//YlJlAYStTDYOjbBYV1ELmq3Ps7+FfYcBAZBnMyWeh5CAbuYOeQgy9rFTokbVC7vkRbNbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832718; c=relaxed/simple;
	bh=FyyMcmRgfiIYTjcYkIsdtJNL7ETHlmFbUG4j+jNYl/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgf0/vxJRl1ZS14sRb8bcqsejQ2CgvDAaVNVSzGBunYzdiQMiIeJV1BXk3v2U/QYQ6CDJILHsyGQLnUAtyQvfP4hDnUSah3Xc1KhSjDMURKY3tLYnr7xhf44fySYtpihe0knORtd0aGCaqZSovwf040xh+cA0k9TcxKuS4fZoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgDbDeEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D904DC4CEF1;
	Thu, 30 Oct 2025 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761832718;
	bh=FyyMcmRgfiIYTjcYkIsdtJNL7ETHlmFbUG4j+jNYl/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TgDbDeEHr8f23k/XpM9Tg3AarDTt18inQ9fMar7O+b8k6tpCKkz4Td3Z5kzVvTHeA
	 AzfnzP+GtlZ3bm3iAceV4+lFmD2TS9Lwy9xUUO0oMrJMpX8A+L7Ms2tcBBAV3BRcyb
	 BK2mfSewmta47dTMmmPnVWlPTnIfqgeSuxZix15Z2W3EWFRU6L26QleNeM7IO9EEJ3
	 cGI8iAVADa7rZ2H2WYpJjS+Rf2QHtP/QkJYUCD1Elngm5J8QVW3C9MPCKQ9WPKgiut
	 NWKELy16rI6cyooYnNIv+yzMdlsv07odY520sKj82j1Zl1rG1Yj84bVW5MOJ6ozkAr
	 Jo9CoP07VxL2A==
Message-ID: <fc3a12bf-8b79-4ba9-8129-a4ad11c4852e@kernel.org>
Date: Thu, 30 Oct 2025 14:58:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 2/2] bpftool: Use libcrypto feature test to
 optionally support signing
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, terrelln@fb.com,
 dsterba@suse.com, acme@redhat.com, irogers@google.com, leo.yan@arm.com,
 namhyung@kernel.org, tglozar@redhat.com, blakejones@google.com,
 charlie@rivosinc.com, ebiggers@kernel.org, bpf@vger.kernel.org,
 linux-crypto@vger.kernel.org
References: <20251029094631.1387011-1-alan.maguire@oracle.com>
 <20251029094631.1387011-3-alan.maguire@oracle.com>
 <fb2fd1cd-239d-4783-8b24-66af0e754a47@kernel.org>
 <4ad07c65-1d4e-40ad-97e1-a7594a4d0d2c@oracle.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <4ad07c65-1d4e-40ad-97e1-a7594a4d0d2c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-10-29 11:22 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
> On 29/10/2025 10:40, Quentin Monnet wrote:
>> 2025-10-29 09:46 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
>>> New libcrypto test verifies presence of openssl3 needed for BPF
>>> signing; use that feature to conditionally compile signing-related
>>> code so bpftool build will not break in the absence of libcrypto v3.
>>
>>
>> Hi Alan, thanks for this work!
>>
>>
>>>
>>> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>>> Suggested-by: Quentin Monnet <qmo@kernel.org>
>>
>>
>> This is not exactly what I suggested, I mentioned adding such a feature
>> check and printing a more user-friendly error message at build time if
>> the dependency is missing, not leaving out the program signing feature.
>>
>> I've got reservations about the current approach: my concern is that
>> people packaging bpftool may prefer to compile and ship it without
>> program signing, if their build environment does not include the OpenSSL
>> dependency. But it seems to me that it will be an important feature
>> going forward, and that bpftool should ship with it.
>>
>> Regarding the OpenSSL v3 vs. older version concern (from the build
>> failure report thread):
>>
>>> One issue here is that some distros package openssl v3 such that the
>>> #include files are in /usr/include/openssl3 and libraries in
>>> /usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
>>> figure out a feature test that handles that too?
>>
>> In that case, we should have a feature probe that gives us the right
>> build parameters to ensure that v3, and not some older version, is
>> picked when building bpftool? (We could imagine falling back to an older
>> version, but I see v3.0 is now the oldest OpenSSL supported version so
>> it's probably not worth it?)
>>
> 
> Actually there may be a simpler solution here; compilation at least
> succeeds for openssl < 3 with the following change
> 
> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> index b34f74d210e9..f9b742f4bb10 100644
> --- a/tools/bpf/bpftool/sign.c
> +++ b/tools/bpf/bpftool/sign.c
> @@ -28,6 +28,12 @@
> 
>  #define OPEN_SSL_ERR_BUF_LEN 256
> 
> +/* Use deprecated in 3.0 ERR_get_error_line_data for openssl < 3 */
> +#if !defined(OPENSSL_VERSION_MAJOR) || (OPENSSL_VERSION_MAJOR < 3)
> +#define ERR_get_error_all(file, line, func, data, flags) \
> +       ERR_get_error_line_data(file, line, data, flags)
> +#endif
> +
>  static void display_openssl_errors(int l)
>  {
>         char buf[OPEN_SSL_ERR_BUF_LEN];
> 
> 
> Given that openssl is already a build requirement for the kernel, that
> may well be enough to resolve this issue without feature tests etc.
> However I can't speak to whether there are other issues with using
> openssl v1 aside from compile-time problem this solves.


I'm equally unfamiliar with the risks associated with older OpenSSL
versions. Other than that, it sounds like a good solution to me. As
Namhyung pointed out, bpftool's build affects other things like perf, or
kernel build itself (for preloaded BPF iterators), so aligning
requirements with the ones from the kernel would make sense. From
Documentation/process/changes.rst I see that the minimal requirement for
OpenSSL is v1.0.0, so your suggestion is probably acceptable?

Quentin

