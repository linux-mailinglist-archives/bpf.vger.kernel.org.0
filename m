Return-Path: <bpf+bounces-69452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1480B96C0D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C143BBAE7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7872820C7;
	Tue, 23 Sep 2025 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="lE9XVShV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC62676DE
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643688; cv=none; b=tK0lw44Pd1SWQnpWy/QtyRhzM6buNEUdSn/EIFLqIyofbmF1s9cfJvK+Fv38RHrnxRly6EJTy6P5bEEtLIdDTqaz8eT7JwhZAbrO/HlqH6HAd/ByN3gfl35d5B4vuFE15HfLIj6Ku0troLQd5DZfUaCXXrODykDV192OQ37XuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643688; c=relaxed/simple;
	bh=p8/sU2tNQ6ZVFyaeHTs5DVYywGuz924qBYYmz835ZQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKITE4kDdCHsXAvYaCceeTJormX2kGmY6kq2BjEhFjaHsjgcfqCh8M3sgKp1gd050/+TivcephYetHCJhHro/VoWwr8t1Qs4IEOIrJBew5JUdEIamj55I1ibGf8nhQpR+VaT80Cx9hSHwAvqdxQeslyQ4X4j+y5o8dalWV813e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=lE9XVShV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f605f22easo433780b3a.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643686; x=1759248486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zu1L3h7cbarGsKN8oBuSeczv4OXYLgkrbzeyl4MK5lo=;
        b=lE9XVShVJseVEVwvKOOIYBgNMy2vEUM12dDSymQGJTyw2Er6CoAYIsUJHaYm4eIQKr
         X7Ns2G9kljeIYudUNKbM69TbhQ+92h5ntFU+u87QwpOcXyQHOIN11dHH13x3PHZkLPKq
         LS9gcKQNi3zPhlwWqrxKZNf1CyJTWG7/2hx/4E4DaMZILpNGRLeTlpfSz0sdyd2zclWR
         6fqfJpi/zmEWd7STP9mNGcjzPRjYzHjwEDHrI8t184GcqrYfFf1LWRu0YlyJ1dce4MNS
         sZ+1qW3TOFVVcUWeBI6xzztGscjSXXnLJp/NFJFCnjrEHIOi3tkT5q65gr1hv7zC03Ui
         bbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643686; x=1759248486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu1L3h7cbarGsKN8oBuSeczv4OXYLgkrbzeyl4MK5lo=;
        b=YWtVaOK1V2ejvXWC+nKAMhuECplUdH4eP4gpzw/b3ehlMiQ/KfKu0vdJqCChRIhr2g
         zEjgTk99WuzXOoaVfANozd2t7YtN06eyv8aNw5jxuvpEirojviJUbIJSE5zWEmRNgyly
         GbBfVkNXIipDFBkRiWQztfOuV/rXn2tBff+h4rgjLtACokgh7MHz0jurJcUCNgp8zQ13
         RIX3618JgX3h4Lt+CcEKYGdxUESqTXXsebirPBXibP2cO2YyfRHbuOxzGLHZr0H1TDTQ
         7cyAjR+plKfduxyjaknxzHi5KxlCs6yP08YiLhbF+dR8U7ehZ9aRjlZoinyQDmw0DT6l
         9fEg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1zIdTwQ4CzOGF7ZqrG365c1cBMpHvGWnC2ftWhZA725oCE49AN3q+acAyyNqmTi9HWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcPgM8a8/KrRFZ0mFAySSIyYGoOXCmA7nFWU/yaOpmAqQGtwf
	pFNC9ed1LzwXRKCcQEPt1eV+1faBpUCATyG/neZFpwLHHBCVLSXC8/NzXcMaCLo1aGU=
X-Gm-Gg: ASbGncv8b3laG/xumb51R+s1m9oambTLyHQFcB0Nuj0je6bfrXL2HnPjzDDZGnfAHUx
	zpYt/OLtDPZ/zG33KxD8aTcIm3MZnodORNiw19wN2XveNJV0Qb0cX0esjySVNQFOciMY0Q+DE+0
	z93W0vndxaUKkBe8Fy5tH7jL7y17lPhpNuZHXR9pFtAPM1wn3FxFnBCLcVpBlFvr1SB26nEx1zb
	w01ja1z+/addNLmtNQYSMU2C1zwXSNRy50i5ehe0IRxsiy4KvUREyq8k0EISGzb9D/iaOn1AwbY
	egnabSlQC3cdJhkGHwzZ7OvlA0TYlOyM0t1Iz4Kp98rK7MCxBC4UaToxgZ5Vcj62aALGo6KXeK+
	iuGlESW+Qo1DarlVVIBOhMney2YZ6OCynnxtAyvjVaTbUEoRv+r0yqwhZJwm8RU/A
X-Google-Smtp-Source: AGHT+IH8WL+N13QtR323irJ+BhiHiyPSqzdWQXcpIgZXUPY9M+dQxu5Dzl7g7Rct6z/RVkCp5rSebw==
X-Received: by 2002:a05:6a00:cc4:b0:771:ef50:346 with SMTP id d2e1a72fcca58-77f53a2c4ebmr3640447b3a.15.1758643686042;
        Tue, 23 Sep 2025 09:08:06 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1ef87dd8sm9608991b3a.75.2025.09.23.09.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:08:05 -0700 (PDT)
Message-ID: <d5933562-b6d7-472f-97a7-3d72da3ff51f@davidwei.uk>
Date: Tue, 23 Sep 2025 09:08:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/20] net, ynl: Add peer info to queue-get
 response
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-7-daniel@iogearbox.net>
 <20250922183254.5990893d@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922183254.5990893d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:32, Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:39 +0200 Daniel Borkmann wrote:
>> +    name: peer-info
>> +    attributes:
>> +      -
>> +        name: id
>> +        doc: Queue index of the netdevice to which the peer queue belongs.
>> +        type: u32
>> +      -
>> +        name: ifindex
>> +        doc: ifindex of the netdevice to which the peer queue belongs.
>> +        type: u32
> 
> Oh, we have an ifindex in the local netns. So the API is to bind a
> queue to one side of a netkit and then the other side of the netkit
> actually gets to use it? Should we not be "binding" to the device that
> is of interest rather than its peer?

We are binding from a netkit queue to a physical netdev queue of
interest.

Sorry, the terminology in this patchset is not consistent and confusing
clearly. Will address in v2.

