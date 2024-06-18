Return-Path: <bpf+bounces-32412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5BF90D78B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C7CB24B79
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 15:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD723759;
	Tue, 18 Jun 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JBKxnnQx"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B61E517;
	Tue, 18 Jun 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724541; cv=none; b=H6Y9/t43xnQ4UtDK0GB46fgQekZbU/YMAPvk7QFkhF/A8tDEfkT3XH3Dc+doV3/2dtIqCmAbsbLK2aGADKafEtGYRfB/yOsXbb2eM+eNip1+gFyZ1XjFky42XvFdzRYbecnwCgHdrIOxFZwgQxYa83xEvdzun5ij/q4oX+CMZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724541; c=relaxed/simple;
	bh=13hdQyWfgxJICumaih7VaGeSrILSJFdl7Sg+tkoPVU0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D/CUpS6/ruXSSj5cZ7jhfNvkjAUeMs7xtEQfQ1SRcoxM6bXUnmpqmuLRBdKKsMDEZewkGtynhNJyfKHs4N8MJYlvaTTDEXOem0ikONBLt705qQc5yUY3rvxXWOpGRQVQPZUA+7Rzg50oaA3cBY1Y0BO+O3HxWs7ICWQRyqgyUEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JBKxnnQx; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BLV0h1fNLCoeUnyzO6M9mrj9v0YKFdisy8TTAF7xWVU=; b=JBKxnnQxBqQZeKUZfu0w9l1bdO
	FJQSnjYMtdB9cUV9RjAluHyTNF10qD0fnvIfv5GaOIWXqEMNOq2IU+AKFbvn+xyMb0gt5qaxZmEDd
	G5X7mweYfFFpkjF+/04hAOwcLOdBJCcnCkTeM6p5M/4jhVQ3DLPJT9A4KlsXpgsXwtwU/lOEGwgdP
	5gNungk9++TyxmAaoAnAQ+UV6ng3urZpzHAN5ewXAsLaAwwFt8hc4IY5Wq6PUwh437sJSX2gS+ZC/
	HuEEQt/ilxPihL2MIa9ewJ4CAGEMKLN9ajGNHJlZW8974KwxlHb+l9ctg/hLLOoAzC70OhLBvT8Z8
	DjpiTAOw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sJalM-000A5w-JM; Tue, 18 Jun 2024 17:28:48 +0200
Received: from [178.197.248.18] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sJalM-000EyV-18;
	Tue, 18 Jun 2024 17:28:48 +0200
Subject: Re: [PATCH v2 bpf] bpf: Fix remap of arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 kernel test robot <lkp@intel.com>
Cc: bpf <bpf@vger.kernel.org>, oe-kbuild-all@lists.linux.dev,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Eddy Z <eddyz87@gmail.com>, Pengfei Xu <pengfei.xu@intel.com>,
 Barret Rhoden <brho@google.com>, Kernel Team <kernel-team@fb.com>
References: <20240617171812.76634-1-alexei.starovoitov@gmail.com>
 <202406181248.u80sRLXy-lkp@intel.com>
 <CAADnVQK0fLbhqRuLDEVj3dPpg46xR0KRmty0hJNQ2G04yeAKLw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7e18a1f4-8385-2245-a72c-04f026ec01fd@iogearbox.net>
Date: Tue, 18 Jun 2024 17:28:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQK0fLbhqRuLDEVj3dPpg46xR0KRmty0hJNQ2G04yeAKLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27309/Mon Jun 17 10:30:25 2024)

On 6/18/24 4:49 PM, Alexei Starovoitov wrote:
> On Mon, Jun 17, 2024 at 9:43 PM kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Alexei,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on bpf/master]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/bpf-Fix-remap-of-arena/20240618-012054
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
>> patch link:    https://lore.kernel.org/r/20240617171812.76634-1-alexei.starovoitov%40gmail.com
>> patch subject: [PATCH v2 bpf] bpf: Fix remap of arena.
>> config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240618/202406181248.u80sRLXy-lkp@intel.com/config)
>> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240618/202406181248.u80sRLXy-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202406181248.u80sRLXy-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>     kernel/bpf/arena.c: In function 'arena_vm_open':
>>>> kernel/bpf/arena.c:235:27: warning: unused variable 'arena' [-Wunused-variable]
>>       235 |         struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>>           |                           ^~~~~
> 
> Daniel or Andrii,
> could you please remove this line while applying?

Ok, done, both lines actually.

