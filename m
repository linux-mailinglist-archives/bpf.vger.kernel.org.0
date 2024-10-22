Return-Path: <bpf+bounces-42744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418DB9A97C5
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 06:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DFC1F23D8C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 04:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5953084A31;
	Tue, 22 Oct 2024 04:22:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5C7E59A
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570957; cv=none; b=QgFOzJNN+9070rLrjTIpBubZ7nMVbWaCqjCRYL/yjDnD8n5QgPcl5BOeYqEOta+IthdvuvQNXrPN+UdHUqXehf7FzS+0tsSNYJ1gfZkImY6OhX/0U+KDDUhjFAp2hWQR7CctCiFU07KfwnK485ROc+H3y5kLVprBdeHR33t1Qvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570957; c=relaxed/simple;
	bh=Ixt//Q5B6obGlMy4UrHmvEzn0b5IIiu1flxmyyAGwMI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ENMo6vupfdcb3n4kMy6ofcfnKiIJI9nhftaDUO3QmXONNkVIXHOOtjNIG3tM0FoHlH8lPmTJ2d+8s0PeSGy+iWMTs3e60lzoOJ8SvaWb45DGIPhCuQuhaM20oqEAwPdoitSwIbm7sWLQqI4+ZshKAGFI1lSKDjue2vBL6TUSOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXfCR5DHKz4f3kv7
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 12:22:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E41511A0568
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 12:22:29 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDXVlyBKBdn8n4LEw--.40821S2;
	Tue, 22 Oct 2024 12:22:29 +0800 (CST)
Subject: Re: [PATCH bpf-next 01/16] bpf: Introduce map flag
 BPF_F_DYNPTR_IN_KEY
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
 <20241008091501.8302-2-houtao@huaweicloud.com>
 <CAADnVQJ67TERc5Ag22f_O0BJJPmNpQYvxP08uBa0ur6FRdJoFw@mail.gmail.com>
 <39cd6231-0d58-14fd-efd0-52dcf0c25a06@huaweicloud.com>
 <CAADnVQJD_ViXZ4Rx9GkgtDs72wW2no_5fyqM-HJ4=uVisHGcHw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a0338215-d989-de62-6e0d-05d02b83e5b9@huaweicloud.com>
Date: Tue, 22 Oct 2024 12:22:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJD_ViXZ4Rx9GkgtDs72wW2no_5fyqM-HJ4=uVisHGcHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDXVlyBKBdn8n4LEw--.40821S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw48urWUXr1xXFW7WFyUWrg_yoW8Xw4rpF
	n3GFW8Zr4DJr9xAw17ta18AF4Yya1agF10kw45Kry5Cw1Ygry5Wr18KF45CFn5trsYyF1U
	trs8Was3Ca4vq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/22/2024 11:53 AM, Alexei Starovoitov wrote:
> On Mon, Oct 21, 2024 at 6:46 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 10/10/2024 10:21 AM, Alexei Starovoitov wrote:
>>> On Tue, Oct 8, 2024 at 2:02 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> index c6cd7c7aeeee..07f7df308a01 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -1409,6 +1409,9 @@ enum {
>>>>
>>>>  /* Do not translate kernel bpf_arena pointers to user pointers */
>>>>         BPF_F_NO_USER_CONV      = (1U << 18),
>>>> +
>>>> +/* Create a map with bpf_dynptr in key */
>>>> +       BPF_F_DYNPTR_IN_KEY     = (1U << 19),
>>>>  };
>>> If I'm reading the other patches correctly this uapi flag
>>> is unnecessary.
>>> BTF describes the fields and dynptr is either there or not.
>>> Why require users to add an extra flag ?
>> Sorry for the late reply. The reason for an extra flag is to make a bpf
>> map which had already used bpf_dynptr in its key to work as before. I
>> was not sure whether or not there is such case, so I added an extra
>> flag. If the case is basically impossible, I can remove it in the next
>> revision.
> Hmm. bpf_dynptr is a kernel type and iirc (after paging in
> the context after 12 days of silence) you were proposing to add
> a new bpf_dynptr_user type which theoretically can be present
> in the key, but it's fine to break such progs.

Got it. Will remove the extra flag in the next revision. Sorry again for
the long delay.  Will try to reply timely next time. bpf_dynptr_user is
only for syscall, bpf_dynptr will be used in map key.


