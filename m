Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8450F13D72B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 10:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgAPJpk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 04:45:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40173 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPJpj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 04:45:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so3010065wmi.5
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 01:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JZyqN5qlv5csEwwF7mhl4MB8eUdR7toL/H4ZfMDEk6g=;
        b=Vj1+B0IIOY42PaOZgZVxmKH8K8KawfI8k4ca+yD6NCdW9+m0f5RoQyWsqVZre+box/
         fdaYwemzm3+elzGhL9u8RQika/e+KsR6BCsRvDSOP7/WdmttrcXjUGi2bPNRrkEDEY+w
         3XpXWf4FWF6aOFv9YPM5+29NEYL1aRkb5JXqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZyqN5qlv5csEwwF7mhl4MB8eUdR7toL/H4ZfMDEk6g=;
        b=Jh/4TscaRpwyykaQUgRegRYpnY2JeV3Xa52iLUOr783+booEj+kR1Ses8ObV8DyNt4
         ctFqpZ4k0CMIQIxTWpcYpX3qKtRIYsLOhqzS7054TaJ2Bvm0KQRaOvxpWBhl1bgfVaeI
         0DdxzeEs3yfM7IEF9tg4JS6Gk5dbeLnP2D5P2itV51P9PdYgeavaeUnzwx9ABC+yQ3RH
         8pcZe8yeJ5TJek8Qp59O/6UI+SQfYVphIUB8SQVxW9TSqXNJTrAL51lnymXBoChMqrPP
         ql4zIoPpgkGHrl9Qo9xmm0ygU/+jeh94hv5LX19ps+HRpaBpgTFROO/KeIf2iGEVXkaf
         mtZg==
X-Gm-Message-State: APjAAAWxavi09izcYjuyp/7IZwQ+A05HawI16F3dajI3DCHrbpkyXV/k
        t9xq2pZIXUWTUp+BzHf7uVsvaA==
X-Google-Smtp-Source: APXvYqzodqnf952non/Pp68saYtHh4fQCSMqKy/g+z0HaIiKWSZD+4CRhvDznRr+j4DRUZr2Hi54TQ==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr5300109wmc.111.1579167938030;
        Thu, 16 Jan 2020 01:45:38 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id x10sm27801564wrv.60.2020.01.16.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 01:45:37 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 16 Jan 2020 10:45:35 +0100
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
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
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 06/10] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200116094535.GA240584@google.com>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-7-kpsingh@chromium.org>
 <20200115172417.GC4127163@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115172417.GC4127163@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15-Jan 18:24, Greg Kroah-Hartman wrote:
> On Wed, Jan 15, 2020 at 06:13:29PM +0100, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > JITed BPF programs are used by the BPF LSM as dynamically allocated
> > security hooks. arch_bpf_prepare_trampoline handles the
> > arch_bpf_prepare_trampoline generates code to handle conversion of the
> > signature of the hook to the BPF context and allows the BPF program to
> > be called directly as a C function.
> > 
> > The following permissions are required to attach a program to a hook:
> > 
> > - CAP_SYS_ADMIN to load the program
> > - CAP_MAC_ADMIN to attach it (i.e. to update the security policy)
> 
> You forgot to list "GPL-compatible license" here :)

Added it to the commit log for v3.

> 
> Anyway, looks good to me:

Thanks! :)

> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
