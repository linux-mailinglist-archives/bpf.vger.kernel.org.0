Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D95AA633
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 05:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiIBDRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 23:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiIBDRI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 23:17:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD22A223D
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 20:17:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJjhz4WL7zlC5c
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 11:15:31 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDXcWundRFjbRcDAQ--.40284S2;
        Fri, 02 Sep 2022 11:16:58 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Test concurrent updates on
 bpf_task_storage_busy
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220901061938.3789460-1-houtao@huaweicloud.com>
 <20220901061938.3789460-5-houtao@huaweicloud.com>
 <20220901193745.haylrp5omm7p2yiq@kafai-mbp.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <0946ff6d-32f3-4886-2383-7fa8c73f7a4e@huaweicloud.com>
Date:   Fri, 2 Sep 2022 11:16:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220901193745.haylrp5omm7p2yiq@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDXcWundRFjbRcDAQ--.40284S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1kAF4DKw1rKF4xJF13Arb_yoW3WFcE9F
        4DK3Z3GrW5trnrJ3sYkFnxKayDWw43uas5Wwn8ZFy7Ww17X397tr4DK3WfAws7CFsYyr9x
        C34UKa40gw15ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/2/2022 3:37 AM, Martin KaFai Lau wrote:
> On Thu, Sep 01, 2022 at 02:19:38PM +0800, Hou Tao wrote:
>> +void test_task_storage_map_stress_lookup(void)
>> +{
SNIP
>> +	ctx.start = true;
>> +	for (i = 0; i < nr; i++)
>> +		pthread_join(tids[i], NULL);
>> +
>> +	skel->bss->pid = getpid();
>> +	err = read_bpf_task_storage_busy__attach(skel);
>> +	CHECK(err, "attach", "error %d\n", err);
>> +
>> +	/* Trigger program */
>> +	syscall(SYS_gettid);
>> +	skel->bss->pid = 0;
>> +
>> +	CHECK(skel->bss->busy != 0, "bad bpf_task_storage_busy", "got %d\n", skel->bss->busy);
> Applied.  One nit.
> Please follow up with a test PASS or SKIP printf.
> There is a 'skips' counter in test_maps.c that
> is good to bump also.
Will send a follow-up patch to do it. Thanks.
>
> .

