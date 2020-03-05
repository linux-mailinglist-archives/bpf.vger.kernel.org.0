Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3D17B19E
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 23:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCEWnU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 17:43:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36086 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEWnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 17:43:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id i13so92669pfe.3;
        Thu, 05 Mar 2020 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jA8p1VP2pt+JFWnPp+edirLjgTdOXHSljdFxDv1Za7g=;
        b=VVk9njl/Z7IPKK7+37XT+aObuQJtyevHOfm9ww2KAU8DY5xN2+hsFugWK5Ojh5MQuj
         5vx+8Ld8/LATRnhUv+IniR1NOsPDoXiCRyF5JX/o7M21UgJopSVbFomOMuwBAiWNd4u4
         jO7eDdbTkII28GQm6aS++5e3CRlwLEZiGklNOJMtJmspY+5xILJF3+I2T6j/uJ9CKiXs
         E54YCzd8yEXAEVLe6sGUrSvC9THlvKR/TAlRVRGzrYGk6fXuURl7ZtUy3Eiguj4uBJUy
         lWTyI/9uJQowsxyOn3Ao+fn3l9dzUEL0KilFXDgcjWHPhKiJDSR2APQIaPThlorgostA
         KHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jA8p1VP2pt+JFWnPp+edirLjgTdOXHSljdFxDv1Za7g=;
        b=GjIQpH0VGUtKyjStxuOPu6N0IoP7fdBML5f3bzXw7acokBu8pnsi6cFdHc9H8TE4KV
         J97HeNaa9HEqDGpeBt8LQw4FzTYtGj8qvhTQq0KnYrTWRl8ILJoxfU2E+KJJIJbug+J+
         q9rVAEXRXbdluMFquryqRSmtascyGDiCjDOxztXZ0S8XoFt4xawU4/0pAZ1xvYE8N3qu
         PebLEw7zLl38bM0B1Hm1UYXzQ/os4VqWh8V0p/NvfGrcki62QAcKeHzk1120w4Fa9PKC
         PUOq+W+mIwzwQE0rpvzxauhbZLAZyGTLWHQI8uNZuA3xgkAu+8TitwbIzSFmrlVtrOyw
         m4Vw==
X-Gm-Message-State: ANhLgQ3fg/SR8SnLXUZVRFjbhRdDOxDwSyw+WjqBrilb+ezvvrshOJLk
        kZPBextAptmpxedtUWTkxbc=
X-Google-Smtp-Source: ADFU+vvleMQSez6lc/fdx5SiFd17q0R3BrugPniE+eI/y2FdayIn84wcAqemUuX8tx5E/KZNeAmrig==
X-Received: by 2002:a63:5713:: with SMTP id l19mr387069pgb.216.1583448199145;
        Thu, 05 Mar 2020 14:43:19 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:f0e7])
        by smtp.gmail.com with ESMTPSA id e30sm33471914pga.6.2020.03.05.14.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 14:43:18 -0800 (PST)
Date:   Thu, 5 Mar 2020 14:43:16 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org, linux-next@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_prog_test_run_tracing for
 !CONFIG_NET
Message-ID: <20200305224315.i4wfxfrugcey22mm@ast-mbp>
References: <20200305220127.29109-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305220127.29109-1-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 05, 2020 at 11:01:27PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> test_run.o is not built when CONFIG_NET is not set and
> bpf_prog_test_run_tracing being referenced in bpf_trace.o causes the
> linker error:
> 
> ld: kernel/trace/bpf_trace.o:(.rodata+0x38): undefined reference to
>  `bpf_prog_test_run_tracing'
> 
> Add a __weak function in bpf_trace.c to handle this.
> 
> Fixes: da00d2f117a0 ("bpf: Add test ops for BPF_PROG_TYPE_TRACING")
> Signed-off-by: KP Singh <kpsingh@google.com>

Applied. Thanks
