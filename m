Return-Path: <bpf+bounces-58407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D61ABA08C
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 18:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6AF17B61E
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CE1B4F0F;
	Fri, 16 May 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtg5IZjX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2686442C
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411400; cv=none; b=ppiDU8miElYy6S5quQV3g62nZ+Xh3wkB2xL7xWG0OV3Kl9Fi+knZoCAZflc0Dc4LlHR3LGK+YDs8B3GG4n1Xar48+iz+oMK0S/GV9Dwg4PfeVfbqPNXRgXfpI7n/pz8jCg1qDWKbBu/M+PkBrOITaRgFHWyynptQQeM1r2T837g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411400; c=relaxed/simple;
	bh=xXzcEqq5JO804+nZnCGA65KTAFUUV/SpykcZ4egdjeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=em46IYnFeWZpD8KtVdAEpGAZljLCpm8El4l5kw//51VC4XXAm1FHpAsw5bxKhMImRYsfGeNjFV6QShl1SOgxpCC9nqifMGFCh7iecsUtMkSLqw0h+I3nJEKwBoEAoM6OcANTLZmwDqaXh7wRTRvB1YuRLscVV5/+DrvQvuLMqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtg5IZjX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso16570985e9.2
        for <bpf@vger.kernel.org>; Fri, 16 May 2025 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747411396; x=1748016196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOArQAhCjCtwpx1z2fdPrFYXZS5MVHr+gWPLC5VJSEo=;
        b=Wtg5IZjXkqgt5ho1h0lltKoJML8u1/56pSCZsrFi1LMJBw6erITMbXMiGaeRCmBKns
         y/NSH3F7bvH7BVAO7g3/BEziZ+x3AwhnvoPYOpFcWfS8BWrL5sHMnCDgJrHsQayviy6T
         VxhcxAJlJAEHZWq7K1CvL0nYuLrZU7uxfI7ukZyF+xQ8a2RmriaCvteQEuKr5WoF/bwN
         suYOsuczu8MWPTEyArk7MIMO4D/RJviYcOWhv1DNg39A1f7Xw+A/dsUalwyxJpCveSSI
         dGwPIpEsaR1lLnp7xgc7gGPdSI5K4V9fIZx46QwuO93ImMA5A7u9RK2IMHKOaZXrd7YO
         uyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747411396; x=1748016196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOArQAhCjCtwpx1z2fdPrFYXZS5MVHr+gWPLC5VJSEo=;
        b=paaqB+n4Hg5ceOLsnb7yW6Jc9sxXSkI1FgqfTQlgpE3Z8g0qP6FBnoV7nKyEsJ5PAh
         7eFnv4ESPscaU+n30EjhDD1QCuCOvVy9g6HwZgTgofZs5h3Mh5+ysSe+v+y6SJxGNfMj
         LTcgB//DoCMcL8Titu5v7ljBnXl18Pi+dpvCPd3Aep1Iq4Xp0K534TqwbKbVHBCsbkfX
         JPt9h5XxRANrcv87YjA/gi+6Jf57myjPGBgKBBdYakHhkz4SUnmNoDnwRCkKLuOVv1Lm
         qmmfDbYiUveY69miG4xfpz2f3yNVH+mlJeetJQ7DY/ZAXvHRHfymbNLcB1bw2Gm+GOb7
         g+ew==
X-Forwarded-Encrypted: i=1; AJvYcCWnF/i5FMb8R+y/QIR4pkOplpRh1VKLA9SliFnCHBxW/6PqtUcNpfDss9BrmTWHdzrq0fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM42MVQnn7AIamK6FpB3mAtPLSwNI/L5v1v40SiIuGT3KYotp7
	8ENFidnHjwJDdDpHnec5OXqx06Yyi/pbKSeNeeaOKpHTsWOg4VdHgrQC
X-Gm-Gg: ASbGncukOlAePO9xZE/ZXQv+6feFH3a377t9ok62AGXvJENDjHP1Nb0yz2r/5LOCZcK
	dCGtdTc7QdHyqjAgoQrhEP12X4CakEv34J1GO4BjmPcLoyDM+gt2nhbhcruk3p1Eutcx334Xviw
	jihahsje+YNvFNqsHA+CUYNdbebgKzzRJZ+WGMn4aNMK78vE/9970YQOud/LBGqd6q769Ole7Tb
	6ju1QeRuBjNICTElylFUa0F+u4HB3MbMveGC9oDqpPSaDXmUQv8luQLDHiZU9kgWxkNnCDVZyJj
	OGrMqtAduI0Oawc6HS2SfTVwlh8bvnwuLHqiOJNGvaZd5gzXujLrxbDQFEKJ02UyBcze/mwEnH/
	tRb+b3nUkb/G6INCuu1xLR9jwCRP8VZsM
X-Google-Smtp-Source: AGHT+IFXhwzoAIhwzlvq14+UQN1L2FB8CnbxTqt3fqt0s8Pk7KpSkaaZbr37cNy8Y4V84XrY6c3N1w==
X-Received: by 2002:a05:600c:c10:b0:442:f989:3dfb with SMTP id 5b1f17b1804b1-442fd60b448mr38953885e9.1.1747411393957;
        Fri, 16 May 2025 09:03:13 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef8bbsm113583075e9.37.2025.05.16.09.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 09:03:13 -0700 (PDT)
Message-ID: <d2368b21-2e45-4601-be04-fc2e51ccf91f@gmail.com>
Date: Fri, 16 May 2025 17:03:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix
 dynptr/test_probe_read_user_str_dynptr test failure
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250515195145.3127492-1-yonghong.song@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250515195145.3127492-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 20:51, Yonghong Song wrote:
> When running bpf selftests with llvm18 compiler, I hit the following
> test failure:
>
>    verify_success:PASS:dynptr_success__open 0 nsec
>    verify_success:PASS:bpf_object__find_program_by_name 0 nsec
>    verify_success:PASS:dynptr_success__load 0 nsec
>    verify_success:PASS:test_run 0 nsec
>    verify_success:FAIL:err unexpected err: actual 1 != expected 0
>    #91/19   dynptr/test_probe_read_user_str_dynptr:FAIL
>    #91      dynptr:FAIL
>
> I did some analysis and found that the test failure is related to
> lib/strncpy_from_user.c function do_strncpy_from_user():
>
>    ...
>    byte_at_a_time:
>          while (max) {
>                  char c;
>
>                  unsafe_get_user(c,src+res, efault);
>                  dst[res] = c;
>                  if (!c)
>                          return res;
>                  res++;
>                  max--;
>          }
>    ...
>
> Depending on whether the character 'c' is '\0' or not, the
> return value 'res' could be different.
>
> In prog_tests/dynptr.c, we have
>    char user_data[384] = {[0 ... 382] = 'a', '\0'};
> the user_data[383] is '\0'. This will cause the following
> error in progs/dynptr_success.c:
>
>    test_dynptr_probe_str_xdp:
>    ...
>          bpf_for(i, 0, ARRAY_SIZE(test_len)) {
>                  __u32 len = test_len[i];
>
>                  cnt = bpf_read_dynptr_fn(&ptr_xdp, off, len, ptr);
>                  if (cnt != len)
>                          err = 1; <=== error happens here
>    ...
>
> In the above particular case, len is 384 and cnt is 383.
>
> If user_data[384] is changed to
>    char user_data[384] = {[0 ... 383] = 'a'};
>
> The above error will not happen and the test will run successfully.
>
> Cc: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   tools/testing/selftests/bpf/prog_tests/dynptr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> index 62e7ec775f24..4cc61afa63b4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -45,7 +45,7 @@ static struct {
>   
>   static void verify_success(const char *prog_name, enum test_setup_type setup_type)
>   {
> -	char user_data[384] = {[0 ... 382] = 'a', '\0'};
> +	char user_data[384] = {[0 ... 383] = 'a'};
>   	struct dynptr_success *skel;
>   	struct bpf_program *prog;
>   	struct bpf_link *link;
This test is disabled in the DENYLIST and the fix was submitted to 
another tree:
https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/
It's a little bit different problem.

