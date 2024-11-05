Return-Path: <bpf+bounces-44013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE09BC53B
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 07:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726F61C20A94
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 06:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20E61B6D04;
	Tue,  5 Nov 2024 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pLxjvH1U"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41CD163
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786762; cv=none; b=JWS7rl5z5NVsBSRiSkpqi8NjCtZfROlUTNgRQQsjlvX7uPhOhmMXVjs4U0siolUZ+SmCVjtmMttoV4BGDC18vARrqa6dPCXwD/BeoAUti/sZR8cTaBxRGF7wW1nbuCtj+cPah2SE7PE8BVhfqVp76i7rksZzz96zzrUnQh6Wsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786762; c=relaxed/simple;
	bh=aEceBmm7Yoa9Fa2z9R9Zw4ZHekvdI3LXzcUMOM6lVLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0F+ypFie0QvDTIZEvCdeatMPczGlTZh52bFRNnFODD4rafRYs5jEnZBif2Juq0/fBSKGy2rsVohbUQwu6sncXvfr1E4kb4EqTKjdF0TXzQDlJZlKtKIaYt6/vBgVpqLGickzXnF0M7tAbHqqZIXlUZbN82Gyvc80m3jE/ujylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pLxjvH1U; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4fb5bbb-0360-4f03-9283-3cddc8fadbe8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730786758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEceBmm7Yoa9Fa2z9R9Zw4ZHekvdI3LXzcUMOM6lVLY=;
	b=pLxjvH1URzat4dhA36Ak0kEtBd6UOLb+5/DJMVTWwAWD7cP9O8iVbdCaElILr57RC2+NaT
	kp92uYuLUIZJPukAvIOFkznJdfwF/jGiWbYKtJ4Ui49FgbieTr6LdY37r3RSfcsUyN8nst
	zOfH6i/SdqaZXX8koKcHgpNK+OsZ+S4=
Date: Mon, 4 Nov 2024 22:05:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 05/10] bpf: Allocate private stack for
 eligible main prog or subprogs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193521.3243984-1-yonghong.song@linux.dev>
 <CAADnVQ+RGgtLtoc_ODv54gt0donCdd_4sLWS1oWA_nGStjb1KQ@mail.gmail.com>
 <34a35dce-fd05-4353-8eaa-0dc87a78dceb@linux.dev>
 <06f43c37-a789-49cb-a4b0-bc2c45ae9485@linux.dev>
 <CAADnVQLNMCnpTr5A4yNwGnV1vET1oUt3sGgZGVSHz9amWgaYSQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLNMCnpTr5A4yNwGnV1vET1oUt3sGgZGVSHz9amWgaYSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/4/24 9:19 PM, Alexei Starovoitov wrote:
> On Mon, Nov 4, 2024 at 7:44 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> Agree. I use alignment 16 to cover all architectures. for x86_64,
>> alignment 8 is used. I did some checking in arch/ directory.
> hmm. I'm pretty sure x86 psABI requires 16-byte stack alignment,
> but I don't know why.

One possible reason is to accommodate values like int128 or
128bit floating point. I will make percpu allocation with 16
byte alignment.


