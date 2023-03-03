Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714B56A8DB8
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 01:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCCAGp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 19:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCAGo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 19:06:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB3D55060;
        Thu,  2 Mar 2023 16:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45EA6B815E2;
        Fri,  3 Mar 2023 00:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1108C433D2;
        Fri,  3 Mar 2023 00:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677802001;
        bh=luoh8JtU3TdK2wxLXMiLv2scl3LcFiMaExI0RINvQ4M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RKFC4U/Tj394kdr5VsbeHxVPh2F1tkpv8mrHr21p4XHY+ekpSwXrNmKTKdA9dk9xb
         PUucwtQ/gOBbN5ml58rVkswEuBShBRgw7vQ+6QiI2l+pIf+aQN4aJ1DbcWZdNJWJ0h
         yCxbiI3GTS88FUlIp2ZxCYPrHq3KLOtn+Y2sc7ggyRNA6gtBL9RR6slGGj/uIPgBQ+
         FjR3KJcT985i94CoDvIKuFsuZ5EFKvQqvVt3P8cGgsmhdRo7npy+2xLu4dk18OSs7A
         J0mAhVV+UlXS17B+pdtfbGc0l8uS9ie7YBCgE+KYOGvF31H83Vd9XG9zBuTjWpcdwT
         D0cIg/LskcTew==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8BF009762BD; Fri,  3 Mar 2023 01:06:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC v2 bpf-next 3/3] bpf: minimal support for programs
 hooked into netfilter framework
In-Reply-To: <20230302235300.GB9239@breakpoint.cc>
References: <20230302172757.9548-1-fw@strlen.de>
 <20230302172757.9548-4-fw@strlen.de> <87sfemexgf.fsf@toke.dk>
 <20230302235300.GB9239@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 03 Mar 2023 01:06:36 +0100
Message-ID: <87ilfiem0j.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org> wrote:
>> Florian Westphal <fw@strlen.de> writes:
>> > +	case BPF_PROG_TYPE_NETFILTER:
>> > +		return BTF_KFUNC_HOOK_SOCKET_FILTER;
>>=20
>> The dynptr patch reuses the actual set between the different IDs, so
>> this should probably define a new BTF_KFUNC_HOOK_NETFILTER, with an
>> associated register_btf_kfunc_id_set() call?
>
> Good point, the above was a kludge that I forgot about.
>
> I will wait for dynptr patchset to land and will add new
> BTF_KFUNC_HOOK_NETFILTER for next revision.

Sounds good! The dynptr series did land:
https://lore.kernel.org/r/167769421944.16358.12443693977215512909.git-patch=
work-notify@kernel.org

-Toke
