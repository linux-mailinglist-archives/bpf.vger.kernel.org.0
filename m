Return-Path: <bpf+bounces-77902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D8BCF6305
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 02:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F045730434B9
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F9277037;
	Tue,  6 Jan 2026 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sNtSauTl"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F38330D3B
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661635; cv=none; b=Ws2JrzHSFY8VEwr3M+X7q3JiHmcQYBRA6mNZr0ars2W/3VsgcG0KVbm/OiAbddttsFCzAUnxr+V19vFCtO6QT/Z4X6yoFjIrWA+iqTXEWgTT6x6Ico3wIUZNDAJ1oVPIQOWO6Gnemf+I3UPY0W/mPu52/6o424rMSVva+krTdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661635; c=relaxed/simple;
	bh=wlKyS3PRGFWV7qxw0e/pdzEygk0ZENtPmb5Wq+JIJFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xu9xgkku1zVtZF3nv9jnyRlL+txvLye9xEiP+CIJVqst6035cC5GPl9RKXLxq+wMumauj62ttTuuuLYsIJAVdOaIiDTCzd2wdMxxzmo8BUJnGUJFXnRsOq1YDgERv8UsEtBSvR6AqYwNQxeM+6aZwAJXy0mDB3BHTp5pAB3RBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sNtSauTl; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6908562f-4a99-44ea-bffb-19f33fcffe83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767661621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7xYbDqAgfLdGwtu0uzVYsQkSvajSsHD9SkxWwTo6WY=;
	b=sNtSauTlLKMoon9ITkEUV42eUtFomjhZDRDFIdawl3fQc09hoVwYrCp/7yQnApnKr67CSu
	PeClGkygf4UkRFTQUPGuxbsRyfaA4EGKHVN3WX77K3suMtxHnjnn3e5hbS/vLFQVI46yyK
	CF5NNd9RzdNnxc0i9hKRmDUcOT0nyIQ=
Date: Mon, 5 Jan 2026 17:06:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] scripts/gen-btf.sh: Disable LTO when generating
 initial .o file
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260105-fix-gen-btf-sh-lto-v1-1-18052ea055a9@kernel.org>
 <ff8187bd-0bae-4b49-8844-6c975a2e79c6@linux.dev>
 <20260105234605.GB1276749@ax162>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260105234605.GB1276749@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/5/26 3:46 PM, Nathan Chancellor wrote:
> On Mon, Jan 05, 2026 at 02:01:36PM -0800, Ihor Solodrai wrote:
>> Hi Nathan, thank you for the patch.
>>
>> I'm starting to think it wasn't a good idea to do
>>
>> 	echo "" | ${CC} ...
>>
>> here, given the number of associated bugs.
> 
> Yeah, I was wondering if a lack of KBUILD_CPPFLAGS would also be a
> problem since that contains the endianness flag for some targets. I
> cannot imagine any more issues than that but I can understand wanting to
> back out of it.
> 
>> Before gen-btf.sh was introduced, the .btf.o binary was generated with this [1]:
>>
>> 	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
>> 		--strip-all ${1} "${btf_data}" 2>/dev/null
>>
>> I changed to ${CC} on the assumption it's a quicker operation than
>> stripping entire vmlinux. But maybe it's not worth it and we should
>> change back to --strip-all? wdyt?
> 
> That certainly seems more robust to me. I see the logic but with
> '--only-section' and no glob, I would expect that to be a rather quick
> operation but I am running out of time today to test and benchmark such
> a change. I will try to do it tomorrow unless someone beats me to it.

I got curious and did a little experiment. Basically, I ran perf stat
on this part of gen-btf.sh:

	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CFLAGS} -c -x c -o ${btf_data} -
	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
		--set-section-flags .BTF=alloc,readonly ${btf_data}
	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}

Replacing ${CC} command with:

	${OBJCOPY} --strip-all "${ELF_FILE}" ${btf_data} 2>/dev/null

for comparison.

TL;DR is that using ${CC} is:
  * about 1.5x faster than GNU objcopy --strip-all .tmp_vmlinux1
  * about 16x (!) faster than llvm-objcopy --strip-all .tmp_vmlinux1

With obvious caveats that this is a particular machine (Threadripper
PRO 3975WX), toolchain etc:
  * clang version 21.1.7
  * gcc (GCC) 15.2.1 20251211

This is bpf-next (a069190b590e) with BPF CI-like kconfig.

Pasting perf stat output below.


# llvm-objcopy --strip-all
$ perf stat -r 31 -- ./gen-btf.o_strip.sh

 Performance counter stats for './gen-btf.o_strip.sh' (31 runs):

     1,300,945,256      task-clock:u                     #    0.962 CPUs utilized               ( +-  0.10% )
                 0      context-switches:u               #    0.000 /sec                      
                 0      cpu-migrations:u                 #    0.000 /sec                      
           327,311      page-faults:u                    #  251.595 K/sec                       ( +-  0.00% )
     1,532,927,570      instructions:u                   #    1.33  insn per cycle            
                                                  #    0.03  stalled cycles per insn     ( +-  0.00% )
     1,155,639,083      cycles:u                         #    0.888 GHz                         ( +-  0.18% )
        53,144,866      stalled-cycles-frontend:u        #    4.60% frontend cycles idle        ( +-  0.99% )
       297,229,466      branches:u                       #  228.472 M/sec                       ( +-  0.00% )
           903,337      branch-misses:u                  #    0.30% of all branches             ( +-  0.02% )

           1.35200 +- 0.00137 seconds time elapsed  ( +-  0.10% )


# GNU objcopy --strip-all
$ perf stat -r 31 -- ./gen-btf.o_strip.sh

 Performance counter stats for './gen-btf.o_strip.sh' (31 runs):

       119,747,488      task-clock:u                     #    0.970 CPUs utilized               ( +-  0.41% )
                 0      context-switches:u               #    0.000 /sec                      
                 0      cpu-migrations:u                 #    0.000 /sec                      
             9,186      page-faults:u                    #   76.711 K/sec                       ( +-  0.01% )
       132,651,881      instructions:u                   #    1.68  insn per cycle            
                                                  #    0.08  stalled cycles per insn     ( +-  0.00% )
        79,191,259      cycles:u                         #    0.661 GHz                         ( +-  1.06% )
        10,136,981      stalled-cycles-frontend:u        #   12.80% frontend cycles idle        ( +-  2.58% )
        28,422,807      branches:u                       #  237.356 M/sec                       ( +-  0.00% )
           354,981      branch-misses:u                  #    1.25% of all branches             ( +-  0.02% )

          0.123415 +- 0.000564 seconds time elapsed  ( +-  0.46% )


# echo "" | clang ...
$ perf stat -r 31 -- ./gen-btf.o_llvm.sh

 Performance counter stats for './gen-btf.o_llvm.sh' (31 runs):

        62,107,490      task-clock:u                     #    0.774 CPUs utilized               ( +-  0.31% )
                 0      context-switches:u               #    0.000 /sec                      
                 0      cpu-migrations:u                 #    0.000 /sec                      
             9,755      page-faults:u                    #  157.066 K/sec                       ( +-  0.01% )
        88,196,854      instructions:u                   #    1.18  insn per cycle            
                                                  #    0.19  stalled cycles per insn     ( +-  0.00% )
        74,944,793      cycles:u                         #    1.207 GHz                         ( +-  0.50% )
        16,494,448      stalled-cycles-frontend:u        #   22.01% frontend cycles idle        ( +-  0.48% )
        17,914,949      branches:u                       #  288.451 M/sec                       ( +-  0.00% )
           459,548      branch-misses:u                  #    2.57% of all branches             ( +-  0.10% )

          0.080237 +- 0.000313 seconds time elapsed  ( +-  0.39% )


# echo "" | gcc ...
$ perf stat -r 31 -- ./gen-btf.o_gnu.sh

 Performance counter stats for './gen-btf.o_gnu.sh' (31 runs):

        53,683,797      task-clock:u                     #    0.770 CPUs utilized               ( +-  0.33% )
                 0      context-switches:u               #    0.000 /sec                      
                 0      cpu-migrations:u                 #    0.000 /sec                      
             8,390      page-faults:u                    #  156.286 K/sec                       ( +-  0.01% )
        69,398,474      instructions:u                   #    1.22  insn per cycle            
                                                  #    0.17  stalled cycles per insn     ( +-  0.00% )
        56,763,954      cycles:u                         #    1.057 GHz                         ( +-  0.39% )
        12,103,546      stalled-cycles-frontend:u        #   21.32% frontend cycles idle        ( +-  0.47% )
        14,064,366      branches:u                       #  261.985 M/sec                       ( +-  0.00% )
           347,383      branch-misses:u                  #    2.47% of all branches             ( +-  0.09% )

          0.069735 +- 0.000253 seconds time elapsed  ( +-  0.36% )


> 
> Cheers,
> Nathan


