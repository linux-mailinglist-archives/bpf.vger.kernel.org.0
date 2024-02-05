Return-Path: <bpf+bounces-21254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63384A971
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 23:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5F51C27870
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC2482F5;
	Mon,  5 Feb 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBmqiAc0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C111EB3B
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172640; cv=none; b=LfJQC2AHBa2jXI1TO9ie7+IpYk1+s5ALbFOqi4S+UyJORjCUJBADzQBuDGtb0c22CqxJ7bsL5OcAbY+5hHhUvgVVMK2pKKO5j21RhPlEU4BenErP+H4D62nl1E0CSGG65HSRIqCvFqrk09JJHGMJbwRQVYXNb0d1ngDMD8rbZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172640; c=relaxed/simple;
	bh=+uHmsS+RPKbywZFad0ACJv5pI0NYf7/s2soScOPVINk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozFjayTjg3RKxKf7QPh2KyuRtYzC8Z/61rlgzXghwOWMfHbXNm/3joieKYyQkODvaswKxmlkzxpk3KSY4tRi9JkgL6JSjHJdyAqpJbc/0isNWTJLNd2Q62nFytp+htDAcvBVhCCCWLr9q81QOkSpjkIMP4zNnQ/ZuBPCMsm9ric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBmqiAc0; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42c0960382eso18608001cf.2
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 14:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707172637; x=1707777437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8K2wzrMq4QB/LUvIqeYhoIWkDLmifCF8VV2Z7r8u34=;
        b=UBmqiAc0jtF4z6q1MS4pQJHXSqYwUn8N5zNWyiqCcGISGNw4qwi6yU/2/r8NYgW4XQ
         Ap4PbDIESpVpb5dRf9SHS5uD4xPNmZ6Im8Tg9CwquGr1WF+YIZ6y3HivftwNIHKqcFyP
         +TWz4vZxPT3qrkAEp6Cnz8RwgqwH86FQKr2Kuj0nDNJ5+L/CUA+kX9OmHzkIGA6y3bE7
         J5mkCcS3ojzeVrF3D0BZhrMTlTjj+pw+VnJzE+0SteJA8FFL9/uiCkJjU3TFDQLvzDGi
         yWeITsKArph/vKOwh2RZvX6EQdC+Zih1NqxHbrR1gm8ITHG5SRgnuOLRL+TsWAqod+Je
         wMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172637; x=1707777437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8K2wzrMq4QB/LUvIqeYhoIWkDLmifCF8VV2Z7r8u34=;
        b=QDevkypshMIcLEh23qz/kKeSerWNbdkrZt8DjXHQyyWE9bbVPBu4WRCdhmGtCIdBLy
         h1dgsUF7G5f2tbwSSy6t521M4Fck3pKIY6p83GiBtgVivyvk6LI4J342Jr9g35XYlDsj
         32cZ6Tkt66JG8G3cmpunF9meJ0a0bQu4zUCtnx9rD7GLF2uV3tx4jNazm7uKLYXyp4JJ
         T/7tyPUPwAFGt9e/Ww33u9kq2Q22w8wtqpdfxhP90ThgKA1hWLWV0FvHcD9A3utjTuKr
         ao4lIZt7CKUXwvrTBpF5zE+ZY2TPIDNy6v9r2Tu3NcLEHhIj50eSbEzvMDCTE7T53iTZ
         dajg==
X-Gm-Message-State: AOJu0Yxb/zI+aRQDkHfSEr9lnb8yd5Sdlpa7whWSKjvQV8Zk9YVOGaKu
	OXlAPV2dbPIcChA8vdBjcdPwXXJhvuTHo5OfiUN2shGpux+txGpiD5N4YsAmmw==
X-Google-Smtp-Source: AGHT+IFTg3RyLVD+yJ/+5A+XB0U1TKn35KcD5n5pFreByjd81Us5ch4Pww7qfVUMtHX0ARCAXEoQkQ==
X-Received: by 2002:a05:622a:5cc:b0:42b:ff40:a6b0 with SMTP id d12-20020a05622a05cc00b0042bff40a6b0mr976688qtb.40.1707172637547;
        Mon, 05 Feb 2024 14:37:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGW1CmQgkC3ELkadtO8bqFTiAHu/ZnZlA+V7O1C5VaWjw64Kt4zI/5vtI72kjxgCx2lONZBiBADoob7fSfGvkFVAIlDFYlxpfIELEMKfpsOEutsALsGNpYvtI8eIm6vtE65UqaBAznmjipHFrDRH24YBg7hD9z1smjsQeeyVSZaBprQatsreGO4tp+eCmShqbAYh0KCgSdqzC3id3Dpr40dw==
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86798000000b00428346b88bfsm345487qtp.65.2024.02.05.14.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:37:17 -0800 (PST)
Message-ID: <bcdc3431-94dd-413b-b437-6592b4af70bc@google.com>
Date: Mon, 5 Feb 2024 17:37:15 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/2] Enable static subprog calls in spin lock
 critical sections
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,
 Tejun Heo <tj@kernel.org>
References: <20240204222349.938118-1-memxor@gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <20240204222349.938118-1-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/4/24 17:23, Kumar Kartikeya Dwivedi wrote:
> This set allows a BPF program to make a call to a static subprog within
> a bpf_spin_lock critical section. This problem has been hit in sched-ext
> and ghOSt [0] as well, and is mostly an annoyance which is worked around
> by inling the static subprog into the critical section.

thanks!  i look forward to deleting my various noinline hacks.  =)

