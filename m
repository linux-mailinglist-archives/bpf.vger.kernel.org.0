Return-Path: <bpf+bounces-28796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B733D8BE0B8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95711C23A22
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269831514E0;
	Tue,  7 May 2024 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S15W3mLN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439CA6F086
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080253; cv=none; b=QJtlRvKujkg1/tjqhyrxZ2klJgh73dxVfjV2mfud0YGcD0cA9JsEHgnoVRUI5fJQ5rWIHROpUAmSMxcSd67nLwWWf1cMHlLYx2ZJXGhweRva99LiosE0WnDpefJkOvTlX9Yxs432vHH6WtcNWvm58X13J5MXtJpZLQqHl92lHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080253; c=relaxed/simple;
	bh=8BsLDQyHOYjPEWq9Xe8+6NajCenEo8x7fNJ1RDGWa0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i9fMfAqVgHWe6wjnVJsXAFalDpksQ6bRssn8qkcRYGlj245mn/A36GU7dF3gp4YjWrh3pEU2K3W04uZfiN5nmqh2GciHlWqrJYdDl31tzIFuzeOZxry06LZEl6BJdKzMUdMVzrw/iZh9at/NlMCh5tlfc9nqd/ypgvPXqn7u8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S15W3mLN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso16811125e9.1
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715080250; x=1715685050; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgXBWDXfJTQZGqNXQdWwUSTlUSdvzCYZ+5Wh0gT04jk=;
        b=S15W3mLNSixF8l3hX/Z4a3bjrv1CRQpZsK6XafkIG5heK2gVwnI33YlkVohmWsA9/p
         pnGQfcRHQ7pjB0iX7xpOCpEllctZ2n+PG4nx5SFZrbG8MUHO57YOh046SP6Dff3pYJpO
         r2/BHudM0F+mfbxke1jJ1uHamSic0TlVZWmCniEqTF40tS8KktbCn5PAyScBMbqi06ZG
         olL/dS1vhNl57PvbonI7wJqMlFkcOTYFDwYuhHXiHJOMsu/Fr6PoRj4c4NNZg/X89vPj
         mNYAIrUAlLbhsllxJ4B62fKB1PYAVz4yFlPYUuPX/YHEroPCt3RvGnZMGK8SUjw8hz+Q
         a8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715080250; x=1715685050;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgXBWDXfJTQZGqNXQdWwUSTlUSdvzCYZ+5Wh0gT04jk=;
        b=tVMHSHHZN/e6TcoC9H060F/q3w0ytPsuGQr1R8VKQbH+jpzOY0FKn7Kx1xaUG39GrW
         SVwpJpKA7eiOu3xDk/dUpZwkF+ybPkXoFYPIJvx9V2supxMwSCKVkazmPw1535l3VOEd
         CE2sCO3CN9DtrUiKXPeUUBAM0MFxviOTqbDdivLpbY3Q1Jil8Dqq6YIfv4ffYzI2aX4M
         frQtueYRrPkPpOSSdSe9dUlcxviGKK95xswGdafljNLTPmrzHm5CU/RZJkmY0gSat4W/
         nRTVyUzcsL3P9BwY2v8LGx9OaN1IWFPFpATVzfk/T9qGNBeNPJYHbSqlaLcD55Ul8L+F
         VfCQ==
X-Gm-Message-State: AOJu0Yy7lVcDF6R+5HMbyQkBMVWgrHHc0eXLV7I01J74X48u7zt5ODVj
	HlI3inOfTHNE/BrbyGbkOtSPVc4AYlhyNBxwhkyR/4cz5FqfGP7t
X-Google-Smtp-Source: AGHT+IEwtgMl0/NVkwEnfN3O3PWG2LdmvVYjoR7fwdLi3OJ5Crc4Rim6huNtzJuuhnL9qdhcDKYhVg==
X-Received: by 2002:a05:600c:3b1b:b0:41b:4caa:554c with SMTP id m27-20020a05600c3b1b00b0041b4caa554cmr2249513wms.2.1715080250304;
        Tue, 07 May 2024 04:10:50 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id c14-20020adfe70e000000b0034de40673easm12798200wrm.74.2024.05.07.04.10.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2024 04:10:49 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2] s390/bpf: Emit a barrier for BPF_FETCH
 instructions
In-Reply-To: <20240507000557.12048-1-iii@linux.ibm.com>
References: <20240507000557.12048-1-iii@linux.ibm.com>
Date: Tue, 07 May 2024 11:10:47 +0000
Message-ID: <mb61p7cg527yg.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> BPF_ATOMIC_OP() macro documentation states that "BPF_ADD | BPF_FETCH"
> should be the same as atomic_fetch_add(), which is currently not the
> case on s390x: the serialization instruction "bcr 14,0" is missing.
> This applies to "and", "or" and "xor" variants too.
>
> s390x is allowed to reorder stores with subsequent fetches from
> different addresses, so code relying on BPF_FETCH acting as a barrier,
> for example:
>
>   stw [%r0], 1
>   afadd [%r1], %r2
>   ldxw %r3, [%r4]
>
> may be broken. Fix it by emitting "bcr 14,0".
>
> Note that a separate serialization instruction is not needed for
> BPF_XCHG and BPF_CMPXCHG, because COMPARE AND SWAP performs
> serialization itself.
>
> Fixes: ba3b86b9cef0 ("s390/bpf: Implement new atomic ops")
> Reported-by: Puranjay Mohan <puranjay12@gmail.com>
> Closes: https://lore.kernel.org/bpf/mb61p34qvq3wf.fsf@kernel.org/
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay

