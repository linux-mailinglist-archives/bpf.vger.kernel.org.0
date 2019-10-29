Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D18E8C79
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 17:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390313AbfJ2QMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 12:12:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36554 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390165AbfJ2QMP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 12:12:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so7256990plp.3
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NAT8h3GfCznRCCQkShL2kjx8siB2Aq1MMhmzBSGzR4o=;
        b=SMLnelVjMgKOG8ilrMR71i9XzSvVIOn8uwHhfNcFvbJmE6LUDIKoDkrWO5TNbu9nUc
         1b6FoO0se8vhk1WBUYHot70AHlWfvd/NDGO/eywynvddTtip/VP0dcvD0LyNXDcEREKB
         kmBybkBrGoiuw+ebRpGIZkRsn7Gh7IzMeBgHzA8KvKDjiZyBUYlVPk0sC0+GyMge/mfu
         7vP/pRlmDhvRIPtBuTXUwGZSh845KE1QYmj0kgRMSOQIDVs6roaAGD9eOHTsvXo0wHne
         N0bYQPk0GMqnw7Rod/7d0KrV9S4siHy7sGlqkFTI7qEj2xXgxhDkfaRjIjHBc2SNKZkw
         xKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NAT8h3GfCznRCCQkShL2kjx8siB2Aq1MMhmzBSGzR4o=;
        b=PofIt0S319gKj87nOIZMxNajH0vjHObla6pmmtbnFJ1RJF37n3I5jnGtP5UXevqws7
         KG0J+rHKMKJW4oNrjrFIKRFqpHUXdnVg77dK8JWHDm97GZFXAwBnGHNUyLxwruS/Z+cB
         mPRgM2ZpceoC9FqItq8GKIAqkOD3Z3z5joeaxJM+97N6uT6W51Y6BWeutpNvXdCryXUo
         vK19fOKRqodiW+Q3gEVD/RMlXW50OlaaIJ8NxBf3agrWfl3+DHWO2fcYJ0ZaZe2CQzEW
         iIlYGMVD4qtQVsq6NJz+7G+NglTeqbKcnnRHsZMgRhlGirGB0W46UaQjWAHhOnVxWOdf
         OLFw==
X-Gm-Message-State: APjAAAXX5cgdrAWI+wHjdijvYOP+yh0TbgLNj0o70l6jNHOHIk3jd58o
        asJLTlhxeeFGm0ObSYq0EvSFzw==
X-Google-Smtp-Source: APXvYqzJU+CBGmIoYxP8LYfNWQ98/DJqUSWUHBVzA1XruZNYpSy80rM2ImCnHJxD2DZ+Su0OSypEkg==
X-Received: by 2002:a17:902:321:: with SMTP id 30mr4997781pld.61.1572365534851;
        Tue, 29 Oct 2019 09:12:14 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id 13sm15392785pgm.76.2019.10.29.09.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:12:14 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:12:10 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, toke@redhat.com
Subject: Re: [PATCH bpf] bpf: change size to u64 for
 bpf_map_{area_alloc,charge_init}()
Message-ID: <20191029091210.0a7f0b37@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191029154307.23053-1-bjorn.topel@gmail.com>
References: <20191029154307.23053-1-bjorn.topel@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 29 Oct 2019 16:43:07 +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>=20
> The functions bpf_map_area_alloc() and bpf_map_charge_init() prior
> this commit passed the size parameter as size_t. In this commit this
> is changed to u64.
>=20
> All users of these functions avoid size_t overflows on 32-bit systems,
> by explicitly using u64 when calculating the allocation size and
> memory charge cost. However, since the result was narrowed by the
> size_t when passing size and cost to the functions, the overflow
> handling was in vain.
>=20
> Instead of changing all call sites to size_t and handle overflow at
> the call site, the parameter is changed to u64 and checked in the
> functions above.
>=20
> Fixes: d407bd25a204 ("bpf: don't trigger OOM killer under pressure with m=
ap alloc")
> Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init=
()")
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Okay, I guess that's the smallest change we can make here.

I'd prefer we went the way of using the standard overflow handling the
kernel has, rather than proliferating this u64 + U32_MAX comparison
stuff. But it's hard to argue with the patch length in light of the
necessary backports..

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
