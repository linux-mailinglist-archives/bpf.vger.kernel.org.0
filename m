Return-Path: <bpf+bounces-2316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCFA72AA2D
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 10:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2A3281A99
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6815BE6F;
	Sat, 10 Jun 2023 08:01:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EB79C6
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 08:01:39 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67F1FDB;
	Sat, 10 Jun 2023 01:01:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QdVWJ0GVGz9y7KF;
	Sat, 10 Jun 2023 15:51:08 +0800 (CST)
Received: from [10.81.219.229] (unknown [10.81.219.229])
	by APP2 (Coremail) with SMTP id GxC2BwDHilG_LYRkHqEfAw--.38471S2;
	Sat, 10 Jun 2023 09:01:14 +0100 (CET)
Message-ID: <dca634f0-ca7d-1876-0702-6ecc194ac47d@huaweicloud.com>
Date: Sat, 10 Jun 2023 10:00:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 0/4] evm: Do HMAC of multiple per LSM xattrs for new
 inodes
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
 serge@hallyn.com, stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, kpsingh@kernel.org,
 keescook@chromium.org, nicolas.bouchinet@clip-os.org,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhSzC0zV31XrEz06HKp=NNbz0XPT24ja0O1sZtNM_aXqHg@mail.gmail.com>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAHC9VhSzC0zV31XrEz06HKp=NNbz0XPT24ja0O1sZtNM_aXqHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDHilG_LYRkHqEfAw--.38471S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1DAw43Aw4Dtw4fAF4kXrb_yoWDZrbE9a
	10yrZrCw45Xws7GF4aqr1YvrWkKFW8GF1jq3y5WrWay34rAan7AF4vkF4rZr4rJay3Z343
	Cr9Iy34Sy3sFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI
	62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4qCKQAAsS
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/9/2023 10:05 PM, Paul Moore wrote:
> On Sat, Jun 3, 2023 at 3:16 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>>
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> One of the major goals of LSM stacking is to run multiple LSMs side by side
>> without interfering with each other. The ultimate decision will depend on
>> individual LSM decision.
>>
>> Several changes need to be made to the LSM infrastructure to be able to
>> support that. This patch set tackles one of them: gives to each LSM the
>> ability to specify one or multiple xattrs to be set at inode creation
>> time and, at the same time, gives to EVM the ability to access all those
>> xattrs and calculate the HMAC on them ...
> 
> Thanks for sticking with this Roberto, I see a few
> comments/suggestions on this patchset, but overall it is looking
> pretty good; I'm hopeful we will be able to merge the next revision.

Thanks for looking at it.

Just sent v12 with the suggestions. One is addressed with a different 
patch set (Smack transmute fixes).

Roberto


