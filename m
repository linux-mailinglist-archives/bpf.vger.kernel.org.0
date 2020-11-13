Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596B72B13C8
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 02:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgKMBUL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 20:20:11 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38005 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgKMBUL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 20:20:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 200765C0136;
        Thu, 12 Nov 2020 20:20:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 12 Nov 2020 20:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:subject:from
        :cc:to:date:message-id:in-reply-to; s=fm2; bh=+eUC68+z0ydcrOLBLk
        YAA0zrk/j30lG/uV9w1GMqqLI=; b=owgI4oNvwsaAj3eDLg/AK4iciFuTCoNBlD
        FReffE70LRq53r+OgzZyd/QqVly+3AjJL03eQMpmcDV1su6ongPlxGVpIG6D9IkK
        IEKUdQv2644YlZremmIEii/uZy413hCToxXOvrCZePkdmBX1yrVAW+5Z3fmjZSbY
        6yYKlW6mdEdH39J8Ts9GRdGhok8PKrMzO3QgZ2OoHY97V6HbKBry7k5AifmVEHje
        fNkwZD9RASGJ0amDNVrhJFS98T6Hkk+PQ5iBosXpAOdbrL4hc9mrO0i1KmqoWZVf
        ibaZEhRJ7rvZrbmWhM8nhnvOHpZFKywZwuxEc/72gICSLLwXR1DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=+eUC68+z0ydcrOLBLkYAA0zrk/j30lG/uV9w1GMqqLI=; b=rFNc3H+i
        +paQI5iQwu0n3xKjo24rRQeDgJSbtwpcsoyqkrcZ2D6/rJAtiDPF77PmCTnR8xzj
        RtjW3YH8CMcV9XRybj1grvlo+Ai1RiwGUV8dr0uxg49whJEN8lWchEyX3QhO3C50
        7ED/fN/gk+OLhXL2/kzOJm5FPQM6pVmxSLLg3IZUUNBKQlxA46OP/InN7rxthFNV
        8oPeF6avpA5Tzlmz5PR84k08B3jZmNemeOt6ACo2JkpyOqIvLIJ2V2bzMdaFcCvC
        ZAEshVK8uJKwj1E5lbuAdSZat+HJu9VCX/m1EoKTJab3BWewITUgl35q4Cd+okuS
        sWWuOhjZy7saYg==
X-ME-Sender: <xms:Sd-tX0iDmPi87BmGmZxxUnwkmTt5ZKYJd4ZaZT_Iq5bp3vqrVFGtEQ>
    <xme:Sd-tX9CxOJ03ZdPELXpQRGN57Y7yU6gTen0Ioqycv9-VO2YNmzjruJ3tuZRzP_wlU
    fpNByJyvyIubg2JWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpegggf
    gtuffhvfffkfgjsehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepjeefhfdufeefhfejvd
    evhfehudeltdeujeevudegvdejvdejleejgfegtdejjeevnecukfhppeeiledrudekuddr
    uddthedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Sd-tX8HtBCQ0M6HNxCyleDkmBfLarDojJmMbq9VJAyZVSX8uIqP7sw>
    <xmx:Sd-tX1QNhJQZWB0p5KrnEkHCaVS_9nAXzdTrVZzNvp7uQSwCcC4QqA>
    <xmx:Sd-tXxzp5j1FGpD1A5fEDcS6moZ2UWG-M9LAgUolYb2ixft4LuHE8g>
    <xmx:St-tX899YzeglagW-BvGCRiWNYc8PLTWewEC9kP0qfv_-QiWTXvSmA>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46B9F3280064;
        Thu, 12 Nov 2020 20:20:09 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
From:   "Daniel Xu" <dxu@dxuuu.xyz>
Cc:     <cneirabustos@gmail.com>, <ebiederm@xmission.com>, <blez@fb.com>
To:     "Yonghong Song" <yhs@fb.com>, <bpf@vger.kernel.org>
Date:   Thu, 12 Nov 2020 16:57:00 -0800
Message-Id: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
In-Reply-To: <3fb902d7-a88c-f9ed-03f0-460f7bd552fa@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Nov 12, 2020 at 4:27 PM PST, Yonghong Song wrote:
>
>
> On 11/12/20 2:20 PM, Daniel Xu wrote:
> > Hi,
> >=20
> > I'm looking at the current implementation of
> > bpf_get_ns_current_pid_tgid() and the helper seems to be a bit overly
> > restricting to me. Specifically the following line:
> >=20
> >      if (!ns_match(&pidns->ns, (dev_t)dev, ino))
> >              goto clear;
> >=20
> > Why bail if the inode # does not match? IIUC from the old discussions,
> > it was b/c in the future pidns files might belong to different devices.
> > It's not clear to me (possibly b/c I'm missing something) why the inode
> > has to match as well.
>
> Yes, pidns file might belong to different devices in theory so we need
> to match dev as well.
>
> The inode number needs to match so we can ensure user indeed wants to
> get the *current pidns* tgid/pid.

Right, this double-checking at the API level is what feels strange to
me -- why make the user prove they know what they're doing?

Furthermore, the "proof" restricts flexibility. It's as if
bpf_get_current_task() required a (dev,ino) pair. How would you get the
namespaced pid for a process you don't know about yet? eg when you're
profiling the system.

>
> (dev, ino) input expressed user intention. Without this, in no-process
> context, it will be hard to interpret the results.

But bpf_get_current_pid_tgid() doesn't return errors so this shouldn't
either, right?

>
> >=20
> > Would it be possible to instead have the helper return the pid/tgid of
> > the current task as viewed _from_ the `dev`/`ino` pidns? If the current
> > task is hidden from the `dev`/`ino` pidns, then return -ENOENT. The use
> > case is for bpftrace symbolize stacks when run inside a container. For
> > example:
> >=20
> >      (in-container)# bpftrace -e 'profile:hz:99 { print(ustack) }'
>
> I think you try to propose something like below:
> - user provides dev/ino
> - the helper will try to go through all pidns'es (not just active
> one), if any match pidns match, returns tgid/pid in that pidns,
> otherwise, returns -ENOENT.

Right, exactly.

>
> The current helper is
> bpf_get_ns_current_pid_tgid
> you want
> bpf_get_ns_pid_tgid
>
> I think it is possible, you need to check
> pid->numbers[pid_level].ns
> for all pid levels. You need to get a reference count for the namespace
> to ensure valid result.
>
> This may work for root inode, but for container inode, it may have
> issues. For example,
> container 1: create, inode 2
> container 1 removed
> container 2: create, inode 2
> If you use inode 2, depending on timing you may accidentally targetting
> wrong container.

Yeah, so maybe an fd to /proc/<pid>/ns/pid or something.

>
> I think you can workaround the issue without this helper. See below.
>
> >=20
> > This currently does not work b/c bpftrace will generate a prog that get=
s
> > the root pidns pid, pack it with the stackid, and pass it up to
> > userspace. But b/c bpftrace is running inside the container, the root
> > pidns pid is invalid and symbolization fails.
>
> bpftrace can generate a program takes dev/inode as input parameters in
> map. The bpftrace will supply dev/inode value, by query the current
> system/container, and then run the program.

I don't think it's very feasible to have bpftrace integrate with every
container runtime out there. This also becomes really difficult to
manage if you want to trace N processes. You'd need N maps or N progs.

>
> >=20
> > What would be nice is if bpftrace could generate a prog that gets the
> > current pid as viewed from bpftrace's pidns. Then symbolization would
> > work.
>
> Despite the above workaround, what you really need is although it is
> running on container, you want to get stack trace interpreted with
> root pid/tgid for symbolization purpose? But you can already achieve
> this with bpf_get_pid_tgid()?

No, this isn't possible when bpftrace runs inside the container. ie
bpftrace is in a pidns along with the tracees. Bpftrace gets the root
pidns pid from the kernel but cannot resolve it to the pidns pid. That
means bpftrace cannot find the executable file to symbolize against.

[...]

Thanks,
Daniel
