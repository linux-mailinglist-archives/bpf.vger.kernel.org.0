Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6191B64BC55
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 19:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiLMSsz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 13:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbiLMSss (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 13:48:48 -0500
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Dec 2022 10:48:48 PST
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618C8E07
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:48:48 -0800 (PST)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1p5ACn-00072R-0m;
        Tue, 13 Dec 2022 13:40:41 -0500
Message-ID: <52c9d084d9852cc7c769dbb76f03a13df014c37f.camel@surriel.com>
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler
 class
From:   Rik van Riel <riel@surriel.com>
To:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Date:   Tue, 13 Dec 2022 13:40:40 -0500
In-Reply-To: <Y5jAc/Gs4gVRzkDe@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
         <20221130082313.3241517-15-tj@kernel.org>
         <Y5ckYyz14bxCvv40@hirez.programming.kicks-ass.net>
         <Y5eeGMpr/SuyGBQO@slm.duckdns.org>
         <Y5haDh3sYUFcXkBx@hirez.programming.kicks-ass.net>
         <Y5jAc/Gs4gVRzkDe@slm.duckdns.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-J5NzES9P4xwtTmKA+te4"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-J5NzES9P4xwtTmKA+te4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-12-13 at 08:12 -1000, Tejun Heo wrote:
> Hello,
>=20
> On Tue, Dec 13, 2022 at 11:55:10AM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 12, 2022 at 11:33:12AM -1000, Tejun Heo wrote:
> >=20
> > > Here, the way it's handled is a bit different, SCX has
> > > a watchdog mechanism implemented in "[PATCH 18/31] sched_ext:
> > > Implement
> > > runnable task stall watchdog", so if SCX tasks hang for whatever
> > > reason
> > > including being starved by CFS, it will get aborted and all tasks
> > > will be
> > > handed back to CFS. IOW, it's treated like any other BPF
> > > scheduler errors
> > > that can lead to stalls and recovered the same way.
> >=20
> > That all sounds quite terrible.. :/
>=20
> The main source of difference is that we can't implicitly trust the
> BPF
> scheduler and if it malfunctions or on user request, the system
> should
> always be recoverable, so there are some extra things which are
> inherently
> necessary to support that.
>=20
That makes me wonder whether loading an SCX policy
should just have that policy take over all of the
SCHED_OTHER tasks by default, and have a failure of
the policy just return those tasks to CFS?

Having the two be operative at the same time seems
to be a cause of hard to resolve issues, while simply
running all non-RT tasks under the loadable policy
could simplify both internal kernel interfaces, as
well as externally visible effects?

--=20
All Rights Reversed.

--=-J5NzES9P4xwtTmKA+te4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmOYxygACgkQznnekoTE
3oPFQgf8DXDaQVDEPmB52FNhGpq0/9CS1pbuYsFWFntBlTO9Rh4wj4pr19aZg8i1
D3RflOvjgZASN82WRgKdh6sHWKgwQMeCUcpQy9Exly2vsWFHgFwHx7p+j3udjyc3
LCDz8dRRoN4s17ahTvCitZk2YKLz7IV4igYANkl/u2q7X9nXFKFX8CW7CWRHlrkS
3CtxEt3A4wwUgp3NXiiKWsEGxkNmvAQJSzzglSnfp65lyvLfV4JHAznWHFXHie4r
VeTivRteu11k1CF81NyWIg/eKnlbz1LjE4zeWpKlZCq1mUuCISiTWhfg8g7OW/jS
LhguLYFv6LRNAukNTvxMxUvJ1RNCxA==
=f/5v
-----END PGP SIGNATURE-----

--=-J5NzES9P4xwtTmKA+te4--
