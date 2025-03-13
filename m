Return-Path: <bpf+bounces-53955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0DA5F4AE
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 13:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D326917D0BF
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8652D26771F;
	Thu, 13 Mar 2025 12:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692422676CE
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869564; cv=none; b=e+sSbO0qvlRTox00eUVce0R+PLGLXK0LlF7vXj4HOdGqF5bG8IfpSbNNL7pg3/DCRr7JLEaF8zIEO1K0k3HQ78XuGQjXOTeMr+jZAZszgoikTpXims/4f4W9jGx7acxjn4B6GFlXStgyeme1rFHDJ1FGeLMDRn+41EKqPiwY3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869564; c=relaxed/simple;
	bh=RCseLYF2wAKB3eKHYVm/HJzulPAyBLdxXXDwjak2XgU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bSjr8yodSukJwYT0H1SOtV0+F/6sSoDL+2/xF62H93VNZwilveGa7wZMAXDl9b3mMK0LOTqDXxtQBKY6UqKaOz1lWI08ibLVdJspCpuImwjJKNkjt8FLVRk1A3igRNPfKe+Pz3LEUezN2sjFi6hfXcPTBq4N4aC5bPFu6XZuQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZD6W22xxqz4f3mHb
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 20:38:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4CDE91A06D7
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 20:39:18 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCX+Fzy0dJnlKiCGQ--.9609S2;
	Thu, 13 Mar 2025 20:39:18 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix string read in strncmp
 benchmark
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20250313122852.1365202-1-vmalik@redhat.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <afd60f3c-98ce-7c6e-2f57-e8c63615e630@huaweicloud.com>
Date: Thu, 13 Mar 2025 20:39:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250313122852.1365202-1-vmalik@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCX+Fzy0dJnlKiCGQ--.9609S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy3Ww1Dtw4xJr17CF13CFg_yoW5Wr4fpr
	1DC34aka1xCr1Sqa48t3yrAFy7Zr4Iy3y8ZFZ5t3WYvw4DtrnFq342yrW7GwnFga4UGw1I
	qr1rtw1aqryqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 3/13/2025 8:28 PM, Viktor Malik wrote:
> The strncmp benchmark uses the bpf_strncmp helper and a hand-written
> loop to compare two strings. The values of the strings are filled from
> userspace. One of the strings is non-const (in .bss) while the other is
> const (in .rodata) since that is the requirement of bpf_strncmp.
>
> The problem is that in the hand-written loop, Clang optimizes the reads
> from the const string to always return 0 which breaks the benchmark.
>
> Use barrier_var to prevent the optimization.
>
> The effect can be seen on the strncmp-no-helper variant.
>
> Before this change:
>
>     # ./bench strncmp-no-helper
>     Setting up benchmark 'strncmp-no-helper'...
>     Benchmark 'strncmp-no-helper' started.
>     Iter   0 (112.309us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   1 (-23.238us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   2 ( 58.994us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   3 (-30.466us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   4 ( 29.996us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   5 ( 16.949us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Iter   6 (-60.035us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
>     Summary: hits    0.000 ± 0.000M/s (  0.000M/prod), drops    0.000 ± 0.000M/s, total operations    0.000 ± 0.000M/s
>
> After this change:
>
>     # ./bench strncmp-no-helper
>     Setting up benchmark 'strncmp-no-helper'...
>     Benchmark 'strncmp-no-helper' started.
>     Iter   0 ( 77.711us): hits    5.534M/s (  5.534M/prod), drops    0.000M/s, total operations    5.534M/s
>     Iter   1 ( 11.215us): hits    6.006M/s (  6.006M/prod), drops    0.000M/s, total operations    6.006M/s
>     Iter   2 (-14.253us): hits    5.931M/s (  5.931M/prod), drops    0.000M/s, total operations    5.931M/s
>     Iter   3 ( 59.087us): hits    6.005M/s (  6.005M/prod), drops    0.000M/s, total operations    6.005M/s
>     Iter   4 (-21.379us): hits    6.010M/s (  6.010M/prod), drops    0.000M/s, total operations    6.010M/s
>     Iter   5 (-20.310us): hits    5.861M/s (  5.861M/prod), drops    0.000M/s, total operations    5.861M/s
>     Iter   6 ( 53.937us): hits    6.004M/s (  6.004M/prod), drops    0.000M/s, total operations    6.004M/s
>     Summary: hits    5.969 ± 0.061M/s (  5.969M/prod), drops    0.000 ± 0.000M/s, total operations    5.969 ± 0.061M/s
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Fixes: 9c42652f8be3 ("selftests/bpf: Add benchmark for bpf_strncmp() helper")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>

Acked-by: Hou Tao <houtao1@huawei.com>

The problem can be reproduced by using clang 18. After apply the patch,
the problem is fixed.


