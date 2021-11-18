Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C49455986
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 11:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbhKRLCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:02:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235730AbhKRLB7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637233138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaJ4JTGV/useo1QJJf01J8ZkPaZO3mYQ/FtttjXduPM=;
        b=UsSzJTJ9WZE/hYMipeO8o3A5BewK85f80t5kqsqxxr4lrT59SxC29yePtpvDmtRoPXN7d/
        FWv+KpVhAzbrpCDh9EaZUZU/wMvXE/ZOwa+ZQv9DtdY3jHylE44R0nSfmSTItJexrjAM0o
        e6yDnuKKRnN1bW4ZjwuJMIzMzSDosm0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-QcyfLXnePGispGCg0HRSZA-1; Thu, 18 Nov 2021 05:58:57 -0500
X-MC-Unique: QcyfLXnePGispGCg0HRSZA-1
Received: by mail-ed1-f70.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso4920958edb.11
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 02:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kaJ4JTGV/useo1QJJf01J8ZkPaZO3mYQ/FtttjXduPM=;
        b=L8f9+oJvYQs58yrDQYdn6moA4pJiJo6c1cgjCUS4lrbPKOVP9WDi0/qMl3sJh8XvAf
         SroBHByIH/MJ5MvSJeI96QxDEGzdZ1deYuGcIrsydCA/W0xTGg/WJzwWi2FC4untm5dK
         YGz0fnfqHud8C4aAJOYY3lFLTY0RrCjUPfDnb9KibiFfgWu261c16O5mjLbiBLr9cuvu
         PpcZRXrIpAZ0IPHwAkCosIAE65Be2JYlYJIV12bA49jsWGD1q1xp8wxAK0mVGKou04Ds
         aLnuS3by6yIkA+0k+dGPM6iQ8hRpWmS/YHGhIyDXQewRK10IJ7hdasMLAuSUEqE++OaO
         wp8A==
X-Gm-Message-State: AOAM5325NDQLkndhIPiKCTy4qTe8plGqLBH1NNlvnbA3x8A9xQZMkAmR
        GFRGm3tl28Gj15uspO1UzXtnykTo0VeSpu7ZCiR3qiOrNtve4ZsK+WIYTJIf2Be4K2b2WXbtzdX
        FXT+Lm3xVY5Ob
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr9982740edq.160.1637233136188;
        Thu, 18 Nov 2021 02:58:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyu5tbFjz0Ifq9bVZL101160u2GPyacVXsjy0Ui7hipCBOTYoBoOKdpj4Lo+UxlToZdS2kEmA==
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr9982675edq.160.1637233135741;
        Thu, 18 Nov 2021 02:58:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g11sm496574edz.53.2021.11.18.02.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:58:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2193A180270; Thu, 18 Nov 2021 11:58:54 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] libbpf: add runtime APIs to query libbpf version
In-Reply-To: <20211118012018.2124797-1-andrii@kernel.org>
References: <20211118012018.2124797-1-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Nov 2021 11:58:54 +0100
Message-ID: <87zgq1enm9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> Libbpf provided LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION macros to
> check libbpf version at compilation time. This doesn't cover all the
> needs, though, because version of libbpf that application is compiled
> against doesn't necessarily match the version of libbpf at runtime,
> especially if libbpf is used as a shared library.
>
> Add libbpf_major_version() and libbpf_minor_version() returning major
> and minor versions, respectively, as integers. Also add a convenience
> libbpf_version_string() for various tooling using libbpf to print out
> libbpf version in a human-readable form. Currently it will return
> "v0.6", but in the future it can contains some extra information, so the
> format itself is not part of a stable API and shouldn't be relied upon.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Great!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

