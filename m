Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE743F0414
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 14:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhHRM71 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 08:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236499AbhHRM70 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 08:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629291531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09x+8dCI5/TkbKvSdPIJMMOV6aZdICcvnRHsab2iCfM=;
        b=FjZ8Qn/Ed+hidzbbSC3fxrMuexTgEin2crnt+cKx2GwKphlO1VC17hyMTj6Deckj1u+v4r
        rvuyskw5I8SZh9CHIQD+3loh2USU3zOqBZm+Bi7ChmkSvNErrwe404bhnfD1gQUbSqSIhX
        RRi4rwtnL5Q/cf6RPT1EvqEN83J2vgI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-N1TXnSb1O8aZtbqto0anzQ-1; Wed, 18 Aug 2021 08:58:50 -0400
X-MC-Unique: N1TXnSb1O8aZtbqto0anzQ-1
Received: by mail-ed1-f71.google.com with SMTP id e3-20020a50ec830000b02903be5be2fc73so975723edr.16
        for <bpf@vger.kernel.org>; Wed, 18 Aug 2021 05:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=09x+8dCI5/TkbKvSdPIJMMOV6aZdICcvnRHsab2iCfM=;
        b=ZnM/x9S+gmtRGZJmAHT4d0vMbLwY4dE13CaxN/qWiHqT9/84S8bZzmHZMkjoD/O1cA
         6OS8OEuakpBCmL9AUpKd+E2gwSgrFnqAGtr2bYZsT/tuNYaeko1GtqPGdwXad46p5F2d
         ZbWAAucX8Ke2YPwntMNjW5PZJi62vpNkJJs7+T5mQCR4+epFfiUI4zmVcvoKDSLV9fqp
         ZqHWHL8LqHHe+d3Q9VOumcKA82TyVSfxslkGFHTwEPAa0bEK6RDNPwlXeaY+l0T98DRk
         GLK3Dga2GgD4B6PmxCpE/lXSInGeJqo4FpV9/aaGW3+5EWJ5bxUy/EsjxsHluj1/fO/U
         Ycew==
X-Gm-Message-State: AOAM533+SjZx7PPTyU/Pvl6QO+X0C9UfyyqTErnryTttBMl8PbplrMvQ
        LmHra6m8fwxxX5P4sf2psga9hlHkIe7gN+l7QV+5L3FVjM63rzQP2qjXPalrtvgTVLWpnoPIjMw
        T2POi7lxdsL3f
X-Received: by 2002:a05:6402:1d1c:: with SMTP id dg28mr10347642edb.234.1629291529180;
        Wed, 18 Aug 2021 05:58:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyofstIBDIciczj+UTiU5luCJUGq5UtpCf+huZBHZDLqEX5l4Po8j4IFhWvEYpVmIrk47gCKw==
X-Received: by 2002:a05:6402:1d1c:: with SMTP id dg28mr10347622edb.234.1629291529057;
        Wed, 18 Aug 2021 05:58:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u18sm2029941ejf.118.2021.08.18.05.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:58:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DF76918032C; Wed, 18 Aug 2021 14:58:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v11 bpf-next 17/18] net: xdp: introduce
 bpf_xdp_adjust_data helper
In-Reply-To: <YR0BYiQFvI8cmOJU@lore-desk>
References: <cover.1628854454.git.lorenzo@kernel.org>
 <9696df8ef1cf6c931ae788f40a42b9278c87700b.1628854454.git.lorenzo@kernel.org>
 <87czqbq6ic.fsf@toke.dk> <YR0BYiQFvI8cmOJU@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Aug 2021 14:58:47 +0200
Message-ID: <878s0yrjso.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
> [...]
>> > + *	Description
>> > + *		For XDP frames split over multiple buffers, the
>> > + *		*xdp_md*\ **->data** and*xdp_md *\ **->data_end** pointers
>> > + *		will point to the start and end of the first fragment only.
>> > + *		This helper can be used to access subsequent fragments by
>> > + *		moving the data pointers. To use, an XDP program can call
>> > + *		this helper with the byte offset of the packet payload that
>> > + *		it wants to access; the helper will move *xdp_md*\ **->data**
>> > + *		and *xdp_md *\ **->data_end** so they point to the requested
>> > + *		payload offset and to the end of the fragment containing this
>> > + *		byte offset, and return the byte offset of the start of the
>> > + *		fragment.
>> 
>> This comment is wrong now :)
>
> actually we are still returning the byte offset of the start of the fragment
> (base_offset).

Hmm, right, I was looking at the 'return 0':

> +BPF_CALL_2(bpf_xdp_adjust_data, struct xdp_buff *, xdp, u32, offset)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	u32 base_offset = xdp->mb.headlen;
> +	int i;
> +
> +	if (!xdp_buff_is_mb(xdp) || offset > sinfo->xdp_frags_size)
> +		return -EINVAL;
> +
> +	if (offset < xdp->mb.headlen) {
> +		/* linear area */
> +		xdp->data = xdp->data_hard_start + xdp->mb.headroom;
> +		xdp->data_end = xdp->data + xdp->mb.headlen;
> +		return 0;
> +	}

But I guess that's an offset; but that means the helper is not doing
what it says it's doing if it's within the first fragment. That should
probably be made consistent... :)

-Toke

