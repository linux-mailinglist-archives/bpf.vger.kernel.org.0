Return-Path: <bpf+bounces-51954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F7A3C354
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013D97A57F1
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4510B1F30DE;
	Wed, 19 Feb 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI1Ld7VO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582319AD8D;
	Wed, 19 Feb 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978150; cv=none; b=tUuXZPSuYF536DRqX6/v/9imv+cYIuDRNKPgRe2tlPlFdy+oJemd3Xa4t9QDPDP1b8IDfAk7Mf/cfPnC4xfT6dDhHrVe55ci1hlBuGC5X46ahAM2gjyrBey538GMaIXghx6WgTkB6i2C6wIt+9NS0iu0Ar4WA9jeNNk/v6HE024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978150; c=relaxed/simple;
	bh=5KRfKV5zScOeINpScp/M+94YFIqjnoMZpAMiuoxF37o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Axq/equuBETPTOwaj5/IYvc8fn25lJMh4c3gAV8TvPc5tKM8LF8Ap4S8EXsXuhjI9SynMpXwCDlPYr6MdnHoAEBlscNNG+cGfo2CLyhpFbTGBkZ0lmTIwd3IjjFnd9nS77lwp3hrAIdIvQ3hOP4ntz/MEa4d7S11SgQ0OHgTbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI1Ld7VO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c665ef4cso104024735ad.3;
        Wed, 19 Feb 2025 07:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739978148; x=1740582948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFZCvP+VypO5M1ubhfpGlg17yxQ00UK58exZlvQ9tsY=;
        b=kI1Ld7VODaahym+0kZL5VWIT0Ze439dBmO9+G1P7M+7Dr8qpUAPAZD9q0S2Y/W4yoA
         6n66u4EyTG3n1zwkCKUcJv48ICfQHEUzHNHMC/YiyvfrbNBYU3MIy7rrnJDSiztGi79S
         FFAg5m3fy9LHiP4Tw7bIZxu/49PD3hytixlLKd4aC3Pb8n8Dgf/4CC6ckqAmgNoFTX+E
         fFaWTkDPu7dfprre8GHz1NXGr2ykAbpxYCm9/7DbHDd18TxFvdALQTBDgBJSkgHM1M6a
         uJKZyitXzmw/D2O2WfXlBbA9TxpzwXqGOqZiyh652+m6Mh3T7YqGWYkS8ogo2XpBroVr
         saiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978148; x=1740582948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FFZCvP+VypO5M1ubhfpGlg17yxQ00UK58exZlvQ9tsY=;
        b=UJJ+m/b4vElEixq2Oo94ycrM9N4kJnZYShTLiKuY55UPIDg3OmpgT62C7tYdMF3bau
         2RNEH1xh01LZDe5GyBaQvhhJWk9WLQy3i7hLA2FgLlJL4SbJz4Kp65ZLtaOeCJS/Tdb0
         UiZNo3mClrR+UjHGwTu9sJwL82p0jMpMTfScZEzjMXjucqobUHoBaW/oRaiF7APioBK9
         AsYl9rapBZAl4hA4d1wkB1ZfOd+1cLWXJs/SpU2zuRb4QH7Hog+SzYIZCHroWD/Plysz
         xqRbq4IuRPlKekeOPNpwf3RADl112w8ovH66fjJ/Cx/MsBTBvXehr90bndBxAzhSp6J8
         25PA==
X-Forwarded-Encrypted: i=1; AJvYcCXMZ6HLwuNJ1WS5xXD+KLYXAuzZ0MVXiudpeFtz/NrneKEPop5nKgpFF2NFkfBAco49XrMTnQ+hr2014CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvXX9UmMEOCJJNDYEnKh8Mg+B+VAL2PPi+fzKNRVv1JIAcSFY
	gB4sp4W/4u2Eo2LefYOoB0x28xwmpuNVYRbXZu/RWiLVRnAgssGa
X-Gm-Gg: ASbGncvtQzCfsWf2uAyjhrWgMuouGiMM/UybEZQ0V/Y1QvYHZhjm/1/33lmBsUkQgNR
	R6EnhLuZYtCxcQcD+hZcrXWkMZdzx/+HIK3CURMB+HS3AvbDb/j7kFahP3CSQitX4NfVKAcm4CS
	H4X4kD4SbedfPiadOuuj53GlsMbp31dzo3sTKl2wy6bpG6ODKUHDPZRLH5TZ+eoRazmrw30XQ44
	xQ/Si68kJqDN1bnAUKTmnC31icFqzNXqudypU5H0R4q1rl6sTq29eZP9oommCzhfYqXRi8JX2pm
	fi0kNU8CWdZw5SY8gRGy6e/8iO43hIfTmA==
X-Google-Smtp-Source: AGHT+IHf97y6BsTdKWRbngclqAs1L8w/TnFdT5LmTK8LFNOkE7K59c60tIj5TJxDiKjZOxroe+9u/Q==
X-Received: by 2002:a17:902:e841:b0:21f:860:6d0d with SMTP id d9443c01a7336-22103efb488mr312692255ad.5.1739978148310;
        Wed, 19 Feb 2025 07:15:48 -0800 (PST)
Received: from [192.168.50.123] ([117.147.90.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5586075sm105347415ad.228.2025.02.19.07.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 07:15:47 -0800 (PST)
Message-ID: <b387d566-e460-4cae-bddb-67abe70d9f83@gmail.com>
Date: Wed, 19 Feb 2025 23:15:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: Wrap libbpf API direct err with libbpf_err
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, haoluo@google.com,
 jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214141717.26847-1-chen.dylane@gmail.com>
 <88f0c25cc981f958e46d51560fbf6db7136a3fa0.camel@gmail.com>
 <9df12336-ca00-4d45-a832-24203c334df7@gmail.com>
 <745bb51eb27835c93e7d4d6f1760c920417ad7f4.camel@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <745bb51eb27835c93e7d4d6f1760c920417ad7f4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/19 14:34, Eduard Zingerman 写道:
> On Wed, 2025-02-19 at 14:23 +0800, Tao Chen wrote:
>> 在 2025/2/19 10:08, Eduard Zingerman 写道:
>>> On Fri, 2025-02-14 at 22:17 +0800, Tao Chen wrote:
>>>> Just wrap the direct err with libbpf_err, keep consistency
>>>> with other APIs.
>>>>
>>>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>>>> ---
>>>
>>> While at it, I've noticed two more places that need libbpf_err() calls.
>>> Could you please check the following locations:
>>>
>>> bpf_map__set_value_size:
>>>     return -EOPNOTSUPP;       tools/lib/bpf/libbpf.c:10309
>>>     return err;               tools/lib/bpf/libbpf.c:10317
>>
>> Will change it. Thanks
>>
>>>
>>> ?
>>>
>>> Other than that, I agree with changes in this patch.
>>>
>>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>>>
>>> [...]
>>>
>>
>> I use a simple script, other places may also should be added:
> 
> Yeah, makes sense :)
> 
>>
>> 9727 line: return NUL; (API:libbpf_bpf_attach_type_str)
>> 9735 line: return NULL; (API: libbpf_bpf_link_type_str)
>> 9743 line: return NULL; (API: libbpf_bpf_map_type_str)
>> 9751 line: return NULL; (API: libbpf_bpf_prog_type_str)
>> 10151 line: return NULL; (API: bpf_map__name)
> 
> Sort of makes sense for these.
> Idk, I'm fine with and without changes to these functions.
> 

Well，then I'll still keep these and won't make any modifications.

>> 10458 line: return NULL; (API: bpf_object__prev_map)
> 
> This is not an error, I think.
> 
> [...]
> 


-- 
Best Regards
Tao Chen

