Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18EE629F76
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiKOQqo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiKOQqn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:46:43 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA401F3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:46:42 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id gw22so13817070pjb.3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3iOhbkWK5hCd762mPr7ZlVFRGoZc8NDZ9OvXUXj4SHU=;
        b=i9Cuz/dAgJKOSDMvr7pMBPVGOsR0TmpiL8JNKC2AnHaS+7G3T0P8E/R0eipLhkppn6
         J1bJZO20REIEKc3rnGopkrfHVw40d9MGK/ndREPeDKBQCiZ2Z/DvwrSRCDc6ENmqZPpC
         josw24uk5KREqQwyjNGjxylXyMN8tuitfazJqztzDPYGQd8K13fofpwyjpkQU+huokxA
         YvXEnBjrpCa3SEd+NvVnjiK3EWX5wR2XCHcEzwV8WR4rMEHmoX+1n77q6OX2ycdAxB+t
         q8WAKISLKbn3M5lRJ7sJ//mtDmcIRFFn+FboSkieQHjQzwW6WrLZBEeQtSHzZlrBltNl
         BTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iOhbkWK5hCd762mPr7ZlVFRGoZc8NDZ9OvXUXj4SHU=;
        b=CTJB0IbBIDGDfqLvBcno63jhVLL1Snh8r5YKBmfBWP1b9+LSJXbphgDq4Og8/IHfuo
         BBQ9X+pn43MsY85OXIsSjEf96oduGXfneCPhCHEUZhePmddxgO0XpB9qG6bCutB2Ehip
         4Xi9S+ybeKVs+hOWPUdu13rDBhvo8jqUqAZ7hMABgX5fWoj+kIaSit9imjw7vuC+X92i
         Qd+h1SStwzy9GckOeaHu8hmbHFzgr2ylLadZY5fN1o9OJDVppPYDgii1i+M2PDFEaACD
         kfHgUTA8XcbQrAEaCESzH2PUMHcYzzJus6zzjRZW2j9KmxFasZljIhpdNaOWKJSlANC8
         +6EQ==
X-Gm-Message-State: ANoB5pk4qV/SjArVGThgwjw0hBIiCptB/nV9inEET/7MTCkcOHBDbDwN
        jzsby60eTDp4SCr59tjHiAzZYw63lz0=
X-Google-Smtp-Source: AA0mqf5M3klTPNqInMGHmEGoOifXPKwcPPVNaEcbnt7br2Oas0f3UdcPB0MBJkNut0EIG187KOSTUA==
X-Received: by 2002:a17:90a:e81:b0:212:c216:50c1 with SMTP id 1-20020a17090a0e8100b00212c21650c1mr3133895pjx.163.1668530802372;
        Tue, 15 Nov 2022 08:46:42 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b00186b945c0d1sm10138345plw.2.2022.11.15.08.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:46:42 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:16:37 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [bug report] bpf: Consolidate spin_lock, timer management into
 btf_record
Message-ID: <20221115164637.abhfdtcq6xu6h2xr@apollo>
References: <Y3OO0aZps7WeVpFA@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3OO0aZps7WeVpFA@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 06:36:25PM IST, Dan Carpenter wrote:
> [ Email screwup on my end means I have to resend two weeks of email.
>   :/  -dan ]
>
> Hello Kumar Kartikeya Dwivedi,
>
> The patch db559117828d: "bpf: Consolidate spin_lock, timer management
> into btf_record" from Nov 4, 2022, leads to the following Smatch
> static checker warning:
>
> 	kernel/bpf/syscall.c:1002 map_check_btf()
> 	warn: ignoring unreachable code.
>
> kernel/bpf/syscall.c
>     946 static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>     947                          u32 btf_key_id, u32 btf_value_id)
>     948 {
>     949         const struct btf_type *key_type, *value_type;
>     950         u32 key_size, value_size;
>     951         int ret = 0;
>     952
>     953         /* Some maps allow key to be unspecified. */
>     954         if (btf_key_id) {
>     955                 key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
>     956                 if (!key_type || key_size != map->key_size)
>     957                         return -EINVAL;
>     958         } else {
>     959                 key_type = btf_type_by_id(btf, 0);
>     960                 if (!map->ops->map_check_btf)
>     961                         return -EINVAL;
>     962         }
>     963
>     964         value_type = btf_type_id_size(btf, &btf_value_id, &value_size);
>     965         if (!value_type || value_size != map->value_size)
>     966                 return -EINVAL;
>     967
>     968         map->record = btf_parse_fields(btf, value_type, BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR,
>     969                                        map->value_size);
>     970         if (!IS_ERR_OR_NULL(map->record)) {
>     971                 int i;
>     972
>     973                 if (!bpf_capable()) {
>     974                         ret = -EPERM;
>     975                         goto free_map_tab;
>     976                 }
>     977                 if (map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG)) {
>     978                         ret = -EACCES;
>     979                         goto free_map_tab;
>     980                 }
>     981                 for (i = 0; i < sizeof(map->record->field_mask) * 8; i++) {
>     982                         switch (map->record->field_mask & (1 << i)) {
>     983                         case 0:
>     984                                 continue;
>     985                         case BPF_SPIN_LOCK:
>     986                                 if (map->map_type != BPF_MAP_TYPE_HASH &&
>     987                                     map->map_type != BPF_MAP_TYPE_ARRAY &&
>     988                                     map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
>     989                                     map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
>     990                                     map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
>     991                                     map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
>     992                                     map->map_type != BPF_MAP_TYPE_CGRP_STORAGE) {
>     993                                         ret = -EOPNOTSUPP;
>     994                                         goto free_map_tab;
>     995                                 }
>     996                                 break;
>     997                         case BPF_TIMER:
>     998                                 if (map->map_type != BPF_MAP_TYPE_HASH &&
>     999                                     map->map_type != BPF_MAP_TYPE_LRU_HASH &&
>     1000                                     map->map_type != BPF_MAP_TYPE_ARRAY) {
>     1001                                         return -EOPNOTSUPP;
>                                                  ^^^^^^^^^^^^^^^^^^^
> --> 1002                                         goto free_map_tab;
>
> s/return/ret =/
>
> Surprised the coverity-bot hasn't complained about this...
>

Thanks, another bad gaffe :/. Fixed locally, will push it out with v8.
