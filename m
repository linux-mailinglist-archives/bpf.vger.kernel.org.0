Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B482B3BEB
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 04:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKPDza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Nov 2020 22:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbgKPDza (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Nov 2020 22:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605498929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIyX+K3069TyD6kPLH7ed95GPSU1kyK555UH9jTHff8=;
        b=VkwFfq+mpqDP2HE4WM1gLE32nRcOMoQZ7TRQn/PNj4M/GcmH9UclJCsHk1OCmWCs/99S/f
        oiwQmf8yN3Bdof31RaYplTL1ohPBFjNSZF7XPRcqQuoE43rz9LomjERVgBvPXvIQFTEWYx
        lEj4ZXnEASRrm0LmJA5EOh4NvhfdC1Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-Hqog-xMzP3WJjnbJwvMmGA-1; Sun, 15 Nov 2020 22:55:27 -0500
X-MC-Unique: Hqog-xMzP3WJjnbJwvMmGA-1
Received: by mail-pl1-f198.google.com with SMTP id p15so8304609plr.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2020 19:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIyX+K3069TyD6kPLH7ed95GPSU1kyK555UH9jTHff8=;
        b=N5Jlha/tYkvm6ybm413AGkfreM242zpSjfV9u5nYYy6FYqSoQmnOxPt63EKwXOJkuS
         RWGlYI0V1/c59Q23un9Ogw5URFN1mcLuzshtoaRH4xoti60nbYzGmn4Ix99/Qjrrj33k
         l4sCQRxn4VdKqH32zmMBJURhu3UVo6VXD7salxhHBe5QUXl3g1JJpO/LpoMav0z/QAc0
         a5SD4KgZ7CEKp2vvo8aX+hkRmniX+8V1UWG52+TXHkOSiOXSmYZweF5vMBWHjOHlcfOw
         CTln8i+/PcDnylDLPvGPnAS0MgDWaxC2Mq9xdrCCQSI8nI9Zv8gEugZKkzACUXQGq85f
         XlaA==
X-Gm-Message-State: AOAM533r4Eor1ASbZudCk4KHMx5YZpqmLmgB08+swj912KnekqMwpVoi
        GXtTfIk3q/Fru6QQEx390YK4eSWIVfj++XHnBlJ6whC4ef26wiJ6qWoMhDJocT+YAMsSM/nc2Er
        1tEPSmBFAiNM=
X-Received: by 2002:a62:fc8f:0:b029:18b:823a:13c2 with SMTP id e137-20020a62fc8f0000b029018b823a13c2mr12779130pfh.57.1605498926118;
        Sun, 15 Nov 2020 19:55:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxU3YC5FlhTRqYFjiD1ghZIezWxTurXey8HolzSwXwjlWGMIUkQhABix+3/0x/8BgqAQK+Nbg==
X-Received: by 2002:a62:fc8f:0:b029:18b:823a:13c2 with SMTP id e137-20020a62fc8f0000b029018b823a13c2mr12779117pfh.57.1605498925883;
        Sun, 15 Nov 2020 19:55:25 -0800 (PST)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y3sm14379033pgq.40.2020.11.15.19.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 19:55:25 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:55:15 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCHv4 iproute2-next 2/5] lib: rename bpf.c to bpf_legacy.c
Message-ID: <20201116035515.GF2408@dhcp-12-153.nay.redhat.com>
References: <20201029151146.3810859-1-haliu@redhat.com>
 <20201109070802.3638167-1-haliu@redhat.com>
 <20201109070802.3638167-3-haliu@redhat.com>
 <a42a6a91-53fa-5b31-4bba-273847ee8986@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a42a6a91-53fa-5b31-4bba-273847ee8986@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 08:24:41PM -0700, David Ahern wrote:
> On 11/9/20 12:07 AM, Hangbin Liu wrote:
> > diff --git a/lib/bpf_glue.c b/lib/bpf_glue.c
> > new file mode 100644
> > index 00000000..7626a893
> > --- /dev/null
> > +++ b/lib/bpf_glue.c
> 
> ...
> 
> > +
> > +int bpf_program_load(enum bpf_prog_type type, const struct bpf_insn *insns,
> > +		     size_t size_insns, const char *license, char *log,
> > +		     size_t size_log)
> > +{
> > +#ifdef HAVE_LIBBPF
> > +	return bpf_load_program(type, insns, size_insns, license, 0, log, size_log);
> > +#else
> > +	return bpf_load_load_dev(type, insns, size_insns, license, 0, log, size_log);
> > +#endif
> > +}
> > +
> 
> Fails to compile:
> 
> $ LIBBPF_FORCE=off ./configure
> $ make
> ...
> /usr/bin/ld: ../lib/libutil.a(bpf_glue.o): in function `bpf_program_load':
> bpf_glue.c:(.text+0x13): undefined reference to `bpf_load_load_dev'

Opps, sorry for the typo...

