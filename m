Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A3363A5
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfFESzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 14:55:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42421 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFESzh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 14:55:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so19233159qtk.9
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2019 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l9rVGvGqRB9qcdDl2IiiDsnLK4HD8J3eRDoZWHeXx8c=;
        b=ao90HGzYmKSyJ5yadJvMh8VGQDOA6MNjILeQncdlDneN26iVRouxPOwsjeNUQo/9Cm
         hOhQIkVniO4uzx3SYsD4QEeJyFxWCKlGOYRgBCV8LFYj+/yNfGYmuwpimBV4reRGfhJw
         aQ7hvPmYlhTNwbP/EPdpEk4xT5gMsvy/jHR6k8OAPrtiJgnVGEV93yLFmkv92buyYJES
         QiEoxItSGnRKHJD9HIzNj03yEQGYl7da11K0JYiGyLfGEEdmlTpcyHWwKKxKPyMHuXQy
         l5evcg4bnSW5ozPaxj0o9GSMqNl/UAEYwIWIk+tzQC6EubeiV8k9qZAN05UiNEmYlCjy
         MESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l9rVGvGqRB9qcdDl2IiiDsnLK4HD8J3eRDoZWHeXx8c=;
        b=TPFxCGEEDalLr8OdtCJCUjGQcveeM7+GRh6BfHJlmwrUXinZqVv5KU6lT2JMi0HBDf
         HNLZq1H7hpKDwi4gihBpA6yKqf/osLQDaehyoG/b3xLBQdwTYdgtvvxZM1oUGzJ2cV/f
         7EzeeZ9oX5H1CEVJlVsemoNMWa65msOIXq5q1loFnqgv6mVnvcr1UPC2/ml9SobWMmX0
         cd12/4CCUCW7CsjlbG189McwRrxGBvT5fcAqVIvJznbfSWOYjdabVy/5MIeWIf8fHc62
         LVZU0sKhLnPdav89DJNwCPrPWsD+aDtnDSlM2VE5Onhmj9i2eGY2U9N31SUriXVQ2iiw
         T4TA==
X-Gm-Message-State: APjAAAV42/zlIWDi/BJrOQOvQM1VRHDuen+KkQDGrwmnyLnnYBFk/vWc
        RFjY7mafYM4zs1C79PdtAuhUtylp5StwYOWF8cU=
X-Google-Smtp-Source: APXvYqzuhNMTvLV2Bg5W6kURIqF7+Z1EfwmT/7ziVrxj/uB6gGIn5b3ZpEOUkNwgAKAnggjdhRf36hKEy92N/HFv+yw=
X-Received: by 2002:a0c:9e02:: with SMTP id p2mr13412485qve.150.1559760936377;
 Wed, 05 Jun 2019 11:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190604223815.2487730-1-hechaol@fb.com> <BDC04C37-0C03-4D98-B4F2-437C7A746F88@fb.com>
 <C4921362-A75B-4333-91C7-437B4AA4C854@fb.com> <a6761839-7b1c-3504-0a96-28452c5b1450@iogearbox.net>
 <4F4DDA32-3BF0-40D7-BA75-7FA1A9FD0843@fb.com> <2a6ab005-0ac1-be09-d5dc-05ea672cbf9a@iogearbox.net>
 <8E01213E-C06A-4251-9982-FF8394A4BFF5@fb.com>
In-Reply-To: <8E01213E-C06A-4251-9982-FF8394A4BFF5@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jun 2019 11:55:25 -0700
Message-ID: <CAEf4BzYUqdUOidoJAStJh=Kg-h2+4CPRuJ2yLESfWa1CfB8aFw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Move bpf_num_possible_cpus() to libbpf_util
To:     Hechao Li <hechaol@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 5, 2019 at 10:41 AM Hechao Li <hechaol@fb.com> wrote:
>
>
> > On Jun 5, 2019, at 4:54 AM, Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
> >
> > On 06/05/2019 02:18 AM, Hechao Li wrote:
> >> I looked into current public APIs in libbpf.h and bpf.h. Most of them =
seem to be directly related to bpf object/program/map. But this function, b=
pf_num_possible_cpus(), is just a utility used while looking up per-CPU map=
s. I am not sure if it is appropriate to make it an official API. Yonghong,=
 the author of libbpf_util.h, also asked me to put it into libbpf_util. But=
 I am fine with either way. I can move it to libbpf.h/.c if you all agree.
> >
> > (please avoid top-posting)
> >
> > It's a good question, I think it depends how much we want to aide users=
 consuming libbpf
> > that are using per-CPU maps, for example. If we only want to reuse it f=
or in-tree selftests,
> > it's fine to keep it in an unexposed internal header that selftests wou=
ld include.
> > Other option could be to expose and prefix as libbpf_num_possible_cpus(=
) to denote it's a
> > misc helper and perhaps also move f3515b5d0b71 ("bpf: provide a generic=
 macro for percpu
> > values for selftests") into libbpf. I'd be fine either way, my preferen=
ce is to add it
> > as an libbpf_ API given users would need something along these lines wh=
en walking the value
> > anyway. See e00c7b216f34 ("bpf: fix multiple issues in selftest suite a=
nd samples") for
> > context on why this helper was added and sysconf(_SC_NPROCESSORS_CONF) =
use would be broken
> > in this context.
> >
> > Thanks,
> > Daniel
> >
> >> Thanks,
> >> Hechao
> >>
> >> On 6/4/19, 5:08 PM, "Daniel Borkmann" <daniel@iogearbox.net> wrote:
> >>
> >>    On 06/05/2019 01:54 AM, Hechao Li wrote:
> >>> I put the implementation in libbpf_util.c mainly because it depends o=
n pr_warning defined in libbpf_internal.h. If including libbpf_internal.h i=
n libbpf_util.h, then the internal stuff will be exposed to whoever include=
 libbpf_util.h. But let me know if there is a better way to print the error=
 messages other than depending on libbpf_internal.
> >>>
> >>> Thanks,
> >>> Hechao
> >>>
> >>> On 6/4/19, 4:40 PM, "Song Liu" <songliubraving@fb.com> wrote:
> >>>
> >>>
> >>>> On Jun 4, 2019, at 3:38 PM, Hechao Li <hechaol@fb.com> wrote:
> >>>>
> >>>> Getting number of possible CPUs is commonly used for per-CPU BPF map=
s
> >>>> and perf_event_maps. Putting it into a common place can avoid duplic=
ate
> >>>> implementations.
> >>>>
> >>>> Hechao Li (2):
> >>>> Add bpf_num_possible_cpus to libbpf_util
> >>>> Use bpf_num_possible_cpus in bpftool and selftests
> >>>>
> >>>> tools/bpf/bpftool/common.c                    | 53 ++--------------
> >>>> tools/lib/bpf/Build                           |  2 +-
> >>>> tools/lib/bpf/libbpf_util.c                   | 61 +++++++++++++++++=
++
> >>>> tools/lib/bpf/libbpf_util.h                   |  7 +++
> >>>> tools/testing/selftests/bpf/bpf_util.h        | 42 +++----------
> >>>> .../selftests/bpf/prog_tests/l4lb_all.c       |  2 +-
> >>>> .../selftests/bpf/prog_tests/xdp_noinline.c   |  2 +-
> >>>> tools/testing/selftests/bpf/test_btf.c        |  2 +-
> >>>> tools/testing/selftests/bpf/test_lru_map.c    |  2 +-
> >>>> tools/testing/selftests/bpf/test_maps.c       |  6 +-
> >>>> 10 files changed, 88 insertions(+), 91 deletions(-)
> >>>> create mode 100644 tools/lib/bpf/libbpf_util.c
> >>>>
> >>>> --
> >>>> 2.17.1
> >>>>
> >>>
> >>>    The change is mostly straightforward. However, I am not sure wheth=
er
> >>>    they should be added to libbpf_util.h. Maybe libbpf.h is a better
> >>>    place?
> >>>
> >>>    Daniel and Alexei, what's your recommendation here?
> >>
> >>    Hm, looks like the patch did not make it to the list (yet?). Agree =
it makes
> >>    sense to move it into libbpf given common use for per-CPU/perf-even=
t maps.
> >>    Given from the diff stat it's not added to libbpf.map, is there a r=
eason to
> >>    not add it to, say, tools/lib/bpf/libbpf.c and expose it as officia=
l API?
> >>
> >>    Thanks,
> >>    Daniel
> >>
> >>
> >
>
> Thanks a lot for the detailed explanation, Daniel. And sorry for the repl=
y format. Sure, I will add it as a libbpf_
> API instead. Moving  the macro BPF_DECLARE_PERCPU in selftest util to lib=
bpf also makes sense to me.
> However, since bpf_num_possible_cpus in selftest exits the process in cas=
e of failures, which is not good for
> a user facing API, how about making #CPU a param and define it as
>
> #define BPF_DECLARE_PERCPU(type, name, ncpu) \
>              struct { type v; } __bpf_percpu_val_align name[ncpu]
>
> And the user should do
> int ncpu =3D libbpf_num_possible_cpus();
> // error handling if ncpu <=3D0
> BPF_DECLARE_PERCPU(long, value, ncpu)
>
> The problem of this method is, the user may still pass sysconf(_SC_NPROCE=
SSORS_CONF) as ncpu.
> I think this can be avoided by putting some comments around this macro. D=
oes it make sense?
>

BPF_DECLARE_PERCPU doesn't do anything fancy and is used only from
single selftest, so I'd keep it where it is right now. There is no
need to pollute libbpf_internal.h with lots of stuff, if it's not
widely used.

For libbpf_num_possible_cpus() - definitely change it to return int
with <0 on error.

> Thanks,
> Hechao
>
