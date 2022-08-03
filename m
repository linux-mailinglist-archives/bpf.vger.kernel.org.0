Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E81588585
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 03:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiHCBtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 21:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiHCBtU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 21:49:20 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949D32DBC
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 18:49:18 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10dc1b16c12so19270642fac.6
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 18:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WU2kUjnstyWYEWgZ7QsgdfMzDYXtd6/0pNDP+bXUFL0=;
        b=pIWX4GwdMT4s1CNUKjFxa/wUxQiqlI9U7FowMhYAeZa7umj+sPRJbIpi+Z21gUEYYE
         433Nns+UPJlflf0DqSQA3yiK/+50l7xj4k6R4ReZguOx2Cc7/g2fiMg95y1GNIUeDPMd
         V+Lh9P03ep6UhJYdGI8gJ0zY7ai0eAd28oK81+97R9w7l1upYIeN8vIpaEkwxwy8kZyf
         zZF9FkcCJzYUnpJN9gShop3mA/ecb4sYCuRekLHMd0Db1+9A7jivy5e5+ApU4h/2WX+4
         wZ2wbKDaLe7tCDrW3/uZmwaFwlh/rdLDYVY7kNr+hj2ws8TkzMpzrBJENITBpvMBXF4g
         ToUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WU2kUjnstyWYEWgZ7QsgdfMzDYXtd6/0pNDP+bXUFL0=;
        b=C5Xkw0mp66HQs9WGOGciYt5DLCurXX0WWupudD2P/vb+8sY02y4gIYD5PBoiK+tSqA
         XGOMqcfbXjaWojrLVrL4FDsB3R/jo+DZBpD8QRVOBw5rYkqHLWu9U45oJuAhjwdmvYuE
         y0zeSr2mB9BGEdpFC5qEqIoTe5DPKdcxl5I1voCLar0mADoRaQzja+/9yLmYDh++fclH
         MeEqnwrmm6jQdvyhk6n3j1Uwc7PhmeDjrO1Pjg3WkSKrx9JpyclEVxTXPh1iObdCcs7c
         DS7wMIjYEL9OITW15Yg7TSlZdg8pWulGmt4vLxzomkvpjjyrwb0eHTccXlWR65gL0MUv
         pIcA==
X-Gm-Message-State: ACgBeo0C4pSsCS3tktGFYykrO14G3JZB7356iadzEKvbcVEbD0mE0+6r
        agj/WtCLy3ZhZyxyp2V8Jc6FqIgseJ5fd6AImmOx
X-Google-Smtp-Source: AA6agR7k//bqv1RaCR4etWugLTK8eSl7/U9by+A0YLPK6GBwFTC/Luh5uDHGjqJVOoDgmY2y6IrjX0JtPhXr4FRQHZA=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr993168oao.41.1659491357702; Tue, 02 Aug
 2022 18:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220721172808.585539-1-fred@cloudflare.com> <20220722061137.jahbjeucrljn2y45@kafai-mbp.dhcp.thefacebook.com>
 <18225d94bf0.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <a4db1154-94bc-9833-1665-a88a5eee48de@cloudflare.com> <CAHC9VhQw8LR9yJ9UkA-9aPNETQavt25G-GGSs-_ztg6ZpxNzxA@mail.gmail.com>
 <CACYkzJ7=Cvo9qncMX_5_Wp1zNNWDyh3DxdOLq_ysWxDCs8VC8g@mail.gmail.com>
In-Reply-To: <CACYkzJ7=Cvo9qncMX_5_Wp1zNNWDyh3DxdOLq_ysWxDCs8VC8g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Aug 2022 21:49:06 -0400
Message-ID: <CAHC9VhRMcouRoGn1SbhcMXpeOzS-S+z-fkK-t4-uvib0MACLow@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introduce security_create_user_ns()
To:     KP Singh <kpsingh@kernel.org>,
        Frederick Lawler <fred@cloudflare.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, revest@chromium.org,
        jackmanb@chromium.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 2, 2022 at 5:25 PM KP Singh <kpsingh@kernel.org> wrote:
> On Mon, Aug 1, 2022 at 5:19 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Aug 1, 2022 at 9:13 AM Frederick Lawler <fred@cloudflare.com> wrote:
> > > On 7/22/22 7:20 AM, Paul Moore wrote:
> > > > On July 22, 2022 2:12:03 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > >> On Thu, Jul 21, 2022 at 12:28:04PM -0500, Frederick Lawler wrote:
> > > >>> While creating a LSM BPF MAC policy to block user namespace creation, we
> > > >>> used the LSM cred_prepare hook because that is the closest hook to prevent
> > > >>> a call to create_user_ns().
> > > >>>
> > > >>> The calls look something like this:
> > > >>>
> > > >>> cred = prepare_creds()
> > > >>> security_prepare_creds()
> > > >>> call_int_hook(cred_prepare, ...
> > > >>> if (cred)
> > > >>> create_user_ns(cred)
> > > >>>
> > > >>> We noticed that error codes were not propagated from this hook and
> > > >>> introduced a patch [1] to propagate those errors.
> > > >>>
> > > >>> The discussion notes that security_prepare_creds()
> > > >>> is not appropriate for MAC policies, and instead the hook is
> > > >>> meant for LSM authors to prepare credentials for mutation. [2]
> > > >>>
> > > >>> Ultimately, we concluded that a better course of action is to introduce
> > > >>> a new security hook for LSM authors. [3]
> > > >>>
> > > >>> This patch set first introduces a new security_create_user_ns() function
> > > >>> and userns_create LSM hook, then marks the hook as sleepable in BPF.
> > > >> Patch 1 and 4 still need review from the lsm/security side.
> > > >
> > > > This patchset is in my review queue and assuming everything checks out, I expect to merge it after the upcoming merge window closes.
> > > >
> > > > I would also need an ACK from the BPF LSM folks, but they're CC'd on this patchset.
> > >
> > > Based on last weeks comments, should I go ahead and put up v4 for
> > > 5.20-rc1 when that drops, or do I need to wait for more feedback?
> >
> > In general it rarely hurts to make another revision, and I think
> > you've gotten some decent feedback on this draft, especially around
> > the BPF LSM tests; I think rebasing on Linus tree after the upcoming
> > io_uring changes are merged would be a good idea.

As I was typing up my reply I realized I mistakenly mentioned the
io_uring changes that Linus just merged today - oops!  If you haven't
figured it out already, you can disregard that comment, that's a
completely different problem and a completely different set of patches
:)

> > Although as a
> > reminder to the BPF LSM folks - I'm looking at you KP Singh :) - I
> > need an ACK from you guys before I merge the BPF related patches
>
> Apologies, I was on vacation. I am looking at the patches now.
> Reviews and acks coming soon :)

No worries, we've still got the two weeks of the merge window before I
can do anything into linux-next - thanks KP!

-- 
paul-moore.com
