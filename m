Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650D7204288
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgFVVWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 17:22:32 -0400
Received: from www62.your-server.de ([213.133.104.62]:41734 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbgFVVWb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 17:22:31 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jnTtd-00056O-JS; Mon, 22 Jun 2020 23:22:29 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jnTtd-000E1q-BI; Mon, 22 Jun 2020 23:22:29 +0200
Subject: Re: [PATCH v2 bpf-next 0/5] bpf: Support access to bpf map fields
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, kafai@fb.com, andriin@fb.com, kernel-team@fb.com
References: <cover.1592600985.git.rdna@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <078165b0-dd60-4ab8-9ecb-b989b9ae6da0@iogearbox.net>
Date:   Mon, 22 Jun 2020 23:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1592600985.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25851/Mon Jun 22 15:09:36 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/19/20 11:11 PM, Andrey Ignatov wrote:
> v1->v2:
> - move btf id cache to a new bpf_map_ops.map_btf_id field (Martin, Andrii);
> - don't check btf names for collisions (Martin);
> - drop btf_find_by_name_kind_next() patch since it was needed only for
>    collision check;
> - don't fall back to `struct bpf_map` if a map type doesn't specify both
>    map_btf_name and map_btf_id;
> 
> This patch set adds support to access bpf map fields from bpf programs
> using btf_struct_access().
> 
> That way a program can cast a pointer to map to either `struct bpf_map *`
> or map type specific struct pointer such as `struct bpf_array *` or
> `struct bpf_htab *`, and access necessary fields, e.g. map->max_entries.
> 
> The fields, in turn, should be defined by a user provided struct with
> preserve_access_index attribute or included from vmlinux.h.
> 
> Please see patch 3 for more details on the feature and use-cases.
> 
> Other patches:
> 
> Patch 1 is refactoring to simplify btf_parse_vmlinux().
> Patch 2 is a rename to avoid having two different `struct bpf_htab`.
> 
> Patch 4 enables access to map fields for all map types.
> Patch 5 adds selftests.
> 

Applied, thanks!
