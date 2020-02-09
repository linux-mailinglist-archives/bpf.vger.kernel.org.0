Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78DD156AFD
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2020 16:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgBIP3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Feb 2020 10:29:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46843 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgBIP3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Feb 2020 10:29:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id x14so4249493ljd.13
        for <bpf@vger.kernel.org>; Sun, 09 Feb 2020 07:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GeG1KWLb3anDrvTa9Q1tSCi6BsVsKZhJEV3LxmD8BUM=;
        b=BEZFSL2kjB0jykfKIYokzx8baCX9jKke3FqJsdl0OqF3I8O83CH/+Wd+SVCTB9KbDr
         KYsyXzw9piPUtm8HHVTMupikAHF6LRF57EJFdM0fLRqiQor3xqsSyUr5olkt8yF2kJWe
         RQiG5F8ibpgOLjiPUmPJ8EWLptQV1W+sxNw6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GeG1KWLb3anDrvTa9Q1tSCi6BsVsKZhJEV3LxmD8BUM=;
        b=om4+9LtEFZ6Ba2XWeLllaSujKP+TSpmsPRwuGTJ9DFU9SQs9JCgKJfCjKbOm5II8wO
         mpkgt5IuPQL1x6yI3IMIKHrBsdCVBAmnFoyYFYlHA1SLkta4BwMKhpqMicEmCJYfXiA9
         H2EtLpIsHfH3g9gp6NpaKY1ByLpWBNU3Xb/1dSAYm1f+W3WpN8/K6I8B6QO75+gYnld7
         L9cZoDBWZoCMSLSG7vd1akX8NfHC+9gp0MBVqMvurT2FD2FOdPM540HxOzYVSoTV5KRp
         KnSkvVWcI2+SiZi03nX5XIRh1jr8sNmg6voS7gnrLWskeUDZ7Eak6/tiDHBkDCAAsqpn
         cmxQ==
X-Gm-Message-State: APjAAAXrgNzQx3CkE60X0f6BMKxowc6h+TN9EJRhdzqAO6OSdZYdXUgv
        0RIX3bbUk62oNS7BabNqY83Spw==
X-Google-Smtp-Source: APXvYqyyhc5Hq9Up5D9WtT4+gync24YvGT2lp640zi8JRF9ONhPTeZnVEHQhfxmwCJyumbd3WfALXw==
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr5419310lji.274.1581262188646;
        Sun, 09 Feb 2020 07:29:48 -0800 (PST)
Received: from cloudflare.com (user-5-173-219-131.play-internet.pl. [5.173.219.131])
        by smtp.gmail.com with ESMTPSA id z13sm4859546ljh.21.2020.02.09.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 07:29:47 -0800 (PST)
References: <20200206111652.694507-1-jakub@cloudflare.com> <20200206111652.694507-4-jakub@cloudflare.com> <CAADnVQJU4RtAAMH0pL9AQSXDgHGcXOqm15EKZw10c=r-f=bfuw@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf 3/3] selftests/bpf: Test freeing sockmap/sockhash with a socket in it
In-reply-to: <CAADnVQJU4RtAAMH0pL9AQSXDgHGcXOqm15EKZw10c=r-f=bfuw@mail.gmail.com>
Date:   Sun, 09 Feb 2020 16:29:44 +0100
Message-ID: <87eev3aidz.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 09, 2020 at 03:41 AM CET, Alexei Starovoitov wrote:
> On Thu, Feb 6, 2020 at 3:28 AM Jakub Sitnicki <jakub@cloudflare.com> wrot=
e:
>>
>> Commit 7e81a3530206 ("bpf: Sockmap, ensure sock lock held during tear
>> down") introduced sleeping issues inside RCU critical sections and while
>> holding a spinlock on sockmap/sockhash tear-down. There has to be at lea=
st
>> one socket in the map for the problem to surface.
>>
>> This adds a test that triggers the warnings for broken locking rules. No=
t a
>> fix per se, but rather tooling to verify the accompanying fixes. Run on a
>> VM with 1 vCPU to reproduce the warnings.
>>
>> Fixes: 7e81a3530206 ("bpf: Sockmap, ensure sock lock held during tear do=
wn")
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>
> selftests/bpf no longer builds for me.
> make
>   BINARY   test_maps
>   TEST-OBJ [test_progs] sockmap_basic.test.o
> /data/users/ast/net/tools/testing/selftests/bpf/prog_tests/sockmap_basic.=
c:
> In function =E2=80=98connected_socket_v4=E2=80=99:
> /data/users/ast/net/tools/testing/selftests/bpf/prog_tests/sockmap_basic.=
c:20:11:
> error: =E2=80=98TCP_REPAIR_ON=E2=80=99 undeclared (first use in this func=
tion); did
> you mean =E2=80=98TCP_REPAIR=E2=80=99?
>    20 |  repair =3D TCP_REPAIR_ON;
>       |           ^~~~~~~~~~~~~
>       |           TCP_REPAIR
> /data/users/ast/net/tools/testing/selftests/bpf/prog_tests/sockmap_basic.=
c:20:11:
> note: each undeclared identifier is reported only once for each
> function it appears in
> /data/users/ast/net/tools/testing/selftests/bpf/prog_tests/sockmap_basic.=
c:29:11:
> error: =E2=80=98TCP_REPAIR_OFF_NO_WP=E2=80=99 undeclared (first use in th=
is function);
> did you mean =E2=80=98TCP_REPAIR_OPTIONS=E2=80=99?
>    29 |  repair =3D TCP_REPAIR_OFF_NO_WP;
>       |           ^~~~~~~~~~~~~~~~~~~~
>       |           TCP_REPAIR_OPTIONS
>
> Clearly /usr/include/linux/tcp.h is too old.
> Suggestions?

Sorry for the inconvenience. I see that tcp.h header is missing under
linux/tools/include/uapi/.

I have been building against my distro kernel headers, completely
unaware of this. This is an oversight on my side.

Can I ask for a revert? I'm traveling today with limited ability to
post patches.

I can resubmit the test with the missing header for bpf-next once it
reopens.
