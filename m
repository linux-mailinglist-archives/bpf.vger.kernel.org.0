Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42AEEB62A
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2019 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfJaRbF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Oct 2019 13:31:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbfJaRbF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Oct 2019 13:31:05 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAF1385362
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2019 17:31:04 +0000 (UTC)
Received: by mail-lf1-f71.google.com with SMTP id r21so1597270lff.1
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2019 10:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=A98ZbpLN02ShHsjGWgvbK5h5LF9r2lohJMdJTRe83QQ=;
        b=C5ZmT9ASnUD9XDpLpl1SWPHAJj6mUnyDd4AqfX6pcJqIQkb2cXSEG/ucqVmktp6/tE
         RRecVWCs9bCVqWP8UqczVAZh/V4Gsz0X4pd1ZmfZGLzgNo0WItj9eas8Bmzscuknz2RC
         lCXF5oSk2aAQdUDQkeOtUuGZSRORby5jH/0c8MSahJtUMIsWs7PKpU0d6LWOMNc2Fdk1
         UnNOHcKynXblRBzQ0KDMH5kfQCPHuzn3gp+JZVvoDgiejNv3VYkJpwh26v2UjVmrwubC
         RA1PFuGX2DWHef7HgES30/gtSVU+0DNJ1YzZfZzKWYgJa6NbGzOz0lUjYLK+HQ8qbzkI
         tVvQ==
X-Gm-Message-State: APjAAAUTRe5ckuI1NDHI6KxTs+YWK0txgolPUYSflqWabL1FOT0sjXpZ
        ilozRfE4eYJBJTrznXf9NIPDY3u0KFq61P2b4fteE1gQ6hYHg9MEBR4iadZAwPWWH7zGmdx8E4E
        lO9c01CiehE1/
X-Received: by 2002:a19:ec02:: with SMTP id b2mr1416138lfa.121.1572543063424;
        Thu, 31 Oct 2019 10:31:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzuZ0u8TDe2F08iwASeJ9Xwym2M/KWxW+rywOa70uTTQU7n4oioBxCGIFSuTPr5r+A9CZdy8g==
X-Received: by 2002:a19:ec02:: with SMTP id b2mr1416122lfa.121.1572543063280;
        Thu, 31 Oct 2019 10:31:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id y6sm1386921ljm.95.2019.10.31.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 10:31:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 002561818B5; Thu, 31 Oct 2019 18:31:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/5] libbpf: Store map pin path and status in struct bpf_map
In-Reply-To: <CAEf4BzZ4pRLhwX+5Hh1jKsEhBAkrZbC14rBgAVgUt1gf3qJ+KQ@mail.gmail.com>
References: <157237796219.169521.2129132883251452764.stgit@toke.dk> <157237796448.169521.1399805620810530569.stgit@toke.dk> <CAEf4BzZ4pRLhwX+5Hh1jKsEhBAkrZbC14rBgAVgUt1gf3qJ+KQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 31 Oct 2019 18:31:01 +0100
Message-ID: <8736f8om96.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> [...]
>
>>
>>         return err;
>> @@ -4131,17 +4205,24 @@ int bpf_object__unpin_maps(struct bpf_object *obj, const char *path)
>>                 return -ENOENT;
>>
>>         bpf_object__for_each_map(map, obj) {
>> +               char *pin_path = NULL;
>>                 char buf[PATH_MAX];
>
> you can call buf as pin_path and get rid of extra pointer?

The idea here is to end up with bpf_map__unpin(map, NULL) if path is
unset. GCC complains if I reassign a static array pointer, so don't
think I can actually get rid of this?

-Toke
