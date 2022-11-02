Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214866156CA
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 01:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKBAxF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 20:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKBAxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 20:53:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2F71C103;
        Tue,  1 Nov 2022 17:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60BE4CE1EFC;
        Wed,  2 Nov 2022 00:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3489AC433D6;
        Wed,  2 Nov 2022 00:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667350380;
        bh=zU98Qd6nUGmbsVpz/zaMgp0xzDyYsHdeE2cMqaZDK34=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ZD0XIW5X8bQ6GyxVaAkhMLCWAlzm9VPmO9F5d8uUJpE9qniKStI1ZrS29WoVjQbpB
         5GeUbvC2XxFg5wVqqXuOnTx9fUIrnG/YN6LEWIp6v5VADmsmsO8IRMw4LBYxlLEYzj
         /LStFFZ1y8MApwlitOfYWxqWmfWz+OmglIGAOEuMrCMCIv7B3OJaieOjd8C0yxOL/l
         BDXaLuHWTOlj5aYuqa/2zY5l14+5Pg5CO61eq9q9HgQC/UjEPxyR7y70csFJ+slmPy
         0mMRf484UAAkDBxY0meN6Dp7wdo2WfMjxO5031RS6JCkPVhdDPg5n53RmTuYYQ2JV6
         aDuUf08k/3k1g==
Date:   Tue, 01 Nov 2022 17:52:58 -0700
From:   Kees Cook <kees@kernel.org>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>
CC:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, casey@schaufler-ca.com
Subject: Re: [PATCH v2] LSM: Better reporting of actual LSMs at boot
User-Agent: K-9 Mail for Android
In-Reply-To: <a737ec91-0eba-94dc-46dc-683abdc96366@schaufler-ca.com>
References: <20221102000525.gonna.409-kees@kernel.org> <a737ec91-0eba-94dc-46dc-683abdc96366@schaufler-ca.com>
Message-ID: <970317F3-D1A2-412D-88EF-18A606AC1E6A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On November 1, 2022 5:46:55 PM PDT, Casey Schaufler <casey@schaufler-ca=2Ec=
om> wrote:
>On 11/1/2022 5:05 PM, Kees Cook wrote:
>> Enhance the details reported by "lsm=2Edebug" in several ways:
> [=2E=2E=2E]
>
>Acked-by: Casey Schaufler <casey@schaufler-ca=2Ecom>

Thanks!

>I'm curious about what is driving this change=2E

I was working on the ima stacking PoC and found the lsm=2Edebug output con=
fusing to read, and I wrote it=2E :P So, I wanted to clarify things and mak=
e sure stuff like lockdown was visible=2E Additionally, if we're going to k=
eep the "lsm=3D" param as-is, I wanted it's value visible at boot so people=
 would know what to start from when making changes=2E

-Kees


--=20
Kees Cook
