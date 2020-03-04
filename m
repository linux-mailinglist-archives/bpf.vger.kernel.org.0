Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CD179B9F
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 23:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgCDWRf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 17:17:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46609 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDWRf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 17:17:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id y30so1655683pga.13;
        Wed, 04 Mar 2020 14:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SeLK1u6XZQiNjm/hVW01wDa1blPflVVcyrMnhEyc6lQ=;
        b=NMU2vjdlKGiHucUtsyG5rog2PzW9dzSnvDzdLKNICZRP2PNr8ScfWCQFerCD8Ahp2u
         vcUeFNhQG8fPfXQ0gGiJdVRFNTvcogp34MrK6zryQm4gwiI6JQQpIdQ70ZDrOevveruT
         BUe+wIukIMUlRudvg0bo9jOQ3aE/yM6Xt5AGi8DirwFPvk4bGYJWgAZuvsYum+0rAKHn
         6GnluaBJFp+g3s93SOqNX9+N5XBSJLxrHLxBFvm02VytTQBXtJyyR6sG/XdfxLCZJaZ9
         qnywdqfsF0Xw5akcQdU3OnELDza+MQ0cDUe8rlVoEcm/uz//hHG87CAd4sSMiWCxa6F3
         2hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SeLK1u6XZQiNjm/hVW01wDa1blPflVVcyrMnhEyc6lQ=;
        b=bG6M4Ut0DGtIAS90bJTpz/Q8MVcZiNfptw0jOjs2FTmHIERtv1RcTL8D29YO67gED2
         rnZafOBPhPi3Wt2c4EGfDaGeYbOotQZzBIPv5jasu9n+Gjc5vjb/8OxvOYukUNNUgLIz
         WQWp863ZQEMqzw9o5JVqQjztEuCkXbYNW9CIKqou1ceMHSQaRGc3UharcA6T0BCpwVpj
         hrg0GqBaw6wVpZ/KAU+61KZMcX98nxjlB3w5q7RD1OWySSc+NqK9aBW7HmwGzERLD/IE
         09encumyvcLVEYWELgwq0PwXtEjNNN2vDJ2pEqEcofgh9cVSjp7sMG+Wcttc6S76ObaE
         ezhg==
X-Gm-Message-State: ANhLgQ1GqPhZe8dNnHqU3nC2LcFbw72aGvr3fpSRVu6mx19XNRjPH3z4
        qM3ukmgBYHMHgucfYv3H4zTOTTzA
X-Google-Smtp-Source: ADFU+vvKbQM5v+o2ycE8rww55wXTCIhFEwn13T6g0O69i6FRGcqst85HQWxGYDGPUnt5gDi8TljC5Q==
X-Received: by 2002:a63:2323:: with SMTP id j35mr4466654pgj.440.1583360253961;
        Wed, 04 Mar 2020 14:17:33 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:500::4:c694])
        by smtp.gmail.com with ESMTPSA id d186sm11160532pfc.8.2020.03.04.14.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 14:17:33 -0800 (PST)
Date:   Wed, 4 Mar 2020 14:17:31 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v4 0/7] Introduce BPF_MODIFY_RET tracing progs
Message-ID: <20200304221729.d6omw6tltqhbw5xr@ast-mbp>
References: <20200304191853.1529-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304191853.1529-1-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 04, 2020 at 08:18:46PM +0100, KP Singh wrote:
> 
> Here is an example of how a fmod_ret program behaves:
> 
> int func_to_be_attached(int a, int b)
V> {  <--- do_fentry
> 
> do_fmod_ret:
>    <update ret by calling fmod_ret>
>    if (ret != 0)
>         goto do_fexit;
> 
> original_function:
> 
>     <side_effects_happen_here>
> 
> }  <--- do_fexit
> 
> ALLOW_ERROR_INJECTION(func_to_be_attached, ERRNO)
> 
> The fmod_ret program attached to this function can be defined as:
> 
> SEC("fmod_ret/func_to_be_attached")
> int BPF_PROG(func_name, int a, int b, int ret)
> {
>         // This will skip the original function logic.
>         return -1;
> }

Applied to bpf-next. Thanks.

I think it sets up a great base to parallelize further work.

1. I'm rebasing my sleepable BPF patches on top.
It's necessary to read enviroment variables without the
'opportunistic copy before hand' hack I saw in your github tree
to do bpf_get_env_var() helper.

2. please continue on LSM_HOOK patches to go via security tree.

3. we need a volunteer to generalize bpf_sk_storage to task and inode structs.
This work will be super useful for all bpf tracing too.
Sleepable progs are useful for tracing as well.
