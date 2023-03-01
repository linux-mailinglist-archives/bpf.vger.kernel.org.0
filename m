Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479426A6586
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 03:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCACbj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 21:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCACbj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 21:31:39 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A129E33
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 18:31:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PRJC34vzRz4f3kp7
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 10:31:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAAuf5j3v8OEg--.10060S4;
        Wed, 01 Mar 2023 10:31:29 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     laoar.shao@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, horenc@vt.edu,
        john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com,
        kpsingh@kernel.org, sdf@google.com, songliubraving@fb.com,
        xiyou.wangcong@gmail.com, yhs@fb.com
Subject: Re: [PATCH bpf-next v3 03/18] bpf: hashtab memory usage
Date:   Wed,  1 Mar 2023 10:59:49 +0800
Message-Id: <20230301025949.238485-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230227152032.12359-4-laoar.shao@gmail.com>
References: <20230227152032.12359-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbAAuf5j3v8OEg--.10060S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CryDKF47Aw4UGw43Xw15twb_yoW8uw1Upa
        13AF15JFyvgry3uayvyw1jq3yDWa18u3W3Ja4Yqr1YkrWxWr1xtFZ7tF1I9FWj9ry3X3ZY
        qFWI9wn3ArWUAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

> htab_map_mem_usage() is introduced to calculate hashmap memory usage. In
> this helper, some small memory allocations are ignore, as their size is
> quite small compared with the total size. The inner_map_meta in
> hash_of_map is also ignored.
> 
> The result for hashtab as follows,
> 
> - before this change
> 1: hash  name count_map  flags 0x1  <<<< no prealloc, fully set
>         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> 2: hash  name count_map  flags 0x1  <<<< no prealloc, none set
>         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> 3: hash  name count_map  flags 0x0  <<<< prealloc
>         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> 
> The memlock is always a fixed size whatever it is preallocated or
> not, and whatever the count of allocated elements is.
> 
> - after this change
> 1: hash  name count_map  flags 0x1    <<<< non prealloc, fully set
>         key 16B  value 24B  max_entries 1048576  memlock 117441536B
> 2: hash  name count_map  flags 0x1    <<<< non prealloc, non set
>         key 16B  value 24B  max_entries 1048576  memlock 16778240B
> 3: hash  name count_map  flags 0x0    <<<< prealloc
>         key 16B  value 24B  max_entries 1048576  memlock 109056000B
> 
> The memlock now is hashtab actually allocated.
> 
> The result for percpu hash map as follows,
> - before this change
> 4: percpu_hash  name count_map  flags 0x0       <<<< prealloc
>         key 16B  value 24B  max_entries 1048576  memlock 822083584B
> 5: percpu_hash  name count_map  flags 0x1       <<<< no prealloc
>         key 16B  value 24B  max_entries 1048576  memlock 822083584B
> 
> - after this change
> 4: percpu_hash  name count_map  flags 0x0
>         key 16B  value 24B  max_entries 1048576  memlock 897582080B
> 5: percpu_hash  name count_map  flags 0x1
>         key 16B  value 24B  max_entries 1048576  memlock 922748736B
> 
> At worst, the difference can be 10x, for example,
> - before this change
> 6: hash  name count_map  flags 0x0
>         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> 
> - after this change
> 6: hash  name count_map  flags 0x0
>         key 4B  value 4B  max_entries 1048576  memlock 83889408B
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
Acked-by: Hou Tao <houtao1@huawei.com>

