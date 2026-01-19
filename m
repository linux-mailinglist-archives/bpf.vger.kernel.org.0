Return-Path: <bpf+bounces-79470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C38D3AE23
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 16:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B10F830217A6
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D224E364E86;
	Mon, 19 Jan 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buYHleqI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28291A3172
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834969; cv=none; b=i8mjn/f9tdD8ShKpFeEZHsGcKKkH38019djV2+wnpCazipge/I9HFlx2IGp1m1FSCCJKPzslbOwdUVlE1SXP+DJ8RNxeSdP6CgSk7Kr5W7jyFEOFr/hIu/eXRN0tPAnxXDP6w32sfT9rsNiEi8cUZaaI/41bOl7aeGXQs14uGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834969; c=relaxed/simple;
	bh=aK56Ym/xMX76kiQnFMPVuZM80MLYaaWuy4cfVIyd7n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8REHq68pIvXNsfCfOxkQ1nGNxe1eD7tMdO171C2UcOjNSZpCpzpQ9Xgp9LggVlpTO+qE9cYmUunVwQkaja+YI0rwJzbxfFTM/9/ZuvGE7+fzfkT+P02a3g99zKhRxiqcTw9wPyjKoEw4saLKjn7mYZekpEspN6VbgilodT1xh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buYHleqI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so2456590f8f.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768834966; x=1769439766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKqp9XcHqiL4e8mZMtTJPPQ64a+gniw5AvK+LfnE4go=;
        b=buYHleqIXuZuw9PUtoSaES4TCOBv9B4dSpPFXI2iPpbZyVhBvYnsjqBjaY9Wl/Xybx
         MwSAP3QO+q5ZLA7t4IDt62usk93iPEiPK/GR56qJPq+6M0spURO7nrI+lUJl6EOK7mJX
         3pyqbMfU2B/jKvYaDD12+DR5y6nPIBzApmlGyH0qy/qTfBXIbsiX6uDCjupxdn5Qy40Y
         H/vSB2bGlpqIpC6YISO0Pm8YxXo0L++hSldbFzdsuVye2qgW3rL+U7SZibo4tUWjmD4p
         z4i/OHEudi4Pe8BIkqMOvr/Npug8tICgX989nEIxYB7PB/hc4EWn7+ewhzr+G1594tBq
         Vp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768834966; x=1769439766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKqp9XcHqiL4e8mZMtTJPPQ64a+gniw5AvK+LfnE4go=;
        b=uAeY++XTtwlIxqT9EgVvTu2B1DK0c/F1/PkWgOieVIf0WyC/6v9B/IIWYOzHhUYcPG
         TwVr2a2+8zZouWKjwRnU1F6kTJyhH2WqqeWkjhl25ovmLxjN1xtR9aXfvslgCjGOBwBY
         eE/RRNSsKc0pUKv9CL5XfaHWtGAkwLiMee+S/snBe3Gw/g+xYA5boI9tL2q8Gj2tYDLe
         x5swH1xxrmptqrx1Qy2EG7SHJJuSuT0rcf+CORwZE9dLGf9loHAcE2QWsMYV7QPWnrcn
         GAY1iF9jIfrb8IdrEcOZChCyRfr6oocoy73GE0fbjqrUqw8oAzgl/TPhjEd1X2dBn9dY
         Gfaw==
X-Gm-Message-State: AOJu0YxjZ6POsIrpHXrLy61twY+7VmOBJwfBrHbg0DNf2EyEasKqehFI
	/AOcFHJclqyXZqbtL08/vnxDY5d5s5zKT3EvlRZFKBNWsKv7ZAMja+jX
X-Gm-Gg: AZuq6aIX0Epun4OTLb7P5Ln64TyH3k+JV8u+vhJb15E3aGv4JATLeyehyWu8y7wUM6B
	897QP8rJyqN6Ol0br/kDu6gj6Q0zdt3maanD1Z1beIvOQzl2YydKE7wNSyvBHKxA3YA9FwFd8oR
	fhu2WHi9gXUMrIdJlAhaBGCybdkwOdU9Lh4iZnia9O5dQZEudGmk83aDly0xX6szwUsIvXmgJTr
	KeOnpA88vRjNRgYcNGjdU51wFwl2A4L8zhpwUsunuJBC28kHPwzF0AnphMn7gvBjNBCkv98b7UG
	zvPtu9v6+FhHLiak5tw5QAapiWOteqO/GhXtjon6sraHbvQb9s8snEWfURXjaBVaqv8Rp3TMN1a
	j+EU1QMO9PJ2bMelW7idM/9KUL7vNYk2mlpOkdXVU2j7vjbQmBJzKVufecLh877Dm/9idjssqIN
	vf+QBGqyJxuaY7+lv9aom39OoEDnh0+w3R/k4=
X-Received: by 2002:a05:6000:4205:b0:431:808:2d50 with SMTP id ffacd0b85a97d-4356a024d4cmr15486621f8f.13.1768834965671;
        Mon, 19 Jan 2026 07:02:45 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1130::11ed? ([2620:10d:c092:400::5:9e2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm23686358f8f.35.2026.01.19.07.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 07:02:45 -0800 (PST)
Message-ID: <1cfe2f61-811f-4ae1-924a-07b1e4ff53d1@gmail.com>
Date: Mon, 19 Jan 2026 15:02:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strncasecmp kfunc
To: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
 Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev
References: <20260115173717.2060746-1-ishiyama@hpc.is.uec.ac.jp>
 <20260115173717.2060746-2-ishiyama@hpc.is.uec.ac.jp>
 <46799ba9-d292-494e-b9b1-658448993538@gmail.com>
 <bcce0d61-e7ae-4268-a6ec-a82f1329cc6d@redhat.com>
 <CAJjCV5Hr_WqmMrA8SKJNVKtUOVjhWAcMS1iu7sFDgLr+bm=Nvw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAJjCV5Hr_WqmMrA8SKJNVKtUOVjhWAcMS1iu7sFDgLr+bm=Nvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/17/26 09:06, Yuzuki Ishiyama wrote:
> I think it would be clearer to document the other string functions as
> well. What do you think, Mykyta? If you'd like, I can take care of it
> after I'm done with this patch.
>
> Yuzuki
Viktor is right, probably

-E2BIG - One of strings is too large

is clear enough.
>
> 2026年1月17日(土) 1:03 Viktor Malik <vmalik@redhat.com>:
>> On 1/16/26 13:28, Mykyta Yatsenko wrote:
>>> On 1/15/26 17:37, Yuzuki Ishiyama wrote:
>>>> bpf_strncasecmp() function performs same like bpf_strcasecmp() except
>>>> limiting the comparison to a specific length.
>>>>
>>>> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
>>>> ---
>>>>    kernel/bpf/helpers.c | 31 ++++++++++++++++++++++++++++---
>>>>    1 file changed, 28 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>> index 9eaa4185e0a7..2b275eaa3cac 100644
>>>> --- a/kernel/bpf/helpers.c
>>>> +++ b/kernel/bpf/helpers.c
>>>> @@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
>>>>     * __get_kernel_nofault instead of plain dereference to make them safe.
>>>>     */
>>>>
>>>> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>>>> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>>>>    {
>>>>       char c1, c2;
>>>>       int i;
>>>> @@ -3416,6 +3416,9 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>>>>               return -ERANGE;
>>>>       }
>>>>
>>>> +    if (len == 0)
>>>> +            return 0;
>>>> +
>>>>       guard(pagefault)();
>>>>       for (i = 0; i < XATTR_SIZE_MAX; i++) {
>>>>               __get_kernel_nofault(&c1, s1, char, err_out);
>>>> @@ -3428,6 +3431,8 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>>>>                       return c1 < c2 ? -1 : 1;
>>>>               if (c1 == '\0')
>>>>                       return 0;
>>>> +            if (len < XATTR_SIZE_MAX && i == len - 1)
>>>> +                    return 0;
>>> Maybe rewrite this loop next way: u32 max_sz = min_t(u32,
>>> XATTR_SIZE_MAX, len); for (i=0; i < max_sz; i++) { ... } if (len <
>>> XATTR_SIZE_MAX) return 0; return -E2BIG; This way we eliminate that
>>> entire if statement from the loop body, which should be positive for
>>> performance.
>>>>               s1++;
>>>>               s2++;
>>>>       }
>>>> @@ -3451,7 +3456,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>>>>     */
>>>>    __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>>>>    {
>>>> -    return __bpf_strcasecmp(s1__ign, s2__ign, false);
>>>> +    return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
>>>>    }
>>>>
>>>>    /**
>>>> @@ -3469,7 +3474,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>>>>     */
>>>>    __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
>>>>    {
>>>> -    return __bpf_strcasecmp(s1__ign, s2__ign, true);
>>>> +    return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
>>>> +}
>>>> +
>>>> +/*
>>>> + * bpf_strncasecmp - Compare two length-limited strings, ignoring case
>>>> + * @s1__ign: One string
>>>> + * @s2__ign: Another string
>>>> + * @len: The maximum number of characters to compare
>>> Let's also add that len is limited by XATTR_SIZE_MAX
>> This applies for other string kfuncs, too, but we never mention it in
>> the docs comments. Does it make sense to have it just for one? Or should
>> we add it to the rest as well?
>>
>> Viktor
>>
>>>> +
>>>> + * Return:
>>>> + * * %0       - Strings are equal
>>>> + * * %-1      - @s1__ign is smaller
>>>> + * * %1       - @s2__ign is smaller
>>>> + * * %-EFAULT - Cannot read one of the strings
>>>> + * * %-E2BIG  - One of strings is too large
>>>> + * * %-ERANGE - One of strings is outside of kernel address space
>>>> + */
>>>> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
>>>> +{
>>>> +    return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
>>>>    }
>>>>
>>>>    /**
>>>> @@ -4521,6 +4545,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>>>    BTF_ID_FLAGS(func, __bpf_trap)
>>>>    BTF_ID_FLAGS(func, bpf_strcmp);
>>>>    BTF_ID_FLAGS(func, bpf_strcasecmp);
>>>> +BTF_ID_FLAGS(func, bpf_strncasecmp);
>>>>    BTF_ID_FLAGS(func, bpf_strchr);
>>>>    BTF_ID_FLAGS(func, bpf_strchrnul);
>>>>    BTF_ID_FLAGS(func, bpf_strnchr);
>>>


