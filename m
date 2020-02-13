Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F07615CDCF
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2020 23:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgBMWGv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Feb 2020 17:06:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33157 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727519AbgBMWGv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Feb 2020 17:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581631609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxFQbPQ4DkEncmBxpMMyx8C/MI86QK2bsuQ9NT3AH+c=;
        b=VKiJ3jXfK3qKz+hg1DXW+MZMZohQF7FpZrLpXAIjppG4Fb/TFlmtqMfHqnS4lpD/Tv1lEs
        m1E39fHFHrtI5FA6SyGUNQ++X6e0xyTIFgczQhzAs7Q5cWwoFwjGle6LOva72fmOxmxGzT
        5Fb7RUDm3h7wbKNMOzF88PaQQ82WhFU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Qf3OhWPSNA-H1Q6IzJSOOA-1; Thu, 13 Feb 2020 17:06:48 -0500
X-MC-Unique: Qf3OhWPSNA-H1Q6IzJSOOA-1
Received: by mail-lf1-f70.google.com with SMTP id i24so876788lfj.17
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2020 14:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LxFQbPQ4DkEncmBxpMMyx8C/MI86QK2bsuQ9NT3AH+c=;
        b=QPwbiKxbBw4ch7QjnJtW7iy0uny7t5hWtAzYta4gBK+1v2LwuRFtqoZsm2AuP8hOfL
         Mugox2SglLF7riQ+LdZFDPIojhC7mbO2zIHerDQdOpt4Y0amXeMv4Be9LMpE9eADj5Io
         TDsIRjXj5hngGa9g/1BWIIWguxQUpHSqkY5y7BwJM2aQZIzx9FMjAwYXr0C7lp9puLdt
         Qm+eFI30j8O+RyBkti2bkLlpnE6uGgP37af+L3c7Wg4RaNVzPYJJsTiDLLnrsqx2gCTB
         s/AsOMkIaymxehKocsf4WmJBbS6/CsOjhUmb4LjbDOjQsrwi7UXRD3nmlJMy5pLSFdaH
         4kHw==
X-Gm-Message-State: APjAAAX77csGpzQywiEhceI8uIpnsZxnJ16YqpvjlksMwueKcj3+l8qQ
        W5PmTbC22WsBaL696TVFmxnN5i6EMKm3Spg/g6HkEA9yx75SIyCMHkjLXnSlsqaN4oWfeNH0dHG
        A0CJ1Vwob89ip
X-Received: by 2002:a19:8b88:: with SMTP id n130mr43429lfd.210.1581631606723;
        Thu, 13 Feb 2020 14:06:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIR5MTDuyqJZzbAd+Oog4qWtz2YVgnGuRldqMlL9ZjjTHwn2JU3D4VUhs8wnw513YCkFeUVA==
X-Received: by 2002:a19:8b88:: with SMTP id n130mr43419lfd.210.1581631606369;
        Thu, 13 Feb 2020 14:06:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r12sm2307837ljh.105.2020.02.13.14.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 14:06:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 04299180371; Thu, 13 Feb 2020 23:06:43 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Networking <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast\@kernel.org" <ast@kernel.org>,
        "daniel\@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [RFC bpf-next 3/4] bpftool: introduce "prog profile" command
In-Reply-To: <6C487C26-1037-4CE5-8FA2-0BD67DA5F3F7@fb.com>
References: <20200213210115.1455809-1-songliubraving@fb.com> <20200213210115.1455809-4-songliubraving@fb.com> <87o8u2dunl.fsf@toke.dk> <6C487C26-1037-4CE5-8FA2-0BD67DA5F3F7@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Feb 2020 23:06:43 +0100
Message-ID: <87lfp6dtvw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song Liu <songliubraving@fb.com> writes:

>> On Feb 13, 2020, at 1:50 PM, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>>=20
>> Song Liu <songliubraving@fb.com> writes:
>>=20
>>> With fentry/fexit programs, it is possible to profile BPF program with
>>> hardware counters. Introduce bpftool "prog profile", which measures key
>>> metrics of a BPF program.
>>>=20
>>> bpftool prog profile command creates per-cpu perf events. Then it attac=
hes
>>> fentry/fexit programs to the target BPF program. The fentry program sav=
es
>>> perf event value to a map. The fexit program reads the perf event again,
>>> and calculates the difference, which is the instructions/cycles used by
>>> the target program.
>>>=20
>>> Example input and output:
>>>=20
>>>  ./bpftool prog profile 20 id 810 cycles instructions
>>>  cycles: duration 20 run_cnt 1368 miss_cnt 665
>>>          counter 503377 enabled 668202 running 351857
>>>  instructions: duration 20 run_cnt 1368 miss_cnt 707
>>>          counter 398625 enabled 502330 running 272014
>>>=20
>>> This command measures cycles and instructions for BPF program with id
>>> 810 for 20 seconds. The program has triggered 1368 times. cycles was not
>>> measured in 665 out of these runs, because of perf event multiplexing
>>> (some perf commands are running in the background). In these runs, the =
BPF
>>> program consumed 503377 cycles. The perf_event enabled and running time
>>> are 668202 and 351857 respectively.
>>>=20
>>> Note that, this approach measures cycles and instructions in very small
>>> increments. So the fentry/fexit programs introduce noticable errors to
>>> the measurement results.
>>>=20
>>> The fentry/fexit programs are generated with BPF skeleton. Currently,
>>> generation of the skeleton requires some manual steps.
>>>=20
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>> ---
>>> tools/bpf/bpftool/profiler.skel.h         | 820 ++++++++++++++++++++++
>>> tools/bpf/bpftool/prog.c                  | 387 +++++++++-
>>> tools/bpf/bpftool/skeleton/README         |   3 +
>>> tools/bpf/bpftool/skeleton/profiler.bpf.c | 185 +++++
>>> tools/bpf/bpftool/skeleton/profiler.h     |  47 ++
>>> 5 files changed, 1441 insertions(+), 1 deletion(-)
>>> create mode 100644 tools/bpf/bpftool/profiler.skel.h
>>> create mode 100644 tools/bpf/bpftool/skeleton/README
>>> create mode 100644 tools/bpf/bpftool/skeleton/profiler.bpf.c
>>> create mode 100644 tools/bpf/bpftool/skeleton/profiler.h
>>>=20
>>> diff --git a/tools/bpf/bpftool/profiler.skel.h b/tools/bpf/bpftool/prof=
iler.skel.h
>>> new file mode 100644
>>> index 000000000000..10e99989c03e
>>> --- /dev/null
>>> +++ b/tools/bpf/bpftool/profiler.skel.h
>>> @@ -0,0 +1,820 @@
>>> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>>> +
>>> +/* THIS FILE IS AUTOGENERATED! */
>>> +#ifndef __PROFILER_BPF_SKEL_H__
>>> +#define __PROFILER_BPF_SKEL_H__
>>> +
>>> +#include <stdlib.h>
>>> +#include <bpf/libbpf.h>
>>> +
>>> +struct profiler_bpf {
>>> +	struct bpf_object_skeleton *skeleton;
>>> +	struct bpf_object *obj;
>>> +	struct {
>>> +		struct bpf_map *events;
>>> +		struct bpf_map *fentry_readings;
>>> +		struct bpf_map *accum_readings;
>>> +		struct bpf_map *counts;
>>> +		struct bpf_map *miss_counts;
>>> +		struct bpf_map *rodata;
>>> +	} maps;
>>> +	struct {
>>> +		struct bpf_program *fentry_XXX;
>>> +		struct bpf_program *fexit_XXX;
>>> +	} progs;
>>> +	struct {
>>> +		struct bpf_link *fentry_XXX;
>>> +		struct bpf_link *fexit_XXX;
>>> +	} links;
>>> +	struct profiler_bpf__rodata {
>>> +		__u32 num_cpu;
>>> +		__u32 num_metric;
>>> +	} *rodata;
>>> +};
>>> +
>>> +static void
>>> +profiler_bpf__destroy(struct profiler_bpf *obj)
>>> +{
>>> +	if (!obj)
>>> +		return;
>>> +	if (obj->skeleton)
>>> +		bpf_object__destroy_skeleton(obj->skeleton);
>>> +	free(obj);
>>> +}
>>> +
>>> +static inline int
>>> +profiler_bpf__create_skeleton(struct profiler_bpf *obj);
>>> +
>>> +static inline struct profiler_bpf *
>>> +profiler_bpf__open_opts(const struct bpf_object_open_opts *opts)
>>> +{
>>> +	struct profiler_bpf *obj;
>>> +
>>> +	obj =3D (typeof(obj))calloc(1, sizeof(*obj));
>>> +	if (!obj)
>>> +		return NULL;
>>> +	if (profiler_bpf__create_skeleton(obj))
>>> +		goto err;
>>> +	if (bpf_object__open_skeleton(obj->skeleton, opts))
>>> +		goto err;
>>> +
>>> +	return obj;
>>> +err:
>>> +	profiler_bpf__destroy(obj);
>>> +	return NULL;
>>> +}
>>> +
>>> +static inline struct profiler_bpf *
>>> +profiler_bpf__open(void)
>>> +{
>>> +	return profiler_bpf__open_opts(NULL);
>>> +}
>>> +
>>> +static inline int
>>> +profiler_bpf__load(struct profiler_bpf *obj)
>>> +{
>>> +	return bpf_object__load_skeleton(obj->skeleton);
>>> +}
>>> +
>>> +static inline struct profiler_bpf *
>>> +profiler_bpf__open_and_load(void)
>>> +{
>>> +	struct profiler_bpf *obj;
>>> +
>>> +	obj =3D profiler_bpf__open();
>>> +	if (!obj)
>>> +		return NULL;
>>> +	if (profiler_bpf__load(obj)) {
>>> +		profiler_bpf__destroy(obj);
>>> +		return NULL;
>>> +	}
>>> +	return obj;
>>> +}
>>> +
>>> +static inline int
>>> +profiler_bpf__attach(struct profiler_bpf *obj)
>>> +{
>>> +	return bpf_object__attach_skeleton(obj->skeleton);
>>> +}
>>> +
>>> +static inline void
>>> +profiler_bpf__detach(struct profiler_bpf *obj)
>>> +{
>>> +	return bpf_object__detach_skeleton(obj->skeleton);
>>> +}
>>> +
>>> +static inline int
>>> +profiler_bpf__create_skeleton(struct profiler_bpf *obj)
>>> +{
>>> +	struct bpf_object_skeleton *s;
>>> +
>>> +	s =3D (typeof(s))calloc(1, sizeof(*s));
>>> +	if (!s)
>>> +		return -1;
>>> +	obj->skeleton =3D s;
>>> +
>>> +	s->sz =3D sizeof(*s);
>>> +	s->name =3D "profiler_bpf";
>>> +	s->obj =3D &obj->obj;
>>> +
>>> +	/* maps */
>>> +	s->map_cnt =3D 6;
>>> +	s->map_skel_sz =3D sizeof(*s->maps);
>>> +	s->maps =3D (typeof(s->maps))calloc(s->map_cnt, s->map_skel_sz);
>>> +	if (!s->maps)
>>> +		goto err;
>>> +
>>> +	s->maps[0].name =3D "events";
>>> +	s->maps[0].map =3D &obj->maps.events;
>>> +
>>> +	s->maps[1].name =3D "fentry_readings";
>>> +	s->maps[1].map =3D &obj->maps.fentry_readings;
>>> +
>>> +	s->maps[2].name =3D "accum_readings";
>>> +	s->maps[2].map =3D &obj->maps.accum_readings;
>>> +
>>> +	s->maps[3].name =3D "counts";
>>> +	s->maps[3].map =3D &obj->maps.counts;
>>> +
>>> +	s->maps[4].name =3D "miss_counts";
>>> +	s->maps[4].map =3D &obj->maps.miss_counts;
>>> +
>>> +	s->maps[5].name =3D "profiler.rodata";
>>> +	s->maps[5].map =3D &obj->maps.rodata;
>>> +	s->maps[5].mmaped =3D (void **)&obj->rodata;
>>> +
>>> +	/* programs */
>>> +	s->prog_cnt =3D 2;
>>> +	s->prog_skel_sz =3D sizeof(*s->progs);
>>> +	s->progs =3D (typeof(s->progs))calloc(s->prog_cnt, s->prog_skel_sz);
>>> +	if (!s->progs)
>>> +		goto err;
>>> +
>>> +	s->progs[0].name =3D "fentry_XXX";
>>> +	s->progs[0].prog =3D &obj->progs.fentry_XXX;
>>> +	s->progs[0].link =3D &obj->links.fentry_XXX;
>>> +
>>> +	s->progs[1].name =3D "fexit_XXX";
>>> +	s->progs[1].prog =3D &obj->progs.fexit_XXX;
>>> +	s->progs[1].link =3D &obj->links.fexit_XXX;
>>> +
>>> +	s->data_sz =3D 18256;
>>> +	s->data =3D (void *)"\
>>> +\x7f\x45\x4c\x46\x02\x01\x01\0\0\0\0\0\0\0\0\0\x01\0\xf7\0\x01\0\0\0\0=
\0\0\0\0\
>>=20
>> Holy binary blob, Batman! :)
>>=20
>> What is this blob, exactly? The bytecode output of a precompiled
>> program?
>
> It is the skeleton compiled from profiler.bpf.c. Please refer to=20
> the README file for step to generate it.

Ah, right, seems I managed to skip over the second half of the patch so
missed that :)

> In long term, we should include the generation of this blob in the=20
> make process. But for RFC, I kept it simple for now. :)

Yes, I agree; but fair enough.

-Toke

