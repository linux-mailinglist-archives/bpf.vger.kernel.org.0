Return-Path: <bpf+bounces-75452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE907C85038
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F7B4E9213
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E11E28E00;
	Tue, 25 Nov 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhSvXsca"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB92AE77
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074818; cv=none; b=cNSEMg1+a/hOZ4T+bUhfeBY2qj23gbAt6g0y0xTX/NmonfGTG04k//T2mXxSpKJVc7BzAhNx5fGs4pJkIYL8k2k4akRq3KLaLe5p0SppXCMMQ8dNm8dJgJETJaan3C495X7HEJxsmBbatRyIgfEAZ7JxWmqBl37CBQ/9X2Kc5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074818; c=relaxed/simple;
	bh=bgV5yw7s+3MyA2i3oY/dwSW0/v9Wck/idd+mEop6rRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPeju9iiDJHaKyeVTqRAT/cF8g4YyeeXUGQG7mhx7VdHv8uqbGqWDlVAYM6Mn87ORbVc90xOnF3g/eyWzasb2FRKem3/m6+WwMLFKXZArB9cwNjvi2U7Eo5RcYfoJ3leqgP68N71VBpPrs94XCVH8QrxmfybYuFG8Fh2QkuuhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhSvXsca; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b31c610fcso4684516f8f.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764074815; x=1764679615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCCLhoUNC39eu/n58aVUYS3QhS0sN807HiT2blG5Gag=;
        b=OhSvXsca0fOuLKPK+vxdpYOtkE0EJFGgWQJp01u1i+hagzU3BfqK1KHu2U1duf9hOD
         9f6T/t2Zp90LTJxNLy1005pBxTQggafMaZcw0cXuKo/5miFXvskV0UVtU0u+dHHOCplC
         9UAfl5peWcqyVofYMi5Ws3mzbDDczXrhtyroDSIlQiQDQX352MHrZJQP5yYH3R933sMf
         YdrILV1mIcnBOdG96R1LNqYHW5W5aDokgLOy9snWTZhmfcDUVWaDVk03jDfcnGLs/zkv
         E87ug8F5DAATIdeKo/f+xDwdLEZaFl/iNFDdcArqi8w3q/Kk8PgCUaJH/wY5CApUsEt6
         sMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764074815; x=1764679615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCCLhoUNC39eu/n58aVUYS3QhS0sN807HiT2blG5Gag=;
        b=Be3CvKdUaFuv1Jz2QGTP1K81h0bWuF8jDJX4oNoo+ia4BNpxezQqBYOwcvQTyXjUlo
         iaIUtksOVF0upw2yKMSFVa3Ebm/bIAjSfTYlcpIkC+z90I/FwggijVpewmKz7lq1usxr
         G5HMH93k/+ATmE6NNw81ia9TpTO5AAHXsod1O9dpjXbek0hOHnyibZ8UZacWyJm7mqOr
         PvnOwbsECxPTH8QA+OY2qBdVnMfOW4+Bq5hbEPh9aoGhrbSrjDX6ohA3LDVX4jHuTJsD
         jGaYH4jhtKHbgJ7f1wmqunh0z4xDuPq0ZPSmBQc2oJODRj2b8mM1cjpBd7ucQ3NXf5XE
         2f3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7jYunnPIAkqhfZd49cCjKW3MUe6abTTLXw4kIyWwTVbeIVC43qWnC+ICTRRUR6WtpVvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzELuygkfskOiFqPpyr84p48pV+ofDNbul+PB4lvmWQJCYeIaHF
	zfdJEe4nbqBsEFnn1jbaeRFHu+Icd4jcTpNXdkzsrQN+VWHBJiRWShOJ
X-Gm-Gg: ASbGnct4OcdfIAO6O8YQa6HH8KuN3pL8A1E/Sy9A3w25UhJfRbs8CTEjs3tZwuwVnT7
	fPKb0M9pDvi+MzRz6D1lbJvZNEHDoAdQGU0E3gOqAV1ntOG00NoqUFFvn6i4nipVxaCzIEZYrG3
	0m8Z2/7w7SWWwcnr4B9K6+dJZgJnzFQ10R6zgjUTV4aTFofFM2r2RJfIN2Nb3s+x04joDA9fpZJ
	R6IHw1JxNxlnqDjE5DqNsZrnvqSBImrrCYcJ18JDXNcSs1bI84Kz1DT3F+Td498DQhJRsRPfnmd
	A6gAw7tBujytki4jhTRCt32c5z9CHQO9hlGzDjroM3JSAmoPxHC+2xR83U1I2UqXjzWIWiDUZlm
	p24A2bE2Oklqdo5AKdBF/mRglQqJ4wWRia24UGnjwJN663C2MsAvMALRWgjysZFohnErFPMh6zb
	uqc/uLTOJsuppTA28Y1r0HkmNx30AWdMuA8pnMDvwJJeFRFy0zfl1iNDqGIwg2AQ==
X-Google-Smtp-Source: AGHT+IH0sHJ8VIJg/RX0pA9kl5euwpPhRAtTw97zF5G+4fN3Yr3V95yt7IPXdy2ULmxCS1GBFMi/nQ==
X-Received: by 2002:a5d:64c5:0:b0:3f2:b077:94bc with SMTP id ffacd0b85a97d-42e0f1fc074mr2665735f8f.4.1764074814632;
        Tue, 25 Nov 2025 04:46:54 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm34668235f8f.12.2025.11.25.04.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 04:46:54 -0800 (PST)
Message-ID: <58126161-3451-414a-9ee4-83209bcba8fa@gmail.com>
Date: Tue, 25 Nov 2025 12:46:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] io_uring/bpf: implement struct_ops registration
To: Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
References: <cover.1763031077.git.asml.silence@gmail.com>
 <cce6ee02362fe62aefab81de6ec0d26f43c6c22d.1763031077.git.asml.silence@gmail.com>
 <aSPUtMqilzaPui4f@fedora> <015ee1ee-e0a4-491f-833f-9cef8c5349cc@gmail.com>
 <aSRrundGeeIpaKmd@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aSRrundGeeIpaKmd@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 14:29, Ming Lei wrote:
> On Mon, Nov 24, 2025 at 01:12:29PM +0000, Pavel Begunkov wrote:
>> On 11/24/25 03:44, Ming Lei wrote:
>>> On Thu, Nov 13, 2025 at 11:59:44AM +0000, Pavel Begunkov wrote:
...
>>> I feel per-io-uring struct_ops is less useful, because it means the io_uring
>>> application has to be capable of loading/registering struct_ops prog, which
>>> often needs privilege.
>>
>> I gave it a thought before, there would need to be a way to pass a
>> program from one (e.g. privileged) task to another, e.g. by putting
>> it into a list on attachment from where it can be imported. That
>> can be extended, and I needed to start somewhere.
> 
> If any task can ask such privileged task to load bpf program for itself,
> BPF_UNPRIV_DEFAULT_OFF becomes `N` actually for bpf controlled io_uring.

That's not what I said. There are enough apps that can have a
privileged component but caps are not extended to e.g. IO
workers.

>>> For example of IO link use case you mentioned, why does the application need
>>> to get privilege for running IO link?
>>
>> Links are there to compare with existing features. It's more interesting
>> to allow arbitrary relations / result propagation between requests. Maybe
>> some common patterns can be generalised, but otherwise nothing can be
>> done with this without custom tailored bpf programs.
> 
> I know the motivation, which is one thing covered in my IORING_OP_BPF patch
> too.
-- 
Pavel Begunkov


