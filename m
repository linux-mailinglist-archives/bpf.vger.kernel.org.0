Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8962A0410
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 12:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgJ3LYG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 07:24:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55603 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJ3LYF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 07:24:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CN0Lp2L3Gz9sTD;
        Fri, 30 Oct 2020 22:24:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604057043;
        bh=1921BYj0UW4d0ZcLBKhvGnqz9a10y136F0EiqIep73c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BNwBUdxk334VdxuvKh4tfMmfNYQt2uhE/Rwfi3Oy2ijuKnDPD9kX3QMJXwkjiQ0Wy
         1eQwasPLmIAw34GrlUPZXkRQRy7oj3yWDmYpsG1HwfiDkElpDhozzWUsLPQuhNMsXC
         YPdZDQfz0TSK/fmRUopsFLm1m1rrS1mt+siLOWTjtwzY8VPWnxd00LwADvybHz7QNC
         +3/a/wzBVjrqaYv+o/G7itU7aK0DGyMf3Pn74Nx6sg8zkDNOZD3AYmksVxwt3OGN+q
         Cuq8dHwwL4w3BbbF3pwOwCuthahIag5gUxhGT+b/5eKu9RdtSuQ7E2s/H0VMBsxdAt
         WH3ekx2zybthw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Willy Tarreau <w@1wt.eu>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Alon\, Liran" <liran@amazon.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dan Aloni <dan@kernelim.com>, bpf <bpf@vger.kernel.org>,
        security@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH] btf: Expose kernel BTF only to tasks with CAP_PERFMON
In-Reply-To: <20201029041501.GA16341@1wt.eu>
References: <20201028203853.2412751-1-dan@kernelim.com> <CAEf4BzZxabLCaNj0E5UEcnrEY25ujSLOzTbYRXneJy2HrY64JA@mail.gmail.com> <3bccbaac-ec63-bc06-0e4b-5501c0788822@amazon.com> <20201028230602.4g7guvb5nzgosgwb@ast-mbp.dhcp.thefacebook.com> <20201029041501.GA16341@1wt.eu>
Date:   Fri, 30 Oct 2020 22:23:57 +1100
Message-ID: <87k0v8ufci.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:
> On Wed, Oct 28, 2020 at 04:06:02PM -0700, Alexei Starovoitov wrote:
>> On Thu, Oct 29, 2020 at 12:30:49AM +0200, Alon, Liran wrote:
>> > > Guarding /sys/kernel/bpf/vmlinux behind CAP_PERFMON would break a lot
>> > > of users relying on BTF availability to build their BPF applications.
>> > True. If this patch is applied, would need to at least be behind an optin
>> > knob. Similar to dmesg_restrict.
>> 
>> It's not going to be applied. If a file shouldn't be read by a user
>> it should have appropriate file permissions instead of 444.
>> Checking capable() in read() is very non-unix way to deal with permissions.
>
> Not only it's a non-unix way, both don't achieve the same goals at all!
>
> One checks for permissions at open() time and may for example allow a
> process to drop its uid after opening, while the other one allows to
> filter who can really read it, particularly in case the FD is inherited
> between processes. With this said, I don't see why there would be a
> special case for this one, it should definitely stick to file permissions
> only.

From include/linux/bpf.h:

static inline bool bpf_allow_ptr_leaks(void)
{
	return perfmon_capable();
}

static inline bool bpf_allow_ptr_to_map_access(void)
{
	return perfmon_capable();
}

static inline bool bpf_bypass_spec_v1(void)
{
	return perfmon_capable();
}

static inline bool bpf_bypass_spec_v4(void)
{
	return perfmon_capable();
}


There's also several cases in bpf_base_func_proto().

So it seems entirely reasonable to suggest that perfmon_capable() is the
right check here.

cheers
