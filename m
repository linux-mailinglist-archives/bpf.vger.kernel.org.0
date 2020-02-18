Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60265162ADF
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 17:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBRQmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Feb 2020 11:42:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37586 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbgBRQmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 11:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582044125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Da0a2vMsz34AthRKxQAElJS/XJmZChgUuBhVkkThmfM=;
        b=IQ3F72SgixdQZaAfI4LvEe36fXHlNkR3uULn7j7Omssi0XAEnhzpAm4IGU3KopXyHRNxN6
        4ysJ2+st4scmlvATuVI8xxMDWclFaeldtn7ah8Air1SqeErKhkFv9Kluf3lS6lSgsU84Mk
        mnVNJTvGPtdlXkyL4OwxCgOEb9dc0wA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-slvf6EgLPmCsayihjXWyuA-1; Tue, 18 Feb 2020 11:42:03 -0500
X-MC-Unique: slvf6EgLPmCsayihjXWyuA-1
Received: by mail-lj1-f200.google.com with SMTP id z2so7345193ljh.16
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 08:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Da0a2vMsz34AthRKxQAElJS/XJmZChgUuBhVkkThmfM=;
        b=dWN9krb1Ipf5H5EFKCXNy4MJLD0xI6zhZkqZAFh/ea1wRJiy4LzKz/NBFtlGNejmkT
         Xa1IUplgrDgb6r9Q7bMio2XnvQXnmaWpO0FwZfOBHPKpXz4Vu3kN+9O92DvnRTP3UJeN
         3MECsAY0L3zzHA2eZXQtjEgxtY0czZDQevTVu1Lpmef0K5zivKFSAcqw58rJofXv/GqW
         KbFPbvwGeGzFu09jSHtjAK2vH3z5eshASc+G7+n7sJSbdxCk+dmUxf8Vuu0RoWZT0yq2
         CioWexxGrZAHYi7S+krtlFFRPXwjSrA5oD6sgtTco5Mdvpf0Vxy+u7LPlkwzwq6X3up5
         XfKg==
X-Gm-Message-State: APjAAAVu03M3avcO9M5/LPsF+KOUfFUBpEYjjW0eLP+XqnzAylQP2bYt
        WgBI0z8A4Rn/moLYntAL98iQ/j6EnQ5OV6CTlCT/yylyIJz2b7fGSFu5Q5Do7otD3j+EMdMR61D
        8394FZ//xB4Tw
X-Received: by 2002:a2e:761a:: with SMTP id r26mr13717322ljc.135.1582044122175;
        Tue, 18 Feb 2020 08:42:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0fuWRuZpOiL5TQahKWr/7iSFU4gA7j8vSPrhDev9my/sJmZkObcwb4DCUACw44gNhVDzNIQ==
X-Received: by 2002:a2e:761a:: with SMTP id r26mr13717304ljc.135.1582044121946;
        Tue, 18 Feb 2020 08:42:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l22sm2841469ljb.2.2020.02.18.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 08:42:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3C9FC180365; Tue, 18 Feb 2020 17:42:00 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf] libbpf: Sanitise internal map names so they are not rejected by the kernel
In-Reply-To: <a0923745-ee34-3eb0-7f9b-31cec99661ec@fb.com>
References: <20200217171701.215215-1-toke@redhat.com> <9ddddbd6-aca2-61ae-b864-0f12d7fd33b4@iogearbox.net> <a0923745-ee34-3eb0-7f9b-31cec99661ec@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 18 Feb 2020 17:42:00 +0100
Message-ID: <87sgj7yhif.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 2/18/20 6:40 AM, Daniel Borkmann wrote:
>> On 2/17/20 6:17 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> The kernel only accepts map names with alphanumeric characters,=20
>>> underscores
>>> and periods in their name. However, the auto-generated internal map nam=
es
>>> used by libbpf takes their prefix from the user-supplied BPF object nam=
e,
>>> which has no such restriction. This can lead to "Invalid argument" erro=
rs
>>> when trying to load a BPF program using global variables.
>>>
>>> Fix this by sanitising the map names, replacing any non-allowed=20
>>> characters
>>> with underscores.
>>>
>>> Fixes: d859900c4c56 ("bpf, libbpf: support global data/bss/rodata=20
>>> sections")
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> Makes sense to me, applied, thanks! I presume you had something like '-'=
=20
>> in the
>> global var leading to rejection?
>
> The C global variable cannot have '-'. I saw a complain in bcc mailing=20
> list sometimes back like: if an object file is a-b.o, then we will=20
> generate a map name like a-b.bss for the bss ELF section data. The
> map name "a-b.bss" name will be rejected by the kernel. The workaround
> is to change object file name. Not sure whether this is the only
> issue which may introduce non [a-zA-Z0-9_] or not. But this patch indeed=
=20
> should fix the issue I just described.

Yes, this was exactly my problem; my object file is called
'xdp-dispatcher.o'. Fun error to track down :P

Why doesn't the kernel allow dashes in the name anyway?

-Toke

