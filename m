Return-Path: <bpf+bounces-19415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C094782BBE3
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 08:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C11F24DE0
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F7B5D72A;
	Fri, 12 Jan 2024 07:41:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962E5B1E4;
	Fri, 12 Jan 2024 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxrusI7aBlXHsEAA--.13273S3;
	Fri, 12 Jan 2024 15:40:56 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx34cE7aBl_V8TAA--.50255S3;
	Fri, 12 Jan 2024 15:40:53 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Skip callback tests if jit is
 disabled in test_verifier
To: Hou Tao <houtao@huaweicloud.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20240112015700.19974-1-yangtiezhu@loongson.cn>
 <1e919c98-2fc4-bd03-df19-97c4e8a24649@huaweicloud.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1930b1eb-afff-8509-e233-26c28e7622fd@loongson.cn>
Date: Fri, 12 Jan 2024 15:40:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1e919c98-2fc4-bd03-df19-97c4e8a24649@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Bx34cE7aBl_V8TAA--.50255S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW5uFWDJry3uF1kJrW8AFc_yoW8Xr4fpF
	WDJFsFyFWkXryrKrWqqw17JF93trWkJryqyFZIgayUJwnxZr9YqF18KryF9FZrZryDua4I
	vF48uF9xu3y3JacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
	WlkUUUUU=



On 01/12/2024 12:21 PM, Hou Tao wrote:
> Hi,
>
> On 1/12/2024 9:57 AM, Tiezhu Yang wrote:
>> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
>> exist 6 failed tests.

...

>> +static bool is_jit_enabled(void)
>> +{
>> +	const char *jit_sysctl = "/proc/sys/net/core/bpf_jit_enable";
>> +	bool enabled = false;
>> +	int sysctl_fd;
>> +
>> +	sysctl_fd = open(jit_sysctl, 0, O_RDONLY);
>
> It should be open(jit_sysctl, O_RDONLY).

Yes, this function comes from test_progs.c, I think
it is better to move it to testing_helpers.c with
this change.

>> +	if (sysctl_fd != -1) {
>> +		char tmpc;
>> +
>> +		if (read(sysctl_fd, &tmpc, sizeof(tmpc)) == 1)
>> +			enabled = (tmpc != '0');
>> +		close(sysctl_fd);
>> +	}
>> +
>> +	return enabled;
>> +}
>> +
>>  static int null_terminated_insn_len(struct bpf_insn *seq, int max_len)
>>  {
>>  	int i;
>> @@ -1662,6 +1691,16 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>>  		goto close_fds;
>>  	}
>>
>> +	if (!is_jit_enabled()) {
>
> Is it necessary to check whether jit is enabled or not each time ? Could
> we just check it only once just like unpriv_disabled does ?

Yes, it looks better, will modify the related code.

>> +		for (i = 0; i < prog_len; i++, prog++) {
>
> Is it better to only check pseudo_func only when both fd_prog < 0 and
> saved_errno == EINVAL are true, so unnecessary check can be skipped ?

Yes, will do it like this:

   if (fd_prog < 0 && saved_errno == EINVAL && jit_disabled)

Thanks,
Tiezhu


