Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03F26A6581
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 03:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCACbP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 21:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCACbP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 21:31:15 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D67D8D
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 18:31:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PRJBh409Nz4f3jqW
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 10:31:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7PsuP5j9PsOEg--.21322S4;
        Wed, 01 Mar 2023 10:31:10 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     laoar.shao@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, horenc@vt.edu,
        john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com,
        kpsingh@kernel.org, sdf@google.com, songliubraving@fb.com,
        xiyou.wangcong@gmail.com, yhs@fb.com
Subject: Re: [PATCH bpf-next v3 02/18] bpf: lpm_trie memory usage
Date:   Wed,  1 Mar 2023 10:59:29 +0800
Message-Id: <20230301025929.237985-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230227152032.12359-3-laoar.shao@gmail.com>
References: <20230227152032.12359-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7PsuP5j9PsOEg--.21322S4
X-Coremail-Antispam: 1UD129KBjvJXoW7urWrCF4DJr4DKryrKrykZrb_yoW8Ar48pF
        WFka4kGr40qr47Xwsavws8urZ8Xw1fGw42gas5K34Sy3sIqr9rGFyvgFW7ZrWY9FWUKr45
        JFn5tryvq3y3uFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
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

Hi,

> trie_mem_usage() is introduced to calculate the lpm_trie memory usage.
> Some small memory allocations are ignored. The inner node is also
> ignored.
> 
> The result as follows,
> 
> - before
> 10: lpm_trie  flags 0x1
>         key 8B  value 8B  max_entries 65536  memlock 1048576B
> 
> - after
> 10: lpm_trie  flags 0x1
>         key 8B  value 8B  max_entries 65536  memlock 2291536B
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/lpm_trie.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index d833496..e0ca08e 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -720,6 +720,16 @@ static int trie_check_btf(const struct bpf_map *map,
>  	       -EINVAL : 0;
>  }
>  
> +static u64 trie_mem_usage(const struct bpf_map *map)
> +{
> +	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
> +	u64 elem_size;
> +
> +	elem_size = sizeof(struct lpm_trie_node) + trie->data_size +
> +			    trie->map.value_size;
> +	return elem_size * trie->n_entries;
Need to use READ_ONCE(trie->n_entries) because all updates of n_entries are protected by trie->lock and here it is a lockless read.

> +}
> +
>  BTF_ID_LIST_SINGLE(trie_map_btf_ids, struct, lpm_trie)
>  const struct bpf_map_ops trie_map_ops = {
>  	.map_meta_equal = bpf_map_meta_equal,
> @@ -733,5 +743,6 @@ static int trie_check_btf(const struct bpf_map *map,
>  	.map_update_batch = generic_map_update_batch,
>  	.map_delete_batch = generic_map_delete_batch,
>  	.map_check_btf = trie_check_btf,
> +	.map_mem_usage = trie_mem_usage,
>  	.map_btf_id = &trie_map_btf_ids[0],
>  };
> -- 
> 1.8.3.1
> 

