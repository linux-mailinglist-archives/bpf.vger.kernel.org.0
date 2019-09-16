Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D62B3F7E
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfIPRP4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 13:15:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45598 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbfIPRP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 13:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pKYQCMu5Ew9eTX6pbhaq2BMM6o7kuFp6qMQrSf8Ncmg=; b=IZkc4kQTdFury5z5agwZqDsTF
        OD425v2AQe+39GC5L9AFsW6Z4Fmrbv7hueDCeEs5GC11uUplxLCPentN1Vps2kgpwF7orC+/KiWi+
        GwXkixQeEb6I0/ggQ6QFKY3h4v8zWT/R2vxHq0ND1b+iLIKZtapGuPmCmgbpmo9I2nV2s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9ubP-0005EI-CJ; Mon, 16 Sep 2019 17:15:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5F6892741A0D; Mon, 16 Sep 2019 18:15:50 +0100 (BST)
Date:   Mon, 16 Sep 2019 18:15:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
Message-ID: <20190916171550.GJ4352@sirena.co.uk>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <yq1y2yrdg6w.fsf@oracle.com>
 <20190916070101.GE18977@kadam>
 <yq1blvkb23m.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y3hCyKCCnioDaTIs"
Content-Disposition: inline
In-Reply-To: <yq1blvkb23m.fsf@oracle.com>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--Y3hCyKCCnioDaTIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2019 at 01:08:45PM -0400, Martin K. Petersen wrote:

> Vendor driver submissions, however, are generally huge. Sometimes 50+
> patches per submission window. And during this window I often get on the
> order of 10 to 20 patches for the same driver in the fixes tree. It is
> not always easy to determine whether a bug fix series is for one tree or
> the other.

I get the impression that a lot of vendors just don't distinguish and
only really care about getting things upstream, especially in the
embedded world many of them realistically expect to be shipping a pile
of out of tree patches to anyone using anything other than mainline
anyway so it's not super clear to them that it's worthwhile.  This goes
back to the converstations about stable and how vendors interact with
that.

--Y3hCyKCCnioDaTIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/w0UACgkQJNaLcl1U
h9CWZQf/bJEaAhJ2Jmw6j0ouL6Ar57UT+tZpuzfw210a2H0xjdN9gERqaSmt7vtN
oC3gvj3MXjUgszuLCeTTYNskiNrgmZq9yICZh0tLEUk8Qi21qZTnyLr7yOMxFinv
rIG4zKkc2OY1M9RZEEasl78vgmX/WE8a1umabatF7a1QNes98pnoxaO+LF/VOJVM
s3eNaantTut35U3PDDf5/F4I2KGof3xBq3lXhLAh8FfAGWT2DUSQdjlRE67Mg58b
2UTgwcmcdAWDHYQpdEOhotF7vSnWWbm5LZ9djO4q2CZFD+HTCCtN1NpXpusR5RSI
3JtgUwuHa8/ucGJ5O7yvSmL8FEw4cg==
=sHVd
-----END PGP SIGNATURE-----

--Y3hCyKCCnioDaTIs--
