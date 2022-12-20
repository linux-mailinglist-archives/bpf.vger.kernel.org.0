Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E8B6526C8
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 20:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiLTTIT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 14:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiLTTIR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 14:08:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A01FD0E
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 11:08:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2FF961570
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 19:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A8C433EF;
        Tue, 20 Dec 2022 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671563296;
        bh=S9IbuXpKKc0ntRt4viCIXkeWet3lWOWvVWrl2COH8Tg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=lEgIHceCDqILioLItjXs3TQJPZWetuV0ZPFkELqKlFPCrNH2W3aHX+sVsZtyVQd1F
         VUZBu9Vu6ujbJa+lxxrKPiP8nvm9hzhx7pyae2SNCnqYTZZG8vRsIFSAkAyUfiAcqp
         F2gDXpzk1PewCEmzhQREysxhGVWRfKKidCU7svaVKSqo5VbmVVF4UiPiBbNogROYfV
         IzW51EcaakiYyWygKvtJ3oWs/7ruUK9twmTkGomiAZ7gZbL4DXmf0SFsniBhoxh5M1
         LCvLBS1eNoKvX/0mtySVSUPnPCuWyOebsQuz6p41/3YZlrkbAS/eBGbaTvT+JXRUTp
         Rm6XPTXI4LN1Q==
Date:   Tue, 20 Dec 2022 11:08:11 -0800
From:   Kees Cook <kees@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>, Hyunwoo Kim <v4bel@theori.io>
CC:     keescook@chromium.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        syzbot+b1e1f7feb407b56d0355@syzkaller.appspotmail.com,
        bpf@vger.kernel.org
Subject: Re: [report] OOB in bpf_load_prog() flow
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKH8qBuerUeU7M2x5cfjJUuSjNTZj84Hd5s+rLZ+h-XHG_a4GA@mail.gmail.com>
References: <20221219135939.GA296131@ubuntu> <Y6C1SFEj9MOOnAnb@google.com> <20221220113718.GA1109523@ubuntu> <CAKH8qBuerUeU7M2x5cfjJUuSjNTZj84Hd5s+rLZ+h-XHG_a4GA@mail.gmail.com>
Message-ID: <AA40C8DF-45F6-4BFB-8A2D-F4714B754479@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On December 20, 2022 9:32:51 AM PST, Stanislav Fomichev <sdf@google=2Ecom> =
wrote:
>On Tue, Dec 20, 2022 at 3:37 AM Hyunwoo Kim <v4bel@theori=2Eio> wrote:
>>
>> On Mon, Dec 19, 2022 at 11:02:32AM -0800, sdf@google=2Ecom wrote:
>> > On 12/19, Hyunwoo Kim wrote:
>> > > Dear,
>> >
>> > > This slab-out-of-bounds occurs in the bpf_prog_load() flow:
>> > > https://syzkaller=2Eappspot=2Ecom/text?tag=3DCrashLog&x=3D172e25104=
80000
>> >
>> > > I was able to trigger KASAN using this syz reproduce code:
[=2E=2E=2E]
>> >
>> > > IMHO, the root cause of this seems to be commit
>> > > ceb35b666d42c2e91b1f94aeca95bb5eb0943268=2E
>> >
>> > > Also, a user with permission to load a BPF program can use this OOB=
 to
>> > > execute the desired code with kernel privileges=2E
>> >
>> > Let's CC Kees if you suspect the commit above=2E Maybe we can run
>> > with/without it to confirm?
>>
>> I built and tested each commit of 'kernel/bpf/verifier=2Ec' that caused
>> OOB, but I couldn't find the commit that caused OOB=2E
>>
>> So, starting from upstream, I reversed commits one by one and
>> found the commit that triggers KASAN=2E
>>
>> As a result of testing, OOB is triggered from commit
>> 8fa590bf344816c925810331eea8387627bbeb40=2E
>>
>> However, this commit seems to be a kvm related patch,
>> not directly related to the bpf subsystem=2E
>>
>> IMHO, the cause of this seems to be one of these:
>> 1=2E I ran this KASAN test on a nested guest in L2=2E That is,
>> there is a problem with the kvm patch 8fa590bf34481=2E
>>
>> 2=2E Previously, the BPF subsystem had a patch that triggers KASAN,
>> and KASAN is induced when kvm is patched=2E
>>
>> 3=2E There was confusion in the =2Econfig I tested, so the wrong
>> patch was derived as a test result=2E
>>
>> I haven't been able to pinpoint what the root cause is yet=2E
>> So I didn't add a CC for 8fa590bf34481 commit=2E
>
>Thanks for the details! Even if this particular one is unrelated,
>there are a couple of reports which still somewhat look like they are
>related to commit ceb35b666d42 ("bpf/verifier: Use
>kmalloc_size_roundup() to match ksize() usage") ?
>
>https://lore=2Ekernel=2Eorg/bpf/000000000000ab724705ee87e321@google=2Ecom=
/
>https://lore=2Ekernel=2Eorg/bpf/000000000000269f9a05f02be9d8@google=2Ecom=
/

I suspect something is hitting array_resize() that wasn't maximal-bucket-s=
ize allocated=2E Does reverting 38931d8989b5760b0bd17c9ec99e81986258e4cb ma=
ke it go away?


--=20
Kees Cook
