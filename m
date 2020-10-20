Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB9A2941D3
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408907AbgJTSDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 14:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408885AbgJTSDp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Oct 2020 14:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603217023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+hw9pDBfQhWZiRkExgEhd3YAIxYMlrpGhZNKTigtMU=;
        b=DCX/Z/RoF93R2tv+kfClrsy4bXGc8NSBIAcTeqVkXyzO27O1CeuN5KQ1+mdqdaRBvO69gL
        Zz8BNZPyjGOOXJclNad8sph0SHGT8rgy8KqgOo8r9WbK6szJ//55FszINQk7EMCW77walO
        dcBDciNiVjUlJHrvKckghrL9FO7aK6s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-qqmv2IFxOHuHusGUqYTzyQ-1; Tue, 20 Oct 2020 14:03:42 -0400
X-MC-Unique: qqmv2IFxOHuHusGUqYTzyQ-1
Received: by mail-ed1-f70.google.com with SMTP id dn20so919290edb.14
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 11:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=R+hw9pDBfQhWZiRkExgEhd3YAIxYMlrpGhZNKTigtMU=;
        b=eIaWuuSK8qZDFMJZ3JVVuagoFF/0VIFHXF6a2t4zU8+7AaPq19sfe2EJQHw2fk2O5N
         lFV3wtygUtXcpLitpdrrPZyNFaZdiyv1NJXKPQDSiKcXEqAay2GXsEWt/YTmJKUG30gs
         8V6EpWoRAZfzq5+mUWpdzxVTw3C9lAWr/PyGlozn54Tx5D6ska9re9lVDsSlOm0NRWSb
         ccn4TseQfGNxAZxbnBNzMFtWuuxiQZjr0a5mfu2o65eOcfR5dmsy3fMsN0I67o86ULbd
         4uZUpuPJPqK6B8rw2oiNbHVt3Kl9/ixUvP3bEnYUsaT1IBYBtnJX2U+QrZPHkDtCR2Qx
         5pUw==
X-Gm-Message-State: AOAM530Mmo3FKcWXtyYIHyvDX+OmR2sfObQwOUKe4CTUR0NHNg3JBnTm
        hD4WnSqQ2B9Wn7KVj6aQJltaCyyAR19OxQPxY3CQE/E7fVPKVqCAdD9dtfipBzhA+x+GaNXGujT
        EUDhBSG7ZUvbN
X-Received: by 2002:a17:906:fa99:: with SMTP id lt25mr4261358ejb.511.1603217020796;
        Tue, 20 Oct 2020 11:03:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDRxB+C7L4z0vpks9Bnjcj86EiCKKVqBknhXESE72XqvM3lmkE694arfl/UYujTace3+5AUw==
X-Received: by 2002:a17:906:fa99:: with SMTP id lt25mr4261338ejb.511.1603217020544;
        Tue, 20 Oct 2020 11:03:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r24sm3200856eds.67.2020.10.20.11.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:03:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 900321838FA; Tue, 20 Oct 2020 20:03:39 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/3] bpf_redirect_neigh: Support supplying the
 nexthop as a helper parameter
In-Reply-To: <20201020093405.59079473@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <160319106111.15822.18417665895694986295.stgit@toke.dk>
 <160319106221.15822.2629789706666194966.stgit@toke.dk>
 <20201020093405.59079473@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Oct 2020 20:03:39 +0200
Message-ID: <87zh4g22ro.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 20 Oct 2020 12:51:02 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> +struct bpf_nh_params {
>> +	u8 nh_family;
>> +	union {
>> +		__u32 ipv4_nh;
>> +		struct in6_addr ipv6_nh;
>> +	};
>> +};
>
> Folks, not directly related to this set, but there's a SRv6 patch going
> around which adds ifindex, otherwise nh can't be link local.
>
> I wonder if we want to consider this use case from the start (or the
> close approximation of start in this case ;)).

The ifindex is there, it's just in the function call signature instead
of the struct... Or did you mean something different?

-Toke

