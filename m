Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFA3CB750
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 11:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfJDJ1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 05:27:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49936 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727611AbfJDJ1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 05:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570181251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjyer/U6Y+oiGKP2bVl8pCipiegwE7ie1YY+oAl4Nd8=;
        b=Y1Ste/pFC9k0jF/8YYyjFlvMO1fnlf8TjP8viPUNpeXpwkI6WEqzyiILNyp+dQbLC7WI/g
        wIqAlFrjksnAERB6zne3egTjM9tAq7M+hz9MxdZ/T5PBGsr4xpbeMirWrFBbjhlW8X0WTA
        bGzgmQsA1+4qR+U5KymOsKVgMeQ274o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-jFNt_a54MTeKY9BiIbZ4_A-1; Fri, 04 Oct 2019 05:27:30 -0400
Received: by mail-lj1-f197.google.com with SMTP id x13so1585037ljj.18
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 02:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qjyer/U6Y+oiGKP2bVl8pCipiegwE7ie1YY+oAl4Nd8=;
        b=ensN8ULyLEi7clhtn7s/irwmhz1wQ5VaLSibQouCRZeDHv26fIWWT0irpPd8scQaRI
         L7LmEVFSkIJP7I1DQdbgDGmwzuLXGrpXTamQkNJGq+SoWvblvzRJIh7Tm14g78CBrt8L
         nXj+AWzLr5mXmW8n9cG7Wonox+yHsf+jAw4npuYwesIpkIb7qoOgEilM89Iep91vremL
         pdTF/st+QPPYtnXDuUqiVcnXx2Glma94FIJ9r6j2cxj20t66bFTTLFN/Hiw7+8LLD9xC
         kqvRjLZLceWJ52aX/an59JDdGFkUQzvlxUTPjR08x7/Bnnro9PBaHtgCAOWUQsJAbtcD
         gh7Q==
X-Gm-Message-State: APjAAAU8NbjKc/hhw5jCycGZxTvTszTSVAR+DoGj6NfYt9d8NuwfeAlT
        67YHJRyT0k7/YXabGQnnAW5gtLZlAPFWGXB/1K34gYCUFJ9XLP+ELo1TbOLq9ouXjqvdjAHiTuQ
        8bJWiOFcZeTPN
X-Received: by 2002:a19:f801:: with SMTP id a1mr7640945lff.166.1570181248547;
        Fri, 04 Oct 2019 02:27:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz4lUtmSD5ClS+953q4DT2fCMfMovRljQn5aBweEWopaCUX8Z6KB6FkEjjJwU/dDbldhtVTqQ==
X-Received: by 2002:a19:f801:: with SMTP id a1mr7640938lff.166.1570181248318;
        Fri, 04 Oct 2019 02:27:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id e21sm1031128lfj.10.2019.10.04.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:27:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8DF2C18063D; Fri,  4 Oct 2019 11:27:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Add cscope and TAGS targets to Makefile
In-Reply-To: <CAEf4BzZpksMGZhggHd=wHVStrN9Wb8RRw-PyDm7fGL3A7YSXdQ@mail.gmail.com>
References: <20191003084321.1431906-1-toke@redhat.com> <CAEf4BzZpksMGZhggHd=wHVStrN9Wb8RRw-PyDm7fGL3A7YSXdQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Oct 2019 11:27:26 +0200
Message-ID: <87r23soo75.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: jFNt_a54MTeKY9BiIbZ4_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Oct 3, 2019 at 1:46 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Using cscope and/or TAGS files for navigating the source code is useful.
>> Add simple targets to the Makefile to generate the index files for both
>> tools.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> Thanks a lot for adding this!
>
> I tested cscope only and it works (especially without -k), so:
>
> Tested-by: Andrii Nakryiko <andriin@fb.com>
>
>
>>  tools/lib/bpf/.gitignore |  2 ++
>>  tools/lib/bpf/Makefile   | 10 +++++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/.gitignore b/tools/lib/bpf/.gitignore
>> index d9e9dec04605..c1057c01223e 100644
>> --- a/tools/lib/bpf/.gitignore
>> +++ b/tools/lib/bpf/.gitignore
>> @@ -3,3 +3,5 @@ libbpf.pc
>>  FEATURE-DUMP.libbpf
>>  test_libbpf
>>  libbpf.so.*
>> +TAGS
>> +cscope.*
>> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> index c6f94cffe06e..57df6b933196 100644
>> --- a/tools/lib/bpf/Makefile
>> +++ b/tools/lib/bpf/Makefile
>> @@ -262,7 +262,7 @@ clean:
>>
>>
>>
>> -PHONY +=3D force elfdep bpfdep
>> +PHONY +=3D force elfdep bpfdep cscope TAGS
>>  force:
>>
>>  elfdep:
>> @@ -271,6 +271,14 @@ elfdep:
>>  bpfdep:
>>         @if [ "$(feature-bpf)" !=3D "1" ]; then echo "BPF API too old"; =
exit 1 ; fi
>>
>> +cscope:
>> +       (echo \-k; echo \-q; for f in *.c *.h; do echo $$f; done) > csco=
pe.files
>> +       cscope -b -f cscope.out
>
> 1. I'd drop -k, given libbpf is user-land library, so it's convenient
> to jump into system headers for some of BPF definitions.

Well, the reason I included it was that when using the version in the
kernel tree, I found it really annoying to jump to kernel headers
installed in the system. Then I'd rather the jump fails and I can go
lookup the header in the kernel tree myself.

So maybe we should rather use -I to point at the parent directory? You
guys could then strip that when syncing to the github repo?

> 2. Wouldn't this be simpler and work exactly the same?
>
> ls *.c *.h > cscope.files
> cscope -b -q -f cscope.out

Well, I usually avoid 'ls' because I have it aliased in my shell so it
prints more info than just the file names. But I don't suppose that's an
issue inside the Makefile, so will fix :)

>> +
>> +TAGS:
>
> let's make it lower-case, please? Linux makefile supports both `make
> tags` and `make TAGS`, but all-caps is terrible :)

You mean just rename the 'make' target, right? Sure, can do...

As for the file itself, I think the version actually on what you use to
generate the tags file. 'ctags' generates lower-case 'tags' by default,
while 'etags' generates 'TAGS'.

I don't use either, so dunno why that different exists, and if it's
actually meaningful? Should we do both?

>> +       rm -f TAGS
>> +       echo *.c *.h | xargs etags -a
>
> nit: might as well do ls *.c *.h for consistency with cscope
> suggestion above (though in both cases we just rely on shell expansion
> logic, so doesn't matter).

Heh, pedantic much? ;)
But OK, I have no strong feelings one way or the other...

-Toke

