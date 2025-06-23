Return-Path: <bpf+bounces-61261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC66AE3548
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 08:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD2616CF79
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 06:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377AC1DB366;
	Mon, 23 Jun 2025 06:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/xFMbcx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403D7E0E4
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750658815; cv=none; b=aAJEXtE1VUDmDYJx6PBivhcf4N39zClWlxBjwQxWwfdIHvMlmZb/sgPkL2h8riXiFNoM+E+LMxXoQ5OraYRhtWV6C7ES/eunDKDDz/z1jd0yxCt9AwTimbCQyLSOKgpEG+A7pT8napbfTCY9iWq72rKEW91dvmCg7UXbbaNpHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750658815; c=relaxed/simple;
	bh=U41fTgONRBtjWI6SV8rjTjvLGtB5hvWY8KZE8w8h/tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laanFT6b8YcDH/4BNG/aB9Qi5XeLz5aZUQMRlPk38Il8PW9rdOPm1O774JCDX6DfZlUZR9xdWAwXtnq7FG5TEzJlofLEsttgXgxJdJctfMoXQaDld0cBm58bV0bY0Q7FbDt3/DBzpfk/zSZ3MEm5XJgu2yc+G4F/cOqrabw7skE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/xFMbcx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750658813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7B2xANrbLrWCJupxHs4Qp3DmgQTkKiqVo6NNzx1AMQ=;
	b=g/xFMbcx3eUbFa3zwVTTTin9VuiFWDReZ7+EvNnEp+4M9MgciLmbCEFu0IxvTQY67UJ1pM
	PguMtVYpeAyw+EsVmKGOHotf9D++G6P9vSChF854i+TlyW7sNQFubKBty2MokNnIVusQx2
	ou2V0ilPQ9Pn70xuiC0/sfpfItrkJow=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-VLsmh7OoP-a1FXHRHxGypA-1; Mon, 23 Jun 2025 02:05:34 -0400
X-MC-Unique: VLsmh7OoP-a1FXHRHxGypA-1
X-Mimecast-MFC-AGG-ID: VLsmh7OoP-a1FXHRHxGypA_1750658733
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a58939191eso1472136f8f.0
        for <bpf@vger.kernel.org>; Sun, 22 Jun 2025 23:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750658733; x=1751263533;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7B2xANrbLrWCJupxHs4Qp3DmgQTkKiqVo6NNzx1AMQ=;
        b=uTTol9LDGibWtGjBfN3/n984TW87Ji8bZCHxCreUE4EhA//humVCqEAEwop7+kjHEJ
         8fue/VojVOzbBhjO87GSqyI0+62stpsL4eMwk889+Ab/TIAFwibsH0enVedq/Yu0wYkK
         urVuELYosCgi6M+t0MajL8mcYm4up5PadIUuM9K7tjWiBymqScNuyDsqqnElrFkNehLK
         FXTK4EH+LgIz55B2LatyLkwb/NUSKXHVrjY9KKNjeZQSISzzw1pVTdCbyBilzEQrV8mP
         Havqh4bXijN4yeEkvNh5afrjbokfEIjbSS8eBN25QxMjP/FZaGSMO/vT3+/j36XUg48l
         Xm8Q==
X-Gm-Message-State: AOJu0YwxE5Cp/SUuS7AOsMFquZBoGU07buerGW86veIbRcRee4P7lKkV
	BWzH1ZTbIeOUcdzBEum4qxZ/dzVF/dZhBkptcJ696HYOWSOKvfnlNYdvD2UaMk3xGSs4iI5Wdrb
	C68vSwy3R72ktWHsJ5ci3GMM2b0OW+nlC68A7tbI3juJ8ktERdh9Z
X-Gm-Gg: ASbGncuQLaGWNkuHKCsSCjrJ1nCKsKP1KyqfxA83M49RfnufWprESyXkuH5cgBvHHNw
	2Kd/sdTRDUoiRIocba0LN/3HqdUoHIbzoj4/nnaYP7i7cYuasN1th5yNxZlZZO+wHwLceWdqLJQ
	oB35u3ejg4NSrLHEWEOHN7kkLwO4gS8pFIcXlRf3gu7rIF0asobYQU8VtdQtAdhMub+tHhiU/W3
	56wN8f70AlTrEtmXSRszYIdYXvnSaS1tGbU+x9ZJO10l0r54SouPHGwESWif/bnDWHBwGQJgoPD
	jxKi3xmMXmbUUVV01aC+fjmMIveQ8MU1Tcu/8fMmbh1UoPoRwcWRYMJP
X-Received: by 2002:a05:6000:658:b0:3a6:d967:380c with SMTP id ffacd0b85a97d-3a6d9673f9bmr4201037f8f.36.1750658733220;
        Sun, 22 Jun 2025 23:05:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGztGt3d1zPfGEl6gPA9SGu1MzR0c9x/rj3PrWsRtsbHyMtKbPACKY6qUs079pMWpWLW4KYFg==
X-Received: by 2002:a05:6000:658:b0:3a6:d967:380c with SMTP id ffacd0b85a97d-3a6d9673f9bmr4201014f8f.36.1750658732867;
        Sun, 22 Jun 2025 23:05:32 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a1bsm133832325e9.33.2025.06.22.23.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 23:05:32 -0700 (PDT)
Message-ID: <6c716452-5743-4708-a0cc-34166a742c93@redhat.com>
Date: Mon, 23 Jun 2025 08:05:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add tests for string
 kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1750402154.git.vmalik@redhat.com>
 <17543560f4a1e269aec6596e72fe3fff8ef1dd2e.1750402154.git.vmalik@redhat.com>
 <fdbb8caa-77f6-4143-ad0b-4f32d9e6d8e6@redhat.com>
 <CAADnVQKj3iTJyhXiQbcSo=6rJarfY_uMQi9yhytmjX-y24GXkQ@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKj3iTJyhXiQbcSo=6rJarfY_uMQi9yhytmjX-y24GXkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/20/25 20:06, Alexei Starovoitov wrote:
> On Fri, Jun 20, 2025 at 5:33 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>>> +SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }
>>
>> For some reason, these tests are failing on s390x. I'll investigate.
> 
> I suspect this is the reason for failures:
> 
> +char *user_ptr = (char *)1;
> +char *invalid_kern_ptr = (char *)-1;

Actually, the kernel address works fine, it's the userspace addresses
causing the problem (user_ptr and NULL). On s390, __get_kernel_nofault
always returns 0 for these addresses instead of going to the exception
table.

> Ilya,
> 
> Please suggest user/kern addresses to use for these tests.

FWIW, I've also tried a couple other random userspace addresses, for all
of them __get_kernel_nofault returned 0.

In string kfuncs, 0 is treated as the end of the string (not an error),
so, unless some s390 expert has a better solution, the best I can think
of here is to disable the userspace addresses tests on s390.

Viktor


