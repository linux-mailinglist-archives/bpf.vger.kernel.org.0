Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020EE1279A2
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 11:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLTKuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 05:50:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39654 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbfLTKuW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Dec 2019 05:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576839021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zMpOOo3iufJ9ca6/YVFrdxmrvBnoxtNnRc6ySdLQkNQ=;
        b=HkuQSnhAvtOJTCGXuXjDjyLoUOUISo9E/XNngyhp/F0M0+Pjtt/llnK0TGVjamzdTU4eIf
        nS9oWdoWpfhWvZE+LrS1o/J45+TxqqJwREpk1Ulo7pypzbEc/WSeCtEfMwJQe3czFsUZnE
        +j5UO3GFrBavYVhMkLGXkUuwYFpwqjE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-ayoyuHTFMrSpruGUBhOy0A-1; Fri, 20 Dec 2019 05:50:19 -0500
X-MC-Unique: ayoyuHTFMrSpruGUBhOy0A-1
Received: by mail-lf1-f72.google.com with SMTP id h7so1056762lfp.20
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 02:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zMpOOo3iufJ9ca6/YVFrdxmrvBnoxtNnRc6ySdLQkNQ=;
        b=Bd8lVGNY3zeEPTmpr+c+nIsORGM1HeUEOIuJCn09yuyydhhwdWBm2tFsyHTiJ4zXcY
         YAJG8W2ZB1gMEUhqOgEWMe04b/pVqJOm81gMgzxTs9l3ksJWfFvl4kh/4E86FynjVBei
         08fMrnPLgw+8p/po3di6MAiMShLozvsQO6zlMzsIsDP5RkzPxLsIW4INQb1WbQdG6WIE
         UAXpEG22RNMBiNb6SxDaYEWs7YhqIeV65YZZWn5Rx10XGG75WXC4cq1VXFHPnu3YUD9+
         wW13sryAtbT1l4QvQCie3xkJcD86ufYFVovRVCVIwz5so+RkIwMyhZs+fTD4fJEA4Q0I
         dpUQ==
X-Gm-Message-State: APjAAAWay/M8vsM4jwtGaEIShZEr0aoUJQV+3+3L213drsixhGYgpEEj
        l+d5RqHCZ94j1UEGXwjILVf9lZbJYL42XYA8DDFikz8DRBWBBsnqu7Nz95usRdoJh6MsHLnhu9S
        N3Bap9GU3VaIo
X-Received: by 2002:a2e:721a:: with SMTP id n26mr9399422ljc.128.1576839018156;
        Fri, 20 Dec 2019 02:50:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWai7mH5bN6DUYqYikkEJa3ngKRJyCOOPV4p4up1n/uVniG9/nnEFiXV1TbCsg5IX8+FwN8w==
X-Received: by 2002:a2e:721a:: with SMTP id n26mr9399405ljc.128.1576839017992;
        Fri, 20 Dec 2019 02:50:17 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x21sm4010516ljd.2.2019.12.20.02.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 02:50:17 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 98282180969; Fri, 20 Dec 2019 11:50:16 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 1/3] libbpf: Add new bpf_object__load2() using new-style opts
In-Reply-To: <CAEf4BzYKpstQk8JO_iOws93VpHEEs+J+z+ZO7cKRiKRNvN1zMg@mail.gmail.com>
References: <157676577049.957277.3346427306600998172.stgit@toke.dk> <157676577159.957277.7471130922810004500.stgit@toke.dk> <CAEf4BzYKpstQk8JO_iOws93VpHEEs+J+z+ZO7cKRiKRNvN1zMg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 20 Dec 2019 11:50:16 +0100
Message-ID: <87eewz2rvb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Dec 19, 2019 at 6:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> Since we introduced DECLARE_LIBBPF_OPTS and related macros for declaring
>> function options, that is now the preferred way to extend APIs. Introduc=
e a
>> variant of the bpf_object__load() function that uses this function, and
>> deprecate the _xattr variant. Since all the good function names were tak=
en,
>> the new function is unimaginatively called bpf_object__load2().
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> I've been thinking about options for load quite a bit lately, and I'm
> leaning towards an opinion, that bpf_object__load() shouldn't take any
> options, and all the various per-bpf_object options have to be
> specified in bpf_object_open_opts and stored, if necessary for
> load/attach phase. So I'd rather move target_btf_path and log_level to
> open_opts instead.

Hmm, yeah, don't really object to that. I do think the 'log_level' is a
bit of an odd parameter in any case, though. If I turn on verbose
logging using the log_level parameter, that won't affect the logging of
libbpf itself, which was certainly surprising to me when I first
discovered it. So maybe rename it when adding it as an open option
("verbose_verifier" or something along those lines?).

Anyhow, given your idea with having a separate bpf_linker__() type, this
is not really needed for linking in any case, so I'll just drop this
patch for now...

-Toke

