Return-Path: <bpf+bounces-26984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C5D8A6F61
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9CCB2450B
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BC1304A9;
	Tue, 16 Apr 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="T1xpcWHn"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37461130492;
	Tue, 16 Apr 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280250; cv=none; b=Sy2ZoYns32+5rYJz+yLXIb85D/G2uCqTKNOruhZocGsKBQqKBnb/isWajPvd1NS3utaM48sZ2Ak+wrh7t8TP+pkdDkPKqcNs1SNJpKo7xhkjtDonq1HKoi0mktANN4afXMMaQlIzJHqgXPYtm/7q6oHtqQQF4kUikOMGw5vLoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280250; c=relaxed/simple;
	bh=oWmtNqx34co9G/ruHlt/dfHkDFvWiSKVm75+2tdvFfI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ru0LZ9wMy9COYMYlpyCZCsyexxSxf93kAA/jYcWZ+jOcDZ+cyD6xLD/MdH8bPeaYuvLBmf72Vaxzc0Z+RJ1Oh+K3E5h9d/SSmxFZCICWXSOxHyamMXlxIZfzI/nPFw2xoLNxF6L8SpBB3Q3mXaaUY2867dZr8vSOj1jVaXSwc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=T1xpcWHn; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1dXsDJwOcsf1iP+JSaO0Xl2y5kp0qQjyv56XNwnMJfY=; b=T1xpcWHnfBxN9wyUld0D7uM6rc
	2whbwCS9IP2z1zzo25aWi1qJ6hXvLcCEcHKemYGGPof+UGxZ7GVOIZVgYMxa4+p1KNs/7enneMEo7
	Y2XwL4mYYtLHfnpiCzTfEIuy6gp7KSKW1ZFtiQiRr+4PYjrUgFEtP3LLpLq3vNoKsTaIatmNO9vo8
	hG9ttWnHj6LFHo+PYags+uDSmlxDH1C4ynlRPzytIsvebtYs7upn2OnPJnw/eGVwf70YXFVyRTisH
	eaeOtaY3OG9FE1JbRb6e1N0Y0yRPxptO/irkPOPHn9+ml9brPfpKuoo5pUq8ci2PwQtjwclN8aDok
	rpmaNQ3g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rwk60-000DNl-8N; Tue, 16 Apr 2024 16:47:40 +0200
Received: from [178.197.249.50] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rwk5z-000E7n-02; Tue, 16 Apr 2024 16:47:39 +0200
Subject: Re: [PATCH] bpf: btf: include linux/types.h for u32
To: Jiri Olsa <olsajiri@gmail.com>,
 Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, haoluo@google.com,
 sdf@google.com, kpsingh@kernel.org, john.fastabend@gmail.com,
 yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com,
 andrii@kernel.org, ast@kernel.org, martin.lau@linux.dev,
 khazhy@chromium.org, vmalik@redhat.com, ndesaulniers@google.com,
 ncopa@alpinelinux.org, dxu@dxuuu.xyz
References: <20240414045124.3098560-1-dmitrii.bundin.a@gmail.com>
 <Zh0ZhEU1xhndl2k8@krava>
 <CANXV_Xwmf-VH5EfNdv=wcv8J=2W5L5RtOs8n-Uh5jm5a1yiMKw@mail.gmail.com>
 <Zh4ojsD-aV2vHROI@krava>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ddc0ac5b-9bd4-f31a-a7ec-83f7a10e6ab1@iogearbox.net>
Date: Tue, 16 Apr 2024 16:47:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zh4ojsD-aV2vHROI@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27247/Tue Apr 16 10:25:32 2024)

On 4/16/24 9:28 AM, Jiri Olsa wrote:
> On Tue, Apr 16, 2024 at 08:27:21AM +0300, Dmitrii Bundin wrote:
>> On Mon, Apr 15, 2024 at 3:11 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>>> lgtm, did it actualy cause problem anywhere?
>>>
>>> there's also tools/include/linux/btf_ids.h
>>
>> It caused the problems exactly in the file
>> tools/include/linux/btf_ids.h and was reported in
>> https://bugzilla.kernel.org/show_bug.cgi?id=218647
>> The patch including linux/types.h in tools/include/linux/btf_ids.h is
>> already there https://lore.kernel.org/all/20240328110103.28734-1-ncopa@alpinelinux.org/
>> I also faced the same compile-error of the form
>>
>>      error: unknown type name 'u32'
>>                                u32 cnt;
>>                                ^~~
>> when compiling the bpf tool with glibc 2.28.
>>
>> I think it might be reasonable to add the inclusion in
>> include/linux/btf_ids.h as well to prevent build problems like this.
> 
> ok, it's in the bpf/master already
Please add the error description as motivation aka "why" into the commit
description, otherwise it's not really obvious looking at it at a later
point in time why the include was needed.

Thanks,
Daniel

