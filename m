Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85A9DFE3B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 09:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbfJVH1K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 03:27:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57667 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387614AbfJVH1K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Oct 2019 03:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571729228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GT05HthJTrW7c4K3gTLDo8MsaDeqfweknqOj+D0OahU=;
        b=ObdwrLjb5/lTxOJvutuA25XjwLw71h/l73b4EPWvSSih6fXjJ1jzeffCNOdK7xRtfvgXCZ
        Vq4OwW8gBrnVZpC0q7jPBx1/8fSOhuuVEF54SXuBRS+mHC7OEkEEbzDCYeqrQGUSeailwF
        RPLyVv1gVmWtFglrf2p3UcW3JZDccyI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-lbpzgxa1PCiSJujFOXfjbQ-1; Tue, 22 Oct 2019 03:27:07 -0400
Received: by mail-wm1-f71.google.com with SMTP id b10so1682910wmh.6
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 00:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=V40UFYPSkCXYwl4O4Et5hQgR3UAKLwpf6CRuPrVQy1M=;
        b=gSZrWVuwDiPqf+pcYtzX2E0GkhAKO2mSVn9FBkvS8X18Qsp5eDYQwEcU445DZpH/Ap
         HRKJtmsfUjAH12kP6vABqdaiH/+nqaR4514+a2Wpf7g48Mr0XTTyqK3BQGFmkwpeuEqc
         FT8lDNk7NZpXxFBL0d414gS4dCdaBSjsPjLqJUquu4INRPKZY2NgY0TzEFL+aarq97Wx
         Fc1PxcVnHF7RIHJhOsG7DEzq0oYha8/HxXFbWz4Us12MO3Rp5UpK1pMc5yTmGMQhpfaE
         P5fhalM+3uSwb/h0oMfdx56GIH/YbVi3FqasXMnxIZC2wfwFfI7jJwEcJK8vGwcVk0o6
         QDFA==
X-Gm-Message-State: APjAAAWwQahXAiLRBYcyoTZv/eQGsBpk06Yw2F3pXSwfwurNoPE/DgVS
        90ggsDcOMAzeUxBTAwyEYKX6An2T3uJ1HVDd6Dab+3XpM27kKfkknzVF+6U9GPN3Pnupruhske1
        QA9rbS2T1CXFw
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr1596506wmk.126.1571729226414;
        Tue, 22 Oct 2019 00:27:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz2+PmYOvcKorzPwbtDvaLtXey5ex4I0xMrb5/iQdcke+WfKoxqxrnP4elZhngmygWjuRKrUA==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr1596478wmk.126.1571729226173;
        Tue, 22 Oct 2019 00:27:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a4sm16742655wmm.10.2019.10.22.00.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 00:27:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E62C51804B1; Tue, 22 Oct 2019 09:27:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] libbpf: make LIBBPF_OPTS macro strictly a variable declaration
In-Reply-To: <CAEf4BzaWEJ1t-4rB9ZftiSEdSBToAjFvnheo2z+H+OsG=BqZzA@mail.gmail.com>
References: <20191021165744.2116648-1-andriin@fb.com> <87mudtdisk.fsf@cloudflare.com> <CAEf4BzaWEJ1t-4rB9ZftiSEdSBToAjFvnheo2z+H+OsG=BqZzA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 09:27:04 +0200
Message-ID: <87imohp7ef.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: lbpzgxa1PCiSJujFOXfjbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Oct 21, 2019 at 12:01 PM Jakub Sitnicki <jakub@cloudflare.com> wr=
ote:
>>
>> On Mon, Oct 21, 2019 at 06:57 PM CEST, Andrii Nakryiko wrote:
>> > LIBBPF_OPTS is implemented as a mix of field declaration and memset
>> > + assignment. This makes it neither variable declaration nor purely
>> > statements, which is a problem, because you can't mix it with either
>> > other variable declarations nor other function statements, because C90
>> > compiler mode emits warning on mixing all that together.
>> >
>> > This patch changes LIBBPF_OPTS into a strictly declaration of variable
>> > and solves this problem, as can be seen in case of bpftool, which
>> > previously would emit compiler warning, if done this way (LIBBPF_OPTS =
as
>> > part of function variables declaration block).
>> >
>> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>> > ---
>>
>> Just a suggestion - macro helpers like this usually have DECLARE in
>> their name. At least in the kernel. For instance DECLARE_COMPLETION.
>
> Yes, it makes sense. This will cause some extra code churn, but it's
> not too late. Will rename in v2 and fix current usages.

While you're respinning, maybe add a comment explaining what it is
you're doing? It certainly broke the C parser in my head, so maybe a
hint would be good for others as well :)

-Toke

