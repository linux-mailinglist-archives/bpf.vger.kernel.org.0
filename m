Return-Path: <bpf+bounces-32957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ABF915A3F
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D552286442
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 23:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2041A2568;
	Mon, 24 Jun 2024 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="xViEqujr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3601A2553
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719270515; cv=none; b=HCnOvakJ6U/EIowTFGG0ah6zy8VjL0KLEDksdH+UzRZMdENGf+zsugWuz43NWO3VPlNM4W9bUXLhDa0vI/Jt1NQsb2hgpdPW4Uagj7TdtTQQn2Qi5UbW3BIRBHXy3LV1YetPsQXDo+BzNSfbDRVDy6hW105op/q5j1JMcU5CX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719270515; c=relaxed/simple;
	bh=dQATCdxrA96O+8ZgphugN/R17ylASjnAa3pSnrwWVHo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bJUVvcejkQh3Rvc8yHREBGPnm9obA+hS/olk7XbEHrmuJLjBhu44sVVq7Mmu99r7Dy3LS4qkoM+cMe2hVx8sIyBQUFF3M5I8PKANvTJA14ZxY51RcfYoGoHPI3iYXmaKaeuCH9wV6rChvagnVX35tayns/erhg6ZumgFRUXChBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=xViEqujr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6fbe639a76so777447166b.1
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719270512; x=1719875312; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vXm6QRkb0yr07P0PtHmYlW8Uq78lbg7t+K4Kf09s4M=;
        b=xViEqujrks14GxH7PBb7wfvHaCgDGz5CmcSGDF4yuOYA67T8hbvV0iU302p7DLNRob
         RbJq0RP4ztNI9F20vexQZkCQmwX86gBwLm8wdAU9Y4MVSVC4FP8MkWnbXDrTRGZv9lER
         +QISQRrjSpOqiGng8kA3tL+K27eoTEpzB3XOFs1pC8tBP7ynTaMkkEY+lD8hAdq5cbBz
         tPqUb2z0kqa/nBbR6Fw+5iqDI/BtszQcjQUPqB6RyDbfSMrkN9zJZQ19IMoTgLqwFItA
         3dvDNqATgvCEYBF8ERsiyYKpNh/wZlDSySAR1m+2Rfhu6PnATOZYnG1w7BJh5/1oZ/CU
         3/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719270512; x=1719875312;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vXm6QRkb0yr07P0PtHmYlW8Uq78lbg7t+K4Kf09s4M=;
        b=HpY10W1Xs8bA5jDeANAY9tjpSDOZDVT5yOmCdk4GqX8xFPGbULUzYxgamaTzdNE4Mr
         oViMjyHNV64hVu675dbJ7fJLMG1ZnmFHcEEBTXZUz+XLzp3fxLqEzu1OmDm9HbEo2xOV
         YMV5F1/R+Bh9VFjlxu0Xsf5aJ4/uSHM6KAjauI9Mym0u8yNqz8JWMZZewUMVGOsgSUX7
         UquOSs1vCAaNC1HItL0mhzrUK7ZMqo4ILqW4knjnLXV0+flgOFR1zIuwZGHXCK13sXVm
         QrLEU/Jp+eDMUxhlnVl1mUgJ9MT6RcJVo5pRkfDp2tj89oJYxtMJoj1zPrwpaTlg43vM
         jV5w==
X-Forwarded-Encrypted: i=1; AJvYcCUp7jtGtT0y3GRp2n3s+00DlJoxra1VyJUZnYL+aalVd6iT5XbzU2HpxPXvTpHihlKdRefxNWFXbNXUrQPFhmhrNE4P
X-Gm-Message-State: AOJu0Yxy7m1B1OzyZH/AQELbeOa8wgQtKCLlAyHVFizkk4e+TYXG6o6P
	GHZCsxuPLGSmgatMNjYVXnHrnmY31Gz8+koDpqhbwNEaEZGPPPLEW6MjgnmaQ2M=
X-Google-Smtp-Source: AGHT+IFdsNqN/YFNCt3hSfJYwgXLMeE/bLv9dNIrwn7EImKp/cqYRBmS/BpwFMGkYG2d9mpEfSBWKg==
X-Received: by 2002:a17:907:6b86:b0:a6e:f869:d718 with SMTP id a640c23a62f3a-a702760bfc3mr525301866b.21.1719270512013;
        Mon, 24 Jun 2024 16:08:32 -0700 (PDT)
Received: from smtpclient.apple (tmo-087-202.customers.d1-online.com. [80.187.87.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf54923fsm452807266b.104.2024.06.24.16.08.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 16:08:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] bpf, btf: Make if test explicit to fix Coccinelle error
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <faf99c63015c6a5f619d85bd45405b91a3498bf9.camel@gmail.com>
Date: Mon, 24 Jun 2024 16:08:13 -0700
Cc: martin.lau@linux.dev,
 ast@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 song@kernel.org,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@fomichev.me,
 haoluo@google.com,
 jolsa@kernel.org,
 yonghong.song@linux.dev,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <99A36D9C-E171-452D-B0AB-AB0EE6C6410B@toblux.com>
References: <20240624195426.176827-2-thorsten.blum@toblux.com>
 <faf99c63015c6a5f619d85bd45405b91a3498bf9.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 24. Jun 2024, at 13:16, Eduard Zingerman <eddyz87@gmail.com> wrote:
> On Mon, 2024-06-24 at 21:54 +0200, Thorsten Blum wrote:
>> Explicitly test the iterator variable i > 0 to fix the following
>> Coccinelle/coccicheck error reported by itnull.cocci:
>> 
>> ERROR: iterator variable bound on line 4688 cannot be NULL
>> 
>> Compile-tested only.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> kernel/bpf/btf.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 821063660d9f..7720f8967814 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -4687,7 +4687,7 @@ static void btf_datasec_show(const struct btf *btf,
>>    __btf_name_by_offset(btf, t->name_off));
>> for_each_vsi(i, t, vsi) {
>> var = btf_type_by_id(btf, vsi->type);
>> - if (i)
>> + if (i > 0)
>> btf_show(show, ",");
>> btf_type_ops(var)->show(btf, var, vsi->type,
>> data + vsi->offset, bits_offset, show);
> 
> Could you please elaborate a bit?
> Here is for_each_vsi is defined:
> 
> #define for_each_vsi(i, datasec_type, member) \
> for (i = 0, member = btf_type_var_secinfo(datasec_type); \
>     i < btf_type_vlen(datasec_type); \
>     i++, member++)
> 
> Here it sets 'i' to zero for the first iteration.
> Why would the tool report that 'i' can't be zero?

Coccinelle thinks i can't be a NULL pointer (not the number zero). It's
essentially a false-positive warning, but since there are only 4 such
warnings under kernel/, I thought it would be worthwhile to remove some
of them by making the tests explicit.

