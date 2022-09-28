Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789AC5EDA20
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiI1Kdz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiI1Kdz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 06:33:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CD081B16;
        Wed, 28 Sep 2022 03:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CE81B82024;
        Wed, 28 Sep 2022 10:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030D1C433D6;
        Wed, 28 Sep 2022 10:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664361231;
        bh=o3DJqkHCY3GJJxzrWVszTlyAG3oG/IJLYa4ub+/pt/I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DHcRAUwfRqjwYCbr7KQE9qu50YUQzBiAPZQYGZtaRJtulLeVKGRL791FXoi6CX/tj
         zDf+5J8LJVA58BZIsiu9HODTAgeViQTnO5/VITOsFwHV4udrDjpIldWUbrVVsj4qwM
         FXKvsupwGbplxQeVb2Qdxi8YTWQijQVnForcrBI+d3iGbGXEWM5i+U7fNGifYDCmFW
         FVesGGrQj97c1uHrMFpFfdndP5Mn/2Fw/eDRT+IyB3GWjnkuM2Ue2ljssgDxLGAKq+
         LnYClmhVoxGgUOrmbAqkcJDIoEhb9zXI/MIOhM2IUbacXU0uS2Wu3vMFB3tWgt+8pV
         Uz1eNTih/V+uA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2768061D1B6; Wed, 28 Sep 2022 12:33:48 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: Closing the BPF map permission loophole
In-Reply-To: <6e142c3526df693abfab6e1293a27828267cc45e.camel@huaweicloud.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
 <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
 <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
 <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
 <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
 <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com>
 <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
 <439dd1e5-71b8-49ed-8268-02b3428a55a4@www.fastmail.com>
 <6e142c3526df693abfab6e1293a27828267cc45e.camel@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 28 Sep 2022 12:33:48 +0200
Message-ID: <87mtajss8j.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Roberto Sassu <roberto.sassu@huaweicloud.com> writes:

> On Wed, 2022-09-28 at 09:52 +0100, Lorenz Bauer wrote:
>> On Mon, 26 Sep 2022, at 17:18, Roberto Sassu wrote:
>> > Uhm, if I get what you mean, you would like to add DAC controls to
>> > the
>> > pinned map to decide if you can get a fd and with which modes.
>> > 
>> > The problem I see is that a map exists regardless of the pinned
>> > path
>> > (just by ID).
>> 
>> Can you spell this out for me? I imagine you're talking about
>> MAP_GET_FD_BY_ID, but that is CAP_SYS_ADMIN only, right? Not great
>> maybe, but no gaping hole IMO.
>
> +linux-security-module ML (they could be interested in this topic as
> well)
>
> Good to know! I didn't realize it before.
>
> I figured out better what you mean by escalating privileges.
>
> Pin a read-only fd, get a read-write fd from the pinned path.
>
> What you want to do is, if I pin a read-only fd, I should get read-only 
> fds too, right?
>
> I think here there could be different views. From my perspective,
> pinning is just creating a new link to an existing object. Accessing
> the link does not imply being able to access the object itself (the
> same happens for files).
>
> I understand what you want to achieve. If I have to choose a solution,
> that would be doing something similar to files, i.e. add owner and mode
> information to the bpf_map structure (m_uid, m_gid, m_mode). We could
> add the MAP_CHMOD and MAP_CHOWN operations to the bpf() system call to
> modify the new fields.
>
> When you pin the map, the inode will get the owner and mode from
> bpf_map. bpf_obj_get() will then do DAC-style verification similar to
> MAC-style verification (with security_bpf_map()).

As someone pointed out during the discussing at LPC, this will
effectively allow a user to create files owned by someone else, which is
probably not a good idea either from a security PoV. (I.e., user A pins
map owned by user B, so A creates a file owned by B).

-Toke
