Return-Path: <bpf+bounces-63288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1FB04DCC
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 04:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1FE3B1789
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EDC2C327E;
	Tue, 15 Jul 2025 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dMIilexW"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8681A8412
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546123; cv=none; b=pimHrqPTGS15cmpSVueGubOrLBdBWBj0Oys4bo69MEdvS2sb8FYmaa1Z/SdtHPzq0Nnmmr9EnALoFZCvtiJvBJTVWLrmZ4ADrj9nNOxbS2+nCdmqWQuLmjzK3JmAWgV7plV0GyT4O9yvhAAIJ7W0MzMxrImEwFkViBRcegpPwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546123; c=relaxed/simple;
	bh=Bt4Lg6fkQ1I3lRJ6fSVH9O3myzqEgcL4Tzt9IlewX6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mabNFknfKUG9nXOgH6J4u5nS2jNxN7au4njTYP68NVu2OB0I5lzHU4TB9VDHvYD6lcM2Jkak2y4i2kA1UP4QTMnCRXM3J8axkmVigA+Les8u08sLfsl1MI2cHPGnLMj496GvcdSBCSY98/vaUwOv/3WWNNe/frGGL1NXGa/IkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dMIilexW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b7ce379-3a03-4e6c-976f-8ea93abe7129@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752546109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm3Q+NNgGjYFRJRzRUfBNBDTKxjdEwDdWv+PaxWBpa4=;
	b=dMIilexWBrJj+fPZZ+mKeApg8DoIwlBSKs2NhvbWg12jbVKJPvG2PxEm7jBVC0lwBXdf3A
	e/JBgrU8u7/QjQYhd120HgJOd8DWylD9CoyJHVR7pFNldAoSdWWg89h1Fw3WmRF7aMR2IO
	2Z7CJs3MErvxSQzYrxjNpQ9f5bNJtyY=
Date: Tue, 15 Jul 2025 10:21:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Add struct bpf_token_info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, willemb@google.com,
 kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711094517.931999-1-chen.dylane@linux.dev>
 <CAEf4BzZzsqu1=Q-3+6uJvgvKd52o+FR=DFp28w+vT5knP9NyCQ@mail.gmail.com>
 <f580b139-a08b-4705-addd-31f104fd570c@linux.dev>
 <CAEf4BzbwRj7XC0rvWDzJX+v3QweYBh=dT6H17piyD=v1QLbi7w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbwRj7XC0rvWDzJX+v3QweYBh=dT6H17piyD=v1QLbi7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/15 05:06, Andrii Nakryiko 写道:
> I think it makes sense overall, so I
> don't really have objections to adding the API.

Yes, it is. Thank you for your patiently reply, and there was
some compilation warning from kernel test，i will fix it in v2.

-- 
Best Regards
Tao Chen

