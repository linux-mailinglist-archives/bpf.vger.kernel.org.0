Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA8134A63
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 19:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgAHSWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 13:22:33 -0500
Received: from namei.org ([65.99.196.166]:56096 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbgAHSWd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 13:22:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 008ILnMB026782;
        Wed, 8 Jan 2020 18:21:49 GMT
Date:   Thu, 9 Jan 2020 05:21:49 +1100 (AEDT)
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
Subject: Re: [PATCH bpf-next v1 10/13] bpf: lsm: Handle attachment of the
 same program
In-Reply-To: <20191220154208.15895-11-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2001090521340.9683@namei.org>
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-11-kpsingh@chromium.org>
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
> Allow userspace to attach a newer version of a program without having
> duplicates of the same program.
> 
> If BPF_F_ALLOW_OVERRIDE is passed, the attachment logic compares the
> name of the new program to the names of existing attached programs. The
> names are only compared till a "__" (or '\0', if there is no "__"). If
> a successful match is found, the existing program is replaced with the
> newer attachment.
> 
> ./loader Attaches "env_dumper__v1" followed by "env_dumper__v2"
> to the bprm_check_security hook..
> 
> ./loader
> ./loader
> 
> Before:
> 
>   cat /sys/kernel/security/bpf/process_execution
>   env_dumper__v1
>   env_dumper__v2
> 
> After:
> 
>   cat /sys/kernel/security/bpf/process_execution
>   env_dumper__v2
> 
> Signed-off-by: KP Singh <kpsingh@google.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

