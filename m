Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D562D3350
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 21:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgLHUQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 15:16:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33991 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbgLHUMu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 15:12:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id g25so2511381wmh.1
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 12:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=e6YSCGu2Oi5y5zgx0PfCtwMdD4IMQhe57zZy7ZhqyTY=;
        b=dGi561rx2Cs2oRQl86hpsUH21HEifyfEfBkhi2V+3yUYn6QtyCdBwS7Q7ZrbbTS/5c
         ySSKB98xVWcDgkq52yZfSPG7K/XZXJtVT7HZwPTjfvTV0jYxH4B9orbRVHkKG2wovY6l
         ICuuEwupKGOUWtxiWOjQ92HKhkFS4Q5FZ1BNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=e6YSCGu2Oi5y5zgx0PfCtwMdD4IMQhe57zZy7ZhqyTY=;
        b=Gw7eU2bEplqOKi2oEuOT9wc52Nl8wQuARD5y4au9pYNMCyqT3qA+hB8J5avFDb0DeG
         bS3bxa5gc3qzvtwvgQ8xpuUM30BgTZO6KsMcqSAXP+yibDMtUorF6Ao70pJdEicg6h81
         BirvjpzY3tWm5/oF8fl9InqVR0+Tjj5uIOPB7I9ICU5McxfgT8L97r9viDZjGLm1btzC
         sYMBGu/hXrY5cyFyrGZ5CMhJsiddb8qlEbCJ0/4w7Mq9Toym0Ep8cmxP0H7Ct5eBa5iM
         Wxhy3fCIcERq0CpGsz/kSbPEVVeCvaALPFNK3SWCT9cBq0GwW4WNC7KLJxR5yD+KhdOV
         nudg==
X-Gm-Message-State: AOAM533c7Ik5r6WGc4YLxWIcJa+GgN4+X8tsXjiT5dq28suie2IkVh66
        l+VJNXWBk5aR1YRRlOPTDWL4th9uyZQ5ow==
X-Google-Smtp-Source: ABdhPJwUdTAGR5hyNsc0++LpwBm+wq8xzQ0ph1Q1n3qM4dFS69jQjIc4yb0dJ2lg/W/QuDfMmdhzOQ==
X-Received: by 2002:a1c:b608:: with SMTP id g8mr5270089wmf.110.1607456410525;
        Tue, 08 Dec 2020 11:40:10 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id c2sm21474188wrv.41.2020.12.08.11.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:40:09 -0800 (PST)
Message-ID: <afd9317561b1823da2fa473f29723da83247767e.camel@chromium.org>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Expose bpf_get_socket_cookie to
 tracing programs
From:   Florent Revest <revest@chromium.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Dec 2020 20:40:08 +0100
In-Reply-To: <20201204194748.cqyz7hfx5s5dyszc@kafai-mbp.dhcp.thefacebook.com>
References: <20201203213330.1657666-1-revest@google.com>
         <20201204194748.cqyz7hfx5s5dyszc@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-12-04 at 11:47 -0800, Martin KaFai Lau wrote:
> On Thu, Dec 03, 2020 at 10:33:28PM +0100, Florent Revest wrote:
> > +const struct bpf_func_proto
> > bpf_get_socket_cookie_sock_tracing_proto = {
> > +	.func		= bpf_get_socket_cookie_sock,
> > +	.gpl_only	= false,
> > +	.ret_type	= RET_INTEGER,
> > +	.arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> 
> In tracing where it gets a sk pointer, the sk could be NULL.
> A NULL check is required in the helper. Please refer to
> bpf_skc_to_tcp_sock[_proto] as an example.

Ah, good catch! :) 

> This proto is in general also useful for non tracing context where
> it can get a hold of a sk pointer. (e.g. another similar usage that
> will have a hold on a sk pointer for BPF_PROG_TYPE_SK_REUSEPORT [0]).

Agreed.

> In case if you don't need sleepable at this point as Daniel
> mentioned in another thread.  Does it make sense to rename this
> proto to something like bpf_get_socket_pointer_cookie_proto?

My understanding is that I could have two helpers definitions and
protos, one calling sock_gen_cookie and the other one calling
__sock_gen_cookie. Then I could just use:

return prog->aux->sleepable
       ? bpf_get_socket_pointer_cookie_sleepable_proto
       : bpf_get_socket_pointer_cookie_proto;

Would that work ?

