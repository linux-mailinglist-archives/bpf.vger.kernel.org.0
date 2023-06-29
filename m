Return-Path: <bpf+bounces-3680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD7741E40
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 04:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A291C208AF
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 02:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D782187C;
	Thu, 29 Jun 2023 02:28:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F791842
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 02:28:49 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF81BE4;
	Wed, 28 Jun 2023 19:28:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs2SX4dQZz4f4F3C;
	Thu, 29 Jun 2023 10:28:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDHuRda7Jxk9ehcLw--.33191S2;
	Thu, 29 Jun 2023 10:28:45 +0800 (CST)
Subject: Re: [PATCH bpf-next v7 1/2] selftests/bpf: Add min() and max() macros
 in bpf_util.h
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 Hou Tao <houtao1@huawei.com>
References: <20230628115910.3817966-1-houtao@huaweicloud.com>
 <20230628115910.3817966-2-houtao@huaweicloud.com>
 <CAADnVQ+yg5iP59Y1oTsZmM6A2orOY=JNZME+m=TgJpOKwYbj_Q@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <91b90b24-3bdf-cbdc-dd59-d8b78b1af368@huaweicloud.com>
Date: Thu, 29 Jun 2023 10:28:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+yg5iP59Y1oTsZmM6A2orOY=JNZME+m=TgJpOKwYbj_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDHuRda7Jxk9ehcLw--.33191S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4DXFy3tw1rKr4fZw1xuFg_yoWDKFXEqr
	4Fyr97AFWkCFyqv3WUCas3uFW8GayrWrsrJr45try3CF1DXa1rJFs5uryYvF9IgayDGFW3
	JFsYvFZxJr4YqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/29/2023 2:02 AM, Alexei Starovoitov wrote:
> On Wed, Jun 28, 2023 at 4:41 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> max() will be used by the following htab-mem benchmark patch.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  tools/testing/selftests/bpf/bpf_util.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
>> index 10587a29b967..e87e9f8c13a7 100644
>> --- a/tools/testing/selftests/bpf/bpf_util.h
>> +++ b/tools/testing/selftests/bpf/bpf_util.h
>> @@ -59,4 +59,11 @@ static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
>>         (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>>  #endif
>>
>> +#ifndef min
>> +#define min(x, y) ((x) < (y) ? (x) : (y))
>> +#endif
>> +#ifndef max
>> +#define max(x, y) ((x) < (y) ? (y) : (x))
>> +#endif
> That's for user space only?
> Just use the standard MIN/MAX macros.
> .
Yes. Will update and remove this prepare patch.


