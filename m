Return-Path: <bpf+bounces-42228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C48C9A126E
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 21:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97641F2308D
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68902139D1;
	Wed, 16 Oct 2024 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZbCS2Nzj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6818B481
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106686; cv=none; b=hg7pVPXT0714HRG1fUZmXblAf8EpppL3c3xRL2Y58ZRn/MWvEU8NysIFLDOYWva8RQieQ93SDaT5ydzxDa0f13Qd3CDYnZHLa1zQoZZ3hbSIoUg1M6NqggzIbnzgCD6FPVjq+aFFbHADhtU6F6iG47b8MHRbtWmufBoR7O1UT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106686; c=relaxed/simple;
	bh=FzU/iLTZ4B1IaU06GFiFkVzaSWgyml6zKfql2USL3Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLPF7usX1X22Mrtu3ZN93uZh0AU7G3DFoJp3M1RcDBFILRP1DLrDDekogOMFTW02qaW7hsozelYBlL0iHczi9cUiH9iAor711IvM9NEVCCZYAHqFzr29nX1rIYeataBHTsu9f8nZZcK9UgxULiqr5WrnBPFy4CIzuev7l33U4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZbCS2Nzj; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e3e6f14b3aso128058b6e.0
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729106683; x=1729711483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFrbDrPfg3rrkD9XkEkUzNWI5xOL9/0Wm1TLTmu/5jY=;
        b=ZbCS2NzjJOllOD5qhYNv3rke3JIYevW4w+O/XMDv5H/1Zt7/boqCXJs3/8Ccw0O2JW
         jf/Ov1iq09AwaknywBHldS2e3VzIefygupfS64ddI5cbAJGnZ1Bz7hK1WP0bnxdpDzHO
         pfzqSZQd9i/4mUCk6AWUN0PnJCzmshO141SxZa+p+FENC2JPG4W4UHKqIdXPDH002xr2
         V0dn54ToI1IoWp+uUEfm6m8ANnDb525LTKNjVD2va5te350aMa2NEKFZrySNZX5as3s6
         VHSVGP7nlA7cVM1evRO1aqcarAlqELnMUKil0ER+eSYQ/WX4U2say2tGLnh3dVx2+vDK
         Df/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106683; x=1729711483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFrbDrPfg3rrkD9XkEkUzNWI5xOL9/0Wm1TLTmu/5jY=;
        b=RQBPsjtbPdotDQKEpP6WUVVq+iEWFtCLsMjG4HPzJ3LOjf3fWPoD7g5XOUBWiL52Tb
         1SshWxyi8qNGwgiyIRNOAxmRFu8Fmb4+Y+y02duvkZMMHH2uf5wYpoSmoew6Nzv78pFs
         W6ibtTXdihDxTYKYIo8yQXV46z9w836c/N2ud0MFyoIj52HBBQyTSyepuLUcTDeoqfQi
         pLlsampSltH3FiRr/wisZWclaNlSukqoXbjdSy+EDMIy2EOKjWhaTk0AdB0pedZAhR2Z
         PW/doDsSUniuW90ShYHfEHEP43/i7A1F8cLXFXBgJdT+4lRFXyzxmmPH/ILhYprmeIvz
         mKng==
X-Forwarded-Encrypted: i=1; AJvYcCWDCT3LeO7dCEiVB8txGCYrfEe+HQFspTPiI0sfXn2hpTSlIAXkJRWvaAb1iMSOkdp3Z7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Zlzg8K5u6b01y5x+ARMb+K6newMVVBKpxwM/TwVv7s05tLNJ
	x4i4zEF4h9HAcrT44haOswSugerZIeoWigEV/bfiafsIXkNhYnosJjj49PpJgic=
X-Google-Smtp-Source: AGHT+IGTzfLbqI0Dpl3Jiqxt+Q0SSXDSbCiRxSKsEac4EdSus5akKW3T9AweFnZwOVZdSyeaeMjfyw==
X-Received: by 2002:a05:6808:2022:b0:3e0:5896:a0bb with SMTP id 5614622812f47-3e5f0289cdemr4470403b6e.18.1729106683428;
        Wed, 16 Oct 2024 12:24:43 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e5f353e8dasm580272b6e.54.2024.10.16.12.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 12:24:40 -0700 (PDT)
Message-ID: <78d6acdf-f87c-4594-8f0e-77a86fa4e83e@bytedance.com>
Date: Wed, 16 Oct 2024 12:24:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: RE: [PATCH bpf 0/2] Two fixes for test_sockmap
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 bhole_prashant_q7@lab.ntt.co.jp, jakub@cloudflare.com,
 xiyou.wangcong@gmail.com
References: <20241012203731.1248619-1-zijianzhang@bytedance.com>
 <671001a983dd2_1e3420833@john.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <671001a983dd2_1e3420833@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/24 11:10 AM, John Fastabend wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Function msg_verify_data should have context of bytes_cnt and k instead of
>> assuming they are zero. Otherwise, test_sockmap with data integrity test
>> will report some errors. I also fix the logic related to size and index j
>>
>> 1/ 6  sockmap::txmsg test passthrough:FAIL
>> 2/ 6  sockmap::txmsg test redirect:FAIL
>> 7/12  sockmap::txmsg test apply:FAIL
>> 10/11  sockmap::txmsg test push_data:FAIL
>> 11/17  sockmap::txmsg test pull-data:FAIL
>> 12/ 9  sockmap::txmsg test pop-data:FAIL
>> 13/ 1  sockmap::txmsg test push/pop data:FAIL
>> ...
>> Pass: 24 Fail: 52
>>
>> After fixing msg_verify_data, some of the errors are solved, but for push
>> pull and pop, we may need more fixes to msg_verify_data, added a TODO
>>
>> 10/11  sockmap::txmsg test push_data:FAIL
>> 11/17  sockmap::txmsg test pull-data:FAIL
>> 12/ 9  sockmap::txmsg test pop-data:FAIL
>> ...
>> Pass: 37 Fail: 15
> 
> Thanks. Did you plan on fixing the rest next? Otherwise I'll add it to
> my list.
> 

No problem, I will fix it next.

>>
>> Besides, added a custom errno EDATAINTEGRITY for msg_verify_data, we
>> shall not ignore the error in txmsg_cork case, and fixed the txmsg_redir
>> in test_txmsg_pull "Test pull + redirect" case.
>>
>>
>> Zijian Zhang (2):
>>    selftests/bpf: Fix msg_verify_data in test_sockmap
>>    selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
>>
>>   tools/testing/selftests/bpf/test_sockmap.c | 32 ++++++++++++++--------
>>   1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> -- 
>> 2.20.1
>>
> 
> 
> For the series,
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>


