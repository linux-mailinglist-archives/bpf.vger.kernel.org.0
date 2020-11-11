Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465532AF7F3
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 19:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKKSdJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 13:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgKKSdJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 13:33:09 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70EC0613D1;
        Wed, 11 Nov 2020 10:33:09 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so2634416qkb.7;
        Wed, 11 Nov 2020 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=gavp6tNqWuRZ+zWPhGuAXVWSO+tjwIuRUlDIDkI3FGQ=;
        b=Z57vWhy9FFCAy78wImJ/7EL/rv/A8r21UzG+vsL9vWTxNtxrH+HtbhOPelRzNKPnob
         i7CFXoizhYauOIf1rNJFz4sTC+ful7l/Jra5llIOB81huO+LGDFM0vAYnrG+62cFsAOR
         CMlUJcN9vvtflklO+tdIG/CZSHJTyOZDKWMt29g32eH7fbiD7EIA1W6IQbTr8mE/B7Ia
         DyxTpnAdr3pXheTySA/OawLFawQQ6OOx6FXKqKEXqQ1AQpOjnc4UK4pvVkJvnQ3o1XPC
         vrw/qD2HVLQM3dwzUFrkkGx6XlrZztF0bcb/s1/dADhBDztmmr0hfkpPaV216f/ZGo7D
         Xk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=gavp6tNqWuRZ+zWPhGuAXVWSO+tjwIuRUlDIDkI3FGQ=;
        b=KmZvpbQxogdQjwA0GHqFFfEQ1E4Vg+exeugDUq2TspaHe6JDp130ASkvuJpjOVkw9a
         Uv9Ki3uCrZVJQOstxLSkktHijF11WTCNMVr3j1HgW0rYpQ6sPoyqWx+lZh7Aaq0k7TAC
         Pa4Q38PLydNP4s84wV+4S92M2R73LEy493Ck9KwKU7/MQ6biy4/K5Y5AUY62+xqdfLty
         xhMsCNa5n7Vp4QFfj7g33nNvP5U3KsKO5mKA+7owl4fDHpODI96WlgojC/hOtdLQnSI7
         uuCAQ5F01jQWL/Ug4g/lO7LVxlunDnTbo6pztCaF7qGNwtjxdUIUwJVGAeJInPH+qDvJ
         0zFw==
X-Gm-Message-State: AOAM533MVBnBGTfLo1b/Mgp8RqcjpmYhQj3TUfXFZJ4Fvd7/cuDXzvkT
        YZNhAm9LCC4QQaVMDCoHTXFSpBIxnE4=
X-Google-Smtp-Source: ABdhPJy65TFbOXart7fZqwKuq1nJEFobwv7XpkQrp9+omLxrnyRhdediRJD+Oih+9dBFY8a1cSHIXQ==
X-Received: by 2002:a37:9c83:: with SMTP id f125mr26818895qke.149.1605119588483;
        Wed, 11 Nov 2020 10:33:08 -0800 (PST)
Received: from [172.29.31.236] ([187.68.204.65])
        by smtp.gmail.com with ESMTPSA id o16sm2969608qkg.27.2020.11.11.10.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 10:33:07 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:32:43 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzajM3Pg13uTF7cKOWfASvhOPOx85ufcchuDcGLEq8d9fQ@mail.gmail.com>
References: <20201106052549.3782099-1-andrii@kernel.org> <20201106052549.3782099-5-andrii@kernel.org> <20201111115627.GB355344@kernel.org> <20201111121946.GD355344@kernel.org> <CAEf4BzajM3Pg13uTF7cKOWfASvhOPOx85ufcchuDcGLEq8d9fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH dwarves 4/4] btf: add support for split BTF loading and encoding
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <CD0AB08B-9BEC-4E72-AB16-2959F8837DCB@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On November 11, 2020 3:29:32 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakry=
iko@gmail=2Ecom> wrote:
>On Wed, Nov 11, 2020 at 4:19 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> Em Wed, Nov 11, 2020 at 08:56:27AM -0300, Arnaldo Carvalho de Melo
>escreveu:
>> >
>> > The entry for btf_encode/-J is missing, I'll add in a followup
>patch=2E
>> >
>> > Also I had to fixup ARGP_btf_base to 321 as I added this, to
>simplify
>> > the kernel scripts and Makefiles:
>> >
>> >   $ pahole --numeric_version
>> >   118
>> >   $
>>
>> Added this:
>>
>> [acme@five pahole]$ git diff
>> diff --git a/man-pages/pahole=2E1 b/man-pages/pahole=2E1
>> index 20ee91fc911d4b39=2E=2Ef44c649924383a32 100644
>> --- a/man-pages/pahole=2E1
>> +++ b/man-pages/pahole=2E1
>> @@ -181,6 +181,14 @@ the debugging information=2E
>>  =2EB \-\-skip_encoding_btf_vars
>>  Do not encode VARs in BTF=2E
>>
>> +=2ETP
>> +=2EB \-J, \-\-btf_encode
>> +Encode BTF information from DWARF, used in the Linux kernel build
>process when
>> +CONFIG_DEBUG_INFO_BTF=3Dy is present, introduced in Linux v5=2E2=2E Us=
ed
>to implement
>> +features such as BPF CO-RE (Compile Once - Run Everywhere)=2E
>> +
>> +See \fIhttp://vger=2Ekernel=2Eorg/bpfconf2019_talks/bpf-core=2Epdf\fR=
=2E
>
>Can you please point to [0] instead? That linked

Sure=2E

> presentation is
>already a bit out of date and will bitrot much faster=2E Blog post has
>at least a chance at being updated with relevant important stuff=2E Plus
>it has links both to the bpfconf2019 presentation, as well as some
>other resources (including your presentation)=2E
>
>  [0] https://nakryiko=2Ecom/posts/bpf-portability-and-co-re/

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
