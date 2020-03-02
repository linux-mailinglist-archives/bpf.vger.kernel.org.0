Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6D176188
	for <lists+bpf@lfdr.de>; Mon,  2 Mar 2020 18:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCBRsn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Mar 2020 12:48:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42860 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727268AbgCBRsn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Mar 2020 12:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583171322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYoO8Pf0iaS8yqXQ7PzQ3SXf+GOBTbXUKsbsFwGRIxA=;
        b=E75IE/np7hmZftlHAwvqJaez5FmurU+CJJKIMBfK5MbqQxAK/t48qkQ0kJ/IeAwKMzWA6h
        NiAgxKwNtqd+lybdjvwcgV9TbIwAqcJKjGu3PPg9dS0YXCQCmvpULQfgtWMG88p0v0O7Rv
        t94lWpBTFUlFNEi6RkPzIsRRSJkQPVw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-jN4fgftXPCmFON0L5lzrPg-1; Mon, 02 Mar 2020 12:48:40 -0500
X-MC-Unique: jN4fgftXPCmFON0L5lzrPg-1
Received: by mail-wr1-f69.google.com with SMTP id 72so36101wrc.6
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2020 09:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yYoO8Pf0iaS8yqXQ7PzQ3SXf+GOBTbXUKsbsFwGRIxA=;
        b=a15TPiyr5MLsN0q0LsI5DGR6r8KudEvpLMOb5VIrv+NNeR4lae5ygDMhrdcbzMd/Is
         JjDwdMBTDK0Oax/qklz2Dfpeqb19Ha6Vj1qpACuvjD7R2JiOWPtOX6o2pKoRIrzR7fTu
         wMeBJOXyX94cuqhnuRHRFeoCIAXZLtTO5Gt5dhiltkNmDjE99ZXxk0NY8PYPI18XwPJC
         snck26pRB/YKHpKdraZkQTzn2bKOh+jhkpVMaTMB7NIPSe9bTHsAO6BmO9yaiGAVsLEm
         7vSaVc73UNAIiBenE0TUwQqbd2tWlzs9UqxDAKugNZl9d3kJ8WQReJiXfdp7UrrI+ieZ
         H5TQ==
X-Gm-Message-State: ANhLgQ1ucVHozVK8H2MRRDEco+M/02/WfiZTMI6bN9yYkPPgc9Lnrdm3
        kdm0L/ZLHUD3ze0iOeJL0nZTSWfgmMk1/Rq87zVSAUd69KDUPFWFWNEZ47ADfzG+YWyqfBFTKc4
        w8gvamiR1g/cj
X-Received: by 2002:a1c:f214:: with SMTP id s20mr187880wmc.57.1583171319583;
        Mon, 02 Mar 2020 09:48:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuFuwv9A8HJWG5R6iN5L+nwAy67CNZMFHfXdsU75VwKauWFcoCH2NbSQgNP/P/L5pym++m0DQ==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr187871wmc.57.1583171319386;
        Mon, 02 Mar 2020 09:48:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g7sm29090107wrq.21.2020.03.02.09.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:48:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 28D56180362; Mon,  2 Mar 2020 18:48:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     daniel@iogearbox.net, ast@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Declare bpf_log_buf variables as static
In-Reply-To: <20200302165831.GA84713@rdna-mbp>
References: <20200302145348.559177-1-toke@redhat.com> <20200302165831.GA84713@rdna-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 02 Mar 2020 18:48:38 +0100
Message-ID: <87blpetzpl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey Ignatov <rdna@fb.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> [Mon, 2020-03-02 06:54=
 -0800]:
>> The cgroup selftests did not declare the bpf_log_buf variable as static,=
 leading
>> to a linker error with GCC 10 (which defaults to -fno-common). Fix this =
by
>> adding the missing static declarations.
>>=20
>> Fixes: 257c88559f36 ("selftests/bpf: Convert test_cgroup_attach to prog_=
tests")
>
> Hi Toke,
>
> Thanks for the fix.
>
> My 257c88559f36 commit was just a split that simply moved this
> bpf_log_buf from tools/testing/selftests/bpf/test_cgroup_attach.c to all
> new three files as is among many other things. Before that it was moved
> as is from samples/ in
> ba0c0cc05dda ("selftests/bpf: convert test_cgrp2_attach2 example into kse=
lftest")
> and before that it was introduced in
> d40fc181ebec ("samples/bpf: Make samples more libbpf-centric")
>
> Though since these are new files I guess having just 257c88559f36 in the
> tag should be fine(?) so:

Yeah, I did realise you didn't write the original code, but this Fixes
tag should at least make the patch be picked up by any stable trees
after you moved things around, so I guess that's good enough :)

-Toke

