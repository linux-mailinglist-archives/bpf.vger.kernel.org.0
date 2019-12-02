Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867B310EA4D
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2019 14:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBNCd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Dec 2019 08:02:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23363 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727382AbfLBNCc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Dec 2019 08:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575291751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wnZYQHNyF93TOuzpHzsjI/rl9jczeNd2hf1BHCa51L8=;
        b=aECf72bY9nlpzG9aK5TVQLpF58WFaj83NvMRnmSxMEbWIcP2WlEk3bB8oABbXdH2eS890Q
        nJ/5fUdS2SyLpv0RFiyfUCt/3mmzPZafsw33N6jeYvYXoHzIT1Tr+uMsqeEH3bo5Xi3mab
        bzx22eh6Zd4b6HEaAVjHA1N4AFUzJhs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-pI8cMc_pPF29OnANM_CiRg-1; Mon, 02 Dec 2019 08:02:30 -0500
Received: by mail-lf1-f70.google.com with SMTP id r187so3825924lff.21
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2019 05:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wnZYQHNyF93TOuzpHzsjI/rl9jczeNd2hf1BHCa51L8=;
        b=KwrHtdPysHMdMr4FJWu4mHeY08HiWw0m0eGrKM7/e6I3+n5O6prZEySoxgRCvdh1xC
         z5eVCp07I22O18E7jNv1p3IBs7B8Gvz5/SlPYeJ0hlg057l0Tyg11lQMqDOdrbYVIbTA
         dkpifjgCEQFLgfN/pJYJVHRI7x4d75ivfyiKnOvUUxpJRcoqRs8r9M4KWr6hQ4CPchFn
         8j1s2TdUJD+yJEiLV9UHMcgobdqZSLAnfrkV19PJfJAhk3+sq8Q7aECR98nmriiALft3
         zM4rml8ZpLw3ZSJdyV6IRQeZYFEKiSKOfuPD4LpgcYtrDBl+UQXzmIgU/mKrlrTp90k3
         SJwA==
X-Gm-Message-State: APjAAAUVRjVRvqBjL3iUdWvq2/yQeyoAw52eE21CHKcHoQzI6R/5Jezr
        T9873JrjpWUxZtrULs1TYNihlzRT1J9NTceJTo2jLLZcOZ+8KsYHfeHCcIwVeSv+psEErmwdEt8
        o4KQgX62275La
X-Received: by 2002:a05:651c:1066:: with SMTP id y6mr47130219ljm.96.1575291749495;
        Mon, 02 Dec 2019 05:02:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9rDXleedQx7EL3lXGtVOObHOfwWLrWorFA2PCi83Q4ChTqbLiZbDzrUkNFFwJzJoFQlZsvA==
X-Received: by 2002:a05:651c:1066:: with SMTP id y6mr47130185ljm.96.1575291749249;
        Mon, 02 Dec 2019 05:02:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u3sm9692949lfm.37.2019.12.02.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 05:02:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E1875181942; Mon,  2 Dec 2019 14:02:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     jakub.kicinski@netronome.com, netdev@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        danieltimlee@gmail.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [bpf PATCH] samples/bpf: fix broken xdp_rxq_info due to map order assumptions
In-Reply-To: <157529025128.29832.5953245340679936909.stgit@firesoul>
References: <157529025128.29832.5953245340679936909.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 02 Dec 2019 14:02:27 +0100
Message-ID: <87k17ericc.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: pI8cMc_pPF29OnANM_CiRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> In the days of using bpf_load.c the order in which the 'maps' sections
> were defines in BPF side (*_kern.c) file, were used by userspace side
> to identify the map via using the map order as an index. In effect the
> order-index is created based on the order the maps sections are stored
> in the ELF-object file, by the LLVM compiler.
>
> This have also carried over in libbpf via API bpf_map__next(NULL, obj)
> to extract maps in the order libbpf parsed the ELF-object file.
>
> When BTF based maps were introduced a new section type ".maps" were
> created. I found that the LLVM compiler doesn't create the ".maps"
> sections in the order they are defined in the C-file. The order in the
> ELF file is based on the order the map pointer is referenced in the code.
>
> This combination of changes lead to xdp_rxq_info mixing up the map
> file-descriptors in userspace, resulting in very broken behaviour, but
> without warning the user.
>
> This patch fix issue by instead using bpf_object__find_map_by_name()
> to find maps via their names. (Note, this is the ELF name, which can
> be longer than the name the kernel retains).
>
> Fixes: be5bca44aa6b ("samples: bpf: convert some XDP samples from bpf_loa=
d to libbpf")
> Fixes: 451d1dc886b5 ("samples: bpf: update map definition to new syntax B=
TF-defined map")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

