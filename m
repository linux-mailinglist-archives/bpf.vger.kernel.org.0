Return-Path: <bpf+bounces-1938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B317248CB
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51CD1C20B07
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95030B97;
	Tue,  6 Jun 2023 16:17:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045B37B97
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 16:17:31 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6363F19B5;
	Tue,  6 Jun 2023 09:17:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbFj23984z9v7g4;
	Wed,  7 Jun 2023 00:06:46 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBH+D7jW39k6f4OAw--.4034S2;
	Tue, 06 Jun 2023 17:16:47 +0100 (CET)
Message-ID: <a662955b402126c79cc287299a749d706406ff8f.camel@huaweicloud.com>
Subject: Re: [PATCH v11 0/4] evm: Do HMAC of multiple per LSM xattrs for new
 inodes
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
 stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org, 
	nicolas.bouchinet@clip-os.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 06 Jun 2023 18:16:31 +0200
In-Reply-To: <276a89395a11bf2c38fc2b24bdfd8a62f1430199.camel@linux.ibm.com>
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
	 <276a89395a11bf2c38fc2b24bdfd8a62f1430199.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBH+D7jW39k6f4OAw--.4034S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYb7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18
	PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj45LyAADs6
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-06 at 12:09 -0400, Mimi Zohar wrote:
> Hi Roberto,
> 
> Based on which git repo/branch does this patch set apply?  In the
> future please include the "--base" option.

Hi Mimi

yes, sorry, I forgot to add this information.

It applies on:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/log/?h=next

plus:

https://github.com/cschaufler/smack-next/commits/next

Roberto


