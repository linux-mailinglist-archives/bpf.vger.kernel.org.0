Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB681354C0
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 09:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgAIIvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 03:51:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25098 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728792AbgAIIvD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Jan 2020 03:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578559861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWr6CdwBjc2lm2GdlX+0ljF22j2ZghSQ3T2YFBFAWYY=;
        b=D+vPrdzJ7UywmO66pYGyD4xbbLMnxuspWgvr+TYw8hYgs/kD7ifRfnelNWDXTeKqXacdEP
        KESSkzPPJZVZbWKyOguXur67EDQqrtXXUcUc/l7pXGF0e2dIrbxB/GdaPhdTsxxsnd6+N+
        y3MjfpOND02V4HiyHrwDboJYJO16lb4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-viSnM7UyMj-k9ev6PuPKyg-1; Thu, 09 Jan 2020 03:50:57 -0500
X-MC-Unique: viSnM7UyMj-k9ev6PuPKyg-1
Received: by mail-wr1-f72.google.com with SMTP id z15so2635283wrw.0
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2020 00:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VWr6CdwBjc2lm2GdlX+0ljF22j2ZghSQ3T2YFBFAWYY=;
        b=QGAlzLku13qsMQOrmYX+caTmfd7yiUxL8lBoz7PYV2G3I80HA/47diDn9/DaftmjdA
         +/FVjiP1EthUreH8NmN010iVUZZtZnbTzFcqgWZigtNwVqyjtIfQqWNwDLX4xfR3NXpu
         E6sJ6XKV/lZCrQtVy5/Pe6XS0LpXe8uZYI2PMsS0BEJDnaeWRsudO0AAHvwCBVW1eW6v
         HMAgsMoewNqX+0Zr747WdxwMjw/wbX1Hgapr/PEl6sOy1ldymXDNgNJjd6ekM3RoRcZD
         GwPW81TB31Q4pJ1Q9fd4rZ8Nl0KkPiepoih9lk4oz4T9n3doQqTaxPZLD1lzpERMt/ob
         XtcQ==
X-Gm-Message-State: APjAAAUdPyuBBtLpVxn11MitrQWBnQP0ZRXpkB80Nd5S2W+5vZsTQPqL
        v4T6Of1uI4aKnRiB4nIx4RDmv9BgBZJbm01YVtCXNXMOKpxVURXpB47mjpaco8Atv+PWZDX1vYe
        DNLM9FwmAxb9a
X-Received: by 2002:a5d:5592:: with SMTP id i18mr9035950wrv.55.1578559856505;
        Thu, 09 Jan 2020 00:50:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxi5Tx492/FZYofU8nhhT4P9n695WfkmFFPCfYFdpSpaHcxjbpxoCHChTdCbVojEn19L5fHA==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr9035923wrv.55.1578559856254;
        Thu, 09 Jan 2020 00:50:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l3sm7251246wrt.29.2020.01.09.00.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:50:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9D9F8180ADD; Thu,  9 Jan 2020 09:50:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        "davem\@davemloft.net" <davem@davemloft.net>
Cc:     "daniel\@iogearbox.net" <daniel@iogearbox.net>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: Collect static vs global info about functions
In-Reply-To: <89249a19-5fb9-86e3-925b-dbb03427f718@fb.com>
References: <20200108072538.3359838-1-ast@kernel.org> <20200108072538.3359838-3-ast@kernel.org> <871rsai6td.fsf@toke.dk> <89249a19-5fb9-86e3-925b-dbb03427f718@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 09 Jan 2020 09:50:53 +0100
Message-ID: <87imllggia.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 1/8/20 2:25 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Alexei Starovoitov <ast@kernel.org> writes:
>>=20
>>> Collect static vs global information about BPF functions from ELF file =
and
>>> improve BTF with this additional info if llvm is too old and doesn't em=
it it on
>>> its own.
>>=20
>> Has the support for this actually landed in LLVM yet? I tried grep'ing
>> in the commit log and couldn't find anything...
>
> It has not landed yet. The commit link is:
>     https://reviews.llvm.org/D71638
>
> I will try to land the patch in the next couple of days once this series
> of patch is merged or the principle of the patch is accepted.

OK. My next question was going to be whether you're planning to get this
into LLVM master before the cutoff date for LLVM10, but I see Alexei
already answered that in the other reply, so great!

-Toke

