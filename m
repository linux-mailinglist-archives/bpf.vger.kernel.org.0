Return-Path: <bpf+bounces-75341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A372C80B15
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 14:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8089D345491
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22EA26F467;
	Mon, 24 Nov 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fao69M6k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E82EB86C
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989958; cv=none; b=WjTzfzoHmk5SdkeRtcffpGyM0jkl9xEhMuwhgSK2mUoyPYNdKgd3LPAlh06TxlfCn0Kc069Z69runud8k5iF0yPk4alk9BX7pQBvshHcMOuuq317ZmC1MlW91O3Qt66cgUd2q2kC7pec42ZIYUqY+/7N7WE17lXPQTlbSnAdzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989958; c=relaxed/simple;
	bh=LVOeGfX/hrncYVszLSmkoVX2bh+Fnz3uRx8/nohuEvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hv0WLxfs2IdnCOMAIdW+H5sEma8UowPw7PQV0XwrKmics+u5U5MXlftea2NuemiEU9Gj9YN/CGRrdanSKe9ktzuZPRvU7V5kdCGz+11TqGqz3FrBb6uwg4dbH/7jSx5XyWUlKGIyEV0K26Ok2Wopmat1qSSA2d6uWASkaBJuvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fao69M6k; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c4c65485so3499574f8f.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 05:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763989955; x=1764594755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/jAyvXkLX8H+nuUsYcPgHdNHZqUW0ZlRkXZiy2I490=;
        b=Fao69M6kOSKQRbPpkncvtBfJ76Bg/Yz2iNMbrijD5u/o8gE6CykzW/spmPBqf+3fIl
         WPKsCMUwWAPECxB9UyD08pLzZxvbEkVKvZqsFjvUkH1POYCYuaVwwpZxvsCQiQK6STj+
         gT78AMt981ObEoTw/SHxNnFRi3mtq1DYQ9FTzzHeiDk8ZQbCwVibhm1XRLf07XOfmwcV
         gbGlCOg5w/VM7JqwqqL4YX1b2hR7onzcLBQIC5QfDGulH/wSK1BqJ1OZjeObrDMVUyit
         7udmEf+wDEwsGowGGJm/ILk112294Amo64GEWdET5SfCPZcB5QKlLNCc8hmeMVIMQhAv
         i4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763989955; x=1764594755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/jAyvXkLX8H+nuUsYcPgHdNHZqUW0ZlRkXZiy2I490=;
        b=lkqnikOZCDtA47QY73nDfxdcoaZgcXhmh8DSug1HUU3FFzxvnb2OwaCM+Ff0Xoj6fZ
         XNhzfV7IkkIzE+HaF4P7ztwW+4G1XTy4A5xJFZ5SKMhGElPdeIuq0Nb6Bfkrki4Rf1B9
         wRNBus8Rzyoy2+580aZ8PhGSv05zNbBRFJUJ0FWpvWz4SkTSMAlInzROCzAjxvaO+W9+
         Vzgxo/ou1G2b8W3HDD+xuFTrbY6srCXjP6XlpjtchIkLARl+NxRXWitxFWPWyzjctHO5
         X08xrnGWqyLaFlJ88J6yyB11OscqXedijDB8W6Eb7Dpp+0fqvAFLItdV9YbJYVInTEKx
         WW8w==
X-Forwarded-Encrypted: i=1; AJvYcCXXjShq8cJzcpg1p/c9SfoLYhPtU9ykQM/D3gvlKl0/IfTa3qD2BCKO0/5Jd6xD/HZMWPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaz78U1rMrAHqc7q06MF0XFb1PfbWA26Vby7vW419ZbjYwXHgn
	gYLtN/+1TWENYkWJ6RM6B3ai6LhBa7onxv485UNF/FedCCI1OXQd9PLR
X-Gm-Gg: ASbGncuEX0GevPdAojuJeQmRc0nugA8LlC4XjkD9qoAv72F+r7NCvUCeyff5hAOeL0r
	/drliNXClph6uzFen1FR4E2np5Ke8nV0At9tySdTnMNUNYTyfQgVo498CbefSPpi4cwvV+DMviN
	zKKlyEsvrEhCDGPTpf5MJUXQZEuoPOu9eRVnuknn2frm2F4bbSpXcGHWYTsUT4pRwA3LrlEBioE
	4OVcg2fsUNoHINgT9aVYEZQp6chBAJbbCHEr6aU8gmamL+5/Uh3brh6YbIFJz+ZHmzjzEZcFTAA
	jX/QafRgq2r7n/jcmczV+FzLz9/7X+KVM46KD9nk3nCd53RySNdYUto/X1gSRr+5hSATZvZUG/4
	4YpGF7L8wuhABADYi6vcrFr+5bOdezI5Jd/8UnrMviGjVP2ASRpaBKSAt1P501exIeNFuhkw4uy
	oYuxIGvNiwRgdTFywsELpVzsix/FLYw7ZK1i0HrmNpH9VaztfZI241zv9kI1vehaT6TpRqZj8d
X-Google-Smtp-Source: AGHT+IFqiPToSF4N3e+veioRZSYuFb1cST6j6mPnAPjs/4jifICbawVLxJn6G5AnECO7vxqysuoJ7g==
X-Received: by 2002:a05:6000:290f:b0:429:8bfe:d842 with SMTP id ffacd0b85a97d-42cc1cd8f9fmr13219439f8f.4.1763989954744;
        Mon, 24 Nov 2025 05:12:34 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f49a7bsm27934717f8f.19.2025.11.24.05.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 05:12:34 -0800 (PST)
Message-ID: <015ee1ee-e0a4-491f-833f-9cef8c5349cc@gmail.com>
Date: Mon, 24 Nov 2025 13:12:29 +0000
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
 <aSPUtMqilzaPui4f@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aSPUtMqilzaPui4f@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 03:44, Ming Lei wrote:
> On Thu, Nov 13, 2025 at 11:59:44AM +0000, Pavel Begunkov wrote:
>> Add ring_fd to the struct_ops and implement [un]registration.
...
>> +static int io_install_bpf(struct io_ring_ctx *ctx, struct io_uring_ops *ops)
>> +{
>> +	if (ctx->bpf_ops)
>> +		return -EBUSY;
>> +	ops->priv = ctx;
>> +	ctx->bpf_ops = ops;
>> +	ctx->bpf_installed = 1;
>>   	return 0;
>>   }
>>   
>>   static int bpf_io_reg(void *kdata, struct bpf_link *link)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct io_uring_ops *ops = kdata;
>> +	struct io_ring_ctx *ctx;
>> +	struct file *file;
>> +	int ret = -EBUSY;
>> +
>> +	file = io_uring_register_get_file(ops->ring_fd, false);
>> +	if (IS_ERR(file))
>> +		return PTR_ERR(file);
>> +	ctx = file->private_data;
>> +
>> +	scoped_guard(mutex, &io_bpf_ctrl_mutex) {
>> +		guard(mutex)(&ctx->uring_lock);
>> +		ret = io_install_bpf(ctx, ops);
>> +	}
> 
> I feel per-io-uring struct_ops is less useful, because it means the io_uring
> application has to be capable of loading/registering struct_ops prog, which
> often needs privilege.

I gave it a thought before, there would need to be a way to pass a
program from one (e.g. privileged) task to another, e.g. by putting
it into a list on attachment from where it can be imported. That
can be extended, and I needed to start somewhere.

Furthermore, it might even be nice to have a library of common
programs, but it's early for that.

> For example of IO link use case you mentioned, why does the application need
> to get privilege for running IO link?

Links are there to compare with existing features. It's more interesting
to allow arbitrary relations / result propagation between requests. Maybe
some common patterns can be generalised, but otherwise nothing can be
done with this without custom tailored bpf programs.

-- 
Pavel Begunkov


