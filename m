Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5F10C59C
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2019 10:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1JHE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Nov 2019 04:07:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726565AbfK1JHD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Nov 2019 04:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574932023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fc+1aWU1n7L4x+QFUaTGUrJ8QZV6jxVGyjTh715dkvk=;
        b=MNJzXv5Xs4Tnawu6ekTk/NGZXTFeiebbGGK0qgqXwsu+c8DRa075AxlGH6dH+nY2SpQDw9
        /OadUeaF0ybFhI1yDW4viQCW46q8AjHftmHr/5J7Xhe3XMqPe6C1rvu0ns/J1Ig/+sP3Da
        VU0HQoIHEWIEV1/qDFENYa1Xd2EGEl0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-kq0Sx46bOlWNuZLaypE39A-1; Thu, 28 Nov 2019 04:07:01 -0500
Received: by mail-lj1-f198.google.com with SMTP id v26so792768ljg.22
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2019 01:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DvrocL/1GRTCvaXxuQQF+aHOAoWJJA60RMKFIr0Cm60=;
        b=E9FTYWK1+dqNPFwBTz8bC3WoiIFYicnueZB1QNvr1kOgwDcjL/vnCGkf1DTe/2+VLO
         25ZMHFV4NmUhXxvkp7e0bg4GxZm2wpoC5V6Re2L7Z3irVgu979N483z/TZTCzSr150VF
         3bmtornb8fyqZ1Bp7UgkBTgh2Y31vtcnucdZIRHh3JokFCCNlJjU9m8zxn4zCzZ7KoPW
         iGVaubEIQhsxZxej7wilDF2kPJV30RCd6ZYU/V+JguaFRROoAzBDAM4NAWY5oBqzks3t
         Piq1FKfrnpyJU2LYwEJIOgvOh9NNub/8BH41+GM82hinLTu45pSuYNZP28DNv3if2zQ7
         oW+w==
X-Gm-Message-State: APjAAAV+eAW3/GJ65Hwy9bwxoahHWb45iylkEapokEI0xqN78fjl8lHO
        D8vvXmLc62yRqqxU0D66w12kGfOMzLR+uXxQ7e5J2iZAFQsjHYfCv1tSbmvQdJkGIs8A/zIWg4F
        TL0JeWt1zOqaA
X-Received: by 2002:a2e:914d:: with SMTP id q13mr7972517ljg.198.1574932019916;
        Thu, 28 Nov 2019 01:06:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwW+RawCEjX/SrVq5qTek4AHlvFYFzQbz7nhztA0ZhJ3BUPtFzw7uzugqmhWCO8ANdZ6bOJqQ==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr7972501ljg.198.1574932019671;
        Thu, 28 Nov 2019 01:06:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o26sm8079173lfi.57.2019.11.28.01.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 01:06:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2377C1818BE; Thu, 28 Nov 2019 10:06:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 0/3] perf/bpftool: Allow to link libbpf dynamically
In-Reply-To: <CAADnVQLp2VTi9JhtfkLOR9Y1ipNFObOGH9DQe5zbKxz77juhqA@mail.gmail.com>
References: <20191127094837.4045-1-jolsa@kernel.org> <CAADnVQLp2VTi9JhtfkLOR9Y1ipNFObOGH9DQe5zbKxz77juhqA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 28 Nov 2019 10:06:57 +0100
Message-ID: <87o8wwwery.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: kq0Sx46bOlWNuZLaypE39A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Nov 27, 2019 at 1:48 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> hi,
>> adding support to link bpftool with libbpf dynamically,
>> and config change for perf.
>>
>> It's now possible to use:
>>   $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1
>>
>> which will detect libbpf devel package with needed version,
>> and if found, link it with bpftool.
>>
>> It's possible to use arbitrary installed libbpf:
>>   $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/tmp/libb=
pf/
>>
>> I based this change on top of Arnaldo's perf/core, because
>> it contains libbpf feature detection code as dependency.
>> It's now also synced with latest bpf-next, so Toke's change
>> applies correctly.
>
> I don't like it.
> Especially Toke's patch to expose netlink as public and stable libbpf
> api.

Figured you might say that :)

> bpftools needs to stay tightly coupled with libbpf (and statically
> linked for that reason).
> Otherwise libbpf will grow a ton of public api that would have to be stab=
le
> and will quickly become a burden.

I can see why you don't want to expose the "internal" functions as
LIBBPF_API. Doesn't *have* to mean we can't link bpftool dynamically
against the .so version of libbpf, though; will see if I can figure out
a clean way to do that...

-Toke

