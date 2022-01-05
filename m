Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC36485813
	for <lists+bpf@lfdr.de>; Wed,  5 Jan 2022 19:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbiAESVB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 5 Jan 2022 13:21:01 -0500
Received: from msx.hs-osnabrueck.de ([131.173.88.34]:56403 "EHLO
        msx.hs-osnabrueck.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbiAESU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 13:20:59 -0500
Received: from sea-01.fhos.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 55C0D731207_1D5E186B;
        Wed,  5 Jan 2022 18:20:54 +0000 (GMT)
Received: from msx.hs-osnabrueck.de (Sinabung.FHOS.DE [192.168.179.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "msx.hs-osnabrueck.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by sea-01.fhos.de (Sophos Email Appliance) with ESMTPS id 26DCF72E6CC_1D5E186F;
        Wed,  5 Jan 2022 18:20:54 +0000 (GMT)
Received: from ROCKENSTEIN.FHOS.DE (192.168.179.25) by Sinabung.FHOS.DE
 (192.168.179.75) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 5 Jan
 2022 19:20:53 +0100
Received: from ROCKENSTEIN.FHOS.DE ([fe80::d109:b519:b2eb:52b4]) by
 Rockenstein.FHOS.DE ([fe80::d109:b519:b2eb:52b4%12]) with mapi id
 15.00.1497.026; Wed, 5 Jan 2022 19:20:53 +0100
From:   "Buchberger, Dennis" <dennis.buchberger@hs-osnabrueck.de>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: AW: [Extern] Re: Problem loading eBPF program on Kernel 4.18 (best
 with CO:RE): -EINVAL
Thread-Topic: [Extern] Re: Problem loading eBPF program on Kernel 4.18 (best
 with CO:RE): -EINVAL
Thread-Index: AQHYAhp5eI29nHop60CO4GOJmoPCtqxULQ4AgAAwfxc=
Date:   Wed, 5 Jan 2022 18:20:53 +0000
Message-ID: <1641406853508.18736@hs-osnabrueck.de>
References: <1641377010132.82356@hs-osnabrueck.de>,<YdV2NgMG/EWwJVQn@kroah.com>
In-Reply-To: <YdV2NgMG/EWwJVQn@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.179.139]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>> Hello :)
>>
>> I am currently having a problem and hope you can help me: My goal is to develop a BPF-program (see below) on a development machine and then deploy it to another machine to run it there using BPF CO:RE.
>> But the program does not load; bpf_object__load returns -EINVAL.
>>
>> Development machine:
>> - Ubuntu 20.04 LTS
>> - Linux 5.4.0-90-generic x86_64
>> - Kernel compiled with CONFIG_DEBUG_INFO_BTF=y, so BTF is available under /sys/kernel/btf/vmlinux
>> - clang version: 10.0.0-4ubuntu1
>> - llc version: 10.0.0
>>
>> Target machine:
>> - Ubuntu 18.10
>> - Linux 4.18.0-25-generic x86_64
>
> 4.18 is very old and obsolete and insecure and only supported by the
> vendor you are paying support from.  Please upgrade to a more modern
> kernel (4.18 was released way back in 2018), if you wish to get help
> from the kernel community.
> 
> Actually, the vendor you are paying for support to stay at this old
> kernel version should be able to provide help to you, why not ask them?
> 
> thanks,
> 
> greg k-h

Ubuntu 18.04 LTS is still out there and did not reach its end of maintenance; 18.10 is even a bit newer. So yes, it is not up to date, but I would not consider it very old or obsolete.
Actually, I am a student and not paying any vendor I could ask.

BPF CO:RE stands for Compile Once, Run >Everywhere<, so I do wonder why it does not work - it should, no matter wether it is kernel 4.18 or another one, should't it?.

I just get started to eBPF programming and find it difficult to get documentation and examples on how to do it in a not-deprecated way without using bcc, bpftrace or skeletons.

It is quite a simple program, why does it fail getting loaded on 4.18 but not on 5.4?:

SEC("kprobe/")
int trace_func_entry(struct pt_regs *ctx) {
    u64 pid_tgid = bpf_get_current_pid_tgid();
    u32 pid = pid_tgid;

    int arg1;
    int arg2;

    arg1 = BPF_CORE_READ(ctx, di);
    arg2 = PT_REGS_PARM2_CORE(ctx);

    __u32 key = 0;
    struct stack_trace_t* data;
    data = bpf_map_lookup_elem(&stackdata_map, &key);
	if (!data)
		return 0;

    size_t max_len = MAX_STACK_RAWTP * sizeof(__u64);
    data->user_stack_size = bpf_get_stack(ctx, data->user_stack, max_len, BPF_F_USER_STACK);
    return 0;
}

Thanks for any help
Dennis

