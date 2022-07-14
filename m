Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008D57579D
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 00:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiGNW0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbiGNW0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 18:26:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DECD71BD3;
        Thu, 14 Jul 2022 15:26:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v16so4360969wrd.13;
        Thu, 14 Jul 2022 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:date:message-id:references
         :user-agent:mime-version;
        bh=f/f3T6jUqJ0Mvhpwmg1y16GyMNRqXtSKIrAiD1EFjtg=;
        b=qhieuNl3hKqRlVd70V/SrlenwctmlPx0DR8cRjSktE2mig3MvdXgUtJPOrH+PsbfnJ
         LyfmWgCakixjRzR4kKuQq3pe1h2b/Ld5htqsweRDiXBBx+8hYbIYGYyFyOmN+rvBuB7S
         qSATHlPJAn/e8ECe9uG11R/a5Mo16xIRbrQ/7YX+dGCsYyIt+RYHJR2Ft/aBtZ3TUyh/
         Ybd78QYtOUK7NRBBLtHJ6/QrdURnsih+7HqmYqwgcRs0cfoGpWCatkxLaAMuK8D0nywQ
         1KvdcC4UL93KbDdoSakpzzplPlTV+dJ7gEG6luK2yqW/XMYKU7RwA66N6xFGRnnrbU3p
         Hwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :references:user-agent:mime-version;
        bh=f/f3T6jUqJ0Mvhpwmg1y16GyMNRqXtSKIrAiD1EFjtg=;
        b=hT0MB6KD5/NhsDaDUDsgEB1a6ae2RoZIVWbGLhn9iZbTQc5m/uxYsdnEdIOEZNCd9v
         //LW5TcE1ACoPeJqW8FqpDYy0Xxm4RZMMGMAY5yy5JDbMoIwhNZVPxnhTSGJwA94wH7W
         FENEJzDmSDmmDino1VLO28NuLmGGy6OD+JoHya+5b/2R3VN9Dw15sZQUoKqRB7RI32R1
         fhMsAEiC9ec9BRT1/awAs1h5HMj/a5f6wAPWIhuPdNfNMSvgUqeVEZ+VXMcjhT1YTMkm
         kF1icUS4TlyW1zarkrNYO9iVlzRq81gfs2SmF29N22+xXM9zeuTJnBi64KR5lBcj/3tX
         w4vA==
X-Gm-Message-State: AJIora/YUpTpHg9Olc1kWraG3Fq2PVXWRGpZWBwk+jlA1w2WHhihT9pD
        rjrw1P/xgDq7gZrzKQED06U=
X-Google-Smtp-Source: AGRyM1vr58d/HoZjvLczDkWjVBVTrPC+nAbTIjxSRYaGzphc8WuitomVAG98+H8KhPuggMs+IBQVEQ==
X-Received: by 2002:a5d:6504:0:b0:21d:7376:6411 with SMTP id x4-20020a5d6504000000b0021d73766411mr9949513wru.512.1657837599666;
        Thu, 14 Jul 2022 15:26:39 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:7cd7:ddd5:b3c7:3e26])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bcb86000000b003a2d6f26babsm3177376wmi.3.2022.07.14.15.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 15:26:39 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] bpf, docs: document BPF_MAP_TYPE_HASH and variants
In-Reply-To: <Ys9VhwanEB/T8/Ue@google.com> (sdf@google.com's message of "Wed,
        13 Jul 2022 16:30:15 -0700")
Date:   Thu, 14 Jul 2022 23:20:23 +0100
Message-ID: <m2y1wv2v6g.fsf@gmail.com>
References: <20220713211612.84782-1-donald.hunter@gmail.com>
        <Ys9VhwanEB/T8/Ue@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sdf@google.com writes:
>> +``BPF_MAP_TYPE_HASH`` and ``BPF_MAP_TYPE_PERCPU_HASH`` provide general
>> +purpose hash map storage. Both the key and the value can be structs,
>> +allowing for composite keys and values. The maximum number of entries is
>> +defined in max_entries and is limited to 2^32. The kernel is responsible
>
> Do we really need to mention 2^32 limit here? It really depends on
> the key/value sizes, right?
>
> Instead, might be worth talking about how/when this memory is allocated and
> mention BPF_F_NO_PREALLOC?

Good suggestion. I'll incorporate this into v2.

>> +.. c:function::
>> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const  void *value, u60
>> flags)
>
> s/u60/u64/

Good catch, thanks.

>> +Kernel
>> +------
>> +
>> +.. code-block:: c
>> +
>> +    #include <linux/bpf.h>
>> +    #include <bpf/bpf_helpers.h>
>> +
>> +    struct key {
>> +        __u32 srcip;
>> +    };
>> +
>> +    struct value {
>> +        __u64 packets;
>> +        __u64 bytes;
>> +    };
>> +
>> +    struct {
>> +            __uint(type, BPF_MAP_TYPE_LRU_HASH);
>> +            __uint(max_entries, 32);
>> +            __type(key, struct key);
>> +            __type(value, struct value);
>> +    } packet_stats SEC(".maps");
>> +
>> +    static inline void count_by_srcip(__u32 srcip, int bytes)
>> +    {
>> +            struct key key = {
>> +                    .srcip = srcip
>> +            };
>> +            struct value *value = bpf_map_lookup_elem(&packet_stats,  &key);
>> +            if (value) {
>> +                    __sync_fetch_and_add(&value->packets, 1);
>> +                    __sync_fetch_and_add(&value->bytes, bytes);
>> +            } else {
>> +                    struct value newval = { 1, bytes };
>> +                    bpf_map_update_elem(&packet_stats, &key, &newval,  BPF_NOEXIST);
>> +            }
>> +    }
>> +
>> +Userspace
>> +---------
>> +
>> +.. code-block:: c
>> +
>> +    #include <bpf/libbpf.h>
>> +    #include <bpf/bpf.h>
>> +
>> +    static void print_values(int map_fd)
>> +    {
>> +            struct key *cur_key = NULL;
>> +            struct key next_key;
>> +            int next;
>> +            do {
>> +                    next = bpf_map_get_next_key(stats_fd, cur_key,  &next_key);
>> +                    if (next == -ENOENT)
>> +                            break;
>> +                    if (next < 0) {
>> +                            fprintf(stderr, "bpf_map_get_next_key %d  returned %s\n",
>> stats_fd, strerror(-next));
>> +                            break;
>> +                    }
>> +
>> +                    struct in_addr src_addr = {
>> +                            .s_addr = next_key.srcip
>> +                    };
>> +                    char *src_ip = inet_ntoa(src_addr);
>> +
>> +                    struct value value;
>> +                    int ret = bpf_map_lookup_elem(stats_fd, &next_key,  &value);
>> +                    if (ret < 0) {
>> +                            fprintf(stderr, "Failed to lookup elem with  key %s: %s\n",
>> src_ip, strerror(-ret));
>> +                            break;
>> +                    }
>> +                    printf("%s: %lld packets, %lld bytes\n", src_ip,  value.packets,
>> value.bytes);
>> +                    cur_key = &next_key;
>> +            } while (next == 0);
>> +    }
>
> Instead of adding c code, maybe add pointers to specific file within
> tools/testing/selftests/bpf/progs ? That's what we've done for
> prog_cgroup_sockopt; the actual tests are a bit more maintained than
> the doc :-)

I tried to cut the examples to the minimum that was still complete
enough to show use in context. Happy to try cutting the examples down to
a sequence of shorter snippets and and links to samples/bpf and
tools/testing/selftests/bpf/progs. I'll need to reference samples/bpf
because there are no bpf_map_get_next_key examples in
tools/testing/selftests/bpf/progs.

Donald.
