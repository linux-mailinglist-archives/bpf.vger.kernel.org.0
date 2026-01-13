Return-Path: <bpf+bounces-78671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFAD17301
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 09:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9BDA302DB23
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 08:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4433793B6;
	Tue, 13 Jan 2026 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxXOAStl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX+dW9y4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5CB378D92
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291548; cv=none; b=AVoe89CKu0GbxXGlRvloyrOf77h2Ki4Ee7Qohjf4yP/IHASfNETfErL1yGl/sJxYqk/zsm+LbAAsSXx9MYd74fhOd73mkE34Fgb6oVasKAChwqvLqeYCOdVmeMWU3Sxsk7TqkJgncSGHzuALdBW0chkzzfG/z69N0waJDuE2HdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291548; c=relaxed/simple;
	bh=fRi2unUu8V122miaigPUffi76To7mIA6Zcs7VF/ATNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=myp3xvAoYHY4wNKIfcnSAxGVqQ3jZF9j+2/K83RqtmlU3jBsIVnYy29v3uC5Shi8OZSGvHMLGUevwlCMxrQdf03cTWN2HMdLtXUi0i43Dsdx546ewYLm9vqm09wV4wg4TN3d38LZMZR/+XX4z9I+WqMpbeyOXQ15GeMzwmBHvvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxXOAStl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JX+dW9y4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768291544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ALfLzTfY43sCt6mgYccmhOKA3koQ8xwtXxNBjH2L2Q=;
	b=ZxXOAStlQgl4hqvwyvI67QU0pv20eJOkqfZ1OFspkWFO0zfWZcJQTxxEgSvNEOAb5ZkAbK
	NkU9aRgiXqHoyxwi+ZhGLHrJmQ/3hwelx1MvxUlqt4tyeRDpgF3N/mGQQvKAkNL3qIOcmI
	83Sf6i6D7oyDDPXwM7WWsKj+EildQuk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-SM4TX5-DO8uZhcIVP8H5Sg-1; Tue, 13 Jan 2026 03:05:43 -0500
X-MC-Unique: SM4TX5-DO8uZhcIVP8H5Sg-1
X-Mimecast-MFC-AGG-ID: SM4TX5-DO8uZhcIVP8H5Sg_1768291542
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d4029340aso74757535e9.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 00:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768291541; x=1768896341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ALfLzTfY43sCt6mgYccmhOKA3koQ8xwtXxNBjH2L2Q=;
        b=JX+dW9y4kWvNB6NgMyRhJuv9TCiDIxOcd/gzciKbn4/ePOptrpUXXgA889nfubcQz+
         /Kr1juvPcWdy8g8rmhZKJMXColyCPVKU+mU47sm6o/12AQ5lNbiW6Yxwho3UO0CkQt7p
         NTLcw9EwthZvfF4D9yNR1eFfeT3LrkGZEOR/5T7o+T6bHgIq5dcjgvK37GVJS1KMMVSt
         pwWXSlY1hxD2882+XV393Nd/CdzqEEuI4cvwtN5ZYuWh+TVlfJ8yD622rbUMiVeYnLSV
         sFz8umvuuwfKrCzRJhYpDcwxyEmz9m8xDfhYoRxe80Fwma/OWIgHAzJ93c6nCBOgvr+s
         bYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768291541; x=1768896341;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ALfLzTfY43sCt6mgYccmhOKA3koQ8xwtXxNBjH2L2Q=;
        b=tQoELJkFPahq0ih1IyPQcc/kA4C5vmI6q8RhELDdg8gxWjnYn4eNyUn0G/Owvc9Se1
         XsD+KNNXYcj9ePw2+jErFpm0BfLRS/AX/+HWzssbLXLpvmiNyXRwSYYy9TyDaeQcCGO3
         VJkaDyUv9JBLoK7xN85kXw5Ff/ehtBdC+yTXHBQJU+rf382Y0ANvnU6ZgSV8fG7TA/U2
         KHS4nDNhArSILH/5/InGyx85YzF8eTwyDeu4oq157emwfFO3j6ojkYseTwhw8942E3p+
         Z12vnOGIZiWnj8a2Yh4fHXqvq0fhjepHSk5CBjeJ45NjUZ2TIS4ENIg+buOFYsUMGMrE
         HnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXaGWAep2ptYdJjFaHzeu+AE7+ifD5N+egmRxtosx12aepvVJAkjUWmN8u+u/LKXkWomQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyllT60tjx8NuH2POi5iLZanXqr4Vmu4byAxWARWSDk1iZFztD4
	6CVPZzXTceVla7zM5WhzAvjpX1Iqfe97qzMRCxRRLbNJj/zdQUQlGNgGBK0bbuBN9oXexqcmr3Y
	zcgEcJ647caNDFZXSfZ99rvI+58SrFoNmelWbJNnBR7+iAKhqu9DHgnXYFAf2
X-Gm-Gg: AY/fxX4ZIexw4SN4mjjnyDazfx3cVyw70GQXOxwbNWgDPBHEnKVclPNHNHtY8CSpKGF
	9Kc6vtCRCRuVWqykNoVfAfUeqrJ31dtOukSwXmGSx0oQa0ateBv72EO40LAuG6N78tdbx7MvFxA
	XBB/2PGRPMYzYtMkvkQKsfgYRie3yTql8h7EZ4XTxw0vqbVDiLYzIaZ4sAhGiTmtvxY8JpPZYII
	Io4dI9xUeuF+diMfa6mFFpML06C/xfc8IOtneaiEdeaDm1M6uutw0ZjgwrxLBLoaTLmgxga/jOa
	MTtZJt0Xk9VAI/tETjKtxH7tTn4QK0HtqqHHxEU6Lac5IzCr3EpFFgSv6xzCbTQKO9l1ptuVmjZ
	2ayls0NDmlKoWG0emqUkuexAH+3dbOMynI0VBDD+dSM5O
X-Received: by 2002:a05:600c:1d0a:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47d84b17b55mr241998305e9.15.1768291541308;
        Tue, 13 Jan 2026 00:05:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvvRZbXii/iSdFOntvktXWamnXS4sM5hBDz1PLgrt1LtH0ZZ7KVTq0aL1TdkpX+pBKUL2EYw==
X-Received: by 2002:a05:600c:1d0a:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47d84b17b55mr241998015e9.15.1768291540942;
        Tue, 13 Jan 2026 00:05:40 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47eda0e59cesm9794715e9.8.2026.01.13.00.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:05:40 -0800 (PST)
Message-ID: <793831f1-a8ea-4e0b-a0e8-c86c30b1ab2f@redhat.com>
Date: Tue, 13 Jan 2026 09:05:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Usage of kfuncs in tracepoints
To: David <david@davidv.dev>, bpf@vger.kernel.org
References: <f5e6c1e4-f2f2-4982-a796-e3a49c522bbf@davidv.dev>
 <3735a372-1641-4a37-a7e2-54b7533caf83@oracle.com>
 <bb6a3ada-ddcf-417d-82c7-f86cde6ed4f7@davidv.dev>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
Cc: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <bb6a3ada-ddcf-417d-82c7-f86cde6ed4f7@davidv.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 20:08, David wrote:
> On 12/01/2026 19:03, Alan Maguire wrote:
> 
>> I think you need to add "__ksym __weak";" here i.e.
> 
> This change let me load the program, however, libbpf cannot find a 
> kernel image at
> /sys/kernel/btf/vmlinux, because /sys/kernel/btf is not populated on my 
> system.
> 
> My kernel _is_ built with CONFIG_DEBUG_INFO_BTF=y, is there something 
> else I need to do
>   to get this path populated?

Did you try rebuilding from scratch (with `make clean`) after enabling
CONFIG_DEBUG_INFO_BTF? If the sources were already built without debug
info, they will not be automatically rebuilt just by adding the config
option.

> 
> Because this path is missing, libbpf reports:
> 
> ```
> kernel BTF is missing at '/sys/kernel/btf/vmlinux', was 
> CONFIG_DEBUG_INFO_BTF enabled?
> ```
> 
> But I see from strace that it tries a few fallback paths.
> In the meantime, I copied my kernel into /boot/vmlinux-6.18.2 so libbpf 
> can find it, but
> now the loader says
> 
> ```
> calling kernel function is not supported without CONFIG_DEBUG_INFO_BTF
> ```

While libbpf may try other fallback paths to find BTF, using kfuncs
requires the kernel to find that kfunc in BTF and kernel will only use
the system BTF (the one from /sys/kernel/vmlinux/btf).

> Can I not use `bpf_strstr` on a tracepoint? To validate, I tried a 
> `raw_tp` but
> had the same result.

There shouldn't be any issue using bpf_strstr from tracepoints (or any
other program type).

Viktor


