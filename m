Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50BD2929B7
	for <lists+bpf@lfdr.de>; Mon, 19 Oct 2020 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgJSOss (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Oct 2020 10:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729529AbgJSOsr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Oct 2020 10:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603118926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MWWutcR5pVHVHTyCCwcpQfBRR/x2k81YN4WOt/E6KKs=;
        b=ET0I3zodtW2oT4APL0JDHlnAOot/a/VQ07Mmf1UCNGh48B63/W8Q/dp1/hMPRtEQewuGsy
        G9sT9vNE9cfDFO+5Io3Yiuu76PmCTeNvKUYrLi5D9VYUvmBYFDkvpqxKMXBZ8wvKA+lC2j
        TzXOuqwvaKRRMlIW+2BvRX6LlRZiaY0=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-LHDK3j5nN1OS3k0Fyb-F5Q-1; Mon, 19 Oct 2020 10:48:43 -0400
X-MC-Unique: LHDK3j5nN1OS3k0Fyb-F5Q-1
Received: by mail-vs1-f71.google.com with SMTP id a143so2049677vsd.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 07:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MWWutcR5pVHVHTyCCwcpQfBRR/x2k81YN4WOt/E6KKs=;
        b=oDyIhq+szq9OgihVawC+iO0tSWrL+8iZ7XgZM7uEqt0Su7Ofrbh8ky+RMJo3u74oNU
         8Wk+WRNdPc/WNOwq24PyHRTEdRmInjE7nE4yGo/08TWjJTOpDArAnNLNB1tTYPMd0MTe
         P+U3ZlKMD9LYr5eH3pX13jHfhCPd3+/AJr3gXwdvvHoDyefJbZg8xsJ2mYNUHdS7I0pR
         kFckEPL0ntD1ZxiHrzu8IZpejdUdeFmkiyMPFsCD607PYxzigd5i3AJDmTCzWbwLiOxY
         XW83bbF2iip+JKcfueX7DV24BN5s8cRafiBXj7ITj9NGbrjHZNUkFsmV82A/c8E4A19+
         27tQ==
X-Gm-Message-State: AOAM530YdTqGgavc6jnH4xlvdGqDpghbA7W8TJ7JyIlnZqZW65AL/OWA
        AFK13mF3ift5xTSyQScxmOq/5PUKsqbgXyhkRBPVqvSrPC0rx+Iv3FyGuMAZYBC6KZzoCDH8b8O
        DlZ+8fQ3NrRRH
X-Received: by 2002:a67:ff91:: with SMTP id v17mr41313vsq.11.1603118922714;
        Mon, 19 Oct 2020 07:48:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQYxHsxPa+COy4XaT/QpPe/wGt+h15wvCwAlfp7G5CNMN5qA7gNDKdrcbgfyacivpdTETe3w==
X-Received: by 2002:a67:ff91:: with SMTP id v17mr41294vsq.11.1603118922321;
        Mon, 19 Oct 2020 07:48:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v68sm19547vsb.32.2020.10.19.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:48:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EFB641837DD; Mon, 19 Oct 2020 16:48:39 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 2/2] selftests: Update test_tc_neigh to use
 the modified bpf_redirect_neigh()
In-Reply-To: <684a0bd5-b131-c620-ed5e-d1ea7d151ae1@iogearbox.net>
References: <160277680746.157904.8726318184090980429.stgit@toke.dk>
 <160277680973.157904.15451524562795164056.stgit@toke.dk>
 <684a0bd5-b131-c620-ed5e-d1ea7d151ae1@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 19 Oct 2020 16:48:39 +0200
Message-ID: <87wnzme0fs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 10/15/20 5:46 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> This updates the test_tc_neigh selftest to use the new syntax of
>> bpf_redirect_neigh(). To exercise the helper both with and without the
>> optional parameter, one forwarding direction is changed to do a
>> bpf_fib_lookup() followed by a call to bpf_redirect_neigh(), while the
>> other direction is using the map-based ifindex lookup letting the redire=
ct
>> helper resolve the nexthop from the FIB.
>>=20
>> This also fixes the test_tc_redirect.sh script to work on systems that h=
ave
>> a consolidated dual-stack 'ping' binary instead of separate ping/ping6
>> versions.
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> I would prefer if you could not mix the two tests, meaning, one complete =
test
> case is only with bpf_redirect_neigh(get_dev_ifindex(xxx), NULL, 0, 0) fo=
r both
> directions, and another self-contained one is with fib lookup + bpf_redir=
ect_neigh
> with params, even if it means we duplicate test_tc_neigh.c slighly, but I=
 think
> that's fine for sake of test coverage.

Sure, can do :)

-Toke

