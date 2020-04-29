Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6871BDC33
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD2Mb4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 08:31:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:18882 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgD2Mb4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Apr 2020 08:31:56 -0400
IronPort-SDR: Kz2jzlWPxz2lbMCaGF0nA28a24ZVaMVnNLbMduRYuLkA9//9Encjz7l8uvuL7wGpqZ3at8gTbA
 /o6o7cb/TFFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 05:31:55 -0700
IronPort-SDR: wgubizt0x69lH+ZvDFBUTwZpoXVYu6G8bufARnTlZJNrgBmYDO2uhPNPh0A12xREoB/ZT1aOlr
 qqKGELXf9eCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="405026231"
Received: from amasrati-mobl1.ger.corp.intel.com (HELO [10.214.197.183]) ([10.214.197.183])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2020 05:31:48 -0700
Subject: Re: [PATCH bpf-next v9 0/8] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200329004356.27286-1-kpsingh@chromium.org>
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
Message-ID: <0165887d-e9d0-c03e-18b9-72e74a0cbd59@linux.intel.com>
Date:   Wed, 29 Apr 2020 15:31:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200329004356.27286-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 29/03/2020 02:43, KP Singh wrote:
> # How does it work?
> 
> The patchset introduces a new eBPF (https://docs.cilium.io/en/v1.6/bpf/)
> program type BPF_PROG_TYPE_LSM which can only be attached to LSM hooks.
> Loading and attachment of BPF programs requires CAP_SYS_ADMIN.
> 
> The new LSM registers nop functions (bpf_lsm_<hook_name>) as LSM hook
> callbacks. Their purpose is to provide a definite point where BPF
> programs can be attached as BPF_TRAMP_MODIFY_RETURN trampoline programs
> for hooks that return an int, and BPF_TRAMP_FEXIT trampoline programs
> for void LSM hooks.

I have two systems (a NUC and a qemu VM) that fail to boot if I enable
the BPF LSM without enabling SELinux first. Anything I might be missing
or are you able to trigger it too?

For instance, the following additional cmdline args: "lsm.debug=1
lsm="capability,apparmor,bpf" results in:

[    1.251889] Call Trace:
[    1.252344]  dump_stack+0x57/0x7a
[    1.252951]  panic+0xe6/0x2a4
[    1.253497]  ? printk+0x43/0x45
[    1.254075]  mount_block_root+0x30c/0x31b
[    1.254798]  mount_root+0x78/0x7b
[    1.255417]  prepare_namespace+0x13a/0x16b
[    1.256168]  kernel_init_freeable+0x210/0x222
[    1.257021]  ? rest_init+0xa5/0xa5
[    1.257639]  kernel_init+0x9/0xfb
[    1.258074]  ret_from_fork+0x35/0x40
[    1.258885] Kernel Offset: 0x11000000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    1.264046] ---[ end Kernel panic - not syncing: VFS: Unable to mount 
root fs on unknown-block(253,3)

Taking out "bpf" or adding "selinux" before it boots OK. I've tried
with both 5.7-rc2 and -rc3.

LSM logs:

[    0.267219] LSM: Security Framework initializing
[    0.267844] LSM: first ordering: capability (enabled)
[    0.267870] LSM: cmdline ignored: capability
[    0.268869] LSM: cmdline ordering: apparmor (enabled)
[    0.269508] LSM: cmdline ordering: bpf (enabled)
[    0.269869] LSM: cmdline disabled: selinux
[    0.270377] LSM: cmdline disabled: integrity
[    0.270869] LSM: exclusive chosen: apparmor
[    0.271869] LSM: cred blob size     = 8
[    0.272354] LSM: file blob size     = 24
[    0.272869] LSM: inode blob size    = 0
[    0.273362] LSM: ipc blob size      = 0
[    0.273869] LSM: msg_msg blob size  = 0
[    0.274352] LSM: task blob size     = 32
[    0.274873] LSM: initializing capability
[    0.275381] LSM: initializing apparmor
[    0.275880] AppArmor: AppArmor initialized
[    0.276437] LSM: initializing bpf
[    0.276871] LSM support for eBPF active

-- Regards, Mikko
