Return-Path: <bpf+bounces-22826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4FA86A44E
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 01:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FA91C237C0
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 00:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E6536F;
	Wed, 28 Feb 2024 00:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+LUj4U3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82B363
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079153; cv=none; b=nVysI0vMlRjPNLrmUO2OMW1fPW2pfmtDt0v7N71bECKltRhkE3VoeJOX7jHjRH6HPs9qmlHreZ/ZBk2h+exuYCvf8E+YD2qBbUZAT9Y85EgnSLZl7yWKmyPGQdLrCSS8cAWEqoUdHkUtGaZvpARnOVJ8TQhgfbPNNlnumbCip38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079153; c=relaxed/simple;
	bh=n2vQIX9yymvU0JReyUvrY9Q42YTx4yV8eUdoz0/8axk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCt21tT7zplHu9HsHRpcgigpIQrZVqqlJ3jLQX2bMltoUj033ahu5w8iI4ThqqRlvTmIQfwQuA6hCyOkJhItU+ldx2nEwxcxgA0ImYDINeqjHCj3A+O4lzsUKsZFPdxwLU5nE8AAHo8v0OeLUrBslYWwobFC0aI7XU2jPVI4cf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+LUj4U3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso5067303276.0
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 16:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709079150; x=1709683950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNipfxdf6Beti5e0NWYo3Nte7whmeK9tsXF0yyNkul8=;
        b=R+LUj4U3gZiTvIqx+hGZUdnvEOQFKa5Kpi8d6hoODzC2+hSj/7+08dEd0+ZgVqBVKH
         ZMDWl9Uz4abZPtuTqwzWjF+25Hj0HMyBZMCWbzRYPSf7T1JpKPJg5ZQjc0oT9I868Ech
         aeNUEWPtrqmttevg6n+ABMwVo4pbfZAKpvZxRfz9WxkK5dzMZ4OWoXXchnB42h4cT2PU
         2yJbnfLHKTx0qb0+WlP5huvdmb3sFYtVwMtvQjc8E1BNjbjKcBU/SQsLY9VTQ82L9qsn
         gnD2zHmwlo5BnlmoSe7sOqWQmslxmW22VRQKvLEkO3L6R8SgJ5B2ZmKIvf7aUNDE6Et/
         X/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709079150; x=1709683950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNipfxdf6Beti5e0NWYo3Nte7whmeK9tsXF0yyNkul8=;
        b=lUV0IZhfLDRPmJEz9ozbQ8qPqqrcAzT0ZiDU+l/TxinMLFtBw9ynnAI4XJm0P1pr/x
         dgz0Lc7XDuY5HrUZX7d8E1aB16+wXFa94pWFxiIQPp75AsaLQQUKjTUba7aKv6usmy/i
         u6ywph/IMlRm+kapa51mDRANAYxgvmsGP+Ujt7lD4uFRUdp4rsChHZSOhzQeaa2YdsY+
         aBiRKtHrBqVMYo7UdNlGZbJ1fmkQmPdHbJIZW1U36aW3iIYecULO7uyZFmZ9NuXn0Her
         QPjRuCbWxs+tU1B06PsqD266hynqCp59Ub9j3noMo3tA35614CG/2p6H8g05GUkPEogg
         HElg==
X-Forwarded-Encrypted: i=1; AJvYcCVtU3CJ9DtxEM8WaEE4HBcoE6cnFtLv9VuEMjRpTXIw7T9NzYBjfyS7EwxbpInWEmyXSuXv3o+xlyvbKm6sciwiniOM
X-Gm-Message-State: AOJu0Yy4LFbw1HoG4I6pe6r2V/F4oYZ3i1VItSLcm0FeiW5eMHnhWxuH
	8hcyXy92IEs311AwWpp6/nwB63wwIyOado4bNLK1YjdPyJcXILar
X-Google-Smtp-Source: AGHT+IHdL8iSwAuDBXsCdbFVusJl2K1T9vv7bbEynvF/QIJCb+jeSwj6hL2hOA/kXbzq9m7biUJyDg==
X-Received: by 2002:a5b:881:0:b0:dc7:4b0a:589 with SMTP id e1-20020a5b0881000000b00dc74b0a0589mr1019036ybq.55.1709079150251;
        Tue, 27 Feb 2024 16:12:30 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:76a2:1c3:c564:933e? ([2600:1700:6cf8:1240:76a2:1c3:c564:933e])
        by smtp.gmail.com with ESMTPSA id cf32-20020a056902182000b00dcdb0f80b69sm1645231ybb.48.2024.02.27.16.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 16:12:29 -0800 (PST)
Message-ID: <3d784a4f-7d90-442e-8c4a-fb0f40134e35@gmail.com>
Date: Tue, 27 Feb 2024 16:12:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-8-eddyz87@gmail.com>
 <ec9d8997-f5a2-44b6-9bc4-2caaf19df8a9@gmail.com>
 <c9395bfd3cbd27ec5280d2e55abc6a6186fc663a.camel@gmail.com>
 <7adcc642-4dec-425a-b198-14bbc0416f21@gmail.com>
 <f6b6bf33c1fa379fcaba9ceaeb841a275cdbdc68.camel@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f6b6bf33c1fa379fcaba9ceaeb841a275cdbdc68.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 15:30, Eduard Zingerman wrote:
> On Tue, 2024-02-27 at 15:16 -0800, Kui-Feng Lee wrote:
> [...]
> 
>>> So, it appears that with shadow types users would have more or less
>>> convenient way to disable / enable related BPF programs
>>> (the references to programs are available, but reference counting
>>>    would have to be implemented by user using some additional data
>>>    structure, if needed).
>>>
>>> I don't see a way to reconcile shadow types with this autoload/autocreate toggling
>>> => my last two patches would have to be dropped.
>>
>> How about to update autoload according to the value of autocreate of
>> maps before loading the programs? For example, update autoload in
>> bpf_map__init_kern_struct_ops()?
> 
> This can be done, but it would have to be a separate pass:
> first scanning all maps and setting up reference counters for programs,
> then scanning all programs and disabling those unused.
> I can do that in v2, thank you for the suggestion.
> 

It only has to scan once with an additional flag.
The value of the autoload of a prog should be
true if its autoload_user_set is false and autocreate of any one of
struct_ops maps pointing to the prog is true.

Let's say the flag is autoload_autocreate.
In bpf_map__init_kern_struct_ops(), it has to check
prog->autoload_user_set, and do prog->autoload |= map->autocreate if
prog->autoload_user_set is false and autoload_autocreate is true. Do 
prog->autoload = map->autocreate if autoload_autocreate is false I think 
it is enough, right?

if (!prog->autoload_user_set) {
     if (!prog->autoload_autocreate)
         prog->autoload = map->autocreate;
     else
         prog->autoload |= map->autocreate;
     prog->autoload_autocreate = true;
}

