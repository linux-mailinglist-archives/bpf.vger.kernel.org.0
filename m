Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5D6F3698
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 21:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjEATSs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjEATSe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 15:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A4173E
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 12:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8DEF60FE2
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 19:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DA3C433D2;
        Mon,  1 May 2023 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682968712;
        bh=GaxbhBwVR7T/4mnSvn+D1IQFbOe+S0UuiCnU7E7HfZ0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ROHKA2iOxM/4ZiJVM97wGhlvN8SvdBVaux3bPVzeAl8BV4XeXHYjumLoPwsTz9QMQ
         n9lYD/Qh5Uy2rTElDFLROdXOwAxapuZ/dKUzoFODBjao/+YxWIJwI+5F3PUe8Y7G5h
         XOUFW9V84YHMkRW/OXRV/3ENJCoAdsQn61rDri1QbLmrtY62r+nafHGhTyWONO9Fqn
         XaZxWE+oraS4JGLZNXtNLU3LG1zpf1TKWe+i84n50wAlZqBdieLSR36+kFhZZsjRO1
         xzAKyLjMKdJQInPsZzQJWBfivgo3eRPlnSaSvuyW8J7Rz/XsPMMEqVWuyKOIp6u9Ik
         wMiVNyBzvWwtA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B56A6ADD17D; Mon,  1 May 2023 21:18:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>
Subject: Re: [ANN] bpf development stats for 6.4
In-Reply-To: <ZFAOojsT93ZxwNu3@google.com>
References: <ZFAOojsT93ZxwNu3@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 01 May 2023 21:18:29 +0200
Message-ID: <87wn1r6et6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> Hi all,
>
> Here is my attempt to apply Jakub's scripts to analyze mailing list activ=
ity.
> See the following link for mode details and methodology:
> https://lore.kernel.org/netdev/4d47c418-32d9-4d6a-9510-a6a927ebe61b@lunn.=
ch/T/#t
>
> tl;dr: people/companies receive higher score when they participate in rev=
iews
> (vs only sending patches).
>
> For now, I'm providing the numbers without any analysis.

Thanks for running the numbers!


>   12. [233] Toke H=C3=AF=C2=BF=C2=BDiland-J=C3=AF=C2=BF=C2=BDrgensen    1=
2. [ 37] "D. Wythe"

Looks like the script is a bit UTF-8-challenged, though (or some
conversion went wrong afterwards, maybe?) :)

(But yay, I made the list!)

-Toke
