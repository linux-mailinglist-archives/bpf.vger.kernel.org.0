Return-Path: <bpf+bounces-53707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FEDA58A7D
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 03:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42846168151
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9817A312;
	Mon, 10 Mar 2025 02:34:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDBA935
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574077; cv=none; b=QkZBydIvDz8Tq2OKll7IzNdHPKsEZ0U6pT74UCjOs9JQrmAO6mDwYuIHlOBIlG3OLmMFxi9dR0x+4vhQQjp5IcwX0+eNqnSbX2rdDbA+WY4mvWVcRzpdT2YQaeWfOs+RHgaEvUtBZY2tmUsKgu477ux6+oQ0j9yXFCOntrRSt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574077; c=relaxed/simple;
	bh=7Kp1g1zrJyV6ZZyCL/Tq6ntVUWXZZe+euIeMG2H+XUg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bkMIPWPcqeVl6u4k0DQmexkDFcyKDGaJ40PiJdspNFxznl4fzb8isjgNG+phGVuwTD0TN1qz+hcp+gMzsBddVvzyQI5gRTs5PTwS073ImoU5mf3LcZZqUu47rwjwwvKscu7jQTVKEHsfH0tgTjyW1bopErFIZi60sglm2tBCTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZB1Dc59Tnz4f3kFH
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 10:34:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 061021A06D7
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 10:34:30 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgDH0GO1T85n4bUUGA--.18618S2;
	Mon, 10 Mar 2025 10:34:29 +0800 (CST)
Subject: Re: [PATCH v7 4/4] selftests: bpf: fix duplicate selftests in
 cpumask_success.
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, tj@kernel.org, memxor@gmail.com
References: <20250309230427.26603-1-emil@etsalapatis.com>
 <20250309230427.26603-5-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b299c859-74ea-135f-4b34-702c91f633a2@huaweicloud.com>
Date: Mon, 10 Mar 2025 10:34:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250309230427.26603-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgDH0GO1T85n4bUUGA--.18618S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1fZrWxurWrAFyrWFWxWFg_yoWxAFgEgF
	97Wr1kZw47uw47tw1YgF4akFW8tay7W397XF1UJFsxZF12v39YqFnYvwn8Z34xG3sIvrn2
	gwn7WFWvv34IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3
	UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 3/10/2025 7:04 AM, Emil Tsalapatis wrote:
> The BPF cpumask selftests are currently run twice in
> test_progs/cpumask.c, once by traversing cpumask_success_testcases, and
> once by invoking RUN_TESTS(cpumask_success). Remove the invocation of
> RUN_TESTS to properly run the selftests only once.
>
> Now that the tests are run only through cpumask_success_testscases, add
> to it the missing test_refcount_null_tracking testcase. Also remove the
> __success annotation from it, since it is now loaded and invoked by the
> runner.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Acked-by: Hou Tao <houtao1@huawei.com>


