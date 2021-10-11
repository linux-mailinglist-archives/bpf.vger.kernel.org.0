Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28FD4291B6
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbhJKO16 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 10:27:58 -0400
Received: from www62.your-server.de ([213.133.104.62]:59030 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbhJKO1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 10:27:45 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mZwFL-000CI8-QX; Mon, 11 Oct 2021 16:25:43 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mZwFL-0004dx-Kg; Mon, 11 Oct 2021 16:25:43 +0200
Subject: Re: [PATCH bpf-next] bpf: rename BTF_KIND_TAG to BTF_KIND_DECL_TAG
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com
References: <20211011040608.3031468-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c91ece3f-ec7e-bd3c-9b3d-19952b2d21e7@iogearbox.net>
Date:   Mon, 11 Oct 2021 16:25:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211011040608.3031468-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26319/Mon Oct 11 10:18:47 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/11/21 6:06 AM, Yonghong Song wrote:
> Patch set [1] introduced BTF_KIND_TAG to allow tagging
> declarations for struct/union, struct/union field, var, func
> and func arguments and these tags will be encoded into
> dwarf. They are also encoded to btf by llvm for the bpf target.
> 
> After BTF_KIND_TAG is introduced, we intended to use it
> for kernel __user attributes. But kernel __user is actually
> a type attribute. Upstream and internal discussion showed
> it is not a good idea to mix declaration attribute and
> type attribute. So we proposed to introduce btf_type_tag
> as a type attribute and existing btf_tag renamed to
> btf_decl_tag ([2]).
> 
> This patch renamed BTF_KIND_TAG to BTF_KIND_DECL_TAG and some
> other declarations with *_tag to *_decl_tag to make it clear
> the tag is for declaration. In the future, BTF_KIND_TYPE_TAG
> might be introduced per [2].
> 
>   [1] https://lore.kernel.org/bpf/20210914223004.244411-1-yhs@fb.com/
>   [2] https://reviews.llvm.org/D111199
> 

Just a small nit: no objections to the rename as its only in bpf-next, but
lets add proper Fixes tags to the three main commits from the series in [1]
(which adds it to core, libbpf, bpftool). Given these are in bpf-next, the
commit shas are more useful for searching in the git log compared to links
to lore in this case. Thanks!

> Signed-off-by: Yonghong Song <yhs@fb.com>
