Return-Path: <bpf+bounces-59037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E88AC5E17
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68BEE7AA15B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547A1F5EA;
	Wed, 28 May 2025 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h88kr1Ap"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC107FD
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391336; cv=none; b=dBvcXkesue8j9ZZVWZGLmHTRKkniQwgPvDUfC75pJchD8xcnHfY5NCPjw5SfnUt/+2Z9lQ4NE5GvzUU2iZ3Bcq5cGAwZ4Bi58rJQFv+ftfZFjof3eI2kDJZJRZHT3rBDFEncnzJq3sAf1h2xvPdHIdK5zXxXdMef8QUWWny+eWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391336; c=relaxed/simple;
	bh=8jy2lxDluNtavO8EYHrZZ182tkV8F8WNEMPMhciutkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TwYNpy79S3EsLgiS1JxFG8y76EWZPvZQSB+7YAtmn9dFs3B5lhT/vlGbt58sziQqVQCuyc9U+OD7ttLwhw2CWoWfrdnRS6rGiwbxeH3BxhHCVZgx1UnT7oDRGqt+Rkqpr2G/yDEamz+PpK1OvDSBlYmqPryGGHYga/g6dZCV7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h88kr1Ap; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c46611b6so4451099b3a.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748391334; x=1748996134; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKKfDYFznTdGGXd7qbd7Y28+t09cxE2n806aKyaE7SE=;
        b=h88kr1ApEj2Uz19/fuQ6cKcK9QCXV2gtnV9LbAOvDrsJXkRoPW4xEM9elXyvgc7lO7
         VSsMeEmesQJ8ZT9G8KBbk5xfeOyZjfv2qtv1V5TRjrM3HCgF3crCbbM+cLdDrdoo8AdR
         8jfpV22YYyrjLRyjcwMN9RZR00cm8g9/OjLojhCg7z+r4Cdpdcw9j10H6K18dshbBTp6
         9zeMM9FGuP4HkOT0GWhhhZLJEIz2PKFqk4Uy/loJ/0T8nMs0oHtOSkEKFQ781A3AOaMY
         ImMOI2eqjeA1DV73cHOwM54NCpWvILtWFBYTUi+bLzAgFATqJ99v3JStsY6Jr09cFlww
         vbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748391334; x=1748996134;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKKfDYFznTdGGXd7qbd7Y28+t09cxE2n806aKyaE7SE=;
        b=ViuOEslIhpNoIO8zgcVbJL8dAc4VfTqQJ2U/zhvlSaUTLFs9j8Sg77t+Va+n51Tqhu
         1+Rcggds/J2Y5Wr93IRctElBfHrW0VOS5pH6A2etH2tPIci3udGxawW6oKtMTFCaUTsb
         dMMZXXpVRPd8L+bBhlVrim5LZ9eS7p3EwZ0rtA+RsRWyajRCN4W4ll7jJ78jvu+plFmV
         8VEI488b6f9CfV1wYEtOdBxYQ3qxTG/JeNvXhRA9IcPlk4+hfwiy8hwNjVzUk0sszkJK
         iJnkcqFJqCgHlIW5CmMBHIKhiDo8XFSM6o5Qe8IpFI5V3VhNEw4Q7Uo8G5NiXe4S9Tkh
         Ce9A==
X-Gm-Message-State: AOJu0YyuMElG7HY3BCmBcA55ysSMJtJWknTEgomIYmQqRW4EC9kKeth5
	ER4FI32X5COS060QrBvcRquybvBSPdon0RAmiI1STUnedK2qjPAJx9hC
X-Gm-Gg: ASbGncuhwAYXvAdiLpwCZ5xP24dHz2dFP4VVd4epmoZ2LQMbHKu0x9Aboz37ySQXen+
	RLQT+cAmU5ipIaOEv+PIdesdTAvsdikRVcVGfLLWxgyPDZH5NHC76H9PDNaQvhs9xO+1MWR8U5n
	IfqdKqyXDA0k/fkq4SwV2r1EusZxHPl8FU4xlzMgDJrRolsfe3z0hrNNcr37y1xLTviRfz2lvLd
	9eE5F0kQLRtXzbSH0htfUo7wbZe8Ji+T/7T8ZolcFoptEYBZJ10mlG3SUj4R46FSnuLSEcCejKt
	llJHnd8Cgp4Ei04wIzRj7rHpPtuX7RIXtxDkAYwzPhrsEKy/U5k4o+bOtN9Wvo1ZMQ==
X-Google-Smtp-Source: AGHT+IEarfFg/6E0sxSw6qy6wZdu68ziNn3G/zmDx+oJQHk+xEAbOudT55nEgmToeN9UKvxQBjiKEw==
X-Received: by 2002:a17:903:32c2:b0:22e:3eb9:471b with SMTP id d9443c01a7336-23414f60848mr214689165ad.23.1748391333810;
        Tue, 27 May 2025 17:15:33 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::7:461c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234cc2336b8sm1686695ad.159.2025.05.27.17.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:15:33 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 04/11] bpf: Hold RCU read lock in
 bpf_prog_ksym_find
In-Reply-To: <CAP01T76sCLH8qCrEqr=oYLW3CpbZA-+ifbA3DOCXT93Lk0LN5Q@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Sat, 24 May 2025 06:41:08
	+0200")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-5-memxor@gmail.com>
	<CAP01T76sCLH8qCrEqr=oYLW3CpbZA-+ifbA3DOCXT93Lk0LN5Q@mail.gmail.com>
Date: Tue, 27 May 2025 17:15:31 -0700
Message-ID: <m2o6vd4ml8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -782,7 +782,11 @@ bool is_bpf_text_address(unsigned long addr)
>>
>>  struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
>>  {
>> -       struct bpf_ksym *ksym = bpf_ksym_find(addr);
>> +       struct bpf_ksym *ksym;
>> +
>> +       rcu_read_lock();
>> +       ksym = bpf_ksym_find(addr);
>> +       rcu_read_unlock();
>>
>>         return ksym && ksym->prog ?
>>                container_of(ksym, struct bpf_prog_aux, ksym)->prog :
>
> This isn't right, we need to have the read section open around ksym
> access as well.
> We can end the section and return the prog pointer.
> The caller is responsible to ensure prog outlives RCU protection, or
> otherwise hold it if necessary for prog's lifetime.
>
> We're using this to pick programs who have an active stack frame, so
> they aren't going away.
> But the ksym access itself needs to happen under correct protection.
>
> I can fix it in a respin, whatever is best.

Are rcu_read_{lock,unlock} necessary in core.c:search_bpf_extables()
after this change?
Also, helpers.c:bpf_stack_walker.c does not have lock/unlock in it,
this patch needs a fixes tag for commit f18b03fabaa9 ("bpf: Implement BPF exceptions")?

