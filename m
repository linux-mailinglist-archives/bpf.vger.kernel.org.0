Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F10644C79
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiLFT1H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 14:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiLFT1G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 14:27:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412E829C81
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 11:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11CF618A9
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 19:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1010EC433C1;
        Tue,  6 Dec 2022 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670354825;
        bh=EGvHtY5F3ePiOcjFRoVVlVnrhO3OAMZMoVb8hl2Ic1Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZjB50tkAxS9fvOhh+kM3dp6jZBqQpdET6DHwoBtB6Up6iLlv0g/MzipJl20H3fy4a
         c3UYOMQlsRzvMbUVCCJbBWc/7nZHU7EE44GmQpMS3Y78D7XFB+1nqxUfmuJaYJ9MKz
         FZYw89mzyC7HGcH7Alv1qq3VdfRAr4V52jPbkLtWySKDq59064WMUANWda8WfQqMTm
         Y9VTvMHOLxPzzPfEHBxyngQ421HlRZMAJFVbaJSonJgxwupFaM7B6BEATQrojlVOVN
         jFzxlD31h3qp8MGzgrQTpOPfmiVXMKErnmuUnWKs5+dV7LStSV7GAHluGs0/pPUoj2
         Ajvqjry4LpPeg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B638282E3F8; Tue,  6 Dec 2022 20:27:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Bring test_offload.py back to life
In-Reply-To: <CAKH8qBsz-pP82vLt2g0JzL3+ErnTN8wDxYNwyFHby3nRiXtzWQ@mail.gmail.com>
References: <20221206011052.3099563-1-sdf@google.com>
 <87o7sgu4zr.fsf@toke.dk>
 <CAKH8qBsz-pP82vLt2g0JzL3+ErnTN8wDxYNwyFHby3nRiXtzWQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 06 Dec 2022 20:27:01 +0100
Message-ID: <871qpctjsq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Tue, Dec 6, 2022 at 3:49 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@ker=
nel.org> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > Commit ccc3f56918f6 ("selftests/bpf: convert remaining legacy map
>> > definitions") converted sample_map_ret0.c to modern BTF map format.
>> > However, it doesn't looks like iproute2 part that attaches XDP
>> > supports this format.
>>
>> It does if it's linked against libbpf; what distro are you on that
>> doesn't do that?
>
> Ah, I've been using my own statically compiled version that doesn't
> use libbpf; recompiling with -libbpf_force fixes this part.
> I'll resend with only base_map_names changes (+ skipping builtin), thanks!

Cool! You're welcome :)

-Toke
