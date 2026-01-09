Return-Path: <bpf+bounces-78286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A6D07FC7
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 09:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E569304C2A3
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE5352F9E;
	Fri,  9 Jan 2026 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b62prC1p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="on/i7mri"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D1352C4D
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948745; cv=none; b=SCciQnE5k/Zg0xTIUEJzrWUvS8y1Imk50fmUrlh8HA5133nYfLwGuwv9uR4jGX4nsQsXaNKerVpI6nemVDq4G0u1+Pz8CWlWizXyvFZ+d+YGKEcln5ZK8iFkLHCZ917ADPsr6vsQv6DkKfX62T9jQjAWT/o8MQ9TSg1Kiil8+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948745; c=relaxed/simple;
	bh=E3NMqM+A8CEVRBGBT/M+cmeErAmFmkV5CGQbz1hlnlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlOfp8Yc7KkmfeHJkl3Ob6lTbRG0SFAO82ZHz5ZN4e4vejnlghVz6P+11HMNf9QdnVEgxo0UU67Lc5kScjmtB6oR4yC5RX1adcpSeGzgh9UDwIlliUahycSRD7CwxgtI9u0MvYpN7/Q/HGjopSWHsQkqY9zKWJPxiGE/TkZgJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b62prC1p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=on/i7mri; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767948738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qd3TxPrGEwbS4GVg26E8iOv4W5rh/N/xdaEX+6CIF7k=;
	b=b62prC1peqyEIzxPNzSc3AOQublxyM6ZUzfBD+7VyNtoBC4KCmS09NX1kXMRV7N9BpmOrj
	LjBBWYBbVZTR7bHCtXxYRuybM/902ErYLrpsMpoFqOfeQ+IMRJ7sN7gG/NAkNRMxnO7Vc2
	d18algdYF+6UhWrSJo2S2nmGIyMiiII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644--MQI-ARjPT6n_4lyk9QX-A-1; Fri, 09 Jan 2026 03:52:16 -0500
X-MC-Unique: -MQI-ARjPT6n_4lyk9QX-A-1
X-Mimecast-MFC-AGG-ID: -MQI-ARjPT6n_4lyk9QX-A_1767948735
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso27405305e9.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767948735; x=1768553535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qd3TxPrGEwbS4GVg26E8iOv4W5rh/N/xdaEX+6CIF7k=;
        b=on/i7mriqFGTWZYVvAc0CbJ+AJCpYNvEpDYWPKqMHf6E+JfLX9Zn2X2Dv9xm+6ogoL
         u2aRDzNbOVnnr2NvkAmwiCT547u1qgSdAmBo+3n6z8VsDyuh3LOdlW9TN2zHN0dp78FU
         cK316FDu6EBtIDkiO+abtBB6ePZc2yCG+bdD78+V206MV5nkZFa7rhBK8GUat36aopxr
         Jqi0huRQwX9XZ3Ylosl4CKjLpDwK1URIEap0RmtGMBU0iDEzWhg6E7YcNh8clE2j+l0Y
         iSAUsatvaJS87FLez3LCS3C/vme+SfjOKL6IKa2c1W5mzKxJtvcebzpCYsy1gAbNoM44
         +pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767948735; x=1768553535;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd3TxPrGEwbS4GVg26E8iOv4W5rh/N/xdaEX+6CIF7k=;
        b=BvHlpraPZG9hpnUUgTBho+ghiJ47C2i/bDurTlHk4lxvukx5Rz6zPl0dgDak8mEe0F
         TiSZ0kmnUicuZ/hJU44NXlGhy9pX/lJDyinwF6V4ufSfKgeu79oAkv0lVgBSDXmWk6TB
         4Z9hvCIdWfM2acArhSII1fJnhqEpXQLTGRIqqmRcIq16Y9HG5iLsAxsemurAGqGf+88E
         uOLYpKkSMvnqB0WIT+5m9T4vZj9pvjlzr1fBaj48Azwqy1+KYkX348/vDEOnOSPzoetA
         nm+nF4K2baLoNFXzMBkpIK+iwDMRbsqDWMyW5ReJ0svHTyHu+KAOVMS2sjoSk5p+Ynyo
         PSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2FoYqMLZ4E/Zn4+9Vo3p853uC2+l7LIGm2fbjCoPV9xPaHblo73fxP8WZVbup7PQDtEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMMZCo+esPgNH1MDKCIKdUwgO8wAYfSVFMOMFm8JZzjfBcrhh
	BbT1mu4rspVGBPBuZmPpRymjM/KSU9iwI8U24C7TYySGmPpo5NGt6HGKyKv+LFRnZoTyhxLhCfM
	GknZvNa0EDQaLSHWt6NX86w9yN7cAP8bmEfLqQvF3oSJwFplTEXa7
X-Gm-Gg: AY/fxX63LaaKLOLJsXle/ZqzzPBSjIFkQZq4rxY46A+6lnNkS7P5PwbT0LYb6TwQmb1
	4a4DGMCsviaidCQptDj0ARCrOY8ez1KgGY43frepnu2xYnZ/Eowa06d+g6zVIM+jKaMTjhth2bC
	irwrW6aekErMFIoUPxrgrEi4Ey+leUdHCzL6XjRpAwNc6EUXh1+gSim7CEIqJBKERJVDmFB5ZY6
	qCikyuAJQxGY+1tNnHSD2YpA4JtumV4JUp8bCWgzqKADXrPLllAOSfSEL0alEuaRXJ2+MyEOX/l
	9qP34QuqUhm7Aky7EcKYgj51RVd1WOlxdZSXOTK4KFDTlBF8Uhmq9atThwYfihPRGaP87ejilGz
	uc6lubFY3OCywklFTq+TcJLbAppYvRgl0AjV4FbWbgmJI
X-Received: by 2002:a05:600c:4ed4:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47d84b40ae5mr105450795e9.26.1767948734942;
        Fri, 09 Jan 2026 00:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+OFAHyxfPesOUruCB2DRAXrjgnW+eYi4VghBgkUB+GFBY8GQZwQg5dZXLwXvSMhkSZcxTww==
X-Received: by 2002:a05:600c:4ed4:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47d84b40ae5mr105448925e9.26.1767948734236;
        Fri, 09 Jan 2026 00:52:14 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d871a1e11sm55516855e9.19.2026.01.09.00.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 00:52:13 -0800 (PST)
Message-ID: <1fd29f17-a0e9-4032-8349-a85c9659a5f2@redhat.com>
Date: Fri, 9 Jan 2026 09:52:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/4] Use correct destructor kfunc types
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20251126221724.897221-6-samitolvanen@google.com>
 <6482b711-4def-427a-a416-f59fe08e61d0@redhat.com>
 <CAADnVQJVEEcRy9C99sPuo-LYPf_7Tu3AwF6gYx5nrk700Y1Eww@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJVEEcRy9C99sPuo-LYPf_7Tu3AwF6gYx5nrk700Y1Eww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/5/26 17:16, Alexei Starovoitov wrote:
> On Mon, Jan 5, 2026 at 5:56 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 11/26/25 23:17, Sami Tolvanen wrote:
>>> Hi folks,
>>>
>>> While running BPF self-tests with CONFIG_CFI (Control Flow
>>> Integrity) enabled, I ran into a couple of failures in
>>> bpf_obj_free_fields() caused by type mismatches between the
>>> btf_dtor_kfunc_t function pointer type and the registered
>>> destructor functions.
>>>
>>> It looks like we can't change the argument type for these
>>> functions to match btf_dtor_kfunc_t because the verifier doesn't
>>> like void pointer arguments for functions used in BPF programs,
>>> so this series fixes the issue by adding stubs with correct types
>>> to use as destructors for each instance of this I found in the
>>> kernel tree.
>>>
>>> The last patch changes btf_check_dtor_kfuncs() to enforce the
>>> function type when CFI is enabled, so we don't end up registering
>>> destructors that panic the kernel.
>>
>> Hi,
>>
>> this seems to have slipped through the cracks so I'm bumping the thread.
>> It would be nice if we could merge this.
> 
> It did. Please rebase, resend.

@Sami, could you please rebase and resend?

Thanks!

> 


