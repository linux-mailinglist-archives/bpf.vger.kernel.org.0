Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46B133403
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2020 22:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAGVXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jan 2020 16:23:09 -0500
Received: from namei.org ([65.99.196.166]:55898 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbgAGVXC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jan 2020 16:23:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 007LMRpJ014254;
        Tue, 7 Jan 2020 21:22:27 GMT
Date:   Wed, 8 Jan 2020 08:22:27 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
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
Subject: Re: [PATCH bpf-next v1 06/13] bpf: lsm: Init Hooks and create files
 in securityfs
In-Reply-To: <20191220154208.15895-7-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2001080822090.9683@namei.org>
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-7-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 20 Dec 2019, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 
> The LSM creates files in securityfs for each hook registered with the
> LSM.
> 
>     /sys/kernel/security/bpf/<h_name>
> 
> The list of LSM hooks are maintained in an internal header "hooks.h"
> Eventually, this list should either be defined collectively in
> include/linux/lsm_hooks.h or auto-generated from it.
> 
> * Creation of a file for the hook in the securityfs.
> * Allocation of a bpf_lsm_hook data structure which stores
>   a pointer to the dentry of the newly created file in securityfs.
> * Creation of a typedef for the hook so that BTF information
>   can be generated for the LSM hooks to:
> 
>   - Make them "Compile Once, Run Everywhere".
>   - Pass the right arguments when the attached programs are run.
>   - Verify the accesses made by the program by using the BTF
>     information.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

