Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7C134A70
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 19:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgAHSZa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 13:25:30 -0500
Received: from namei.org ([65.99.196.166]:56160 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbgAHSZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 13:25:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 008IP1Vu027011;
        Wed, 8 Jan 2020 18:25:01 GMT
Date:   Thu, 9 Jan 2020 05:25:01 +1100 (AEDT)
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
Subject: Re: [PATCH bpf-next v1 12/13] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
In-Reply-To: <20191220154208.15895-13-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2001090524390.9683@namei.org>
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-13-kpsingh@chromium.org>
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
> * Load a BPF program that audits mprotect calls
> * Attach the program to the "file_mprotect" LSM hook
> * Verify if the program is actually loading by reading
>   securityfs
> * Initialize the perf events buffer and poll for audit events
> * Do an mprotect on some memory allocated on the heap
> * Verify if the audit event was received
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Good to see!


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

