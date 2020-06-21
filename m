Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FF8202829
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 05:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgFUD11 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Jun 2020 23:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgFUD10 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Jun 2020 23:27:26 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF8C061794
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 20:27:25 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i18so1581283ilk.10
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 20:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mDm5wYbsxXJPy3ZYOnc7NYQTSU2kDDN7q1zj63e1s2c=;
        b=nWwqJW8Hdy2tTNnyq6AOfbJ3dsnRGgX1dJ+JMZlvczDwCn7CCZkKTSNFVqry/CcjSj
         hCCDpgWApJm6vEu8oFognBoyIz6DbO8Dz9spGuBx/sXYXiw2f6PLtg5c/cnRcOFQyUXd
         4BSOoOVLpQ/Agh+KUjb0Iqx6wLU0Lwlk65K8b56EA2/LiPbqeJpshQtG9eyUMcLbDT5d
         Vj0EracCa6kE4pwr062lu2m71hOl1NnadjsLtW0GkTRLg7I5qzYJem9G4tcnXvbV5U7g
         58J7z7s3nb8GY/zHwv5NJ3VSY+PCsFeM0sdgREtU1nW1ywSGKdynyX2xDbRQcQD1MB0F
         PVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mDm5wYbsxXJPy3ZYOnc7NYQTSU2kDDN7q1zj63e1s2c=;
        b=oeWJA1y3vg1VlnGc/v4hI86x0pukleAUulNOUyGByjQpsDy3XTaQ3ZC8jaxGDkOql3
         43VBwTqYx8ZFuvTVdJmTou1xqDCDNLAVv2DawR2GwS4HsmokvwlvDHH+eLLUlouGO7gE
         5oj7zjujleThV3Sl6VyEHSA0AIxpqUF5pqmLjgbcHE7PRze3aT0p+0fawxkCYdaewTdG
         PIhe4MGR2VzAqtSnFmLuFwI67pZ7Oebo+tEKD5oBgKyfhoqi+5zKG7k8d4v24VuB/kb/
         bCuELpfP7YTEijR1H8nPhLubkMuzr0P7LdntfjrlLfcXyH0QpGDayMO/Il6sr4qnsbp6
         jwJg==
X-Gm-Message-State: AOAM533BYG1Xkp9oDJxMpai+Xg2W2F/JXjT2OfrML4ModKlbFBwC4P8S
        TTGs5DAsx4irJ3IzBScfGV8=
X-Google-Smtp-Source: ABdhPJwBBDNpLRbcqJg/0ftfAluV7T+DmMQ/aRSxVPwAxA1O5RknYXKJCq8LI/DHnE/cxsnVLsO0tA==
X-Received: by 2002:a92:506:: with SMTP id q6mr11207458ile.107.1592710044443;
        Sat, 20 Jun 2020 20:27:24 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id d13sm5678761ilo.40.2020.06.20.20.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 20:27:23 -0700 (PDT)
Date:   Sat, 20 Jun 2020 20:27:15 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     Andrey Ignatov <rdna@fb.com>, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, andriin@fb.com, kernel-team@fb.com
Message-ID: <5eeed39388e0d_38742acbd4fa45b89b@john-XPS-13-9370.notmuch>
In-Reply-To: <6479686a0cd1e9067993df57b4c3eef0e276fec9.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
 <6479686a0cd1e9067993df57b4c3eef0e276fec9.1592600985.git.rdna@fb.com>
Subject: RE: [PATCH v2 bpf-next 3/5] bpf: Support access to bpf map fields
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey Ignatov wrote:
> There are multiple use-cases when it's convenient to have access to bpf
> map fields, both `struct bpf_map` and map type specific struct-s such as
> `struct bpf_array`, `struct bpf_htab`, etc.
> 
> For example while working with sock arrays it can be necessary to
> calculate the key based on map->max_entries (some_hash % max_entries).
> Currently this is solved by communicating max_entries via "out-of-band"
> channel, e.g. via additional map with known key to get info about target
> map. That works, but is not very convenient and error-prone while
> working with many maps.
> 
> In other cases necessary data is dynamic (i.e. unknown at loading time)
> and it's impossible to get it at all. For example while working with a
> hash table it can be convenient to know how much capacity is already
> used (bpf_htab.count.counter for BPF_F_NO_PREALLOC case).
> 
> At the same time kernel knows this info and can provide it to bpf
> program.
> 
> Fill this gap by adding support to access bpf map fields from bpf
> program for both `struct bpf_map` and map type specific fields.
> 
> Support is implemented via btf_struct_access() so that a user can define
> their own `struct bpf_map` or map type specific struct in their program
> with only necessary fields and preserve_access_index attribute, cast a
> map to this struct and use a field.
> 
> For example:
> 
> 	struct bpf_map {
> 		__u32 max_entries;
> 	} __attribute__((preserve_access_index));
> 
> 	struct bpf_array {
> 		struct bpf_map map;
> 		__u32 elem_size;
> 	} __attribute__((preserve_access_index));
> 
> 	struct {
> 		__uint(type, BPF_MAP_TYPE_ARRAY);
> 		__uint(max_entries, 4);
> 		__type(key, __u32);
> 		__type(value, __u32);
> 	} m_array SEC(".maps");
> 
> 	SEC("cgroup_skb/egress")
> 	int cg_skb(void *ctx)
> 	{
> 		struct bpf_array *array = (struct bpf_array *)&m_array;
> 		struct bpf_map *map = (struct bpf_map *)&m_array;
> 
> 		/* .. use map->max_entries or array->map.max_entries .. */
> 	}
> 
> Similarly to other btf_struct_access() use-cases (e.g. struct tcp_sock
> in net/ipv4/bpf_tcp_ca.c) the patch allows access to any fields of
> corresponding struct. Only reading from map fields is supported.
> 
> For btf_struct_access() to work there should be a way to know btf id of
> a struct that corresponds to a map type. To get btf id there should be a
> way to get a stringified name of map-specific struct, such as
> "bpf_array", "bpf_htab", etc for a map type. Two new fields are added to
> `struct bpf_map_ops` to handle it:
> * .map_btf_name keeps a btf name of a struct returned by map_alloc();
> * .map_btf_id is used to cache btf id of that struct.
> 
> To make btf ids calculation cheaper they're calculated once while
> preparing btf_vmlinux and cached same way as it's done for btf_id field
> of `struct bpf_func_proto`
> 
> While calculating btf ids, struct names are NOT checked for collision.
> Collisions will be checked as a part of the work to prepare btf ids used
> in verifier in compile time that should land soon. The only known
> collision for `struct bpf_htab` (kernel/bpf/hashtab.c vs
> net/core/sock_map.c) was fixed earlier.
> 
> Both new fields .map_btf_name and .map_btf_id must be set for a map type
> for the feature to work. If neither is set for a map type, verifier will
> return ENOTSUPP on a try to access map_ptr of corresponding type. If
> just one of them set, it's verifier misconfiguration.
> 
> Only `struct bpf_array` for BPF_MAP_TYPE_ARRAY and `struct bpf_htab` for
> BPF_MAP_TYPE_HASH are supported by this patch. Other map types will be
> supported separately.
> 
> The feature is available only for CONFIG_DEBUG_INFO_BTF=y and gated by
> perfmon_capable() so that unpriv programs won't have access to bpf map
> fields.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  include/linux/bpf.h                           |  9 ++
>  include/linux/bpf_verifier.h                  |  1 +
>  kernel/bpf/arraymap.c                         |  3 +
>  kernel/bpf/btf.c                              | 40 +++++++++
>  kernel/bpf/hashtab.c                          |  3 +
>  kernel/bpf/verifier.c                         | 82 +++++++++++++++++--
>  .../selftests/bpf/verifier/map_ptr_mixing.c   |  2 +-
>  7 files changed, 131 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 07052d44bca1..1e1501ee53ce 100644

LGTM, but any reason not to allow this with bpf_capable() it looks
useful for building load balancers which might not be related to
CAP_PERFMON.

Otherwise,

Acked-by: John Fastabend <john.fastabend@gmail.com>
