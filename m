Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD197134B16
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 19:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgAHS7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 13:59:07 -0500
Received: from namei.org ([65.99.196.166]:56264 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgAHS7G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 13:59:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 008IwTZG029133;
        Wed, 8 Jan 2020 18:58:29 GMT
Date:   Thu, 9 Jan 2020 05:58:29 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF
 (KRSI)
In-Reply-To: <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.2001090551000.27794@namei.org>
References: <20191220154208.15895-1-kpsingh@chromium.org> <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com> <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com> <201912301112.A1A63A4@keescook>
 <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 8 Jan 2020, Stephen Smalley wrote:

> This appears to impose a very different standard to this eBPF-based LSM than
> has been applied to the existing LSMs, e.g. we are required to preserve
> SELinux policy compatibility all the way back to Linux 2.6.0 such that new
> kernel with old policy does not break userspace.  If that standard isn't being
> applied to the eBPF-based LSM, it seems to inhibit its use in major Linux
> distros, since otherwise users will in fact start experiencing breakage on the
> first such incompatible change.  Not arguing for or against, just trying to
> make sure I understand correctly...

A different standard would be applied here vs. a standard LSM like 
SELinux, which are retrofitted access control systems.

I see KRSI as being more of a debugging / analytical API, rather than an 
access control system. You could of course build such a system with KRSI 
but it would need to provide a layer of abstraction for general purpose 
users.

So yes this would be a special case, as its real value is in being a 
special case, i.e. dynamic security telemetry.


-- 
James Morris
<jmorris@namei.org>

