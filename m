Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508D962999B
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 14:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiKONGd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 08:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiKONGc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 08:06:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739EB12ACB
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 05:06:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a14so24173920wru.5
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 05:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tV14Qy/6IUBPY0Tl3hd1OnbpHrRDKjJzVrHfXzHZ7t4=;
        b=Xy5G+zCPyxmeP8/k+Xt2vwVAIgc03vim6m0DmsGa8OdettVG/SJXKCeY8ntJtRQGmR
         lg+ORVV73zkhCsX8/YRODZrwR9yEuwc8K7pMWaqEEwXu4/1Beu7DgUdkMyoOQU1OzeOl
         Ndbyaw9LTgFH/NacD9pkCrssnKlMRzTeb1xIoBHuqz395ZZgOxNuMwmzAhULs3j7v0zT
         kq/SNMR5oEwPSlQ97Wdf49wH05hCjTsPIG8M2CBah1YO2mAsb3JW6Vieavzqh/QLQW64
         p3R8Qc9UFBHjjqOW/+eTKRiXgiH/fvVkDkdUlsRnwPE3dTPv7+IoyWfiO0aUAHHvwP0i
         201Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tV14Qy/6IUBPY0Tl3hd1OnbpHrRDKjJzVrHfXzHZ7t4=;
        b=ZjCdE5gFXNaYvq3Ore69UT7CSmbR3KfZp1t4L8nQ11FAke4izNxiwdKGTUMWPwa2UA
         7Htzc2FIJL8Nmn0ZanodPsGH58oWPjJT64TQ+A7RA7u80I1kAkOapnsYnXRzt5XiHzzG
         kOnerZDq91bygEHPqPp5S2fBwaQJCkxnfDTOb0bnXkaS4AFoXk9FBS1Q3K+VgQrApuWp
         G1ZrJwdAwvrW3sSWw+7XklQYU36NKQzFSjIfDfaJKXp4P+ba8kqcAMvDbgc6eyWXmq6g
         QVHol8EkCHwuwPHqCqmW0f+vWjo48tD/zQ9Ktw+pKDJDfxWO9R0vbeGzPJfxFy996V7L
         xtoA==
X-Gm-Message-State: ANoB5pkW6RO6q2K21NSXkpswtyQps/03OrJnl1BH5EI0BioGO9wAy2EJ
        2RVPkfSQvMicHNs6fEppjNU=
X-Google-Smtp-Source: AA0mqf7Et/YoJW8zFZ3DVW4ztyDvftEeu3HuFNG69gpqQKaahfwT6Egj/yfS9Mfo0YbsahKV9AvrhA==
X-Received: by 2002:adf:dc86:0:b0:22a:88fa:4b77 with SMTP id r6-20020adfdc86000000b0022a88fa4b77mr10180982wrj.182.1668517589970;
        Tue, 15 Nov 2022 05:06:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003cf894c05e4sm23687701wmq.22.2022.11.15.05.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:06:29 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:06:25 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     memxor@gmail.com
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf: Consolidate spin_lock, timer management into
 btf_record
Message-ID: <Y3OO0aZps7WeVpFA@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ Email screwup on my end means I have to resend two weeks of email.
  :/  -dan ]

Hello Kumar Kartikeya Dwivedi,

The patch db559117828d: "bpf: Consolidate spin_lock, timer management
into btf_record" from Nov 4, 2022, leads to the following Smatch
static checker warning:

	kernel/bpf/syscall.c:1002 map_check_btf()
	warn: ignoring unreachable code.

kernel/bpf/syscall.c
    946 static int map_check_btf(struct bpf_map *map, const struct btf *btf,
    947                          u32 btf_key_id, u32 btf_value_id)
    948 {
    949         const struct btf_type *key_type, *value_type;
    950         u32 key_size, value_size;
    951         int ret = 0;
    952 
    953         /* Some maps allow key to be unspecified. */
    954         if (btf_key_id) {
    955                 key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
    956                 if (!key_type || key_size != map->key_size)
    957                         return -EINVAL;
    958         } else {
    959                 key_type = btf_type_by_id(btf, 0);
    960                 if (!map->ops->map_check_btf)
    961                         return -EINVAL;
    962         }
    963 
    964         value_type = btf_type_id_size(btf, &btf_value_id, &value_size);
    965         if (!value_type || value_size != map->value_size)
    966                 return -EINVAL;
    967 
    968         map->record = btf_parse_fields(btf, value_type, BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR,
    969                                        map->value_size);
    970         if (!IS_ERR_OR_NULL(map->record)) {
    971                 int i;
    972 
    973                 if (!bpf_capable()) {
    974                         ret = -EPERM;
    975                         goto free_map_tab;
    976                 }
    977                 if (map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG)) {
    978                         ret = -EACCES;
    979                         goto free_map_tab;
    980                 }
    981                 for (i = 0; i < sizeof(map->record->field_mask) * 8; i++) {
    982                         switch (map->record->field_mask & (1 << i)) {
    983                         case 0:
    984                                 continue;
    985                         case BPF_SPIN_LOCK:
    986                                 if (map->map_type != BPF_MAP_TYPE_HASH &&
    987                                     map->map_type != BPF_MAP_TYPE_ARRAY &&
    988                                     map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
    989                                     map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
    990                                     map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
    991                                     map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
    992                                     map->map_type != BPF_MAP_TYPE_CGRP_STORAGE) {
    993                                         ret = -EOPNOTSUPP;
    994                                         goto free_map_tab;
    995                                 }
    996                                 break;
    997                         case BPF_TIMER:
    998                                 if (map->map_type != BPF_MAP_TYPE_HASH &&
    999                                     map->map_type != BPF_MAP_TYPE_LRU_HASH &&
    1000                                     map->map_type != BPF_MAP_TYPE_ARRAY) {
    1001                                         return -EOPNOTSUPP;
                                                 ^^^^^^^^^^^^^^^^^^^
--> 1002                                         goto free_map_tab;

s/return/ret =/

Surprised the coverity-bot hasn't complained about this...

    1003                                 }
    1004                                 break;
    1005                         case BPF_KPTR_UNREF:
    1006                         case BPF_KPTR_REF:
    1007                                 if (map->map_type != BPF_MAP_TYPE_HASH &&
    1008                                     map->map_type != BPF_MAP_TYPE_LRU_HASH &&
    1009                                     map->map_type != BPF_MAP_TYPE_ARRAY &&
    1010                                     map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
    1011                                         ret = -EOPNOTSUPP;
    1012                                         goto free_map_tab;
    1013                                 }
    1014                                 break;
    1015                         default:
    1016                                 /* Fail if map_type checks are missing for a field type */
    1017                                 ret = -EOPNOTSUPP;
    1018                                 goto free_map_tab;
    1019                         }
    1020                 }
    1021         }
    1022 
    1023         if (map->ops->map_check_btf) {
    1024                 ret = map->ops->map_check_btf(map, btf, key_type, value_type);
    1025                 if (ret < 0)
    1026                         goto free_map_tab;
    1027         }
    1028 
    1029         return ret;
    1030 free_map_tab:
    1031         bpf_map_free_record(map);
    1032         return ret;
    1033 }

regards,
dan carpenter
