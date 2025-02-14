Return-Path: <bpf+bounces-51532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB6AA3578A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 08:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557781890197
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8865155CB3;
	Fri, 14 Feb 2025 07:03:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A632753E8
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516598; cv=none; b=pnFR3tfvglzArgnRQw55ep7ijHFwxI7kkL4hKIRGzWvddham0FixBdjBTbEaT6JMGaLfx4ZUopHyRfo5fAYupiFVn49JYh6eK8zUJKjQZFrwSBVEZLP623GtrCW9YyMTCCKIkfUvJUJqZ/Wr6av1OqZioNb21M2KDKZMOOGBPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516598; c=relaxed/simple;
	bh=cxPbFTfq360UydIdMJDBbXYB6K/8ADMUy2idW7qhsQw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VT6btCHybrcpbeLjqS0aavalpNFXHCg//7g08dnUJJSqBkIFuqNCek0EQ5ARCEby7dZcf8mkf/ZPxw95ajO+nvfuTEPZuFYLK+0FZrsHuYYeOGFVc1jgu/gPSKmGf6bwIhasNjuX6o9BbxniH7wA5+eHcEnHcfoNd/vqDYPV9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YvNKh39lhz4f3kvm
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 15:02:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3B9DF1A0ED7
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 15:03:11 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBHUGOr6q5n7B8lDw--.61329S2;
	Fri, 14 Feb 2025 15:03:11 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 10/20] bpf: Introduce bpf_dynptr_user
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
 <20250125111109.732718-11-houtao@huaweicloud.com>
 <CAADnVQLKcQtWM5e3sycn8fBpSvVa8Ly1fyE8J8BDPQZVE56Qxw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ade143b5-d919-faf0-7acc-982d5b726311@huaweicloud.com>
Date: Fri, 14 Feb 2025 15:03:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLKcQtWM5e3sycn8fBpSvVa8Ly1fyE8J8BDPQZVE56Qxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBHUGOr6q5n7B8lDw--.61329S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4xWFWUZF1kKF4Uur15Jwb_yoW5Wr48pF
	95GFWxur4xJFW7Cr1DJa1Ivr4Fgr4rur1UK39F9ryYkryqgF93ZF40gFsIkFZ5t3yUKrW7
	XryIgrZ8u3y0vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/14/2025 8:13 AM, Alexei Starovoitov wrote:
> On Sat, Jan 25, 2025 at 2:59 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> For bpf map with dynptr key support, the userspace application will use
>> bpf_dynptr_user to represent the bpf_dynptr in the map key and pass it
>> to bpf syscall. The bpf syscall will copy from bpf_dynptr_user to
>> construct a corresponding bpf_dynptr_kern object when the map key is an
>> input argument, and copy to bpf_dynptr_user from a bpf_dynptr_kern
>> object when the map key is an output argument.
>>
>> For now the size of bpf_dynptr_user must be the same as bpf_dynptr, but
>> the last u32 field is not used, so make it a reserved field.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  include/uapi/linux/bpf.h       | 6 ++++++
>>  tools/include/uapi/linux/bpf.h | 6 ++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 2acf9b3363717..7d96685513c55 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7335,6 +7335,12 @@ struct bpf_dynptr {
>>         __u64 __opaque[2];
>>  } __attribute__((aligned(8)));
>>
>> +struct bpf_dynptr_user {
>> +       __bpf_md_ptr(void *, data);
>> +       __u32 size;
>> +       __u32 reserved;
>> +} __attribute__((aligned(8)));
> Pls add a comment explaining that bpf_dynptr_user is for user space only
> and bpf progs should continue using bpf_dynptr.
> May be give an example that to use bpf_dynptr in map key
> the bpf prog should write:
>
> +struct mixed_dynptr_key {
> + int id;
> + struct bpf_dynptr name;
> +};
>
> while to access that map the user space should write:
>
> +struct id_dname_key {
> + int id;
> + struct bpf_dynptr_user name;
> +};

Will add comments for the {data,size} tuple case.
>
> tbh the api is kinda ugly, since in the past we always had user space
> and bpf prog reuse the same struct names.
> Here the top struct names have to be different,
> but have to have the same layout.
>
> Maybe let's try the following:
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fff6cdb8d11a..55d225961dbf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7335,7 +7335,14 @@ struct bpf_wq {
>  } __attribute__((aligned(8)));
>
>  struct bpf_dynptr {
> +       union {
>         __u64 __opaque[2];
> +       struct {
> +               __bpf_md_ptr(void *, data);
> +               __u32 size;
> +               __u32 reserved;
> +       };
> +       };
>  } __attribute__((aligned(8)));
>
> Then bpf prog and user space can use the same key type.
> .

It seems a bit strange to combine these two structs, because bpf prog
uses bpf_dynptr as an opaque object, but user space application uses
bpf_dynptr as a {data,size} tuple. However, I don't have better idea.
Will switch to that in v3.



