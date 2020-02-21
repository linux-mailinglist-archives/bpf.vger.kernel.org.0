Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACF8166CDD
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 03:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgBUCZm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 21:25:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41056 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgBUCZl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 21:25:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id t14so211376plr.8;
        Thu, 20 Feb 2020 18:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5OYxEQQxQq0p35RLj6fqeKc94hTFaGsasuln1viLIdM=;
        b=QollWffK6jd8OXRhT9J5DLBOBkw+xPgjx6gAMf9dPBC0kiyUcuXhIyV22tEuUBHhhU
         1er5Pi6ahnldQshoUfq6PQlifzU1MlI01sY0Eq+ahqnDkp+0wfL/6varsJO72pYOO/yd
         pmR/zciVCfIGgU9tOiwwqER1RCrG6AUSNxClvKN5gIluaSTJVg1S/NdY0F0vR4PNTYQF
         lrWg53MU9MGhDlr5EUE2w6+Q0VNKtk8EBUZD2JjPUdnJanQ5Dl8OHCYj6Fnx+YjMDVQt
         hyCuCuX/B7oTerLlxxKWMlruLhmkUYv79FPHfDej0MnCDXakRGIQEeeobe1WyzCFJy16
         pxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5OYxEQQxQq0p35RLj6fqeKc94hTFaGsasuln1viLIdM=;
        b=qf4q5v7m/NLPf04xn7pS7td5Q8NjE675vimaXDGf+uX9AMvydOnVgh2bSX3NwHe5ic
         /9thVONWGCKZBXUGR3DAI0cOgupyEorjKBl412MqaniY/GQXe6Td3Bs0LDZAc5ikBLzy
         4jVS17u/5OR+W0k8mWUuc7RXmQIuVz7UoEDm8UIH5fYGir/DfJsbQdSiNrqklOwO2D0+
         5CQZumSlbUQzoccRGIF9GnT/KApMPe2yZcakXGyVc6ybm+sLFeCaJEn1e6tG05yDjrEp
         diY6YnPV+dK1i8cQVzxiGVoSHjFERafRkVbcZqIrIWAtG28VbcqPXQfvcO0BXyT96uTC
         NLBA==
X-Gm-Message-State: APjAAAVar9TK+5EWLbo9bzdKLtkpqWNBThQ8+IeRo6llgZ2M84u/0jkM
        p1o426OBKSpWlmMTmtx7n6s=
X-Google-Smtp-Source: APXvYqzhUU5b2z0pgBVEdf+2WxrIVTDiYtYVi35cMj89Vpxa+xCRoKVQtJb0z5fUOwrnT/JLSNHs6Q==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr228481pjb.33.1582251941007;
        Thu, 20 Feb 2020 18:25:41 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:500::5:f03d])
        by smtp.gmail.com with ESMTPSA id 26sm717367pjk.3.2020.02.20.18.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 18:25:40 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:25:38 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200221022537.wbmhdfkdbfvw2pww@ast-mbp>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220175250.10795-4-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 20, 2020 at 06:52:45PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The BPF LSM programs are implemented as fexit trampolines to avoid the
> overhead of retpolines. These programs cannot be attached to security_*
> wrappers as there are quite a few security_* functions that do more than
> just calling the LSM callbacks.
> 
> This was discussed on the lists in:
> 
>   https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.org/T/#m068becce588a0cdf01913f368a97aea4c62d8266
> 
> Adding a NOP callback after all the static LSM callbacks are called has
> the following benefits:
> 
> - The BPF programs run at the right stage of the security_* wrappers.
> - They run after all the static LSM hooks allowed the operation,
>   therefore cannot allow an action that was already denied.
> 
> There are some hooks which do not call call_int_hooks or
> call_void_hooks. It's not possible to call the bpf_lsm_* functions
> without checking if there is BPF LSM program attached to these hooks.
> This is added further in a subsequent patch. For now, these hooks are
> marked as NO_BPF (i.e. attachment of BPF programs is not possible).

the commit log doesn't match the code.

> +
> +/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> + * function where a BPF program can be attached as an fexit trampoline.
> + */
> +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> +#define LSM_HOOK_int(NAME, ...) noinline int bpf_lsm_##NAME(__VA_ARGS__)  \

Did you check generated asm?
I think I saw cases when gcc ignored 'noinline' when function is defined in the
same file and still performed inlining while keeping the function body.
To be safe I think __weak is necessary. That will guarantee noinline.

And please reduce your cc next time. It's way too long.
