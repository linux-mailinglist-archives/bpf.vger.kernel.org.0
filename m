Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7250F379C69
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 04:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhEKCFg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 22:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhEKCFf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 22:05:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67689C061574;
        Mon, 10 May 2021 19:04:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b21so10096734plz.0;
        Mon, 10 May 2021 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FAkiD+F8EGFEXXB2wgPC00kKeAj+LDr86VTrzLzFEYM=;
        b=p7LuOMJl2G+UZBBm+HhjKOVm76lvDOdsIWSW/cYMWu0z6PHY0hc3Aa7YV8IeMB5QLt
         H63sUljAjiHlcpDSs5mRDgommAXeT0/EcWhJBiNPYUtB5OG/K41MoIQo9mc2Z4/Iy42L
         xP173fp5Kwp68chlsCq8U50/RDPkbtyVPHUdWRaf2yyappL41w1hu6uNYoqHCihrjWQC
         ctxh9pNr8miGwCBJU6RNexFkka16l8R5Y21VYgT5GbL819/WAhXu4qnlAuSuOe2OIlsq
         JpVxj0e6Y9WOqfLUpIFlr/vCwMT20gIHL+9fUZdwCOXqszRdAqun2d01KhHCy8Htk0Im
         ognQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FAkiD+F8EGFEXXB2wgPC00kKeAj+LDr86VTrzLzFEYM=;
        b=tBKhI/PXXPBfolI0ZqsOGBZdtWe8++KV8R0HM7Nc/9n/bYg9/zFURaw4xccBrqzr7O
         HWHbevxlZmXzTG8g44p4B93vWl11Kba49ZiHwOOtwMVz0AKI18CmYDdWpYEeR2e/JGlA
         iS0Qg3xUDzUZKKinWpQiFDBv1ESKXzukTwJMRF8U9hPHVNnERYiaFKKJmhwVKoPKwTL7
         blDBo/upX9koXTFtd5kLUm2JuXE7N9w/grJJBT65dT4F311QLtKRfg+XGsigL2F96VcS
         /aVRAlDGpLZhVmvUR5e7D+C9wk9NxbXO6yF37f8m4hrnOo943xpF0H2rZ/z7IPMLCdk5
         hSww==
X-Gm-Message-State: AOAM530BzMsbqcSxzyjdQ2zLBsMVPgWirqrKpDuvVU4N+q0qlSyUKW7j
        Y3Ywt4CfbxvrxZYmXqjL9Rg=
X-Google-Smtp-Source: ABdhPJzw0a/aGm3KCJqbO5MTeJ4kjEBU3TYGUedRrBJzPTq1fVBie3ydBnx4UvkFYdAMJIPNP49puA==
X-Received: by 2002:a17:90b:2393:: with SMTP id mr19mr2284042pjb.24.1620698669870;
        Mon, 10 May 2021 19:04:29 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:bba4])
        by smtp.gmail.com with ESMTPSA id a18sm12541979pgg.51.2021.05.10.19.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 19:04:29 -0700 (PDT)
Date:   Mon, 10 May 2021 19:04:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux.dev, bpf@vger.kernel.org,
        YiFei Zhu <yifeifz2@illinois.edu>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [RFC PATCH bpf-next seccomp 10/12] seccomp-ebpf: Add ability to
 read user memory
Message-ID: <20210511020425.54nygajvrpxqnfsh@ast-mbp.dhcp.thefacebook.com>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <53db70ed544928d227df7e3f3a1f8c53e3665c65.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53db70ed544928d227df7e3f3a1f8c53e3665c65.1620499942.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 10, 2021 at 12:22:47PM -0500, YiFei Zhu wrote:
>  
> +BPF_CALL_3(bpf_probe_read_user_dumpable, void *, dst, u32, size,
> +	   const void __user *, unsafe_ptr)
> +{
> +	int ret = -EPERM;
> +
> +	if (get_dumpable(current->mm))
> +		ret = copy_from_user_nofault(dst, unsafe_ptr, size);

Could you explain a bit more how dumpable flag makes it safe for unpriv?
The unpriv prog is attached to the children tasks only, right?
and dumpable gets cleared if euid changes?
