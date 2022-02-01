Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED44A58C1
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 09:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiBAIqp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 03:46:45 -0500
Received: from www62.your-server.de ([213.133.104.62]:59276 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiBAIqo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 03:46:44 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nEooE-0002k2-Pz; Tue, 01 Feb 2022 09:46:42 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nEooE-000C8V-GV; Tue, 01 Feb 2022 09:46:42 +0100
Subject: Re: [PATCH v2 bpf-next] libbpf: deprecate xdp_cpumap and xdp_devmap
 sec definitions
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>
References: <d456931681fe2344ae56225a698a0bd1d5c63b88.1643375942.git.lorenzo@kernel.org>
 <CAEf4Bzbt--iLcctUq+D_CXY0qyDRi3_uWc=vvOV4z-eQvum2cA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5ac647bb-e596-0dd1-8120-3c93a262202a@iogearbox.net>
Date:   Tue, 1 Feb 2022 09:46:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzbt--iLcctUq+D_CXY0qyDRi3_uWc=vvOV4z-eQvum2cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26439/Mon Jan 31 10:24:40 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/1/22 6:50 AM, Andrii Nakryiko wrote:
> On Fri, Jan 28, 2022 at 5:29 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>>
>> Deprecate xdp_cpumap xdp_devmap sec definitions.
>> Introduce xdp/devmap and xdp/cpumap definitions according to the standard
>> for SEC("") in libbpf:
>> - prog_type.prog_flags/attach_place
>> Update cpumap/devmap samples and kselftests
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>> Changes since v1:
>> - refer to Libbpf-1.0-migration-guide in the warning rised by libbpf
>> ---
>>   samples/bpf/xdp_redirect_cpu.bpf.c                   |  8 ++++----
>>   samples/bpf/xdp_redirect_map.bpf.c                   |  2 +-
>>   samples/bpf/xdp_redirect_map_multi.bpf.c             |  2 +-
>>   tools/lib/bpf/libbpf.c                               | 12 ++++++++++--
>>   .../bpf/progs/test_xdp_with_cpumap_frags_helpers.c   |  2 +-
>>   .../bpf/progs/test_xdp_with_cpumap_helpers.c         |  2 +-
>>   .../bpf/progs/test_xdp_with_devmap_frags_helpers.c   |  2 +-
>>   .../bpf/progs/test_xdp_with_devmap_helpers.c         |  2 +-
>>   .../selftests/bpf/progs/xdp_redirect_multi_kern.c    |  2 +-
> 
> Please split samples/bpf, selftests/bpf, and libbpf changes into
> separate patches. We keep them separate whenever possible.
> 
>>   9 files changed, 21 insertions(+), 13 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 4ce94f4ed34a..ba003cabe4a4 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -237,6 +237,8 @@ enum sec_def_flags {
>>          SEC_SLOPPY_PFX = 16,
>>          /* BPF program support non-linear XDP buffer */
>>          SEC_XDP_FRAGS = 32,
>> +       /* deprecated sec definitions not supposed to be used */
>> +       SEC_DEPRECATED = 64,
>>   };
>>
>>   struct bpf_sec_def {
>> @@ -6575,6 +6577,10 @@ static int libbpf_preload_prog(struct bpf_program *prog,
>>          if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
>>                  opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>>
>> +       if (def & SEC_DEPRECATED)
>> +               pr_warn("sec '%s' is deprecated, please take a look at https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide\n",
>> +                       prog->sec_name);
>> +
> 
> Please add a link directly to [0]. I just added a new section listing
> xdp_devmap and xdp_cpumap. I also added SEC("classifier") ->
> SEC("tc"), so let's mark SEC("classifier") as deprecated as well in
> the next revision?
> 
> Daniel, does that sound reasonable to you or should we leave
> SEC("classifier") intact?

Yeap, sounds reasonable, lets mark "classifier" as SEC_DEPRECATED, too.

> Let's use also the syntax consistent with the code people write.
> Something like "SEC(\"%s\") is deprecated, please see
> https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#bpf-program-sec-annotation-deprecations
> for details"?
> 
>    [0] https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#bpf-program-sec-annotation-deprecations
> 
>>          if ((prog->type == BPF_PROG_TYPE_TRACING ||
>>               prog->type == BPF_PROG_TYPE_LSM ||
>>               prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
>> @@ -8618,9 +8624,11 @@ static const struct bpf_sec_def section_defs[] = {
>>          SEC_DEF("iter.s/",              TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
>>          SEC_DEF("syscall",              SYSCALL, 0, SEC_SLEEPABLE),
>>          SEC_DEF("xdp.frags/devmap",     XDP, BPF_XDP_DEVMAP, SEC_XDP_FRAGS),
>> -       SEC_DEF("xdp_devmap/",          XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
>> +       SEC_DEF("xdp/devmap",           XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
>> +       SEC_DEF("xdp_devmap/",          XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
>>          SEC_DEF("xdp.frags/cpumap",     XDP, BPF_XDP_CPUMAP, SEC_XDP_FRAGS),
>> -       SEC_DEF("xdp_cpumap/",          XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
>> +       SEC_DEF("xdp/cpumap",           XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
>> +       SEC_DEF("xdp_cpumap/",          XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
>>          SEC_DEF("xdp.frags",            XDP, BPF_XDP, SEC_XDP_FRAGS),
>>          SEC_DEF("xdp",                  XDP, BPF_XDP, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
>>          SEC_DEF("perf_event",           PERF_EVENT, 0, SEC_NONE | SEC_SLOPPY_PFX),
> 
> [...]
> 

