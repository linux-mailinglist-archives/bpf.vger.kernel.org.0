Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34533277419
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgIXOe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 10:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728132AbgIXOe5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 10:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600958096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HqrxwHoOSHrlwkdSsVQFFgcglebPJHiA/TqTJru7b8=;
        b=gmLKYbgA+5ANzVpJJd67TWSvINfpTYqAQYmh7yHnd1aUSiy2gVqFV3XroaURsjm+jafrVq
        XLYMeZwQpjiK+DjyhqwZyx3jtEapv7XRrkgcx+SDGHaCSXdJVzEajfH798Z/Hz/DEGhAY9
        OJdB9VHytt0hze5Y0WcrFgFO0k1fELA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-B7NSE-fQOP6TgilzTSUlYg-1; Thu, 24 Sep 2020 10:34:54 -0400
X-MC-Unique: B7NSE-fQOP6TgilzTSUlYg-1
Received: by mail-wr1-f72.google.com with SMTP id b2so1306313wrs.7
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 07:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3HqrxwHoOSHrlwkdSsVQFFgcglebPJHiA/TqTJru7b8=;
        b=Oi2BcqmxHcKgcamNxtFeMWN3n7WchGqW6gQnmkyQy8COPV99aYul3WXUv6IJ5mdAHB
         viE5JC5g+w+9RH3ZAID6LbdKFpf3XEhIwefio+HtcnF4M5m8K+sIvXY+IHMeOmIXAUJj
         RFdRPfVGUBLlxokb0K/UhbmiPovCcj/U4X+9sXg1lSK8/GkgJInKcW+TSXXWIrdPml3G
         JBrm7q4KZ/tt2Ufdicy7BHHXA79bsOKSkEOTLVZZcDwQ6RxVq4JupPoO0wMymvkSi14S
         Zb0Uux3iDXwjPjEdp08FmxA9jqSZ7ty6WEcqBPsBV1akSIkw+/0OSa65vTK+Ve57lLcY
         ycLg==
X-Gm-Message-State: AOAM5321MttoeQwV5WO+1N42WannmRWFHgZzHGNzhNz5cQue5IQUtwF6
        b+Zzy152MwJm5r+jcFQyP//irzsX6qTMEqDmC181SfE3kIlJdRlrv3vCBHrVL2w/7TCMsv9pJ7C
        ub+JcnDpSZekz
X-Received: by 2002:adf:e690:: with SMTP id r16mr63502wrm.15.1600958092877;
        Thu, 24 Sep 2020 07:34:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxov5wA5+uFn87KgQIxTqy6jBHTt3Q+u5yphyU1YoqfXrDp8sCS7h83YiRgzwvTLW4lQw/bGw==
X-Received: by 2002:adf:e690:: with SMTP id r16mr63478wrm.15.1600958092640;
        Thu, 24 Sep 2020 07:34:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 9sm3644568wmf.7.2020.09.24.07.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:34:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 71B2E183A90; Thu, 24 Sep 2020 16:34:51 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 04/11] bpf: move prog->aux->linked_prog and
 trampoline into bpf_link on attach
In-Reply-To: <20200924001439.qitbu5tmzz55ck4z@ast-mbp.dhcp.thefacebook.com>
References: <160079991372.8301.10648588027560707258.stgit@toke.dk>
 <160079991808.8301.6462172487971110332.stgit@toke.dk>
 <20200924001439.qitbu5tmzz55ck4z@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Sep 2020 16:34:51 +0200
Message-ID: <874knn1bw4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Sep 22, 2020 at 08:38:38PM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> @@ -746,7 +748,9 @@ struct bpf_prog_aux {
>>  	u32 max_rdonly_access;
>>  	u32 max_rdwr_access;
>>  	const struct bpf_ctx_arg_aux *ctx_arg_info;
>> -	struct bpf_prog *linked_prog;
>
> This change breaks bpf_preload and selftests test_bpffs.
> There is really no excuse not to run the selftests.

I did run the tests, and saw no more breakages after applying my patches
than before. Which didn't catch this, because this is the current state
of bpf-next selftests:

# ./test_progs  | grep FAIL
test_lookup_update:FAIL:map1_leak inner_map1 leaked!
#10/1 lookup_update:FAIL
#10 btf_map_in_map:FAIL
configure_stack:FAIL:BPF load failed; run with -vv for more info
#72 sk_assign:FAIL
test_test_bpffs:FAIL:bpffs test  failed 255
#96 test_bpffs:FAIL
Summary: 113/844 PASSED, 14 SKIPPED, 4 FAILED

The test_bpffs failure happens because the umh is missing from the
.config; and when I tried to fix this I ended up with:

[..]
  CC [M]  kernel/bpf/preload/bpf_preload_kern.o

Auto-detecting system features:
...                        libelf: [ OFF ]
...                          zlib: [ OFF ]
...                           bpf: [ OFF ]

No libelf found

...which I just put down to random breakage, turned off the umh and
continued on my way (ignoring the failed test). Until you wrote this I
did not suspect this would be something I needed to pay attention to.
Now that you did mention it, I'll obviously go investigate some more, my
point is just that in this instance it's not accurate to assume I just
didn't run the tests... :)

> I think I will just start marking patches as changes-requested when I see=
 that
> they break tests without replying and without reviewing.
> Please respect reviewer's time.

That is completely fine if the tests are working in the first place. And
even when they're not (like in this case), pointing it out is fine, and
I'll obviously go investigate. But please at least reply to the email,
not all of us watch patchwork regularly.

(I'll fix all your other comments and respin; thanks!)

-Toke

