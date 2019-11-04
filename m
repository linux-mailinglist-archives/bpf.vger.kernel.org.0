Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7AEDC53
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2019 11:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfKDKSc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 4 Nov 2019 05:18:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfKDKSb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Nov 2019 05:18:31 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EEE287634
        for <bpf@vger.kernel.org>; Mon,  4 Nov 2019 10:18:30 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id o20so332395ljg.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2019 02:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+7qFcNlUl+8M23vTnMU10G5kkgLKUsBOQSDTGQQBufc=;
        b=kAeZ8iLFhQPqwZqiZxHbZaDDFYUkMLVSs8hT6r45BzVhbIXbEz3ejqR/RtGvB8/0jD
         CM8MzzuUfo9mbrUYjp4EnHaUQ+07+riAnuW52U3vpJkhKoVR9EPYtcZ4NBwE+aGBw9ak
         LsLQR1/CnGhcxYIjMR/U4M+Xemuls5ZUj2xUe1xIK20F3gAmho4JvyUTp1EUsSgFB+Pi
         6aQFE066CkYuJ4UMiuO073Kgax/zkWQufjaiHY5PQucokUADo39qrxlzS2S90BEen+ZY
         Xh2QOGcmIeAQtcSUeB9uhPzrNKVM8avgydIfDlSVNofqS4Sblv5HQfSmPvT0hDmCf5fl
         cmDA==
X-Gm-Message-State: APjAAAW0MGghaYYqiSyBsvxGed+FTd6RBFB73d7ffh30Pn3jwPgdtlvd
        dSnMGOctYSu1xFjY2ajU7AGFgqvwfqi2jvKslpdaT/aObqomrrrsuP7FhA0QqUxJDQz3RDnEvC6
        d4gF9srdX7dAN
X-Received: by 2002:a2e:9094:: with SMTP id l20mr17387419ljg.246.1572862708795;
        Mon, 04 Nov 2019 02:18:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqywzFF2qNaZfGs4Gjhy68LoH5Zq/aodrWDlObf36tW8H0TMV0Z3L1zomKXCLeWnvenxd02kOw==
X-Received: by 2002:a2e:9094:: with SMTP id l20mr17387398ljg.246.1572862708581;
        Mon, 04 Nov 2019 02:18:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q189sm3405061ljq.79.2019.11.04.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 02:18:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A796E1818B5; Mon,  4 Nov 2019 11:18:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6 0/5] libbpf: Support automatic pinning of maps using 'pinning' BTF attribute
In-Reply-To: <CAEf4BzYXhoaiH5x9YZ99ABUMngsjBVRAYJBm+oMbnAHnpn-18g@mail.gmail.com>
References: <157269297658.394725.10672376245672095901.stgit@toke.dk> <CAEf4BzYXhoaiH5x9YZ99ABUMngsjBVRAYJBm+oMbnAHnpn-18g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 04 Nov 2019 11:18:26 +0100
Message-ID: <87lfswkkr1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Sat, Nov 2, 2019 at 4:09 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> This series adds support to libbpf for reading 'pinning' settings from BTF-based
>> map definitions. It introduces a new open option which can set the pinning path;
>> if no path is set, /sys/fs/bpf is used as the default. Callers can customise the
>> pinning between open and load by setting the pin path per map, and still get the
>> automatic reuse feature.
>>
>> The semantics of the pinning is similar to the iproute2 "PIN_GLOBAL" setting,
>> and the eventual goal is to move the iproute2 implementation to be based on
>> libbpf and the functions introduced in this series.
>>
>> Changelog:
>>
>> v6:
>>   - Fix leak of struct bpf_object in selftest
>>   - Make struct bpf_map arg const in bpf_map__is_pinned() and bpf_map__get_pin_path()
>>
>> v5:
>>   - Don't pin maps with pinning set, but with a value of LIBBPF_PIN_NONE
>>   - Add a few more selftests:
>>     - Should not pin map with pinning set, but value LIBBPF_PIN_NONE
>>     - Should fail to load a map with an invalid pinning value
>>     - Should fail to re-use maps with parameter mismatch
>>   - Alphabetise libbpf.map
>>   - Whitespace and typo fixes
>>
>> v4:
>>   - Don't check key_type_id and value_type_id when checking for map reuse
>>     compatibility.
>>   - Move building of map->pin_path into init_user_btf_map()
>>   - Get rid of 'pinning' attribute in struct bpf_map
>>   - Make sure we also create parent directory on auto-pin (new patch 3).
>>   - Abort the selftest on error instead of attempting to continue.
>>   - Support unpinning all pinned maps with bpf_object__unpin_maps(obj, NULL)
>>   - Support pinning at map->pin_path with bpf_object__pin_maps(obj, NULL)
>>   - Make re-pinning a map at the same path a noop
>>   - Rename the open option to pin_root_path
>>   - Add a bunch more self-tests for pin_maps(NULL) and unpin_maps(NULL)
>>   - Fix a couple of smaller nits
>>
>> v3:
>>   - Drop bpf_object__pin_maps_opts() and just use an open option to customise
>>     the pin path; also don't touch bpf_object__{un,}pin_maps()
>>   - Integrate pinning and reuse into bpf_object__create_maps() instead of having
>>     multiple loops though the map structure
>>   - Make errors in map reuse and pinning fatal to the load procedure
>>   - Add selftest to exercise pinning feature
>>   - Rebase series to latest bpf-next
>>
>> v2:
>>   - Drop patch that adds mounting of bpffs
>>   - Only support a single value of the pinning attribute
>>   - Add patch to fixup error handling in reuse_fd()
>>   - Implement the full automatic pinning and map reuse logic on load
>>
>> ---
>>
>> Toke Høiland-Jørgensen (5):
>>       libbpf: Fix error handling in bpf_map__reuse_fd()
>>       libbpf: Store map pin path and status in struct bpf_map
>>       libbpf: Move directory creation into _pin() functions
>>       libbpf: Add auto-pinning of maps when loading BPF objects
>>       selftests: Add tests for automatic map pinning
>>
>>
>
> For the series:
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Awesome! Thank you for your thorough reviews :)

-Toke
