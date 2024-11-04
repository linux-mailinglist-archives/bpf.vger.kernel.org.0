Return-Path: <bpf+bounces-43863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F0E9BAA55
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 02:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611141C21952
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 01:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C8D15C147;
	Mon,  4 Nov 2024 01:35:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4CBA34;
	Mon,  4 Nov 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684109; cv=none; b=kXcB3gRrBpOhTQTmdxUMYG3FGUkMuueIF7r5Mr941FDdhLNYwcoz3F11NBz0gal7i5FZFepVGUg3Z6wR/1Jfwt0i0b9WDLu9AUJUt0T9VBuHr9d7SK/RotmElEDsSg5TfOzq0N/Z8TJZMwv3NAZaxzjJ3fQHoY0AueZWCRRNj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684109; c=relaxed/simple;
	bh=dmjd8SgnTqtPPqJabuSxtaVlktBRQFvwIjLCnmlLeoI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fm97ZiFvI5qmBaC8IK7YO41bXJ2qM4p2mVcgD/3iqZ6xfWYDhnNQc3qg4wFz3Tumw/XbE5BP1LEP8Y1RGwUyanakTzvQeWr3KsS+xvqg9VUEEeyJqO5V/QE83VP5+Wh4YIHEPB0SamsMYrSl1Y0zg9r36ReU+CzsK2ZLNgm5CkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XhYt655C6z4f3kvP;
	Mon,  4 Nov 2024 09:34:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 742891A018D;
	Mon,  4 Nov 2024 09:34:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYW8JChnA0omAw--.49075S2;
	Mon, 04 Nov 2024 09:34:55 +0800 (CST)
Subject: Re: [PATCH bpf] selftests/bpf: Add a copyright notice to
 lpm_trie_map_get_next_key
To: Byeonguk Jeong <jungbu2855@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZycSXwjH4UTvx-Cn@ub22>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <925cb852-df24-81b6-318a-ee6a628d43c7@huaweicloud.com>
Date: Mon, 4 Nov 2024 09:34:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZycSXwjH4UTvx-Cn@ub22>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAHMYW8JChnA0omAw--.49075S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4Dur1UZF13Zw1ruFyDWrg_yoW8tFWfpF
	Z7KFZxKrWDJ3Z0kr1xGF1Uu3y8Kw1qkFyayw18Kw45WF98X397Kry09r4Y93ZFyrs5uw1Y
	vw47u3s7A348tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/3/2024 2:04 PM, Byeonguk Jeong wrote:
> Hi,
>
> The selftest "verifier_bits_iter/bad words" has been failed with
> retval 115, while I did not touched anything but a comment.
>
> Do you have any idea why it failed? I am not sure whether it indicates
> any bugs in the kernel.
>
> Best,
> Byeonguk

Sorry for the inconvenience. It seems the test case
"verifier_bits_iter/bad words" is flaky. It may fail randomly, such as
in [1]. I think calling bpf_probe_read_kernel_common() on 3GB addr under
s390 host may succeed and the content of the memory address will decide
whether the test case will succeed or not. Do not know the reason why
reading 3GB address succeeds under s390. Hope to get some insight from
Ilya.  I think we could fix the failure first by using NULL as the
address of bad words just like null_pointer test case does. Will merge
the test in bad_words into the null_pointer case.

[1]:
https://github.com/kernel-patches/bpf/actions/runs/11625956355/job/32377297736
>
> On Sun, Nov 03, 2024 at 04:41:26AM +0000, bot+bpf-ci@kernel.org wrote:
>> Dear patch submitter,
>>
>> CI has tested the following submission:
>> Status:     FAILURE
>> Name:       [bpf] selftests/bpf: Add a copyright notice to lpm_trie_map_get_next_key
>> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=905730&state=*
>> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/11648453401
>>
>> Failed jobs:
>> test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/11648453401/job/32434970670
>>
>> First test_progs failure (test_progs_no_alu32-s390x-gcc):
>> #433 verifier_bits_iter
>> tester_init:PASS:tester_log_buf 0 nsec
>> process_subtest:PASS:obj_open_mem 0 nsec
>> process_subtest:PASS:specs_alloc 0 nsec
>> #433/13 verifier_bits_iter/bad words
>> run_subtest:PASS:obj_open_mem 0 nsec
>> run_subtest:PASS:unexpected_load_failure 0 nsec
>> do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>> run_subtest:FAIL:1035 Unexpected retval: 115 != 0
>>
>>
>> Please note: this email is coming from an unmonitored mailbox. If you have
>> questions or feedback, please reach out to the Meta Kernel CI team at
>> kernel-ci@meta.com.
> .


