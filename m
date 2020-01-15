Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC0213CD72
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 20:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgAOTvH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 14:51:07 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52346 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbgAOTvH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 14:51:07 -0500
Received: by mail-pj1-f65.google.com with SMTP id a6so392705pjh.2
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ThaTxuo87ns4krckkkwEe3+1A1nRGxaYkFtAmXa64M=;
        b=YmyKdY1BDmTZZ9xS3oGVXhFGAgSjNopD7FZ2o7TdnVojWMJ9p/SHV8xIS6l35Aoz0v
         8987NFa5clGoQiiVae47isXrKym0mF3N/u1pBrnQdlyDF2FvGNKrBRz/Jl1Dz6w43i3D
         ogX30Xx0+VKv8H9HeuZMoHIPTkUaEDcH9mlBYkVMyFPD5hXJmaz1jjjtuAeMqBm7lW7n
         /Ci3rLW3yglshJmOjuO3+glx1fk6NKiLVbqOQ0yVqIpg28MKg5SMs9r8d5Z0fhhlj17V
         u68oOtEWysTZc2n5YLV9ziRb0KBCYH6rYYnyMQBZjZ9oYnc+d7ErXCX/rj2Cf7NgpYEQ
         PsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ThaTxuo87ns4krckkkwEe3+1A1nRGxaYkFtAmXa64M=;
        b=i7fF2XBK6f4Zj4tApG7Y2QObDn8ui702bjTEmdwUHm3miH251nQNfYx2VrOmaM6lP2
         N36grjaY2bnc3wy5qOcRUCU1JU35NgJ7Pk8RwSzYbwh8w40dqlmnQSEUTO11r/fTm708
         58O38CK10L5kAhZ24NsJ5ROo+9Y9IrcIFCCuh4bWUErYbN+K3/Gbzif6+hpPTuS+YWeE
         MRHQ4Mu91xsydPfSBIxTrRv0JPcFiOtiPcxbzcZFu2133Hqr5I51PHV/psYiALnBLNOJ
         C71kmh7EapSLfMC4077VzHfaFYDp/f7nmZ5z8m2JdacxMRK4Udz6LFhTJtsB8tVTuaQb
         DbEg==
X-Gm-Message-State: APjAAAWZb6EDW45g9NHeBKauARMmPhbxmN/taD8dFvnF2/CP6ZwwCxuK
        aMQT9u+o2Lo763tIYr29bV4=
X-Google-Smtp-Source: APXvYqxUXtIMcztdHYfT9G6qj/FRMylDjrojVZR5EaUnRDH+FrWGuvjxxVGwZsopYJ7W/tjcti8CKg==
X-Received: by 2002:a17:90a:a05:: with SMTP id o5mr1836384pjo.77.1579117866830;
        Wed, 15 Jan 2020 11:51:06 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3:e760])
        by smtp.gmail.com with ESMTPSA id b22sm22171899pft.110.2020.01.15.11.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 11:51:06 -0800 (PST)
Date:   Wed, 15 Jan 2020 11:51:04 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 0/2] bpf: add bpf_send_signal_thread() helper
Message-ID: <20200115195103.vncvolqjcu72odg7@ast-mbp.dhcp.thefacebook.com>
References: <20200115035002.602280-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115035002.602280-1-yhs@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 14, 2020 at 07:50:02PM -0800, Yonghong Song wrote:
> Commit 8b401f9ed244 ("bpf: implement bpf_send_signal() helper") 
> added helper bpf_send_signal() which permits bpf program to
> send a signal to the current process. The signal may send to 
> any thread of the process.
>  
> This patch implemented a new helper bpf_send_signal_thread()
> to send a signal to the thread corresponding to the kernel current task. 
> This helper can simplify user space code if the thread context of
> bpf sending signal is needed in user space. Please see Patch #1 for 
> details of use case and kernel implementation.
>  
> Patch #2 added some bpf self tests for the new helper.
>  
> Changelogs:
>   v2 -> v3:
>     - More simplification for skeleton codes by removing not-needed
>       mmap code and redundantly created tracepoint link.
>   v1 -> v2: 
>     - More description for the difference between bpf_send_signal()
>       and bpf_send_signal_thread() in the uapi header bpf.h. 
>     - Use skeleton and mmap for send_signal test.

Applied. Thanks.

Though extra tests were added it's nice to see that skeleton keeps deleting
lines from selftests:
2 files changed, 73 insertions(+), 106 deletions(-)
