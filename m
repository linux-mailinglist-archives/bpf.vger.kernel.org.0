Return-Path: <bpf+bounces-30517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7F38CE8F9
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057791C2011F
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492FF12E1F9;
	Fri, 24 May 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6yCtMAm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0112C464
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569940; cv=none; b=Rbf5QnByXVlQcOZo7f+xQzfO+CCGNcLqfVtkpv2dRGhFG8HIr0xFU2m/3OL3lGUrCzVzuGsZWxpCmt4EQKcV+CSxChYKK544eZo/lJgPk8vl5E4lLve/xGy/pIhF1bteiLsXZehKGW+Vq9QXCd+LoNu8LoBphAqqSf7F5KEuqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569940; c=relaxed/simple;
	bh=RJlQLpMFX7QVNsXnLXwRsAXhGD/7+bqqqPjf8F86LgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XthjL2ODr2hu++e4l7YpdIgUzQ/+7dFjwMH+OMTu8qlkdOGYOjN8vwQpAPXo5hNHTHUFyMctY6S2xDyalGBAH7G0L6t0Jr4COXoVN6/HH5N9X6SlwyCfaJyldxfn+MBHJ1qeTIG8OEcwV3jzJzAkZGaN2FNXK4xWl6vJksJ7JVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6yCtMAm; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-627f46fbe14so29635507b3.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716569938; x=1717174738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFahLVGUTFjN8XF5mVnHFpiiROwWXczh45yhnS4VtSE=;
        b=O6yCtMAmX1X/GugTkfznYt9RY/qTDB2xlUfVSEavt851ut4PgGeaooZumDJi7oeJwp
         1Rwrl16rCHmIvVT/tzESmmJvIda8bTFE3Yci3Q8dKmiUHUySOuO0JHAJdUnGbyLQlDch
         5OhiY4Z983xItSsjAovroACmNcCchmNJV1AyNd+tfgqYgDv89RjhigHkQM7o1lpuVmtL
         kGRauhwXJ5X5QuoL48U5LRR42IG7mQZE5hidKekJ4Cm0AeEaES3GlG0r3bR4s06wKv2+
         yJdnT8I0jqjKW9hwYWQbLNi7Pt01tblzRaK1xI83Whh2977/+o450HjSRPJNjd/+p9Bc
         jO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716569938; x=1717174738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFahLVGUTFjN8XF5mVnHFpiiROwWXczh45yhnS4VtSE=;
        b=pIf9aXrcqd9VD4ODJSSgd66HaYZ1v0dPujZQOX0wftunto0VgjN9I9jtaDIevuYPcw
         Ri4jkH4bJkYPziAYIWlhEFfAO+75OdZ7e4twgL7mZ9jLMX4bTLNv7aFjxbB/9+Syjenw
         VXTPErTBGOXIlTDvBM1eDdvHDg081OcwBYFb+yAVgarK6PPiDKzSNYfLnm1tiu7K08rL
         DEuzpRYvWONr9g6Usvq3wnbZGWus1mDPQNDGdhvv3jQ0h+TWMoUgGRuMfoG7MBb7VMXd
         bfJBnaC2pByH/xvOpulsqxyi92CC6YI3vgEkGPyl0Qr5jIVIHiULFjEdvV2um2kVPRdW
         OarQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjNDFYZWFhE8goEVrL2IYDMhnxYrl6bB1dPT7atI9+ILSpK0wje7H7Hh/LIGO8TaQI45zuYQ4bR1o1SsvnCYUi6ou6
X-Gm-Message-State: AOJu0YynjkaA4+H7yHtImh64k6xNgnIxg4i75Rmgiw7IMDfCphKAxamt
	FBU4uRl3eiIU/I1/BF3q1grQjSJzEp8qFHQtu2jcXggAckB/DShu
X-Google-Smtp-Source: AGHT+IGFL22ByE+OAXJKZ1A5WpJHOwYY9SeQ5JgiHwqcIlIMbzR+v4m0VFhvKex1iopYU4ungC55xA==
X-Received: by 2002:a81:b625:0:b0:620:50e0:c38 with SMTP id 00721157ae682-62a08ddeb70mr27287857b3.24.1716569936925;
        Fri, 24 May 2024 09:58:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:115c:ba6e:a860:c6a9? ([2600:1700:6cf8:1240:115c:ba6e:a860:c6a9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a27d1dfsm3123457b3.27.2024.05.24.09.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 09:58:56 -0700 (PDT)
Message-ID: <3b04c9bf-d320-4094-8e64-8fe40d6479a9@gmail.com>
Date: Fri, 24 May 2024 09:58:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 8/8] bpftool: Fix pid_iter.bpf.c to comply
 with the change of bpf_link_fops.
To: Quentin Monnet <qmo@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240523230848.2022072-1-thinker.li@gmail.com>
 <20240523230848.2022072-9-thinker.li@gmail.com>
 <a69b12ef-4ff9-482a-8039-0f977ccaae2d@kernel.org>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a69b12ef-4ff9-482a-8039-0f977ccaae2d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/24/24 09:20, Quentin Monnet wrote:
> 2024-05-24 00:09 UTC+0100 ~ Kui-Feng Lee <thinker.li@gmail.com>
>> To support epoll, a new instance of file_operations, bpf_link_fops_poll,
>> has been added for links that support epoll. The pid_iter.bpf.c checks
>> f_ops for links and other BPF objects. The check should fail for struct_ops
>> links without this patch.
>>
>> Cc: Quentin Monnet <qmo@kernel.org>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The bpftool change looks OK to me, thanks!
> Although I wouldn't call it a "fix" (in the commit object).

Got it! I would love to change it.

> 
> Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you for the review.

