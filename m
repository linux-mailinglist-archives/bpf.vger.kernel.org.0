Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638D5DCE0E
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 20:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390501AbfJRSgN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 14:36:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33807 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfJRSgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 14:36:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so4413618pfa.1
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=F1226GAHCP5ljRI20xaHaZyrtrpwD3DRasaIdGAzha8=;
        b=gYItQ9PfoxYjaqLHy8Kcppym7sg1bY1cm2rfEaSgMNYNjuUAWGuhXXeT4PliR9JvY6
         jDg4T7Q2knJ3jm05K9hPrXADfDdRhNWLlN7Hs2BnaNOx3TjoPz6VrCS8sX3y89G4fqhx
         BLeSyXg/n7xCPa7hGJctnrMNYVvgBU6uA+bKX3sT4sHJoRbw/AQoh1xJBn27K2Kgafg6
         +bIZac9RlQ4M+EoDobG2sR0IwctNGcANcKkeMF+v+CzR/hq73dyOUUe2EWoi1Ke70WRn
         fec6oxtwyzuunU6ayPsV0wn95M/HpajDMhlnlfnebxkAd4gQbMpZtEvqXbOnnBbrETHZ
         oeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=F1226GAHCP5ljRI20xaHaZyrtrpwD3DRasaIdGAzha8=;
        b=WJyb3iNnGcBHBbyDSvAZNPTQJpbI4x9H9mWf4NuHx8BlsHzQtov5ghbFJgXldZb44N
         bm1p4cDhjZ5tybB4y+EaUEN+IUvyKM/6DGa/yRpJLZDhOPylO80Yt/kTFokGAoOi1VmP
         jLx/OmUyQEaDAEWp12eVJcvZTAgc6kyMW5Nyxe65c9qfjJuf9DoQ4leFYPl16jnc0sCW
         x3n2OX5zK5qGabbWCFuh8ifzdoaS0ONXJ16qvcZ5K8JJ6ahkbFNInmQmRW/CFXhgYeGy
         4ySQnDSjnuuQxFrKgnuhxIXkEE630ACmy8B+fFsrKuWl1NupkujuX6myo5bc9jF73j9F
         +g1w==
X-Gm-Message-State: APjAAAVm8APA+xZyC+XptVpptyv2hkj4x+QTZgSDAGurZA5sQBqI98EV
        8/mrMp0GSuE4MPXM/YzkK7W/yg==
X-Google-Smtp-Source: APXvYqxjegWkTeh7600ZdsBgRCfTvjITWGlnWIIDHxZqQMZ4GF/bfOC/HLYzQDdOwgVpWppQkrS+kA==
X-Received: by 2002:a17:90a:266e:: with SMTP id l101mr13008557pje.104.1571423771947;
        Fri, 18 Oct 2019 11:36:11 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v9sm6727381pfe.1.2019.10.18.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 11:36:11 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:19:49 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     daniel@iogearbox.net, ast@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH bpf] xdp: Prevent overflow in devmap_hash cost
 calculation for 32-bit builds
Message-ID: <20191018101949.7043c7d9@cakuba.netronome.com>
In-Reply-To: <87y2xie7no.fsf@toke.dk>
References: <20191017105702.2807093-1-toke@redhat.com>
        <20191017115236.17895561@cakuba.netronome.com>
        <87y2xie7no.fsf@toke.dk>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 18 Oct 2019 11:15:39 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Jakub Kicinski <jakub.kicinski@netronome.com> writes:
>=20
> > On Thu, 17 Oct 2019 12:57:02 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote: =20
> >> Tetsuo pointed out that without an explicit cast, the cost calculation=
 for
> >> devmap_hash type maps could overflow on 32-bit builds. This adds the
> >> missing cast.
> >>=20
> >> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up dev=
ices by hashed index")
> >> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> ---
> >>  kernel/bpf/devmap.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> >> index a0a1153da5ae..e34fac6022eb 100644
> >> --- a/kernel/bpf/devmap.c
> >> +++ b/kernel/bpf/devmap.c
> >> @@ -128,7 +128,7 @@ static int dev_map_init_map(struct bpf_dtab *dtab,=
 union bpf_attr *attr)
> >> =20
> >>  		if (!dtab->n_buckets) /* Overflow check */
> >>  			return -EINVAL;
> >> -		cost +=3D sizeof(struct hlist_head) * dtab->n_buckets;
> >> +		cost +=3D (u64) sizeof(struct hlist_head) * dtab->n_buckets; =20
> >
> > array_size()? =20
>=20
> Well, array_size does this:
>=20
> 	if (check_mul_overflow(a, b, &bytes))
> 		return SIZE_MAX;
>=20
> However, we don't to return SIZE_MAX on overflow, we want the
> calculation itself to be done in 64 bits so it won't overflow... Or?

Note that array_size calculates on size_t, so it should be fine.
But looking at it, it seems all of this code uses the (u64) cast,=20
so I guess that's fine. Clean up for another day :)
