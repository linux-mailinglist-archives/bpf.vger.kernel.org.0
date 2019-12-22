Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0529B128C25
	for <lists+bpf@lfdr.de>; Sun, 22 Dec 2019 02:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLVB1a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Dec 2019 20:27:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41059 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfLVB13 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Dec 2019 20:27:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so7311869pfw.8;
        Sat, 21 Dec 2019 17:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tkfasVhjkiXRo4y/SdMA6WHfZdAOzeb5acRwT7JCd/4=;
        b=Q86FXMrhLCdpVxdd76AiAH284fsVdwUdoMnkAPH0AxmHClF+KlWTIwqu1QmOeVrx7V
         iBQESqVRZ2uaLBzsb/MlHk+12o1/DpwrjIGOBXAkJWUtAcLRvwcF7GHV7uKJ24zBNkqk
         MfdUP5c+oqjM0ydAnK0aTp+uUSFQgZN/bvYcbq2DWPJmV+s4j4XX66r1JbEGPzk/QDOc
         1KzXjqLG1HfnVTh+dQnB2SXN/LHyTIMBJReqcOff0pEHHSNgFt0ZETKMJw3xjuZKpZTR
         L08fIxgUnOlp0QAiQd9gMTWb7/oxHKGxPDaJzy6efo3NCiwExh1jzRhZmTtJ1npEEzRL
         gS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tkfasVhjkiXRo4y/SdMA6WHfZdAOzeb5acRwT7JCd/4=;
        b=r50BGiKn6JF1/OCQZWMjQjtsy9JY8KShozPWDDjqs9xYxRt6DUWgIbE6sHAclD0QlB
         RyjYqRd1dP6IgvBawVy78ahfwSv9W7B80NR1wOvV9UthOS4YEzB/WHdnV3GwrrGrN1Mu
         uIv8Di8Stn8at9fGxjAi6S0xZiejzELsAg3CmzsEG7G4QNozzyeS6ROwXFGCv8GofYb5
         4eiJcBP4salV4xaihhgblVZACJDtq4Lq1zomcDvCpflZ1xRb0qqkeW1zLqFJGxKS0P5e
         2p4U78nM9NV2Wp+XaIgm51GErBu6SIVzRPa4byr/m/8XvjfThfYdN3Q5FM0YusLsv/Ek
         uRaw==
X-Gm-Message-State: APjAAAWlJJoNojfvXSnbQO3ghbfhVtRBXtKBxJW6Lf/v6Fv7aFCC4bct
        2VuZmnauwCxh/ThN8fYkdbM=
X-Google-Smtp-Source: APXvYqyzF37Wr83/MMsHlAx39SfrIAzDHVoFQd5qust1Gyqf3rJp3+h++6iETeKkUjVBQJsml6C/gQ==
X-Received: by 2002:a65:6815:: with SMTP id l21mr22943252pgt.283.1576978048431;
        Sat, 21 Dec 2019 17:27:28 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::2aea])
        by smtp.gmail.com with ESMTPSA id 189sm19019028pfw.73.2019.12.21.17.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 17:27:27 -0800 (PST)
Date:   Sat, 21 Dec 2019 17:27:24 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20191222012722.gdqhppxpfmqfqbld@ast-mbp.dhcp.thefacebook.com>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 04:41:55PM +0100, KP Singh wrote:
> // Declare the eBPF program mprotect_audit which attaches to
> // to the file_mprotect LSM hook and accepts three arguments.
> BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
> 	    struct vm_area_struct *, vma,
> 	    unsigned long, reqprot, unsigned long, prot
> {
> 	unsigned long vm_start = _(vma->vm_start);
> 	return 0;
> }

I think the only sore point of the patchset is:
security/bpf/include/hooks.h   | 1015 ++++++++++++++++++++++++++++++++
With bpf trampoline this type of 'kernel types -> bpf types' converters
are no longer necessary. Please take a look at tcp-congestion-control patchset:
https://patchwork.ozlabs.org/cover/1214417/
Instead of doing similar thing (like your patch 1 plus patch 6) it's using
trampoline to provide bpf based congestion control callbacks into tcp stack.
The same trampoline-based mechanism can be reused by bpf_lsm.
Then all manual work of doing BPF_LSM_HOOK(...) for every hook won't be
necessary. It will also prove the point that attaching BPF to raw LSM hooks
doesn't freeze them into stable abi.
The programs can keep the same syntax as in your examples:
BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
libbpf will find file_mprotect's btf_id in kernel vmlinux and pass it to
the kernel for attaching. Just like fentry/fexit bpf progs are doing
and just like bpf-based cc is doing as well.

> In order to better illustrate the capabilities of the framework some
> more advanced prototype code has also been published separately:
> 
> * Logging execution events (including environment variables and arguments):
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c
> * Detecting deletion of running executables:
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_detect_exec_unlink.c
> * Detection of writes to /proc/<pid>/mem:
> https://github.com/sinkap/linux-krsi/blob/patch/v1/examples/samples/bpf/lsm_audit_env.c

Thank you for sharing these examples. That definitely helps to see more
complete picture. I noticed that the examples are using the pattern:
  u32 map_id = 0;
  env = bpf_map_lookup_elem(&env_map, &map_id);
Essentially they're global variables. libbpf already supports them.
bpf prog can use them as:
  struct env_value env;
  int bpf_prog(..)
  {
    env.name... env.value..
  }
That will make progs a bit easier to read and faster too.
Accesing global vars from user space is also trivial with skeleton work:
  lsm_audit_env_skel->bss->env.name... env.value.
Both bpf side and user side can access globals as normal C variables.

There is a small issue in the patches 8 and 10.
bpf program names are not unique and bpf-lsm should not require them to be different.
bpf_attr->prog_name is also short at 16 bytes. It's for introspection only.
Longer program names are supplied via btf's func_info.
It feels that:
cat /sys/kernel/security/bpf/process_execution
env_dumper__v2
is reinventing the wheel. bpftool is the main introspection tool.
It can print progs attached to perf, cgroup, networking. I think it's better to
stay consistent and do the same with bpf-lsm.

Another issue is in proposed attaching method:
hook_fd = open("/sys/kernel/security/bpf/process_execution");
sys_bpf(attach, prog_fd, hook_fd);
With bpf tracing we moved to FD-based attaching, because permanent attaching is
problematic in production. We're going to provide FD-based api to attach to
networking as well, because xdp/tc/cgroup prog attaching suffers from the same
production issues. Mainly with permanent attaching there is no ownership of
attachment. Everything is global and permanent. It's not clear what
process/script suppose to detach/cleanup. I suggest bpf-lsm use FD-based
attaching from the beginning. Take a look at raw_tp/tp_btf/fentry/fexit style
of attaching. All of them return FD which represents what libbpf calls
'bpf_link' concept. Once refcnt of that FD goes to zero that link (attachment)
is destroyed and program is detached _by the kernel_. To make such links
permanent the application can pin them in bpffs. The pinning patches haven't
landed yet, but the concept of the link is quite powerful and much more
production friendly than permanent attaching.
bpf-lsm will still be able to attach multiple progs to the same hook and
see what is attached via bpftool.

The rest looks good. Thank you for working on it.
