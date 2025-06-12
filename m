Return-Path: <bpf+bounces-60468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C585AD733B
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AE37AF3CB
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003225B692;
	Thu, 12 Jun 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eWKXF7PH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30A253932
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737250; cv=none; b=o5go4Uzbu7xyzYMUijlB5xitYaT9WgJNS1Dct8/P09Ez1BfhC0CIGRFiBw83qNdR+Lw6um2819hvGXIqp8I2K/LLg1nG83Uiu+uKoWOKSA3zQikxCWDIeptmbbzq/FOlu0ZVW7oHLuGFUfUTnF9AGRoQUP9urL17dkAnUXu5RPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737250; c=relaxed/simple;
	bh=ZlKxXddzvj0sXC2oFaswxrLnTGaZARGcaCxTzDGh+pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TppB9MSXZ87WdcPr7kUZxwP3THFQa5Dt0ZIO91y7SBBZQ6MRvjD4vbUDH50FrdlFZVbwnlNz6wHMNPatqOWOi7b7cqzprCeJJWl3xzQaffZi/oD9oGX3jWP2HFAwUhwzMJHK11suIC89re5aREY/TzzOzJh3TVwxQHidsFxadbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eWKXF7PH; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86a052d7897so88064539f.0
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749737248; x=1750342048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7BaPEJdKodlX+vyBzolZJORQM5uM4U2VT2SEvpE3y0=;
        b=eWKXF7PHthlvSUHo2L0mT7TZPZVHmB8dQfitUDKzHVJJVL2i9WgDAKvnaUTC5auDFW
         +tD43WlkaLI/aacQwM+1hiBXVhdtJ9ZU6aPvvxB8R0/DEgyx0nhgN5b6pjBDaf9yq/BT
         UeA/Erknw1tQqGAFXE6uc44jhhcNKjSWQIultjeHa7CFqpjFW1/ZD11+Z068w1iYEAHe
         0NylkR/LY4DTOQXB1QCW9xdHmUlgFRuw53Edz1ZjpEQTfRwfPfaWTUjs1YygN0wfwv/S
         uATBxdizd02kWSCdiQt0ZdKfspQd6d2XoVUj0APzVfphlueoYsmyC4Sp/rvkvSqo+sNo
         RTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749737248; x=1750342048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7BaPEJdKodlX+vyBzolZJORQM5uM4U2VT2SEvpE3y0=;
        b=SW9M4N9N5PHTVijGOlN5Kws4qqGtq/ErXUkIMjiUDilHTOfFkS83LnoGaD55tzvkMT
         meacOZ53+kAdXHq2H39M6blXuiH5KUdcIc9K7cFtIVzDjNr0UQGxbLwLMj+55UTOWZis
         5jIWbMda3nUWrdSn1YKUfAbXZN8ML4Hxnqct/w2n6BtTzBl+O+RivoDgeN6/FCWWOD3/
         E18uF5ghlhKJhR4h+okO8Qx6NktQf9/VqS/7JVZW9KqiM1AKAH2wn2Yfeiw3WyuktvAA
         R6GM9y/o9Eq9ilnoGbhsLGpIeGG0LBJZ0IeuDSH7TbEjAdvLYc5pJ2Ei41BWImo0+h7P
         algg==
X-Forwarded-Encrypted: i=1; AJvYcCWRefkbnmZ22/Yir8Vn9PqvbBL/jJ00ut1GdWJF9AuNyaqb1IgAxwr44HbMqha5KiRwDrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJ1AE+faSGYZgbYipZet3cogicITGUaEuxxKUxMxGj6xFRsjp
	h2zE9GspW83TSmX4/3nNuzUcZw7gihriW5aZJfPAUQ175TaiSJp9yupydN/lwq5wBes=
X-Gm-Gg: ASbGncsrj2Vl2P93E14Q0PpHqY1n2Sim28Bc8QVoWp2a3y6mNO44D32mH2pHp4rGzIz
	FdL5rP2F4yqHa/vQKKEs/Uyj2Yr7kvxQR1pRM9D6qgz2oXSfGIlDbqNXUOeVXO1VfH7unzBaK4r
	ok1ozE5A1PprbmRLE3wLGM+lfFRPNgeDoVStF5facPyJ5kGl/7PNGe4BlkBAD2G+zbIg1SD+vDm
	/M9qKfR9XiCpo6Vyfd+jpCkmxF4brzHSJN/vEourwruxg1MxMFGYn2tT0r4rcCDQakUQ1ezjeYx
	UPOiyLMq9Z99JgoJrCozou55wzRzBqakYxg+QPWx9txYHYAWZ1qt7S8psQw=
X-Google-Smtp-Source: AGHT+IEWCCCjDjSoMklKVcYCB9WmouD1OwKf8Ba8LILdXB0kk8qnSuDBdbKmmY1TIsfRF6uiFQot2Q==
X-Received: by 2002:a05:6602:480a:b0:875:95b6:4666 with SMTP id ca18e2360f4ac-875bc3ce053mr876867639f.1.1749737248018;
        Thu, 12 Jun 2025 07:07:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875c7c39bf7sm36016539f.0.2025.06.12.07.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 07:07:27 -0700 (PDT)
Message-ID: <bf35d09b-e259-46b0-88d5-e950d9ced964@kernel.dk>
Date: Thu, 12 Jun 2025 08:07:26 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 4/5] io_uring/bpf: add handle events callback
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1749214572.git.asml.silence@gmail.com>
 <1c8fcadfb605269011618e285a4d9e066542dba2.1749214572.git.asml.silence@gmail.com>
 <CAADnVQKOmYmFZwMZJmtAc5v9v1gBJqO-FyGeBZDZe1tT5qPKWA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAADnVQKOmYmFZwMZJmtAc5v9v1gBJqO-FyGeBZDZe1tT5qPKWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 8:28 PM, Alexei Starovoitov wrote:
> On Fri, Jun 6, 2025 at 6:58?AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> +static inline int io_run_bpf(struct io_ring_ctx *ctx, struct iou_loop_state *state)
>> +{
>> +       scoped_guard(mutex, &ctx->uring_lock) {
>> +               if (!ctx->bpf_ops)
>> +                       return IOU_EVENTS_STOP;
>> +               return ctx->bpf_ops->handle_events(ctx, state);
>> +       }
>> +}
> 
> you're grabbing the mutex before calling bpf prog and doing
> it in a loop million times a second?
> Looks like massive overhead for program invocation.
> I'm surprised it's fast.

Grabbing a mutex is only expensive if it's contended, or obviously
if it's already held. Repeatedly grabbing it on submission where
submission is the only one expected to grab it (or off that path, at
least) means it should be very cheap.

-- 
Jens Axboe

