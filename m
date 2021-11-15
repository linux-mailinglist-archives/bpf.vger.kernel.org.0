Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0603450987
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 17:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhKOQYf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 11:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhKOQXp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Nov 2021 11:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636993249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJXd3y47Yvuh4jq6RhS8xDO4xus8QSeywbiwUwhav7s=;
        b=M3mKJAdC0CpSzzobSWjAVZur9dkY7peMTzyeFGhztwfguWYWb2wucglZJccLbDrrk+o1Qh
        Euc2ZQzBeK9Ne7BSQqMaZ/LHJAMtShfTz8g5hOQw403+T2AVKoPwVRGBDDCbNANHkHYiHr
        IpquQBjngoI7x0Se3cgy6iR7NGtY41o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-MO44ZxwyNNSrCX4ExWokZA-1; Mon, 15 Nov 2021 11:20:48 -0500
X-MC-Unique: MO44ZxwyNNSrCX4ExWokZA-1
Received: by mail-qv1-f71.google.com with SMTP id j9-20020a05621419c900b003b815c01a54so16344365qvc.10
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 08:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hJXd3y47Yvuh4jq6RhS8xDO4xus8QSeywbiwUwhav7s=;
        b=qfaEueYiVAtgD5M4opq2/SbvVXAipsmBxL9JhKTMCNJZgk2Do43JhtZlmqEeEKTTAF
         k79xZJ+8h/U75z89PA0DxvOJ1ocUDkB+aHWW9QHOsoL69q+NqGLAJtZO3u7ZtpeHZ90t
         XAi27jrI9lhkf+OCYjzp5IDKDEra5QtXf1RgYNWZdCM3uAmxcZ7GTzkBhq3ADCtcVK2m
         hPMTqHY1vOPRqGWGvap1B2eSy2LWmVFGet/j4H3siEz9a7yaeBLw2mXjPRRw/xCNY9y0
         GvVuIIF7HazimQIIMLiIlW1HTmD3e1WKic806QVJRFKfs+P7Q5n1miB7KKuONCEVQn1A
         F7Fg==
X-Gm-Message-State: AOAM532TtkKWl/IgWy2CH8G5TDx9Vyx2XlwO+9AuaJf14WAK6cN1PFdY
        xfxttby4kqvcMyJVBj4uwC0oLEX0jOHfzm1ptP7nMXDDLiaEIgsIzgsSHX6BNOauldmyP9+AMBd
        GmmFTh4GwV8B/
X-Received: by 2002:ac8:5855:: with SMTP id h21mr243848qth.8.1636993247374;
        Mon, 15 Nov 2021 08:20:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznTB6ASLKQoL3laWA31P0QaPk9N0ZM4IS6XXkdl36U8FSBxNvhTFzyGLHOG8DQoDP7389EFA==
X-Received: by 2002:ac8:5855:: with SMTP id h21mr243788qth.8.1636993246950;
        Mon, 15 Nov 2021 08:20:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m9sm7114499qkn.59.2021.11.15.08.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DCB4718026E; Mon, 15 Nov 2021 17:20:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] bpf: do not WARN in bpf_warn_invalid_xdp_action()
In-Reply-To: <188c69a78ff2b1488ac16a1928311ea3ab39abed.1636987322.git.pabeni@redhat.com>
References: <cover.1636987322.git.pabeni@redhat.com>
 <188c69a78ff2b1488ac16a1928311ea3ab39abed.1636987322.git.pabeni@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 15 Nov 2021 17:20:38 +0100
Message-ID: <875ysto0fd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> writes:

> The WARN_ONCE() in bpf_warn_invalid_xdp_action() can be triggered by
> any bugged program, and even attaching a correct program to a NIC
> not supporting the given action.
>
> The resulting splat, beyond polluting the logs, fouls automated tools:
> e.g. a syzkaller reproducers using an XDP program returning an
> unsupported action will never pass validation.
>
> Replace the WARN_ONCE with a less intrusive pr_warn_once().
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

