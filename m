Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8674E6572
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2019 21:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfJ0UzX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Oct 2019 16:55:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32832 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727913AbfJ0UzX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Oct 2019 16:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572209721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeHUYCK/IlKxUH3CfOmqQ3rs9pcC2CQcmpmIoy5aShA=;
        b=i7HCSxm1M/6LtMtr3z6ZlsCUgaVbp9pSYAAmIN3iKtxjeivsgM85tudzQNvdhS4R5f7+Nm
        nNpQgQVNKFUrcT6htXjAzcwTY+or9soam+qyTjAIbK0a9+aIb4w0ATime7BqGK//nR794L
        WSBfn6yZFtn0aWEE/LNb+/j3QIzD6vU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-4IsADKQuOMKmWrTgghqZUQ-1; Sun, 27 Oct 2019 16:55:18 -0400
Received: by mail-lf1-f70.google.com with SMTP id o2so1434737lfb.12
        for <bpf@vger.kernel.org>; Sun, 27 Oct 2019 13:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YeHUYCK/IlKxUH3CfOmqQ3rs9pcC2CQcmpmIoy5aShA=;
        b=pgP80c4+10QMt9lN1HmQhyQTmA1c5h+I2DnQNb4PP54V96cXboXo8fUg1lQFbzfe09
         haPDMknYx1sUV8hAOtES/HWy8grxg60vHm9ayu9dtgjyUE+xZYRZvy7bPa9a4ksipO9M
         tSDeZOYNwzgeuheqyLioTyTzC5wbo+9JpqpRYUfhlzDpnEeb9yMG30aXyLnRNGqNKZHT
         sSLFSvUuwJ78wtX0kLDsWiVHHzqX+8TD1e2KDzvUgln2sqAtau1y0K7WEmpnTDY3n/M8
         F+lkLSFa7lH3oAcfZnSwf2JSifycSU+G1XQx3MVO2gDNnRu6YdtaN1nkNdEQGqPtSoiR
         ofiQ==
X-Gm-Message-State: APjAAAXzkgGh68fOgSqr8dRheIb1wsTWTdICZ25fLAmRnxrYyyKVQR4O
        o8N08ThS5VQBl9MXhMFnxslUvuIIJv5btGe8Qg2DYfxgTbgSewogQy/aqCYTs7aDPjVeE9p9aC0
        OWIGh1krwl+51
X-Received: by 2002:a2e:9cc9:: with SMTP id g9mr9290432ljj.188.1572209717128;
        Sun, 27 Oct 2019 13:55:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8FZtSydpSq2B0agUrJg7VC+Rb3bBR6I8HYekHP5er16FCw9Rq8EupBGmuyRy55z6PpS6gSw==
X-Received: by 2002:a2e:9cc9:: with SMTP id g9mr9290421ljj.188.1572209716984;
        Sun, 27 Oct 2019 13:55:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v10sm2040801lji.46.2019.10.27.13.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 13:55:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 738191818B6; Sun, 27 Oct 2019 21:55:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Add libbpf_set_log_level() function to adjust logging
In-Reply-To: <CAEf4BzYC6U-QC48nRkicb9YHNt+6xPkQAmTZcoEFt+u_vkExYw@mail.gmail.com>
References: <20191024132107.237336-1-toke@redhat.com> <CAEf4BzZAutRXf+W+ExaHjFMtWCfot9HkTWZNGuPckBiXqFcJeQ@mail.gmail.com> <87sgnejvij.fsf@toke.dk> <CAEf4BzYC6U-QC48nRkicb9YHNt+6xPkQAmTZcoEFt+u_vkExYw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 27 Oct 2019 21:55:15 +0100
Message-ID: <87r22xsybw.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 4IsADKQuOMKmWrTgghqZUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Sun, Oct 27, 2019 at 4:08 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Fri, Oct 25, 2019 at 4:50 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
>> >>
>> >> Currently, the only way to change the logging output of libbpf is to
>> >> override the print function with libbpf_set_print(). This is somewhat
>> >> cumbersome if one just wants to change the logging level (e.g., to en=
able
>> >
>> > No, it's not.
>>
>> Yes, it is :)
>
> As much fun as it is to keep exchanging subjective statements, I won't
> do that.

Heh, yeah. Even though I think the current behaviour is incredibly
annoying, it's also somewhat of a bikeshedding issue, so let's just
agree to disagree on this, drop this patch and move on :)

-Toke

