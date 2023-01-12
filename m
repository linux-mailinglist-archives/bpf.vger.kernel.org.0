Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021E7668545
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 22:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjALV0K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 16:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbjALVZr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 16:25:47 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9EB81C31
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 13:05:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 18so28602971edw.7
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 13:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4rKqmSaUi/fgFgZKqCD43R9BqnhvoDRAdLiLx1zzho=;
        b=q5Y5sVlsmv4pp2gjVJj7zhqU8/Dy3T4UMHa2X5vNAGGq0qAqZtLhuYAHMdp3MUvTCa
         ppJtSUqxieN5rr7457qjsH+zzwaAmfxg/NpIYgwlE8pmK8yUHuK3QKadnrtHRlTI8ShN
         c7DbEirMN8KdOKgLVt6+odaPqKpRASDHZyB3meFXjRd1XxTKTAt1g1qn7LSxsHTVhJqP
         M84Y9M8Ir2dpvXqlSHHmzP0JHgFMgZ4YPRVbcRjxWwRzoYM9zjyE5AgNhq9nXaYLHv4o
         UlkKwqri454kY2vN9QguAzIjyCO6+On3QeiH31/4txjf82aG+Y4rpCeOoBmAF1msc940
         N9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4rKqmSaUi/fgFgZKqCD43R9BqnhvoDRAdLiLx1zzho=;
        b=j1gnxQxzSmNoChjUaHtWnbUFcve3zJd8ShwE5ktZ6TttShiLEWgBxedxc6UfnTjYwM
         E4XTu4aZI65Px04ugkgV2tZL7v9irzsd/wJkmghYlndABMsW8dWiPlmCaQLwHI3QMwfY
         2wipAO6a3V47EJS7QQdl1RqYYetukrnzg2BR+fs5w2Gd904FGpiv5w/Ub0KdVV/GiFDJ
         Jq0Mvdq3iYYoZM5vCFO1SHN4BYyMMY/NVKOHq/ZmJlHpIvclOnxRo8Aed79pDK4EDmAs
         E17aSk172Qocm5UVPPHCHP5tMq7bRvjtXDZLQn/iHooJ4rcnj8DMf7HbS7fUu31B+AEe
         kAvQ==
X-Gm-Message-State: AFqh2kpguGmT59/FPmR4S1o9HmvClSxvnCeTRCmHigWHysCI2L4CLUlK
        ncBLgQEGOmYnf7KHiK4jrRqfhQHpiEkEQM4TOK4=
X-Google-Smtp-Source: AMrXdXvTTLRYRuFlvv3A4QLSVprqV9sqm0TJBbNgep/gV8dsrl1n+DCm0DJavRFJovdEhqB52wiXcp5i8SBUPIGlAGA=
X-Received: by 2002:aa7:c94b:0:b0:499:bfa7:832d with SMTP id
 h11-20020aa7c94b000000b00499bfa7832dmr1728379edt.338.1673557529158; Thu, 12
 Jan 2023 13:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20230112155326.26902-1-laoar.shao@gmail.com>
In-Reply-To: <20230112155326.26902-1-laoar.shao@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 12 Jan 2023 13:05:17 -0800
Message-ID: <CAADnVQJie8jSNxEio9iu6oXBkXyCjCg6h2mHssPv4mDHubWTwA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 00/11] mm, bpf: Add BPF into /proc/meminfo
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Tejun Heo <tj@kernel.org>, dennis@kernel.org,
        Chris Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 12, 2023 at 7:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Currently there's no way to get BPF memory usage, while we can only
> estimate the usage by bpftool or memcg, both of which are not reliable.
>
> - bpftool
>   `bpftool {map,prog} show` can show us the memlock of each map and
>   prog, but the memlock is vary from the real memory size. The memlock
>   of a bpf object is approximately
>   `round_up(key_size + value_size, 8) * max_entries`,
>   so 1) it can't apply to the non-preallocated bpf map which may
>   increase or decrease the real memory size dynamically. 2) the element
>   size of some bpf map is not `key_size + value_size`, for example the
>   element size of htab is
>   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
>   That said the differece between these two values may be very great if
>   the key_size and value_size is small. For example in my verifaction,
>   the size of memlock and real memory of a preallocated hash map are,
>
>   $ grep BPF /proc/meminfo
>   BPF:                 350 kB  <<< the size of preallocated memalloc pool
>
>   (create hash map)
>
>   $ bpftool map show
>   41549: hash  name count_map  flags 0x0
>         key 4B  value 4B  max_entries 1048576  memlock 8388608B
>
>   $ grep BPF /proc/meminfo
>   BPF:               82284 kB
>
>   So the real memory size is $((82284 - 350)) which is 81934 kB
>   while the memlock is only 8192 kB.

hashmap with key 4b and value 4b looks artificial to me,
but since you're concerned with accuracy of bpftool reporting,
please fix the estimation in bpf_map_memory_footprint().
You're correct that:

> size of some bpf map is not `key_size + value_size`, for example the
>   element size of htab is
>   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`

So just teach bpf_map_memory_footprint() to do this more accurately.
Add bucket size to it as well.
Make it even more accurate with prealloc vs not.
Much simpler change than adding run-time overhead to every alloc/free
on bpf side.

Higher level point:
bpf side tracks all of its allocation. There is no need to do that
in generic mm side.
Exposing an aggregated single number if /proc/meminfo also looks wrong.
People should be able to "bpftool map show|awk sum of fields"
and get the same number.
