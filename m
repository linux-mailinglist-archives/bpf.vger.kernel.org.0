Return-Path: <bpf+bounces-6881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA0C76EF4B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9801C215B3
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B82417F;
	Thu,  3 Aug 2023 16:21:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D7182C8
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 16:21:26 +0000 (UTC)
Received: from frasgout12.his.huawei.com (ecs-14-137-139-154.compute.hwclouds-dns.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BE4E45;
	Thu,  3 Aug 2023 09:21:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGtzX3LLsz9v7cL;
	Fri,  4 Aug 2023 00:07:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAn27rj08tk6HI7AA--.882S2;
	Thu, 03 Aug 2023 17:21:01 +0100 (CET)
Message-ID: <5a938ee2f56f9ccf7df82f233fcf9c7ff310b4cb.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 00/12] integrity: Introduce a digest cache
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
 jarkko@kernel.org,  pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,
 mjg59@srcf.ucam.org, Roberto Sassu <roberto.sassu@huawei.com>, Panu
 Matilainen <pmatilai@redhat.com>
Date: Thu, 03 Aug 2023 18:20:47 +0200
In-Reply-To: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
References: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAn27rj08tk6HI7AA--.882S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4xAr1xZry8tryfJF43ZFb_yoW5WrWkp3
	43Gr17JF1DJr18Jr17Jw47JryUGwsrJrWUJryrJry8Ar45Ar1kJr18tr1Fq34UCryDJF1U
	Xr1UXw1UJr1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj5I3JQAHsh
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-07-21 at 18:33 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>

[...]

> The last part I wanted to talk about is about the digest list parsers. Th=
is
> was a long debate. In the original proposal, Matthew Garrett and Christop=
h
> Hellwig said that adding parsers in the kernel is not scalable and not a
> good idea in general. While I do agree with them, I'm also thinking what
> benefits we get if we relax a bit this requirement. If we merge this patc=
h

I tried to mitigate the risk of adding unsafe code to the kernel by
verifying the parsers with a formal verification tool, Frama-C.

The verified code can be accessed here, and contains all the necessary
dependencies (so that the kernel is not involved):

https://github.com/robertosassu/rpm-formal

I added some assertions, to ensure that for any given input, the parser
does not try to reference memory outside the assigned memory area.

I also tried to enforce finite termination by making the number of
loops dependent on the passed data length.

The output I get is the following:

[eva:summary] =3D=3D=3D=3D=3D=3D ANALYSIS SUMMARY =3D=3D=3D=3D=3D=3D
  -------------------------------------------------------------------------=
---
  13 functions analyzed (out of 13): 100% coverage.
  In these functions, 232 statements reached (out of 251): 92% coverage.
  -------------------------------------------------------------------------=
---
  Some errors and warnings have been raised during the analysis:
    by the Eva analyzer:      0 errors    2 warnings
    by the Frama-C kernel:    0 errors    0 warnings
  -------------------------------------------------------------------------=
---
  0 alarms generated by the analysis.
  -------------------------------------------------------------------------=
---
  Evaluation of the logical properties reached by the analysis:
    Assertions        5 valid     0 unknown     0 invalid      5 total
    Preconditions    25 valid     0 unknown     0 invalid     25 total
  100% of the logical properties reached have been proven.
  -------------------------------------------------------------------------=
---

The warnings are:

[eva] validate_tlv.c:353: Warning:=20
  this partitioning parameter cannot be evaluated safely on all states

[eva] validate_tlv.c:381: Warning:=20
  this partitioning parameter cannot be evaluated safely on all states

Not sure how I can make them go away. Anyway, the assertions are
successful.

I verified the parsers with both deterministic (random but valid) and
non-deterministic (random and possibly invalid) data. For deterministic
data, I also verified that bytes at a specific location have the
expected value.

Due to the increasing complexity, the analysis was not done on
arbitrary lengths and value ranges (it would probably require a
different type of analysis).

Thanks

Roberto


