Return-Path: <bpf+bounces-7881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F282F77DC0F
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 10:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A734D281862
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BFD307;
	Wed, 16 Aug 2023 08:22:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C1443D
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 08:22:40 +0000 (UTC)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E21BE8;
	Wed, 16 Aug 2023 01:22:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RQgkd2NsDz9v7Jj;
	Wed, 16 Aug 2023 16:08:41 +0800 (CST)
Received: from [10.81.209.179] (unknown [10.81.209.179])
	by APP1 (Coremail) with SMTP id LxC2BwAn27okh9xkzRb3AA--.62650S2;
	Wed, 16 Aug 2023 09:22:07 +0100 (CET)
Message-ID: <84159dc8-d2e5-4c10-9910-b329500862e0@huaweicloud.com>
Date: Wed, 16 Aug 2023 10:21:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 02/13] integrity: Introduce a digest cache
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, corbet@lwn.net, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,
 mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
 <20230812104616.2190095-3-roberto.sassu@huaweicloud.com>
 <CUSFHQGJ3I8F.WBL3ZYT3U5FB@suppilovahvero>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CUSFHQGJ3I8F.WBL3ZYT3U5FB@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwAn27okh9xkzRb3AA--.62650S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbG2Nt
	UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj5KudAAAs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/14/2023 7:03 PM, Jarkko Sakkinen wrote:
> On Sat Aug 12, 2023 at 1:46 PM EEST, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Introduce the digest cache, a structure holding a hash table of digests,
>> extracted from a digest list. Its pointer is stored in the iint of the
> 
> What is iint? I honestly don't know what it is. I first thought that it
> was "int" typoed.

Ops. It is the integrity_iint_cache structure, to retain the 
integrity-specific state of an inode. Will explain that in the next version.

Thanks

Roberto


