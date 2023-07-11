Return-Path: <bpf+bounces-4730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA874E834
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691461C20B61
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D737174CD;
	Tue, 11 Jul 2023 07:40:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AFF5CBC
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:40:08 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3097E1A4;
	Tue, 11 Jul 2023 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Jvs47pnLFbOZN+azKq1C5wj2WCQusgiaHr3c6gc02MA=; b=TpKJPkSbUuCRkZ5xDjO8ka1TrN
	vG6Gfqk1XHRrSmiWuno8oVr93rlUi4n94wEe9hVDazeG9JY1DlTiz72QvjH3kh/dhh3zsUx4HcZ2U
	Hj8IC/7NNEDJXXtIAtW6OZ37fv+T5E6v9sRoI0epkQmgZdORzqWn5QiROxqN1/0/orQxMTOQbGEpa
	6gC82FusuIfdoR1+0Fwp+vZt8ap5DEZNyFcx5MGQUpjP1o3Z3X3NXYDWEIMQd2hWbiZohtj398blq
	yHA//54Bl2ycuwdbP8Idz6fMVqyE9lu/2mKQwhuzPjgAinfopG5GjHsAVGHxsKDMFVXRWAmG+pGtb
	vl0CcZOA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJ7yP-0007pp-CJ; Tue, 11 Jul 2023 09:39:49 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJ7yO-000Xjb-L2; Tue, 11 Jul 2023 09:39:48 +0200
Subject: Re: [PATCH v2] samples/bpf: Fix compilation failure for samples/bpf
 on LoongArch Fedora
To: Huacai Chen <chenhuacai@kernel.org>, Haoran Jiang <jianghaoran@kylinos.cn>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kernel@xen0n.name, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, loongarch@lists.linux.dev, martin.lau@linux.dev,
 nathan@kernel.org, ndesaulniers@google.com, sdf@google.com, song@kernel.org,
 trix@redhat.com, yangtiezhu@loongson.cn, yhs@fb.com
References: <CAAhV-H6s3N=-brDz24PfrtEKNFjvnLjbDR2NpOVDF_fN7rA53A@mail.gmail.com>
 <20230710052750.259595-1-jianghaoran@kylinos.cn>
 <CAAhV-H7orsUHDZuwcTUeWYbizcWRG4k_BPy53W7PT_MQ_2SXgw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7ecc42aa-4a0f-77f7-a2ad-236270137b6e@iogearbox.net>
Date: Tue, 11 Jul 2023 09:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7orsUHDZuwcTUeWYbizcWRG4k_BPy53W7PT_MQ_2SXgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26965/Mon Jul 10 09:29:40 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/10/23 7:54 AM, Huacai Chen wrote:
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> 
> On Mon, Jul 10, 2023 at 1:34 PM Haoran Jiang <jianghaoran@kylinos.cn> wrote:
>>
>> When building the latest samples/bpf on LoongArch Fedora
>>
>>       make M=samples/bpf
>>
>> There are compilation errors as follows:
>>
>> In file included from ./linux/samples/bpf/sockex2_kern.c:2:
>> In file included from ./include/uapi/linux/in.h:25:
>> In file included from ./include/linux/socket.h:8:
>> In file included from ./include/linux/uio.h:9:
>> In file included from ./include/linux/thread_info.h:60:
>> In file included from ./arch/loongarch/include/asm/thread_info.h:15:
>> In file included from ./arch/loongarch/include/asm/processor.h:13:
>> In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
>> ./arch/loongarch/include/asm/loongarch.h:13:10: fatal error: 'larchintrin.h' file not found
>>           ^~~~~~~~~~~~~~~
>> 1 error generated.
>>
>> larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
>> and the header file location is specified at compile time.
>>
>> Test on LoongArch Fedora:
>> https://github.com/fedora-remix-loongarch/releases-info
>>
>> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
>>
>> ---
>> v2:
>> use LoongArch instead of Loongarch in the title and commit message.
>> ---
>>   samples/bpf/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 615f24ebc49c..b301796a3862 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -434,7 +434,7 @@ $(obj)/%.o: $(src)/%.c
>>          @echo "  CLANG-bpf " $@
>>          $(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
>>                  -I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
>> -               -I$(LIBBPF_INCLUDE) \
>> +               -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \

There's still one location in XDP_SAMPLE_CFLAGS, do we need the $(CLANG_SYS_INCLUDES)
there as well?

>>                  -D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
>>                  -D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
>>                  -Wno-gnu-variable-sized-type-not-at-end \
>> --
>> 2.27.0
>>
>>


