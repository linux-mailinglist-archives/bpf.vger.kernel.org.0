Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB0159DCA
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 01:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgBLAJQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 19:09:16 -0500
Received: from www62.your-server.de ([213.133.104.62]:39780 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgBLAJQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 19:09:16 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j1faW-0007DH-Se; Wed, 12 Feb 2020 01:09:09 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j1faW-000ETx-4j; Wed, 12 Feb 2020 01:09:08 +0100
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jann Horn <jannh@google.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp> <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
 <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp>
 <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp>
 <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
 <20200211213819.j4ltrjjkuywihpnv@ast-mbp>
 <CAADnVQLsiWgSBXbuxmpkC9TS8d1aQRw2zDHG8J6E=kfcRoXtKQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1cd10710-a81b-8f9b-696d-aa40b0a67225@iogearbox.net>
Date:   Wed, 12 Feb 2020 01:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAADnVQLsiWgSBXbuxmpkC9TS8d1aQRw2zDHG8J6E=kfcRoXtKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.1/25720/Mon Feb 10 12:53:41 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/12/20 12:26 AM, Alexei Starovoitov wrote:
> On Tue, Feb 11, 2020 at 1:38 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Feb 11, 2020 at 09:33:49PM +0100, Jann Horn wrote:
>>>>
>>>> Got it. Then let's whitelist them ?
>>>> All error injection points are marked with ALLOW_ERROR_INJECTION().
>>>> We can do something similar here, but let's do it via BTF and avoid
>>>> abusing yet another elf section for this mark.
>>>> I think BTF_TYPE_EMIT() should work. Just need to pick explicit enough
>>>> name and extensive comment about what is going on.
>>>
>>> Sounds reasonable to me. :)
>>
>> awesome :)
> 
> Looks like the kernel already provides this whitelisting.
> $ bpftool btf dump file /sys/kernel/btf/vmlinux |grep FUNC|grep '\<security_'
> gives the list of all LSM hooks that lsm-bpf will be able to attach to.
> There are two exceptions there security_add_hooks() and security_init().
> Both are '__init'. Too late for lsm-bpf to touch.
> So filtering BTF funcs by 'security_' prefix will be enough.
> It should be documented though.
> The number of attachable funcs depends on kconfig which is
> a nice property and further strengthen the point that
> lsm-bpf is very much kernel specific.
> We probably should blacklist security_bpf*() hooks though.

One thing that is not quite clear to me wrt the fexit approach; assuming
we'd whitelist something like security_inode_link():

int security_inode_link(struct dentry *old_dentry, struct inode *dir,
                          struct dentry *new_dentry)
{
         if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
                 return 0;
         return call_int_hook(inode_link, 0, old_dentry, dir, new_dentry);
}

Would this then mean the BPF prog needs to reimplement above check by
probing old_dentry->d_inode to later ensure its verdict stays 0 there
too, or that such extra code is to be moved to call-sites instead? If
former, what about more complex logic?

Another approach could be to have a special nop inside call_int_hook()
macro which would then get patched to avoid these situations. Somewhat
similar like static keys where it could be defined anywhere in text but
with updating of call_int_hook()'s RC for the verdict.

Thanks,
Daniel
