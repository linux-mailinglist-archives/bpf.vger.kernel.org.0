Return-Path: <bpf+bounces-49176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFCEA14D99
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687E7188C3FB
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5811F9EA0;
	Fri, 17 Jan 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ZAjNqbSR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F81F63ED
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109910; cv=none; b=VawSciyPUOo3YhDTLeg0K9WLGrGoIXI8Q+qPVibQT+A/sg1oEvAwpijP7/P+sKgoLI8XBv/E2eIcoPFdUQFWvrkkH+m6CGR08O0NaG9cPcxCcxL2TK/+YwWHJMG3wqMbDyII73S3+Iheo6dMZlnWt+gOobmmWWMW1LvgUqVJxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109910; c=relaxed/simple;
	bh=jZtcWczJkWQSm7PfylScafoMlcdX3+Xl7ux2Pxfj7yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSYDA2st7FRDRVnuH0cniovxiG99n/ZwYYrwy7u7M9wQeEo94Elu4YlB/BLB7UCkJDl9lHIQNMm57OFUrmhOT0h148c5NaadZkuL1U434dGJrKCf3elHpMUmiuZgzrgFQvF4yzq3TkGagp6PXuYLVDYVz8COhzuiKDV0b8jSVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ZAjNqbSR; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso343883766b.1
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 02:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1737109906; x=1737714706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cNwFhA5vTka5BCVv0SiX0chrl8U101YQ0RQsv3+bOhc=;
        b=ZAjNqbSR4diMoiKphyzOXdVtkkBKt4p9T08X8+MTZsIXEYaqHaIpK80vpTYsGPTvKI
         qpNVMUvOs6sYfa4Y9InfS90VEmmxkMToKgODPM7S5e8vwliOcdzX10OaibnSF+wHIfrk
         Y99TZbQLlA4nGNiyXC/3Pqp+CdzJv/L5a5tk/R4TfXjpAwhp1UIG/+lg8SikUNdylDsb
         kc46WvPrq5oM9XZ+cyrQhX6SqUQDedukgmtVqF5OwBw6UvBr3j0tiIzJtXIOji6MgiwI
         roelck544PJYGR4C4FtjEG14HgXsFikD6oevXDxuEdkVHFLc94s9lAbPalAM8sZ2lf3C
         tklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737109906; x=1737714706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNwFhA5vTka5BCVv0SiX0chrl8U101YQ0RQsv3+bOhc=;
        b=ZI460vUo8mZBB15gYMPJ8oFz7SvPl92X8hKQ5BQIcSAHBmzFNRoxuTMXm6t8pik5En
         MIHIOeJvJE9nWBuOjSW/nHMxElyPB9Hm91oDbjpkfFqYn5L+HymvB/EBdYRDuinTXTci
         Bd9hw+uB1I7qK0Yfc5tLqCMXRjJoA4qkwhPyX+uJ/0h9jxF638nSYGJgIeLzBKbgNaV3
         Q6I+tnXTfPyfZPn8Pk7jP7mW6SS7psxB0eN1wC6DaClj4fj38M7kQIX7yd3z//Z7/58i
         M+jElPNedPGdJk/W4dCrU/Uy+sCcNb7e83HFnXxJqglqvgpb14YaPnEP/QKc2TJwauXs
         /mYg==
X-Forwarded-Encrypted: i=1; AJvYcCX+2ZEs5c9FgtasUyFFp8liEzAoQqsRQ+CUkN6/XokZsTzcOvWYXzS/psEiDXlMW1GsVic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Q1NxVeKiAXH8/ZxdJ1OcklpfuwsoY577xRD5yqb5IxSxQnLx
	yvytRdrwFo6lai72IREK++gxwmglaoZrl57LSNX0o3CIzH1kGLEgT784iAHRiHZklRVSwqvS+2p
	f
X-Gm-Gg: ASbGncsONkGCImUnjXlh0RaCAmi4Fz1QxytGtSXLEu0JR61aKuwagciriBEHR1Owxjv
	i3BUbCZsuKrw6pD5HBseL0RExi/Sq8IZwrAdm+Lq01lEU2eiZG7ygp/HKdPH3e+r+tElhXFc9QV
	OuVJNIiey6TRd6z3GwSYyRSMPXM8wIg9d0dQoj0T0a5S0mc4nEgOgzedpX0nTQnChmNhA6VWaj2
	FZYXah5pWeU6TXygZtMaR2oKGOY6T87rQft/pRRYt1PmA==
X-Google-Smtp-Source: AGHT+IHGh2AMhadR21zLBrsnmcBHQzANkF4mAMLKV1tuJsf9gdLnUp6JwYXKtjbhhliM6WEWTqdFqQ==
X-Received: by 2002:a17:907:2da6:b0:ab3:25c9:fbf0 with SMTP id a640c23a62f3a-ab38b48c301mr198244466b.56.1737109906438;
        Fri, 17 Jan 2025 02:31:46 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f87065sm146789566b.133.2025.01.17.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:31:45 -0800 (PST)
Date: Fri, 17 Jan 2025 10:35:47 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Nick Zavaritsky <mejedi@gmail.com>
Cc: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>, aspsk2@gmail.com
Subject: Re: [PATCH bpf-next 0/4] expose number of map entries to userspace
Message-ID: <Z4oygzEgfLqGCCNA@eis>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
 <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net>
 <Z3zcTB+SjPK5QOt9@eis>
 <CAAvdH+yNG=GefEd5CcP_52gPzzZexWMMxFAxnM3isX04iErMfQ@mail.gmail.com>
 <CAAvdH+wHjWEvO3e0_=o4imJZq1082pzp-qszbQvj_Ev50eQCrw@mail.gmail.com>
 <Z4AJY8orP8JMzvhW@eis>
 <68891842-975E-48B0-AED5-875F3ABC5F49@gmail.com>
 <Z4ke1A1agEko41v8@eis>
 <AC7968EC-73CA-415B-8FAD-70C805075479@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AC7968EC-73CA-415B-8FAD-70C805075479@gmail.com>

On 25/01/16 06:52PM, Nick Zavaritsky wrote:
> 
> > On 16. Jan 2025, at 15:59, Anton Protopopov <aspsk@isovalent.com> wrote:
> > 
> > On 25/01/14 12:38PM, Nick Zavaritsky wrote:
> >> 
> >>> On 9. Jan 2025, at 18:37, Anton Protopopov <aspsk@isovalent.com> wrote:
> >>> 
> >>> On 25/01/07 12:10PM, Charalampos Stylianopoulos wrote:
> >>>> (sorry for double posting, this time in plain text)
> >>>> Thanks a lot for the feedback!
> >>>> 
> >>>> So, to double check, the suggestion is to only extend the libbpf API
> >>>> with a new helper that does pretty much what get_cur_elements() does
> >>>> in tools/testing/selftests/bpf/map_tests/map_percpu_stats.c ?
> >>> 
> >>> What is your use case for getting the number of elements in a
> >>> particular map? Will it work for you to just use a variant of
> >>> get_cur_elements() from selftests vs. adding new API to libbpf?
> >> 
> >> (On behalf of Charalampos Stylianopoulos) we would like to get the
> >> number of elements in some maps for monitoring purposes. The end goal is
> >> to get someone paged when a fixed-capacity map is about to start
> >> rejecting inserts.
> >> 
> >> We aim to operate a large number of apps in containers (custom packet
> >> processing services, telekom). We find it most convenient for an app
> >> itself to expose metrics concerning the maps it has created.
> >> 
> >> We currently use a map iterator and a bunch of bpf_probe_read_kernel. We
> >> foresee the number of maps in our systems getting significantly higher
> >> in the near future. Therefore enumerating every map in the system to get
> >> a number of elements in a particular map doesn't look sustainable.
> >> 
> >> How do you feel about introducing bpf_map_sum_elem_count_by_fd kfunc,
> >> available in syscall programs?
> > 
> > This should work already, something like
> > 
> >    __s64 bpf_map_sum_elem_count(const struct bpf_map *map) __ksym;
> >    __s64 ret_user;
> > 
> >    struct {
> >            __uint(type, BPF_MAP_TYPE_HASH);
> >            __type(key, int);
> >            __type(value, int);
> >            __uint(max_entries, 4);
> >    } your_map SEC(".maps");
> > 
> >    SEC("syscall")
> >    int sum(void *ctx)
> >    {
> >            struct bpf_map *map = (struct bpf_map *)&your_map;
> > 
> >            ret_user = bpf_map_sum_elem_count(map);
> > 
> >            return 0;
> >    }
> > 
> >    char _license[] SEC("license") = "GPL";
> > 
> > Is this sufficient for your use case?
> 
> Technically it works. One can add a program similar to the snippet below
> to their bpf code to expose the number of elements in every map of
> interest.
> 
> struct stats { __s64 a, b, c, d; };
> SEC(“.maps”) struct { ... } a, b, c, d;
> 
> SEC(“syscall”)
> int sum_element_count_bulk(void *ctx)
> {
>     struct stats *stats = ctx;
>     stats->a = bpf_map_sum_element_count((void *)a);
>     stats->b = bpf_map_sum_element_count((void *)b);
>     ...
>     return 0;
> }
> 
> The downside is that it is boilerplate code that has to be written every
> single time. With the proposed bpf_map_sum_element_count_by_fd, one can
> have a library in user space that offers convenient
> sum_element_count(int fd).
> 
> It could leverage the following bpf program behind the scenes:
> 
> SEC(“syscall”)
> int sum_element_count(void *ctx)
> {
>     *(__s64 *)ctx = bpf_map_sum_element_count_by_fd(*(int *)ctx);
>     return 0;
> }

Makes sense. And this can also be used for multiple maps in one call.

I've quickly tested that the following implementation works, please
send a patch + selftests. Note that unlike the bpf_map_sum_elem_count
function, the bpf_map_sum_elem_count_by_fd should be only allowed for
SYSCALL programs.

__bpf_kfunc s64 bpf_map_sum_elem_count_by_fd(int fd)
{
        struct bpf_map *map;
        s64 ret;

        map = bpf_map_get(fd);
        if (IS_ERR(map))
                return 0;

        ret = bpf_map_sum_elem_count(map);
        bpf_map_put(map);
        return ret;
}

> > 
> >>> 
> >>> [Also, please try not to top-post, see https://www.idallen.com/topposting.html]
> >>> 
> >>>>> On Tue, 7 Jan 2025 at 08:44, Anton Protopopov <aspsk@isovalent.com> wrote:
> >>>>>> 
> >>>>>> On 25/01/06 05:19PM, Daniel Borkmann wrote:
> >>>>>>> On 1/6/25 3:53 PM, Charalampos Stylianopoulos wrote:
> >>>>>>>> This patch series provides an easy way for userspace applications to
> >>>>>>>> query the number of entries currently present in a map.
> >>>>>>>> 
> >>>>>>>> Currently, the number of entries in a map is accessible only from kernel space
> >>>>>>>> and eBPF programs. A userspace program that wants to track map utilization has to
> >>>>>>>> create and attach an eBPF program solely for that purpose.
> >>>>>>>> 
> >>>>>>>> This series makes the number of entries in a map easily accessible, by extending the
> >>>>>>>> main bpf syscall with a new command. The command supports only maps that already
> >>>>>>>> track utilization, namely hash maps, LPM maps and queue/stack maps.
> >>>>>>> 
> >>>>>>> An earlier attempt to directly expose it to user space can be found here [0], which
> >>>>>>> eventually led to [1] to only expose it via kfunc for BPF programs in order to avoid
> >>>>>>> extending UAPI.
> >>>>>>> 
> >>>>>>> Perhaps instead add a small libbpf helper (e.g. bpf_map__current_entries to complement
> >>>>>>> bpf_map__max_entries) which does all the work to extract that info via [1] underneath?
> >>>>>> 
> >>>>>> One small thingy here is that bpf_map_sum_elem_count() is only
> >>>>>> available from the map iterator. Which means that to get the
> >>>>>> bpf_map_sum_elem_count() for one map only, one have to iterate
> >>>>>> through the whole set of maps (and filter out all but one).
> >>>>>> 
> >>>>>> I wanted to follow up my series by either adding the result of
> >>>>>> calling bpf_map_sum_elem_count() to map_info as u32 or to add
> >>>>>> possibility to provide a map_fd/map_id when creating an iterator
> >>>>>> (so that it is only called for one map). But so far I haven't
> >>>>>> a real use case for getting the number of elements for one map only.
> >>>>>> 
> >>>>>>> Thanks,
> >>>>>>> Daniel
> >>>>>>> 
> >>>>>>> [0] https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/
> >>>>>>> [1] https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/
> >>>>>>>     https://lore.kernel.org/bpf/20230719092952.41202-1-aspsk@isovalent.com/
> >>>>>>> 
> >>>>>>>> Charalampos Stylianopoulos (4):
> >>>>>>>>  bpf: Add map_num_entries map op
> >>>>>>>>  bpf: Add bpf command to get number of map entries
> >>>>>>>>  libbpf: Add support for MAP_GET_NUM_ENTRIES command
> >>>>>>>>  selftests/bpf: Add tests for bpf_map_get_num_entries
> >>>>>>>> 
> >>>>>>>> include/linux/bpf.h                           |  3 ++
> >>>>>>>> include/linux/bpf_local_storage.h             |  1 +
> >>>>>>>> include/uapi/linux/bpf.h                      | 17 +++++++++
> >>>>>>>> kernel/bpf/devmap.c                           | 14 ++++++++
> >>>>>>>> kernel/bpf/hashtab.c                          | 10 ++++++
> >>>>>>>> kernel/bpf/lpm_trie.c                         |  8 +++++
> >>>>>>>> kernel/bpf/queue_stack_maps.c                 | 11 +++++-
> >>>>>>>> kernel/bpf/syscall.c                          | 32 +++++++++++++++++
> >>>>>>>> tools/include/uapi/linux/bpf.h                | 17 +++++++++
> >>>>>>>> tools/lib/bpf/bpf.c                           | 16 +++++++++
> >>>>>>>> tools/lib/bpf/bpf.h                           |  2 ++
> >>>>>>>> tools/lib/bpf/libbpf.map                      |  1 +
> >>>>>>>> .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
> >>>>>>>> tools/testing/selftests/bpf/test_maps.c       | 35 +++++++++++++++++++
> >>>>>>>> 14 files changed, 171 insertions(+), 1 deletion(-)
> 
> 

