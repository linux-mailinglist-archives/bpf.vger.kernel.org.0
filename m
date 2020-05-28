Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B58A1E61AB
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbgE1NF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390060AbgE1NF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 09:05:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B58C05BD1E
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 06:05:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y13so10025670eju.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=SxOri3O+pFijqd0Okl/7zENBG3JvyHUCefM2glGcSso=;
        b=xD/tlCktZIgcULOBB+ZWBzsPS0mLTbyHSGf87BIaNX0+2C8+NfXb7tUoHRFPX/tldD
         XzCTw3t0lgHZ/Pg16UU1MSVdjrs3TGgjDnNYTCMCyQ73/sOYtZ7nanIU+2aOw5iFXV1K
         kWXmWKCBrK9pdumsQNgMWoaiy00nGWbl31Xtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=SxOri3O+pFijqd0Okl/7zENBG3JvyHUCefM2glGcSso=;
        b=qTbZtSvLz2W2cg1vvapExYUbUt0aA2VdiHQaFYomYEbT20J3VWsGP66ck7Zo+9ILGH
         OmK7fT1/eOpqvShGyfS5OisuMh/dUDkadNiVqFzNeoBLZ0nfESJS9jvGy6Zg3X93jAys
         JEtiVtH0/bysd9XCIY0Qjrx4+Iw/ctzVdzR/mMVFUof8WQeGBoyd+FyR4gxsPz8pPaIv
         RIrYVZiCkElu+53PYH93Od6mrPs8kj64IjiQWpfOPluVM4Q8SlUGYNLsDMBzH6TjiiO3
         R7s6Q3gke+taZwMYRjcw86OySuF8c5JoAL5FgtWmMfL40vaNPrpdjaXEIGiDDm0smPwp
         +AnA==
X-Gm-Message-State: AOAM533oPrG4XCt8JeqlQgmGDCDaE9oeIPaGPjOUEVz/0czhqzxLQVyq
        4PsXkf65ZRWkYeUXvLw6XqKFSQ==
X-Google-Smtp-Source: ABdhPJzAxMFaacW3peB2OUbE+AWkbsb7nGgeD/k/4IAzKdOVGwSweK1MQzkFadlUKvYhH+3clJihKw==
X-Received: by 2002:a17:906:f85:: with SMTP id q5mr2869436ejj.344.1590671155747;
        Thu, 28 May 2020 06:05:55 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id qp13sm5499239ejb.8.2020.05.28.06.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:05:51 -0700 (PDT)
References: <20200527170840.1768178-1-jakub@cloudflare.com> <20200527170840.1768178-7-jakub@cloudflare.com> <CAEf4BzZJU-zRXzQU3X3zyBWX4=nxfDTjyqjzJ6NV3HvGUxNd_Q@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 6/8] libbpf: Add support for bpf_link-based netns attachment
In-reply-to: <CAEf4BzZJU-zRXzQU3X3zyBWX4=nxfDTjyqjzJ6NV3HvGUxNd_Q@mail.gmail.com>
Date:   Thu, 28 May 2020 15:05:50 +0200
Message-ID: <87o8q82or5.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 28, 2020 at 07:59 AM CEST, Andrii Nakryiko wrote:
> On Wed, May 27, 2020 at 12:16 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> Add bpf_program__attach_nets(), which uses LINK_CREATE subcommand to create
>> an FD-based kernel bpf_link, for attach types tied to network namespace,
>> that is BPF_FLOW_DISSECTOR for the moment.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  tools/lib/bpf/libbpf.c   | 20 ++++++++++++++++----
>>  tools/lib/bpf/libbpf.h   |  2 ++
>>  tools/lib/bpf/libbpf.map |  1 +
>>  3 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 5d60de6fd818..a49c1eb5db64 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -7894,8 +7894,8 @@ static struct bpf_link *attach_iter(const struct bpf_sec_def *sec,
>>         return bpf_program__attach_iter(prog, NULL);
>>  }
>>
>> -struct bpf_link *
>> -bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
>> +static struct bpf_link *
>> +bpf_program__attach_fd(struct bpf_program *prog, int target_fd)
>>  {
>>         enum bpf_attach_type attach_type;
>>         char errmsg[STRERR_BUFSIZE];
>> @@ -7915,11 +7915,11 @@ bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
>>         link->detach = &bpf_link__detach_fd;
>>
>>         attach_type = bpf_program__get_expected_attach_type(prog);
>> -       link_fd = bpf_link_create(prog_fd, cgroup_fd, attach_type, NULL);
>> +       link_fd = bpf_link_create(prog_fd, target_fd, attach_type, NULL);
>>         if (link_fd < 0) {
>>                 link_fd = -errno;
>>                 free(link);
>> -               pr_warn("program '%s': failed to attach to cgroup: %s\n",
>> +               pr_warn("program '%s': failed to attach to cgroup/netns: %s\n",
>
> I understand the desire to save few lines of code, but it hurts error
> reporting. Now it's cgroup/netns, tomorrow cgroup/netns/lirc/whatever.
> If you want to generalize, let's preserve clarity of error message,
> please.

Ok, that's fair. I could pass the link type bpf_program__attach_fd and
map it to a string.

>
>>                         bpf_program__title(prog, false),
>>                         libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
>>                 return ERR_PTR(link_fd);
>> @@ -7928,6 +7928,18 @@ bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
>>         return link;
>>  }
>>
>> +struct bpf_link *
>> +bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
>> +{
>> +       return bpf_program__attach_fd(prog, cgroup_fd);
>> +}
>> +
>> +struct bpf_link *
>> +bpf_program__attach_netns(struct bpf_program *prog, int netns_fd)
>> +{
>> +       return bpf_program__attach_fd(prog, netns_fd);
>> +}
>> +
>>  struct bpf_link *
>>  bpf_program__attach_iter(struct bpf_program *prog,
>>                          const struct bpf_iter_attach_opts *opts)
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 1e2e399a5f2c..adf6fd9b6fe8 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -253,6 +253,8 @@ LIBBPF_API struct bpf_link *
>>  bpf_program__attach_lsm(struct bpf_program *prog);
>>  LIBBPF_API struct bpf_link *
>>  bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd);
>> +LIBBPF_API struct bpf_link *
>> +bpf_program__attach_netns(struct bpf_program *prog, int netns_fd);
>>
>>  struct bpf_map;
>>
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 381a7342ecfc..7ad21ba1feb6 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -263,4 +263,5 @@ LIBBPF_0.0.9 {
>>                 bpf_link_get_next_id;
>>                 bpf_program__attach_iter;
>>                 perf_buffer__consume;
>> +               bpf_program__attach_netns;
>
> Please keep it alphabetical.

Will do. Not sure how I didn't pick up the convention.

>
>>  } LIBBPF_0.0.8;
>> --
>> 2.25.4
>>

