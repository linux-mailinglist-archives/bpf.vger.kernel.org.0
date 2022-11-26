Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669B8639648
	for <lists+bpf@lfdr.de>; Sat, 26 Nov 2022 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKZOMV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Nov 2022 09:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZOMV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Nov 2022 09:12:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442AB1FF8C;
        Sat, 26 Nov 2022 06:12:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p16so5392556wmc.3;
        Sat, 26 Nov 2022 06:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mP0jQyPa/WPgNondQxR1aqMRo1/9+aoHgpIr8lZMUQ=;
        b=aOVOmwdAaahnaO9K5sR9Os63SuX6ti1w8q3DaF02HA/Q/eifGYgkU8s0g4MzJL0i9B
         YLt3rD+8e5eVR/hxqucOk8bld3quh9E2IzYpErFZINgztMWyROTBzGfP79IUTcjs5Db9
         S7zZbaSFxOkxblLZDNtmmdrdih5hKKsekN+q0i+JJU71B2jdfXBzi996VkDLoOVmr+eD
         4zeTGdEZbrcYzGCA4mHrLS1PXmGDrTIpmooS5Hq6m1y7LLVDSQqiOp0GBSE9s2+fOJlP
         eOTl/RE4VQJBo/3IcckwAnQsjKaOrTMyEwGud7HJ9NMMB14tmRUX0AEYynKonUIfI1kk
         pNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mP0jQyPa/WPgNondQxR1aqMRo1/9+aoHgpIr8lZMUQ=;
        b=16t8VzFTtFdz/g+o+/jZUgSkfXvgQuEYw3SxnM0Vdc24pznjCBQHcX3j7C3P97xkhY
         3XSoEX3UsbMLJFBNNWyeCj9+sENy7HChl5GgilmgzQ6U+SyjiUQWsK85L8Ll9q1lHshd
         zakBRbPshaUy+1XlpzHIPcrzTjJJ/Wglztl5TivJzFHk0a2mZva5qaIJRekcE4t18dCu
         /U+43b/Iop0qemMQysoa4uIWTBMChARffJR17sSoIxj2TooT9kkDKkT1sYUrU6ry4l6j
         +XJruQzxpIZ8/eOM7+1l06JQiBZHm5FK/5nHn+v6oi2DPYofS9SMe0P0SjxSCj3k71Xc
         GYvw==
X-Gm-Message-State: ANoB5pkO8oXNpaX6lrtAMcRO4qkMa2YW1XraDeudkw/fGHs4sdy/oPMC
        kwrma/x7d9Xo+8HJAmhqXPw=
X-Google-Smtp-Source: AA0mqf6W2A96Yp+3IpF3gNdgNV8Kyd6By66H/QbebR2FvXf2wOh1fGTxI0r+vSsgrOFA8RPxOnNn0g==
X-Received: by 2002:a05:600c:1c9d:b0:3cf:69ec:9628 with SMTP id k29-20020a05600c1c9d00b003cf69ec9628mr32055376wms.79.1669471938450;
        Sat, 26 Nov 2022 06:12:18 -0800 (PST)
Received: from suse.localnet (host-79-55-110-244.retail.telecomitalia.it. [79.55.110.244])
        by smtp.gmail.com with ESMTPSA id j29-20020a5d6e5d000000b00241b371d73esm6188413wrz.77.2022.11.26.06.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 06:12:17 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v4] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Sat, 26 Nov 2022 15:12:16 +0100
Message-ID: <2188828.irdbgypaU6@suse>
In-Reply-To: <Y4FG0O7VWTTng5yh@ZenIV>
References: <20221016163855.8173-1-fmdefrancesco@gmail.com> <Y4E++JERgUMoqfjG@ZenIV> <Y4FG0O7VWTTng5yh@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On venerd=EC 25 novembre 2022 23:50:56 CET Al Viro wrote:
> On Fri, Nov 25, 2022 at 10:17:28PM +0000, Al Viro wrote:
> > The bottom line:
> > 	* teach your ufs_put_page() to accept any address within the page
> > 	* flip the ways you return page and address in ufs_get_page()
> > 	* use offset_in_page(addr) instead of these addr -=20
page_address(page)
> >=20
> > and you'll get a much smaller patch, with a lot less noise in it.
> > What's more, offset_in_page() part can be carved out into a separate
> > commit - it's valid on its own, and it makes both halves easier to
> > follow.
> >=20
> > AFAICS, similar observations apply in your sysvfs patch; the point about
> > calling conventions for ufs_get_page() definitely applies there, and
> > stronger than for ufs - those casts are eye-watering...
>=20
> As the matter of fact, I'd probably split it into 3 steps:
> 	1) switch the calling conventions of ufs_get_page() - callers follow
> it with something like kaddr =3D page_address(page); and that change makes
> sense on its own.  Isolated and easy to follow.
> 	2) offset_in_page() changes.  Again, separate, stands on its own and
> is easy to follow.
> 	3) kmap_local() switch itself - pass address to ufs_put_page(), etc.
> Considerably smaller and less cluttered than your current variant.

Al, thanks for taking the time to answer in such detail although I can beli=
eve=20
that, to spot the mistakes in my patch and then write your email, it probab=
ly=20
took you 10 minutes or so :-)

Instead I had to read two or three times to make sense of it all. I will do=
 my=20
best to first rewrite these kmap_local_page() conversions in fs/ufs by=20
separating the work into three patches, as you recommended.

I'm pretty sure that the next attempt won't be applicable yet, because I mi=
ght=20
not fully understand your suggestions or I might not be able to implement t=
hem=20
correctly. I'm afraid I addressed something that, as it stands, is a little=
=20
beyond my knowledge and experience, so I hope you'll want to chime in and=20
comment on the next version as well.

When the changes to fs/ufs will be done I will also rewrite the patch for f=
s/
sysv which (as you pointed out) needs to be worked out according to the sam=
e=20
requirements.

I am sincerely grateful to you also because it seemed to me that I would ne=
ver=20
get any feedback regarding these two old patches.

Regards,

=46abio



