Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B712F5806
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 21:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbfKHUEP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Nov 2019 15:04:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbfKHUEP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 15:04:15 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 740C8C057F32
        for <bpf@vger.kernel.org>; Fri,  8 Nov 2019 20:04:14 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id i27so1520526ljb.17
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 12:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8PjjvIiZ6aE6Dpro+Lpqhvx8ZCU8Es2jgcO6SbHEpro=;
        b=JLRb2eyP4tQQXsklvyS0oqfQA5NTyziiXo9XaDTmgdC7rIR2z3Om5+NZ3ITrIsVeuF
         JdmWECXTpcJ6r7fXVnvUpuY31fJfdsMnDxll6gASn12N+iEQX9tW4BoCmHY3QdnkU079
         Lz9ZwT6mjef80ZllbEHiK9cWFsZs5piOIbhTn+onmxdBIZFNKOa1zF/O6jfIs5okDhDN
         vcUPYXMrmeF/BoG1ta1WvvDahtYzIq3+UGQU28/hzSQaElscGegz4zAlEAR9cpspOb9W
         aWcLCTP81JEfZrWSYY7QHux/KiDQUG9jsQh2s9k66/mijjuqaJYva5/bf0BCsT0GZ/ov
         TJQQ==
X-Gm-Message-State: APjAAAXLMU/PjWxedgDf1UBNDsxSdG7oLU4q6w4M/4Q5ZsQRV02g9Sip
        uGL+aZROt/sTWnucxq79D2nlltbzZ3ricqY8BOodiGjab47rYfTtEVVH5DBMMNcRTdpSyv2cQ0K
        xJc79h9X64lly
X-Received: by 2002:a05:651c:20a:: with SMTP id y10mr8012312ljn.76.1573243452956;
        Fri, 08 Nov 2019 12:04:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8CmwFfoGfo8L3dqS47x80bKzoMUDwZo1lM7uiqNiEZoolM1ut3wJvllfWuK3kAbXkZcUYVA==
X-Received: by 2002:a05:651c:20a:: with SMTP id y10mr8012293ljn.76.1573243452710;
        Fri, 08 Nov 2019 12:04:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id u27sm2819566lfl.34.2019.11.08.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:04:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2524F1818B6; Fri,  8 Nov 2019 21:04:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 5/6] libbpf: Add bpf_get_link_xdp_info() function to get more XDP information
In-Reply-To: <3C1D7121-8D90-4F30-964D-D684CAC3FFEA@fb.com>
References: <157314553801.693412.15522462897300280861.stgit@toke.dk> <157314554370.693412.2312326138964108684.stgit@toke.dk> <3C1D7121-8D90-4F30-964D-D684CAC3FFEA@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Nov 2019 21:04:11 +0100
Message-ID: <87r22iceys.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song Liu <songliubraving@fb.com> writes:

>> On Nov 7, 2019, at 8:52 AM, Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>> 
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> 
>> Currently, libbpf only provides a function to get a single ID for the XDP
>> program attached to the interface. However, it can be useful to get the
>> full set of program IDs attached, along with the attachment mode, in one
>> go. Add a new getter function to support this, using an extendible
>> structure to carry the information. Express the old bpf_get_link_id()
>> function in terms of the new function.
>> 
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>> tools/lib/bpf/libbpf.h   |   10 ++++++
>> tools/lib/bpf/libbpf.map |    1 +
>> tools/lib/bpf/netlink.c  |   78 ++++++++++++++++++++++++++++++----------------
>> 3 files changed, 62 insertions(+), 27 deletions(-)
>> 
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 6ddc0419337b..f0947cc949d2 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -427,8 +427,18 @@ LIBBPF_API int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
>> LIBBPF_API int bpf_prog_load(const char *file, enum bpf_prog_type type,
>> 			     struct bpf_object **pobj, int *prog_fd);
>> 
>> +struct xdp_link_info {
>> +	__u32 prog_id;
>> +	__u32 drv_prog_id;
>> +	__u32 hw_prog_id;
>> +	__u32 skb_prog_id;
>> +	__u8 attach_mode;
>> +};
>> +
>> LIBBPF_API int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags);
>> LIBBPF_API int bpf_get_link_xdp_id(int ifindex, __u32 *prog_id, __u32 flags);
>> +LIBBPF_API int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
>> +				     size_t info_size, __u32 flags);
>> 
>> struct perf_buffer;
>> 
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 86173cbb159d..45f229af2766 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -202,4 +202,5 @@ LIBBPF_0.0.6 {
>> 		bpf_program__get_type;
>> 		bpf_program__is_tracing;
>> 		bpf_program__set_tracing;
>> +		bpf_get_link_xdp_info;
>
> Please keep these entries in alphabetic order.

Huh, I could have sworn I already did that; will fix and re-send.

> Just found I added most out-of-order entries. :(
>
> Other than this
>
> Acked-by: Song Liu <songliubraving@fb.com>

Thanks for your review (of the whole series).
