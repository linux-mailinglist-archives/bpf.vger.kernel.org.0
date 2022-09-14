Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10D5B878E
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 13:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiINLwk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 07:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiINLwj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 07:52:39 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1477AC0C
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 04:52:37 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-127ba06d03fso40255568fac.3
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ndUOLxOaGlFRGIa+IUCqchYoYX0ob/eqM4B2Su7aOP0=;
        b=EYX698uwfmKMSXh/ILCEGi20kLHVC2QuF0Wcs243ekp242ONMvwY1QBX2Wui6PGcDI
         CStw08eCxFr2759UFNnBa8qHHa4Win2S11Vurdt3ZiGKFm99xL6z796AH36DFexOXHDP
         zceFKtA8ZYKgFgi2lYpPZ4YFgTfHW75lvh0G4BuwOq1lyzddQzX9zqz0gVeu016zV1zD
         p7pXrSD4aLmWaQ02ILxqsWj/iVqXRyGwtUm79+trpdTViGk3qIKqq7Db2TJdO+s7ryjY
         6ehpS2yC1VWqMsZ7CzGOU4R+6lla4NmIAE5RKYGCXbWJFKfbJy5VfKDaamgKn3aZsgRm
         A9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ndUOLxOaGlFRGIa+IUCqchYoYX0ob/eqM4B2Su7aOP0=;
        b=ZZ2CzdUjfo7NNACK4Pu71iE/ognTOnAeDVfeoEK8LIguVGSao/gHtIp9oD1sqeqH5w
         ETZ0w1bs7wf/u89216yPTroFYoLSNooLj0lC3GJZbzMIp7mGY1ve1lzfrTGlR8v40ARW
         NVYXVPDEYKRWiW7AZtqP1nt7DJeNGDafP961QGpb0MPZo2XVZxrMwtI94ocW7eWrdEMI
         hD9Y8hjeiDJ/an3LqvWmiV2sSLjC/sCrJNbxoLjfNYRiLJVrJj9SCf9MEHdEHdlH2kgx
         A2Zq3RFXYRljNyif9dzSJqLHVVayMFqWy+wvzfGuvp1pk+KwJqHzXUPVIBHsdYCP7P18
         /NNA==
X-Gm-Message-State: ACgBeo1Rp1bg6RED3lULw7F9RVb+5gyE11C/SdAZ2in6MJvM8PtdT+aT
        x5WzIqtGgqNHxkKYAuekB70P+ii69WCP3NTvC9fe
X-Google-Smtp-Source: AA6agR6NuCDcdGmTw2CRi4kDEce0q6x+ZkxaJ0aByIguJ13AxbD6awMbL0ptxfjdNAPNp3SxBD/Oa58zKL17FN8ONQ4=
X-Received: by 2002:a05:6808:1a18:b0:34f:ff74:8303 with SMTP id
 bk24-20020a0568081a1800b0034fff748303mr1737508oib.41.1663156357118; Wed, 14
 Sep 2022 04:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220912091718.18053-1-xu.panda@zte.com.cn>
In-Reply-To: <20220912091718.18053-1-xu.panda@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Sep 2022 07:52:26 -0400
Message-ID: <CAHC9VhSnzZ-75EVyOx6SO1_61y7HT-oGHisCwNSeM+VpjzhaDQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] selinux/hooks: remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 12, 2022 at 5:24 AM <cgel.zte@gmail.com> wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>
> Return the value avc_has_perm() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  security/selinux/hooks.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)

Merged into selinux/next, thanks.

-- 
paul-moore.com
