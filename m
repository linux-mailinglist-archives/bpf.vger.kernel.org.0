Return-Path: <bpf+bounces-29963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0148C8AC0
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76526285F5D
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C0313DBB2;
	Fri, 17 May 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B+IMB02s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872413DB9B
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966197; cv=none; b=ZJFau0TjG27x586x7Bo9pNSsvc2Zkzj5zuJieqRw2X6VGcJXDv17RQvKPdjZRc04KThR+LIit2oSl3Hoc75McmUcnEtQwsHlvc/Xr+/lQ4a/ds6Aop7QZ44OMF5jXXqc6CvLcWo1btbruOt3aDjsJvHQxoIPlW8Bzbl5385VD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966197; c=relaxed/simple;
	bh=GTRLCZPO5nYxEY6ZwQLaYR7Z7asMqP06IyUffGW8L1w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=AXJK3e98d31hHdIxn08hYqY3JmJ4XcPorIm490hEso1THuXX5TaUblAmliUHQwD5Os+Zn4COqiFEZ9IBnvOy6LRYDXj72mXGRC2STpAZhoXf6+CuRF5Y7GFVEXfzsMRIdbCH7oI8K9L1tS/l+XFj/BD3QfQueVV5RXsIV7uVWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=B+IMB02s; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ed96772f92so15513485ad.0
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1715966195; x=1716570995; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnExOqV+7uRXHFu/y7RSrNtAFBzF2jJxaME1kcwkiDw=;
        b=B+IMB02sqP4m/qkDUuERbyl+rD8ZTeHKuG/C1AN2pO/LxpXRkwQNk9ZlqBdXX0aQMA
         qyOfRDr0CucF2c9B1z1r/IsLp9oUMak/dui0lOoPX65fzM6ThPkWx02A5LM7/QglX3Yi
         U8ZzJ4Gq0kzt/p7WKqxV2PmSqVnaSLtdfmuyVjbYIfgzwvHgCMXlhnX0E7HPyYWX+d9O
         fUPXr3pN1k0SCknfg6T3Q5RGPgQJc8gb30BsfSKlVJ5MYuPDDDA2s8TDjratUqKYVtjD
         GM+EYOuo+ypqxE8Vzh7ZYSkOwZN5Epf11maeVvLxsgGgEju/rpx0HTJQ9z+PDahjT2KE
         xypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966195; x=1716570995;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnExOqV+7uRXHFu/y7RSrNtAFBzF2jJxaME1kcwkiDw=;
        b=j1vLreyUodFnruGkEtYY1aqltwk4+rkvz83RbnOS2A8Optf4IhV2NJSUKv47iZuzjX
         3l07KjyWvbYt/mUZ/hqnjF/xyVMqkJCd/CHb8lntKHVKEwlf0wxnXt9ZU1AOURxFYm0/
         mUufBF1GlG2WYaMxOwVf4UUw3+7Tjwu+1t4+EBekPqxhPwxe7MvovS/c2HpKPOpy+dDC
         aXhPVrfKsyquSLkSJAxdTVDWABdPxpMDP6BpwdpVSFPyumg4dvvNNBeCyWUEzCbZWQwf
         aVGKG+pENG6/fimZImYpRlwV24GauCoawmWVAbo0wTeWNXjI3EZTZpS0FutDi6rFmJZA
         Iqqw==
X-Forwarded-Encrypted: i=1; AJvYcCVyAQ7r2WVxN+zeku2DqPEfRB4eeILAHSTaKh8fgTEXeGjswR+bzKvio+G/G5zf5lU1EVix554l9D4tNmG5zk+nScI+
X-Gm-Message-State: AOJu0YzdNQ3St8hTKer66a8RCrgOtexA0zIPo/qMQmiWwkE3vYlCT3XK
	S47Oqi+r23RzDwp0e6cd6LcdLMkqw/goA2Pqps7OKAru/Ov5KGMwllFJ/g==
X-Google-Smtp-Source: AGHT+IGpjVtNLxkEf8zt1iFoHwywFhxbIYluUtfkvFJ0mJcM41xIhJ56sgOXLjB4ZF9DoAbBCT3Mpw==
X-Received: by 2002:a17:903:2404:b0:1e2:c8f9:4cd7 with SMTP id d9443c01a7336-1ef44059612mr184043395ad.64.1715966195176;
        Fri, 17 May 2024 10:16:35 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31420sm159465345ad.172.2024.05.17.10.16.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2024 10:16:34 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Dave Thaler'" <dthaler1968@googlemail.com>,
	<bpf@vger.kernel.org>
Cc: <bpf@ietf.org>
References: <20240517165855.4688-1-dthaler1968@gmail.com>
In-Reply-To: <20240517165855.4688-1-dthaler1968@gmail.com>
Subject: RE: [PATCH bpf-next] bpf, docs: Use RFC 2119 language for ISA requirements
Date: Fri, 17 May 2024 10:16:32 -0700
Message-ID: <05d601daa87d$f7a3daa0$e6eb8fe0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQMNxtSz5Xxdo4l4z3k03OfsZBHpa681bcTw

[...]
>  Platforms that support the BPF Type Format (BTF) support identifying  a
helper
> function by a BTF ID encoded in the 'imm' field, where the BTF ID
-identifies the
> helper name and type.
> +identifies the helper name and type.  Further documentation of BTF is
> +outside the scope of this document and is left for future work.

Perhaps we should informatively reference
https://www.kernel.org/doc/html/latest/bpf/btf.html for now?

Dave


