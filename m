Return-Path: <bpf+bounces-61773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7043AEC085
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 22:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAB23BFD47
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9F61FF5E3;
	Fri, 27 Jun 2025 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5pYToYN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA715E8B
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054470; cv=none; b=el31tqXqklmZm9R/Crd2Ut37qumEkZC8OFC3x3qaFV3xVPg5zmkjOF+29cTyLpq+OUIlfnj9AjLPPtW+H55QuDwf6Qsi0+XezgTO80eyVziWt2kZ0hWZVBYmztxxtFrfpC4C3kPAENXJqzGHEvNWJOLsrLnigU0D1CMGUv0laXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054470; c=relaxed/simple;
	bh=IfxZ3Bwo1o2aGxDLFElkm5269449BZDWspyP/diuZfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8EeME3dX/SlLQbVv2qRTy2ls1vvBvAG/gTocwGoOyLsmc7eyKq8Fc5JAf+ZnBVwXbBUcF0l/sYVXykm2vdSHo7H/Fdn0HOC+Kbzlg00Ud3ePMOcNhvhEX+nfJjSptZ3Jmngw6tGgDTdpmTp2fNeyjbfkk8CwVvLoWmJ+XR/Tuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5pYToYN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a365a6804eso1498698f8f.3
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751054467; x=1751659267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHMABs4O+WoHScw4JygUW9hbl+I+3p+wYtR4AncWm1w=;
        b=J5pYToYNmo6Ulp5qcxr1UJ8GD/VzrHth0bKTbSF1DTz2C70FakLjHYP0C3j4Gy3DKv
         crvqxjMkgigLaL9Msg63P1IUIYLsrd49Wgt6SV7HR/sY0MhWDx6dzDroszDgxMRBBomQ
         NUfi0RZOWh2kQEG+fxoXMKTZPPZhODR5L3ugQ/J+FpwdcXak2ub2esnr3fw4wM9HNzzF
         LqumXD9P3iYsmxX83s3aITATE+IOzxnNXmC10WauoE5M12/IzxAid/ANv8MWizdhqAb0
         L8sNTRiIWU+w/nOqDrLva0Iu/HSE2NSYo9i1CL0YR02e+ebNsmyBmd4H+CNQpbh5PDS3
         jLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751054467; x=1751659267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHMABs4O+WoHScw4JygUW9hbl+I+3p+wYtR4AncWm1w=;
        b=Gh/Il7mrNBeYy6Z+Evkj7lKwvnXL6IM4NdcjVGyjuDIJoKO6+iVgayzYoI5mu3vQ6d
         T0OaeLg4XjV2hJhHk+O6rL3hXrY4pQGkMRX6VQ9HbBWajJO06tBJxoSdHsmj5CQooEB9
         tG4PIde1MaYChiKYJiKixsZYF2RNADXvtuIZr6e+vmYQs5Ynky3PwbF2R2B19eZrN3UT
         fMha9Gg3+rFkhCyLRaJ8QzzO5Yo0MSMWLoCd6U+dxuEctCToT9E3+7mpaMkajajzoNug
         Xsz13nEjT+RtvTOggJSHrdVosaACPtTTqLhoXKXnLiagr+vGN6okKlUmFtRTtKORRviC
         7cNw==
X-Forwarded-Encrypted: i=1; AJvYcCVYxB09QwM3H/DzsTIDRS2HZEUumzeFvb3RuYorVGZjZtWDB4fU6Ib8QaLE1mddxn/KNEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM450lWZbPcVHLnAgRdRz78tRVicIzis2TYTzluVz5jFHNXubO
	Nv+xha1GVgFi2OvhF76lDxJ3C7jFaVFtKdBPQ9a2Hzubv0moODgX/3ortj5MzQ==
X-Gm-Gg: ASbGncvU+2Z+zg/32+3Wmpxhg/G5BDgA0yv1dvSXN+523MiDf8VaDdMMUdVNDnxSgQX
	2vQwFnap7ZUHqKVOZCSPlXLetMyp0aHiLYisKc6kMkqI37tsLLrMf43rZy47w4dONTaVAUd3ioH
	l6AMqFJcobzq2Oe5NQ2itOd530MmJ1d8rNRZ1OZ/dxPUpQUKJPExewzuNNkd0oEZlOhjHOPWkoi
	nSoFXnja39/HQmGmstinbNhQSMZg2XR9QITOIOYiHz9eAnKsYK7vdTcnDcq9yOAgJEgRSjr8i6T
	Wm4oB6kWJUdkE5X78FWhgKY7LC5A0EzAdoQgXa1WszQ5Q9Fj2Tjs9LZKlxBJwmTJrPjgmtrM8IR
	UDAQ6pgJY4eCNrdcAjfHtIOpl6IoGJ5ISMdPKJSzskvOqy2Ewf2/q/10Z
X-Google-Smtp-Source: AGHT+IEbyQU2hc/Vez8JcdVWc8yPb8mxgE80cjX/MehptaqTiZO5BxkRfGsLdpJOTJRoQyn4yKbWjA==
X-Received: by 2002:adf:9dce:0:b0:3a4:fa6a:9189 with SMTP id ffacd0b85a97d-3a8ffbd4d24mr3840579f8f.31.1751054466942;
        Fri, 27 Jun 2025 13:01:06 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c5fasm91801785e9.8.2025.06.27.13.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 13:01:06 -0700 (PDT)
Message-ID: <f6de5879-0984-4de0-af6f-62f091bb0dd0@gmail.com>
Date: Fri, 27 Jun 2025 21:01:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: improve error messages in
 veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250627144342.686896-1-mykyta.yatsenko5@gmail.com>
 <c49fcfaf3b622b8e71e33a3928c6494f29aa486d.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <c49fcfaf3b622b8e71e33a3928c6494f29aa486d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/25 20:12, Eduard Zingerman wrote:
> On Fri, 2025-06-27 at 15:43 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Return error if preset parsing fails. Avoid proceeding with veristat run
>> if preset does not parse.
>> Before:
>> ```
>> ./veristat set_global_vars.bpf.o -G "arr[999999999999999999999] = 1"
>> Failed to parse value '999999999999999999999'
>> Processing 'set_global_vars.bpf.o'...
>> File                   Program           Verdict  Duration (us)  Insns  States  Program size  Jited size
>> ---------------------  ----------------  -------  -------------  -----  ------  ------------  ----------
>> set_global_vars.bpf.o  test_set_globals  success             27     64       0            82           0
>> ---------------------  ----------------  -------  -------------  -----  ------  ------------  ----------
>> Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.
>> ```
>> After:
>> ```
>> ./veristat set_global_vars.bpf.o -G "arr[999999999999999999999] = 1"
>> Failed to parse value '999999999999999999999'
>> Failed to parse global variable presets: arr[999999999999999999999] = 1
>> ```
>>
>> Improve error messages:
>>   * If preset struct member can't be found.
>>   * Array index out of bounds
>>
>> Extract rtrim function.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>> @@ -1955,6 +1967,8 @@ static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
>>   			break;
>>   		case FIELD_NAME:
>>   			err = adjust_var_secinfo_member(btf, base_type, 0, atom->name, sinfo);
>> +			if (err == -ESRCH)
>> +				fprintf(stderr, "Can't find '%s'\n", atom->name);
> Nit: adjust_var_secinfo_member() already reports a few errors,
>       maybe report this error there as well?
That was my first attempt, but adjust_var_secinfo_member is called 
recursively for anonymous embedded structures, so this particular error 
will be noisy, as it'll get triggered for every embedded structure. 
Placing error msg here makes sure it's printed just once and only in 
cases when member is not present anywhere.
>
>>   			prev_name = atom->name;
>>   			break;
>>   		default:


