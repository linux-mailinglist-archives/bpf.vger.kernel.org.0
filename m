Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3022531313B
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhBHLqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 06:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233048AbhBHLnl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Feb 2021 06:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612784534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZYHP4/VLuvN2DRnNGs4g8F2eM2skx1+3fiYM2APmO8=;
        b=dem2U8Yb9Bx6wMg+KvzzWvetvwOGeUfoGPG8A51DxjN/oIBHyGEcgpFKH5E63EY8ik888h
        7AQUAI/NFdqvGyjhtd8f3lCqtjtixt558kGLO8QbsVs6/J1g2l3iJO/CTJ+wdFG0gabk+m
        2ZqY8XPV1KPoDXJydgGfjN7vUQEkYNQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-A4d9_PkyN6i6nK4xgmQKLQ-1; Mon, 08 Feb 2021 06:42:13 -0500
X-MC-Unique: A4d9_PkyN6i6nK4xgmQKLQ-1
Received: by mail-ej1-f71.google.com with SMTP id ar1so8015091ejc.22
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 03:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SZYHP4/VLuvN2DRnNGs4g8F2eM2skx1+3fiYM2APmO8=;
        b=fZ6Irro3RwAWdMEx8jLkAkm3lMuSIiS0gBlNfgYaViMZ36A3sYdLOAY6309YyPPLbi
         eyxmYizzsAZJVFT/qfu5G4jRtsbh7FDGqk5+J/iQZaU+WETbyvYrIEviaZpGR46wUwnP
         nIKLlEsvyMedF5h/dqKxF8bTndhJqpIjh2zWwKp1nVCoA4djhl5ZkY/K976jxmVqxcEc
         CJDIzCCpX3mTxL6MpYwqbyuH8cPzro1mZtZ5ND6Sb7AQUHwzTrEx+mOVuMQoZV03YU2w
         v6gldFL5/1jZixKE9XN2YS6fntHSPB0aMVQd1WkgD54gMfl7dB0Tdo1fBDzqjMxbTnxB
         hTtQ==
X-Gm-Message-State: AOAM5320ztT++iE2W9eF2fxvbDwEYHgjKbVApmG4xec992DX8BlJWKAM
        pVTts6WAcEQOI5/kiYuHD6qn4vrzVyloyzbD0qE3n47rf34xNdd5Pcb7t6vxt4pq1Ch3ghu2izs
        RejyN4Z5MQFsj
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr16796687ejb.355.1612784531800;
        Mon, 08 Feb 2021 03:42:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysOIPIO5xinDtHUS3eRimPSuvyRO4TY391pRe3Qcb7H3ltucD4bGHjs7qKAZB4+VYNRz48pA==
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr16796674ejb.355.1612784531615;
        Mon, 08 Feb 2021 03:42:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k4sm8480531eji.82.2021.02.08.03.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:42:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B33101804EE; Mon,  8 Feb 2021 12:42:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Gilad Reti <gilad.reti@gmail.com>, bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>
Subject: Re: libbpf: pinning multiple progs from the same section
In-Reply-To: <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Feb 2021 12:42:09 +0100
Message-ID: <87v9b2u6pa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Gilad Reti <gilad.reti@gmail.com> writes:

> Also, is there a way to set the pin path to all maps/programs at once?
> For example, bpf_object__pin_maps pins all maps at a specific path,
> but as far as I was able to find there is no similar function to set
> the pin path for all maps only (without pinning) so that at loading
> time libbpf will try to reuse all maps. The only way to achieve a
> complete reuse of all maps that I could find is to "reverse engineer"
> libbpf's pin path generation algorithm (i.e. <path>/<map_name>) and
> set the pin path on each map before load.

You can set the 'pinning' attribute in the map definition - add
'__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By default
this will pin beneath /sys/fs/bpf, but you can customise that by setting
the pin_root_path attribute in bpf_object_open_opts.

-Toke

