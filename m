Return-Path: <bpf+bounces-74924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C3AC68842
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1061F4ECC6B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A7314B64;
	Tue, 18 Nov 2025 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL22y+dI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F027F015
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457728; cv=none; b=g2yHNIYmBvVNlXOLUIwGYGbF03+vH0LajJQt5zGUlIxZONZWwthCQGatJnw5DlpA3SrXtDx5QVOYyzrSrnmlg5pB/TAXj6egtimMcEunC3DwKwOLjqUkNx129a4SZNWMuVNYlWOUCzrJO9ihdkM5g8300681un/SqyyEr60312s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457728; c=relaxed/simple;
	bh=BvOFQAdy9zjJKDHz1JA0HgglsdARQQ0adRPw9YpAmhM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=pIYai0ijhQuBIu275S6PwSmAyfliwhktHALwphq5kwZAUWquK5xj+UgieY9FE2EtezdaPRJC76gDSR3p2T4V9wR4+lx4+gG2b+L4Fls4NqrNTEps3VORgNK9M+qRcoHHOLqcSW4L27N2abAjZdn+FP/C9QGL/f0O3iSsuWfVAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL22y+dI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775ae77516so57817175e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763457725; x=1764062525; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9PnZqYfIzULXWhxWLD9KbztWyXV9i31fSKXw0TFJSM=;
        b=YL22y+dInl7eOtPzbxUXKZe7AD0/7yMfLv1enhSandlAu9DS+52Rcf0I+gph3X3969
         btDi23gZR7eaVscZXv5GX1BVQjR7qRlXJZ2scK6R5J1cod85upGSlLsUBJEnQ5SZ5QMk
         vqG960LUly0N/wapCcRxmmZAHUr+bqi5oC/vS6mP6XmQUrqmzfZv+UT3OzBSdC9kN2Y3
         YV0orcGlE+8+RffYrGayetvqgn6wGvi6ft1OwJsnr6nrxPEx19S3m5OhTVqVBbdMLBwI
         Blt450VZpRYUKOozoP3/ASNaA+zi/7TjPuhG3F13HBH2k47NrVKxsBZnz8ecAZtzeQJN
         Y1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763457725; x=1764062525;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n9PnZqYfIzULXWhxWLD9KbztWyXV9i31fSKXw0TFJSM=;
        b=Mzguev9w+H1FoqURXjQvKvEi/P880rfKljOU3ZHwCt9f0tPQQ6Z5QY4zxeqZVkLHU1
         J3Z9eLHwbUGOLPRGk0RJl4B/IBgXXwvD3K05lj41n61AC47ZUQnJ/QuQB8DEnGZu4V1J
         pG1sTtI6uDhzz2RKBem1HRh2XrNplSXa3FC2hif+gaLVYcFO81G/FowVcShZBKbRKv1m
         9e4Qlt8Wcs6KmgU8kBUUYPxscpy1XthOQnGHbNtEIlAOn5gjiLZip1wkWr/VAAkU7BDu
         JMw9E2UmE7l4ove+cJi5hh9mzWJ6q81QuoNa3qr7iwh2pRjoLhg2U1ATL44DGz0DGCk0
         bzLw==
X-Forwarded-Encrypted: i=1; AJvYcCU02MSiSeI7EOEpQcJIQCMOcxXFcME/PS2B3fGRii02IIj+DQ+UMAx6Bv6n31lHAXdIe0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYoowzhfGwvx+OOS7YEGQ+K985loNb8YPlkAKNRMIsIcPm4no
	Za62pfwejOxtWFEhbpLM6jBRFgVcMyyN+cEC2lCH/sCR69uMSx84Eqj2
X-Gm-Gg: ASbGncvjEAV42WG52bSqRRcrCio+R0NTqHiDoJi1D4VKS6Rp8xfJiqXaPWlHW6bWSIh
	7OTPC/Lrp1qpTRpmlgQy9/Q/47lswQm3LP+UXWHeA3iass3kX9mJ2K5/okplBGEWijfrbeCEFhr
	xmh7mYn0e/AolL9XeMsvav+6ixCQ4ETTBetDkyhtL5BfpN4IbzUekkE9WxvTeWKFC6N00aHrViK
	wgLiX9j2qz1l33jSiqbC8NAc9DQknOOC/kPr5185kM+AovZnyufGpHXTS3avCXWYiEmX8oUIuPi
	lfQofXkaTi90xikCf1dUqJ8ysOL1C9KVjvD1pyeQCX9hXv9fBqGQb98HkUoJGZeb7IWWMaxS4eA
	8KdgLUguwnwSgRbrasZ5SfZythazv9WpsuBGcBptl5hwgQnEzi3L89Yhg09Gq7UUroBZD5jC1Hx
	nZl2pRoEk25BXT6Qlgw8c/9a/e6wUrl4hP/1o8ArXDeXNN
X-Google-Smtp-Source: AGHT+IGSr/3N2cWhsJqtnk0wg9x/yA/uNhYB0j+Mk1qBcmIOENJcOu7NXZJlQH8vYKujOTqblYlcPw==
X-Received: by 2002:a05:600c:45d4:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-4778fe5dde3mr190114145e9.16.1763457724945;
        Tue, 18 Nov 2025 01:22:04 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:295b:6b4b:e3b5:a967])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e953e3sm346458935e9.14.2025.11.18.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:22:04 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  <netdev@vger.kernel.org>,  Simon
 Horman <horms@kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  <bpf@vger.kernel.org>,  Nimrod Oren
 <noren@nvidia.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option
 to show operation attributes
In-Reply-To: <20251117173503.3774c532@kernel.org>
Date: Tue, 18 Nov 2025 09:20:50 +0000
Message-ID: <m2y0o3lmrx.fsf@gmail.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-2-gal@nvidia.com>
	<20251117173503.3774c532@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Sun, 16 Nov 2025 21:28:43 +0200 Gal Pressman wrote:
>>
>> +    def print_attr_list(attr_names, attr_set):
>
> It nesting functions inside main() a common pattern for Python?
> Having a function declared in the middle of another function,
> does not seem optimal to me, but for some reason Claude loves
> to do that.

It's common for closure-like things and for scoping. Reviewing this
again, these add a lot of noise to main() and would be better separated
out.

To be fair, I started it with `def output(msg)` but I'd argue it is a
closure-like scoped helper thing :-)

>> +        """Print a list of attributes with their types and documentation."""
>> +        for attr_name in attr_names:
>> +            if attr_name in attr_set.attrs:
>> +                attr = attr_set.attrs[attr_name]
>> +                attr_info = f'  - {attr_name}: {attr.type}'
>> +                if 'enum' in attr.yaml:
>> +                    attr_info += f" (enum: {attr.yaml['enum']})"
>> +                if attr.yaml.get('doc'):
>> +                    doc_text = textwrap.indent(attr.yaml['doc'], '    ')
>> +                    attr_info += f"\n{doc_text}"
>> +                print(attr_info)
>> +            else:
>> +                print(f'  - {attr_name}')
>> +

