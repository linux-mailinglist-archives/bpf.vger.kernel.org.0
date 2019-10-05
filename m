Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CCCCC95E
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2019 12:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfJEKa4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 5 Oct 2019 06:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfJEKaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Oct 2019 06:30:55 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 396308BE70
        for <bpf@vger.kernel.org>; Sat,  5 Oct 2019 10:30:55 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id i18so2358191ljg.14
        for <bpf@vger.kernel.org>; Sat, 05 Oct 2019 03:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0BTW7nl+H/XRQtnoJO4rjId8yr0bcribLIhknb5mLqw=;
        b=mdDUC+alFmJ23HF7hravFN+G7BpWnJ2aVE/RN5Xz77ehZcbo7m7KOlhXa4Kq3FK5Ux
         kPREbuU35UO+EzcdfiFozq3Cfqam0vahyHDQrLooSmypvGPSiemdBWcUpHW0Wf9MQF3C
         ua5vjTAq+5Xm6cTs0aU6oZAgVbrVHKOMPRRijkeHaKCzWvkH3YXOI8gGUHre6DOqH2Es
         3z4t0Tj4OtV8mU9l2mXLPOkfrWCDAKYpcJ9JAbqw0cbu3TwyUYEAmlOhUcPKA3BUA+Ia
         GZiFEhXPBlPtY6/jksF+8DVVYw8kLTLUFfOsbgHXvQBNJu4cLVxRAhl7aerXFUmXtx4S
         3Ycw==
X-Gm-Message-State: APjAAAU0cBXlJ+Y7Vr1LSG/Y5aE+iGr53aYM/bhesqMFo4o4Z2sjGONf
        DqQu37CsHZd+9uaZAXcMWLk1JDjyNruUzsIn1Run3ABAojKpFrLM3LNt9INujCaSSWELXaZqWbc
        t5aYs5QwE80aQ
X-Received: by 2002:a2e:9e8b:: with SMTP id f11mr8734636ljk.153.1570271453709;
        Sat, 05 Oct 2019 03:30:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyJyujM1Er185peAYODficBxekswVKPLsM3E8O4Zeu2pJ+E3A2prNs/g4ezxCnjlv2sPcVXWg==
X-Received: by 2002:a2e:9e8b:: with SMTP id f11mr8734625ljk.153.1570271453536;
        Sat, 05 Oct 2019 03:30:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a23sm1620173lfl.66.2019.10.05.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 03:30:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0182218063D; Sat,  5 Oct 2019 12:30:51 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Add support for setting chain call sequence for programs
In-Reply-To: <20191004161842.617b8bd8@cakuba.hsd1.ca.comcast.net>
References: <157020976030.1824887.7191033447861395957.stgit@alrua-x1> <157020976257.1824887.7683650534515359703.stgit@alrua-x1> <20191004161842.617b8bd8@cakuba.hsd1.ca.comcast.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 05 Oct 2019 12:30:51 +0200
Message-ID: <87a7afo55w.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <jakub.kicinski@netronome.com> writes:

> On Fri, 04 Oct 2019 19:22:42 +0200, Toke Høiland-Jørgensen wrote:
>> From: Alan Maguire <alan.maguire@oracle.com>
>> 
>> This adds support for setting and deleting bpf chain call programs through
>> a couple of new commands in the bpf() syscall. The CHAIN_ADD and CHAIN_DEL
>> commands take two eBPF program fds and a return code, and install the
>> 'next' program to be chain called after the 'prev' program if that program
>> returns 'retcode'. A retcode of -1 means "wildcard", so that the program
>> will be executed regardless of the previous program's return code.
>> 
>> 
>> The syscall command names are based on Alexei's prog_chain example[0],
>> which Alan helpfully rebased on current bpf-next. However, the logic and
>> program storage is obviously adapted to the execution logic in the previous
>> commit.
>> 
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=prog_chain&id=f54f45d00f91e083f6aec2abe35b6f0be52ae85b&context=15
>> 
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>
> It'd be good to explain why not just allocate a full prog array (or 
> in fact get one from the user), instead of having a hidden one which
> requires new command to interact with?

Because I consider the reuse of the prog array to be an implementation
detail that we may want to change later. Whereas if we expose it to
userspace it becomes API.

For instance, if we do end up wanting to have support directly in the
JIT for this, we could make the next progs just a linked list that the
JIT will walk and emit direct call instructions for each, instead of
doing the index-lookup.

-Toke
