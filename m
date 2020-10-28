Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7B29D84B
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 23:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbgJ1WbK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 18:31:10 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:7364 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387849AbgJ1WbK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 18:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603924269; x=1635460269;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=QDDt48fvtUReXh4D+ECRysyY9kqbHnhxHr3iezMI364=;
  b=mK97a4rsRbpPBU+e+DUhrr0KdNwb7Jj9KYjh+dup5x5jSiSa26YqbbNq
   Eq36waw4jpr6MwPwDMFn7oXOwM19LDA+NfeXoeWq3D3rJmbEwUgqYzXKo
   g6jM55/GTQaEuHFyh3uXQFaWG3q6CrumyXZaVw/Ww05d1pe0O6nQyfVnK
   Q=;
X-IronPort-AV: E=Sophos;i="5.77,428,1596499200"; 
   d="scan'208";a="61703929"
Subject: Re: [PATCH] btf: Expose kernel BTF only to tasks with CAP_PERFMON
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 28 Oct 2020 22:31:01 +0000
Received: from EX13D47EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 99EA1A211F;
        Wed, 28 Oct 2020 22:31:00 +0000 (UTC)
Received: from 3c22fb434718.ant.amazon.com (10.43.160.52) by
 EX13D47EUB003.ant.amazon.com (10.43.166.246) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 28 Oct 2020 22:30:54 +0000
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dan Aloni <dan@kernelim.com>, bpf <bpf@vger.kernel.org>
CC:     <security@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
References: <20201028203853.2412751-1-dan@kernelim.com>
 <CAEf4BzZxabLCaNj0E5UEcnrEY25ujSLOzTbYRXneJy2HrY64JA@mail.gmail.com>
From:   "Alon, Liran" <liran@amazon.com>
Message-ID: <3bccbaac-ec63-bc06-0e4b-5501c0788822@amazon.com>
Date:   Thu, 29 Oct 2020 00:30:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZxabLCaNj0E5UEcnrEY25ujSLOzTbYRXneJy2HrY64JA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.52]
X-ClientProxiedBy: EX13D13UWA002.ant.amazon.com (10.43.160.172) To
 EX13D47EUB003.ant.amazon.com (10.43.166.246)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 28/10/2020 23:56, Andrii Nakryiko wrote:
> + bpf@vger.kernel.org
You shouldn't Cc public email lists for a patch submitted to 
security@kernel.org.
>
> On Wed, Oct 28, 2020 at 1:40 PM Dan Aloni <dan@kernelim.com> wrote:
>> Commit 341dfcf8d78e ("btf: expose BTF info through sysfs") added a sysfs
>> file that exposes to userspace kernel BTF information which allows
>> userspace to deduce the structure layout of all kernel internal
>> structures.
>>
>> This file is currently accessible to unprivileged users, without
>> requiring any special capability. Given that knowledge on kernel
>> structure layout is useful for dynamically building local privilege
>> escalation exploit in userspace, access to this file should be
>> restricted.
> So is /proc/config.gz, which is also very helpful in understanding
> what exactly is there in the kernel.
Viewing kernel build config is more like querying supported kernel features.
I don't consider it as a meaningful information disclosure, as I see 
disclosing
the kernel internal struct layout.
> So seems to be
> /boot/vmlinux-$(uname -r), which has exactly the same BTF data and
> more.
I agree. True. Good enough argument for dropping this patch.
>
> Guarding /sys/kernel/bpf/vmlinux behind CAP_PERFMON would break a lot
> of users relying on BTF availability to build their BPF applications.
True. If this patch is applied, would need to at least be behind an 
optin knob. Similar to dmesg_restrict.



