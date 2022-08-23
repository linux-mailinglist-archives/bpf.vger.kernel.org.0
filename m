Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB05259D169
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 08:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbiHWGly (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 02:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbiHWGlw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 02:41:52 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5961132
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 23:41:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MBfjp1HPSzKxJp
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 14:40:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgCXm+iodgRjyJnEAg--.13377S2;
        Tue, 23 Aug 2022 14:41:48 +0800 (CST)
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu
 map_locked
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Hou Tao <houtao1@huawei.com>
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com>
 <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
 <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com>
 <CA+khW7h1OK2oqGyCipGfySV_kcHW4=SHo6123nk2WTTXMOMUxQ@mail.gmail.com>
 <387c851f-03ae-9b34-4ec0-9667fb26ec18@huaweicloud.com>
 <CA+khW7jgvZR8azSE3gEJvhT_psgEeHCdU3uWAQUkkKFLgh0a4Q@mail.gmail.com>
 <CA+khW7iv+zX0XzC++i-F7QZju9QGufh6+SVN3JWp9WyJe2qhMg@mail.gmail.com>
 <CAADnVQ+udaAy5OZ-BXpfeQZdPRHD6F+FUD7KxJfxcjiyvh2Dsg@mail.gmail.com>
 <67c5da0b-e5af-0934-6e17-1c43d0f96165@huaweicloud.com>
 <CAADnVQ+nd3p0=nNoa4kKOXgAbscm+k0EQeSupwF2Rs3vhftTAQ@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <c3517815-e291-0cd2-5296-971334a7ad3b@huaweicloud.com>
Date:   Tue, 23 Aug 2022 14:41:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+nd3p0=nNoa4kKOXgAbscm+k0EQeSupwF2Rs3vhftTAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgCXm+iodgRjyJnEAg--.13377S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW5JVWrJwAF
        c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjxUFDGOUUUUU
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

On 8/23/2022 12:50 PM, Alexei Starovoitov wrote:
> On Mon, Aug 22, 2022 at 7:57 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>
SNIP
>>> So please address Hao's comments, add a test and
>>> resubmit patches 1 and 3.
>>> Also please use [PATCH bpf-next] in the subject to help BPF CI
>>> and patchwork scripts.
>> Will do. And to bpf-next instead of bpf ?
> bpf-next is almost always prefered for fixes for corner
> cases that have been around for some time.
> bpf tree is for security and high pri fixes.
> bpf-next gives time for fixes to prove themselves.
> .
Understand. Thanks for the explanation.

