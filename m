Return-Path: <bpf+bounces-61995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F2AF0409
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939071885E1B
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308328314E;
	Tue,  1 Jul 2025 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gq26tMrR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A26283C97
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399043; cv=none; b=tESx2tQFonOD6v50YOG0hKG/CCOxNVtwg6yRzwXdZ/mov4V+BADEvJdenJ5inhHGUl/yr2jPRXA7wHJ7fnFGSM1TWIftLIA8Q/bKNnH0/Gi7Bhw/s93wrDyVczfjmYbj9usisjqrZkhvlUs/9+jStfyw75FlEVV2XPIVxR8W04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399043; c=relaxed/simple;
	bh=XSrXPyN34ZlW84DZlk3jiD3xY95jDP3wXoBml++kuc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHykpQTM5rpLIEIsP14IvcGz0zLS1YfPM6a86YushEK1+upY3Jx44fGrsIU5F5l1eUb1DTqq/+HXDbHIRQ/ZkEGtwudfKvuBgtcYiysUjbgrkQPQj1Fjg/YRY/EguHE9O9HD+7KYVCpKdZoZ2f+Ez14Dt1ZmysxzX/LksK+geyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gq26tMrR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751399036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwNfXDXi/HtkILPBNIWMjY7gn8nreoM0WQX+RyiIhr4=;
	b=Gq26tMrR3InSzy3+vrxFSyFjr4f9eMgOht2Qp5eStJ5Oq7M9qCUrtb6dQ6mbcASWCVZ6lv
	5hHOi619K10vlEFGya/5DE+L1Yw1StVMTjVMPc23tFJyh6ojOpDwcYfCAXFqmcsHXsNNah
	ZhTp+VpfQB8GYscLOAg1p4fWsKdsIlg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Ut-1pXX-PD2r2BePwdwZNA-1; Tue, 01 Jul 2025 15:43:55 -0400
X-MC-Unique: Ut-1pXX-PD2r2BePwdwZNA-1
X-Mimecast-MFC-AGG-ID: Ut-1pXX-PD2r2BePwdwZNA_1751399034
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae2b7bdc8f6so442922266b.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 12:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751399034; x=1752003834;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwNfXDXi/HtkILPBNIWMjY7gn8nreoM0WQX+RyiIhr4=;
        b=eHSFAcRRYKuK0toioxatRUU/JrgdtqFDrvc8XCIjKAc5BvxNDMtSLU14pkj3KdxY7x
         a6ooivBeoRtFRQNcOwDyfPJ8ufFUsfPZfmq2WZ0bwXKgHAK8Dtvqp0TPx9Ky6Zqvj6f6
         a0B6W7KoJZ5VL9b+KSv5nvmXt2RBGju2dDZJFkx6gPjJ+QrBhDn5wJnBFZ0bw7BLhbbJ
         YRx/nBjW72oczgkH1yX5N2kxhlydjGt6qYudX/GejhXG4m8p5CoXvlAPLlm4pkcaEDRr
         nBnotApJWnY+CSqy1ZfrodqVNG7HYtOaP4ZbA/ZBnF/XWWnwlQ8qNGDaUEV8pTd8yVmB
         L3ZA==
X-Gm-Message-State: AOJu0YzzJLdaiQzql1wraDfmB2qS5xNDJyV7S/qTiivIIPQpWoGB7NOk
	whWZ0gptP2B4156fgzCauhdRrC/SGLJ9f14RCxX984afwMjYXHI0zhiGzCWjSISw5k40wRn8wND
	Sd25sU2Q0hQU6e49Bw1QsNhrnZWkOajr20Wg+YA/73VuUAVKiR6RS
X-Gm-Gg: ASbGncuW6pJKXOpd10nApvFVn0rEVPH1jgZmPg8A0j8SRSdfoQuP4aTA61uV9RNbS/A
	pe2GjbbfMQL0PXfzH2Vj15YZickaWXMbyhA3e3nxO5oEfzjnD+3+XSAY9i/rrmpLVkMiCxgSvtJ
	JqPwuaeX/1El31OdXAU/2hD9LXUJpS1viBejnyZr0NaFb0cIxC0KkN2yo1Dg/MTK/Uom3E30V5+
	bOcBaA9beHgFZoEtVQRCem06WoySjY+lDrXqP4MC8watv9R9hH/ltdhZRl8IdpWSiFaM0KDFJlp
	xBqv2GmEhan1X3G+PIieqLvlnowJfv8YWLa2+rNPblvbVsOa0S7Ff2dp
X-Received: by 2002:a17:907:6011:b0:ae3:b22c:2ee9 with SMTP id a640c23a62f3a-ae3b22c31c1mr260118766b.12.1751399034389;
        Tue, 01 Jul 2025 12:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjhRjEcstamngITY33ww829zc9JSyNHxKJl6hi5/MhiXLknub0gTfDRAnyAty0Oh2/kZ5bXQ==
X-Received: by 2002:a17:907:6011:b0:ae3:b22c:2ee9 with SMTP id a640c23a62f3a-ae3b22c31c1mr260103566b.12.1751399030016;
        Tue, 01 Jul 2025 12:43:50 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659df1sm964469166b.52.2025.07.01.12.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:43:49 -0700 (PDT)
Message-ID: <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com>
Date: Tue, 1 Jul 2025 21:43:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc
 tests
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgense?=
 =?UTF-8?Q?n?= <toke@redhat.com>, Feng Yang <yangfeng@kylinos.cn>
References: <20250630133524.364236-1-vmalik@redhat.com>
 <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 19:46, Alexei Starovoitov wrote:
> On Mon, Jun 30, 2025 at 6:35 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> BPF selftests compilation fails on systems with CONFIG_NET_SCH_BPF=n.
>> The reason is that qdisc-related kfuncs are included via vmlinux.h but
>> when qdisc is disabled, they are not defined and do not appear in
>> vmlinux.h.
> 
> Yes and that's expected behavior. It's not a bug.
> That's why we have CONFIG_NET_SCH_BPF=y in
> selftests/bpf/config
> and CI picks it up automatically.
> 
> If we add these kfuncs to bpf_qdisc_common.h where would we
> draw the line when the kfuncs should be added or not ?

I'd say that we should add kfuncs which are only included in vmlinux.h
under certain configurations. Obviously stuff like CONFIG_BPF=y can be
presumed but there're tons of configs options which may be disabled on a
system and it still makes sense to compile and run at least a part of
test_progs on them.

> Currently we don't add any new kfuncs, since they all
> should be in vmlinux.h

This way, we're preventing people to build and therefore run *any*
test_progs on systems which do not have all the configs required in
selftests/bpf/config. Running selftests on such systems may reveal bugs
not captured by the CI so I think that it may be eventually beneficial
for everyone.

WDYT?

> 
> --
> pw-bot: cr
> 


